From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 21 Jan 2014 18:01:01 +0100
Subject: [PATCH 1/2] ohci-platform: Add support for controllers with
 big-endian regs / descriptors
In-Reply-To: <Pine.LNX.4.44L0.1401211116370.1272-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1401211116370.1272-100000@iolanthe.rowland.org>
Message-ID: <52DEA7CD.5070107@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/21/2014 05:40 PM, Alan Stern wrote:
> On Tue, 21 Jan 2014, Hans de Goede wrote:
>
>> Note this commit uses the same devicetree booleans for this as the ones
>> already existing in the usb-ehci bindings.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
>> --- a/drivers/usb/host/Kconfig
>> +++ b/drivers/usb/host/Kconfig
>> @@ -512,6 +512,10 @@ config USB_CNS3XXX_OHCI
>>
>>   config USB_OHCI_HCD_PLATFORM
>>   	tristate "Generic OHCI driver for a platform device"
>> +	# Always support LE, support BE on architectures which have readl_be
>> +	select USB_OHCI_LITTLE_ENDIAN
>> +	select USB_OHCI_BIG_ENDIAN_DESC if (AVR32 || MIPS || MICROBLAZE || SPARC || PPC32 || PPC64)
>> +	select USB_OHCI_BIG_ENDIAN_MMIO if (AVR32 || MIPS || MICROBLAZE || SPARC || PPC32 || PPC64)
>>   	default n
>
> The comment line above is slightly misleading.  USB_OHCI_LITTLE_ENDIAN
> doesn't exactly mean to include support for little-endian controllers;
> it means include mixed-endian support if either
> USB_OHCI_BIG_ENDIAN_DESC or USB_OHCI_BIG_ENDIAN_MMIO is set.  That is,
> the driver determines at runtime whether a particular controller is
> big-endian or little-endian, rather than choosing to support one or the
> other at compile time.

Right I already knew that, that is what the "Always" tried to summarize.

> In any case, the style we have adopted is that these select lines go in
> the arch-specific defconfig, not here.

Ok, so I should drop the Kconfig parts of both patches ?

>  For example, check out the
> occurrences of EHCI in arch/mips/Kconfig.  Also, I'm not sure how you
> came up with that list of architectures for the two selects; it's hard
> to say if they are right.  For instance, why did you include AVR32?

I included all archs which defines readl_be in asm/io.h

Regards,

Hans
