From: toddpoynor@google.com (Todd Poynor)
Date: Sat, 16 Jul 2011 12:07:34 -0700
Subject: [PATCH v4 REPOST 18/20] gpio/omap: use pm-runtime framework
In-Reply-To: <1310804152-9243-19-git-send-email-tarun.kanti@ti.com>
References: <1310804152-9243-1-git-send-email-tarun.kanti@ti.com>
	<1310804152-9243-19-git-send-email-tarun.kanti@ti.com>
Message-ID: <20110716190734.GB990@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 16, 2011 at 01:45:50PM +0530, Tarun Kanti DebBarma wrote:
> Call runtime pm APIs pm_runtime_get_sync() and pm_runtime_put_sync()
> for enabling/disabling clocks appropriately. Remove syscore_ops and
> instead use dev_pm_ops now.
> 
...
> @@ -481,6 +483,22 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
>  
>  	spin_lock_irqsave(&bank->lock, flags);
>  
> +	/*
> +	 * If this is the first gpio_request for the bank,
> +	 * enable the bank module.
> +	 */
> +	if (!bank->mod_usage) {
> +		if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev) < 0)) {
> +			dev_err(bank->dev, "%s: GPIO bank %d "
> +					"pm_runtime_get_sync failed\n",
> +					__func__, bank->id);
> +			return -EINVAL;


Must spin_unlock_irqrestore() first.

> +		}
> +
> +		/* Initialize the gpio bank registers to init time value */
> +		omap_gpio_mod_init(bank);

omap_gpio_mod_init calls mpuio_init calls platform_driver_register
which can't be called in an IRQs off and spinlocked atomic context,
for example, device_private_init calls kzalloc with GFP_KERNEL.

Concurrency protection for this will need to happen prior to the
spinlock (assuming it really does need to be an IRQ saving spinlock
and not a mutex).   Possibly a new mutex is needed to protect the
check for first usage and init'ing the bank (and blocking a racing
second caller until the init is done).

The omap_gpio_mod_init may be unbalanced with the code performed below
on last free of a GPIO for the bank?  If all GPIOs are freed and then
a new GPIO used, does omap_gpio_mod_init do the right thing?  Need a
separate flag to indicate whether one-time init has ever been
performed, vs. needing runtime PM enable/disable?

> +	}
> +
>  	/* Set trigger to none. You need to enable the desired trigger with
>  	 * request_irq() or set_irq_type().
>  	 */
> @@ -517,7 +535,6 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&bank->lock, flags);
> -
>  	if (bank->regs->wkup_status)
>  		/* Disable wake-up during idle for dynamic tick */
>  		_gpio_rmw(base, bank->regs->wkup_status, 1 << offset, 0);
> @@ -535,6 +552,18 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
>  	}
>  
>  	_reset_gpio(bank, bank->chip.base + offset);
> +
> +	/*
> +	 * If this is the last gpio to be freed in the bank,
> +	 * disable the bank module.
> +	 */
> +	if (!bank->mod_usage) {
> +		if (IS_ERR_VALUE(pm_runtime_put_sync(bank->dev) < 0)) {
> +			dev_err(bank->dev, "%s: GPIO bank %d "
> +					"pm_runtime_put_sync failed\n",
> +					__func__, bank->id);
> +		}
> +	}
>  	spin_unlock_irqrestore(&bank->lock, flags);


Todd
