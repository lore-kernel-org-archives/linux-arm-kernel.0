From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 20 Oct 2011 09:28:32 +0200
Subject: [RFC] clocktree representation in the devicetree
In-Reply-To: <4E9D9CA8.8060303@gmail.com>
References: <20111017102921.GA18141@pengutronix.de>
	<4E9C5F71.5070608@gmail.com>
	<20111017184358.GD18141@pengutronix.de>
	<4E9CB63C.1000200@gmail.com>
	<20111018071618.GI18141@pengutronix.de>
	<4E9D9CA8.8060303@gmail.com>
Message-ID: <20111020072832.GB23421@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2011 at 10:35:04AM -0500, Rob Herring wrote:
> Sascha,
> 
> On 10/18/2011 02:16 AM, Sascha Hauer wrote:
> > On Mon, Oct 17, 2011 at 06:11:56PM -0500, Rob Herring wrote:
> >> On 10/17/2011 01:43 PM, Sascha Hauer wrote:
> 
> snip
> 
> >>
> >> Okay. Missed that not going far enough down into the dts...
> >>
> >> So either a clock can have an explicit parent (or list) or can inherit
> >> from the parent node. That aligns pretty well with how interrupts are done.
> >>
> >> Perhaps it should be "clock-parent" rather than just parent.
> > 
> > Yes. Also we should make the difference clear between the possible
> > parents of a mux and the one the user wants to select. So maybe
> > 
> > 'clock-parent' for the possible parents of a mux
> > 
> > and
> > 
> > 'selected-clock-parent' for the one the user wants to have.
> > 
> 
> Looks good.
> 
> >>
> >>>
> >>> So the entry in imx53-qsb.dts is used to describe what a board wants
> >>> and not what the current status is.
> >>>
> >> I worry that that could result in a lot of combinations of DT's that
> >> won't boot. If it's all generic code, how do you ensure things are done
> >> in the right order. There's lots of gotchas ensuring clocks stay in the
> >> right ranges and ratios when you change them. I don't think the clock
> >> hierarchy alone is enough information. As a simple example, what is the
> >> maximum frequency of internal bus clocks. That is one of the primary
> >> differences between MX51 and MX53 clocks.
> > 
> > If a user selects higher rates than allowed for a SoC he's doomed, just
> > like he's doomed when he screws up the devicetree in other ways
> > nowadays.
> > 
> > I agree that there will be problems when critical bus timings should be
> > changed via the devicetree. This would either need special handling in
> > the kernel or simply should be dissallowed.
> > 
> >>
> >> Granted this problem exists already, but is it just making it easier to
> >> hang yourself?
> >>
> >>>>
> >>>> Will clocks ever become generic enough that it makes sense to describe
> >>>> clocks in DT at the level of muxes, dividers, gates, etc.?
> >>>
> >>> I think yes. On i.MX processors you only need dividers, gates, muxes and
> >>> plls. On other SoCs there may be table based dividers, power-of-2
> >>> dividers or similar stuff, but overall there should be a quite limited
> >>> set of features to be described.
> >>>
> >>
> >> So how do you bind a "fsl,imx51-clk-mux" to yet to be written generic
> >> clock mux code?
> > 
> > Well my first thought was to use normal (of-)platform devices, but as
> > mentioned this may have some unwanted overhead. In case of the mux
> > a generic mux could be used, so maybe compatible = "fsl,imx51-clk-mux",
> > "clk-mux" should do it. In case of a gate we'll probably need a i.MX5
> > specific variant as these SoCs use two bits for a single gate.
> > 
> 
> You can easily point a specific compatible property to a generic
> implementation. My concern is just that the binding properties be
> presented generically so everyone pays attention (hopefully).
> 
> >> More importantly, are the properties exposed sufficient?
> > 
> > No :)
> > 
> > At least there should be a propagates flag, but there may be more.
> > 
> 
> At least in the FSL BSP, that was always just an optimization to avoid
> walking the tree needlessly. I think it could be determined from parent
> and child information in the DT.

You mean something like 'propagate up until a clock has a sibling?'

I'm unsure whether this works as expected.

> 
> >>
> >> While we may ultimately want the compatible strings to be SOC specific,
> >> it would be good to start by generically defining bindings for dividers,
> >> muxes, and gates and ensure we have something that works for all SOCs.
> >>
> >>>> Perhaps it
> >>>> makes more sense to just describe the clock controller to device
> >>>> connections and any board level clocks in the DT.
> >>>
> >>> Describing the clock tree in the device tree also makes it possible for
> >>> a board to customize the divider/PLL/mux settings.
> >>> Consider a SoC with a PLL where several different devices can derive its
> >>> clock from.  One board may want to move all other devices away from this
> >>> PLL and use it exclusively for sound to get an exact rate. Another might
> >>> use it for the pixel clock and a third one selects a good compromise
> >>> between an exact sound clock and the pixel clock. Not describing this in
> >>> the device tree means that we need board specific code with
> >>> clk_get/clk_get_parent/clk_set_rate orgies. 
> >>> I gave up on creating clock code that magically tries to do everything
> >>> right based on clk_* functions. With the example above how should the
> >>> clock code know how to adjust the mentioned PLL? If you managed to get
> >>> it right for one SoC the next totally different SoC will already be in
> >>> the pipeline.
> >>>
> >> Good point. I guess the board specifics can go all the way back up the
> >> clock tree.
> >>
> >> It's good to see a real example. but it would be nice to see some
> >> documentation to update this:
> >>
> >> http://www.devicetree.org/ClockBindings
> >>
> >> Do you have any code using this? I've updated the OF clock support based
> >> on Mike's latest common clk code that I need to send out. But it's based
> >> on the above clock binding.
> > 
> > I wasn't aware of this page. As I see it I could rewrite my suggestion
> > so that it extends these clock bindings without really changing them.
> > I have no code working yet, I first wanted to see how the reactions are.
> > 
> 
> To be clear, these are just proposed bindings, so they can be changed
> still. In fact, Grant said at LPC that he wants to make some changes.
> Perhaps Grant can chime in.
> 
> Honestly, I like your proposal better. I think having a single clock per
> DT node is a good thing. This can simplify parsing the tree and should
> make implementing generic code easier.

Ah, I see. In the example given the pll has two clock outputs, 'pll'
and 'pll-switched'. That's not so nice, but can we avoid it? I'm
just thinking about a single register bit that switches multiple
clocks in hardware. On i.MX we don't have this, but maybe others do.

> 
> Do we need clock name strings on outputs or just phandles? Many
> intermediate clocks don't really need a name other than the phandle name.

If a single node represents one clock no name strings should be
necessary.

> 
> IIRC, Grant suggesting aligning with how doing reg names (aka
> resource_byname) was agreed upon at LPC. Something like this:
> 
> clocks = <&clk_phandle1, &clk_phandle2>;
> clock-names = <"clk1", "clk2">;
> 
> clock-names could then be optional.
> 
> Rob
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
