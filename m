From: mgr@pengutronix.de (Michael Grzeschik)
Date: Tue, 25 Jun 2013 17:05:59 +0200
Subject: [PATCH] ARM: dts: imx: fix clocks for cspi
In-Reply-To: <1369369002.837105175@f322.mail.ru>
References: <1369309085-31146-1-git-send-email-jonas@microbit.se>
 <1369319290.379285076@f398.i.mail.ru>
 <20130523173306.GT32299@pengutronix.de>
 <1369369002.837105175@f322.mail.ru>
Message-ID: <20130625150559.GA3150@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 24, 2013 at 08:16:42AM +0400, Alexander Shiyan wrote:
> > > > On Thu, May 23, 2013 at 04:10:59PM +0400, Alexander Shiyan wrote:
> > > > > > > The CSPI controller has only one clock, but the driver spi-imx.c needs clock "per" to calculate bitrate divisor.
> > > > > > > 
> > > > > > > Signed-off-by: Jonas Andersson <jonas@microbit.se>
> > > > > > > ---
> > > > > > >  arch/arm/boot/dts/imx25.dtsi | 12 ++++++------
> > > > > > >  arch/arm/boot/dts/imx27.dtsi |  6 +++---
> > > > > > >  arch/arm/boot/dts/imx51.dtsi |  2 +-
> > > > > > >  arch/arm/boot/dts/imx53.dtsi |  2 +-
> > > > > > >  4 files changed, 11 insertions(+), 11 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> > > > > > > index d2550e0..7011539 100644
> > > > > > > --- a/arch/arm/boot/dts/imx25.dtsi
> > > > > > > +++ b/arch/arm/boot/dts/imx25.dtsi
> > > > > > > @@ -141,8 +141,8 @@
> > > > > > >  				#size-cells = <0>;
> > > > > > >  				compatible = "fsl,imx25-cspi", "fsl,imx35-cspi";
> > > > > > >  				reg = <0x43fa4000 0x4000>;
> > > > > > > -				clocks = <&clks 62>;
> > > > > > > -				clock-names = "ipg";
> > > > > > > +				clocks = <&clks 62>, <&clks 62>;
> > > > > > > +				clock-names = "ipg", "per";
> > > > > > >  				interrupts = <14>;
> > > > > > >  				status = "disabled";
> > > > > > >  			};
> > > > > 
> > > > > Sorry, typo.
> > > > > 
> > > > > > Why you do not use "dummy" clock for "per" here?
> > > > > 
> > > > > *for "ipg"
> > > > 
> > > > Because the same clock is used for the register clock and the baudrate
> > > > clock. You have to enable the ipg clock to access registers.
> > > 
> > > I am not see any "ipg" clock usage in the spi driver.
> > 
> > It's the register clock. The driver enables it in order to access the
> > registers.
> > 
> > > If "ipg" clock is
> > > a dependency for "per" clock, it should be registered in ccm as parent.
> > 
> > Look, the eCSPI unit has two clock inputs, one for accessing the
> > registers (ipg) and one for generating the SPI bit clock (per). Now the
> > CSPI unit only has a single clock input, so the 100% correct way would
> > be to specify only a single clock for this unit. However, since we
> > handle both units with the same driver the simplest way to cope with
> > it is to provide the very same clock twice, once for the register access
> > and once for generating the SPI bit clock.
> > And yes, we have to specify the real clock twice and can't replace one
> > with a dummy clock, because if we specify a dummy clock for the ipg
> > clock, then the driver couldn't access the registers even if it enabled
> > the clock. If we would replace the SPI bit clock with a dummy clock then
> > the device couldn't send data even if the driver enabled the bit clock.
> > (That of course only becomes relevant when the driver actually
> > en/disables the clocks during runtime and not only once during probe).
> 
> Well, I completely forgot about the clock for registers.
> Everything looks right then.
> However, it would be nice to add a few words about the clocks in the
> Documentation/devicetree/bindings/spi/fsl-imx~spi.txt
> Thanks for the clarification.

the spi device i got, only keeps working if having the per2_gate
enabled.

It also seems that we lost that dependency, as the file
arch/arm/mach-imx/clk-imx27.c contains this:

clk_register_clkdev(clk[per2_gate], "per", "imx27-cspi.0");
clk_register_clkdev(clk[cspi1_ipg_gate], "ipg", "imx27-cspi.0");
clk_register_clkdev(clk[per2_gate], "per", "imx27-cspi.1");
clk_register_clkdev(clk[cspi2_ipg_gate], "ipg", "imx27-cspi.1");
clk_register_clkdev(clk[per2_gate], "per", "imx27-cspi.2");
clk_register_clkdev(clk[cspi3_ipg_gate], "ipg", "imx27-cspi.2");

So my suggestion is as follows:

From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH] ARM: dts: imx: fix clocks for cspi

The CSPI controller needs the per2_gate clock to work.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/boot/dts/imx27.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 7f7d4a5..14683c3 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -169,7 +169,7 @@
 				compatible = "fsl,imx27-cspi";
 				reg = <0x1000e000 0x1000>;
 				interrupts = <16>;
-				clocks = <&clks 53>, <&clks 53>;
+				clocks = <&clks 53>, <&clks 60>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -180,7 +180,7 @@
 				compatible = "fsl,imx27-cspi";
 				reg = <0x1000f000 0x1000>;
 				interrupts = <15>;
-				clocks = <&clks 52>, <&clks 52>;
+				clocks = <&clks 52>, <&clks 60>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -345,7 +345,7 @@
 				compatible = "fsl,imx27-cspi";
 				reg = <0x10017000 0x1000>;
 				interrupts = <6>;
-				clocks = <&clks 51>, <&clks 51>;
+				clocks = <&clks 51>, <&clks 60>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
-- 
1.8.3.1

Thanks,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
