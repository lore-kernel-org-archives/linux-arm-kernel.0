From: plaes@plaes.org (Priit Laes)
Date: Wed, 01 Mar 2017 21:41:55 +0200
Subject: [linux-sunxi] [PATCH 3/4] ARM: sun7i: Convert to CCU
In-Reply-To: <bca96944-bd58-5011-5eb9-01c4a1440fe2@elopez.com.ar>
References: <20170227210914.18954-1-plaes@plaes.org>
 <20170227210914.18954-4-plaes@plaes.org>
 <bca96944-bd58-5011-5eb9-01c4a1440fe2@elopez.com.ar>
Message-ID: <1488397315.29650.1.camel@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-02-28 at 14:01 -0300, Emilio L?pez wrote:
> Hi,
> 
> I spotted a couple of things here on a quick look, see below
> 
> El 27/02/17 a las 18:09, Priit Laes escribi?:
> > Convert sun7i-a20.dtsi to new CCU driver.
> > 
> > > > Signed-off-by: Priit Laes <plaes@plaes.org>
> > ---
> > ?arch/arm/boot/dts/sun7i-a20.dtsi | 719 +++++----------------------------------
> > ?1 file changed, 86 insertions(+), 633 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> > index 04c9977..6f80cb8 100644
> > --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> > +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> > @@ -47,7 +47,8 @@
> > ?#include <dt-bindings/interrupt-controller/arm-gic.h>
> > ?#include <dt-bindings/thermal/thermal.h>
> > ?
> > -#include <dt-bindings/clock/sun4i-a10-pll2.h>
> > +#include <dt-bindings/clock/sun7i-ccu.h>
> > +#include <dt-bindings/reset/sun7i-ccu.h>
> > ?#include <dt-bindings/dma/sun4i-a10.h>
> > ?#include <dt-bindings/pinctrl/sun4i-a10.h>
> > ?
> > @@ -67,19 +68,19 @@
> > > > ?			compatible = "allwinner,simple-framebuffer",
> > > > ?				?????"simple-framebuffer";
> > > > ?			allwinner,pipeline = "de_be0-lcd0-hdmi";
> > > > -			clocks = <&ahb_gates 36>, <&ahb_gates 43>,
> > > > -				?<&ahb_gates 44>, <&de_be0_clk>,
> > > > -				?<&tcon0_ch1_clk>, <&dram_gates 26>;
> > > > +			clocks = <&ccu CLK_AHB_LCD0>, <&ccu CLK_AHB_HDMI1>,
> > > > +				?<&ccu CLK_AHB_DE_BE0>, <&ccu CLK_DE_BE0>,
> > > > +				?<&ccu CLK_TCON0_CH1>, <&ccu CLK_DRAM_DE_BE0>;
> > > > ?			status = "disabled";
> > > > ?		};
> > ?
> > > > -		framebuffer at 1 {
> > +		framebuffer at 0 {
> 
> This looks like an unrelated change

Yup, that 's leftover from changes made during initial debugging. Will
fix in v2.

> 
> > @@ -184,21 +185,11 @@
> > ?
> > > > > > ?		osc24M: clk at 01c20050 {
> > > > ?			#clock-cells = <0>;
> > > > -			compatible = "allwinner,sun4i-a10-osc-clk";
> > > > -			reg = <0x01c20050 0x4>;
> > > > +			compatible = "fixed-clock";
> > > > ?			clock-frequency = <24000000>;
> > > > ?			clock-output-names = "osc24M";
> > ?		};
> 
> allwinner,sun4i-a10-osc-clk implements a gate apart from a fixed clock,
> is the feature loss intended?

This is how most of the existing drivers handle it (A13, A31, A33) so I
didn't want to do anything fancy.. 
Besides, the code for clock actually configures gate:

static SUNXI_CCU_GATE(hosc_clk, "hosc", "osc24M", 0x050, BIT(0), 0);


P?ikest,
Priit 
