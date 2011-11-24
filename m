From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 24 Nov 2011 12:01:29 +0800
Subject: [RFC PATCH 1/3] arm/imx6: describe clocks in device tree source
In-Reply-To: <20111122085649.GC27267@pengutronix.de>
References: <1321926536-671-1-git-send-email-shawn.guo@linaro.org>
 <1321926536-671-2-git-send-email-shawn.guo@linaro.org>
 <20111122085649.GC27267@pengutronix.de>
Message-ID: <20111124040128.GC17979@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 09:56:49AM +0100, Sascha Hauer wrote:
> On Tue, Nov 22, 2011 at 09:48:54AM +0800, Shawn Guo wrote:
> > It adds document for imx clock device tree bindings and then describes
> > imx6 clocks in dts.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  .../devicetree/bindings/clock/clock-imx.txt        |  124 +++
> >  arch/arm/boot/dts/imx6q.dtsi                       |  943 +++++++++++++++++++-
> >  2 files changed, 1058 insertions(+), 9 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/clock/clock-imx.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/clock-imx.txt b/Documentation/devicetree/bindings/clock/clock-imx.txt
> > new file mode 100644
> > index 0000000..5c597d9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/clock-imx.txt
> > @@ -0,0 +1,124 @@
> > +* Device Tree Bindings for Freescale i.MX Clock
> > +
> > +== Clock Gate ==
> > +
> > +Required properties:
> > +- imx,clock-gate:  It's a two 32-bit integers array.  The first
> > +  integer specifies the offset of the gate register, and the second
> > +  one specifies the bit mask of the gate for this clock.
> 
> On i.MX53 we have two bit gates:
> 
> 00b disable
> 01b disable in stop mode, enable in run mode
> 10b reserved
> 11b enable
> 
> I can't find this description in my i.MX6RM, but I suppose it's the same
> here. Do you have plans for these? Currently only disable and enable
> seem to be handled.
> 
Yes, imx6 is same as imx5 on this.  It's something missing from clock
driver rather than binding.  The binding only describes the shift and
mask of the gate bits, and the encoding of the bits is left to clock
driver.  And I plan to add support for cases 01b and 10b when the need
occurs.

> 
> > +
> > +		pll2_pfd_clk: pll2-pfd {
> > +			compatible = "fsl,imx6q-pfd";
> > +			#clock-cells = <3>;
> > +			imx,clock-gate = <0x100 0x80>,
> > +					 <0x100 0x8000>,
> > +					 <0x100 0x800000>;
> > +			imx,clock-divider = <0x100 0 0 0 6>,
> > +					    <0x100 0 0 8 6>,
> > +					    <0x100 0 0 16 6>;
> > +			clock-input = <&pll_bus_clk 0>;
> > +			clock-input-name = "pll2-bus";
> > +			clock-output-name = "pll2-pfd-352m",
> > +					    "pll2-pfd-594m",
> > +					    "pll2-pfd-400m";
> > +		};
> 
> Does this pll simultaneously have three different output frequencies?
> I'm not familiar with the i.MX6 yet.
> 
This is not a PLL.  Instead, they are 3 PFDs having the PLL2 as the
parent clock.

> > +
> > +		can_root_clk: can-root {
> > +			compatible = "fsl,imx6q-clock";
> > +			#clock-cells = <1>;
> > +			imx,clock-divider = <0x20 0 0 2 6>;
> > +			clock-input = <&pll_usb_clk 0 0>;
> > +			clock-input-name = "pll3-usb-otg";
> > +			clock-output-name = "can-root";
> > +		};
> > +
> > +		can_clk: can {
> > +			compatible = "fsl,imx6q-clock";
> > +			#clock-cells = <4>;
> > +			imx,clock-gate = <0x68 0xc000>,
> > +					 <0x68 0x30000>,
> > +					 <0x68 0xc0000>,
> > +					 <0x68 0x300000>;
> > +			clock-input = <&can_root_clk 0>;
> > +			clock-input-name = "can-root";
> > +			clock-output-name = "can1",
> > +					    "can1-serial",
> > +					    "can2",
> > +					    "can2-serial";
> > +		};
> > +
> > +		ecspi_root_clk: ecspi-root {
> > +			compatible = "fsl,imx6q-clock";
> > +			#clock-cells = <1>;
> > +			imx,clock-divider = <0x38 0 0 19 6>;
> > +			clock-input = <&pll3_div_clk 2 0 0>;
> > +			clock-input-name = "pll3-60m";
> > +			clock-output-name = "ecspi-root";
> > +		};
> 
> I'm not sure you do yourself a favour if you skip all the muxes and
> assume reset default for them. The ecspi-root parent is a mux The mux
> seems to be missing in the can clock, uart and probably others.
> 
I'm looking at IMX6DQRM.pdf 'Rev. B, 07/2011'.  I do not see mux for
ECSPI_CLK_ROOT as well as other clocks you mentioned.  Instead, I can
only see divider for these clocks.  Can you point out the registers
and bits of these muxes you are seeing with these clocks?

> > +
> > +		ecspi_clk: ecspi {
> > +			compatible = "fsl,imx6q-clock";
> > +			#clock-cells = <5>;
> > +			imx,clock-gate = <0x6c 0x3>,
> > +					 <0x6c 0xc>,
> > +					 <0x6c 0x30>,
> > +					 <0x6c 0xc0>,
> > +					 <0x6c 0x300>;
> > +			clock-input = <&ecspi_root_clk 0>;
> > +			clock-input-name = "ecspi-root";
> > +			clock-output-name = "ecspi1",
> > +					    "ecspi2",
> > +					    "ecspi3",
> > +					    "ecspi4",
> > +					    "ecspi5";
> > +		};
> > +
> 
> [...]
> 
> > +
> > +		uart_clk: uart {
> > +			compatible = "fsl,imx6q-clock";
> > +			#clock-cells = <2>;
> > +			imx,clock-gate = <0x7c 0x3000000>,
> > +					 <0x7c 0xc000000>;
> > +			imx,clock-divider = <0x24 0 0 0 6>,
> > +					    <0x24 0 0 0 6>;
> > +			clock-input = <&pll3_div_clk 1 0 0>;
> > +			clock-input-name = "pll3-80m";
> > +			clock-output-name = "uart",
> > +					    "uart-serial";
> > +		};
> 
> This seems wrong. The UARTs have two clocks, the register clock and the
> baud clock. parent of the baud clock is uart-root (the mux is missing
> here) and parent of the register clock is the ipg clock. This node only
> has one parent.
> 
Yes, this is wrong.  Thanks for catching.  But still I do not see mux
for uart-root but only divider.

Regards,
Shawn
