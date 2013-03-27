From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 27 Mar 2013 10:47:59 -0600
Subject: [PATCHv2 3/7] pinctrl: gpio: vt8500: Add pincontrol driver for
 arch-vt8500
In-Reply-To: <1364360362.2160.6.camel@gitbox>
References: <1364015633-18580-1-git-send-email-linux@prisktech.co.nz>
 <1364015633-18580-4-git-send-email-linux@prisktech.co.nz>
 <515083CB.1060908@wwwdotorg.org> <1364237467.18777.9.camel@gitbox>
 <515204F7.30502@wwwdotorg.org> <1364360362.2160.6.camel@gitbox>
Message-ID: <515322BF.2080109@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2013 10:59 PM, Tony Prisk wrote:
> On Tue, 2013-03-26 at 14:28 -0600, Stephen Warren wrote:
>> On 03/25/2013 12:51 PM, Tony Prisk wrote:
>>> On Mon, 2013-03-25 at 11:05 -0600, Stephen Warren wrote:
>>>> On 03/22/2013 11:13 PM, Tony Prisk wrote:
>>>>> This patch adds support for the GPIO/pinmux controller found on the VIA
>>>>> VT8500 and Wondermedia WM8xxx-series SoCs.
>>>>>
>>>>> Each pin within the controller is capable of operating as a GPIO or as
>>>>> an alternate function. The pins are numbered according to their control
>>>>> bank/bit so that if new pins are added, the existing numbering is maintained.
>>>>>
>>>>> All currently supported SoCs are included: VT8500, WM8505, WM8650, WM8750 and
>>>>> WM8850.
>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-vt8500.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-vt8500.txt

>>>>> +Optional properties:
>>>>> +- wm,pinmux: A value and mask pair describing the configuration changes to
>>>>> +  the pinmux register. Only bits marked 1 in the mask will be changed.
>>>>
>>>> This needs more explanation. What does this do and why is it needed?
>>>
>>> This is the bit that is causing most of the trouble with this patchset.
>>>
>>> This binding exposes a 32-bit register which is basically a mux
>>> register, but a messy one at that.
>>>
>>> The bit values seem to change on each of the different SoCs, we have no
>>> hardware docs for most of the later SoCs so it's very much guess-work.
>>> Because we don't have the doc's, we don't know which pins are
>>> function-swapped when changing bits in this register so writing a proper
>>> pinmux driver is impossible.
>>>
>>> We currently only use this register to ensure the DVO/LCD output is
>>> enabled for the framebuffer driver. On the vt8500 SoC, this is bit 0 -
>>> all later SoCs use bit 31.
>>>
>>> I exposed it this was so that we don't need to change anything in the
>>> future as new functions are found. The DTS can be modified to
>>> enable/disable the functions directly. It would make even more sense
>>> once we get a C header or similar with #define's to describe what each
>>> bit does.
>>>
>>> Given the confusion/hesitation around this one property, I am tempted to
>>> drop it from the patchset and leave the original code in
>>> arch/arm/vt8500.c to enable the LCD output.
>>
>> Oh yes, this doesn't sound very good.
> 
> Will look at this before the next version.
> 
>>
>> Why can't you write a driver without complete knowledge? That driver
>> would simply only support 1 pin/pingroup, and 1 (or I guess 2?)
>> functions that can be mux'd onto it. If more is discovered about the HW
>> later, can't more pins/groups/functions be added in a
>> backwards-compatible fashion?
>
> This is what we have now - we have 1 pin/pingroup, and 1 alt func.

Given the description below, I think there are two functions; LCD and CCIR?

> The problem is, using the LCD example above, we don't specifically know
> which pins are affected when we set the 'DVO enable' bit on the pinmux
> register, but if we don't set the bit, the LCD output is disabled.

It almost sounds as if there isn't enough information to even know that
the HW module is a pinmux rather than something else?

> When we set bit 31 of pinmux, the DVO output pins are changed to make
> the LCD work. If we clear bit 31, some of those pins become the CCIR
> function, and other's become something else.
> 
> I couldn't add it as a 2nd alt func, because it can't be set per-pin, it
> applies to a group of pins.

The pinctrl subsystem certainly supports muxing on groups of pins at
once. I don't think that should be an issue.

> To complicate matters, some of the bits in the pinmux register are
> simple dis(en)able bits, others are alt-func type bits (0=CCIR, 1=DVO)
> etc.

I think that's an internal detail of the HW that the driver can hide
quite easily.

> If I knew which pins were affected for each function I would have
> written it as a proper pinmux driver with pin groups, but I couldn't see
> how to apply the pinmux function around what this register does.

I think you can define just pins/groups/functions in the driver that are
currently known about. Certainly you must know at least some of the pins
that are affected by that CCIR/DVO bit, simply because they are the pins
that you care about working. So, include just those pins in the group
definition for the LCD/CCIR group for now. The set of known
pins/groups/functions, and the set of pins within each group, can easily
be added to later without affecting the DT binding; it's simply that
additional values might be valid in the DT later, but not now, right?
