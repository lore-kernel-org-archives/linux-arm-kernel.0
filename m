From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 27 May 2014 09:41:48 +0900
Subject: [PATCH v2] ARM: shmobile: r8a7790: link PCI USB devices to USB PHY
In-Reply-To: <5383C439.1080808@cogentembedded.com>
References: <201405270217.33057.sergei.shtylyov@cogentembedded.com>
 <CANqRtoT+xKmK7wkayiD9yCmUqFNKWxpeSgkGTiCqc+THYE0sVw@mail.gmail.com>
 <5383C439.1080808@cogentembedded.com>
Message-ID: <CANqRtoTanAWvEODE99dY-BRU1FOm3V78FM6ePYKtVbK1Ro+79A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 7:46 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 05/27/2014 02:36 AM, Magnus Damm wrote:
>
>>> Describe the PCI USB devices that are behind the PCI bridges, adding
>>> necessary
>>> links to the USB PHY device.
>
>
>>> Based on the original work by Ben Dooks <ben.dooks@codethink.co.uk>.
>
>
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
>
>>> ---
>>> This patch is against 'renesas-devel-v3.15-rc7-20140526' tag of Simon
>>> Horman's
>>> 'renesas.git' repo plus R8A7790/Lager PCI and USB PHY support patches
>>> posted
>>> before. The patch requires the internal PCI DT support, USB PHY driver,
>>> and
>>> USB HCD generic PHY support (also already posted) in order to work.
>
>
>>> Changes in version 2:
>>> - renamed the PCI OHCI/EHCI device nodes to comply with the PCI binding;
>>> - changed the PHY specifier in the PCI#2 node to reflect that channel #1
>>> support
>>>    was dropped;
>>> - resolved rejects, refreshed the patch.
>
>
>>>   arch/arm/boot/dts/r8a7790.dtsi |   28 ++++++++++++++++++++++++++++
>>>   1 file changed, 28 insertions(+)
>
>
>>> Index: renesas/arch/arm/boot/dts/r8a7790.dtsi
>>> ===================================================================
>>> --- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
>>> +++ renesas/arch/arm/boot/dts/r8a7790.dtsi
>>> @@ -919,6 +919,20 @@
>>>                  interrupt-map = <0x0000 0 0 1 &gic 0 108
>>> IRQ_TYPE_LEVEL_HIGH
>>>                                   0x0800 0 0 1 &gic 0 108
>>> IRQ_TYPE_LEVEL_HIGH
>>>                                   0x1000 0 0 2 &gic 0 108
>>> IRQ_TYPE_LEVEL_HIGH>;
>>> +
>>> +               usb at 0,1 {
>>> +                       reg = <0x800 0 0 0 0>;
>>> +                       device_type = "pci";
>>> +                       phys = <&usbphy 0 0>;
>>> +                       phy-names = "usb";
>>> +               };
>>> +
>>> +               usb at 0,2 {
>>> +                       reg = <0x1000 0 0 0 0>;
>>> +                       device_type = "pci";
>>> +                       phys = <&usbphy 0 0>;
>>> +                       phy-names = "usb";
>>> +               };
>>>          };
>>>
>>>          pci1: pci at ee0b0000 {
>>> @@ -955,5 +969,19 @@
>>>                  interrupt-map = <0x0000 0 0 1 &gic 0 113
>>> IRQ_TYPE_LEVEL_HIGH
>>>                                   0x0800 0 0 1 &gic 0 113
>>> IRQ_TYPE_LEVEL_HIGH
>>>                                   0x1000 0 0 2 &gic 0 113
>>> IRQ_TYPE_LEVEL_HIGH>;
>>> +
>>> +               usb at 0,1 {
>>> +                       reg = <0x800 0 0 0 0>;
>>> +                       device_type = "pci";
>>> +                       phys = <&usbphy 1 0>;
>>> +                       phy-names = "usb";
>>> +               };
>>> +
>>> +               usb at 0,2 {
>>> +                       reg = <0x1000 0 0 0 0>;
>>> +                       device_type = "pci";
>>> +                       phys = <&usbphy 1 0>;
>>> +                       phy-names = "usb";
>>> +               };
>>>          };
>>>   };
>
>
>> Hi Sergei,
>
>
>> Above I see two hunks of DTS code but my r8a7790 data sheet contains
>> three USB PCI devices. Perhaps my understanding is wrong, or may there
>
>
>    You probably wanted to say 6 (OHCI and EHCI are 2 different PCI devices).

Sure. I guess it depends on if you count PCI host controllers or USB
host controllers..

>> is some other patch available to enable all USB PCI devices included
>> in the SoC?
>
>
>    This patch doesn't enable USB devices, it just links them to the PHY
> where it makes sense (for USB channel #1 it doesn't).

I know we've discussed this before, and for USB channel #1 you tend to
say that the PHY is not necessary for operation. From my side I am not
so sure. Over the months I seen several shortcuts and missing pieces
so for now just assume this is another rushed attempt. As usual I
would like to make sure the dependencies are correctly described in DT
before merging anything.

Like I mentioned earlier there are shared bits in UGCTRL register in
the PHY. Those may or may not affect USB channel #1. Furthermore, on
top of this we have the MSTP bit for the PHY that may or may not be
related to USB channel #1.

My opinion is that if the USB PHY requires the MSTP clock to be
enabled when using USB channel #1 _or_ the UGCTRL bits affect the USB
Channel #1 then DT needs to point out the relationship between the PHY
and the USB Host so Runtime PM can be used in the PHY driver to
dynamically manage the clock.

Thanks,

/ magnus
