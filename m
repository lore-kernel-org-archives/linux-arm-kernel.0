From: ps.report@gmx.net (Peter Seiderer)
Date: Fri, 22 May 2015 21:30:19 +0200
Subject: Aw: Re: [PATCH v2] ARM: dts: nitrogen6x: add CAN support
In-Reply-To: <1432292734.3929.64.camel@pengutronix.de>
References: <1432230303-3414-1-git-send-email-ps.report@gmx.net>,
 <1432292734.3929.64.camel@pengutronix.de>
Message-ID: <trinity-1dc833e7-79e4-4fe4-9e8b-cff88a35a0d9-1432323019162@3capp-gmx-bs48>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Philipp,

> Gesendet: Freitag, 22. Mai 2015 um 13:05 Uhr
> Von: "Philipp Zabel" <p.zabel@pengutronix.de>
> An: "Peter Seiderer" <ps.report@gmx.net>
> Cc: linux-kernel at vger.kernel.org, "Mark Rutland" <mark.rutland@arm.com>, devicetree at vger.kernel.org, "Russell King" <linux@arm.linux.org.uk>, "Pawel Moll" <pawel.moll@arm.com>, "Ian Campbell" <ijc+devicetree@hellion.org.uk>, "Rob Herring" <robh+dt@kernel.org>, "Sascha Hauer" <kernel@pengutronix.de>, "Kumar Gala" <galak@codeaurora.org>, "Shawn Guo" <shawn.guo@linaro.org>, linux-arm-kernel at lists.infradead.org
> Betreff: Re: [PATCH v2] ARM: dts: nitrogen6x: add CAN support
>
> Hi Peter,
> 
> Am Donnerstag, den 21.05.2015, 19:45 +0200 schrieb Peter Seiderer:
> > Regulator stuff copied from imx6qdl-tx6.dtsi, pin configuration
> > taken from Boundary Devices linux kernel tree ([1] and [2]).
> > 
> > [1] https://github.com/boundarydevices/linux-imx6/blob/boundary-imx_3.10.17_1.0.2_ga/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> > [2] https://github.com/boundarydevices/linux-imx6/blob/boundary-imx_3.10.17_1.0.2_ga/arch/arm/boot/dts/imx6qdl.dtsi
> > 
> > Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> > ---
> > v2:
> >  - fix imx6qdl-nitrogen6x.dtsi url
> >  - use real PAD settings (suggested by Fabio Estevam)
> >  - remove _1 suffix (suggested by Shawn Guo)
> > ---
> >  arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 32 +++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> > index fd096dc..d40092e 100644
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
> 
> According to
> Documentation/devicetree/bindings/regulator/fixed-regulator.txt
> this should have:
> 			enable-active-high;
> 
> instead of the gpio phandle flag (which is ignored). Otherwise an active
> low GPIO is assumed.
> 

Thanks for review...

I was a bit confused from the original:

imx6qdl-tx6.dtsi:103:           reg_can_xcvr: regulator at 3 {
imx6qdl-tx6.dtsi-104-                   compatible = "regulator-fixed";
imx6qdl-tx6.dtsi-105-                   reg = <3>;
imx6qdl-tx6.dtsi-106-                   regulator-name = "CAN XCVR";
imx6qdl-tx6.dtsi-107-                   regulator-min-microvolt = <3300000>;
imx6qdl-tx6.dtsi-108-                   regulator-max-microvolt = <3300000>;
imx6qdl-tx6.dtsi-109-                   pinctrl-names = "default";
imx6qdl-tx6.dtsi:110:                   pinctrl-0 = <&pinctrl_flexcan_xcvr>;
imx6qdl-tx6.dtsi-111-                   gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
imx6qdl-tx6.dtsi-112-                   enable-active-low;
imx6qdl-tx6.dtsi-113-           };

...and removed the default 'enable-active-low'...

Maybe GPIO_ACTIVE_LOW is the right thing?

>From the other files:

imx28-tx28.dts:90:              reg_can_xcvr: regulator at 4 {
imx28-tx28.dts-91-                      compatible = "regulator-fixed";
imx28-tx28.dts-92-                      reg = <4>;
imx28-tx28.dts-93-                      regulator-name = "CAN XCVR";
imx28-tx28.dts-94-                      regulator-min-microvolt = <3300000>;
imx28-tx28.dts-95-                      regulator-max-microvolt = <3300000>;
imx28-tx28.dts-96-                      gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
imx28-tx28.dts-97-                      pinctrl-names = "default";
imx28-tx28.dts:98:                      pinctrl-0 = <&tx28_flexcan_xcvr_pins>;
imx28-tx28.dts-99-              };


imx53-tx53.dtsi:90:             reg_can_xcvr: regulator at 2 {
imx53-tx53.dtsi-91-                     compatible = "regulator-fixed";
imx53-tx53.dtsi-92-                     reg = <2>;
imx53-tx53.dtsi-93-                     regulator-name = "CAN XCVR";
imx53-tx53.dtsi-94-                     regulator-min-microvolt = <3300000>;
imx53-tx53.dtsi-95-                     regulator-max-microvolt = <3300000>;
imx53-tx53.dtsi-96-                     pinctrl-names = "default";
imx53-tx53.dtsi:97:                     pinctrl-0 = <&pinctrl_can_xcvr>;
imx53-tx53.dtsi-98-                     gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
imx53-tx53.dtsi-99-             };

But there are also imx regulator-fixed definitions with GPIO_ACTIVE_HIGH/enable-active-high:

imx28-tx28.dts-101-             reg_lcd: regulator at 5 {
imx28-tx28.dts-102-                     compatible = "regulator-fixed";
imx28-tx28.dts-103-                     reg = <5>;
imx28-tx28.dts-104-                     regulator-name = "LCD POWER";
imx28-tx28.dts-105-                     regulator-min-microvolt = <3300000>;
imx28-tx28.dts-106-                     regulator-max-microvolt = <3300000>;
imx28-tx28.dts-107-                     gpio = <&gpio1 31 GPIO_ACTIVE_HIGH>;
imx28-tx28.dts-108-                     enable-active-high;
imx28-tx28.dts-109-             };


imx53-tx53.dtsi-101-            reg_usbh1_vbus: regulator at 3 {
imx53-tx53.dtsi-102-                    compatible = "regulator-fixed";
imx53-tx53.dtsi-103-                    reg = <3>;
imx53-tx53.dtsi-104-                    regulator-name = "usbh1_vbus";
imx53-tx53.dtsi-105-                    regulator-min-microvolt = <5000000>;
imx53-tx53.dtsi-106-                    regulator-max-microvolt = <5000000>;
imx53-tx53.dtsi-107-                    pinctrl-names = "default";
imx53-tx53.dtsi-108-                    pinctrl-0 = <&pinctrl_usbh1_vbus>;
imx53-tx53.dtsi-109-                    gpio = <&gpio3 31 GPIO_ACTIVE_HIGH>;
imx53-tx53.dtsi-110-                    enable-active-high;
imx53-tx53.dtsi-111-            };


imx6qdl-tx6.dtsi-115-           reg_lcd0_pwr: regulator at 4 {
imx6qdl-tx6.dtsi-116-                   compatible = "regulator-fixed";
imx6qdl-tx6.dtsi-117-                   reg = <4>;
imx6qdl-tx6.dtsi-118-                   regulator-name = "LCD0 POWER";
imx6qdl-tx6.dtsi-119-                   regulator-min-microvolt = <3300000>;
imx6qdl-tx6.dtsi-120-                   regulator-max-microvolt = <3300000>;
imx6qdl-tx6.dtsi-121-                   pinctrl-names = "default";
imx6qdl-tx6.dtsi-122-                   pinctrl-0 = <&pinctrl_lcd0_pwr>;
imx6qdl-tx6.dtsi-123-                   gpio = <&gpio3 29 GPIO_ACTIVE_HIGH>;
imx6qdl-tx6.dtsi-124-                   enable-active-high;
imx6qdl-tx6.dtsi-125-                   regulator-boot-on;
imx6qdl-tx6.dtsi-126-                   regulator-always-on;
imx6qdl-tx6.dtsi-127-           };

Any further advice from your side which solution is the right one?

 - GPIO_ACTIVE_HIGH/enable-active-high
 - GPIO_ACTIVE_LOW

Regards,
Peter

> regards
> Philipp
> 
> 
