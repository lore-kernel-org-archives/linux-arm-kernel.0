From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Sep 2014 18:22:28 +0200
Subject: [PATCH v2 5/7] arm64: dts: Add initial device tree support for
 EXYNOS7
In-Reply-To: <036a01cfc792$422271e0$c66755a0$@samsung.com>
References: <1409672143-8574-1-git-send-email-ch.naveen@samsung.com>
 <1409672143-8574-6-git-send-email-ch.naveen@samsung.com>
 <036a01cfc792$422271e0$c66755a0$@samsung.com>
Message-ID: <3382034.5ADO0F7naY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 September 2014 01:15:20 Kukjin Kim wrote:
> Naveen Krishna Chatradhi wrote:
>
> > diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-
> > espresso.dts
> > new file mode 100644
> > index 0000000..f6a8879
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> > @@ -0,0 +1,31 @@
> > +/*
> > + * SAMSUNG Exynos7 Espresso board device tree source
> > + *
> > + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> > + *		http://www.samsung.com
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > +*/
> > +
> > +/dts-v1/;
> > +#include "exynos7.dtsi"
> > +
> > +/ {
> > +	model = "Samsung Exynos7 Espresso board based on EXYNOS7";
> > +	compatible = "samsung,exynos7-espresso", "samsung,exynos7";
> > +
> > +	chosen {
> > +		linux,stdout-path = &serial_2;
> 
> Well...
> 
> > +	};
> > +
> > +	memory at 40000000 {
> > +		device_type = "memory";
> > +		reg = <0x0 0x40000000 0x0 0xC0000000>;
> 
> The base address of system memory is depending on each board, actually some of
> them are 0x20000000.

This is the board specific file, so it seems ok.

> > +#include <dt-bindings/clock/exynos7-clk.h>
> > +
> > +/ {
> > +	compatible = "samsung,exynos7";
> > +	interrupt-parent = <&gic>;
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +
> > +	aliases {
> > +		serial0 = &serial_0;
> > +		serial1 = &serial_1;
> > +		serial2 = &serial_2;
> > +		serial3 = &serial_3;
> 
> There are exynos7 SoC is having 3 serial IPs...

These aliases should just go into the board file as well, and
since it seems to have only one uart, the best way is to list
that as serial0:

	serial0 = &serial_2;

> > +
> > +	psci {
> > +		compatible = "arm,psci-0.2";
> > +		method = "smc";
> > +	};
> > +
> > +	soc: soc {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0 0 0 0x18000000>;
> > +
> > +		chipid at 10000000 {
> > +			compatible = "samsung,exynos4210-chipid";
> > +			reg = <0x10000000 0x100>;
> > +		};
> > +
> > +		fin_pll: xxti {
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <24000000>;
> 
> It's wrong on some exynos7 SoCs...
> 

Is this an external clock input? If so, the frequency should
also go into the board file, otherwise into the soc-specific
one.

	Arnd
