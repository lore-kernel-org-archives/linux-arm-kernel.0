From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Mar 2013 17:40:43 +0000
Subject: [PATCH v2] mmc: mvsdio: fix non-DT probing of GPIOs
In-Reply-To: <1363792148-26405-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1363792148-26405-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130320174043.GN4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 04:09:08PM +0100, Thomas Petazzoni wrote:
> Ralph Droms <rdroms.ietf@gmail.com> reported that 3.9-rc was breaking
> the SDIO interface on his Sheevaplug platform, and that the recent
> changes to the mvsdio driver are responsible for this breakage.
> 
> After investigation, is turns out that the Sheevaplug does not have
> any "card detect" GPIO, and the Sheevaplug has not been converted to
> the Device Tree. Therefore, the Sheevaplug board code does not define
> a value for the .gpio_card_detect field of the mvsdio_platform_data
> structure, which means that its value is 0. Unfortunately,
> gpio_is_valid() considers 0 as a valid GPIO, and therefore calls
> mmc_gpio_request_cd(), which fails and makes the entire probing of the
> driver fail.

Hmm, and we have the situation where GPIO 0 is a valid GPIO on some
platforms too.  So really, we should do something better here.

We could either go the route of IRQs and declare GPIO 0 to always be
invalid - fixing gpio_is_valid() appropriately, or we should to fix
it such that -1 is supplied in the platform data if no GPIOs are
specified.

However, for -rc I suggest going with your fix which merely restores
the old behaviour.

> In fact, in the previous mvsdio code, before the Device Tree binding
> was introduced, 0 was not considered as a valid GPIO.

It would be nice to include the commit reference here where this changed.
07728b77c03d (mmc: mvsdio: use slot-gpio for card detect gpio).
