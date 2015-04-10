From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Apr 2015 15:26:55 +0100
Subject: [RFC] mixture of cleanups to cache-v7.S
In-Reply-To: <20150410141105.GA16979@red-moon>
References: <20150402224947.GX24899@n2100.arm.linux.org.uk>
 <20150410132723.GD6854@e104818-lin.cambridge.arm.com>
 <20150410141105.GA16979@red-moon>
Message-ID: <20150410142655.GF12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 03:11:05PM +0100, Lorenzo Pieralisi wrote:
> On Fri, Apr 10, 2015 at 02:27:42PM +0100, Catalin Marinas wrote:
> > As for the v7_flush_dcache_all always having the barriers, I guess
> > no-one is expecting a v7 CPU without caches.
> 
> Well, yes, actually I'd rather remove the barriers if LoC is 0 instead
> of adding them to LoUIS API in case there is nothing to flush, I do not
> think that's a problem in the first place.

Maybe you should read through the patch set before declaring there to
be no problem.

There may be no problem as the code stands right now, and we can bury
our heads in the sand and continue as through there's no problem what
so ever, and we'd be right to, but...

We need to have 643719 enabled for all platforms.  Right now, the code
in cache-v7 surrounding that workaround is pretty crap - enabling the
option places the workaround into the execution path whether it applies
or not.

What this patch series does is rearrange stuff to avoid the workaround
where it's possible to do so, while cleaning up a lot of the crap coding
that was done here in the first place.

In doing this, I spotted that if we _solve_ the above issue by making
both functions behave in the same way, we get more common code paths.

So, while the issue doesn't _cause_ a problem, fixing the disparity
between the two functions is worth it just to be able to have a
flush_levels implementation which behaves the same no matter how it's
called - one which always has a dmb before it, and (possibly) always
the dsb+isb afterwards - or only has the dsb+isb afterwards if it's
done some cache flushing.

Look at the resulting code after applying all the patches, and I'm sure
you'd agree that it's a lot better than the crap which is currently
there.  To save you having to look up the files and apply the patches,
here are the old and new versions:

============= old ====================
ENTRY(v7_flush_dcache_louis)
        dmb                                     @ ensure ordering with previous memory accesses
        mrc     p15, 1, r0, c0, c0, 1           @ read clidr, r0 = clidr
        ALT_SMP(ands    r3, r0, #(7 << 21))     @ extract LoUIS from clidr
        ALT_UP(ands     r3, r0, #(7 << 27))     @ extract LoUU from clidr
#ifdef CONFIG_ARM_ERRATA_643719
        ALT_SMP(mrceq   p15, 0, r2, c0, c0, 0)  @ read main ID register
        ALT_UP(reteq    lr)                     @ LoUU is zero, so nothing to do        ldreq   r1, =0x410fc090                 @ ID of ARM Cortex A9 r0p?
        biceq   r2, r2, #0x0000000f             @ clear minor revision number
        teqeq   r2, r1                          @ test for errata affected core and if so...
        orreqs  r3, #(1 << 21)                  @   fix LoUIS value (and set flags state to 'ne')
#endif
        ALT_SMP(mov     r3, r3, lsr #20)        @ r3 = LoUIS * 2
        ALT_UP(mov      r3, r3, lsr #26)        @ r3 = LoUU * 2
        reteq   lr                              @ return if level == 0
        mov     r10, #0                         @ r10 (starting level) = 0
        b       flush_levels                    @ start flushing cache levels

ENTRY(v7_flush_dcache_all)
        dmb                                     @ ensure ordering with previous memory accesses
        mrc     p15, 1, r0, c0, c0, 1           @ read clidr
        ands    r3, r0, #0x7000000              @ extract loc from clidr
        mov     r3, r3, lsr #23                 @ left align loc bit field
        beq     finished                        @ if loc is 0, then no need to clean
        mov     r10, #0                         @ start clean@cache level 0
flush_levels:
        add     r2, r10, r10, lsr #1            @ work out 3x current cache level
        mov     r1, r0, lsr r2                  @ extract cache type bits from clidr
...
============= new ====================
ENTRY(v7_flush_dcache_louis)
        mrc     p15, 1, r0, c0, c0, 1           @ read clidr, r0 = clidr
ALT_SMP(mov     r3, r0, lsr #20)                @ move LoUIS into position
ALT_UP( mov     r3, r0, lsr #26)                @ move LoUU into position
#ifdef CONFIG_ARM_ERRATA_643719
ALT_SMP(ands    r3, r3, #7 << 1)                @ extract LoU*2 field from clidrALT_UP( b       start_flush_levels)
        bne     start_flush_levels              @ LoU != 0, start flushing
        mrc     p15, 0, r2, c0, c0, 0           @ read main ID register
        movw    r1, #:lower16:(0x410fc090 >> 4) @ ID of ARM Cortex A9 r0p?
        movt    r1, #:upper16:(0x410fc090 >> 4)
        teq     r1, r2, lsr #4                  @ test for errata affected core
and if so...
        moveq   r3, #1 << 1                     @ fix LoUIS value (and set flags state to 'ne')
#endif
        b       start_flush_levels              @ start flushing cache levels

ENTRY(v7_flush_dcache_all)
        mrc     p15, 1, r0, c0, c0, 1           @ read clidr
        mov     r3, r0, lsr #23                 @ move LoC into position
start_flush_levels:
        dmb                                     @ ensure ordering with previous memory accesses
        ands    r3, r3, #7 << 1                 @ extract field from clidr
        beq     finished                        @ if loc is 0, then no need to clean
        mov     r10, #0                         @ start clean at cache level 0
flush_levels:
        add     r2, r10, r10, lsr #1            @ work out 3x current cache level
        mov     r1, r0, lsr r2                  @ extract cache type bits from clidr
...

Which do you think is better, the old version or the new version?

-- 
FTTC broadband for 0.8mile line: currently@10.5Mbps down 400kbps up
according to speedtest.net.
