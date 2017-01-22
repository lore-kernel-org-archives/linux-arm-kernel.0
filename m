From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun, 22 Jan 2017 17:39:05 +0800
Subject: [linux-sunxi] Re: [PATCH 1/4] phy: sun4i-usb: support PHY0 on H3
 in MUSB mode
In-Reply-To: <93a01892-47b5-5445-d802-f56bdac8371f@redhat.com>
References: <20170116191449.50397-1-icenowy@aosc.xyz>
 <20170116191449.50397-2-icenowy@aosc.xyz>
 <20170117080611.tn7s7ddj2csqr27m@lukather>
 <3866431484672228@web20j.yandex.ru>
 <20170117200658.gcrcxeanthdtwg26@lukather>
 <CAGb2v67kYtrTdw9YMS7wvRa=2MWYJ=BEc9SmUOds7hNYZKOz9g@mail.gmail.com>
 <20170119143445.dmckuqjxmfhwr3h5@lukather> <1682741484838608@web2j.yandex.ru>
 <20170119202709.GA1853@excalibur.cnev.de>
 <93a01892-47b5-5445-d802-f56bdac8371f@redhat.com>
Message-ID: <9112691485077945@web29h.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



20.01.2017, 16:04, "Hans de Goede" <hdegoede@redhat.com>:
> HI,
>
> On 19-01-17 21:27, Karsten Merker wrote:
>> ?On Thu, Jan 19, 2017 at 11:10:08PM +0800, Icenowy Zheng wrote:
>>> ?19.01.2017, 22:34, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
>>>> ?On Wed, Jan 18, 2017 at 04:09:32AM +0800, Chen-Yu Tsai wrote:
>>>>> ??On Wed, Jan 18, 2017 at 4:06 AM, Maxime Ripard
>>>>> ??<maxime.ripard@free-electrons.com> wrote:
>>>>> ??> On Wed, Jan 18, 2017 at 12:57:08AM +0800, Icenowy Zheng wrote:
>>>>> ??>> 17.01.2017, 16:06, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
>>>>> ??>> > On Tue, Jan 17, 2017 at 03:14:46AM +0800, Icenowy Zheng wrote:
>>>>> ??>> >> The PHY0 on H3 can be wired either to MUSB controller or OHCI/EHCI
>>>>> ??>> >> controller.
>>>>> ??>> >>
>>>>> ??>> >> The original driver wired it to OHCI/EHCI controller; however, as the
>>>>> ??>> >> code to use PHY0 as OHCI/EHCI is missing, it makes the PHY fully
>>>>> ??>> >> unusable.
>>>>> ??>> >>
>>>>> ??>> >> Rename the register (according to its function and the name in BSP
>>>>> ??>> >> driver), and remove the code which wires the PHY0 to OHCI/EHCI, as MUSB
>>>>> ??>> >> can support both peripheral and host mode (although the host mode of
>>>>> ??>> >> MUSB is buggy).
>>>>> ??>> >
>>>>> ??>> > Can you elaborate on that? What's wrong with it?
>>>>> ??>>
>>>>> ??>> The configuration is at bit 0 of register 0x20 in PHY.
>>>>> ??>>
>>>>> ??>> When the PHY is reseted, it defaults as MUSB mode.
>>>>> ??>>
>>>>> ??>> However, the original author of the H3 PHY code seems to be lack of
>>>>> ??>> this knowledge (He named it PHY_UNK_H3), and changed the PHY to HCI
>>>>> ??>> mode.
>>>>> ??>>
>>>>> ??>> I just removed the code that wires it to HCI mode, thus it will work
>>>>> ??>> in MUSB mode, with my sun8i-h3-musb patch.
>>>>> ??>
>>>>> ??> I have no idea what you mean by MUSB mode.
>>>>> ??>
>>>>> ??> Do you mean that the previous code was only working in host mode, and
>>>>> ??> now it only works in peripheral?
>>>>>
>>>>> ??From what I understand, with the H3, Allwinner has put a mux
>>>>> ??in front of the MUSB controller. The mux can send the USB data
>>>>> ??to/from the MUSB controller, or a standard EHCI/OHCI pair.
>>>>> ??This register controls said mux.
>>>>>
>>>>> ??This means we can use a proper USB host for host mode,
>>>>> ??instead of the limited support in MUSB.
>>>>
>>>> ?But musb can still operate as a host, right?
>>>
>>> ?Yes!
>>
>> ?Hello,
>>
>> ?I don't know how the MUSB implementation in the H3 behaves as I
>> ?don't have any H3-based systems, but if it should happen to be
>> ?similar to the one in the A31s, it probably isn't a full-fledged
>> ?alternative to using an OHCI/EHCI controller.
>
> You right it isn't which is why I suggested that the phy-sun4i-usb
> code should set the mux to the OCHI/EHCI pair when the id pin
> is pulled low (host-mode).
>
>> ?From my practical experiments with the MUSB in the A31s in host
>> ?mode I can report that I hadn't been able to get multiple HIDs
>> ?(in my case keyboard and mouse) working at the same time. The
>> ?keyboard alone worked without problems, the mouse alone worked
>> ?without problems, but when both were connected, only one of them
>> ?worked.
>>
>> ?I had at that time talked to Hans de Goede about the problem and
>> ?if I remenber correctly, he had mentioned that the MUSB has
>> ?problems servicing more than one device that does interrupt
>> ?transfers (as HIDs do).
>>
>> ?Hans, can you perhaps shed some light on this?
>
> Everything you've said is correct, the MUSB can emulate a
> host-controller, but it is not really one and when possible
> should not be used as such.

But implement proper EHCI/OHCI pair and MUSB coexistence needs
a lot of code, and MUSB can still work.

We can now just enable MUSB, then after the coexistence is done,
switch to use MUSB for peripheral and {E,O}HCI for host.

Seems that SoCs after sun8iw7 (H3) all have this feature. (At least
I verified it on H3, V3s, A64, H5)

P.S. The implementation on FreeBSD of A64 PHY uses a dedicated
PHY number for the HCI pair, which seems to break the DT compatibility
between Linux and FreeBSD.

>
> Hans
