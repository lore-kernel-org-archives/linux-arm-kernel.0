From: florian@openwrt.org (Florian Fainelli)
Date: Mon, 16 Jul 2012 14:43:25 +0200
Subject: [PATCH 1/8] ARM: support for Moschip MCS814x SoCs
In-Reply-To: <20120716142941.666d928c@skate>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
 <1342363754-30808-2-git-send-email-florian@openwrt.org>
 <20120716142941.666d928c@skate>
Message-ID: <7233708.5ojzueYxjb@flexo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Monday 16 July 2012 14:29:41 Thomas Petazzoni wrote:
> Hello Florian,
> 
> Le Sun, 15 Jul 2012 16:49:07 +0200,
> Florian Fainelli <florian@openwrt.org> a ?crit :
> 
> > diff --git a/arch/arm/mach-mcs814x/Makefile.boot b/arch/arm/mach-
mcs814x/Makefile.boot
> > new file mode 100644
> > index 0000000..414db8b
> > --- /dev/null
> > +++ b/arch/arm/mach-mcs814x/Makefile.boot
> > @@ -0,0 +1,3 @@
> > +    zreladdr-y := 0x00008000
> > + params_phys-y := 0x00000008
> > + initrd_phys-y := 0x00400000
> 
> params_phys-y and initrd_phys-y are useless for DT-based platforms, if
> I'm correct.

Indeed, only zreladdr is actually required.

> 
> > diff --git a/arch/arm/mach-mcs814x/clock.c b/arch/arm/mach-mcs814x/clock.c
> > new file mode 100644
> > index 0000000..eb30ae2
> > --- /dev/null
> > +++ b/arch/arm/mach-mcs814x/clock.c
[snip]
> 
> You should rather use the new clock framework instead of providing your
> own implementation of the clk_*() API. And therefore your clock driver
> should be in drivers/clk/ instead.

Since I was targetting 3.6 initially I more or less used what was existing by 
the time I wrote the patches, but I will do this.

> 
> > +struct cpu_mode {
> > +	const char *name;
> > +	int gpio_start;
> > +	int gpio_end;
> > +};
> > +
> > +static const struct cpu_mode cpu_modes[] = {
> > +	{
> > +		.name		= "I2S",
> > +		.gpio_start	= 4,
> > +		.gpio_end	= 8,
> > +	},
> > +	{
> > +		.name		= "UART",
> > +		.gpio_start	= 4,
> > +		.gpio_end	= 9,
> > +	},
> > +	{
> > +		.name		= "External MII",
> > +		.gpio_start	= 0,
> > +		.gpio_end	= 16,
> > +	},
> > +	{
> > +		.name		= "Normal",
> > +		.gpio_start	= -1,
> > +		.gpio_end	= -1,
> > +	},
> > +};
> > +
> > +void __init mcs814x_init_machine(void)
> > +{
> > +	u32 bs2, cpu_mode;
> > +	int gpio;
> > +
> > +	bs2 = __raw_readl(mcs814x_sysdbg_base + SYSDBG_BS2);
> > +	cpu_mode = (bs2 >> CPU_MODE_SHIFT) & CPU_MODE_MASK;
> > +
> > +	pr_info("CPU mode: %s\n", cpu_modes[cpu_mode].name);
> > +
> > +	/* request the gpios since the pins are muxed for functionnality */
> > +	for (gpio = cpu_modes[cpu_mode].gpio_start;
> > +		gpio == cpu_modes[cpu_mode].gpio_end; gpio++) {
> > +		if (gpio != -1)
> > +			gpio_request(gpio, cpu_modes[cpu_mode].name);
> 
> I am not sure here, but shouldn't this be done with the pinctrl
> subsystem instead?

This muxing is actually hardwired with the bootstrap register setting. I could 
also even remove this because the underlying hardware block actually does not 
need to use the GPIOs, they will be configured as pins for the corresponding 
functions directly. This is also not runtime modifiable. I just thought that 
marking these GPIOs as reserved by the corresponding functionnality could help 
the user figuring out what is happening with them.

> 
> > +void __init mcs814x_map_io(void)
> > +{
> > +	iotable_init(mcs814x_io_desc, ARRAY_SIZE(mcs814x_io_desc));
> > +
> > +	mcs814x_sysdbg_base = ioremap(MCS814X_IO_START + MCS814X_SYSDBG,
> > +					MCS814X_SYSDBG_SIZE);
> > +	if (!mcs814x_sysdbg_base)
> > +		panic("unable to remap sysdbg base");
> 
> Any reason to have a static mapping initialized with iotable_init() and
> then a dynamic mapping initialized with ioremap() ? I thought that
> ioremap() wasn't ready at the ->map_io() time, and it was therefore the
> reason we had static mappings.

There are no particular reasons, I could use the the define for the virtual 
address directly.

> 
> > diff --git a/arch/arm/mach-mcs814x/include/mach/entry-macro.S 
b/arch/arm/mach-mcs814x/include/mach/entry-macro.S
> > new file mode 100644
> > index 0000000..cbad566
> > --- /dev/null
> > +++ b/arch/arm/mach-mcs814x/include/mach/entry-macro.S
> > @@ -0,0 +1,29 @@
> > +#include <mach/mcs814x.h>
> > +                .macro  disable_fiq
> > +                .endm
> > +
> > +		.macro arch_ret_to_user, tmp1, tmp2
> > +		.endm
> > +
> > +		.macro  get_irqnr_preamble, base, tmp
> > +		ldr	\base, =mcs814x_intc_base@ base virtual address of INTC
> > +		ldr	\base, [\base]
> > +		.endm
> > +
> > +		.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
> > +		mov	\tmp, #MCS814X_IRQ_STS0	 @ load tmp with STS0 register 
offset
> > +		ldr	\irqstat, [\base, \tmp]	 @ load value at base + tmp
> > +		tst	\irqstat, \irqstat       @ test if no active IRQ's
> > +		beq	1002f                    @ if no active irqs return with 
status 0
> > +		mov	\irqnr, #0               @ start from irq zero
> > +		mov	\tmp,   #1               @ the mask initially 1
> > +1001:
> > +		tst     \irqstat, \tmp           @ and with mask
> > +		addeq   \irqnr, \irqnr, #1       @ if  zero then add one to nr
> > +		moveq   \tmp,   \tmp, lsl #1     @ shift mask one to left
> > +		beq     1001b                    @ if  zero then loop again
> > +		mov     \irqstat, \tmp           @ save the return mask
> > +		mov	\tmp, #MCS814X_IRQ_STS0  @ load tmp with ICR offset
> > +		str     \irqstat,  [\base, \tmp] @ clear irq with selected 
mask
> > +1002:
> > +                .endm
> 
> Hum, you should instead use the MULTI_IRQ_HANDLER feature so that this
> can be written in C.

Last I did this, I managed to get interrupt handling issues with Ethernet, but 
I will try to address this. So far, since we support only MCS8140 this is not 
a problem, MCS8142 also has the same interrupt controller.

> 
> > diff --git a/arch/arm/mach-mcs814x/include/mach/hardware.h b/arch/arm/mach-
mcs814x/include/mach/hardware.h
> > new file mode 100644
> > index 0000000..529f648
> > --- /dev/null
> > +++ b/arch/arm/mach-mcs814x/include/mach/hardware.h
> > @@ -0,0 +1,16 @@
> > +/*
> > + * Copyright (C) 2003 Artec Design Ltd.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + */
> > +
> > +#ifndef __ASM_ARCH_HARDWARE_H
> > +#define __ASM_ARCH_HARDWARE_H
> 
> This #define name no longer looks consistent with where the file is
> located.

Right, thanks!

> 
> > +#include "mcs814x.h"
> > +
> > +#endif
> > +
> > diff --git a/arch/arm/mach-mcs814x/include/mach/irqs.h b/arch/arm/mach-
mcs814x/include/mach/irqs.h
> > new file mode 100644
> > index 0000000..78021d1
> > --- /dev/null
> > +++ b/arch/arm/mach-mcs814x/include/mach/irqs.h
> > @@ -0,0 +1,22 @@
> > +/*
> > + * Copyright (C) 2003 Artec Design Ltd.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + */
> > +
> > +#ifndef __ASM_ARCH_IRQS_H
> > +#define __ASM_ARCH_IRQS_H
> > +
> > +#define FIQ_START	0
> > +
> > +#define NR_IRQS		32
> 
> I think this shouldn't be needed if you use SPARSE_IRQ support.
> 
> > +#define IRQ_PCI_INTA            22
> > +#define IRQ_PCI_INTB            23
> > +#define IRQ_PCI_INTC            24
> > +#define IRQ_PCI_INTD            26
> 
> And these probably belong to the DT somehow?

This would need a complete PCI irq mapping representation, so far we have the 
DT properties, but not the corresponding code to parse them. I would not 
qualify this as a major blocker.

> 
> > diff --git a/arch/arm/mach-mcs814x/timer.c b/arch/arm/mach-mcs814x/timer.c
> > new file mode 100644
> > index 0000000..e8408e4

[snip]

> > +
> > +static void __init mcs814x_timer_init(void)
> > +{
> > +	struct clk *clk;
> > +
> > +	clk = clk_get_sys("timer0", NULL);
> > +	if (IS_ERR_OR_NULL(clk))
> > +		panic("unable to get timer0 clock");
> > +
> > +	clock_rate = clk_get_rate(clk);
> > +	clk_put(clk);
> > +
> > +	mcs814x_of_timer_init();
> > +
> > +	pr_info("Timer frequency: %d (kHz)\n", clock_rate / 1000);
> > +
> > +	timer_reload_value = 0xffffffff - (clock_rate / HZ);
> > +
> > +	/* disable timer */
> > +	__raw_writel(0, mcs814x_timer_base + TIMER_CTL);
> > +	__raw_writel(timer_reload_value, mcs814x_timer_base + TIMER_VAL);
> > +	last_reload = timer_reload_value;
> > +
> > +	setup_irq(mcs814x_timer_irq.irq, &mcs814x_timer_irq);
> > +	/* enable timer, stop timer in debug mode */
> > +	__raw_writel(0x03, mcs814x_timer_base + TIMER_CTL);
> > +}
> > +
> > +struct sys_timer mcs814x_timer = {
> > +	.init	= mcs814x_timer_init,
> > +	.offset	= mcs814x_gettimeoffset,
> > +};
> 
> I am surprised that this doesn't use the clocksource and clockevents
> infrastructure. It probably should, and be implemented in
> drivers/clocksource/.

I will look into this, considering that we still have 2 timers left available 
(64-bits and 16-bits) this should be doable.

Thank you for your comments, I will wait a little more for other people to 
come up before coming up with a patch respin.
--
Florian
