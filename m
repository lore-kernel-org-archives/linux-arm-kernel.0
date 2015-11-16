From: michael@amarulasolutions.com (Michael Trimarchi)
Date: Mon, 16 Nov 2015 12:41:32 +0100
Subject: [PATCH] ARM: dts: imx6q-icore-rqs: Add Engicam IMX6 Q7 initial
 support
In-Reply-To: <1447673895.3144.16.camel@pengutronix.de>
References: <1447584853-12560-1-git-send-email-michael@amarulasolutions.com>
 <1447665552.3144.6.camel@pengutronix.de>
 <20151116112931.GA10464@panicking>
 <1447673895.3144.16.camel@pengutronix.de>
Message-ID: <20151116114127.GB10464@panicking>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Mon, Nov 16, 2015 at 12:38:15PM +0100, Lucas Stach wrote:
> Am Montag, den 16.11.2015, 12:29 +0100 schrieb Michael Trimarchi:
> > Hi
> > 
> > On Mon, Nov 16, 2015 at 10:19:12AM +0100, Lucas Stach wrote:
> > > Am Sonntag, den 15.11.2015, 11:54 +0100 schrieb Michael Trimarchi:
> > > > www.engicam.com/en/products/embedded/som/standard/i-core-rqs-m6s-dl-d-q
> > > > 
> > > > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > > > ---
> > > >  arch/arm/boot/dts/Makefile               |   1 +
> > > >  arch/arm/boot/dts/imx6q-icore-rqs.dts    |  36 +++
> > > >  arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi | 372 +++++++++++++++++++++++++++++++
> > > >  3 files changed, 409 insertions(+)
> > > >  create mode 100644 arch/arm/boot/dts/imx6q-icore-rqs.dts
> > > >  create mode 100644 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
> > > > 
> [...]
> > > > diff --git a/arch/arm/boot/dts/imx6q-icore-rqs.dts b/arch/arm/boot/dts/imx6q-icore-rqs.dts
> > > > new file mode 100644
> > > > index 0000000..cded07d
> > > > --- /dev/null
> > > > +++ b/arch/arm/boot/dts/imx6q-icore-rqs.dts
> > > > @@ -0,0 +1,36 @@
> > > > +/*
> > > > + * Copyright (C) 2015 Amarula Solutions B.V.
> > > > + *
> > > > + * This program is free software; you can redistribute it and/or modify
> > > > + * it under the terms of the GNU General Public License version 2 as
> > > > + * published by the Free Software Foundation.
> > > > + */
> > > > +
> > > > +/dts-v1/;
> > > > +
> > > > +#include "imx6q.dtsi"
> > > > +#include "imx6qdl-icore-rqs.dtsi"
> > > > +
> > > > +/ {
> > > > +	model = "Engicam i.CoreM6 Quad SOM";
> > > > +	compatible = "fsl,imx6-icore-rqs", "fsl,imx6q";
> > > > +	cpus {
> > > > +		cpu at 0 {
> > > > +			operating-points = <
> > > > +				/* kHz    uV */
> > > > +				792000  1150000
> > > > +				396000  1150000
> > > > +			>;
> > > > +
> > > > +			fsl,soc-operating-points = <
> > > > +				/* ARM kHz  SOC-PU uV */
> > > > +				792000        1175000
> > > > +				396000        1175000
> > > > +			>;
> > > > +		};
> > > Why do you need to edit the OPPS here? Just to fix them on a specific
> > > voltage? Why?
> > > 
> > 
> > Board has no pmu regulator
> > 
> The default i.MX6 configuration (see imx6q.dtsi) is to connect the ARM
> and SOC domain to the internal LDOs, so voltage scaling is not dependent
> on an external PMIC being present.
> 

Sorry, It was a mistake based on original patch. So I need to limit the max
allowed frequency suggested by the vendor. So including the operating points
that I support. Is this fine?

> > > > +	};
> > > > +};
> > > > +
> > > > +&sata {
> > > > +	status = "okay";
> > > > +};
> > > > diff --git a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
> > > > new file mode 100644
> > > > index 0000000..59c416e
> > > > --- /dev/null
> > > > +++ b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
> > > > @@ -0,0 +1,372 @@
> > > > +/*
> > > > + * Copyright 2015 Amarula Solutions B.V.
> > > > + *
> > > > + * The code contained herein is licensed under the GNU General Public
> > > > + * License. You may obtain a copy of the GNU General Public License
> > > > + * Version 2 or later at the following locations:
> > > > + *
> > > > + * http://www.opensource.org/licenses/gpl-license.html
> > > > + * http://www.gnu.org/copyleft/gpl.html
> > > > + */
> > > > +#include <dt-bindings/gpio/gpio.h>
> > > > +#include <dt-bindings/clock/imx6qdl-clock.h>
> > > > +
> > > > +/ {
> > > > +	memory {
> > > > +		reg = <0x10000000 0x80000000>;
> > > > +	};
> > > > +
> > > > +	regulators {
> > > > +		compatible = "simple-bus";
> > > > +
> > > > +		reg_usb_h1_vbus: usb_h1_vbus {
> > > > +			compatible = "regulator-fixed";
> > > > +			regulator-name = "usb_h1_vbus";
> > > > +			regulator-min-microvolt = <5000000>;
> > > > +			regulator-max-microvolt = <5000000>;
> > > > +			gpio = <&gpio1 6 GPIO_ACTIVE_HIGH>;
> > > > +			enable-active-high;
> > > > +		};
> > > > +
> > > > +		reg_usb_otg_vbus: usb_otg_vbus {
> > > > +			compatible = "regulator-fixed";
> > > > +			regulator-name = "usb_otg_vbus";
> > > > +			regulator-min-microvolt = <5000000>;
> > > > +			regulator-max-microvolt = <5000000>;
> > > > +			regulator-always-on;
> > > > +		};
> > > > +
> > > > +		reg_3p3v: 3p3v {
> > > > +			compatible = "regulator-fixed";
> > > > +			regulator-name = "3P3V";
> > > > +			regulator-min-microvolt = <3300000>;
> > > > +			regulator-max-microvolt = <3300000>;
> > > > +			regulator-always-on;
> > > > +		};
> > > > +
> > > > +		reg_2p5v: 2p5v {
> > > > +			compatible = "regulator-fixed";
> > > > +			regulator-name = "2P5V";
> > > > +			regulator-min-microvolt = <2500000>;
> > > > +			regulator-max-microvolt = <2500000>;
> > > > +			regulator-always-on;
> > > > +		};
> > > > +
> > > > +		reg_1p8v: 1p8v {
> > > > +			compatible = "regulator-fixed";
> > > > +			regulator-name = "1P8V";
> > > > +			regulator-min-microvolt = <1800000>;
> > > > +			regulator-max-microvolt = <1800000>;
> > > > +			regulator-always-on;
> > > > +		};
> > > > +
> > > > +		reg_sd4_vmmc: sd4_vmmc {
> > > > +			compatible = "regulator-fixed";
> > > > +			regulator-name = "P3V3_SD4_SWITCHED";
> > > > +			regulator-min-microvolt = <3300000>;
> > > > +			regulator-max-microvolt = <3300000>;
> > > > +			regulator-boot-on;
> > > > +			regulator-always-on;
> > > > +		};
> > > > +
> > > > +		reg_sd3_vmmc: sd3_vmmc {
> > > > +			compatible = "regulator-fixed";
> > > > +			regulator-name = "P3V3_SD3_SWITCHED";
> > > > +			regulator-min-microvolt = <3300000>;
> > > > +			regulator-max-microvolt = <3300000>;
> > > > +			gpio = <&gpio1 4 GPIO_ACTIVE_LOW>;
> > > > +			regulator-boot-on;
> > > > +			regulator-always-on;
> > > > +		};
> > > 
> > > A lot of those regulators look like they don't need to be always-on.
> > > 
> > > Also the use of a simple-bus, while giving some structure to the DT is
> > > considered bad style as it doesn't reflect any real hardware.
> > > 
> > 
> > I will check how other boards do it
> > 
> Note that there are a lot of bad examples still around. What you need to
> do is essentially just remove the additional DT level of the regulator
> bus. The regulators are board components that belong to the same level
> as the usb hub below, or the memory node above.

Understand. I will do

> 
> Regards,
> Lucas
> 
> -- 
> Pengutronix e.K.             | Lucas Stach                 |
> Industrial Linux Solutions   | http://www.pengutronix.de/  |
> 

-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
