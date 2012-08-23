From: matt@genesi-usa.com (Matt Sealey)
Date: Wed, 22 Aug 2012 19:08:40 -0500
Subject: [PATCH 2/2] ARM: imx6q: replace clk_register_clkdev with clock DT
 lookup
In-Reply-To: <CAKGA1bkNGJhsCGVBsHnaQn=Dg5T==QP_JnqOXycq8jQn-W-0Kw@mail.gmail.com>
References: <1345104526-14797-1-git-send-email-shawn.guo@linaro.org>
 <1345104526-14797-3-git-send-email-shawn.guo@linaro.org>
 <503232E0.3000007@gmail.com>
 <CAKGA1bn2uCWE8YkGR4EzTxZ_bXJ_ov2diq63uxQ=dT7b6Fu9GQ@mail.gmail.com>
 <20120820151609.GN24242@S2101-09.ap.freescale.net>
 <CAKGA1bnfhMC8QG9OqBbpy5iq6ZAfEgrYMg_LVd50U7yikLhDAg@mail.gmail.com>
 <503384E3.4030705@calxeda.com>
 <CAKGA1bkNGJhsCGVBsHnaQn=Dg5T==QP_JnqOXycq8jQn-W-0Kw@mail.gmail.com>
Message-ID: <CAKGA1bnCk=FqANsVFD123y3uP5dn9AMZydR__mMXrzh6StrBjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ugh. Okay my blood sugar was super low. Can I just condense that into
I agree with Russell and the binding makes no sense once it gets past
the simple definition described in the binding?

If we take the pinctrl mess as an example, all the DT serves to do is
define an SoC-specific or family-specific binding into data the
pinctrl subsystem can use, via an SoC-specific abstraction in a driver
to make a generic subsystem in Linux work the way it should.

The common clock subsystem is no different - divider, fixed factor,
fixed rate, mux, gate, highbank (??) are defined in a way that
abstracts most of the actual SoC-specific stuff out to register
offsets, values, bit definitions and masks.

Right now for i.MX we have several abstraction interfaces
(imx_clk_XXX) which move values from tables around and call the
appropriate common clock function to register the clock. These
abstractions are identical for all the possible i.MX SoCs
(imx_clk_gate2, imx_clk_mux etc.) and move the values around so they
can be passed to clk_register_##same.

So if we can define a fixed-clock, why can't we define an
fsl,gated-clock or fsl,muxed-clock which defines an i.MX clock of that
type, and a much smaller subset of code that stuffs these values in
through a small abstraction and remove all these seperate
clk-imx51-imx53.c, clk-imx6q.c, clk-imx31.c files which are sharing
common functionality into one mega-abstraction which works across the
whole family?

The way I understand the binding right now (and I'm looking at this;
http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=blob_plain;f=Documentation/devicetree/bindings/clock/clock-bindings.txt;hb=766e6a4ec602d0c107553b91b3434fe9c03474f4),
this is entirely what the clock binding is saying we should do. But I
don't understand why we're naming inputs and outputs, but not defining
how these signals are routed (possibly through gate bits in registers)
and leaving that down to some driver somewhere. Or why we have to name
clocks twice, once for the canonical name of the output in reference
to a higher level or root clock "uart_serial", vs. a driver-level name
for that input or output in the driver ("per"), since most clocks at
the driver level can't be re-used for other things anyway. If they
could, the whole prepare/unprepare and some explicit parenting/muxing
of clocks would handle that anyway so that the clock was enabled while
there was at least one user.

I do understand that in Shawn's patch and using UART as an example
again, "ipg" and "per" are definitely needed by the driver, and these
names are defined by the driver and implicit in the documentation to
enable the use of this unit, but at the end of the day the definition
at the *device* level (uart@) makes no sense except to perform a
lookup on a string, and in the end this string lookup only gets done
at the driver probe time anyway. With a standard definition of these
"ipg" and "per" strings per family of SoC or even in a generic fashion
across all possible SoCs (in this case, both are defined using
imx_clk_gate2()) then a node defining that clock and it's magical
driver-specific name would work just as well by phandle reference, and
it's parents are referenced by phandle, and all this stays within
SoC-specific abstraction of the common clocks and turns into normal
common clock structure stuff anyway (so you still get to do a string
lookup, but it's being stuffed by an i.MX driver and registered from
data it pulled from the DT).

Wouldn't we rather have a single device tree parser and clock
registration for i.MX than the current 7 which would get split into 7
clock registration drivers with some helpers that parsed half of it
via device tree? I don't really see what benefit you get out of going
for the halfway-defined model.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.


On Wed, Aug 22, 2012 at 5:50 PM, Matt Sealey <matt@genesi-usa.com> wrote:
> On Tue, Aug 21, 2012 at 7:53 AM, Rob Herring <rob.herring@calxeda.com> wrote:
>>
>>> How do you explain duplicating the clock names in the array AND in the
>>> device node as NOT being bloated?
>>
>> Read the clock binding doc. Names are optional and the 2 names are not
>> the same. One is the name of the output on the CCM and one is the name
>> on input to the module.
>
> My understanding of the i.MX clock tree naming in the docs, though, is
> that the names in the DT don't match the ones in the docs, regardless.
>
> I also don't understand how lots of nodes in a tree *is* lots of
> bloat, by Shawn's definition, but lots of entirely Linux- and
> common-clock-framework-specific names in a table *isn't* bloat even if
> most of these clocks and names are not used for devices in the tree
> anyway.
>
> Device trees shouldn't encode data that is entirely specific to a
> Linux driver. Even if the only user is Linux, you are not describing
> the Linux driver, you are describing the hardware. The names match the
> hardware specification in the CCM chapters of the manual, but just
> barely. All Shawn has done here is make the lookup in the DT, which is
> at the very least internally consistent (it's not referencing the
> order of an array elsewhere than the device tree), but an index into
> an array of strings is not the way we generally encode things in
> device trees since the dawn of time, and certainly shouldn't be
> acceptable behavior now.
>
> I might agree somewhat with Shawn that encoding every clock for the
> chip in the tree (some 190+ entries) and it's bits and entries is a
> ridiculous amount, but most boards don't need all the clocks or
> selects defined if they're not using those peripherals. There are ways
> to make sure boards do not over-define their clock tree (and any
> clocks not defined will not get enabled anyway).
>
> That the clock tree is SoC-specific doesn't mean it should not be
> encoded in the tree; the fact that Sascha could write a fairly
> comprehensive common clock subsystem shows that for certain families
> of SoC, certain groupings of clock mux, select and associations
> between unit clock (for instance to write to registers) and peripheral
> output clock (for instance to clock data to an MMC card or SPI bus or
> whatever) are fairly "common" as it stands. What is not common is the
> naming and the meaning of that naming, which in the end is only useful
> to drivers as debugging information anyway.
>
> What I don't get is why you'd implement a clock lookup as <&clk 160>
> <&clk 161> and then futher give them names like "ipg" "per", even if
> these were seperate clocks, it makes no sense to NAME them. If clock
> 160 is "uart_ipg" and 161 is "uart_serial", what are you gaining from
> the clock-names property inside the actual device definition? You're
> encoding the "ipg" root clock name twice, and "per" doesn't make any
> sense here.
>
> What's the difference with moving ALL the definitions of clock values
> from the driver (such as arch/arm/mach-imx/clk-mx51-mx53.c) into the
> DT and parsing it all out of the DT? Once it's registered then you
> have to look it up by name, but if each DT driver node (uart@ for
> example) references the clock node by phandle, it will be able to look
> up that exact clock by that phandle, correct? What I'm confused about
> right now is what the difference is between naming them "ipg" and
> "per" vs. "donkey" and "shrek"? This is just a driver-specific naming
> such that it can find these things and turn on and off the right
> clocks at the right time, but it doesn't make any sense to refer to
> the CCM node, then an index to a an array of names, then two more
> names defining the clock definition. uart_serial cannot be used for
> ANYTHING besides the uart "per" clock, so just encode this as a clock
> type in the individual clock node. The clkdev subsystem can resolve
> "per" to some magic value or the string in the tree...
>
> uart_ipg_clk: clock at foo {
>      clock-name = "uart";
>      fsl,clock-type = "ipg";
>      ...
> };
>
> uart at bar {
>      clocks = <&uart_ipg_clk, &uart_per_clk>
> };
>
> I counted here and we're not "bloating" anything in terms of bytes
> used to define the clocks - what we save in not doing an array lookup,
> we lose in defining a node. Tthis is not going to end the world. What
> you "waste" in the device tree, you get to automate in the Linux
> driver anyway and remove a bunch of tables, which is what Shawn's
> trying to do anyway. If the UART driver needs to do;
>
>         sport->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
>
> Then it has all the information it needs here; one of the phandle
> references points to a clock which has "ipg" as it's fsl,clock-type
> property. Or something else.
>
> It is going to be an SoC-specific binding, that's for sure, but since
> there is a definition for a fixed clock, why can't there be a
> definition for a gated clock (enable/disable), mux select defined as a
> group and possible selections, and the right clocks being defined with
> the right potential parents? The entire clock tree AND it's lookups
> can be built from device tree, per documentation, per actual SoC
> layout and the driver has to live with getting the information from
> somewhere other than the heady mix of a table in DT, and a table in
> Linux which don't necessarily depend on each other?
>
> You only have to do these lookups once when the clock subsystem starts
> on Linux, it's not like every time you want to go find a clock you
> have to actually enter a firmware interface, parse the entire device
> tree, come back out with a small snippet of data and then go off and
> do the stuff; it's been put in a readily-accessible structure, and
> gets done at device probe. Register them at boot, find them in the
> clock subsystem, you're ready to go.
>
> I would rather see every clock defined in the tree, as much "bloat" as
> you would seem to think it is, it makes no sense to have a huge table
> of clock definitions who's names and numbers are defined in the device
> tree, yet register offsets and bit widths and values and defaults and
> parents are defined in the driver itself along with lots of other
> lists and tables. The table in the DT is making a huge assumption
> about the subsystem needs to do the clock lookups and the way the
> *Linux drivers* themself actually works; this is wrong, wrong, wrong
> on so many levels.
>
>> While generally optional, Shawn has chosen to require at least the
>> output names. In the case of defining a signal clock controller node
>> with lots of outputs, that is the right choice.
>
> You only need to define the inputs and outputs you use, and in the end
> I think referencing an array of strings by phandle and index into a
> property contained in that handle, then looking up another string in
> it's own device node to make sure which clock is which, is more
> complex and takes longer than referencing a clock by phandle and
> looking at two specific properties defining that clock. If we're going
> this far, we should DEFINITELY be encoding the clock subsystems in the
> SoC entirely in the device tree and automating clock setup. If the
> common clock framework lives up to it's name, all you'd need is a
> single arch/arm/mach-imx/clk.c to map the specific operation for every
> i.MX SoC (i.e. bindings for i.MX) and not one for *every* i.MX SoC,
> and all this data can be adequately encoded in the DT.
>
> --
> Matt Sealey <matt@genesi-usa.com>
> Product Development Analyst, Genesi USA, Inc.
