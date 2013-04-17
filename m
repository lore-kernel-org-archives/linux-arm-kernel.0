From: tony@atomide.com (Tony Lindgren)
Date: Tue, 16 Apr 2013 17:52:32 -0700
Subject: [PATCH] ARM: dts: omap3-beagle-xm: Add USB Host support for
 Rev Ax/Bx
In-Reply-To: <516BF4F3.5060904@ti.com>
References: <1366029306-1824-1-git-send-email-rogerq@ti.com>
 <516BF4F3.5060904@ti.com>
Message-ID: <20130417005232.GV10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [130415 05:44]:
> On 04/15/2013 03:35 PM, Roger Quadros wrote:
> > Provide RESET and Power regulators for the USB PHY,
> > the USB Host port mode and the PHY device.
> > 
> > Also provide pin multiplexer information for USB host
> > pins.
> > 
> > This will not work for Rev Cx boards because of reversed logic
> > for USB_POWER_Enable.
> > 
> > CC: Beno?t Cousson <b-cousson@ti.com>
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > ---
> >  arch/arm/boot/dts/omap3-beagle-xm.dts |   62 +++++++++++++++++++++++++++++++++
> >  1 files changed, 62 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
> > index 5a31964..d394c51 100644
> > --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
> > +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
> > @@ -57,6 +57,60 @@
> >  		ti,mcbsp = <&mcbsp2>;
> >  		ti,codec = <&twl_audio>;
> >  	};
> > +
> > +	/* HS USB Port 2 RESET */
> > +	hsusb2_reset: hsusb2_reset_reg {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "hsusb2_reset";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		gpio = <&gpio5 19 0>;	/* gpio_147 */
> > +		startup-delay-us = <70000>;
> > +		enable-active-high;
> > +	};
> > +
> > +	/* HS USB Port 2 Power */
> > +	hsusb2_power: hsusb2_power_reg {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "hsusb2_vbus";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		gpio = <&twl_gpio 18 0>;	/* GPIO LEDA */
> > +		startup-delay-us = <70000>;
> > +		enable-active-high;	/* FIXME: active-low for Rev. C */
> 
> Benoit & Tony,
> 
> Any ideas how to tackle the reversed logic for Rev. C boards?

Sounds like we need a shared omap3-beage.dtsi, then omap3-beagle-xm.dts
and omap3-beagle-rev-c.dts. Then xm and rev-c can both include the
common .dtsi.

Regards,

Tony
