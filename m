From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 21 Aug 2017 10:30:05 +0200
Subject: [linux-sunxi] [PATCH 07/13] ARM: sun8i: h3: add display engine
 pipeline barebone
In-Reply-To: <fcbff773f61061bbc0f1d6ffef2a7c35@aosc.io>
References: <20170801131304.7741-1-icenowy@aosc.io>
 <20170801131304.7741-8-icenowy@aosc.io>
 <1773537.vAqre0jhCE@jernej-laptop>
 <fcbff773f61061bbc0f1d6ffef2a7c35@aosc.io>
Message-ID: <20170821083005.4ujfk5g3kqgqofwl@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 02, 2017 at 01:07:55PM +0800, icenowy at aosc.io wrote:
> ? 2017-08-02 12:47?Jernej ?krabec ???
> > Hi Icenowy,
> > 
> > Dne torek, 01. avgust 2017 ob 15:12:58 CEST je Icenowy Zheng napisal(a):
> > > As we have already the support for the DE2 on Allwinner H3, add the
> > > display engine pipeline device tree nodes to its DTSI file.
> > > 
> > > The H5 pipeline has some differences and will be enabled later.
> > > 
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > ---
> > >  arch/arm/boot/dts/sun8i-h3.dtsi | 170
> > > ++++++++++++++++++++++++++++++++++++++++ 1 file changed, 170
> > > insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi
> > > b/arch/arm/boot/dts/sun8i-h3.dtsi index b36f9f423c39..75ad7b65a7fc
> > > 100644
> > > --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> > > +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> > > @@ -41,6 +41,8 @@
> > >   */
> > > 
> > >  #include "sunxi-h3-h5.dtsi"
> > > +#include <dt-bindings/clock/sun8i-de2.h>
> > > +#include <dt-bindings/reset/sun8i-de2.h>
> > > 
> > >  / {
> > >  	cpus {
> > > @@ -72,6 +74,174 @@
> > >  		};
> > >  	};
> > > 
> > > +	de: display-engine {
> > > +		compatible = "allwinner,sun8i-h3-display-engine";
> > > +		allwinner,pipelines = <&mixer0>,
> > > +				      <&mixer1>;
> > > +		status = "disabled";
> > > +	};
> > > +
> > > +	soc {
> > > +		display_clocks: clock at 1000000 {
> > > +			compatible = "allwinner,sun8i-a83t-de2-clk";
> > > +			reg = <0x01000000 0x100000>;
> > > +			clocks = <&ccu CLK_BUS_DE>,
> > > +				 <&ccu CLK_DE>;
> > > +			clock-names = "bus",
> > > +				      "mod";
> > > +			resets = <&ccu RST_BUS_DE>;
> > > +			#clock-cells = <1>;
> > > +			#reset-cells = <1>;
> > > +			assigned-clocks = <&ccu CLK_DE>;
> > > +			assigned-clock-parents = <&ccu CLK_PLL_DE>;
> > > +			assigned-clock-rates = <432000000>;
> > > +		};
> > 
> > I believe Maxime ask you to use clk_set_rate() in the past:
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2017-June/512909.html
> 
> Yes, but I think the frequency is still part of our configuration,
> not forced by the hardware.
> 
> If we set it in the driver, why don't we set it to 300MHz?
> 
> (In fact for pipelines without TVE we can really use 300MHz for
> CLK_DE, and if we do not want 4K we can even use lower frequency)

You should ask yourself another question. Do you absolutely need that
rate and parent to operate properly?

If the answer is yes, the DT is not what you're looking for, it
provides no guarantee on the changes to the clock rate and parenthood,
and doesn't allow you to act upon those changes either.

If you want to make it work, you need to have some code to do that.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/cda8cd81/attachment.sig>
