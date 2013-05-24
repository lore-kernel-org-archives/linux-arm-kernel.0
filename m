From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 24 May 2013 09:19:56 +0200
Subject: [PATCH V2 1/6] drivers: bus: add a new driver for WEIM
In-Reply-To: <519F13E5.2040701@freescale.com>
References: <1369296978-7669-1-git-send-email-b32955@freescale.com>
 <201305231153.38111.arnd@arndb.de>
 <20130523115505.GG32299@pengutronix.de>
 <201305231509.57651.arnd@arndb.de> <519F13E5.2040701@freescale.com>
Message-ID: <20130524071956.GY32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 03:16:53PM +0800, Huang Shijie wrote:
> ? 2013?05?23? 21:09, Arnd Bergmann ??:
> >OTOH, I agree that it would be nicer if the clk could remain turned
> >off as long as no children are active. Can we do a clk_disable()
> >after setting up the timings for the children and then expect those
> >to actually start up the clk again when they need it?
> >
> >Or to take things further: would it make sense to represent WEIM
> >itself as a clock driver and perform the settings for each child
> >only when it sets up its own clk?
> >
> If the child's subsystem supports it, we can do it.
> 
> The mtd nand does support this feature, it has @select_chip() hook.
> We can enable/disable the clock in the @select_chip().
> 
> But the mtd NOR does _not_ supports it.
> Please read the /drivers/mtd/maps/physmap_of.c and
> /drivers/mtd/chips/cfi_cmd_set_xxx.c.
> Of course, we can add the feature to NOR subsystem. But that's
> another issue.
> 
> So the weim should enable the clock all the time now.

Personally I'm fine with this, but you should not disable the clock when
the children are active, so either make sure

- the WEIM driver can't be unloaded, or
- the WEIM driver unregisters its children, or
- just leave the clock enabled.

> ------------------------------------------------------------------------------------------
> 
> The system hang at :
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> ## Booting kernel from Legacy Image at 10800000 ...
>    Image Name:   Linux
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    4259851 Bytes =  4.1 MB
>    Load Address: 10008000
>    Entry Point:  10008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
> 
> Starting kernel ...
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++==

Use EARLY_PRINTK or move your driver init to a late_initcall to make it
initialize after the console.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
