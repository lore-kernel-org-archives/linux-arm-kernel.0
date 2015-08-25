From: jogo@openwrt.org (Jonas Gorski)
Date: Tue, 25 Aug 2015 16:50:05 +0200
Subject: [PATCH v4] qcom: ipq4019: Add basic board/dts support for IPQ4019
 SoC
In-Reply-To: <20150825120804.GA30996@codeaurora.org>
References: <20150825120804.GA30996@codeaurora.org>
Message-ID: <CAOiHx=kz1voQXre2tkNC2bZo6fqq0L81+V9VeZadKhjR0nDNww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 25, 2015 at 2:08 PM, Varadarajan Narayanan
<varada@codeaurora.org> wrote:
> Add initial dts files and SoC support for IPQ4019
>
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---
> Changes in v2:
>   - Added devicetree bindings documentation
>
> Changes in v3:
>   - Split 'gcnt' into a separate patch
>   - Added the new entries to Makefiles, Kconfig & board.c in sorted order
>   - Used "qcom,ipq40xx" instead of "qcom,ipq40xx-r3pc" in board.c
>
> Changes in v4:
>   - Renamed IPQ40xx as IPQ4019
>   - Moved kconfig and defconfig enablement to separate patch
>   - Dropped Documentation/devicetree/bindings/qcom.txt
>
>  arch/arm/boot/dts/Makefile              |  1 +
>  arch/arm/boot/dts/qcom-ipq4019-r3pc.dts | 34 ++++++++++++++
>  arch/arm/boot/dts/qcom-ipq4019.dtsi     | 81 +++++++++++++++++++++++++++++++++
>  3 files changed, 116 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-ipq4019-r3pc.dts
>  create mode 100644 arch/arm/boot/dts/qcom-ipq4019.dtsi
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 246473a..ca603f3 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -474,6 +474,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>         qcom-apq8074-dragonboard.dtb \
>         qcom-apq8084-ifc6540.dtb \
>         qcom-apq8084-mtp.dtb \
> +       qcom-ipq4019-r3pc.dtb \
>         qcom-ipq8064-ap148.dtb \
>         qcom-msm8660-surf.dtb \
>         qcom-msm8960-cdp.dtb \
> diff --git a/arch/arm/boot/dts/qcom-ipq4019-r3pc.dts b/arch/arm/boot/dts/qcom-ipq4019-r3pc.dts
> new file mode 100644
> index 0000000..e3855d7
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-ipq4019-r3pc.dts
> @@ -0,0 +1,34 @@
> +/* Copyright (c) 2014, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include "qcom-ipq4019.dtsi"
> +
> +/ {
> +       model = "Qualcomm Technologies, Inc. IPQ4019 R3PC";
> +       compatible = "qcom,ipq4019-r3pc", "qcom,ipq4019";
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <0x80000000 0x20000000>; /* 512MB */
> +       };
> +
> +       chosen {
> +               bootargs = "root=/dev/ram rw init=/init initrd=0x82000000,0x000E2246";
> +               stdout-path = "/serial at 78b0000:115200";

I suggest adding an alias to the serial node, so you can just use the
alias name instead of the path (also I never tried using an actual
path, but wouldn't it be "/soc/serial at 78b0000"?).

> +       };
> +
> +       soc {
> +               serial at 78b0000 {
> +                       status = "ok";
> +               };
> +       };
> +};
> diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> new file mode 100644
> index 0000000..1be0322
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> @@ -0,0 +1,81 @@
> +/*
> + * Copyright (c) 2014, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +/dts-v1/;
> +
> +#include "skeleton.dtsi"
> +
> +/ {
> +       model = "Qualcomm Technologies, Inc. IPQ4019";
> +       compatible = "qcom,ipq4019";
> +       interrupt-parent = <&intc>;
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               cpu at 0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0x0>;
> +               };
> +
> +               cpu at 1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0x1>;
> +               };
> +
> +               cpu at 2 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0x2>;
> +               };
> +
> +               cpu at 3 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0x3>;
> +               };
> +       };
> +
> +       soc {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +               compatible = "simple-bus";
> +
> +               intc: interrupt-controller at b000000 {
> +                       compatible = "qcom,msm-qgic2";
> +                       interrupt-controller;
> +                       #interrupt-cells = <3>;
> +                       reg = <0x0b000000 0x1000>,
> +                       <0x0b002000 0x1000>;
> +               };
> +
> +               serial at 78b0000 {
> +                       compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +                       reg = <0x78b0000 0x200>;
> +                       interrupts = <0 108 0>;
> +                       status = "disabled";
> +               };

I think it's nice to have the nodes ordered by their (first) registers
address, so maybe consider doing that. This makes it also clear where
new blocks should be added, and if several people try to add blocks
the chance of conflicts is reduced.

> +       };
> +
> +       timer {
> +               compatible = "arm,armv7-timer";
> +               interrupts = <1 2 0xf08>,
> +                            <1 3 0xf08>,
> +                            <1 4 0xf08>,
> +                            <1 1 0xf08>;
> +               clock-frequency = <20833333>;

Assuming ipq4019 is the name of the emulated chip and not a special id
for the emulator, and "IPQ4019 R3PC" is the dts file for the emulator,
you could set the clock-frequency in the board dts instead of forcing
every "real chip" board dts to overwrite/clear it.

> +       };
> +};
> --

regards
Jonas
