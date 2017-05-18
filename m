From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 18 May 2017 07:42:24 +0200 (CEST)
Subject: [PATCH 3/4] dts: imx: add imx7ulp evk support
In-Reply-To: <20170518053532.GB28011@b29396-OptiPlex-7040>
References: <1495036217-20049-1-git-send-email-aisheng.dong@nxp.com>
 <1495036217-20049-4-git-send-email-aisheng.dong@nxp.com>
 <913540926.22766.1495043184702@email.1und1.de>
 <20170518053532.GB28011@b29396-OptiPlex-7040>
Message-ID: <1251059824.564615.1495086144344@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Dong Aisheng <dongas86@gmail.com> hat am 18. Mai 2017 um 07:35 geschrieben:
> 
> 
> On Wed, May 17, 2017 at 07:46:24PM +0200, Stefan Wahren wrote:
> > Hi Dong,
> > 
> > > Dong Aisheng <aisheng.dong@nxp.com> hat am 17. Mai 2017 um 17:50 geschrieben:
> > > 
> > > 
> > > It includes the following support:
> > > 1) CLK
> > > 2) GPIO PTC, PTD, PTE, PTF
> > > 3) uSDHC 1/2
> > > 4) LPUART 4/5/6/7
> > > 5) LPI2C 6/7
> > > 
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > Signed-off-by: Bai Ping <ping.bai@nxp.com>
> > > Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > ---
> > >  arch/arm/boot/dts/Makefile        |   2 +
> > >  arch/arm/boot/dts/imx7ulp-evk.dts |  98 ++++++++++++
> > >  arch/arm/boot/dts/imx7ulp.dtsi    | 310 ++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 410 insertions(+)
> > >  create mode 100644 arch/arm/boot/dts/imx7ulp-evk.dts
> > >  create mode 100644 arch/arm/boot/dts/imx7ulp.dtsi
> > > 
> > > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > > index 0bff8e7..d4bf4fa 100644
> > > --- a/arch/arm/boot/dts/Makefile
> > > +++ b/arch/arm/boot/dts/Makefile
> > > @@ -470,6 +470,8 @@ dtb-$(CONFIG_SOC_IMX7D) += \
> > >  	imx7d-sdb-sht11.dtb \
> > >  	imx7s-colibri-eval-v3.dtb \
> > >  	imx7s-warp.dtb
> > > +dtb-$(CONFIG_SOC_IMX7ULP) += \
> > > +	imx7ulp-evk.dtb
> > >  dtb-$(CONFIG_SOC_LS1021A) += \
> > >  	ls1021a-qds.dtb \
> > >  	ls1021a-twr.dtb
> > > diff --git a/arch/arm/boot/dts/imx7ulp-evk.dts b/arch/arm/boot/dts/imx7ulp-evk.dts
> > > new file mode 100644
> > > index 0000000..ec8790d
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/imx7ulp-evk.dts
> > > @@ -0,0 +1,98 @@
> > > +/*
> > > + * Copyright 2016 Freescale Semiconductor, Inc.
> > > + * Copyright 2017 NXP
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License version 2 as
> > > + * published by the Free Software Foundation.
> > > + */
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include "imx7ulp.dtsi"
> > > +
> > > +/ {
> > > +	model = "NXP i.MX7ULP EVK";
> > > +	compatible = "fsl,imx7ulp-evk", "fsl,imx7ulp", "Generic DT based system";
> > > +
> > > +	chosen {
> > > +		stdout-path = &lpuart4;
> > > +	};
> > > +
> > > +	memory {
> > > +		reg = <0x60000000 0x40000000>;
> > > +	};
> > > +
> > > +	reg_vsd_3v3: regulator-vsd-3v3 {
> > > +		compatible = "regulator-fixed";
> > > +		regulator-name = "VSD_3V3";
> > > +		regulator-min-microvolt = <3300000>;
> > > +		regulator-max-microvolt = <3300000>;
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&pinctrl_usdhc0_rst>;
> > > +		gpio = <&gpio_ptd 0 GPIO_ACTIVE_HIGH>;
> > > +		enable-active-high;
> > > +	};
> > > +};
> > > +
> > > +&lpuart4 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&pinctrl_lpuart4>;
> > > +	status = "okay";
> > > +};
> > > +
> > > +&usdhc0 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&pinctrl_usdhc0_cmd_data>, <&pinctrl_usdhc0_clk>,
> > > +		    <&pinctrl_usdhc0_cd>;
> > > +	cd-gpios = <&gpio_ptc 10 GPIO_ACTIVE_LOW>;
> > > +	vmmc-supply = <&reg_vsd_3v3>;
> > > +	status = "okay";
> > > +};
> > > +
> > > +&iomuxc1 {
> > > +	pinctrl_lpuart4: lpuart4grp {
> > > +		pins = <
> > > +			ULP1_PAD_PTC3__LPUART4_RX
> > > +			ULP1_PAD_PTC2__LPUART4_TX
> > > +		>;
> > > +		bias-pull-up;
> > > +	};
> > > +
> > > +	pinctrl_usdhc0_cmd_data: usdhc0_cmd_data_0_3_grp {
> > > +		pins = <
> > > +			ULP1_PAD_PTD1__SDHC0_CMD
> > > +			ULP1_PAD_PTD2__SDHC0_CLK
> > > +			ULP1_PAD_PTD7__SDHC0_D3
> > > +			ULP1_PAD_PTD8__SDHC0_D2
> > > +			ULP1_PAD_PTD9__SDHC0_D1
> > > +			ULP1_PAD_PTD10__SDHC0_D0
> > > +		>;
> > > +		drive-strength = <1>;
> > > +		bias-pull-up;
> > > +	};
> > > +
> > > +	pinctrl_usdhc0_clk: usdhc0_clk_grp {
> > > +		pins = <
> > > +			ULP1_PAD_PTD2__SDHC0_CLK
> > > +		>;
> > > +		drive-strength = <1>;
> > > +		bias-pull-down;
> > > +	};
> > > +
> > > +	pinctrl_usdhc0_cd: usdhc0_gpios_cd_grp {
> > > +		pins = <
> > > +			ULP1_PAD_PTC10__PTC10		/* USDHC0 CD */
> > > +		>;
> > > +		nxp,input-buffer-enable;
> > > +		bias-pull-up;
> > > +	};
> > > +
> > > +	pinctrl_usdhc0_rst: usdhc0_gpios_rst_grp {
> > > +		pins = <
> > > +			ULP1_PAD_PTD0__PTD0		/* USDHC0 RST */
> > > +		>;
> > > +		nxp,output-buffer-enable;
> > > +		bias-pull-up;
> > > +	};
> > > +};
> > > diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
> > > new file mode 100644
> > > index 0000000..514e063
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/imx7ulp.dtsi
> > > @@ -0,0 +1,310 @@
> > > +/*
> > > + * Copyright 2016 Freescale Semiconductor, Inc
> > > + * Copyright 2017 NXP
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License version 2 as
> > > + * published by the Free Software Foundation.
> > > + */
> > > +
> > > +#include <dt-bindings/clock/imx7ulp-clock.h>
> > > +#include <dt-bindings/gpio/gpio.h>
> > > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +#include "skeleton.dtsi"
> > 
> > AFAIK this dtsi shouldn't be included from new dts files.
> > 
> 
> Missed it, thanks for reminder.
> 
> > > +
> > > +#include "imx7ulp-pinfunc.h"
> > > +
> > > +/ {
> > > +	interrupt-parent = <&intc>;
> > > +
> > > +	aliases {
> > > +		gpio0 = &gpio_ptc;
> > > +		gpio1 = &gpio_ptd;
> > > +		gpio2 = &gpio_pte;
> > > +		gpio3 = &gpio_ptf;
> > > +		i2c0 = &lpi2c6;
> > > +		i2c1 = &lpi2c7;
> > > +		mmc0 = &usdhc0;
> > > +		mmc1 = &usdhc1;
> > > +		serial0 = &lpuart4;
> > > +		serial1 = &lpuart5;
> > > +		serial2 = &lpuart6;
> > > +		serial3 = &lpuart7;
> > > +	};
> > > +
> > > +	cpus {
> > > +		#address-cells = <1>;
> > > +		#size-cells = <0>;
> > > +
> > > +		cpu0: cpu at 0 {
> > > +			compatible = "arm,cortex-a7";
> > > +			device_type = "cpu";
> > > +			reg = <0>;
> > > +		};
> > 
> > I'm not sure, but describing the hardware requires to add the second core.
> > 
> 
> Not quite understand, it looks already fully comply with the standard bindings:
> Documentation/devicetree/bindings/arm/cpus.txt
> 
> Or your mean the following ones?

The dts should describe the hardware. So i think this is missing:

cpu1: cpu at 1 {
        compatible = "arm,cortex-m4";
        device_type = "cpu";
        reg = <1>;
};

> 
> Regards
> Dong Aisheng
