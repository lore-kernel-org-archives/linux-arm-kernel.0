From: khilman@ti.com (Kevin Hilman)
Date: Tue, 06 Sep 2011 16:53:00 -0700
Subject: [PATCH v6 19/25] gpio/omap: cleanup prepare_for_idle and
	resume_after_idle
In-Reply-To: <1314798161-19523-20-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 31 Aug 2011 19:12:35 +0530")
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-20-git-send-email-tarun.kanti@ti.com>
Message-ID: <874o0pxm77.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> Cleanup  omap2_gpio_prepare_for_idle() and omap2_gpio_resume_after_idle()
> by moving most of the stuff to *_runtime_suspend() and *_runtime_resume().

Why? 

(I know the answer, but it should be in the changelog.)

> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Also, as pointed out in an earlier patch, now that this is moved out of
the idle path, where interrupts were known to be disabled, the register
accesses in the runtime PM callbacks need to be protected by the
spinlock just like they are in other parts of the driver.

[...]

> @@ -1305,9 +1316,14 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
>  				bank->base + bank->regs->fallingdetect);
>  	__raw_writel(bank->context.dataout, bank->base + bank->regs->dataout);
>  }
> +#else
> +#define omap_gpio_runtime_suspend NULL
> +#define omap_gpio_runtime_resume NULL
>  #endif
>  
>  static const struct dev_pm_ops gpio_pm_ops = {
> +	.runtime_suspend	= omap_gpio_runtime_suspend,
> +	.runtime_resume		= omap_gpio_runtime_resume,

Please use SET_RUNTIME_PM_OPS() (see <linux/pm.h.)

>  	.suspend		= omap_gpio_suspend,
>  	.resume			= omap_gpio_resume,
>  };

Kevin
