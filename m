From: stigge@antcom.de (Roland Stigge)
Date: Tue, 20 Mar 2012 19:20:12 +0100
Subject: [PATCH] USB: gadget driver for LPC32xx
In-Reply-To: <201203201301.50159.arnd@arndb.de>
References: <1332191930-2433-1-git-send-email-stigge@antcom.de>
 <201203192130.13583.arnd@arndb.de> <4F67B28D.3060500@antcom.de>
 <201203201301.50159.arnd@arndb.de>
Message-ID: <4F68CA5C.2090406@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 03/20/2012 02:01 PM, Arnd Bergmann wrote:
>> Maybe the right thing is a common low-level isp1301 interface defining
>> all the registers and providing low-level (I2C) access functions,
>> leaving all the "higher level"/"board specific" functions up to the
>> existing drivers?
>>
>> (I guess you meant drivers/usb/otg/isp1301_omap.c ?)
> 
> Yes, that sounds like a very good idea. Can you describe which part of
> the function isp1301 does? It's not clear how the layering between
> that and the platform driver should end up.

The ISP1301 is a relatively simple transceiver where the actual
differential USB signals end up being generated/decoded. It contains
some registers and is controlled via I2C to manipulate electrical
settings (pull up / power etc.).

At a first glance, I found the following drivers to be using it:

ohci-nxp (was: ohci-pnx4008 + ohci-lpc32xx)
isp1301_omap
lpc32xx_udc (WIP)

The common functions that all of them are using are some low-level
functions like read/write byte, read/write word. (For ohci-nxp, I used
smbus commands.) I propose exporting just the defines for all the
registers and their bits together with some accessor functions.

Would those be the correct places for header and driver:

drivers/usb/misc/isp1301.c
include/linux/usb/isp1301.h

?

As an example usage, I would let the next update of the lpc32xx_udc use
it and separately provide patches to make the other drivers above also
use it.

Thanks in advance,

Roland
