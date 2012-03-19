From: stigge@antcom.de (Roland Stigge)
Date: Mon, 19 Mar 2012 23:26:21 +0100
Subject: [PATCH] USB: gadget driver for LPC32xx
In-Reply-To: <201203192130.13583.arnd@arndb.de>
References: <1332191930-2433-1-git-send-email-stigge@antcom.de>
 <201203192130.13583.arnd@arndb.de>
Message-ID: <4F67B28D.3060500@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 19/03/12 22:30, Arnd Bergmann wrote:
> There is already a driver for the isp1301 otg part in the kernel, I don't
> think we want to add another one.
> 
> From what I can tell, this shares a common ancestry with the omap version
> but has diverged quite a bit. The best solution would really be to
> bring the two back together and let them share a common base driver,
> with the lpc32xx and omap specific bits in another file.

Yes, it's a good idea to share code where possible and consolidate into
one driver.

Please consider:

The LPC32xx driver is actually using only 3 functions via isp1301:

isp1301_udc_configure()
isp1301_set_powerstate()
isp1301_pullup_set()

The first of those is LPC32xx specific. The power setting function is
also done differently in isp1301_omap's power_up()/power_down() ("board
specific"). For the pullups, there is not (yet?) a dedicated API in the
OMAP driver, but it's really only two small I2C commands.

Are you still sure it's worth it to use a common driver when there is
hardly shared code?

Maybe the right thing is a common low-level isp1301 interface defining
all the registers and providing low-level (I2C) access functions,
leaving all the "higher level"/"board specific" functions up to the
existing drivers?

(I guess you meant drivers/usb/otg/isp1301_omap.c ?)

Thanks in advance,

Roland
