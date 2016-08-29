From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Aug 2016 23:58:32 +0100
Subject: [PATCH 06/33] ARM: pxa/lubbock: add GPIO driver for LUB_MISC_WR
 register
In-Reply-To: <87a8fve4bj.fsf@belgarion.home>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
 <E1beJk4-0000mH-4P@rmk-PC.armlinux.org.uk>
 <87a8fve4bj.fsf@belgarion.home>
Message-ID: <20160829225832.GH1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 09:57:20PM +0200, Robert Jarzmik wrote:
> Russell King <rmk+kernel@armlinux.org.uk> writes:
> If gpio_reg_init() failed (and I know, the probability of a lack of memory at
> that stage of the kernel boot is ridiculous), this will end up as an NULL
> pointer dereference if either IRDA or PCMCIA is used.
> 
> If it's expected, then the the pr_err() below would deserve a pr_crit(). I would
> as well take an option on a "panic()" if lubbock_misc_wr_gc allocation fails. If
> not, maybe a not-NULL test on lubbock_misc_wr_gc is in order, even if that would
> be "hidding under the carpet" and rather difficult to debug later.
> 
> Apart this detail point, it's good for me.

I'd prefer to kill the function entirely.  The PCMCIA user of it goes
later in the series, and all that's left are the three users in lubbock.c,
those being IrDA and ads7846.  I'd like to see pxaficp go the same way
as sa1100_ir - converting to using gpiolib gpiod* APIs to manage the
FIR mode select GPIO itself internally.

That leaves ads7846_cs(), and I'd be surprised if SPI didn't already of
wiring GPIOs up as chip selects.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
