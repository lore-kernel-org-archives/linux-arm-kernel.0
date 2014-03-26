From: robh@kernel.org (Rob Herring)
Date: Wed, 26 Mar 2014 08:59:32 -0500
Subject: [PATCH] ARM: realview: basic device tree implementation
In-Reply-To: <1395826060-26662-1-git-send-email-linus.walleij@linaro.org>
References: <1395826060-26662-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAL_JsqKYR1aujNhOASivsg-ED6xDPCsSCcGVnQn5vy4sD1PhAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 4:27 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> This implements basic device tree boot support for the RealView
> platforms, with a basic device tree for ARM PB1176 as an example.
>
> The implementation is done with a new DT-specific board file
> using only pre-existing bindings for the basic IRQ, timer and
> serial port drivers. A new compatible type is added to the GIC
> for the ARM1176.
>
> This implementation uses the MFD syscon handle from day one to
> access the system controller registers, and register the devices
> using the SoC bus.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/arm-boards |  53 ++++++
>  arch/arm/boot/dts/Makefile                       |   1 +
>  arch/arm/boot/dts/arm-realview-pb1176.dts        | 165 ++++++++++++++++
>  arch/arm/mach-realview/Kconfig                   |  10 +
>  arch/arm/mach-realview/Makefile                  |   1 +
>  arch/arm/mach-realview/realview-dt.c             | 231 +++++++++++++++++++++++
>  arch/arm/mm/Kconfig                              |   2 +-
>  drivers/irqchip/irq-gic.c                        |   1 +
>  8 files changed, 463 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/arm-realview-pb1176.dts
>  create mode 100644 arch/arm/mach-realview/realview-dt.c
>
> diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
> index 3509707f9320..22af7ccacb52 100644
> --- a/Documentation/devicetree/bindings/arm/arm-boards
> +++ b/Documentation/devicetree/bindings/arm/arm-boards
> @@ -86,3 +86,56 @@ Interrupt controllers:
>         compatible = "arm,versatile-sic";
>         interrupt-controller;
>         #interrupt-cells = <1>;
> +
> +
> +ARM RealView Boards
> +-------------------
> +The RealView boards cover tailored evaluation boards that are used to explore
> +the ARM11 and Cortex A-8 and Cortex A-9 processors.
> +
> +Required properties (in root node):
> +       /* RealView Emulation Baseboard */
> +       compatible = "arm,realview-eb";
> +        /* RealView Platform Baseboard for ARM1176JZF-S */
> +       compatible = "arm,realview-pb1176";
> +       /* RealView Platform Baseboard for ARM11 MPCore */
> +       compatible = "arm,realview-pb11mp";
> +       /* RealView Platform Baseboard for Cortex A-8 */
> +       compatible = "arm,realview-pba8";
> +       /* RealView Platform Baseboard Explore for Cortex A-9 */
> +       compatible = "arm,realview-pbx";
> +
> +Required nodes:
> +
> +- syscon: the root node of the Integrator platforms must have a

It should not be the root node, but under some bus node. It seems the
example and actual dts's are correct.

> +  system controller node pointing to the control registers,
> +  with the compatible string
> +  "arm,realview-syscon", "syscon"

As Arnd pointed out, this needs to be more specific. Versatile
probably needs this too, right? I've left it hard coded so far.

> +
> +  Required properties for the system controller:
> +  - regs: the location and size of the system controller registers,
> +    one range of 0x1000 bytes.
> +
> +Example:
> +
> +/dts-v1/;
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include "skeleton.dtsi"
> +
> +/ {
> +       model = "ARM RealView PB1176 with device tree";
> +       compatible = "arm,realview-pb1176";
> +
> +       soc {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "simple-bus";
> +               ranges;
> +
> +               syscon: syscon at 10000000 {
> +                       compatible = "arm,realview-syscon", "syscon";
> +                       reg = <0x10000000 0x1000>;
> +               };
> +
> +       };
> +};
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 032030361bef..f568746abf91 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -234,6 +234,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
>         dra7-evm.dtb
>  dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb
>  dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
> +dtb-$(CONFIG_ARCH_REALVIEW) += arm-realview-pb1176.dtb
>  dtb-$(CONFIG_ARCH_U8500) += ste-snowball.dtb \
>         ste-hrefprev60-stuib.dtb \
>         ste-hrefprev60-tvk.dtb \
> diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
> new file mode 100644
> index 000000000000..3703fca68513
> --- /dev/null
> +++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
> @@ -0,0 +1,165 @@
> +/*
> + * Copyright 2014 Linaro Ltd
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:

We really need to start making dts files BSD licensed. GPL does not
make sense really if the dtb is part of the firmware.

> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include "skeleton.dtsi"
> +
> +/ {
> +       model = "ARM RealView PB1176 with device tree";
> +       compatible = "arm,realview-pb1176";
> +
> +       chosen { };
> +
> +       aliases {
> +               serial0 = &pb1176_serial0;
> +               serial1 = &pb1176_serial1;
> +               serial2 = &pb1176_serial2;
> +               serial3 = &pb1176_serial3;
> +       };
> +
> +       memory {
> +               reg = <0x00000000 0x08000000>;
> +       };
> +
> +       soc {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "simple-bus";
> +               ranges;
> +
> +               syscon: syscon at 10000000 {
> +                       compatible = "arm,realview-syscon", "syscon";
> +                       reg = <0x10000000 0x1000>;
> +               };
> +
> +               xtal24mhz: xtal24mhz at 24M {
> +                       #clock-cells = <0>;
> +                       compatible = "fixed-clock";
> +                       clock-frequency = <24000000>;
> +               };
> +
> +               timclk: timclk at 1M {
> +                       #clock-cells = <0>;
> +                       compatible = "fixed-factor-clock";
> +                       clock-div = <24>;
> +                       clock-mult = <1>;
> +                       clocks = <&xtal24mhz>;
> +               };
> +
> +               uartclk: uartclk at 24M {
> +                       #clock-cells = <0>;
> +                       compatible = "fixed-factor-clock";
> +                       clock-div = <1>;
> +                       clock-mult = <1>;
> +                       clocks = <&xtal24mhz>;
> +               };
> +
> +               /* FIXME: this actually hangs off the PLL clocks */
> +               pclk: pclk at 0 {
> +                       #clock-cells = <0>;
> +                       compatible = "fixed-clock";
> +                       clock-frequency = <0>;
> +               };

I would move the clocks out of the soc node.

> +
> +               /* Primary DevChip GIC synthesized with the CPU */
> +               intc_dc1176: interrupt-controller at 10120000 {
> +                       compatible = "arm,arm1176jzf-gic";

This needs to be documented.

> +                       #interrupt-cells = <3>;
> +                       #address-cells = <1>;
> +                       interrupt-controller;
> +                       reg = <0x10121000 0x1000>,
> +                             <0x10120000 0x100>;
> +               };
> +
> +               /* This GIC on the board is cascaded off the DevChip GIC */
> +               intc_pb1176: interrupt-controller at 10040000 {
> +                       compatible = "arm,arm1176jzf-gic";
> +                       #interrupt-cells = <3>;
> +                       #address-cells = <1>;
> +                       interrupt-controller;
> +                       reg = <0x10041000 0x1000>,
> +                             <0x10040000 0x100>;
> +                       interrupt-parent = <&intc_dc1176>;
> +                       interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
> +               };
> +
> +               L2: l2-cache {
> +                       compatible = "arm,l220-cache";
> +                       reg = <0x10110000 0x1000>;
> +                       interrupt-parent = <&intc_dc1176>;
> +                       interrupts = <0 13 IRQ_TYPE_LEVEL_HIGH>;
> +                       cache-unified;
> +                       cache-level = <2>;
> +               };
> +
> +               pmu {
> +                       compatible = "arm,arm1176-pmu";
> +                       interrupt-parent = <&intc_dc1176>;
> +                       interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
> +               };
> +
> +               timer01: timer at 10104000 {
> +                       compatible = "arm,sp804", "arm,primecell";
> +                       reg = <0x10104000 0x1000>;
> +                       interrupt-parent = <&intc_dc1176>;
> +                       interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>, <0 9 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&timclk>, <&timclk>, <&pclk>;
> +                       clock-names = "timclk1", "timclk2", "apb_pclk";
> +               };
> +
> +               timer23: timer at 10105000 {
> +                       compatible = "arm,sp804", "arm,primecell";
> +                       reg = <0x10105000 0x1000>;
> +                       interrupt-parent = <&intc_dc1176>;
> +                       interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
> +                       arm,sp804-has-irq = <1>;
> +                       clocks = <&timclk>, <&timclk>, <&pclk>;
> +                       clock-names = "timclk1", "timclk2", "apb_pclk";
> +               };
> +
> +               pb1176_serial0: uart at 1010c000 {
> +                       compatible = "arm,pl011", "arm,primecell";
> +                       reg = <0x1010c000 0x1000>;
> +                       interrupt-parent = <&intc_dc1176>;
> +                       interrupts = <0 18 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&uartclk>, <&pclk>;
> +                       clock-names = "uartclk", "apb_pclk";
> +               };
> +
> +               pb1176_serial1: uart at 1010d000 {
> +                       compatible = "arm,pl011", "arm,primecell";
> +                       reg = <0x1010d000 0x1000>;
> +                       interrupt-parent = <&intc_dc1176>;
> +                       interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&uartclk>, <&pclk>;
> +                       clock-names = "uartclk", "apb_pclk";
> +               };
> +
> +               pb1176_serial2: uart at 1010e000 {
> +                       compatible = "arm,pl011", "arm,primecell";
> +                       reg = <0x1010e000 0x1000>;
> +                       interrupt-parent = <&intc_dc1176>;
> +                       interrupts = <0 20 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&uartclk>, <&pclk>;
> +                       clock-names = "uartclk", "apb_pclk";
> +               };
> +
> +               pb1176_serial3: uart at 1010f000 {
> +                       compatible = "arm,pl011", "arm,primecell";
> +                       reg = <0x1010f000 0x1000>;
> +                       interrupt-parent = <&intc_dc1176>;
> +                       interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&uartclk>, <&pclk>;
> +                       clock-names = "uartclk", "apb_pclk";
> +               };
> +       };
> +};
> diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
> index 9db2029aa632..2d29649615c7 100644
> --- a/arch/arm/mach-realview/Kconfig
> +++ b/arch/arm/mach-realview/Kconfig
> @@ -1,6 +1,16 @@
>  menu "RealView platform type"
>         depends on ARCH_REALVIEW
>
> +config REALVIEW_DT
> +       bool "Support RealView(R) Device Tree based boot"
> +       select ARM_GIC
> +       select USE_OF
> +       select SOC_BUS
> +       select MFD_SYSCON

Sort.

This will probably need to be coordinated with Arnd's cpu selection rework.

> +       help
> +         Include support for booting the ARM(R) RealView(R) evaluation
> +         boards using a device tree machine description.
> +
>  config MACH_REALVIEW_EB
>         bool "Support RealView(R) Emulation Baseboard"
>         select ARM_GIC
> diff --git a/arch/arm/mach-realview/Makefile b/arch/arm/mach-realview/Makefile
> index 541fa4c109ef..e07fdf7ae8a7 100644
> --- a/arch/arm/mach-realview/Makefile
> +++ b/arch/arm/mach-realview/Makefile
> @@ -3,6 +3,7 @@
>  #
>
>  obj-y                                  := core.o
> +obj-$(CONFIG_REALVIEW_DT)              += realview-dt.o
>  obj-$(CONFIG_MACH_REALVIEW_EB)         += realview_eb.o
>  obj-$(CONFIG_MACH_REALVIEW_PB11MP)     += realview_pb11mp.o
>  obj-$(CONFIG_MACH_REALVIEW_PB1176)     += realview_pb1176.o
> diff --git a/arch/arm/mach-realview/realview-dt.c b/arch/arm/mach-realview/realview-dt.c
> new file mode 100644
> index 000000000000..1b6f4703922c
> --- /dev/null
> +++ b/arch/arm/mach-realview/realview-dt.c
> @@ -0,0 +1,231 @@
> +/*
> + * Copyright (C) 2014 Linaro Ltd.
> + *
> + * Author: Linus Walleij <linus.walleij@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2, as
> + * published by the Free Software Foundation.
> + *
> + */
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/arm-gic.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/sys_soc.h>
> +#include <linux/slab.h>
> +#include <asm/mach/map.h>
> +#include <asm/mach/arch.h>
> +#include <asm/hardware/cache-l2x0.h>
> +#include <mach/hardware.h>
> +#include <mach/platform.h>
> +#include <mach/board-eb.h>
> +#include <mach/board-pb1176.h>
> +#include <mach/board-pb11mp.h>
> +#include <mach/board-pbx.h>
> +#include "core.h"
> +
> +/* Pointer to the system controller */
> +struct regmap *syscon_regmap;
> +
> +static struct map_desc realview_dt_io_desc[] __initdata = {
> +       {
> +               /* FIXME: static map needed for LED driver */
> +               .virtual        = IO_ADDRESS(REALVIEW_SYS_BASE),
> +               .pfn            = __phys_to_pfn(REALVIEW_SYS_BASE),
> +               .length         = SZ_4K,
> +               .type           = MT_DEVICE,
> +       },
> +};
> +
> +static void __init realview_dt_map_io(void)
> +{
> +       iotable_init(realview_dt_io_desc, ARRAY_SIZE(realview_dt_io_desc));
> +}
> +
> +static const struct of_device_id realview_syscon_match[] = {
> +       { .compatible = "arm,realview-syscon"},
> +       { },
> +};
> +
> +static void __init realview_dt_init_machine(void)
> +{
> +       struct device_node *root;
> +       struct device_node *syscon;
> +       struct soc_device *soc_dev;
> +       struct soc_device_attribute *soc_dev_attr;
> +       struct device *parent;
> +       u32 coreid;
> +       int ret;
> +
> +#ifdef CONFIG_CACHE_L2X0

Use IS_ENABLED

> +       if (of_machine_is_compatible("arm,realview-eb"))
> +               /*
> +                * 1MB (128KB/way), 8-way associativity,
> +                * evmon/parity/share enabled
> +                * Bits:  .... ...0 0111 1001 0000 .... .... ....
> +                */
> +               l2x0_of_init(0x00790000, 0xfe000fff);
> +       else if (of_machine_is_compatible("arm,realview-pb1176"))
> +               /*
> +                * 128Kb (16Kb/way) 8-way associativity.
> +                * evmon/parity/share enabled.
> +                */
> +               l2x0_of_init(0x00730000, 0xfe000fff);
> +       else if (of_machine_is_compatible("arm,realview-pb11mp"))
> +               /*
> +                * 1MB (128KB/way), 8-way associativity,
> +                * evmon/parity/share enabled
> +                * Bits:  .... ...0 0111 1001 0000 .... .... ....
> +                */
> +               l2x0_of_init(0x00730000, 0xfe000fff);
> +       else if (of_machine_is_compatible("arm,realview-pbx"))
> +               /*
> +                * 16KB way size, 8-way associativity, parity disabled
> +                * Bits:  .. 0 0 0 0 1 00 1 0 1 001 0 000 0 .... .... ....
> +                */
> +               l2x0_of_init(0x02520000, 0xc0000fff);
> +#endif

As Arnd pointed out, see Russell's recent L2x0 emails. Since these are
L220s, you do need the way size and associativity to be initialized at
least. There are standard ePAPR definitions for these which should be
used.

Documenting the initial and final aux ctrl values on these platforms
would be helpful for Russell's clean-up.

[snip]

> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 1f8fed94c2a4..3a9266b27d1f 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -929,7 +929,7 @@ config ARM_L1_CACHE_SHIFT
>  config ARM_DMA_MEM_BUFFERABLE
>         bool "Use non-cacheable memory for DMA" if (CPU_V6 || CPU_V6K) && !CPU_V7
>         depends on !(MACH_REALVIEW_PB1176 || REALVIEW_EB_ARM11MP || \
> -                    MACH_REALVIEW_PB11MP)
> +                    MACH_REALVIEW_PB11MP || REALVIEW_DT)

Couldn't this be simplified to: depends on !(ARCH_REALVIEW && (CPU_V6
|| CPU_V6K))

However, we probably will want some way to build a v6+v7
multi-platform kernel and select this option. Perhaps we need a
kconfig option for "support broken v6 Realview platforms."

Rob
