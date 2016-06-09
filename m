From: sf84@laposte.net (Sebastian Frias)
Date: Thu, 9 Jun 2016 10:52:12 +0200
Subject: Platform-specific suspend/resume code in drivers
In-Reply-To: <Pine.LNX.4.44L0.1606081340050.2191-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1606081340050.2191-100000@iolanthe.rowland.org>
Message-ID: <57592E3C.8020005@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

On 06/08/2016 07:45 PM, Alan Stern wrote:
>> I guess the thermal driver is platform-specific, but most devices
>> are third-party IP blocks, so there is a "common" driver upstream.
>> But I would need a platform-specific suspend/resume sequence,
>> just for my platform.
> 
> Why?  What sort of platform-specific things do you need to do?
> 
>>> For another, the driver should be written in a way that doesn't require
>>> this sort of code.  The ops pointer (not any of the structure's members
>>> -- a pointer to the structure) should be set by the platform-dependent
>>> part of the driver that handles initialization.
>>
>> I don't understand. If my platform loses context on suspend, then
>> I must save/restore it. But this wasteful operation should not be
>> imposed on other platforms.
> 
> More details, please.

In addition to what Marc already replied, allow me to put a small (and hopefully self-contained) example:

- There's a SoC with a HW IP (UART, ethernet, usb or whatever else) for which a generic driver exists.
- The generic driver only needs to know the base address of the block, and it will just work.
- It'll just work, provided that when Linux boots the HW IP is enabled.
- Indeed, the SoC may have other registers controlling if the HW IP is enabled/powered up.
- Those registers are SoC specific, even if the HW IP is generic.

So the question is:
=> Does the use of a generic driver indirectly implies that any SoC specific registers are to be setup outside Linux?
In other words, does Linux expects the HW IP to be powered up/enabled and ready to use? (ie: setup by the bootloader)

If that is not the case, what is the recommended way to handle those registers?
In other words, do the generic drivers provide with an API to handle SoC specific enable/clockgating/powerup registers?

Thanks in advance,

Sebastian
