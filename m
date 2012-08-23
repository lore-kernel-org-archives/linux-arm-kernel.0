From: robherring2@gmail.com (Rob Herring)
Date: Wed, 22 Aug 2012 20:32:19 -0500
Subject: [PATCH 2/2] ARM: imx6q: replace clk_register_clkdev with clock
 DT lookup
In-Reply-To: <CAKGA1bnCk=FqANsVFD123y3uP5dn9AMZydR__mMXrzh6StrBjg@mail.gmail.com>
References: <1345104526-14797-1-git-send-email-shawn.guo@linaro.org>
 <1345104526-14797-3-git-send-email-shawn.guo@linaro.org>
 <503232E0.3000007@gmail.com>
 <CAKGA1bn2uCWE8YkGR4EzTxZ_bXJ_ov2diq63uxQ=dT7b6Fu9GQ@mail.gmail.com>
 <20120820151609.GN24242@S2101-09.ap.freescale.net>
 <CAKGA1bnfhMC8QG9OqBbpy5iq6ZAfEgrYMg_LVd50U7yikLhDAg@mail.gmail.com>
 <503384E3.4030705@calxeda.com>
 <CAKGA1bkNGJhsCGVBsHnaQn=Dg5T==QP_JnqOXycq8jQn-W-0Kw@mail.gmail.com>
 <CAKGA1bnCk=FqANsVFD123y3uP5dn9AMZydR__mMXrzh6StrBjg@mail.gmail.com>
Message-ID: <50358823.90400@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2012 07:08 PM, Matt Sealey wrote:
> Ugh. Okay my blood sugar was super low. Can I just condense that into
> I agree with Russell and the binding makes no sense once it gets past
> the simple definition described in the binding?

I can't speak for Russell, but I think his issue is addressed in v2.

> If we take the pinctrl mess as an example, all the DT serves to do is
> define an SoC-specific or family-specific binding into data the
> pinctrl subsystem can use, via an SoC-specific abstraction in a driver
> to make a generic subsystem in Linux work the way it should.

pinctrl changes much more board to board, so it's more valuable to have
in device tree. The changes from board to board in the clock tree are
much less.

> The common clock subsystem is no different - divider, fixed factor,
> fixed rate, mux, gate, highbank (??) are defined in a way that
> abstracts most of the actual SoC-specific stuff out to register
> offsets, values, bit definitions and masks.
> 
> Right now for i.MX we have several abstraction interfaces
> (imx_clk_XXX) which move values from tables around and call the
> appropriate common clock function to register the clock. These
> abstractions are identical for all the possible i.MX SoCs
> (imx_clk_gate2, imx_clk_mux etc.) and move the values around so they
> can be passed to clk_register_##same.
> 
> So if we can define a fixed-clock, why can't we define an
> fsl,gated-clock or fsl,muxed-clock which defines an i.MX clock of that
> type, and a much smaller subset of code that stuffs these values in
> through a small abstraction and remove all these seperate
> clk-imx51-imx53.c, clk-imx6q.c, clk-imx31.c files which are sharing
> common functionality into one mega-abstraction which works across the
> whole family?
>
> The way I understand the binding right now (and I'm looking at this;
> http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=blob_plain;f=Documentation/devicetree/bindings/clock/clock-bindings.txt;hb=766e6a4ec602d0c107553b91b3434fe9c03474f4),
> this is entirely what the clock binding is saying we should do. But I
> don't understand why we're naming inputs and outputs, but not defining
> how these signals are routed (possibly through gate bits in registers)
> and leaving that down to some driver somewhere. Or why we have to name
> clocks twice, once for the canonical name of the output in reference
> to a higher level or root clock "uart_serial", vs. a driver-level name
> for that input or output in the driver ("per"), since most clocks at
> the driver level can't be re-used for other things anyway. If they
> could, the whole prepare/unprepare and some explicit parenting/muxing
> of clocks would handle that anyway so that the clock was enabled while
> there was at least one user.

The binding defines connections on clocks between nodes. Whether this is
a single clock controller node with many outputs or a node per mux,
divider, gate, etc. is up to the implementer. I did the latter on
highbank because I've got about 8 clocks and half are the same (pll
outputs). Having worked on many generations of iMX and knowing all the
pitfalls of their clock controllers, I would do exactly what Shawn has
done for any part with complex clock trees. I don't think trying to
abstract things to completely generic code will be worth the effort or
be able to describe all the interactions between clocks.

The value in device tree is handling board differences as there are 10's
of boards per SOC.

> I do understand that in Shawn's patch and using UART as an example
> again, "ipg" and "per" are definitely needed by the driver, and these
> names are defined by the driver and implicit in the documentation to
> enable the use of this unit, but at the end of the day the definition
> at the *device* level (uart@) makes no sense except to perform a
> lookup on a string, and in the end this string lookup only gets done
> at the driver probe time anyway. With a standard definition of these
> "ipg" and "per" strings per family of SoC or even in a generic fashion
> across all possible SoCs (in this case, both are defined using
> imx_clk_gate2()) then a node defining that clock and it's magical
> driver-specific name would work just as well by phandle reference, and
> it's parents are referenced by phandle, and all this stays within
> SoC-specific abstraction of the common clocks and turns into normal
> common clock structure stuff anyway (so you still get to do a string
> lookup, but it's being stuffed by an i.MX driver and registered from
> data it pulled from the DT).

Why don't you read v2 which removes the strings.

> Wouldn't we rather have a single device tree parser and clock
> registration for i.MX than the current 7 which would get split into 7
> clock registration drivers with some helpers that parsed half of it
> via device tree? I don't really see what benefit you get out of going
> for the halfway-defined model.

All this has been discussed already over the 2 years of iterations of
common struct clock and clock bindings.

Rob
