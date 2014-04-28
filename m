From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 28 Apr 2014 18:13:35 +0100
Subject: [PATCH v4 09/14] ARM: dts: add hip04-d01 dts file
In-Reply-To: <1398668032-8335-10-git-send-email-haojian.zhuang@linaro.org>
References: <1398668032-8335-1-git-send-email-haojian.zhuang@linaro.org>
 <1398668032-8335-10-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140428171334.GA3169@flaeskesteg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 28, 2014 at 07:53:47AM +0100, Haojian Zhuang wrote:
> Add hip04.dtsi & hip04-d01.dts file to support HiP04 SoC platform.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/gic.txt      |   1 +
>  .../bindings/arm/hisilicon/hisilicon.txt           |  10 +
>  .../devicetree/bindings/clock/hip04-clock.txt      |  20 ++
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/hip04-d01.dts                    |  74 +++++++
>  arch/arm/boot/dts/hip04.dtsi                       | 239 +++++++++++++++++++++
>  6 files changed, 345 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/hip04-clock.txt
>  create mode 100644 arch/arm/boot/dts/hip04-d01.dts
>  create mode 100644 arch/arm/boot/dts/hip04.dtsi

I would appreciate if you could split the binding and the DTS updates. The
binding updates would be better associated with the code which implements
support for them.

>
> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
> index 5573c08..150f7d6 100644
> --- a/Documentation/devicetree/bindings/arm/gic.txt
> +++ b/Documentation/devicetree/bindings/arm/gic.txt
> @@ -16,6 +16,7 @@ Main node required properties:
>         "arm,cortex-a9-gic"
>         "arm,cortex-a7-gic"
>         "arm,arm11mp-gic"
> +       "hisilicon,hip04-gic"
>  - interrupt-controller : Identifies the node as an interrupt controller
>  - #interrupt-cells : Specifies the number of cells needed to encode an
>    interrupt source.  The type shall be a <u32> and the value shall be 3.

This looks ok, but would be better associated with the GIC driver update.

[...]

> diff --git a/arch/arm/boot/dts/hip04-d01.dts b/arch/arm/boot/dts/hip04-d01.dts
> new file mode 100644
> index 0000000..a10dcf3
> --- /dev/null
> +++ b/arch/arm/boot/dts/hip04-d01.dts
> @@ -0,0 +1,74 @@
> +/*
> + *  Copyright (C) 2013-2014 Linaro Ltd.
> + *  Author: Haojian Zhuang <haojian.zhuang@linaro.org>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  publishhed by the Free Software Foundation.
> + */
> +
> +/dts-v1/;
> +
> +#include "hip04.dtsi"
> +
> +/ {
> +       /* memory bus is 64-bit */
> +       #address-cells = <2>;
> +       #size-cells = <1>;
> +       model = "Hisilicon D01 Development Board";
> +       compatible = "hisilicon,hip04-d01";
> +
> +       memory at 0 {

This should be memory at 0,10000000 given the reg entry.

Please read my comments I posted back at v2 [1] regarding the dt, as far as I
can see they all still apply. I've repeated a few below, but please refer to my
original mail.

> +               device_type = "memory";
> +               /*
> +                * Bootloader loads kernel image into 0x1000_0000 region,
> +                * so disables the region between [0000_0000 - 1000_0000]
> +                * temporarily.
> +                * Because the PHYS_TO_VIRT_OFFSET is calculated based on
> +                * the original region that kenrel is loaded.
> +                * This workaround will be removed only after UEFI updated.
> +                */

Is it necessary to lie to the kernel here?

If this inaccessible memory causes an issue it sounds like a generic problem we
should be able to solve without lying to the kernel about the physical memory.

> +               reg = <0x00000000 0x10000000 0xc0000000>;
> +       };
> +
> +       memory at 00000004c0000000 {

Please place a comma between cells in unit-addresses, it makes them easer to
read (e.g. this should be memory at 00000004,c0000000).

> +               device_type = "memory";
> +               reg = <0x00000004 0xc0000000 0x40000000>;
> +       };
> +
> +       memory at 0000000500000000 {
> +               device_type = "memory";
> +               reg = <0x00000005 0x00000000 0x80000000>;
> +       };
> +
> +       memory at 0000000580000000 {
> +               device_type = "memory";
> +               reg = <0x00000005 0x80000000 0x80000000>;
> +       };
> +
> +       memory at 0000000600000000 {
> +               device_type = "memory";
> +               reg = <0x00000006 0x00000000 0x80000000>;
> +       };
> +
> +       memory at 0000000680000000 {
> +               device_type = "memory";
> +               reg = <0x00000006 0x80000000 0x80000000>;
> +       };
> +
> +       memory at 0000000700000000 {
> +               device_type = "memory";
> +               reg = <0x00000007 0x00000000 0x80000000>;
> +       };
> +
> +       memory at 0000000780000000 {
> +               device_type = "memory";
> +               reg = <0x00000007 0x80000000 0x80000000>;
> +       };

Is there any reason for describing these in separate nodes? You can place
multiple reg entries in a memory node.

[...]

> +       soc {
> +               /* It's a 32-bit SoC. */
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "arm,amba-bus", "simple-bus";

This should be one either an AMBA bus or a simple bus, not both.

> +               device_type = "soc";
> +               interrupt-parent = <&gic>;
> +               ranges = <0 0 0xe0000000 0x10000000>;
> +
> +               gic: interrupt-controller at c01000 {
> +                       compatible = "hisilicon,hip04-gic";
> +                       #interrupt-cells = <3>;
> +                       #address-cells = <0>;
> +                       interrupt-controller;
> +                       interrupts = <1 9 0xf04>;
> +
> +                       /* gic dist base, gic cpu base */

And hyp and virt, as there seem to be 4 entries?

> +                       reg = <0xc01000 0x1000>, <0xc02000 0x1000>,
> +                             <0xc04000 0x2000>, <0xc06000 0x2000>;
> +               };

[...]

> +               clock: clock {
> +                       compatible = "hisilicon,hip04-clock";
> +                       /* dummy register */
> +                       reg = <0 0x1000>;

Huh?

Cheers,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/246053.html
