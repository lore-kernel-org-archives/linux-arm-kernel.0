From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Mar 2012 19:21:50 +0000
Subject: [PATCH] USB: gadget driver for LPC32xx
In-Reply-To: <4F68CA5C.2090406@antcom.de>
References: <1332191930-2433-1-git-send-email-stigge@antcom.de>
 <201203201301.50159.arnd@arndb.de> <4F68CA5C.2090406@antcom.de>
Message-ID: <201203201921.51253.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 March 2012, Roland Stigge wrote:
> The ISP1301 is a relatively simple transceiver where the actual
> differential USB signals end up being generated/decoded. It contains
> some registers and is controlled via I2C to manipulate electrical
> settings (pull up / power etc.).
> 
> At a first glance, I found the following drivers to be using it:
> 
> ohci-nxp (was: ohci-pnx4008 + ohci-lpc32xx)
> isp1301_omap
> lpc32xx_udc (WIP)
> 
> The common functions that all of them are using are some low-level
> functions like read/write byte, read/write word. (For ohci-nxp, I used
> smbus commands.) I propose exporting just the defines for all the
> registers and their bits together with some accessor functions.

Sounds great. 

> Would those be the correct places for header and driver:
> 
> drivers/usb/misc/isp1301.c
> include/linux/usb/isp1301.h

I believe drivers/usb/misc/ is for usb devices, not for usb hots
(otg or otherwise), but I'm not sure where else it would go.

> As an example usage, I would let the next update of the lpc32xx_udc use
> it and separately provide patches to make the other drivers above also
> use it.

Ok. One thing I'm not sure about is how you would pair the i2c
device with the platform specific driver. The easiest solution would
be to assume that there is always just one of each, so isp1301 binds
to the i2c device and exports functions to be used by the platform
driver. This would fail if you ever have more than one isp1301
in the system, but neither omap nor pnx4008 seem to be doing that.

I guess we can always add support for that later if needed, using
a device tree phandle link, or a pointer to the i2c device in
platform_data.

	Arnd
