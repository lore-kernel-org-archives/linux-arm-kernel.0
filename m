From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Tue, 26 May 2015 20:29:59 +0900
Subject: [RFC PATCH 2/2] arm64: Implement vmalloc based thread_info
 allocator
In-Reply-To: <20150525144045.GE14922@blaptop>
References: <1432483340-23157-1-git-send-email-jungseoklee85@gmail.com>
 <20150525144045.GE14922@blaptop>
Message-ID: <D5CD4D44-77BC-4817-B9A7-60C0F4AE444F@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On May 25, 2015, at 11:40 PM, Minchan Kim wrote:
> Hello Jungseok,

Hi, Minchan,

> On Mon, May 25, 2015 at 01:02:20AM +0900, Jungseok Lee wrote:
>> Fork-routine sometimes fails to get a physically contiguous region for
>> thread_info on 4KB page system although free memory is enough. That is,
>> a physically contiguous region, which is currently 16KB, is not available
>> since system memory is fragmented.
> 
> Order less than PAGE_ALLOC_COSTLY_ORDER should not fail in current
> mm implementation. If you saw the order-2,3 high-order allocation fail
> maybe your application received SIGKILL by someone. LMK?

Exactly right. The allocation is failed via the following path.

if (test_thread_flag(TIF_MEMDIE) && !(gfp_mask & __GFP_NOFAIL))
	goto nopage;

IMHO, a reclaim operation would be not needed in this context if memory is
allocated from vmalloc space. It means there is no need to traverse shrinker list. 

>> This patch tries to solve the problem as allocating thread_info memory
>> from vmalloc space, not 1:1 mapping one. The downside is one additional
>> page allocation in case of vmalloc. However, vmalloc space is large enough,
> 
> The size you want to allocate is 16KB in here but additional 4K?
> It increases 25% memory footprint, which is huge downside.

I agree with the point, and most people who try to use vmalloc might know the number.
However, an interoperation on the number depends on a point of view.

Vmalloc is large enough and not fully utilized in case of ARM64.
With the considerations, there is a room to do math as follows.

4KB / 240GB = 1.5e-8 (4KB page + 3 level combo)

It would be not a huge downside if fork-routine is not damaged due to fragmentation.

However, this is one of reasons to add "RFC" prefix in the patch set. How is the
additional 4KB interpreted and considered?

Best Regards
Jungseok Lee
