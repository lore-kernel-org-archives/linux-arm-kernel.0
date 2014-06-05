From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 5 Jun 2014 09:43:51 +0900
Subject: [PATCH v2] ARM: shmobile: r8a7790: link PCI USB devices to USB PHY
In-Reply-To: <538F7BA7.2010707@cogentembedded.com>
References: <201405270217.33057.sergei.shtylyov@cogentembedded.com>
 <CANqRtoT+xKmK7wkayiD9yCmUqFNKWxpeSgkGTiCqc+THYE0sVw@mail.gmail.com>
 <5383C439.1080808@cogentembedded.com>
 <CANqRtoTanAWvEODE99dY-BRU1FOm3V78FM6ePYKtVbK1Ro+79A@mail.gmail.com>
 <53865A4F.7000007@cogentembedded.com>
 <538F7BA7.2010707@cogentembedded.com>
Message-ID: <CANqRtoSAZrLhJK0pnEGAozdB2sDk7wEL+SLh8Vggb5joa_HMyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 5, 2014 at 5:03 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>
> On 05/29/2014 01:51 AM, Sergei Shtylyov wrote:
>
>>>>>> Describe the PCI USB devices that are behind the PCI bridges, adding
>>>>>> necessary
>>>>>> links to the USB PHY device.
>
>
>>>>>> Based on the original work by Ben Dooks <ben.dooks@codethink.co.uk>.
>
>
>>>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
>
>>>>>> ---
>>>>>> This patch is against 'renesas-devel-v3.15-rc7-20140526' tag of Simon
>>>>>> Horman's
>>>>>> 'renesas.git' repo plus R8A7790/Lager PCI and USB PHY support patches
>>>>>> posted
>>>>>> before. The patch requires the internal PCI DT support, USB PHY
>>>>>> driver,
>>>>>> and
>>>>>> USB HCD generic PHY support (also already posted) in order to work.
>
>
>>>>>> Changes in version 2:
>>>>>> - renamed the PCI OHCI/EHCI device nodes to comply with the PCI
>>>>>> binding;
>>>>>> - changed the PHY specifier in the PCI#2 node to reflect that channel
>>>>>> #1
>>>>>> support
>>>>>>     was dropped;
>>>>>> - resolved rejects, refreshed the patch.
>
>
>>>>>>    arch/arm/boot/dts/r8a7790.dtsi |   28 ++++++++++++++++++++++++++++
>>>>>>    1 file changed, 28 insertions(+)
>
>
>>>>>> Index: renesas/arch/arm/boot/dts/r8a7790.dtsi
>>>>>> ===================================================================
>>>>>> --- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
>>>>>> +++ renesas/arch/arm/boot/dts/r8a7790.dtsi
>>>>>> @@ -919,6 +919,20 @@
>>>>>>                   interrupt-map = <0x0000 0 0 1 &gic 0 108
>>>>>> IRQ_TYPE_LEVEL_HIGH
>>>>>>                                    0x0800 0 0 1 &gic 0 108
>>>>>> IRQ_TYPE_LEVEL_HIGH
>>>>>>                                    0x1000 0 0 2 &gic 0 108
>>>>>> IRQ_TYPE_LEVEL_HIGH>;
>>>>>> +
>>>>>> +               usb at 0,1 {
>>>>>> +                       reg = <0x800 0 0 0 0>;
>>>>>> +                       device_type = "pci";
>>>>>> +                       phys = <&usbphy 0 0>;
>>>>>> +                       phy-names = "usb";
>>>>>> +               };
>>>>>> +
>>>>>> +               usb at 0,2 {
>>>>>> +                       reg = <0x1000 0 0 0 0>;
>>>>>> +                       device_type = "pci";
>>>>>> +                       phys = <&usbphy 0 0>;
>>>>>> +                       phy-names = "usb";
>>>>>> +               };
>>>>>>           };
>>>>>>
>>>>>>           pci1: pci at ee0b0000 {
>>>>>> @@ -955,5 +969,19 @@
>>>>>>                   interrupt-map = <0x0000 0 0 1 &gic 0 113
>>>>>> IRQ_TYPE_LEVEL_HIGH
>>>>>>                                    0x0800 0 0 1 &gic 0 113
>>>>>> IRQ_TYPE_LEVEL_HIGH
>>>>>>                                    0x1000 0 0 2 &gic 0 113
>>>>>> IRQ_TYPE_LEVEL_HIGH>;
>>>>>> +
>>>>>> +               usb at 0,1 {
>>>>>> +                       reg = <0x800 0 0 0 0>;
>>>>>> +                       device_type = "pci";
>>>>>> +                       phys = <&usbphy 1 0>;
>>>>>> +                       phy-names = "usb";
>>>>>> +               };
>>>>>> +
>>>>>> +               usb at 0,2 {
>>>>>> +                       reg = <0x1000 0 0 0 0>;
>>>>>> +                       device_type = "pci";
>>>>>> +                       phys = <&usbphy 1 0>;
>>>>>> +                       phy-names = "usb";
>>>>>> +               };
>>>>>>           };
>>>>>>    };
>
>
> [...]
>
>
>>> I know we've discussed this before, and for USB channel #1 you tend to
>>> say that the PHY is not necessary for operation. From my side I am not
>>> so sure. Over the months I seen several shortcuts and missing pieces
>>> so for now just assume this is another rushed attempt. As usual I
>>> would like to make sure the dependencies are correctly described in DT
>>> before merging anything.
>
>
>>> Like I mentioned earlier there are shared bits in UGCTRL register in
>
>
>>     Did you mean UGCTRL or UGCTRL2 register? My testing didn't prove that
>> the
>> UGCTRL bits (CONNECT and PLLRESET) affect anything but the USBHS
>> controller --
>> my PHY driver only touches these bits if the PHY selected corresponds to
>> the
>> USBHS itself (which is not supported by DT yet)...
>
>
>>> the PHY. Those may or may not affect USB channel #1. Furthermore, on
>>> top of this we have the MSTP bit for the PHY that may or may not be
>>> related to USB channel #1.
>
>
>>     There is no MSTP bit for the PHY, there's MSTP bit for USBHS
>> controller of
>> which this PHY is a part.
>
>
>>> My opinion is that if the USB PHY requires the MSTP clock to be
>>> enabled when using USB channel #1 _or_ the UGCTRL bits affect the USB
>>> Channel #1 then DT needs to point out the relationship between the PHY
>>> and the USB Host
>
>
>>     I agree and I can conduct some additional tests only linking the USB
>> channel #1 to the PHY driver, and hence enabling the USBHS clock only for
>> it...
>
>
>    OK, I've done additional testing and USB channel #1 on R8A7790 works
> regardless of the USBHS clock being enabled or not.

Thanks for testing! So I suppose this means that we can manage the USB
PHY clock used for channel #0 and #2 independently of channel #1?

Cheers,

/ magnus
