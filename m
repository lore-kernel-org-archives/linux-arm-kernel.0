From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 6 May 2015 16:33:38 +0100
Subject: [PATCH 5/6] ARM: re-implement physical address space switching
In-Reply-To: <20150506113313.GS2067@n2100.arm.linux.org.uk>
References: <E1YfmY6-0006X3-1N@rmk-PC.arm.linux.org.uk>
 <20150408173656.GF5977@leverpostej>
 <20150408175533.GN12732@n2100.arm.linux.org.uk>
 <552C14F0.7020006@oracle.com> <20150415120738.GD2866@leverpostej>
 <552E9F9B.2040400@oracle.com> <20150423112449.GB17361@leverpostej>
 <20150506101850.GE2067@n2100.arm.linux.org.uk>
 <20150506103736.GA707@leverpostej>
 <20150506113313.GS2067@n2100.arm.linux.org.uk>
Message-ID: <20150506153337.GA2974@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 12:33:13PM +0100, Russell King - ARM Linux wrote:
> On Wed, May 06, 2015 at 11:37:37AM +0100, Mark Rutland wrote:
> > Hi Russell,
> > 
> > > > It turns out that I was incorrect in my assertion, and the reordering I
> > > > suggested above can't happen. The ARMv7 ARM states:
> > > > 
> > > > 	Any direct write to a system control register is guaranteed not
> > > > 	to affect any instruction that appears, in program
> > > > 	order, before the instruction that performed the direct write
> > > > 
> > > > Which means that the STMFD cannot be affected by the later cp15 write to
> > > > the SCTLR, and so the DSB does not need to be moved before the MCR.
> > > > 
> > > > I apologise for adding to the confusion there.
> > > 
> > > So does this mean this patch gets an ack now?
> > 
> > I assumed there was going to be a respin for the CR_W change?
> > 
> > There's also the dodginess w.r.t. the page table walkers that I can't
> > see is solvable short of disabling the MMU prior to the flush, though I
> > understand you've NAKed that approach.
> 
> Why? 

I was on about the pre-assembly portion:

	cr = get_cr();
	set_cr(cr & ~(CR_I | CR_C | CR_W));
	flush_cache_all();

With the MMU on at this point the page table walkers can race with the
set/way maintenance. It also relies on the compiler not making stack
accesses between the SCTLR write and the completion of flush_cache_all,
which is likely but not guranteed.

So this won't necessarily flush out the data it seems to be intended to.

> Are you saying that after:
> 
> +       mrc     p15, 0, r8, c1, c0, 0           @ read control reg
> +       bic     ip, r8, #CR_M                   @ disable caches and MMU
> +       mcr     p15, 0, ip, c1, c0, 0
> +       dsb
> +       isb
> 
> the page table walkers are still actively walking the page table?
> 
> That to me sounds like a hardware bug.  The point of this is to shut
> down the MMU, _then_ update the page tables, and _then_ to re-enable
> the MMU to explicitly avoid problems with the page table walkers.

I agree that after this point it would be a bug for the page table
walkers to make cacheable accesses.

Thanks,
Mark.
