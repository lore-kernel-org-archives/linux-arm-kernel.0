From: florian@openwrt.org (Florian Fainelli)
Date: Tue, 17 Jul 2012 11:34:15 +0200
Subject: [PATCH 1/8] ARM: support for Moschip MCS814x SoCs
In-Reply-To: <201207161554.04812.arnd@arndb.de>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
 <1342363754-30808-2-git-send-email-florian@openwrt.org>
 <201207161554.04812.arnd@arndb.de>
Message-ID: <6125783.OUR7TQ8gMf@flexo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Monday 16 July 2012 15:54:04 Arnd Bergmann wrote:
> On Sunday 15 July 2012, Florian Fainelli wrote:
> 
> > diff --git a/arch/arm/mach-mcs814x/Kconfig b/arch/arm/mach-mcs814x/Kconfig
> > new file mode 100644
> > index 0000000..c89422f
> > --- /dev/null
> > +++ b/arch/arm/mach-mcs814x/Kconfig
> > @@ -0,0 +1,11 @@
> > +if ARCH_MCS814X
> > +
> > +config MCS8140
> > +	select CPU_ARM926T
> > +	bool
> > +
> > +menu "Moschip MCS8140 boards"
> > +
> > +endmenu
> > +
> > +endif
> 
> What values does the Kconfig file actually provide? I see that you are
> adding the boards here later, but I think it would be nice to just 
> make the new platform a single Kconfig option with no individual
> board selection.

I plan on adding support for MCS8142 later on, thus I thought it would be nice 
to be able to selectively compile board support for MCS8140 or some later 
chip.

> 
> > +struct clk {
> > +	struct clk *parent;		/* parent clk */
> > +	unsigned long rate;		/* clock rate in Hz */
> > +	unsigned long divider;		/* clock divider */
> > +	u32 usecount;			/* reference count */
> > +	struct clk_ops *ops;		/* clock operation */
> > +	u32 enable_reg;			/* clock enable register */
> > +	u32 enable_mask;		/* clock enable mask */
> > +};
> 
> Platforms are now converting to the common clock framework in drivers/clk.
> Mike Turquette as the subsystem maintainer can probably judge better whether
> we should still be allowing new platforms with their own implementation
> of clk, but my feeling is that you should use the subsystem instead
> and add a driver in a subdirectory of drivers/clk instead of in the
> platform.
> 
> > +void __iomem *mcs814x_sysdbg_base;
> 
> Does this have to be globally visible? I would recommend making it static.

Yes, since it is used both by clock.c and common.c

> 
> > +
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
> > +	}
> > +}
> 
> This looks like a very simple instance of a pinmux driver. I wonder
> if it's worth doing an actual pinctrl driver that knows about these
> modes and about the gpio handling of the platform. Maybe Linus Walleij
> can comment on that.
> 
> How is the cpu mode managed? Is it hardwired through something like
> strapping pins, or could you have a system that sets it dynamically
> based on what hardware is being plugged in?

Like I replied to Thomas, these settings are actually hardwired through 
bootstrap registers, so I should not even bother to request these GPIOs.

> 
> > +void __init mcs814x_map_io(void)
> > +{
> > +	iotable_init(mcs814x_io_desc, ARRAY_SIZE(mcs814x_io_desc));
> > +
> > +	mcs814x_sysdbg_base = ioremap(MCS814X_IO_START + MCS814X_SYSDBG,
> > +					MCS814X_SYSDBG_SIZE);
> > +	if (!mcs814x_sysdbg_base)
> > +		panic("unable to remap sysdbg base");
> > +}
> > +
> > +void mcs814x_restart(char mode, const char *cmd)
> > +{
> > +	__raw_writel(~(1 << 31), mcs814x_sysdbg_base);
> > +}
> 
> You should generally avoid using __raw_readl etc. and instead use
> readl/write or readl_relaxed/writel_relaxed.

Allright, even on an ARM926-EJS-based system?

> 
> > diff --git a/arch/arm/mach-mcs814x/common.h b/arch/arm/mach-
mcs814x/common.h
> > new file mode 100644
> > index 0000000..e523abe
> > --- /dev/null
> > +++ b/arch/arm/mach-mcs814x/common.h
> > @@ -0,0 +1,15 @@
> > +#ifndef __ARCH_MCS814X_COMMON_H
> > +#define __ARCH_MCS814X_COMMON_H
> > +
> > +#include <asm/mach/time.h>
> > +
> > +void mcs814x_map_io(void);
> > +void mcs814x_clk_init(void);
> > +void mcs814x_of_irq_init(void);
> > +void mcs814x_init_machine(void);
> > +void mcs814x_handle_irq(struct pt_regs *regs);
> > +void mcs814x_restart(char mode, const char *cmd);
> > +extern struct sys_timer mcs814x_timer;
> > +extern void __iomem *mcs814x_sysdbg_base;
> > +
> > +#endif /* __ARCH_MCS814X_COMMON_H */
> 
> I think a lot of these don't actually need to be global if you combine some
> of the files.
> 
> 
> > diff --git a/arch/arm/mach-mcs814x/include/mach/cpu.h b/arch/arm/mach-
mcs814x/include/mach/cpu.h
> > new file mode 100644
> > index 0000000..1ef3c4a
> > --- /dev/null
> > +++ b/arch/arm/mach-mcs814x/include/mach/cpu.h
> > @@ -0,0 +1,16 @@
> > +#ifndef __ASM_ARCH_CPU_H__
> > +#define __ASM_ARCH_CPU_H__
> > +
> > +#include <asm/cputype.h>
> > +
> > +#define MCS8140_ID	0x41069260	/* ARM926EJ-S */
> > +#define MCS814X_MASK	0xff0ffff0
> > +
> > +#ifdef CONFIG_MCS8140
> > +/* Moschip MCS8140 is based on an ARM926EJ-S core */
> > +#define soc_is_mcs8140()	((read_cpuid_id() & MCS814X_MASK) == MCS8140_ID)
> > +#else
> > +#define soc_is_mcs8140()	(0)
> > +#endif /* !CONFIG_MCS8140 */
> > +
> > +#endif /* __ASM_ARCH_CPU_H__ */
> 
> Can you explain what this is used for? Are there other SoCs in the same
> platform that will get added later?

Yes, that's the plan.

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
> > +
> > +#include "mcs814x.h"
> > +
> > +#endif
> 
> I'd just make this an empty file, like gpio.h. That will let us kill off
> these files more easily in the future.

Ok.

> 
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
> 
> Why do you need the FIQ_START macro here?

I don't think I need this anymore.

> 
> > +#define NR_IRQS		32
> > +
> > +#define IRQ_PCI_INTA            22
> > +#define IRQ_PCI_INTB            23
> > +#define IRQ_PCI_INTC            24
> > +#define IRQ_PCI_INTD            26
> 
> The PCI interrupts should come from the device tree.
> 
> You should also select CONFIG_SPARSE_IRQ unconditionally and use IRQ domains
> so that you no longer need to set NR_IRQS.

Ok.

> 
> > diff --git a/arch/arm/mach-mcs814x/include/mach/mcs814x.h b/arch/arm/mach-
mcs814x/include/mach/mcs814x.h
> > new file mode 100644
> > index 0000000..a4a369e
> > --- /dev/null
> > +++ b/arch/arm/mach-mcs814x/include/mach/mcs814x.h
> > @@ -0,0 +1,53 @@
> > +/*
> > + * Copyright (C) 2003 Artec Design Ltd.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + */
> > +
> > +#ifndef __ASM_ARCH_MCS814X_H
> > +#define __ASM_ARCH_MCS814X_H
> > +
> > +#define MCS814X_IO_BASE		0xF0000000
> > +#define MCS814X_IO_START	0x40000000
> > +#define MCS814X_IO_SIZE		0x00100000
> 
> What are these required for in the global space? Can you move them into
> a single .c file?

I can certainly do this.

> 
> > +/* IRQ controller register offset */
> > +#define MCS814X_IRQ_ICR		0x00
> > +#define MCS814X_IRQ_ISR		0x04
> > +#define MCS814X_IRQ_MASK	0x20
> > +#define MCS814X_IRQ_STS0	0x40
> 
> I'm pretty sure these can be in irq.c

Not unless I switch to MULTI_IRQ_HANDLER.

> 
> > +#define MCS814X_PHYS_BASE	0x40000000
> > +#define MCS814X_VIRT_BASE	MCS814X_IO_BASE
> > +
> > +#define MCS814X_UART		0x000DC000
> > +#define MCS814X_DBGLED		0x000EC000
> > +#define MCS814X_SYSDBG		0x000F8000
> > +#define MCS814X_SYSDBG_SIZE	0x50
> > +
> > +/* System configuration and bootstrap registers */
> > +#define SYSDBG_BS1		0x00
> > +#define  CPU_FREQ_SHIFT		27
> > +#define  CPU_FREQ_MASK		0x0F
> > +#define  SDRAM_FREQ_BIT		(1 << 22)
> > +
> > +#define SYSDBG_BS2		0x04
> > +#define  LED_CFG_MASK		0x03
> > +#define  CPU_MODE_SHIFT		23
> > +#define  CPU_MODE_MASK		0x03
> > +
> > +#define SYSDBG_SYSCTL_MAC	0x1d
> > +#define  BUF_SHIFT_BIT		(1 << 0)
> > +
> > +#define SYSDBG_SYSCTL		0x08
> > +#define  SYSCTL_EMAC		(1 << 0)
> > +#define  SYSCTL_EPHY		(1 << 0) /* active low */
> > +#define  SYSCTL_CIPHER		(1 << 16)
> > +
> > +#define SYSDBG_PLL_CTL		0x3C
> 
> The sysdbg stuff can probably go into a file that deals
> with the sysdbg registers and exports a high-level interface.
> 
> > +
> > +void __iomem *mcs814x_intc_base;
> 
> static?

Since I am not yet using MULTI_IRQ_HANDLER, this is used by the entry-macro.S 
file too.

> 
> > +#define MCS8140_PCI_HOST_BASE           0x80000000
> > +#define MCS8140_PCI_IOMISC_BASE         0x00000000
> > +#define MCS8140_PCI_PRE_BASE            0x10000000
> > +#define MCS8140_PCI_NONPRE_BASE         0x30000000
> > +
> > +#define MCS8140_PCI_CFG_BASE		(MCS8140_PCI_HOST_BASE + 
0x04000000)
> > +#define MCS8140_PCI_IO_BASE		(MCS8140_PCI_HOST_BASE)
> > +
> > +#define MCS8140_PCI_IO_VIRT_BASE	(MCS814X_IO_BASE - \
> > +					 MCS8140_PCI_CONFIG_SIZE - \
> > +					 MCS8140_PCI_IOMISC_SIZE)
> > +#define MCS8140_PCI_CFG_VIRT_BASE	(MCS814X_IO_BASE - \
> > +					 MCS8140_PCI_CONFIG_SIZE)
> 
> 
> > +static unsigned long __pci_addr(struct pci_bus *bus,
> > +				unsigned int devfn, int offset)
> > +{
> > +	unsigned int busnr = bus->number;
> > +	unsigned int slot;
> > +
> > +	/* we only support bus 0 */
> > +	if (busnr != 0)
> > +		return 0;
> 
> Why? A lot of devices have bridges on them and they should just
> work if you take out this check.
> 
> > +	/*
> > +	 * Trap out illegal values
> > +	 */
> > +	BUG_ON(devfn > 255 || busnr > 255 || devfn > 255);
> 
> You're checking devfn twice...
> 
> > +	/* Scan 3 slots */
> > +	slot = PCI_SLOT(devfn);
> > +	switch (slot) {
> > +	case 1:
> > +	case 2:
> > +	case 3:
> > +		if (PCI_FUNC(devfn) >= 4)
> > +			return 0;
> 
> This also looks bogus. Why limit it to three devices?
> 
> > +static int mcs8140_pci_read_config(struct pci_bus *bus,
> > +					unsigned int devfn, int where,
> > +					int size, u32 *val)
> > +{
> > +	unsigned long v = 0xFFFFFFFF;
> > +	unsigned long addr = __pci_addr(bus, devfn, where);
> > +
> > +	if (addr != 0) {
> > +		switch (size) {
> > +		case 1:
> > +			v = __raw_readb(addr);
> > +			break;
> > +		case 2:
> > +			addr &= ~1;
> > +			v = __raw_readw(addr);
> > +			break;
> > +		default:
> > +			addr &= ~3;
> > +			v = __raw_readl(addr);
> > +			break;
> > +		}
> > +	} else
> > +		v = 0xffffffff;
> 
> This is just mmconfig, right? Don't we have a generic implementation for 
that?
> 
> > +
> > +static struct resource io_mem = {
> > +	.name	= "PCI I/O space",
> > +	.start	= MCS8140_PCI_HOST_BASE + MCS8140_PCI_IOMISC_BASE,
> > +	.end	= MCS8140_PCI_HOST_BASE + MCS8140_PCI_IOMISC_BASE + SZ_64M,
> > +	.flags	= IORESOURCE_IO,
> > +};
> 
> This is wrong: MCS8140_PCI_HOST_BASE is an address in IORESOURCE_MEM space.
> You probably also mean SZ_64K instead of SZ_64M.

I will double check with the hardware manual, but I really think it is 
64MBytes.

> 
> > +int __init pci_mcs8140_setup(int nr, struct pci_sys_data *sys)
> > +{
> > +	int ret = 0;
> > +	u32 val;
> > +
> > +	if (nr > 0)
> > +		return 0;
> > +
> > +	sys->mem_offset = MCS8140_PCI_IO_VIRT_BASE - MCS8140_PCI_IO_BASE;
> 
> Your address spaces are very confusing (or confused). So you have defined
> #define MCS8140_PCI_IO_VIRT_BASE       (MCS814X_IO_BASE - \
>                                         MCS8140_PCI_CONFIG_SIZE - \
>                                         MCS8140_PCI_IOMISC_SIZE)
> #define MCS8140_PCI_CFG_VIRT_BASE      (MCS814X_IO_BASE - \
>                                         MCS8140_PCI_CONFIG_SIZE)
> 
> 
> which means you mem_offset is (MCS814X_IO_BASE - MCS8140_PCI_CONFIG_SIZE -
> MCS8140_PCI_IOMISC_SIZE) - (MCS814X_IO_BASE - MCS8140_PCI_CONFIG_SIZE)
> which is (-MCS8140_PCI_IOMISC_SIZE), which in turn evaluates to
> -SZ_64M or 0xfc000000. If that is the correct value, I'm sure it's
> just coincidence ;-)
> 
> > +static int __init mcs8140_map_irq(const struct pci_dev *dev, u8 slot, u8 
pin)
> > +{
> > +	int line = IRQ_PCI_INTA;
> > +
> > +	if (pin != 0) {
> > +		/* IRQ_PCIA - 22 */
> > +		if (pin == PCI_INTD)
> > +			line = IRQ_PCI_INTA + pin; /* IRQ_PCIA - 22 */
> > +		else
> > +			line = IRQ_PCI_INTA + pin - 1; /* IRQ_PCIA - 22 */
> > +	}
> > +
> > +	pr_info("PCI: Map interrupt slot 0x%02x pin 0x%02x line 0x%02x\n",
> > +		slot, pin, line);
> > +
> > +	return line;
> > +}
> 
> This looks like a very unusual mapping. Maybe it's just wrong and that
> explains why you don't support child buses or additional slots?
> 
> In any case, you should use an "interrupt-map" in the device tree that
> describes how the IRQs are mapped to the slots. I think we have generic
> code to deal with that already.
> 
> > +static struct map_desc mcs8140_pci_io_desc[] __initdata = {
> > +	{
> > +		.virtual	= MCS8140_PCI_CFG_VIRT_BASE,
> > +		.pfn		= __phys_to_pfn(MCS8140_PCI_CFG_BASE),
> > +		.length		= MCS8140_PCI_CONFIG_SIZE,
> > +		.type		= MT_DEVICE
> > +	},
> > +	{
> > +		.virtual	= MCS8140_PCI_IO_VIRT_BASE,
> > +		.pfn		= __phys_to_pfn(MCS8140_PCI_IO_BASE),
> > +		.length		= MCS8140_PCI_IOMISC_SIZE,
> > +		.type		= MT_DEVICE
> > +	},
> > +};
> 
> Please have a look at the latest patches from Rob Herring about
> mapping the I/O space. I don't think you need to map the config
> space early because you don't rely on a fixed location for that.
> Just use of_iomap() to find that and store the pointer to the
> config space somewhere.
> 
> > +	pcibios_min_io = MCS8140_PCI_HOST_BASE;
> 
> Leave this one at the default of 0x1000. MCS8140_PCI_HOST_BASE is the
> address from the CPU's point of view, not from the bus. You just need
> to stay out of the range of possible legacy ISA devices.
> 
> It's probably a good idea to keep the PCI support as a separate patch
> for reviewing purposes.

Good idea, I will do that. Note that none of the boards I have actually have 
PCI, so the code is just there in case someone needs it. I could also go along 
and remove it, since I cannot test it, which explains why there are so many 
inconsistencies with it.

> 
> 	Arnd
