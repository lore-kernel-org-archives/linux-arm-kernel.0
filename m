From: s.munaut@whatever-company.com (Sylvain Munaut)
Date: Mon, 29 Jun 2015 08:07:52 +0200
Subject: dma_sync_single_for_cpu takes a really long time
In-Reply-To: <20150628223039.GV7557@n2100.arm.linux.org.uk>
References: <CAF6-1L6sjGc1VySi=oQGzOEm-e5jauznh+jzmdDgmJQWLbA_pA@mail.gmail.com>
 <20150628223039.GV7557@n2100.arm.linux.org.uk>
Message-ID: <CAF6-1L6Xhsk3CwTvu6rAvYGYX3XvcwbmP582tVPEuiVaDnFpRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


Thanks for the quick and detailed answer.


> Flushing a large chunk of memory one cache line at a time takes a long
> time, there's really nothing "new" about that.

So when invalidating cache, you have to do it for every possible cache line
address ? There is not an instruction to invalidate a whole range ?


Also, I noticed that dma_sync_single_for_device takes a while too even
though I would have expected it to be a no-op for the FROM_DEVICE case.

I can guarantee that I never wrote to this memory zone, so there is nothing
in any write-back buffer, is there anyway to convey this guarantee to the
API ? Or should I just not call dma_sync_single_for_device at all ?



> It's the expense that has to be paid for using cacheable mappings on a
> CPU which is not DMA coherent - something which I've brought up over
> the years with ARM, but it's not something that ARM believe is wanted
> by their silicon partners.
>
> What we _could_ do is decide that if the buffer is larger than some
> factor of the cache size, to just flush the entire cache.  However, that
> penalises the case where none of the data is in the cache - and in all
> probably  very little of the frame is actually sitting in the cache at
> that moment.

If I wanted to give that a shot, how would I do that in my module ?

As a start, I tried calling outer_inv_all() instead of outer_inv_range(),
but it turned out to be a really bad idea (just freezes the system)


> However, if you're going to read the entire frame through a cacheable
> mapping, you're probably going to end up flushing your cache several
> times over through doing that

Isn't there some intermediary between coherent and cacheable, a bit like
write combine for read ?

After all, I don't really care if data ends up in cache, I'd even probably
prefer it didn't. But when reading a word I'd want it to be fetched by block
with prefetching and all that stuff.

The Zynq TRM mention something about having independent control on inner
and outer cacheability for instance. If only one was enabled, then at least
the other wouldn't have to be invalidated ?


Cheers,

    Sylvain
