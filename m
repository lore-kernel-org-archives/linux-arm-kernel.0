From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 9 Jun 2016 11:14:04 -0400 (EDT)
Subject: Platform-specific suspend/resume code in drivers
In-Reply-To: <57592E3C.8020005@laposte.net>
Message-ID: <Pine.LNX.4.44L0.1606091105380.1697-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Jun 2016, Sebastian Frias wrote:

> In addition to what Marc already replied, allow me to put a small (and hopefully self-contained) example:
> 
> - There's a SoC with a HW IP (UART, ethernet, usb or whatever else) for which a generic driver exists.
> - The generic driver only needs to know the base address of the block, and it will just work.
> - It'll just work, provided that when Linux boots the HW IP is enabled.
> - Indeed, the SoC may have other registers controlling if the HW IP is enabled/powered up.
> - Those registers are SoC specific, even if the HW IP is generic.
> 
> So the question is:
> => Does the use of a generic driver indirectly implies that any SoC specific registers are to be setup outside Linux?
> In other words, does Linux expects the HW IP to be powered up/enabled and ready to use? (ie: setup by the bootloader)

It varies.  Some implementations do expect the platform-specific parts
to be initialized before boot, whereas others include platform-specific
code to take care of this.

> If that is not the case, what is the recommended way to handle those registers?
> In other words, do the generic drivers provide with an API to handle SoC specific enable/clockgating/powerup registers?

Frequently drivers include platform-specific parts for this purpose.  
These parts are called through various platform-specific mechanisms at 
runtime, such as MODULE_DEVICE_TABLE entries for OF (i.e., Device Tree) 
or ACPI or just plain old platform devices.

For an example, look near the end of drivers/usb/host/ehci-platform.c.

Alan Stern
