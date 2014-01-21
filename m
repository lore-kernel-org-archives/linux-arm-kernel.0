From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 21 Jan 2014 11:48:40 -0800
Subject: [PATCH 1/2] ohci-platform: Add support for controllers with
 big-endian regs / descriptors
In-Reply-To: <Pine.LNX.4.44L0.1401211308040.1272-100000@iolanthe.rowland.org>
References: <52DEA7CD.5070107@redhat.com>
 <Pine.LNX.4.44L0.1401211308040.1272-100000@iolanthe.rowland.org>
Message-ID: <CAGVrzcZ2arvg3yryHE5KcMz6f1Js2m1=TbWxwZzk12kyKq0tKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014/1/21 Alan Stern <stern@rowland.harvard.edu>:
> On Tue, 21 Jan 2014, Hans de Goede wrote:
>
>> Hi,
>>
>> On 01/21/2014 05:40 PM, Alan Stern wrote:
>> > On Tue, 21 Jan 2014, Hans de Goede wrote:
>> >
>> >> Note this commit uses the same devicetree booleans for this as the ones
>> >> already existing in the usb-ehci bindings.
>> >>
>> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> >
>> >> --- a/drivers/usb/host/Kconfig
>> >> +++ b/drivers/usb/host/Kconfig
>> >> @@ -512,6 +512,10 @@ config USB_CNS3XXX_OHCI
>> >>
>> >>   config USB_OHCI_HCD_PLATFORM
>> >>    tristate "Generic OHCI driver for a platform device"
>> >> +  # Always support LE, support BE on architectures which have readl_be
>> >> +  select USB_OHCI_LITTLE_ENDIAN
>> >> +  select USB_OHCI_BIG_ENDIAN_DESC if (AVR32 || MIPS || MICROBLAZE || SPARC || PPC32 || PPC64)
>> >> +  select USB_OHCI_BIG_ENDIAN_MMIO if (AVR32 || MIPS || MICROBLAZE || SPARC || PPC32 || PPC64)
>> >>    default n
>
>> > In any case, the style we have adopted is that these select lines go in
>> > the arch-specific defconfig, not here.
>>
>> Ok, so I should drop the Kconfig parts of both patches ?
>
> That's rigt.  They are likely to cause trouble, and if the selects were
> needed then they should already be present somewhere else.

Absolutely, they will actually break platforms. Since you added some
guards for when these properties are set, but proper support in the
kernel is not enabled, this is already catching misuses, and as such
is already an improvement.
-- 
Florian
