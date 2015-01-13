From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Jan 2015 16:27:54 +0000
Subject: CFT: move outer_cache_sync() out of line
In-Reply-To: <20150113154551.GF16524@e104818-lin.cambridge.arm.com>
References: <20150112163648.GL12302@n2100.arm.linux.org.uk>
 <20150113154551.GF16524@e104818-lin.cambridge.arm.com>
Message-ID: <20150113162753.GS12302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 03:45:52PM +0000, Catalin Marinas wrote:
> On Mon, Jan 12, 2015 at 04:36:48PM +0000, Russell King - ARM Linux wrote:
> > The theory is that moving outer_cache_sync() out of line moves the
> > conditional test from multiple sites to a single location, which
> > in turn means that the branch predictor stands a better chance of
> > making the correct decision.
> [...]
> > --- a/arch/arm/mm/l2c-common.c
> > +++ b/arch/arm/mm/l2c-common.c
> > @@ -7,9 +7,17 @@
> >   * published by the Free Software Foundation.
> >   */
> >  #include <linux/bug.h>
> > +#include <linux/export.h>
> >  #include <linux/smp.h>
> >  #include <asm/outercache.h>
> >  
> > +void outer_sync(void)
> > +{
> > +	if (outer_cache.sync)
> > +		outer_cache.sync();
> > +}
> 
> But don't you end up with two branches now? With an outer cache, I guess
> the additional branch won't be noticed, especially if the prediction on
> the outer_cache.sync() call is better (but that's not a simple
> conditional branch prediction, it relies on predicting the value of the
> pointer, not entirely sure how this works).

Yes, we end up with two branches.  The branch to this function is 
unconditional and always taken - if a branch predictor gets that wrong,
then the branch predictor is broken!

However, that is not the only side effect of this change: the other
change is a reduction in instruction cache usage.

> However, on SoCs without an outer cache (and single kernel image), we
> end up with a permanent branch/return even though such branch would not
> be needed.

Right, so we go from something like this:

 188:   e594301c        ldr     r3, [r4, #28]
 18c:   e3002356        movw    r2, #854        ; 0x356
 190:   e3402100        movt    r2, #256        ; 0x100
 194:   e583204c        str     r2, [r3, #76]   ; 0x4c
 198:   f57ff04e        dsb     st
 19c:   e5953014        ldr     r3, [r5, #20]
 1a0:   e3530000        cmp     r3, #0
 1a4:   0a000000        beq     1ac <ipu_dp_csc_init+0x1ac>
 1a8:   e12fff33        blx     r3

down to:

 1e0:   e594301c        ldr     r3, [r4, #28]
 1e4:   e3002356        movw    r2, #854        ; 0x356
 1e8:   e3402100        movt    r2, #256        ; 0x100
 1ec:   e583204c        str     r2, [r3, #76]   ; 0x4c
 1f0:   f57ff04e        dsb     st
 1f4:   ebfffffe        bl      0 <outer_sync>

which saves 12 bytes per writel() - in favour of having the contents
of outer_cache_sync() being in one location in the kernel, and will
therefore be hotter in the instruction cache.

(Addresses different because the optimiser arranges the functions
differently.)

I'm willing to bet that the excessive use of "inline" in the kernel is
actually harming things: it made sense when taking a branch was expensive
(such as with older ARM CPUs) but this isn't the case anymore.

Now, if we wish to discuss this theoretically, we can do, but it's all
pie in the sky.  What really matters is the performance measurements,
which is what I'm asking people to measure.

So far, the results are either not measurable (due to a huge variance in
measurements), or a small increase in performance.  A small increase in
performance coupled with a small decrease in code size wins over
theoretical arguments. :)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
