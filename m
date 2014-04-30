From: robherring2@gmail.com (Rob Herring)
Date: Wed, 30 Apr 2014 01:51:09 -0500
Subject: [PATCH v4 09/14] ARM: dts: add hip04-d01 dts file
In-Reply-To: <1398668032-8335-10-git-send-email-haojian.zhuang@linaro.org>
References: <1398668032-8335-1-git-send-email-haojian.zhuang@linaro.org>
 <1398668032-8335-10-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CAL_JsqLZmfaG8LB--5aiLieAx54F5TeQ2S-BEAAZTv7+RZcJTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 1:53 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:
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
> index df0a452..4681f15 100644
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
> @@ -19,6 +23,11 @@ Optional properties:
>                 If reg value is not zero, cpun exit wfi and go
>  - resume-offset : offset in sysctrl for notifying cpu0 when resume
>  - reboot-offset : offset in sysctrl for system reboot
> +- relocation-entry : relocation address of secondary cpu boot code
> +- relocation-size : relocation size of secondary cpu boot code
> +- bootwrapper-phys : physical address of boot wrapper
> +- bootwrapper-size : size of boot wrapper
> +- bootwrapper-magic : magic number for secondary cpu in boot wrapper

These need better descriptions.

Can bootwrapper just use /memreserve/?

>
>  Example:
>
> @@ -31,6 +40,7 @@ Example:
>                 reboot-offset = <0x4>;
>         };
>
> +
>  PCTRL: Peripheral misc control register
>
>  Required Properties:
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
> +
> +All these identifier could be found in <dt-bindings/clock/hip04-clock.h>.
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 35c146f..7119bca 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -80,6 +80,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
>  dtb-$(CONFIG_ARCH_HI3xxx) += hi3620-hi4511.dtb
>  dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
>         ecx-2000.dtb
> +dtb-$(CONFIG_ARCH_HIP04) += hip04-d01.dtb
>  dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
>         integratorcp.dtb
>  dtb-$(CONFIG_ARCH_KEYSTONE) += k2hk-evm.dtb \
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
> +               device_type = "memory";
> +               /*
> +                * Bootloader loads kernel image into 0x1000_0000 region,
> +                * so disables the region between [0000_0000 - 1000_0000]
> +                * temporarily.
> +                * Because the PHYS_TO_VIRT_OFFSET is calculated based on
> +                * the original region that kenrel is loaded.
> +                * This workaround will be removed only after UEFI updated.
> +                */
> +               reg = <0x00000000 0x10000000 0xc0000000>;
> +       };
> +
> +       memory at 00000004c0000000 {
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

Am I missing something or isn't this just a single region of:
<0x4 0xc0000000 0x3 0x40000000>

[...]

> +       soc {
> +               /* It's a 32-bit SoC. */
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "arm,amba-bus", "simple-bus";

Drop arm,amba-bus.

> +               device_type = "soc";

Huh? remove.

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
> +                       reg = <0xc01000 0x1000>, <0xc02000 0x1000>,
> +                             <0xc04000 0x2000>, <0xc06000 0x2000>;
> +               };
> +
> +               sysctrl: sysctrl {
> +                       compatible = "hisilicon,sysctrl";
> +                       reg = <0x3e00000 0x00100000>;
> +                       relocation-entry = <0xe0000100>;
> +                       relocation-size = <0x1000>;
> +                       bootwrapper-phys = <0x10c00000>;
> +                       bootwrapper-size = <0x10000>;
> +                       bootwrapper-magic = <0xa5a5a5a5>;
> +               };
> +
> +               fabric: fabric {
> +                       compatible = "hisilicon,hip04-fabric";

documentation?

> +                       reg = <0x302a000 0x1000>;
> +               };
> +
> +               clock: clock {
> +                       compatible = "hisilicon,hip04-clock";
> +                       /* dummy register */

What does that mean? Please fill in valid information.

> +                       reg = <0 0x1000>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               dual_timer0: dual_timer at 3000000 {
> +                       compatible = "arm,sp804", "arm,primecell";
> +                       reg = <0x3000000 0x1000>;
> +                       interrupts = <0 224 4>;
> +                       clocks = <&clock HIP04_CLK_50M>;
> +                       clock-names = "apb_pclk";
> +                       status = "ok";

Not needed.

> +               };
> +
> +               timer {
> +                       compatible = "arm,armv7-timer";
> +                       interrupts = <1 13 0xf08>,
> +                                    <1 14 0xf08>,
> +                                    <1 11 0xf08>,
> +                                    <1 10 0xf08>;
> +               };
> +
> +               uart0: uart at 4007000 {
> +                       compatible = "snps,dw-apb-uart";
> +                       reg = <0x4007000 0x1000>;
> +                       interrupts = <0 381 4>;
> +                       clocks = <&clock HIP04_CLK_168M>;
> +                       clock-names = "uartclk";
> +                       reg-shift = <2>;
> +                       status = "disabled";
> +               };
> +       };
> +};
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
