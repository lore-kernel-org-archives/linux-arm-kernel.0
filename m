From: varada@codeaurora.org (Varadarajan Narayanan)
Date: Mon, 24 Aug 2015 13:53:39 +0530
Subject: [PATCH v2] qcom: ipq40xx: Add basic board/dts support for
 IPQ40XX SoC
In-Reply-To: <20150821162133.GF13472@usrtlx11787.corpusers.net>
References: <20150821103253.GA27466@codeaurora.org>
 <20150821162133.GF13472@usrtlx11787.corpusers.net>
Message-ID: <20150824082339.GA329@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 21, 2015 at 09:21:33AM -0700, Bjorn Andersson wrote:

> On Fri 21 Aug 03:32 PDT 2015, Varadarajan Narayanan wrote:
>
> > Add initial dts files and SoC support for IPQ40XX
> >
> > Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> > ---
> > Changes in v2:
> >   - Added devicetree bindings documentation
> >
> >  .../devicetree/bindings/clock/qca,gcnt.txt         | 14 ++++
> >  Documentation/devicetree/bindings/ipq.txt          | 16 ++++
> >  arch/arm/boot/dts/Makefile                         |  3 +-
> >  arch/arm/boot/dts/qcom-ipq40xx-r3pc.dts            | 33 +++++++++
> >  arch/arm/boot/dts/qcom-ipq40xx.dtsi                | 86 ++++++++++++++++++++++
> >  arch/arm/configs/ipq_defconfig                     |  1 +
> >  arch/arm/mach-qcom/Kconfig                         |  4 +
> >  arch/arm/mach-qcom/board.c                         |  1 +
> >  8 files changed, 157 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/clock/qca,gcnt.txt
> >  create mode 100644 Documentation/devicetree/bindings/ipq.txt
> >  create mode 100644 arch/arm/boot/dts/qcom-ipq40xx-r3pc.dts
> >  create mode 100644 arch/arm/boot/dts/qcom-ipq40xx.dtsi
> >
> > diff --git a/Documentation/devicetree/bindings/clock/qca,gcnt.txt b/Documentation/devicetree/bindings/clock/qca,gcnt.txt
> > new file mode 100644
> > index 0000000..dd0d71e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/qca,gcnt.txt
> > @@ -0,0 +1,14 @@
> > +QCA Global Counter
>
> I don't think I've seen the "global counter" blocks before, what is it?
> What does it do? Do you have a upcoming driver for it? (Have I just
> missed it?)

It is a 56-bit counter that supplies the count to the ARM arch timers.
An upcoming patch will use it.

> You add it to the dts below, but don't seem to reference it. What is
> its purpose?
>
> Also, you should split this definition into its own patch.

Sure. Will post a revised patch.

> > +------------------------------------------------
> > +
> > +Required properties :
> > +- compatible : "qcom,qca-gcnt"
> > +
> > +- reg : shall contain base register location and length
> > +
> > +Example:
> > +
> > +	counter {
> > +		compatible = "qcom,qca-gcnt";
> > +		reg = <0x004a1000 0x4>;
>
> Most of the time when there's a device consuming one register it turns
> out to be part of some larger hw block and down the road things get
> complicated from the fact that we mapped 4 bytes in the middle.
>
> Is this part of a larger block? Can we better implement that as a
> simple-mfd or syscon?

Sure. Will see if I can re-implement it.

> > +	};
> > diff --git a/Documentation/devicetree/bindings/ipq.txt b/Documentation/devicetree/bindings/ipq.txt
> > new file mode 100644
> > index 0000000..7d56bd0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/ipq.txt
>
> This doesn't really follow the general pattern of this directory. There
> are some files like this, but then you should probably name it
> qualcomm.txt.

Will rename.

> > @@ -0,0 +1,16 @@
> > +Qualcomm IPQ device tree bindings
> > +---------------------------------
> > +
> > +System on Chip
> > +
> > +Device tree must specify which SoC it uses, with one of the
> > +following compatible strings
> > +
> > +       "qcom,ipq40xx"
> > +
> > +Platform
> > +
> > +Device tree must specify which Platform it uses, with one of the
> > +following compatible strings
> > +
> > +       "qcom,ipq40xx-r3pc"
>
> I would expect an "ipq.txt" to contain "qcom,ipq8064-ap148" and
> "qcom,ipq8064" as well.
>
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 246473a..6b4caee 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -477,7 +477,8 @@ dtb-$(CONFIG_ARCH_QCOM) += \
> >  	qcom-ipq8064-ap148.dtb \
> >  	qcom-msm8660-surf.dtb \
> >  	qcom-msm8960-cdp.dtb \
> > -	qcom-msm8974-sony-xperia-honami.dtb
> > +	qcom-msm8974-sony-xperia-honami.dtb \
> > +	qcom-ipq40xx-r3pc.dtb
>
> Please insert your entry alphabetically.

Sure.

> >  dtb-$(CONFIG_ARCH_REALVIEW) += \
> >  	arm-realview-pb1176.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += \
> > diff --git a/arch/arm/boot/dts/qcom-ipq40xx-r3pc.dts b/arch/arm/boot/dts/qcom-ipq40xx-r3pc.dts
> > new file mode 100644
> > index 0000000..7e4e629
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/qcom-ipq40xx-r3pc.dts
> > @@ -0,0 +1,33 @@
> > +/* Copyright (c) 2014, The Linux Foundation. All rights reserved.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 and
> > + * only version 2 as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include "qcom-ipq40xx.dtsi"
> > +
> > +/ {
> > +	model = "Qualcomm Technologies, Inc. IPQ40XX R3PC";
> > +	compatible = "qcom,ipq40xx-r3pc", "qcom,ipq40xx";
> > +
> > +	memory {
> > +		device_type = "memory";
> > +		reg = <0x80000000 0x20000000>; /* 512MB */
> > +	};
> > +
> > +	chosen {
> > +		bootargs = "root=/dev/ram rw init=/init console=ttyMSM0,115200n8 initrd=0x82000000,0x000E2246";
> > +	};
> > +
> > +	soc {
> > +		serial at 78b0000 {
> > +			status = "ok";
> > +		};
> > +	};
> > +};
>
> This part looks good.
>
> > diff --git a/arch/arm/boot/dts/qcom-ipq40xx.dtsi b/arch/arm/boot/dts/qcom-ipq40xx.dtsi
> > new file mode 100644
> > index 0000000..76c55a3
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/qcom-ipq40xx.dtsi
> > @@ -0,0 +1,86 @@
> > +/*
> > + * Copyright (c) 2014, The Linux Foundation. All rights reserved.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 and
> > + * only version 2 as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "skeleton.dtsi"
> > +
> > +/ {
> > +	model = "Qualcomm Technologies, Inc. IPQ40XX";
> > +	compatible = "qcom,ipq40xx";
> > +	interrupt-parent = <&intc>;
> > +
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		cpu at 0 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a7";
> > +			reg = <0x0>;
> > +		};
> > +
> > +		cpu at 1 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a7";
> > +			reg = <0x1>;
> > +		};
> > +
> > +		cpu at 2 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a7";
> > +			reg = <0x2>;
> > +		};
> > +
> > +		cpu at 3 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a7";
> > +			reg = <0x3>;
> > +		};
> > +	};
> > +
> > +	soc {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges;
> > +		compatible = "simple-bus";
> > +
> > +		intc: interrupt-controller at b000000 {
> > +			compatible = "qcom,msm-qgic2";
> > +			interrupt-controller;
> > +			#interrupt-cells = <3>;
> > +			reg = <0x0b000000 0x1000>,
> > +			<0x0b002000 0x1000>;
> > +		};
> > +
> > +		counter {
> > +			compatible = "qcom,qca-gcnt";
> > +			reg = <0x004a1000 0x4>;
> > +		};
> > +
> > +		timer {
> > +			compatible = "arm,armv7-timer";
> > +			interrupts = <1 2 0xf08>,
> > +				     <1 3 0xf08>,
> > +				     <1 4 0xf08>,
> > +				     <1 1 0xf08>;
> > +			clock-frequency = <20833333>;
> > +		};
> > +
> > +		serial at 78b0000 {
> > +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> > +			reg = <0x78b0000 0x200>;
> > +			interrupts = <0 108 0>;
> > +			status = "disabled";
> > +		};
> > +	};
> > +};
>
> Unless the counter has a critical function I suggest you add that
> separately, otherwise this looks good.

Ok

> > diff --git a/arch/arm/configs/ipq_defconfig b/arch/arm/configs/ipq_defconfig
> > index 1cabd8b..054a159 100644
> > --- a/arch/arm/configs/ipq_defconfig
> > +++ b/arch/arm/configs/ipq_defconfig
> > @@ -22,6 +22,7 @@ CONFIG_ARCH_MSM8X60=y
> >  CONFIG_ARCH_MSM8960=y
> >  CONFIG_ARCH_MSM8974=y
> >  CONFIG_ARCH_IPQ8064=y
> > +CONFIG_ARCH_IPQ40XX=y
> >  CONFIG_SMP=y
> >  CONFIG_PREEMPT=y
> >  CONFIG_AEABI=y
> > diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
> > index fab49a2..3add9f9 100644
> > --- a/arch/arm/mach-qcom/Kconfig
> > +++ b/arch/arm/mach-qcom/Kconfig
> > @@ -26,4 +26,8 @@ config ARCH_IPQ8064
> >  	bool "Enable support for IPQ806x"
> >  	select CLKSRC_QCOM
> >
> > +config ARCH_IPQ40XX
> > +	bool "Enable support for IPQ40XX"
> > +	select HAVE_ARM_ARCH_TIMER
> > +
>
> Please insert your entry alphabetically.

Ok.

> >  endif
> > diff --git a/arch/arm/mach-qcom/board.c b/arch/arm/mach-qcom/board.c
> > index 6d8bbf7..566487d 100644
> > --- a/arch/arm/mach-qcom/board.c
> > +++ b/arch/arm/mach-qcom/board.c
> > @@ -22,6 +22,7 @@ static const char * const qcom_dt_match[] __initconst = {
> >  	"qcom,ipq8064",
> >  	"qcom,msm8660-surf",
> >  	"qcom,msm8960-cdp",
> > +	"qcom,ipq40xx-r3pc",
>
> Please add qcom,ipq40xx instead, so that we don't need to list every
> single device.
>
> Also, please keep the list alphabetically sorted.

Ok.

> >  	NULL
> >  };
>
> Regards,
> Bjorn

Thanks for your feedback Bjorn. Will re-work and post the patches.
Varada
