From: rob.herring@calxeda.com (Rob Herring)
Date: Tue, 21 Aug 2012 07:53:55 -0500
Subject: [PATCH 2/2] ARM: imx6q: replace clk_register_clkdev with clock
 DT lookup
In-Reply-To: <CAKGA1bnfhMC8QG9OqBbpy5iq6ZAfEgrYMg_LVd50U7yikLhDAg@mail.gmail.com>
References: <1345104526-14797-1-git-send-email-shawn.guo@linaro.org>
 <1345104526-14797-3-git-send-email-shawn.guo@linaro.org>
 <503232E0.3000007@gmail.com>
 <CAKGA1bn2uCWE8YkGR4EzTxZ_bXJ_ov2diq63uxQ=dT7b6Fu9GQ@mail.gmail.com>
 <20120820151609.GN24242@S2101-09.ap.freescale.net>
 <CAKGA1bnfhMC8QG9OqBbpy5iq6ZAfEgrYMg_LVd50U7yikLhDAg@mail.gmail.com>
Message-ID: <503384E3.4030705@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/20/2012 12:22 PM, Matt Sealey wrote:
> On Mon, Aug 20, 2012 at 10:16 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> On Mon, Aug 20, 2012 at 09:54:48AM -0500, Matt Sealey wrote:
>>> Yet another arbitrary array...
>>>
>>> I'm not sure why you would move the registration lookup into the DT
>>
>> Because I do not want to patch kernel every time I need a new lookup.
>> Furthermore, looking at function imx53_qsb_init in imx53-dt.c, you
>> will find that lookup for sgtl5000 is really board specific and should
>> go to device tree.
>>
>>> and use an arbitrarily ordered array again. Sure, you're looking it up
>>> entirely within the device tree here, but a better solution would be
>>> to not name clocks twice, and structure your clock definition
>>> properly.
>>>
>>> What's wrong with;
>>>
>>> ccm at 020c4000 {
>>>    ...
>>>    my_clock: clock at 0 {
>>>        name = "my_clock_name";
>>>    }
>>> }
>>>
>>> uart at nnnnnnnn {
>>>    ...
>>>    clocks = <&my_clock>;
>>> }
>>>
>>> ?
>>>
>> It turns a property into 185 nodes, which will just bloat the device
>> tree.  This issue has been discussed for a plenty of times.
> 
> It's not bloat just because it is by its very definition "a big list", is it?
> 
> How do you explain duplicating the clock names in the array AND in the
> device node as NOT being bloated?

Read the clock binding doc. Names are optional and the 2 names are not
the same. One is the name of the output on the CCM and one is the name
on input to the module.

While generally optional, Shawn has chosen to require at least the
output names. In the case of defining a signal clock controller node
with lots of outputs, that is the right choice.

Rob

> 
> You're going to have to define these clocks as a tree with parents and
> leaf nodes anyway in the clock subsystem. Why not define these in the
> device tree in total and reference them by handle when you build the
> entire clock tree from the ground up? Or will it just be all the
> clocks defined in Linux, but the lookups (which is what I see here)
> moved into the DT? Why not form the lookups as part of the definition
> of the clock tree?
> 
