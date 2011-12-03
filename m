From: will.deacon@arm.com (Will Deacon)
Date: Sat, 3 Dec 2011 10:21:54 +0000
Subject: [GIT PULL] ARM perf updates for 3.3
In-Reply-To: <20111203092659.GL9581@n2100.arm.linux.org.uk>
References: <20111202170231.GP5540@mudshark.cambridge.arm.com>
 <20111203092659.GL9581@n2100.arm.linux.org.uk>
Message-ID: <20111203102154.GB3860@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 03, 2011 at 09:26:59AM +0000, Russell King - ARM Linux wrote:
> On Fri, Dec 02, 2011 at 05:02:31PM +0000, Will Deacon wrote:
> > Please pull these updates to the ARM perf code for 3.3. The highlights are
> > probably the CTI stuff (which is in preparation for OMAP4 support coming from
> > Lei Ming, Benoit and Paul) and the cleanup of the event numbers for ARMv7 so
> > that they are easier to follow. I was hoping to add Cortex-A7 support but I
> > haven't got my paws on an FPGA yet.
> > 
> > I've not included my contextidr patch with this pull because it conflicts
> > quite badly with the LPAE patches. I can rework this for 3.4 later on (I
> > already have a fixup).
> 
> While merging this, I get conflicts in gic.c and omap's common.h.  I'm
> intending to resolve them as below - please check this _before_ I commit
> it (which means my tree is frozen until this is resolved.)

This doesn't sound quite right since I don't touch either of these files in
my perf changes. I suspect that you're getting changes from your recently
merged fixes branch back from my tree, which is based on -rc4.

Unfortunately, I depend on -rc4 for that exact reason (it has some perf
fixes in there)!

So the easiest solution might be to wait until you're using -rc4 as a base
(or I can rebase onto anything that contains your fixes branch).

> diff --cc arch/arm/common/gic.c
> index a1feb6b,410a546..0000000
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@@ -696,12 -582,16 +697,14 @@@ void __init gic_init_bases(unsigned in
>   	 * For primary GICs, skip over SGIs.
>   	 * For secondary GICs, skip over PPIs, too.
>   	 */
> + 	domain->hwirq_base = 32;
>   	if (gic_nr == 0) {
> - 		domain->hwirq_base = 16;
> - 		if (irq_start > 0)
> - 			irq_start = (irq_start & ~31) + 16;
> - 	} else
> - 		domain->hwirq_base = 32;
>  -		gic_cpu_base_addr = cpu_base;
>  -
> + 		if ((irq_start & 31) > 0) {
> + 			domain->hwirq_base = 16;
> + 			if (irq_start != -1)
> + 				irq_start = (irq_start & ~31) + 16;
> + 		}
> + 	}

As it happens, I worked on this with Marc and that resolution looks ok to
me, although I don't have a board at hand to test it.

>   	/*
>   	 * Find out how many interrupts are supported.
> diff --cc arch/arm/plat-omap/include/plat/common.h
> index 346098f,3ff3e36..0000000
> --- a/arch/arm/plat-omap/include/plat/common.h
> +++ b/arch/arm/plat-omap/include/plat/common.h

[...]

Afraid I don't have a clue about this one.

Would you like me to base this on something else?

Will
