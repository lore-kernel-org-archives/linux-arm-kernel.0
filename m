From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 18 Nov 2016 20:12:50 +0000
Subject: [PATCH v16 11/15] acpi/arm64: Add GTDT table parse driver
In-Reply-To: <1479304148-2965-12-git-send-email-fu.wei@linaro.org>
References: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
 <1479304148-2965-12-git-send-email-fu.wei@linaro.org>
Message-ID: <20161118201250.GO1197@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 09:49:04PM +0800, fu.wei at linaro.org wrote:

> +#define for_each_platform_timer(_g) for (; _g; _g = next_platform_timer(_g))

This doesn't fit the usual for_each_* pattern, since _g has to be
manually initialised first. Either come up with a way of maknig this fit
the usual pattern, or get rid of this, and use:

	t = however_you_get_the_first_timer();

	if (!t)
		bailt_out_somehow();
	
	do { 
		...
	} while (t = next_platform_timer(t));

> +/*
> + * Release the memory we have allocated in acpi_gtdt_init.
> + * This should be called, when the driver who called "acpi_gtdt_init" previously
> + * doesn't need the GTDT info anymore.
> + */
> +void __init acpi_gtdt_release(void)
> +{
> +	kfree(timer_block);
> +	kfree(watchdog);
> +	timer_block = NULL;
> +	watchdog = NULL;
> +}

Why is this not simply in the error path of acpi_gtdt_init()?

> +
> +/*
> + * Get some basic info from GTDT table, and init the global variables above
> + * for all timers initialization of Generic Timer.
> + * This function does some validation on GTDT table.
> + */
> +int __init acpi_gtdt_init(struct acpi_table_header *table)
> +{

> +	timer_block = kcalloc(timer_count,
> +			      sizeof(struct acpi_gtdt_timer_block *),
> +			      GFP_KERNEL);
> +	if (!timer_block)
> +		return -ENOMEM;
> +
> +	watchdog = kcalloc(timer_count, sizeof(struct acpi_gtdt_watchdog *),
> +			   GFP_KERNEL);
> +	if (!watchdog) {
> +		kfree(timer_block);
> +		timer_block = NULL;
> +		return -ENOMEM;
> +	}

Please have a common error path below, and branch to that when you need
to free these.

> +error:
> +	acpi_gtdt_release();
> +	return -EINVAL;
> +}

[...]

> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 61a3d90..a1611d1 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -577,6 +577,13 @@ enum acpi_reconfig_event  {
>  int acpi_reconfig_notifier_register(struct notifier_block *nb);
>  int acpi_reconfig_notifier_unregister(struct notifier_block *nb);
>  
> +#ifdef CONFIG_ACPI_GTDT
> +int acpi_gtdt_init(struct acpi_table_header *table);
> +int acpi_gtdt_map_ppi(int type);
> +bool acpi_gtdt_c3stop(int type);
> +void acpi_gtdt_release(void);

Why do these need to be here?

What possible value is ther in exporting acpi_gtdt_release() !?

Thanks,
Mark.
