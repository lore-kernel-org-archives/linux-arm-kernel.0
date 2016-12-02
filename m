From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 2 Dec 2016 16:10:46 +0000
Subject: [PATCH v2 2/3] ARM: dts: sunxi: add support for Orange Pi Zero
 board
In-Reply-To: <11535601480689127@web2g.yandex.ru>
References: <20161121162421.800-1-icenowy@aosc.xyz>
 <20161121162421.800-2-icenowy@aosc.xyz> <5373671480239408@web31m.yandex.ru>
 <cdfd3c65-d473-badb-ea6a-035f7ab79217@arm.com>
 <20161201093619.gs6lmoxtlptp2jr6@lukather>
 <11498641480688550@web2g.yandex.ru>
 <efb30303-b9bb-7a7c-4478-af485991dd86@redhat.com>
 <11535601480689127@web2g.yandex.ru>
Message-ID: <324c8820-aeea-3fad-0e02-1bdb8f675677@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/12/16 14:32, Icenowy Zheng wrote:
> 
> 
> 02.12.2016, 22:30, "Hans de Goede" <hdegoede@redhat.com>:
>> Hi,
>>
>> On 02-12-16 15:22, Icenowy Zheng wrote:
>>>  01.12.2016, 17:36, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
>>>>  On Mon, Nov 28, 2016 at 12:29:07AM +0000, Andr? Przywara wrote:
>>>>>   > Something more interesting happened.
>>>>>   >
>>>>>   > Xunlong made a add-on board for Orange Pi Zero, which exposes the
>>>>>   > two USB Controllers exported at expansion bus as USB Type-A
>>>>>   > connectors.
>>>>>   >
>>>>>   > Also it exposes a analog A/V jack and a microphone.
>>>>>   >
>>>>>   > Should I enable {e,o}hci{2.3} in the device tree?
>>>>>
>>>>>   Actually we should do this regardless of this extension board. The USB
>>>>>   pins are not multiplexed and are exposed on user accessible pins (just
>>>>>   not soldered, but that's a detail), so I think they qualify for DT
>>>>>   enablement. And even if a user can't use them, it doesn't hurt to have
>>>>>   them (since they are not multiplexed).
>>>>
>>>>  My main concern about this is that we'll leave regulators enabled by
>>>>  default, for a minority of users. And that minority will prevent to do
>>>>  a proper power management when the times come since we'll have to keep
>>>>  that behaviour forever.
>>>
>>>  I think these users can add a 'fdt set /xxx/xxx status "disabled" ' .
>>
>> I don't think that will be necessary I'm pretty sure these extra usb
>> ports do not have a regulator for the Vbus, they just hook directly
>> to the 5V rail, can someone with a schematic check ?
> 
> We seems to have still no schematics for the add-on board.

>From looking at the picture of that expansion board on the Aliexpress
page and chasing the tracks, there is clearly no voltage regulator on
there, it's just passive components. The 5V pin from the headers is
routed forth and back between the two layers via some vias directly to
the 5V pins of the USB sockets.

> But something is sure is that there's no any regulator-related pins
> on the add-on pinout. There's only USB DM and DP pins.
> 
> So the Vbus must be directly connected to +5V.

So yes, it is.

But I think the question is moot anyways, since we don't provide DT
support for that add-on board at that point anyways.
One could imagine another board, though, which has regulators switched
by GPIOs, but that would be their problem and they would have regulators
specified in their specific DT snippet, then.

So to summarize:
- For that specific Orange Pi Zero board which we discuss the DT for
there is no regulator support for the additional USB ports. Thus nothing
we could turn off to save power.
- A user could just take these USB brackets with pin headers that are so
common in PCs to connect additional USB ports to the back of the box.
One just needs to re-sort the pins, which is a matter of a minute.
- As long as we don't provide any easy way of handling DT changes, we
should enable the USB ports for the sake of the users of either those
brackets or the expansion board. Any more sophisticated USB expansion
board with regulators would need to amend the DT anyway.

Does that make sense?

Cheers,
Andre.
