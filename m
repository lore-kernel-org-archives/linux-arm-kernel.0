From: tony@atomide.com (Tony Lindgren)
Date: Mon, 9 May 2016 12:44:32 -0700
Subject: [PATCH] ARM: dts: Fix igepv5 audiopwon-gpio
In-Reply-To: <1b37fbdd-67f0-e9e3-d442-bdc0bd74397b@ti.com>
References: <1462474581-13865-1-git-send-email-tony@atomide.com>
 <1b37fbdd-67f0-e9e3-d442-bdc0bd74397b@ti.com>
Message-ID: <20160509194431.GK5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160509 01:36]:
> On 05/05/16 21:56, Tony Lindgren wrote:
> > Playing audio works on omap5-uevm, but produces an "Unhandled fault:
> > imprecise external abort (0x1406) at 0x00000000" error on igepv5.
> > 
> > Looks like the twl6040 audpwron GPIO pin is different for these
> > boards. Let's fix the issue by configuring the audpwron in the
> > board specific dts file.
> > 
> > Cc: Agust? Fontquerni <af@iseebcn.com>
> > Cc: Eduard Gavin <egavin@iseebcn.com>
> > Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>
> > Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/boot/dts/omap5-board-common.dtsi |  3 ++-
> >  arch/arm/boot/dts/omap5-igep0050.dts      | 10 ++++++++++
> >  arch/arm/boot/dts/omap5-uevm.dts          | 10 ++++++++++
> >  3 files changed, 22 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
> > index 2eea26c..23b1d7c 100644
> > --- a/arch/arm/boot/dts/omap5-board-common.dtsi
> > +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
> > @@ -642,7 +642,8 @@
> >  		pinctrl-0 = <&twl6040_pins>;
> >  
> >  		interrupts = <GIC_SPI 119 IRQ_TYPE_NONE>; /* IRQ_SYS_2N cascaded to gic */
> > -		ti,audpwron-gpio = <&gpio5 13 GPIO_ACTIVE_HIGH>;  /* gpio line 141 */
> > +
> > +		/* audpwron gpio defined in the board specific dts */
> >  
> >  		vio-supply = <&smps7_reg>;
> >  		v2v1-supply = <&smps9_reg>;
> > diff --git a/arch/arm/boot/dts/omap5-igep0050.dts b/arch/arm/boot/dts/omap5-igep0050.dts
> > index 72ff6a4..673cdfa 100644
> > --- a/arch/arm/boot/dts/omap5-igep0050.dts
> > +++ b/arch/arm/boot/dts/omap5-igep0050.dts
> > @@ -58,3 +58,13 @@
> >  		<&gpio7 3 0>;		/* 195, SDA */
> >  };
> >  
> > +&twl6040 {
> > +	ti,audpwron-gpio = <&gpio5 16 GPIO_ACTIVE_HIGH>;  /* gpio line 144 */
> 
> BTW: how do you know that gpio144 is used as audpwron GPIO on igepv5?

>From looking at the ISEE git tree. But it would be best for the ISEE guys
to review the patch.

> > +};
> > +
> > +&twl6040_pins {
> > +	pinctrl-single,pins = <
> > +		OMAP5_IOPAD(0x1c4, PIN_OUTPUT | MUX_MODE6)	/* mcspi1_somi.gpio5_144 */
> > +		OMAP5_IOPAD(0x1ca, PIN_OUTPUT | MUX_MODE6)	/* perslimbus2_clock.gpio5_145 */
> 
> What does the gpio145 is used for?

No idea without seeing the schematics, also from ISEE git tree so should
be reviewed.

Regards,

Tony
