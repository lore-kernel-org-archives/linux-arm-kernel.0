From: khilman@ti.com (Kevin Hilman)
Date: Mon, 26 Sep 2011 16:22:31 -0700
Subject: [PATCH v7 05/26] gpio/omap: handle save/restore context in GPIO
	driver
In-Reply-To: <1315918979-26173-6-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 13 Sep 2011 18:32:38 +0530")
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<1315918979-26173-6-git-send-email-tarun.kanti@ti.com>
Message-ID: <87lita7utk.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> Modify omap_gpio_prepare_for_idle() & omap_gpio_resume_after_idle() functions
> to handle save context & restore context respectively in the OMAP GPIO driver
> itself instead of calling these functions from pm specific files.
> For this, in gpio_prepare_for_idle(), call *_get_context_loss_count() and in
> gpio_resume_after_idle() call it again. If the count is different, do restore
> context. The workaround_enabled flag is no more required and is removed.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

[...]

> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
> index 9f3a007..6c6b1a7 100644
> --- a/arch/arm/mach-omap2/gpio.c
> +++ b/arch/arm/mach-omap2/gpio.c
> @@ -23,6 +23,7 @@
>  
>  #include <plat/omap_hwmod.h>
>  #include <plat/omap_device.h>
> +#include <plat/omap-pm.h>
>  
>  #include "powerdomain.h"
>  
> @@ -63,7 +64,9 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>  	pdata->bank_width = dev_attr->bank_width;
>  	pdata->dbck_flag = dev_attr->dbck_flag;
>  	pdata->virtual_irq_start = IH_GPIO_BASE + 32 * (id - 1);
> -
> +#ifdef CONFIG_PM
> +	pdata->get_context_loss_count = omap_pm_get_dev_context_loss_count;
> +#endif

no #ifdef please (c.f. "#ifdefs are ugly" in
Documentation/SubmittingPatches)

In this case, the existence of this API isn't dependent on CONFIG_PM, so
the #ifdef isn't right.

Kevin
