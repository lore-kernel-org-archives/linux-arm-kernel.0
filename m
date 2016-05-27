From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 May 2016 15:58:11 +0100
Subject: v7_dma_inv_range performance/high expense
In-Reply-To: <20160527144045.GB20214@lunn.ch>
References: <20160527144045.GB20214@lunn.ch>
Message-ID: <20160527145810.GN19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2016 at 04:40:45PM +0200, Andrew Lunn wrote:
>   0.26       mrc    15, 0, r3, cr0, cr0, {1}
>   0.07       lsr    r3, r3, #16
>              and    r3, r3, #15
>   0.04       mov    r2, #4
>              lsl    r2, r2, r3
>   0.04       sub    r3, r2, #1
>              tst    r0, r3
>   0.02       bic    r0, r0, r3
>   0.03       dsb    sy
>   3.01       mcrne  15, 0, r0, cr7, cr14, {1}
>   0.54       tst    r1, r3
>              bic    r1, r1, r3
>   0.08       mcrne  15, 0, r1, cr7, cr14, {1}
>   3.82 34:   mcr    15, 0, r0, cr7, cr6, {1}
>  88.32       add    r0, r0, r2
>              cmp    r0, r1
>   1.97       bcc    34
>   0.43       dsb    st
>   1.37       bx     lr
> 
> I'm assuming perf is off by one here, and the add is not taking 88.32%
> of the load, rather it is the mcr instruction before it.

Possibly, but I'm not sure that merely subtracting four from the PC (or
two for thumb) would be the correct solution - what if we've branched
to a function and we've taken the exception with the PC pointing at the
very first instruction - we'd wind it back by one place, and it will be
pointing at the instruction before the function (not the previously
executed instruction.)

So, I think folk just have to get used to reading ARM perf traces
differently[*] - the PC points at the _next_ instruction to be executed
after the exception which recorded the event returns.

* - maybe it is the same as x86, I've never looked at an x86 perf trace,
but I don't see that it would be any different.

> The original code in arch/arm/mm/cache-v7.S  says:
> 
>         mcr     p15, 0, r0, c7, c6, 1           @ invalidate D / U line
> 
> I don't get why a cache invalidate instruction should be so expensive.
> It is just throwing away the contents of the cache line, not flushing
> it out to DRAM. Should i trust perf? Is a cache invalidate really so
> expensive? Or am i totally missing something here?

If we're being asked to do a large region, then flushing the cache one
line at a time _is_ expensive.  There's no real getting away from that.
The only thing that saves you from having to do that is having DMA
coherency with the cache, something which I've pointed out in some
meetings I've had with ARM over the years.

The response was along the lines that you'd expect... It's only
relatively recently, with SMP (which needs coherency) that ARM systems
have had a coherent bus, and even systems which have it, there's
relatively few SoCs which make use of it.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
