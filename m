From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 13 Sep 2013 10:25:10 +0200
Subject: [PATCH 1/2] ARM: dts: imx53-qsb: add TVE entry
In-Reply-To: <20130913065855.GA31147@S2101-09.ap.freescale.net>
References: <1378893068-22235-1-git-send-email-l.stach@pengutronix.de>
 <20130913065855.GA31147@S2101-09.ap.freescale.net>
Message-ID: <1379060710.4396.7.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Am Freitag, den 13.09.2013, 14:58 +0800 schrieb Shawn Guo:
> On Wed, Sep 11, 2013 at 11:51:07AM +0200, Lucas Stach wrote:
> > From: Philipp Zabel <p.zabel@pengutronix.de>
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx53-qsb.dts | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
> > index 512a1f6..2031ccc 100644
> > --- a/arch/arm/boot/dts/imx53-qsb.dts
> > +++ b/arch/arm/boot/dts/imx53-qsb.dts
> > @@ -156,6 +156,15 @@
> >  		};
> >  	};
> >  
> > +	tve {
> > +		pinctrl_vga_sync_1: vgasync-grp1 {
> > +			fsl,pins = <
> > +				/* VGA_HSYNC, VSYNC with max drive strength */
> > +				MX53_PAD_EIM_OE__IPU_DI1_PIN7     0xe6
> > +				MX53_PAD_EIM_RW__IPU_DI1_PIN8     0xe6
> > +			>;
> > +		};
> > +	};
> >  };
> >  
> >  &uart1 {
> > @@ -263,8 +272,8 @@
> >  			};
> >  
> >  			ldo8_reg: ldo8 {
> > -				regulator-min-microvolt = <1200000>;
> > -				regulator-max-microvolt = <3600000>;
> > +				regulator-min-microvolt = <2750000>;
> > +				regulator-max-microvolt = <2750000>;
> 
> Instead of having nothing in commit log, you can explain a little bit
> why the change is needed in there.
>
> >  				regulator-always-on;
> >  			};
> >  
> > @@ -297,6 +306,18 @@
> >  	status = "okay";
> >  };
> >  
> > +&tve {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_vga_sync_1>;
> > +	ddc = <&i2c2>;
> > +	fsl,tve-mode = "vga";
> 
> Are these custom properties documented anywhere?  I cannot find the
> device tree bindings document for them.  Anyway, it should be another
> patch to provide the document, if you like.

No, and I'd actually like to get rid of them, eventually.

If we can use the CDF/V4L2 entity model, the TVE will just be an encoder
entity with an output pad connected to a VGA connector node (or FBAS, or
S-Video, ...).
The ddc i2c bus property should then be placed on the actual (VGA)
connector node. Also the tve-mode could be inferred from the type of
connector (and even changed at runtime if there's both an S-Video and a
Composite connector, for example).

Maybe I should send a minimal patch without the two custom device tree
properties for now?

> > +	status = "okay";
> 
> Nit: please put 'status' at the bottom of the property list.

Ok.

> > +	dac-supply = <&ldo7_reg>;
> > +
> 
> Nit: drop this blank line.

Will do.

> Shawn
> 
> > +	fsl,hsync-pin = <7>; /* IPU DI1 PIN7 via EIM_OE */
> > +	fsl,vsync-pin = <8>; /* IPU DI1 PIN8 via EIM_RW */
> > +};
> > +
> >  &usbh1 {
> >         status = "okay";
> >  };
> > -- 
> > 1.8.4.rc3
> > 

regards
Philipp
