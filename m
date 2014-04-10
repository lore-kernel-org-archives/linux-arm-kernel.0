From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 10 Apr 2014 10:09:02 +0100
Subject: [PATCH v2 08/12] ARM: dts: add hip04-d01 dts file
In-Reply-To: <1396944052-9887-9-git-send-email-haojian.zhuang@linaro.org>
References: <1396944052-9887-1-git-send-email-haojian.zhuang@linaro.org>
 <1396944052-9887-9-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140410090902.GD22639@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 09:00:48AM +0100, Haojian Zhuang wrote:
> Add hip04.dtsi & hip04-d01.dts file to support HiP04 SoC platform.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/gic.txt      |   1 +
>  .../bindings/arm/hisilicon/hisilicon.txt           |  12 ++
>  .../devicetree/bindings/clock/hip04-clock.txt      |  20 ++
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/hip04-d01.dts                    |  74 +++++++
>  arch/arm/boot/dts/hip04.dtsi                       | 240 +++++++++++++++++++++
>  6 files changed, 348 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/hip04-clock.txt
>  create mode 100644 arch/arm/boot/dts/hip04-d01.dts
>  create mode 100644 arch/arm/boot/dts/hip04.dtsi
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
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> index df0a452..47c0a13 100644
> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> @@ -4,6 +4,10 @@ Hisilicon Platforms Device Tree Bindings
>  Hi4511 Board
>  Required root node properties:
>         - compatible = "hisilicon,hi3620-hi4511";
> +HiP04 D01 Board
> +Required root node properties:
> +       - compatible = "hisilicon,hip04-d01";
> +
> 
>  Hisilicon system controller
> 
> @@ -31,6 +35,14 @@ Example:
>                 reboot-offset = <0x4>;
>         };
> 
> +
> +Hisilicon MCPM Implementation

This is _NOT_ a hardware or system property. It is a Linux
implementation detail. This does not belong here as-is.

> +
> +Required Properties:
> +- compatible: "hisilicon,hip04-mcpm"
> +- reg: Register address and size.
> +
> +

The code was looking for several entries in the reg, and you don't
describe what any of them are.

> diff --git a/Documentation/devicetree/bindings/clock/hip04-clock.txt b/Documentation/devicetree/bindings/clock/hip04-clock.txt
> new file mode 100644
> index 0000000..4d31ae3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/hip04-clock.txt
> @@ -0,0 +1,20 @@
> +* Hisilicon HiP04 Clock Controller
> +
> +The HiP04 clock controller generates and supplies clock to various
> +controllers within the HiP04 SoC.
> +
> +Required Properties:
> +
> +- compatible: should be one of the following.
> +  - "hisilicon,hip04-clock" - controller compatible with HiP04 SoC.
> +
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +
> +- #clock-cells: should be 1.
> +
> +
> +Each clock is assigned an identifier and client nodes use this identifier
> +to specify the clock which they consume.

Delete this sentence -- that's a well understood facet of the clock
bindings.

What does the single clock cell represent? Is it a simple linear index?
Is it sparse? Are there a set of well-known IDs?

> +
> +All these identifier could be found in <dt-bindings/clock/hip04-clock.h>.

I'm really not a fan of dt includes, but I understand that others are.
Please move this sentence into the #clock-cells description to make it
clearer.

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

I would expect commented /memreserve/ statements here.

> +       memory at 0 {

This memory doesn't start at 0, as your comment below explains. The
unit-address (the bit after the '@') should math the address cells of
the first reg entry.

> +               device_type = "memory";
> +               /*
> +                * Bootloader loads kernel image into 0x1000_0000 region,
> +                * so disables the region between [0000_0000 - 1000_0000]
> +                * temporarily.

How does it "disable" this region, and why?

> +                * Because the PHYS_TO_VIRT_OFFSET is calculated based on
> +                * the original region that kenrel is loaded.
> +                * This workaround will be removed only after UEFI updated.

What problem exactly does this work around?

> +                */
> +               reg = <0x00000000 0x10000000 0xc0000000>;
> +       };
> +
> +       memory at 00000004c0000000 {

Nit: Place a comma between 32-bit wide entries in the unit-address for
clarity, e.g. memory at 00000004,c0000000

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

Please fold these into a single memory node with multiple reg entries.
Is there a good reason to keep these separate that I'm not aware of?

> +
> +       soc {
> +               uart0: uart at 4007000 {
> +                       status = "ok";
> +               };
> +       };
> +};
> diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
> new file mode 100644
> index 0000000..eb5e5a2
> --- /dev/null
> +++ b/arch/arm/boot/dts/hip04.dtsi
> @@ -0,0 +1,240 @@
> +/*
> + * Hisilicon Ltd. HiP01 SoC
> + *
> + * Copyright (C) 2013-2014 Hisilicon Ltd.
> + * Copyright (C) 2013-2014 Linaro Ltd.
> + *
> + * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * publishhed by the Free Software Foundation.
> + */
> +
> +#include <dt-bindings/clock/hip04-clock.h>
> +
> +/ {
> +       /* memory bus is 64-bit */
> +       #address-cells = <2>;
> +       #size-cells = <1>;

[...]

> +               CPU3: cpu at 3 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a15";
> +                       reg = <3>;
> +               };
> +               CPU4: cpu at 100 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a15";
> +                       reg = <0x100>;
> +                       clock-frequency = <1350000000>;

Why is there a clock-frequency property in some CPU nodes but not
others? Please be consistent.

[...]

> +       soc {
> +               /* It's a 32-bit SoC. */
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "arm,amba-bus", "simple-bus";

You don't need both here. Either this is an AMBA bus or another MMIO
bus, please choose. Existing dts are misleading in having both.

> +               device_type = "soc";

This is completely unnecessary.

> +               interrupt-parent = <&gic>;
> +               ranges = <0 0 0xe0000000 0x10000000>;
> +
> +               gic: interrupt-controller at c01000 {
> +                       compatible = "hisilicon,hip04-gic";
> +                       #interrupt-cells = <3>;
> +                       #address-cells = <0>;
> +                       interrupt-controller;
> +
> +                       /* gic dist base, gic cpu base */
> +                       reg = <0xc01000 0x1000>, <0xc02000 0x1000>;

No GICH or GICV?

> +               };
> +
> +               mcpm: mcpm {
> +                       compatible = "hisilicon,hip04-mcpm";
> +                       reg = <0x100 0x1000>, <0x3e00000 0x00100000>,
> +                             <0x302a000 0x1000>;
> +               };

As mentioned elsewhere, this is meaningless. Please come up with a
better name and/or split this into the actual components.

> +
> +               clock: clock {
> +                       compatible = "hisilicon,hip04-clock";
> +                       /* FIXME: the base of clock controller */
> +                       reg = <0 0x1000>;
> +                       #clock-cells = <1>;
> +               };

Fix this or get rid of it.

Cheers,
Mark.
