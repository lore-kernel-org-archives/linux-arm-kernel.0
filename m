From: mgr@pengutronix.de (Michael Grzeschik)
Date: Mon, 25 Nov 2013 14:42:48 +0100
Subject: [PATCH 2/4 V2] ARM: mx28: Add USB PHY overcurrent pinmux
In-Reply-To: <201311250058.32881.marex@denx.de>
References: <1345852300-2213-1-git-send-email-marex@denx.de>
 <1345852300-2213-2-git-send-email-marex@denx.de>
 <20131122154947.GE24508@pengutronix.de>
 <201311250058.32881.marex@denx.de>
Message-ID: <20131125134248.GA28906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek, Peter,

On Mon, Nov 25, 2013 at 12:58:32AM +0100, Marek Vasut wrote:
> Hello Michael,
> 
> > Hi Marek, Peter,
> > 
> > On Sat, Aug 25, 2012 at 01:51:38AM +0200, Marek Vasut wrote:
> > > Add the pinmux settings for USB PHY overcurrent pins.
> > > 
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > Cc: Chris Ball <cjb@laptop.org>
> > > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > > ---
> > > 
> > >  arch/arm/boot/dts/imx28.dtsi |   30 ++++++++++++++++++++++++++++++
> > >  1 file changed, 30 insertions(+)
> > > 
> > > V2: This is pulled from the M28EVK and SPS1 board files, put it into
> > > common
> > > 
> > >     file.
> > > 
> > > diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> > > index b996c2d..3cba62d 100644
> > > --- a/arch/arm/boot/dts/imx28.dtsi
> > > +++ b/arch/arm/boot/dts/imx28.dtsi
> > > @@ -520,6 +520,36 @@
> > > 
> > >  					fsl,voltage = <1>;
> > >  					fsl,pull-up = <1>;
> > >  				
> > >  				};
> > > 
> > > +
> > > +				usbphy0_pins_a: usbphy0 at 0 {
> > > +					reg = <0>;
> > > +					fsl,pinmux-ids = <
> > > +						0x2152 /* 
> MX28_PAD_SSP2_SS2__USB0_OVERCURRENT */
> > > +					>;
> > > +					fsl,drive-strength = <2>;
> > > +					fsl,voltage = <1>;
> > > +					fsl,pull-up = <0>;
> > > +				};
> > > +
> > > +				usbphy0_pins_b: usbphy0 at 1 {
> > > +					reg = <0>;
> > > +					fsl,pinmux-ids = <
> > > +						0x3061 /* 
> MX28_PAD_AUART1_CTS__USB0_OVERCURRENT */
> > > +					>;
> > > +					fsl,drive-strength = <2>;
> > > +					fsl,voltage = <1>;
> > > +					fsl,pull-up = <0>;
> > > +				};
> > > +
> > > +				usbphy1_pins_a: usbphy1 at 0 {
> > > +					reg = <0>;
> > > +					fsl,pinmux-ids = <
> > > +						0x2142 /* 
> MX28_PAD_SSP2_SS1__USB1_OVERCURRENT */
> > > +					>;
> > > +					fsl,drive-strength = <2>;
> > > +					fsl,voltage = <1>;
> > > +					fsl,pull-up = <0>;
> > > +				};
> > > 
> > >  			};
> > >  			
> > >  			digctl at 8001c000 {
> > 
> > @Marek: Did you test the overcurrent functionality with the MX28 and this
> > pinmux?
> > 
> > I currently can not trigger any overcurrent events and also don't
> > see changes in the PORTSC register after pulling the OC pin to 3V3.
> 
> Sorry for the late reply, I see Peter already replied. Do you see the changes if 
> you configure the pin as a GPIO at least ?

The GPIO is working for this pin. But also the DIGCTL register bits
helped here.  Now the OC event triggers if the pin gets pulled to 3V3.

I am currently looking for a good place to enable the DIGCTL bits.
I suggest to enable them per default.  As we don't have USBMISC registers
in MX28, the bits should be toggled in ci_hdrc_imx.c if the of property
"disable-overcurrent" is not found.  I will use the syscon interface to
reach them with the regmap interface.

Any objections?

Regards,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
