From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 10 Jan 2013 20:26:21 -0500 (EST)
Subject: [PATCH 01/16] ARM: b.L: secondary kernel entry code
In-Reply-To: <20130110230542.GB11628@mudshark.cambridge.arm.com>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-2-git-send-email-nicolas.pitre@linaro.org>
 <20130110230542.GB11628@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1301102006370.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Jan 2013, Will Deacon wrote:

> On Thu, Jan 10, 2013 at 12:20:36AM +0000, Nicolas Pitre wrote:
> > CPUs in a big.LITTLE systems have special needs when entering the kernel
> > due to a hotplug event, or when resuming from a deep sleep mode.
> > 
> > This is vectorized so multiple CPUs can enter the kernel in parallel
> > without serialization.
> > 
> > Only the basic structure is introduced here.  This will be extended
> > later.
> > 
> > TODO: MPIDR based indexing should eventually be made runtime adjusted.
> 
> Agreed.
> 
> > diff --git a/arch/arm/common/bL_entry.c b/arch/arm/common/bL_entry.c
> > new file mode 100644
> > index 0000000000..80fff49417
> > --- /dev/null
> > +++ b/arch/arm/common/bL_entry.c
> > @@ -0,0 +1,30 @@
> > +/*
> > + * arch/arm/common/bL_entry.c -- big.LITTLE kernel re-entry point
> > + *
> > + * Created by:  Nicolas Pitre, March 2012
> > + * Copyright:   (C) 2012  Linaro Limited
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +
> > +#include <asm/bL_entry.h>
> > +#include <asm/barrier.h>
> > +#include <asm/proc-fns.h>
> > +#include <asm/cacheflush.h>
> > +
> > +extern volatile unsigned long bL_entry_vectors[BL_NR_CLUSTERS][BL_CPUS_PER_CLUSTER];
> 
> Does this actually need to be volatile? I'd have thought a compiler
> barrier in place of the smp_wmb below would be enough (following on from
> Catalin's comments).

Actually, I did the reverse i.e. I removed the smp_wmb() entirely. A 
compiler barrier forces the whole world to memory while here we only 
want this particular assignment to be pushed out.

Furthermore, I like the volatile as it flags that this is a special 
variable which in this case is also accessed from CPUs with no cache.

> > +void bL_set_entry_vector(unsigned cpu, unsigned cluster, void *ptr)
> > +{
> > +	unsigned long val = ptr ? virt_to_phys(ptr) : 0;
> > +	bL_entry_vectors[cluster][cpu] = val;
> > +	smp_wmb();
> > +	__cpuc_flush_dcache_area((void *)&bL_entry_vectors[cluster][cpu], 4);
> > +	outer_clean_range(__pa(&bL_entry_vectors[cluster][cpu]),
> > +			  __pa(&bL_entry_vectors[cluster][cpu + 1]));
> > +}
> > diff --git a/arch/arm/common/bL_head.S b/arch/arm/common/bL_head.S
> > new file mode 100644
> > index 0000000000..9d351f2b4c
> > --- /dev/null
> > +++ b/arch/arm/common/bL_head.S
> > @@ -0,0 +1,81 @@
> > +/*
> > + * arch/arm/common/bL_head.S -- big.LITTLE kernel re-entry point
> > + *
> > + * Created by:  Nicolas Pitre, March 2012
> > + * Copyright:   (C) 2012  Linaro Limited
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/linkage.h>
> > +#include <asm/bL_entry.h>
> > +
> > +	.macro	pr_dbg	cpu, string
> > +#if defined(CONFIG_DEBUG_LL) && defined(DEBUG)
> > +	b	1901f
> > +1902:	.ascii	"CPU 0: \0CPU 1: \0CPU 2: \0CPU 3: \0"
> > +	.ascii	"CPU 4: \0CPU 5: \0CPU 6: \0CPU 7: \0"
> > +1903:	.asciz	"\string"
> > +	.align
> > +1901:	adr	r0, 1902b
> > +	add	r0, r0, \cpu, lsl #3
> > +	bl	printascii
> > +	adr	r0, 1903b
> > +	bl	printascii
> > +#endif
> > +	.endm
> > +
> > +	.arm
> > +	.align
> > +
> > +ENTRY(bL_entry_point)
> > +
> > + THUMB(	adr	r12, BSYM(1f)	)
> > + THUMB(	bx	r12		)
> > + THUMB(	.thumb			)
> > +1:
> > +	mrc	p15, 0, r0, c0, c0, 5
> > +	ubfx	r9, r0, #0, #4			@ r9 = cpu
> > +	ubfx	r10, r0, #8, #4			@ r10 = cluster
> > +	mov	r3, #BL_CPUS_PER_CLUSTER
> > +	mla	r4, r3, r10, r9			@ r4 = canonical CPU index
> > +	cmp	r4, #(BL_CPUS_PER_CLUSTER * BL_NR_CLUSTERS)
> > +	blo	2f
> > +
> > +	/* We didn't expect this CPU.  Try to make it quiet. */
> > +1:	wfi
> > +	wfe
> > +	b	1b
> 
> I realise this CPU is stuck at this point, but you should have a dsb
> before a wfi instruction. This could be problematic with the CCI this
> early, so maybe just a comment saying that it doesn't matter because we
> don't care about this core?

Why a dsb?  No data was even touched at this point.  And since this is 
meant to be a better "b ." kind of loop, I'd rather not try to make it 
more sophisticated than it already is.  And of course it is meant to 
never be executed in practice.

> > +
> > +2:	pr_dbg	r4, "kernel bL_entry_point\n"
> > +
> > +	/*
> > +	 * MMU is off so we need to get to bL_entry_vectors in a
> > +	 * position independent way.
> > +	 */
> > +	adr	r5, 3f
> > +	ldr	r6, [r5]
> > +	add	r6, r5, r6			@ r6 = bL_entry_vectors
> > +
> > +bL_entry_gated:
> > +	ldr	r5, [r6, r4, lsl #2]		@ r5 = CPU entry vector
> > +	cmp	r5, #0
> > +	wfeeq
> > +	beq	bL_entry_gated
> > +	pr_dbg	r4, "released\n"
> > +	bx	r5
> > +
> > +	.align	2
> > +
> > +3:	.word	bL_entry_vectors - .
> > +
> > +ENDPROC(bL_entry_point)
> > +
> > +	.bss
> > +	.align	5
> > +
> > +	.type	bL_entry_vectors, #object
> > +ENTRY(bL_entry_vectors)
> > +	.space	4 * BL_NR_CLUSTERS * BL_CPUS_PER_CLUSTER
> 
> Is there a particular reason to put this in the bss?

Yes, to have it zero initialized without taking up binary space.

> > diff --git a/arch/arm/include/asm/bL_entry.h b/arch/arm/include/asm/bL_entry.h
> > new file mode 100644
> > index 0000000000..ff623333a1
> > --- /dev/null
> > +++ b/arch/arm/include/asm/bL_entry.h
> > @@ -0,0 +1,35 @@
> > +/*
> > + * arch/arm/include/asm/bL_entry.h
> > + *
> > + * Created by:  Nicolas Pitre, April 2012
> > + * Copyright:   (C) 2012  Linaro Limited
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#ifndef BL_ENTRY_H
> > +#define BL_ENTRY_H
> > +
> > +#define BL_CPUS_PER_CLUSTER	4
> > +#define BL_NR_CLUSTERS		2
> 
> Hmm, I see these have to be constant so you can allocate your space in
> the assembly file. In which case, I think it's worth changing their
> names to have MAX or LIMIT in them...

Yes, good point.  I'll change them.

>  maybe they could even be CONFIG options?

Nah.  I prefer not adding new config options unless this is really 
necessary or useful.  For the forseeable future, we'll see systems with 
at most 2 clusters and at most 4 CPUs per cluster.  That could easily be 
revisited later if that becomes unsuitable for some new systems.

Initially I wanted all those things to be runtime sized in relation with 
the TODO item in the commit log.  That too can come later.


Nicolas
