From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 4 Feb 2014 10:27:50 +0100
Subject: [PATCH v3 1/8] clk: sunxi: Add Allwinner A20/A31 GMAC clock unit
In-Reply-To: <CAGb2v64+qiBqYtWyc23b6p4aWyWj7a9K1qveTsW7ZGh0ti8_Wg@mail.gmail.com>
References: <1391398346-5094-1-git-send-email-wens@csie.org>
 <1391398346-5094-2-git-send-email-wens@csie.org>
 <20140203193108.GC25625@lukather>
 <CAGb2v64+qiBqYtWyc23b6p4aWyWj7a9K1qveTsW7ZGh0ti8_Wg@mail.gmail.com>
Message-ID: <20140204092750.GK25625@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 10:43:33AM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Tue, Feb 4, 2014 at 3:31 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Mon, Feb 03, 2014 at 11:32:19AM +0800, Chen-Yu Tsai wrote:
> >> The Allwinner A20/A31 clock module controls the transmit clock source
> >> and interface type of the GMAC ethernet controller. Model this as
> >> a single clock for GMAC drivers to use.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> ---
> >>  Documentation/devicetree/bindings/clock/sunxi.txt | 26 +++++++
> >>  drivers/clk/sunxi/clk-sunxi.c                     | 83 +++++++++++++++++++++++
> >>  2 files changed, 109 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> >> index 0cf679b..f43b4c0 100644
> >> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> >> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> >> @@ -37,6 +37,7 @@ Required properties:
> >>       "allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
> >>       "allwinner,sun4i-mod0-clk" - for the module 0 family of clocks
> >>       "allwinner,sun7i-a20-out-clk" - for the external output clocks
> >> +     "allwinner,sun7i-a20-gmac-clk" - for the GMAC clock module on A20/A31
> >>
> >>  Required properties for all clocks:
> >>  - reg : shall be the control register address for the clock.
> >> @@ -50,6 +51,9 @@ Required properties for all clocks:
> >>       If the clock module only has one output, the name shall be the
> >>       module name.
> >>
> 
> 
> >> +For "allwinner,sun7i-a20-gmac-clk", the parent clocks shall be fixed rate
> >> +dummy clocks at 25 MHz and 125 MHz, respectively. See example.
> >> +
> 
> 
> >>  Clock consumers should specify the desired clocks they use with a
> >>  "clocks" phandle cell. Consumers that are using a gated clock should
> >>  provide an additional ID in their clock property. This ID is the
> >> @@ -96,3 +100,25 @@ mmc0_clk: clk at 01c20088 {
> >>       clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> >>       clock-output-names = "mmc0";
> >>  };
> >> +
> >> +mii_phy_tx_clk: clk at 2 {
> >> +     #clock-cells = <0>;
> >> +     compatible = "fixed-clock";
> >> +     clock-frequency = <25000000>;
> >> +     clock-output-names = "mii_phy_tx";
> >> +};
> >> +
> >> +gmac_int_tx_clk: clk at 3 {
> >> +     #clock-cells = <0>;
> >> +     compatible = "fixed-clock";
> >> +     clock-frequency = <125000000>;
> >> +     clock-output-names = "gmac_int_tx";
> >> +};
> >> +
> >> +gmac_clk: clk at 01c20164 {
> >> +     #clock-cells = <0>;
> >> +     compatible = "allwinner,sun7i-a20-gmac-clk";
> >> +     reg = <0x01c20164 0x4>;
> >> +     clocks = <&mii_phy_tx_clk>, <&gmac_int_tx_clk>;
> >
> > You should also document in which order you expect the parents to
> > be. Or it will probably be easier to just use clock-names here.
> 
> Is it not clear from the "Required properties" section above?

I'd make it clearer. But again, using clock-names would avoid any
ambiguity, and be more flexible.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/e48653e2/attachment.sig>
