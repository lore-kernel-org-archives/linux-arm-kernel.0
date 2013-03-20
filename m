From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 20 Mar 2013 20:29:41 +0100
Subject: [PATCH v2] mmc: mvsdio: fix non-DT probing of GPIOs
In-Reply-To: <20130320174043.GN4977@n2100.arm.linux.org.uk>
References: <1363792148-26405-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130320174043.GN4977@n2100.arm.linux.org.uk>
Message-ID: <20130320202941.1325d2b3@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Wed, 20 Mar 2013 17:40:43 +0000, Russell King - ARM Linux wrote:

> > After investigation, is turns out that the Sheevaplug does not have
> > any "card detect" GPIO, and the Sheevaplug has not been converted to
> > the Device Tree. Therefore, the Sheevaplug board code does not define
> > a value for the .gpio_card_detect field of the mvsdio_platform_data
> > structure, which means that its value is 0. Unfortunately,
> > gpio_is_valid() considers 0 as a valid GPIO, and therefore calls
> > mmc_gpio_request_cd(), which fails and makes the entire probing of the
> > driver fail.
> 
> Hmm, and we have the situation where GPIO 0 is a valid GPIO on some
> platforms too.  So really, we should do something better here.

Agreed.

> We could either go the route of IRQs and declare GPIO 0 to always be
> invalid - fixing gpio_is_valid() appropriately, or we should to fix
> it such that -1 is supplied in the platform data if no GPIOs are
> specified.

I haven't followed all the details, but isn't the gpiod work also a way
of solving this problem? Also, the platform data stuff is going away,
at least for the users of the mvsdio driver, since they are being
converted to the Device Tree, and of_get_gpio() properly returns an
error code when no GPIO has been specified in the DT.

> However, for -rc I suggest going with your fix which merely restores
> the old behaviour.

Yes

> > In fact, in the previous mvsdio code, before the Device Tree binding
> > was introduced, 0 was not considered as a valid GPIO.
> 
> It would be nice to include the commit reference here where this changed.
> 07728b77c03d (mmc: mvsdio: use slot-gpio for card detect gpio).

Sure, I'll resend a v3 that includes this.

Thanks for the review!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
