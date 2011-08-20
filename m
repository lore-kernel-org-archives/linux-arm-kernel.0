From: glikely@secretlab.ca (Grant Likely)
Date: Fri, 19 Aug 2011 23:31:40 -0700
Subject: [PATCH 1/3] picoxcell: support for Picochip picoxcell devices
In-Reply-To: <1312884661-27205-2-git-send-email-jamie@jamieiles.com>
References: <1312884661-27205-1-git-send-email-jamie@jamieiles.com>
	<1312884661-27205-2-git-send-email-jamie@jamieiles.com>
Message-ID: <4E4F54CC.8000506@secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-08-09 03:10 AM, Jamie Iles wrote:
> picoXcell is a family of femtocell devices with an ARM application
> processor and picoArray DSP processor array.
>
> This patch adds support for picoXcell boards to be booted using the
> device tree registering the VIC's, UART's and timers.
>
> Signed-off-by: Jamie Iles<jamie@jamieiles.com>
> ---
>
> The thing I'm least certain about here is the VIC handling.  As we have
> two VIC's that aren't cascaded (wire-OR'd instead) there needs to be a
> way for the entry macros to decode to the correct DT IRQ numbers.
> Originally I had two VIC nodes with each one having an irq-start
> property to denote the Linux IRQ number but that's a bit gross.
> Instead, in this patch I've group the two VIC node's into a single
> vic-pair node so that it looks like one controller that handles 64
> sources.
>
>   .../devicetree/bindings/arm/picoxcell.txt          |   27 ++++
>   arch/arm/Kconfig                                   |   18 +++
>   arch/arm/Makefile                                  |    1 +
>   arch/arm/mach-picoxcell/Makefile                   |    3 +
>   arch/arm/mach-picoxcell/Makefile.boot              |    1 +
>   arch/arm/mach-picoxcell/common.c                   |   72 +++++++++++
>   arch/arm/mach-picoxcell/common.h                   |   18 +++
>   arch/arm/mach-picoxcell/include/mach/debug-macro.S |   35 +++++
>   arch/arm/mach-picoxcell/include/mach/entry-macro.S |   19 +++
>   arch/arm/mach-picoxcell/include/mach/gpio.h        |   17 +++
>   arch/arm/mach-picoxcell/include/mach/hardware.h    |   21 +++
>   arch/arm/mach-picoxcell/include/mach/io.h          |   30 +++++
>   arch/arm/mach-picoxcell/include/mach/irqs.h        |   25 ++++
>   arch/arm/mach-picoxcell/include/mach/map.h         |   25 ++++
>   arch/arm/mach-picoxcell/include/mach/memory.h      |   17 +++
>   .../mach-picoxcell/include/mach/picoxcell_soc.h    |   25 ++++
>   arch/arm/mach-picoxcell/include/mach/system.h      |   31 +++++
>   arch/arm/mach-picoxcell/include/mach/timex.h       |   25 ++++
>   arch/arm/mach-picoxcell/include/mach/uncompress.h  |   60 +++++++++
>   arch/arm/mach-picoxcell/include/mach/vmalloc.h     |   18 +++
>   arch/arm/mach-picoxcell/io.c                       |   56 ++++++++
>   arch/arm/mach-picoxcell/time.c                     |  132 ++++++++++++++++++++
>   22 files changed, 676 insertions(+), 0 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/arm/picoxcell.txt
>   create mode 100644 arch/arm/mach-picoxcell/Makefile
>   create mode 100644 arch/arm/mach-picoxcell/Makefile.boot
>   create mode 100644 arch/arm/mach-picoxcell/common.c
>   create mode 100644 arch/arm/mach-picoxcell/common.h
>   create mode 100644 arch/arm/mach-picoxcell/include/mach/debug-macro.S
>   create mode 100644 arch/arm/mach-picoxcell/include/mach/entry-macro.S
>   create mode 100644 arch/arm/mach-picoxcell/include/mach/gpio.h
>   create mode 100644 arch/arm/mach-picoxcell/include/mach/hardware.h
>   create mode 100644 arch/arm/mach-picoxcell/include/mach/io.h
>   create mode 100644 arch/arm/mach-picoxcell/include/mach/irqs.h
>   create mode 100644 arch/arm/mach-picoxcell/include/mach/map.h
>   create mode 100644 arch/arm/mach-picoxcell/include/mach/memory.h
>   create mode 100644 arch/arm/mach-picoxcell/include/mach/picoxcell_soc.h
>   create mode 100644 arch/arm/mach-picoxcell/include/mach/system.h
>   create mode 100644 arch/arm/mach-picoxcell/include/mach/timex.h
>   create mode 100644 arch/arm/mach-picoxcell/include/mach/uncompress.h
>   create mode 100644 arch/arm/mach-picoxcell/include/mach/vmalloc.h
>   create mode 100644 arch/arm/mach-picoxcell/io.c
>   create mode 100644 arch/arm/mach-picoxcell/time.c
>
> diff --git a/Documentation/devicetree/bindings/arm/picoxcell.txt b/Documentation/devicetree/bindings/arm/picoxcell.txt
> new file mode 100644
> index 0000000..406c144
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/picoxcell.txt
> @@ -0,0 +1,27 @@
> +Picochip picoXcell device tree bindings.
> +========================================
> +
> +Required root node properties:
> +    - compatible:
> +	- "picochip,pc7302-pc3x3" : PC7302 development board with PC3X3 device.
> +	- "picochip,3x3" : picoXcell PC3X3 device based board.

"picochip,pc3x3" perhaps?

> +	- "picochip,3x2" : picoXcell PC3X2 device based board.
> +
> +Timers required properties:
> +    - compatible = "picochip,picoxcell-timer"

This looks overly generic. It should specify the exact implementation 
(soc): "picochip,pc3x3-timer" perhaps?

> +    - interrupts : The single IRQ line for the timer.
> +    - clock-freq : The frequency in HZ of the timer.
> +    - reg : The register bank for the timer.
> +
> +Note: two timers are required - one for the scheduler clock and one for the
> +event tick/NOHZ.
> +
> +VIC required properties:
> +    - compatible = "arm,pl192-vic-pair".
> +    - interrupt-controller.
> +    - reg : The register bank for the devices.  Picoxcell has two VIC's and the
> +      IRQ outputs are wire-OR'd together so we effectively have a combined
> +      controller that handles 64 IRQ's.  The first reg tuple is the register
> +      bank of the VIC that generates IRQ's 0->31 and the second tuple handles
> +      IRQ's 32->63.

If they are two separate devices, then it probably should still be 
represented as two separate device tree nodes.  Linux can take care of 
assigning a range of linux irq numbers to each VIC.

> +    - #interrupt-cells : Must be 1.
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 199722b..fcfa4b4 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -609,6 +609,24 @@ config ARCH_TEGRA
>   	  This enables support for NVIDIA Tegra based systems (Tegra APX,
>   	  Tegra 6xx and Tegra 2 series).
>
> +config ARCH_PICOXCELL
> +	bool "Picochip picoXcell"
> +	select ARM_PATCH_PHYS_VIRT
> +	select NO_IOPORT
> +	select ARM_VIC
> +	select CPU_V6K
> +	select DW_APB_TIMER
> +	select GENERIC_CLOCKEVENTS
> +	select HAVE_SCHED_CLOCK
> +	select HAVE_TCM
> +	select USE_OF
> +	select GENERIC_GPIO
> +	select ARCH_REQUIRE_GPIOLIB
> +	help
> +	  This enables support for systems based on the Picochip picoXcell
> +	  family of Femtocell devices.  The picoxcell support requires device tree
> +	  for all boards.
> +
>   config ARCH_PNX4008
>   	bool "Philips Nexperia PNX4008 Mobile"
>   	select CPU_ARM926T
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 0677b86..071134a 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -167,6 +167,7 @@ machine-$(CONFIG_ARCH_OMAP2)		:= omap2
>   machine-$(CONFIG_ARCH_OMAP3)		:= omap2
>   machine-$(CONFIG_ARCH_OMAP4)		:= omap2
>   machine-$(CONFIG_ARCH_ORION5X)		:= orion5x
> +machine-$(CONFIG_ARCH_PICOXCELL)	:= picoxcell
>   machine-$(CONFIG_ARCH_PNX4008)		:= pnx4008
>   machine-$(CONFIG_ARCH_PRIMA2)		:= prima2
>   machine-$(CONFIG_ARCH_PXA)		:= pxa
> diff --git a/arch/arm/mach-picoxcell/Makefile b/arch/arm/mach-picoxcell/Makefile
> new file mode 100644
> index 0000000..c550b63
> --- /dev/null
> +++ b/arch/arm/mach-picoxcell/Makefile
> @@ -0,0 +1,3 @@
> +obj-y	:= common.o
> +obj-y	+= time.o
> +obj-y	+= io.o
> diff --git a/arch/arm/mach-picoxcell/Makefile.boot b/arch/arm/mach-picoxcell/Makefile.boot
> new file mode 100644
> index 0000000..b327175
> --- /dev/null
> +++ b/arch/arm/mach-picoxcell/Makefile.boot
> @@ -0,0 +1 @@
> +zreladdr-y := 0x00008000
> diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
> new file mode 100644
> index 0000000..b529050
> --- /dev/null
> +++ b/arch/arm/mach-picoxcell/common.c
> @@ -0,0 +1,72 @@
> +/*
> + * Copyright (c) 2011 Picochip Ltd., Jamie Iles
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * All enquiries to support at picochip.com
> + */
> +#include<linux/irq.h>
> +#include<linux/irqdomain.h>
> +#include<linux/of.h>
> +#include<linux/of_address.h>
> +#include<linux/of_platform.h>
> +
> +#include<asm/mach/arch.h>
> +#include<asm/hardware/vic.h>
> +
> +#include<mach/map.h>
> +#include<mach/picoxcell_soc.h>
> +
> +#include "common.h"
> +
> +static void __init picoxcell_init_machine(void)
> +{
> +	const struct of_device_id bus_ids[] = {
> +		{ .compatible = "simple-bus" },
> +		{ /* Sentinel */ }
> +	};

You don't need to device one here.  There is now a default bus id table 
called of_default_bus_match_table.

> +
> +	of_platform_bus_probe(NULL, bus_ids, NULL);

Use of_platform_populate() (as you already mentioned that you're going 
to change).

> +}
> +
> +static const char *picoxcell_dt_match[] = {
> +	"picochip,pc3x2",
> +	"picochip,pc3x3",
> +	NULL
> +};
> +
> +static const struct of_device_id vic_of_match[] = {
> +	{ .compatible = "arm,pl192-vic-pair" },
> +	{ /* Sentinel */ }
> +};
> +
> +static void __init picoxcell_init_irq(void)
> +{
> +	struct device_node *np = of_find_matching_node(NULL, vic_of_match);
> +	void __iomem *regs;
> +
> +	if (!np)
> +		panic("unable to find vic");
> +
> +	regs = of_iomap(np, 0);
> +	if (!regs)
> +		panic("unable to map regs for vic0");
> +	vic_init(regs, 0, ~0, 0);
> +
> +	regs = of_iomap(np, 1);
> +	if (!regs)
> +		panic("unable to map regs for vic1");
> +	vic_init(regs, 32, ~0, 0);
> +
> +	irq_domain_add_simple(np, 0);
> +}
> +
> +DT_MACHINE_START(PICOXCELL, "Picochip picoXcell")
> +	.map_io		= picoxcell_map_io,
> +	.init_irq	= picoxcell_init_irq,
> +	.timer		=&picoxcell_timer,
> +	.init_machine	= picoxcell_init_machine,
> +	.dt_compat	= picoxcell_dt_match,
> +MACHINE_END

Otherwise looks okay to me.

g.
