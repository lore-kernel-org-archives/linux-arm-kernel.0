From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 1 Aug 2016 11:49:27 +0200
Subject: [PATCH 3/3] ehci-platform: add the max clock number to 4
In-Reply-To: <255931470039489@web30j.yandex.ru>
References: <20160731112536.4625-1-icenowy@aosc.xyz>
 <20160731112536.4625-3-icenowy@aosc.xyz> <2477355.hXm3xYUusy@wuerfel>
 <414101470035152@web9j.yandex.ru>
 <01a348da-3b26-68a6-9d9f-c37d81b4fd64@redhat.com>
 <255931470039489@web30j.yandex.ru>
Message-ID: <8f85d8c6-761d-ac37-2ae3-1a3a2f21542f@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01-08-16 10:18, Icenowy Zheng wrote:
>
>
> 01.08.2016, 15:27, "Hans de Goede" <hdegoede@redhat.com>:
>> Hi,
>>
>> On 01-08-16 09:05, Icenowy Zheng wrote:
>>>                          clocks = <&ccu CLK_A64_BUS_OHCI1>,
>>>                                   <&ccu CLK_A64_BUS_EHCI1>,
>>>                                   <&ccu CLK_A64_USB_OHCI0>,
>>>                                   <&ccu CLK_A64_USB_OHCI1>;
>>>
>>>  On A64, EHCI requires the matched OHCI to work.
>>
>> Ah, so just like on the H3 (where this also is needed
>> and not documented).
> Yes, I feeled that A64 is like a hybrid of H3 and A33.
>>
>>>  And OHCI1 clock requires OHCI0 clock to work.
>>
>> Hmm, that one is new, can you double check this ?
> SCLK_GATING_OHCI.
> Gating Special Clock For OHCI(48M and 12M)
> 00: Clock is OFF
> 01: OTG-OHCI Clock is ON
> 10: Clock is OFF
> 11:OTG-OHCI and OHCI0 Clock is ON
>
> P.113 of A64 user manual 1.0

Ah I see that looks weird, I assume that you're working
on getting the regular usb host on the A64 to work, iow
the "HCI0" block in the usb block diagram at p. 580, right ?

It could be that the ohci clock for that somehow is
tapped from the ohci clock for the "USB-OTG-HCI" block,
but:

P.113, other bits of the USBPHY_CFG_REG register:

23:22 R/W 0x0 OHCI1_12M_SRC_SEL. OHCI1 12M Source Select
00: 12M divided from 48M
01: 12M divided from 24M
10: LOSC
11: /

21:20 R/W 0x0 OHCI0_12M_SRC_SEL. OHCI0 12M Source Select
00: 12M divided from 48M
01: 12M divided from 24M
10: LOSC
11: /

Suggests that they are independent...

Have you tried to simply drop

                              <&ccu CLK_A64_USB_OHCI0>,

 From the clocks list and check that usb-1 devices
(e.g. a mouse / keyboard) plugged directly into the
board still work ?

If it does we can simply drop it, of it does not work
then indeed we need 4 clocks because allwinner has
done something weird again.

###

Also it seems that the CLK_A64_USB_OHCI0 /
CLK_A64_USB_OHCI1 names are wrong, the datasheet
consistently (*) refers to "usb-otg-ohci" and an
"usb-ohci0" rather then ohci0 and ohci1 (**)

Except for the USBPHY_CFG_REG documentation for bits 20:23,
which I believe is an error in the datasheet.

So we should do the same in the dt-bindings IMHO.

Regards,

Hans



*) In the system address map (p. 73), "Interrupt Source" list (p.210)
in the "Bus Clock Gating Register0" doc (p. 100) and
in the usb block diagram (p. 580).

**) Unlike the H3 where usb-otg-ohci is called usb-ohci0 and
the first non otg host controller is called usb-ohci1.
