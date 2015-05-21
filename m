From: ps.report@gmx.net (Peter Seiderer)
Date: Thu, 21 May 2015 08:56:52 +0200
Subject: Aw: Re: [PATCH v1] ARM: dts: nitrogen6x: add CAN support
In-Reply-To: <20150521013351.GK24844@dragon>
References: <1432158569-4415-1-git-send-email-ps.report@gmx.net>,
 <20150521013351.GK24844@dragon>
Message-ID: <trinity-11799706-adb4-4b27-94e9-81979422dc18-1432191412447@3capp-gmx-bs69>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

> Gesendet: Donnerstag, 21. Mai 2015 um 03:33 Uhr
> Von: "Shawn Guo" <shawn.guo@linaro.org>
> An: "Peter Seiderer" <ps.report@gmx.net>
> Cc: linux-kernel at vger.kernel.org, devicetree at vger.kernel.org, linux-arm-kernel at lists.infradead.org, "Russell King" <linux@arm.linux.org.uk>, "Kumar Gala" <galak@codeaurora.org>, "Ian Campbell" <ijc+devicetree@hellion.org.uk>, "Mark Rutland" <mark.rutland@arm.com>, "Pawel Moll" <pawel.moll@arm.com>, "Rob Herring" <robh+dt@kernel.org>, "Sascha Hauer" <kernel@pengutronix.de>
> Betreff: Re: [PATCH v1] ARM: dts: nitrogen6x: add CAN support
>
> On Wed, May 20, 2015 at 11:49:29PM +0200, Peter Seiderer wrote:
> > Regulator stuff copied from imx6qdl-tx6.dtsi, pin configuration
> > taken from Boundary Devices linux kernel tree ([1] and [2]).
> > 
> > [1] https://github.com/boundarydevices/linux-imx6/blob/boundary-imx_3.10.17_1.0.2_ga/arch/arm/boot/dts/imx6qdl-nitrogen6x.dts
> > [2] https://github.com/boundarydevices/linux-imx6/blob/boundary-imx_3.10.17_1.0.2_ga/arch/arm/boot/dts/imx6qdl.dtsi
> > 
> > Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> > ---
> >  arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 32 +++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> > index fd096dc..1c415e4 100644
> > --- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> > @@ -54,6 +54,17 @@
> >  			gpio = <&gpio3 22 0>;
> >  			enable-active-high;
> >  		};
> > +
> > +		reg_can_xcvr: regulator at 3 {
> > +			compatible = "regulator-fixed";
> > +			reg = <3>;
> > +			regulator-name = "CAN XCVR";
> > +			regulator-min-microvolt = <3300000>;
> > +			regulator-max-microvolt = <3300000>;
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&pinctrl_can_xcvr>;
> > +			gpio = <&gpio1 2 GPIO_ACTIVE_HIGH>;
> > +		};
> >  	};
> >  
> >  	gpio-keys {
> > @@ -138,6 +149,13 @@
> >  	status = "okay";
> >  };
> >  
> > +&can1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_can1_1>;
> > +	xceiver-supply = <&reg_can_xcvr>;
> > +	status = "okay";
> > +};
> > +
> >  &ecspi1 {
> >  	fsl,spi-num-chipselects = <1>;
> >  	cs-gpios = <&gpio3 19 0>;
> > @@ -234,6 +252,20 @@
> >  			>;
> >  		};
> >  
> > +		pinctrl_can1_1: can1grp-1 {
> 
> The '_1' suffix is meaningless.
> 
> 		pinctrl_can1: can1grp {

Thanks for review, will fix it...

Regards,
Peter

> 
> Shawn
> 
> > +			fsl,pins = <
> > +				MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX 0x80000000
> > +				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX 0x80000000
> > +			>;
> > +		};
> > +
> > +		pinctrl_can_xcvr: can-xcvrgrp {
> > +			fsl,pins = <
> > +				/* Flexcan XCVR enable */
> > +				MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x1b0b0
> > +			>;
> > +		};
> > +
> >  		pinctrl_ecspi1: ecspi1grp {
> >  			fsl,pins = <
> >  				MX6QDL_PAD_EIM_D17__ECSPI1_MISO		0x100b1
> > -- 
> > 2.1.4
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
