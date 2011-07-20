From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Wed, 20 Jul 2011 15:38:02 +0530
Subject: [PATCH v4 REPOST 18/20] gpio/omap: use pm-runtime framework
In-Reply-To: <20110716190734.GB990@google.com>
References: <1310804152-9243-1-git-send-email-tarun.kanti@ti.com>
	<1310804152-9243-19-git-send-email-tarun.kanti@ti.com>
	<20110716190734.GB990@google.com>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037C0C4DBE@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]
> >
> > +	/*
> > +	 * If this is the first gpio_request for the bank,
> > +	 * enable the bank module.
> > +	 */
> > +	if (!bank->mod_usage) {
> > +		if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev) < 0)) {
> > +			dev_err(bank->dev, "%s: GPIO bank %d "
> > +					"pm_runtime_get_sync failed\n",
> > +					__func__, bank->id);
> > +			return -EINVAL;
> 
> 
> Must spin_unlock_irqrestore() first.
Yes.

> 
> > +		}
> > +
> > +		/* Initialize the gpio bank registers to init time value */
> > +		omap_gpio_mod_init(bank);
> 
> omap_gpio_mod_init calls mpuio_init calls platform_driver_register
> which can't be called in an IRQs off and spinlocked atomic context,
> for example, device_private_init calls kzalloc with GFP_KERNEL.
Right! The present form of *_mod_init() is not suitable here.

> 
> Concurrency protection for this will need to happen prior to the
> spinlock (assuming it really does need to be an IRQ saving spinlock
> and not a mutex).   Possibly a new mutex is needed to protect the
> check for first usage and init'ing the bank (and blocking a racing
> second caller until the init is done).
I looked at the implementation once again with the comments at background.
There are gaps which require fixing. Thanks.

> 
> The omap_gpio_mod_init may be unbalanced with the code performed below
> on last free of a GPIO for the bank?  If all GPIOs are freed and then
> a new GPIO used, does omap_gpio_mod_init do the right thing?  Need a
> separate flag to indicate whether one-time init has ever been
> performed, vs. needing runtime PM enable/disable?
Yes, there is imbalance. I am re-looking and fixing.
--
Tarun
[...]
