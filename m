From: s.munaut@whatever-company.com (Sylvain Munaut)
Date: Mon, 29 Jun 2015 15:06:23 +0200
Subject: dma_sync_single_for_cpu takes a really long time
In-Reply-To: <5590E6B1.90206@topic.nl>
References: <CAF6-1L6sjGc1VySi=oQGzOEm-e5jauznh+jzmdDgmJQWLbA_pA@mail.gmail.com>
 <5590E6B1.90206@topic.nl>
Message-ID: <CAF6-1L7CY7HYr8RPeisW5rVGzftOcX8mRUev-Mqp1-EVB03pCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

@ Mike & @ Arnd :

Thanks for your suggestions.


> I have the same experience: The cache flush is so slow, that it is about as
> fast to just memcpy() the whole region.

So far it even looks like invalidating L1 takes 8 ms and L2 4 ms.
Which is pretty weird since the L1 inval is a pretty tight loop, and
invalidating something smaller and closer to the CPU takes more time ?
:

1:
        mcr     p15, 0, r0, c7, c6, 1           @ invalidate D / U line
        add     r0, r0, r2
        cmp     r0, r1
        blo     1b


Unless somehow I end up having high mem page in there and the
dma_cache_maint_page loops has more work than I think.


> You're on a Zynq, and that has an ACP port. Connect through that instead of
> an HP port (interface is almost the same), add "dma-coherent" to the
> devicetree and also add my patch that properly maps this into userspace.
>
> The penalty of the ACP port is that it will write a lot slower to the memory
> (about half the speed of the 600MB/s you get from the HP port) because of
> all the cache administration. The good news is that all memory will be
> cacheable once more, and all the dma_sync_... calls will turn into no-ops.
> You don't have to change your driver and the logic also remains the same.

That's a pretty big downside. 600 M/s write speed is already pretty
low (I mean, DDR raw bw should be close to 4G/s, sure it's DDR so you
can never reach that but still for large purely sequential access I
expected to get closer than that).

Also, doesn't that impact the ARM access performance too much to have to share ?

I guess the best flags to use for this are coherent write request
without L2 allocation.


> Another approach is to make your software uncached-memory friendly. If you
> process the frames sequentially and use NEON instructions to fetch large
> aligned chunks for further processing, the absense of caching won't matter
> much.

Yes, that was the next thing I was going to try.

Does using pre-load make anysense for uncached ? I guess not.


Cheers,

   Sylvain
