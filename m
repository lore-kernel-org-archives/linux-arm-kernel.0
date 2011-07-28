From: toddpoynor@google.com (Todd Poynor)
Date: Thu, 28 Jul 2011 00:43:27 -0700
Subject: [PATCH v4 REPOST 18/20] gpio/omap: use pm-runtime framework
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB037C202D59@dbde02.ent.ti.com>
References: <1310804152-9243-1-git-send-email-tarun.kanti@ti.com>
	<1310804152-9243-19-git-send-email-tarun.kanti@ti.com>
	<20110716190734.GB990@google.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB037C202D59@dbde02.ent.ti.com>
Message-ID: <20110728074327.GA12916@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2011 at 05:14:58PM +0530, DebBarma, Tarun Kanti wrote:
...
> > omap_gpio_mod_init calls mpuio_init calls platform_driver_register
> > which can't be called in an IRQs off and spinlocked atomic context,
...
> I have isolated mpuio_init() from omap_gpio_mod_init().
> mpuio_init() is now called once in omap_gpio_probe().

Looking at omap_gpio_mod_init() it seems like much of its processing
could probably be done once at probe time (or at pm_runtime_get_sync
time) as well, namely setting the IRQ enable masks.

Ungating the interface clock, enabling wakeup, setting smart idle for
the module, and enabling the (old-style) system clock seem like either
one-time actions at probe, or a part of the pm_runtime_get_sync
callback.

Or is there some other reason these power management actions should be
taken each time a GPIO is requested in the block (when none were
previously requested), after the runtime PM get_sync callback, but
not as part of the get_sync callback?  If so, what caused
the smart idle setting to be lost, or the interface clock gated, if
not the pm_runtime_put_sync?


Todd

> > The omap_gpio_mod_init may be unbalanced with the code performed below
> > on last free of a GPIO for the bank?  If all GPIOs are freed and then
> > a new GPIO used, does omap_gpio_mod_init do the right thing?  Need a
> > separate flag to indicate whether one-time init has ever been
> > performed, vs. needing runtime PM enable/disable?
> With the above changes I am seeing omap_gpio_mod_init() is balanced.
> Let me know if I am still missing something.
> --
> Tarun
