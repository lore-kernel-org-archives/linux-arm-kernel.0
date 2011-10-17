From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 Oct 2011 20:43:58 +0200
Subject: [RFC] clocktree representation in the devicetree
In-Reply-To: <4E9C5F71.5070608@gmail.com>
References: <20111017102921.GA18141@pengutronix.de>
	<4E9C5F71.5070608@gmail.com>
Message-ID: <20111017184358.GD18141@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2011 at 12:01:37PM -0500, Rob Herring wrote:
> Sascha,
> 
> On 10/17/2011 05:29 AM, Sascha Hauer wrote:
> > 
> > Hi All,
> > 
> > The following is an attempt to represent the clocktree of a i.MX53 in
> > the devicetree. I created this to see how it would look like and to
> > start a discussion whether we want to move in this direction or not.
> > 
> > Some things to consider:
> > 
> > - It seems to be very flexible. A board can customize the clock tree
> >   by just adding some clk-parent=<phandle> properties to the muxers.
> > - clocks can easily be associated with devices.
> > 
> > but:
> > 
> > - The following example registers 127 new platform devices and it's
> >   not even complete. This adds significant overhead to initialization.
> > 
> 
> Why? You should only get platform devices if you declare the clocks
> block as a simple bus.
> 
> I like the clk tree hierarchy reflected in the DT hierarchy. This would
> make init ordering easier. However, there is one major problem I see.
> You can only describe 1 configuration of the clock tree. How do you show
> all possible muxing options for clocks? We need to describe what the mux
> options are, but not what the current selection is as that is
> discoverable already.

The way I did it only dividers and gates are child nodes of their
parents. The muxes instead are located at the base of the clock tree and
have a parent property which describes all possible parents. A board
could then add a current-parent = <phandle> property in its board dts
(similar to the status = enabled property). Something like this:

imx53.dtsi:

...
		periph_apm: clkmux-periph_apm at 0x53fd4018 {
			reg = <0x53fd4018 0x0>;
			shift = <0x00000000>;
			width = <0x00000002>;
			parent = <&pll1 &pll3 &lp_apm 0>;
			compatible = "fsl,imx51-clk-mux";
		};
...

imx53-qsb.dts:

		periph_apm: clkmux-periph_apm at 0x53fd4018 {
			current_parent = <&pll3>
		};


So the entry in imx53-qsb.dts is used to describe what a board wants
and not what the current status is.

> 
> Will clocks ever become generic enough that it makes sense to describe
> clocks in DT at the level of muxes, dividers, gates, etc.?

I think yes. On i.MX processors you only need dividers, gates, muxes and
plls. On other SoCs there may be table based dividers, power-of-2
dividers or similar stuff, but overall there should be a quite limited
set of features to be described.

> Perhaps it
> makes more sense to just describe the clock controller to device
> connections and any board level clocks in the DT.

Describing the clock tree in the device tree also makes it possible for
a board to customize the divider/PLL/mux settings.
Consider a SoC with a PLL where several different devices can derive its
clock from.  One board may want to move all other devices away from this
PLL and use it exclusively for sound to get an exact rate. Another might
use it for the pixel clock and a third one selects a good compromise
between an exact sound clock and the pixel clock. Not describing this in
the device tree means that we need board specific code with
clk_get/clk_get_parent/clk_set_rate orgies. 
I gave up on creating clock code that magically tries to do everything
right based on clk_* functions. With the example above how should the
clock code know how to adjust the mentioned PLL? If you managed to get
it right for one SoC the next totally different SoC will already be in
the pipeline.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
