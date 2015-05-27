From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Thu, 28 May 2015 01:08:43 +0900
Subject: [RFC PATCH 2/2] arm64: Implement vmalloc based thread_info
 allocator
In-Reply-To: <20150527041015.GB11609@blaptop>
References: <1432483340-23157-1-git-send-email-jungseoklee85@gmail.com>
 <20150525144045.GE14922@blaptop>
 <D5CD4D44-77BC-4817-B9A7-60C0F4AE444F@gmail.com>
 <20150527041015.GB11609@blaptop>
Message-ID: <D1AD69AA-8420-4BDD-9BFE-96E52B6AFA2B@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On May 27, 2015, at 1:10 PM, Minchan Kim wrote:
> Hello Jungseok,

Hi, Minchan,

> On Tue, May 26, 2015 at 08:29:59PM +0900, Jungseok Lee wrote:
>> On May 25, 2015, at 11:40 PM, Minchan Kim wrote:
>>> Hello Jungseok,
>> 
>> Hi, Minchan,
>> 
>>> On Mon, May 25, 2015 at 01:02:20AM +0900, Jungseok Lee wrote:
>>>> Fork-routine sometimes fails to get a physically contiguous region for
>>>> thread_info on 4KB page system although free memory is enough. That is,
>>>> a physically contiguous region, which is currently 16KB, is not available
>>>> since system memory is fragmented.
>>> 
>>> Order less than PAGE_ALLOC_COSTLY_ORDER should not fail in current
>>> mm implementation. If you saw the order-2,3 high-order allocation fail
>>> maybe your application received SIGKILL by someone. LMK?
>> 
>> Exactly right. The allocation is failed via the following path.
>> 
>> if (test_thread_flag(TIF_MEMDIE) && !(gfp_mask & __GFP_NOFAIL))
>> 	goto nopage;
>> 
>> IMHO, a reclaim operation would be not needed in this context if memory is
>> allocated from vmalloc space. It means there is no need to traverse shrinker list. 
> 
> For making fork successful with using vmalloc, it's bandaid.

Thanks for clarification!

Best Regards
Jungseok Lee
