From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 18 Jan 2010 09:46:22 +0100
Subject: [PATCH] otg Kconfig: add missing select USB_OTG_UTILS to
	USB_ULPI option
In-Reply-To: <1263576731-26075-1-git-send-email-valentin.longchamp@epfl.ch>
References: <1263576731-26075-1-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <20100118084622.GA15054@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Valentin,

On Fri, Jan 15, 2010 at 06:32:11PM +0100, Valentin Longchamp wrote:
> Fixes a link error for mx3 platforms with ULPI host devices enabled. Should go for rc5 since it completes http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f9ffaa9ca9889f17ef30b82bc0bf954d141280f8 that was introduced in rc4.
Actually I think this is a seperate issue.  f9ffaa9ca fixed arch code to
only use ULPI if it is configured to be available, your patch asserts
that the code is built-in for arch code if configured.

The problem is that with CONFIG_USB_ULPI=y + CONFIG_USB<=m +
CONFIGPCI=n + CONFIG_USB_OTG_UTILS=n drivers/usb/otg/ulpi.o isn't built-in.

So there are several ways to fix it:

 - let CONFIG_USB_ULPI depend on CONFIG_USB_OTG_UTILS (as done here).
   As drivers/Makefile has:

	obj-$(CONFIG_USB_OTG_UTILS)     += usb/otg/

   this works fine.  The downside is that CONFIG_USB_ULPI doesn't really
   depend on CONFIG_USB_OTG_UTILS.

 - add to drivers/Makefile

	obj-$(CONFIG_USB_ULPI) += usb/otg/

   .  That's not pretty.

 - rework the code that arch code doesn't need functions provided by
   drivers/usb/otg/ulpi.c.  That's my favorite, but probably needs some
   work.

 - extend Kconfig to have something like builtin-if-configured-modular.
   Then we could have:

	builtin-$(CONFIG_USB_ULPI) += ulpi.o

   in drivers/usb/otg/Makefile resulting in ulpi.o being linked into
   drivers/builtin.o even though drivers/usb wouldn't be considered for
   building in.

   Would be nice, but this looks more like a long-term-project.

That doesn't mean I'm against Valentin's patch, but IMHO the commit log
should@least contain the breaking config (i.e. CONFIG_USB_ULPI=y +
CONFIG_USB<=m + CONFIG_PCI=n + CONFIG_USB_OTG_UTILS=n) and the resulting
error (message).

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
