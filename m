From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 23 May 2013 19:33:06 +0200
Subject: [PATCH] ARM: dts: imx: fix clocks for cspi
In-Reply-To: <1369319290.379285076@f398.i.mail.ru>
References: <1369309085-31146-1-git-send-email-jonas@microbit.se>
 <1369311059.366490908@f190.mail.ru>
 <20130523123642.GK32299@pengutronix.de>
 <1369319290.379285076@f398.i.mail.ru>
Message-ID: <20130523173306.GT32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 06:28:10PM +0400, Alexander Shiyan wrote:
> > On Thu, May 23, 2013 at 04:10:59PM +0400, Alexander Shiyan wrote:
> > > > > The CSPI controller has only one clock, but the driver spi-imx.c needs clock "per" to calculate bitrate divisor.
> > > > > 
> > > > > Signed-off-by: Jonas Andersson <jonas@microbit.se>
> > > > > ---
> > > > >  arch/arm/boot/dts/imx25.dtsi | 12 ++++++------
> > > > >  arch/arm/boot/dts/imx27.dtsi |  6 +++---
> > > > >  arch/arm/boot/dts/imx51.dtsi |  2 +-
> > > > >  arch/arm/boot/dts/imx53.dtsi |  2 +-
> > > > >  4 files changed, 11 insertions(+), 11 deletions(-)
> > > > > 
> > > > > diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> > > > > index d2550e0..7011539 100644
> > > > > --- a/arch/arm/boot/dts/imx25.dtsi
> > > > > +++ b/arch/arm/boot/dts/imx25.dtsi
> > > > > @@ -141,8 +141,8 @@
> > > > >  				#size-cells = <0>;
> > > > >  				compatible = "fsl,imx25-cspi", "fsl,imx35-cspi";
> > > > >  				reg = <0x43fa4000 0x4000>;
> > > > > -				clocks = <&clks 62>;
> > > > > -				clock-names = "ipg";
> > > > > +				clocks = <&clks 62>, <&clks 62>;
> > > > > +				clock-names = "ipg", "per";
> > > > >  				interrupts = <14>;
> > > > >  				status = "disabled";
> > > > >  			};
> > > 
> > > Sorry, typo.
> > > 
> > > > Why you do not use "dummy" clock for "per" here?
> > > 
> > > *for "ipg"
> > 
> > Because the same clock is used for the register clock and the baudrate
> > clock. You have to enable the ipg clock to access registers.
> 
> I am not see any "ipg" clock usage in the spi driver.

It's the register clock. The driver enables it in order to access the
registers.

> If "ipg" clock is
> a dependency for "per" clock, it should be registered in ccm as parent.

Look, the eCSPI unit has two clock inputs, one for accessing the
registers (ipg) and one for generating the SPI bit clock (per). Now the
CSPI unit only has a single clock input, so the 100% correct way would
be to specify only a single clock for this unit. However, since we
handle both units with the same driver the simplest way to cope with
it is to provide the very same clock twice, once for the register access
and once for generating the SPI bit clock.
And yes, we have to specify the real clock twice and can't replace one
with a dummy clock, because if we specify a dummy clock for the ipg
clock, then the driver couldn't access the registers even if it enabled
the clock. If we would replace the SPI bit clock with a dummy clock then
the device couldn't send data even if the driver enabled the bit clock.
(That of course only becomes relevant when the driver actually
en/disables the clocks during runtime and not only once during probe).

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
