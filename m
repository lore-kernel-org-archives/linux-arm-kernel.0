From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 23 Apr 2012 12:47:23 -0600
Subject: [PATCH 1/2] pinctrl: add pinctrl-mxs support
In-Reply-To: <20120421015052.GA6808@S2101-09.ap.freescale.net>
References: <1334823125-24159-1-git-send-email-shawn.guo@linaro.org>
 <4F91969C.2010201@wwwdotorg.org>
 <20120421015052.GA6808@S2101-09.ap.freescale.net>
Message-ID: <4F95A3BB.3000004@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/20/2012 07:51 PM, Shawn Guo wrote:
> On Fri, Apr 20, 2012 at 11:02:20AM -0600, Stephen Warren wrote:
>> On 04/19/2012 02:12 AM, Shawn Guo wrote:
>>> Add pinctrl support for Freescale MXS SoCs, i.MX23 and i.MX28.
>>> The driver supports device tree probe only.

>>> +Those subnodes will fall into two categories.  One is to set up a group of
>>> +pins for a function, both mux selection and pin configurations.  For the same
>>> +function, all pin group nodes should use the same node name and be sorted
>>> +together in "reg" value.  And the other one is the pure pin configuration
>>> +node, which are used to configure some pins that need a different drive
>>> +strength, voltage or pull-up configurations from what specified in the pin
>>> +group node.
>>
>> This paragraph isn't very clear to me, although reading it in
>> conjunction with the example makes more sense.
>>
>> I don't like a couple of things about this binding:
>>
>> 1) Combining the mux function selection into the fsl,pinmux-ids doesn't
>> seem correct. That property is being overloaded to both identify which
>> pins that node applies to, and to (in some cases) specify the mux
>> function to select for those pins. I think those two aspects should be
>> separate properties.
>
> I fully agree with this observation.  But we decided to have the
> binding combine these two aspects into one entity, a given pin on
> given mux selection, because all existing mach-mxs users use this
> entity to identify a pin (That long list of valid pinmux-ids value
> is copied from existing mach-mxs pinctrl driver).  I have to admit
> this is a compromise to ease the users and engineering.

Don't the pin numbers from DT get converted into the "real" pin numbers
in the pinctrl mapping tables though (i.e. the "mux" field stripped
out)? If so, then it seems that people have to be aware of the
separation between pin number and mux setting anyway, so it may as well
be represented directly in DT. If not, then the pin numbers in the
pinctrl driver aren't true pin numbers, so a lot of pinctrl is going to
be confusing or even useless (i.e. the code in core pinctrl that ensures
the same pin can't be allocated more than once isn't going to work if
every allocation of the pin uses a different pin ID because the mux
setting is included in the pin ID).

Can't a simple script be written to convert the old IDs to the new IDs,
even spitting out the device tree content just based on parsing whatever
.c files you have now? That's what I'm doing for Tegra and it's working
great, except for a few special cases I haven't coded into the
conversion script yet.

>> 2) The use of the reg property to indicate whether the mux field in
>> fsl,pinmux-ids is actually used or not seems bizarre and without precedent.
>>
> That's actually the side-effect of fsl,pinmux-ids definition and reg
> property.  The main purpose of reg property is to distinguish the
> category of the subnodes.  The driver will create a pin group for the
> nodes that have reg property (called pin group node in the binding),
> while ignore the ones that do not have reg property (called pure pin
> configuration node).
> 
>> Instead, why not:
>>
>> * Remove the special-case use of the reg property.
>> * Remove [3:0] mux selection from fsl,pinmux-ids.
>> * Add a new property e.g. fsl,mux-selection to describe which mux value
>> to select for the pins. Perhaps this could be a list if needed.
>>
> This is basically what Dong's imx patch does.  It ends up with something
> like "fsl,mux = <0 0 1 1 1 1 1 1 1 1>;" for a group of pins specified
> in "fsl,pins".  Sascha does not like it, because it makes the pinctrl
> migration hard, and every time we touch "fsl,mux", we need to look at
> hardware manual to find the meaning of these mux numbers.

Well, it's even worse if the pin numbers include both pin numbers and
mux selection. You have to do all the exact same lookups in the manual,
except that first you have to remember which bits of the pin ID really
mean mux function and not pin ID.
