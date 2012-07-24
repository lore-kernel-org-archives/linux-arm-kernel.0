From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jul 2012 18:45:57 +0000
Subject: [RFC 21/23] ARM: keystone: introducing TI Keystone platform
In-Reply-To: <500EE1CD.6030701@ti.com>
References: <1343092165-9470-1-git-send-email-cyril@ti.com>
 <201207241446.53401.arnd@arndb.de> <500EE1CD.6030701@ti.com>
Message-ID: <201207241845.57784.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 July 2012, Cyril Chemparathy wrote:
> >> diff --git a/arch/arm/mach-keystone/include/mach/memory.h b/arch/arm/mach-keystone/include/mach/memory.h
> >> new file mode 100644
> >> index 0000000..7c78b1e
> >> --- /dev/null
> >> +++ b/arch/arm/mach-keystone/include/mach/memory.h
> >
> >> +#ifndef __ASM_MACH_MEMORY_H
> >> +#define __ASM_MACH_MEMORY_H
> >> +
> >> +#define MAX_PHYSMEM_BITS    36
> >> +#define SECTION_SIZE_BITS   34
> >> +
> >> +#endif /* __ASM_MACH_MEMORY_H */
> >
> > I wonder if there is anything we can do to make these generic. What you
> > have here is ok for now, but we will need to do this differently once
> > we are building multiplatform kernels with keystone and sparse memory.
> >
> 
> Understood.  Any ideas on the general direction towards solving this?

I can't remember discussing this in the past. Maybe it never came up
because most platforms don't enable sparsemem.

IIRC this is done through Kconfig on powerpc, where we pick the minimum
required size based on which platforms are enabled.

I also don't know what to do about ARM_PATCH_PHYS_VIRT here: my
impression so far was that we would enable it for all multiplatform
builds, but it conflicts with sparsemem.

> >> +DT_MACHINE_START(KEYSTONE, "Keystone")
> >> +    .map_io         = keystone_map_io,
> >> +    .init_irq       = keystone_init_irq,
> >> +    .timer          = &keystone_timer,
> >> +    .handle_irq     = gic_handle_irq,
> >> +    .init_machine   = keystone_init,
> >> +    .dt_compat      = keystone_match,
> >> +    .nr_irqs        = 480,
> >> +MACHINE_END
> >
> > IIRC, you don't need to set the nr_irqs this high in advance,
> > they will be allocated automatically since you have enabled
> > sparse IRQs.
> >
> 
> We were seeing a complaint without nr_irqs set, but I'll dig into that 
> further.

Maybe a driver that hardcodes an IRQ number?

	Arndx
