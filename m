From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 May 2017 10:19:28 +0200
Subject: [linux-sunxi] Re: [RFC PATCH 10/11] ARM: sun8i: h3: add display
 engine pipeline for TVE
In-Reply-To: <B72028D8-B055-4F53-A4EA-7E93A28DB8FF@aosc.io>
References: <20170517164354.16399-1-icenowy@aosc.io>
 <20170517164354.16399-11-icenowy@aosc.io>
 <20170519180616.vzrlu2avuucsjkiu@flea.home>
 <B72028D8-B055-4F53-A4EA-7E93A28DB8FF@aosc.io>
Message-ID: <20170524081928.xcbepxdt7txnadki@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 20, 2017 at 02:10:35AM +0800, Icenowy Zheng wrote:
> 
> 
> ? 2017?5?20? GMT+08:00 ??2:06:16, Maxime Ripard <maxime.ripard@free-electrons.com> ??:
> >On Thu, May 18, 2017 at 12:43:53AM +0800, Icenowy Zheng wrote:
> >> As we have already the support for the TV encoder on Allwinner H3,
> >add
> >> the display engine pipeline device tree nodes to its DTSI file.
> >> 
> >> The H5 pipeline has some differences and will be enabled later.
> >> 
> >> The currently-unused mixer0 and tcon0 are also needed, for the
> >> completement of the pipeline.
> >> 
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> ---
> >>  arch/arm/boot/dts/sun8i-h3.dtsi | 189
> >++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 189 insertions(+)
> >> 
> >> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi
> >b/arch/arm/boot/dts/sun8i-h3.dtsi
> >> index b36f9f423c39..20172ef92415 100644
> >> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> >> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> >> @@ -41,6 +41,8 @@
> >>   */
> >>  
> >>  #include "sunxi-h3-h5.dtsi"
> >> +#include <dt-bindings/clock/sun8i-de2.h>
> >> +#include <dt-bindings/reset/sun8i-de2.h>
> >>  
> >>  / {
> >>  	cpus {
> >> @@ -72,6 +74,193 @@
> >>  		};
> >>  	};
> >>  
> >> +	de: display-engine {
> >> +		compatible = "allwinner,sun8i-h3-display-engine";
> >> +		allwinner,pipelines = <&mixer0>,
> >> +				      <&mixer1>;
> >> +		status = "disabled";
> >> +	};
> >> +
> >> +	soc {
> >> +		display_clocks: clock at 1000000 {
> >> +			compatible = "allwinner,sun8i-a83t-de2-clk";
> >> +			reg = <0x01000000 0x100000>;
> >> +			clocks = <&ccu CLK_BUS_DE>,
> >> +				 <&ccu CLK_DE>;
> >> +			clock-names = "bus",
> >> +				      "mod";
> >> +			resets = <&ccu RST_BUS_DE>;
> >> +			#clock-cells = <1>;
> >> +			#reset-cells = <1>;
> >> +			assigned-clocks = <&ccu CLK_DE>;
> >> +			assigned-clock-parents = <&ccu CLK_PLL_DE>;
> >> +			assigned-clock-rates = <432000000>;
> >
> >This shouldn't be set in the DT, but evaluated at runtime when calling
> >clk_set_rate.
> 
> Nope, DE2 clock doesn't need evalution, as the clock is decoupled with
> DE2 mixers' output signal. (Although it seems that SoCs with larger
> plane size will use higher clock.)

So it's the display engine that needs that clock to operate properly?
This is the wrong DT node to set that value then. It should be in the
mixer node, or even better in the mixers' driver.

> And setting it to 432MHz is also needed for properly 216MHz clock to
> TVE.

Just like the parenthood, this can and should be evaluated at runtime.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170524/68b8e86b/attachment.sig>
