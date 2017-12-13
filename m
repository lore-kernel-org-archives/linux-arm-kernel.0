From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 13 Dec 2017 10:53:45 +0100
Subject: [PATCH V4 08/12] boot_constraint: Manage deferrable constraints
In-Reply-To: <88c7a0a6421d267c118f501ea1e920b04649002d.1509284255.git.viresh.kumar@linaro.org>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
 <88c7a0a6421d267c118f501ea1e920b04649002d.1509284255.git.viresh.kumar@linaro.org>
Message-ID: <20171213095345.GJ13194@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 29, 2017 at 07:18:56PM +0530, Viresh Kumar wrote:
> It is possible that some of the resources aren't available at the time
> constraints are getting set and the boot constraints core will return
> -EPROBE_DEFER for them. In order to retry adding the constraints at a
> later point of time (after the resource is added and before any of its
> users come up), this patch proposes two things:
> 
> - Each constraint is represented by a virtual platform device, so that
>   it is re-probed again until the time all the dependencies aren't met.
>   The platform device is removed along with the constraint, with help of
>   the free_resources() callback.
> 
> - Enable early defer probing support by calling
>   driver_enable_deferred_probe(), so that the core retries probing
>   deferred devices every time any device is bound to a driver. This
>   makes sure that the constraint is set before any of the users of the
>   resources come up.
> 
> This is tested on ARM64 Hikey board where probe was deferred for a
> device.
> 
> Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/dd.c                         |  12 ++
>  drivers/boot_constraints/Makefile         |   2 +-
>  drivers/boot_constraints/deferrable_dev.c | 235 ++++++++++++++++++++++++++++++
>  include/linux/boot_constraint.h           |  14 ++
>  4 files changed, 262 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/boot_constraints/deferrable_dev.c
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 4eec27fe2b2b..19eff5d08b9a 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -228,6 +228,18 @@ void device_unblock_probing(void)
>  	driver_deferred_probe_trigger();
>  }
>  
> +/**
> + * driver_enable_deferred_probe() - Enable probing of deferred devices
> + *
> + * We don't want to get in the way when the bulk of drivers are getting probed
> + * and so deferred probe is disabled in the beginning. Enable it now because we
> + * need it.
> + */
> +void driver_enable_deferred_probe(void)
> +{
> +	driver_deferred_probe_enable = true;
> +}
> +
>  /**
>   * deferred_probe_initcall() - Enable probing of deferred devices
>   *
> diff --git a/drivers/boot_constraints/Makefile b/drivers/boot_constraints/Makefile
> index b7ade1a7afb5..a765094623a3 100644
> --- a/drivers/boot_constraints/Makefile
> +++ b/drivers/boot_constraints/Makefile
> @@ -1,3 +1,3 @@
>  # Makefile for device boot constraints
>  
> -obj-y := clk.o core.o pm.o supply.o
> +obj-y := clk.o deferrable_dev.o core.o pm.o supply.o
> diff --git a/drivers/boot_constraints/deferrable_dev.c b/drivers/boot_constraints/deferrable_dev.c
> new file mode 100644
> index 000000000000..04056f317aff
> --- /dev/null
> +++ b/drivers/boot_constraints/deferrable_dev.c
> @@ -0,0 +1,235 @@
> +/*
> + * Copyright (C) 2017 Linaro.
> + * Viresh Kumar <viresh.kumar@linaro.org>
> + *
> + * This file is released under the GPLv2.
> + */
> +
> +#define pr_fmt(fmt) "Boot Constraints: " fmt

Hey, you use this one!

But you shouldn't :)

> +/* This only creates platform devices for now */
> +static void add_deferrable_of_single(struct device_node *np,
> +				     struct dev_boot_constraint *constraints,
> +				     int count)
> +{
> +	struct device *dev;
> +	int ret;
> +
> +	if (!of_device_is_available(np))
> +		return;
> +
> +	ret = of_platform_bus_create(np, NULL, NULL, NULL, false);
> +	if (ret)
> +		return;
> +
> +	if (of_device_is_compatible(np, "arm,primecell")) {

Why is "arm,primecell" in the core code here?

> +		struct amba_device *adev = of_find_amba_device_by_node(np);
> +
> +		if (!adev) {
> +			pr_err("Failed to find amba dev: %s\n", np->full_name);

Never use pr_* when you have a valid struct device to use.  Don't you
have one from the struct device_node * passed in here?

> +			return;
> +		}
> +		dev = &adev->dev;
> +	} else {
> +		struct platform_device *pdev = of_find_device_by_node(np);
> +
> +		if (!pdev) {
> +			pr_err("Failed to find pdev: %s\n", np->full_name);

Same here.

thanks,

greg k-h
