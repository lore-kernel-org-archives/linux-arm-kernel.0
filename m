From: robherring2@gmail.com (Rob Herring)
Date: Mon, 17 Oct 2011 18:11:56 -0500
Subject: [RFC] clocktree representation in the devicetree
In-Reply-To: <20111017184358.GD18141@pengutronix.de>
References: <20111017102921.GA18141@pengutronix.de>
	<4E9C5F71.5070608@gmail.com>
	<20111017184358.GD18141@pengutronix.de>
Message-ID: <4E9CB63C.1000200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2011 01:43 PM, Sascha Hauer wrote:
> On Mon, Oct 17, 2011 at 12:01:37PM -0500, Rob Herring wrote:
>> Sascha,
>>
>> On 10/17/2011 05:29 AM, Sascha Hauer wrote:
>>>
>>> Hi All,
>>>
>>> The following is an attempt to represent the clocktree of a i.MX53 in
>>> the devicetree. I created this to see how it would look like and to
>>> start a discussion whether we want to move in this direction or not.
>>>
>>> Some things to consider:
>>>
>>> - It seems to be very flexible. A board can customize the clock tree
>>>   by just adding some clk-parent=<phandle> properties to the muxers.
>>> - clocks can easily be associated with devices.
>>>
>>> but:
>>>
>>> - The following example registers 127 new platform devices and it's
>>>   not even complete. This adds significant overhead to initialization.
>>>
>>
>> Why? You should only get platform devices if you declare the clocks
>> block as a simple bus.
>>
>> I like the clk tree hierarchy reflected in the DT hierarchy. This would
>> make init ordering easier. However, there is one major problem I see.
>> You can only describe 1 configuration of the clock tree. How do you show
>> all possible muxing options for clocks? We need to describe what the mux
>> options are, but not what the current selection is as that is
>> discoverable already.
> 
> The way I did it only dividers and gates are child nodes of their
> parents. The muxes instead are located at the base of the clock tree and
> have a parent property which describes all possible parents. A board
> could then add a current-parent = <phandle> property in its board dts
> (similar to the status = enabled property). Something like this:
> 
> imx53.dtsi:
> 
> ...
> 		periph_apm: clkmux-periph_apm at 0x53fd4018 {
> 			reg = <0x53fd4018 0x0>;
> 			shift = <0x00000000>;
> 			width = <0x00000002>;
> 			parent = <&pll1 &pll3 &lp_apm 0>;
> 			compatible = "fsl,imx51-clk-mux";
> 		};
> ...
> 
> imx53-qsb.dts:
> 
> 		periph_apm: clkmux-periph_apm at 0x53fd4018 {
> 			current_parent = <&pll3>
> 		};
> 

Okay. Missed that not going far enough down into the dts...

So either a clock can have an explicit parent (or list) or can inherit
from the parent node. That aligns pretty well with how interrupts are done.

Perhaps it should be "clock-parent" rather than just parent.

> 
> So the entry in imx53-qsb.dts is used to describe what a board wants
> and not what the current status is.
> 
I worry that that could result in a lot of combinations of DT's that
won't boot. If it's all generic code, how do you ensure things are done
in the right order. There's lots of gotchas ensuring clocks stay in the
right ranges and ratios when you change them. I don't think the clock
hierarchy alone is enough information. As a simple example, what is the
maximum frequency of internal bus clocks. That is one of the primary
differences between MX51 and MX53 clocks.

Granted this problem exists already, but is it just making it easier to
hang yourself?

>>
>> Will clocks ever become generic enough that it makes sense to describe
>> clocks in DT at the level of muxes, dividers, gates, etc.?
> 
> I think yes. On i.MX processors you only need dividers, gates, muxes and
> plls. On other SoCs there may be table based dividers, power-of-2
> dividers or similar stuff, but overall there should be a quite limited
> set of features to be described.
> 

So how do you bind a "fsl,imx51-clk-mux" to yet to be written generic
clock mux code? More importantly, are the properties exposed sufficient?

While we may ultimately want the compatible strings to be SOC specific,
it would be good to start by generically defining bindings for dividers,
muxes, and gates and ensure we have something that works for all SOCs.

>> Perhaps it
>> makes more sense to just describe the clock controller to device
>> connections and any board level clocks in the DT.
> 
> Describing the clock tree in the device tree also makes it possible for
> a board to customize the divider/PLL/mux settings.
> Consider a SoC with a PLL where several different devices can derive its
> clock from.  One board may want to move all other devices away from this
> PLL and use it exclusively for sound to get an exact rate. Another might
> use it for the pixel clock and a third one selects a good compromise
> between an exact sound clock and the pixel clock. Not describing this in
> the device tree means that we need board specific code with
> clk_get/clk_get_parent/clk_set_rate orgies. 
> I gave up on creating clock code that magically tries to do everything
> right based on clk_* functions. With the example above how should the
> clock code know how to adjust the mentioned PLL? If you managed to get
> it right for one SoC the next totally different SoC will already be in
> the pipeline.
> 
Good point. I guess the board specifics can go all the way back up the
clock tree.

It's good to see a real example. but it would be nice to see some
documentation to update this:

http://www.devicetree.org/ClockBindings

Do you have any code using this? I've updated the OF clock support based
on Mike's latest common clk code that I need to send out. But it's based
on the above clock binding.

Rob
