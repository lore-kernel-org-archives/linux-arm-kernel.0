From: stigge@antcom.de (Roland Stigge)
Date: Thu, 23 Aug 2012 00:16:12 +0200
Subject: [PATCH 1/2] usb: change the dependency chain for LPC32XX and
 ISP1301
In-Reply-To: <Pine.LNX.4.44L0.1208221537260.1328-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1208221537260.1328-100000@iolanthe.rowland.org>
Message-ID: <50355A2C.9010505@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 22/08/12 21:49, Alan Stern wrote:
>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>> index c3f619b..cac3ee2 100644
>> --- a/drivers/usb/host/Kconfig
>> +++ b/drivers/usb/host/Kconfig
>> @@ -292,7 +292,6 @@ config USB_OHCI_HCD
>>  	depends on USB && USB_ARCH_HAS_OHCI
>>  	select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3
>>  	select USB_OTG_UTILS if ARCH_OMAP
>> -	select USB_ISP1301 if ARCH_LPC32XX || ARCH_PNX4008
> 
> You want to avoid selecting USB_ISP1301, right?

The ultimate goal is just to prevent the compile error that currently
occurs when I2C isn't selected on LPC32XX but UDC is. It's an invalid
config combination, not easy to prevent by current Kconfig mechanism.

>> @@ -412,6 +411,15 @@ config USB_CNS3XXX_OHCI
>>  	  Enable support for the CNS3XXX SOC's on-chip OHCI controller.
>>  	  It is needed for low-speed USB 1.0 device support.
>>  
>> +config USB_OHCI_LPC32XX_PNX4008
>> +	bool "LPC32XX or PNX4008 OHCI Module"
>> +	depends on USB_OHCI_HCD
>> +	depends on USB_ISP1301
>> +	---help---
>> +	  Enable support for the LPC32XX or PNX4008 SOC's on-chip
>> +	  OHCI controller.
>> +	  It is needed for low-speed USB 1.0 device support.
> 
> Instead you introduce a new symbol to control whether or not ohci-nxp.c
> gets compiled.  The new symbol depends on USB_ISP1301 but not on
> ARCH_LPC32XX or ARCH_PNX4008, which means in theory it could be defined
> even under a totally different arch.

This issue could be resolved in a different way: Have you followed the
discussion at linux-arm-kernel at lists.infradead.org on 2012-08-20,
Subject "i2c: pnx: Fix bit definitions"? If nothing unexpected turns
out, PNX4008 should probably be removed altogether. (Practically
abandoned arch for 6 years.) Easily possible for v3.7.

Then, the resulting solution is much simpler and Sebastian's patch obsolete.

Thanks,

Roland
