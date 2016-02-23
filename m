From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 23 Feb 2016 21:32:13 +0100
Subject: [PATCH] ARM: dts: vf610-zii-dev: Add ZII development board.
In-Reply-To: <c67c93683d9440bd050386df0e200881@agner.ch>
References: <1456084314-9871-1-git-send-email-andrew@lunn.ch>
 <c67c93683d9440bd050386df0e200881@agner.ch>
Message-ID: <20160223203213.GA31401@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2016 at 11:36:49AM -0800, Stefan Agner wrote:
> Hi Andrew,
> 
> Some comments below:
> 
> On 2016-02-21 11:51, Andrew Lunn wrote:
> > From: Cory Tusar <cory.tusar@pid1solutions.com>
> > 
> > This commit adds support for Rev. B of a Zodiac Inflight Innovations
> > development board, mainly intended for DSA and ARINC 429 development
> > work.
> > 
> > Signed-off-by: Cory Tusar <cory.tusar@pid1solutions.com>
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  arch/arm/boot/dts/Makefile                |   3 +-
> >  arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 683 ++++++++++++++++++++++++++++++
> >  2 files changed, 685 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index a4a6d70e8b26..47c4c2ff41de 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -372,7 +372,8 @@ dtb-$(CONFIG_SOC_VF610) += \
> >  	vf610m4-colibri.dtb \
> >  	vf610-cosmic.dtb \
> >  	vf610m4-cosmic.dtb \
> > -	vf610-twr.dtb
> > +	vf610-twr.dtb \
> > +	vf610-zii-dev-rev-b.dtb
> >  dtb-$(CONFIG_ARCH_MXS) += \
> >  	imx23-evk.dtb \
> >  	imx23-olinuxino.dtb \
> > diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
> > b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
> > new file mode 100644
> > index 000000000000..fafe0039ebce
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
> > @@ -0,0 +1,683 @@
> > +/*
> > + * Copyright 2013 Freescale Semiconductor, Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + */
> 
> I recently changed the license of most Vybrid device trees to the new
> dual license. Is it possible to change this device tree too?

Hi Stefan

I need to check with Cory about from which Freescale files this file
was derived from. If those files have been relicenced, we can probably
follow suit.

> > +	chosen {
> > +		bootargs = "console=ttyLP0,115200n8";
> > +		stdout-path = &uart0;
> 
> Is bootargs necessary?
> 
> For the stdout-path I would recommend to use the advanced format:
> stdout-path = "serial0:115200n8";

That probably works. I will test it.

> > +	mdio-mux {
> > +		compatible = "mdio-mux-gpio";
> > +		pinctrl-0 = <&pinctrl_mdio_mux>;
> > +		pinctrl-names = "default";
> > +		gpios = <&gpio0 8  GPIO_ACTIVE_HIGH
> > +			 &gpio0 9  GPIO_ACTIVE_HIGH
> > +			 &gpio0 24 GPIO_ACTIVE_HIGH
> > +			 &gpio0 25 GPIO_ACTIVE_HIGH>;
> > +		mdio-parent-bus = <&mdio1>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		mdio_mux_1: mdio at 1 {
> > +			reg = <1>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> 
> Since there are no child nodes the #address- and #size-cells properties
> are not necessary.

Humm, i would want to test that. Plus, i know there will be patches in
the next few months adding children.

> > +	audio_ext: mclk-osc {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <24576000>;
> > +	};
> 
> This seems not to be used anywhere. Maybe needs to be assigned to the
> clks node?
> 
> > +
> > +	enet_ext: eth-osc {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <50000000>;
> > +	};
> 
> Same here...

I'll let Cory comment on this.
 
> > +
> > +	reg_3p3v: regulator at 0 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "3P3V";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		regulator-always-on;
> > +	};
> 
> Do not use the address format (@0) in node name if the regulator is not
> part of a bus.
> 
> Use regulator-3p3v as node name.

Yes. These used to be inside a simple bus, which i removed, but forgot
to remove this part.
 
> > +	gpio5: pca9505 at 20 {
> > +		compatible = "nxp,pca9554";
> > +		reg = <0x20>;
> > +		gpio-controller;
> > +		#gpio-cells = <2>;
> > +
> > +	};
> > +
> > +	gpio6: pca9505 at 22 {
> > +		compatible = "nxp,pca9554";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_pca9554_opt>;
> > +		reg = <0x22>;
> > +		interrupt-parent = <&gpio1>;
> > +		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
> > +	};
> 
> Hm, any reason why one of this is a gpio-controller while the other
> isn't?

Humm, interesting. No idea. However, i have used the gpio6, but i'm
not sure about gpio5. I will add the missing property and retest.

> > +		i2c2_3:	 i2c at 3 {
> 
> There is an extra space between the colon and i2c at 3...

O.K.
 
> > +&iomuxc {
> 
> We normally put the iomuxc node at the very end.

O.K. I can move it.
 
> > +
> > +&L2 {
> > +	arm,data-latency = <2 1 2>;
> > +	arm,tag-latency = <3 2 3>;
> > +};
> 
> Are you sure about that?
> 
> With 9c17190595 ("ARM: dts: vf610: use reset values for L2 cache
> latencies") we have reasonable values in the base device tree
> vf610.dtsi, I think therefor this is not necessary anymore, even if you
> use 500MHz as CPU clock.

It is probably copy and paste from before that patch.

Thanks for the review.

       Andrew
