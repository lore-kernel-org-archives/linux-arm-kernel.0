From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 26 Mar 2013 14:28:39 -0600
Subject: [PATCHv2 3/7] pinctrl: gpio: vt8500: Add pincontrol driver for
 arch-vt8500
In-Reply-To: <1364237467.18777.9.camel@gitbox>
References: <1364015633-18580-1-git-send-email-linux@prisktech.co.nz>
 <1364015633-18580-4-git-send-email-linux@prisktech.co.nz>
 <515083CB.1060908@wwwdotorg.org> <1364237467.18777.9.camel@gitbox>
Message-ID: <515204F7.30502@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2013 12:51 PM, Tony Prisk wrote:
> On Mon, 2013-03-25 at 11:05 -0600, Stephen Warren wrote:
>> On 03/22/2013 11:13 PM, Tony Prisk wrote:
>>> This patch adds support for the GPIO/pinmux controller found on the VIA
>>> VT8500 and Wondermedia WM8xxx-series SoCs.
>>>
>>> Each pin within the controller is capable of operating as a GPIO or as
>>> an alternate function. The pins are numbered according to their control
>>> bank/bit so that if new pins are added, the existing numbering is maintained.
>>>
>>> All currently supported SoCs are included: VT8500, WM8505, WM8650, WM8750 and
>>> WM8850.
>>
>>> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-vt8500.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-vt8500.txt
>>
>>> +Required properties:
>>
>>> +- gpio-controller: Marks the device node as a GPIO controller.
>>> +- #gpio-cells : Should be two. The first cell is the pin number and the
>>> +  second cell is used to specify optional parameters.
>>
>> What are those optional parameters? This binding should define them.
>
> There are actually no optional parameters at the moment - but there will
> be at some point. In our original GPIO driver binding it was suggested
> that a flags cell be added. When moving it to the pinctrl driver
> binding, the bank + pin number cells were combined as we have linear
> numbering now, and the flags property was retained.
> 
> - #gpio-cells : should be <3>.
> 	1) bank
> 	2) pin number
> 	3) flags - should be 0
> 
> I will clarify this in the next version.

I think you should define a flag for inverted or active-low. This is
typically bit 0 in the flags cell.

>>> +Optional properties:
>>> +- wm,pinmux: A value and mask pair describing the configuration changes to
>>> +  the pinmux register. Only bits marked 1 in the mask will be changed.
>>
>> This needs more explanation. What does this do and why is it needed?
> 
> This is the bit that is causing most of the trouble with this patchset.
> 
> This binding exposes a 32-bit register which is basically a mux
> register, but a messy one at that.
> 
> The bit values seem to change on each of the different SoCs, we have no
> hardware docs for most of the later SoCs so it's very much guess-work.
> Because we don't have the doc's, we don't know which pins are
> function-swapped when changing bits in this register so writing a proper
> pinmux driver is impossible.
> 
> We currently only use this register to ensure the DVO/LCD output is
> enabled for the framebuffer driver. On the vt8500 SoC, this is bit 0 -
> all later SoCs use bit 31.
> 
> I exposed it this was so that we don't need to change anything in the
> future as new functions are found. The DTS can be modified to
> enable/disable the functions directly. It would make even more sense
> once we get a C header or similar with #define's to describe what each
> bit does.
> 
> Given the confusion/hesitation around this one property, I am tempted to
> drop it from the patchset and leave the original code in
> arch/arm/vt8500.c to enable the LCD output.

Oh yes, this doesn't sound very good.

Why can't you write a driver without complete knowledge? That driver
would simply only support 1 pin/pingroup, and 1 (or I guess 2?)
functions that can be mux'd onto it. If more is discovered about the HW
later, can't more pins/groups/functions be added in a
backwards-compatible fashion?

If you take that approach, you can define a regular driver from the
start without the need for any unusual DT properties.

If you want the DT itself to describe the legal set of
pins/groups/functions and combinations thereof, so that only DT edits
and not driver changes are required once future HW knowledge becomes
available, I think you'd want some far more complete and generic DT
binding than a single "wm,pinmux" property, which has a rather generic
name, but rather specific usage.
