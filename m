From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 11 Sep 2018 19:29:13 -0500
Subject: [PATCH] gpio: omap: Remove custom PM calls and use cpu_pm instead
In-Reply-To: <20180911183729.17110-1-tony@atomide.com>
References: <20180911183729.17110-1-tony@atomide.com>
Message-ID: <01f5b04a-82ed-fafe-5b90-3e662f21d0db@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/11/2018 01:37 PM, Tony Lindgren wrote:
> For a long time the gpio-omap custom PM calls have been annoying me so
> let's replace them with cpu_pm instead. This will enable GPIO PM for
> deeper idle states on omap4. And we can handle GPIO PM for omap2/3/4
> in the same way.
> 
> Note that with this patch we are also slightly changing GPIO PM to be
> less aggressive for omap3 and only will idle GPIO when PER context
> may be lost.
> 
> For omap2, we don't need to save context and don't want to remove any
> triggering so let's add a quirk flag for that.
> 
> Let's do this all in a single patch to avoid a situation where old
> custom calls still are used with new code.
> 
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Ladislav Michl <ladis@linux-mips.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Note that this depends on previously posted patch:
> 
> [PATCH] gpio: omap: Add level wakeup handling for omap4 based SoCs
> 
> Linus, once people are happy with these, can you maybe set up an
> immutable branch with both patches in it?
> 

[...]

>   }
>   
> +static int gpio_omap_cpu_notifier(struct notifier_block *nb,
> +				  unsigned long cmd, void *v)
> +{
> +	struct gpio_bank *bank;
> +	struct device *dev;
> +	int error;
> +
> +	bank = container_of(nb, struct gpio_bank, nb);
> +	dev = bank->chip.parent;
> +
> +	switch (cmd) {
> +	case CPU_CLUSTER_PM_ENTER:
> +		/* Gets cleard on runtime_suspend */
> +		bank->power_mode = OFF_MODE;

It has to be reset somewhere.

> +
> +		error = pm_runtime_put_sync(dev);
> +		if (error < 0)
> +			dev_warn(dev, "CPU PM enter: %i\n", error);
> +		break;
> +	case CPU_CLUSTER_PM_ENTER_FAILED:
> +	case CPU_CLUSTER_PM_EXIT:
> +		error = pm_runtime_get_sync(dev);
> +		if (error < 0) {
> +			dev_err(dev, "CPU PM exit %i\n", error);
> +			pm_runtime_put_noidle(dev);
> +		}
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
[...]


-- 
regards,
-grygorii
