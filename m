From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 07 Jan 2014 22:26:47 +0100
Subject: [PATCH 1/2] ohci-platform: Add support for devicetree
 instantiation
In-Reply-To: <4061478.AqT6BOpdOY@wuerfel>
References: <Pine.LNX.4.44L0.1401061043240.1282-100000@iolanthe.rowland.org>
 <52CC6B8F.5000404@redhat.com> <4061478.AqT6BOpdOY@wuerfel>
Message-ID: <52CC7117.3010704@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/07/2014 10:16 PM, Arnd Bergmann wrote:
> On Tuesday 07 January 2014 22:03:11 Hans de Goede wrote:
>>>> +
>>>> +Optional properties:
>>>> + - clocks: array of clocks
>>>> + - clock-names: clock names "ahb" and/or "ohci"
>>>
>>> Where does "ahb" come from, what does it mean, and how is it relevant
>>> to generic platforms?
>>
>> ahb is an ARM specific thing, so your right it does not belong in a
>> generic driver. I'll use clk1 and clk2 as names in my next version.
>
> While AHB is a bus created by ARM Ltd, it's not actually specific
> to the ARM architecture. My guess is that it is in fact used on 95%
> of all SoCs, so I would leave it at that. For the other clock, I
> think that's actually the bus clock for the USB interface, so I would
> not call it "ohci" but rather just "usb" or "phy".
>
> I think it's important to distinguish the names and not just use
> "clk1" and "clk2", because the driver may actually want to access
> a particular clock in some scenario.

The idea here is to have a generic driver, if a driver needs to know
about a specific clock, it will likely be another device specific
driver and it can use its own dt-bindings and clock names. I believe
that for a generic driver meant to cover common hardware configs,
simply having X clks and then on power_on enabling clk1, then clk2,
then clk3, etc. and on power off do the same in reverse other is
a good approach.

>
>>> What about platforms that use 3 clocks?
>>
>> Ah yes I see some platforms have 3 clocks, I'll also add a clk3.
>
> I guess we should try to find at least one hardware data sheet
> for an actual ohci implementation and look at what the clock
> inputs are really called. A lot of the drivers seem to incorrectly
> use the name for the clock signal inside of the soc, which tends
> to be named after who provides it, not what it's used for.

I don't know about data-sheets, but an example of a driver
with 3 clocks is drivers/usb/host/ohci-at91.c fwiw it uses
"uhpck", "hclk" and "usb_clk" as clk names.

Regards,

Hans
