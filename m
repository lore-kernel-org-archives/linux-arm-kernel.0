From: jonathan.austin@arm.com (Jonathan Austin)
Date: Fri, 17 Aug 2012 16:53:44 +0100
Subject: Discontiguous memory and cacheflush
In-Reply-To: <1822556972.575011.1345068509111.JavaMail.root@mozilla.com>
References: <1822556972.575011.1345068509111.JavaMail.root@mozilla.com>
Message-ID: <502E6908.4070408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/08/12 23:08, Martin Rosenberg wrote:

>> It's intention is to support self-modifying userspace code only and
>> also intended to be used over a _short_ range of addresses only -
>> it works by flushing each _individual_ cache line over the range of
>> addreses requested.
> Documenting the current behavior would mostly be acceptable, but it
> is rather confusing (and took quite some time to track down)
> 
>> If it's going to be used for significantly larger areas, then we
>> need to think about imposing a limit, upon which we just flush the
>> entire cache and be done with it.
> 
> I found that there was still a net win making fewer syscalls, even
> with the overhead of flushing extra cache lines. In the cases where
> the range is discontiguous, 


Was this net win on platforms other than ARM? Was it still evident after
working around the truncation/multiple vma issue that occurs?

I'm curious as to whether some (even most?) of your performance
improvement could be coming from the range truncation. Perhaps the
performance is better because you're actually doing less flushing, and
not governed by the syscall overhead?

Consider an extreme version of the case you describe below: lets say
instruction 1/20 was in the first vma and 19/20 are in subsequent vmas.
In the un-coalesced case you are going to flush several pages covering
the addresses of all 20 instructions, but in your coalesced case I think
only one page that contains the first instruction[1] will get
flushed...(which, as you know, means you've got a bug!)

> I usually need to do something silly,
> like flush 20 individual instructions that are scattered throughout
> several hundred MB of memory. I think the fastest method for
> flushing in this case would be to shave a different call, with a
> different api, where userspace can provide an array of addresses that
> need to be flushed, but that sounds like material for a new thread.
> Thanks --Marty

A better understanding of the details of your case would be a good
starting point for a discussion. For example it might be nice to know
how significant the syscall overhead is compared to the time to flush
ranges you're interested in...

Also, as Russell says, there'll be a point at which flushing the whole
cache is better than flushing a load of odd chunks here and there...

Jonny

[1] Had you noticed that our implementation flushes a minimum of 1-page?

(cacheflush.h:257)
#define flush_cache_user_range(start,end) \
        __cpuc_coherent_user_range((start) & PAGE_MASK, PAGE_ALIGN(end))

Does that have a bearing on what you're doing?
