From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 09 Jan 2014 18:45:32 +0100
Subject: [linux-sunxi] Re: [PATCH v2 2/2] ehci-platform: Add support for
 clks and phy passed through devicetree
In-Reply-To: <Pine.LNX.4.44L0.1401091043380.1493-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1401091043380.1493-100000@iolanthe.rowland.org>
Message-ID: <52CEE03C.3090804@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/09/2014 04:47 PM, Alan Stern wrote:
> On Thu, 9 Jan 2014, Hans de Goede wrote:
>
>>>> +Optional properties:
>>>> +- clocks : a list of phandle + clock specifier pairs, one for each entry
>>>> +   in clock-names.
>>>> +- clock-names : "clk0", "clk1", ...
>>>> +- phys : phy
>>>> +- phy-names : "phy0"
>>>> +
>>>> +Example:
>>>> +
>>>> +	ehci at d8007900 {
>>>> +		compatible = "via,vt8500-ehci";
>>>> +		reg = <0xd8007900 0x200>;
>>>> +		interrupts = <43>;
>>>> +		clocks = <&usb_clk 6>, <&ahb_gates 2>;
>>>> +		clock-names = "clk0", "clk1";
>>>
>>> I'm really not convinced by this either. It prevents you from doing
>>> anything useful out of these clocks, and the only thing you can
>>> actually do with it is calling clk_get, and that's pretty much it.
>>>
>>> What if you some platform needs to adjust the rate of one of the two?
>>
>> Then it needs its own driver. This is intended as a binding for a
>> *generic* driver, which is meant to cover simple straight forward
>> non-pci ohci cases. For more complex cases a separate driver will
>> need to be written.
>>
>> I must say I'm becoming a bit unhappy with how the reviews of devicetree
>> bindings are being done. In one case it is not generic enough (ahci-sunxi).
>>
>> If I then try to make it more generic in a case where that can actually
>> be done as the hardware is pretty straight forward, it is not specific enough.
>> You can simply not have both!
>>
>>> Or wants to cut one but not the other for any reason?
>>
>> This is another example of non generic behavior, requiring a separate
>> (small using the existing ohci core) platform glue driver, like the *19* we
>> already have.
>
> Would DT allow ehci-platform.c to access the clocks by their index in
> the array, rather than by name?  After all, you don't really care about
> the names at all, since the driver knows nothing about the clocks'
> functions.

Yes, actually I've been discussing this with Maxime on irc and I'm
just done preparing a v3 doing exactly that. I was just checking mail
for any more review comments before pushing out v3 :)

> The same is true of the phy entry.

The phy entry must have a name, this is specified in the phy bindings
in Documentation/devicetree/bindings/phy/phy-bindings.txt:

"""
PHY user node
=============

Required Properties:
phys : the phandle for the PHY device (used by the PHY subsystem)
phy-names : the names of the PHY corresponding to the PHYs present in the
             *phys* phandle
"""

Now that I've dropped the clock-names, I've changed the ugly "phy0" name
to "usb" as the phy pointed to is supposed to be an usb phy.

Regards,

Hans
