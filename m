From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 May 2018 11:52:52 +0100
Subject: [PATCH v1 1/2] ACPI / APEI: Add SEI notification type support
 for ARMv8
In-Reply-To: <1527770506-8076-2-git-send-email-gengdongjiu@huawei.com>
References: <1527770506-8076-1-git-send-email-gengdongjiu@huawei.com>
 <1527770506-8076-2-git-send-email-gengdongjiu@huawei.com>
Message-ID: <20180531105252.it67drvnsfz62pqa@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2018 at 08:41:45PM +0800, Dongjiu Geng wrote:
> +#ifdef CONFIG_ACPI_APEI_SEI
> +static LIST_HEAD(ghes_sei);
> +
> +/*
> + * Return 0 only if one of the SEI error sources successfully reported an error
> + * record sent from the firmware.
> + */
> +int ghes_notify_sei(void)
> +{
> +	struct ghes *ghes;
> +	int ret = -ENOENT;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(ghes, &ghes_sei, list) {
> +		if (!ghes_proc(ghes))
> +			ret = 0;
> +	}
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +static void ghes_sei_add(struct ghes *ghes)
> +{
> +	mutex_lock(&ghes_list_mutex);
> +	list_add_rcu(&ghes->list, &ghes_sei);
> +	mutex_unlock(&ghes_list_mutex);
> +}
> +
> +static void ghes_sei_remove(struct ghes *ghes)
> +{
> +	mutex_lock(&ghes_list_mutex);
> +	list_del_rcu(&ghes->list);
> +	mutex_unlock(&ghes_list_mutex);
> +	synchronize_rcu();
> +}
> +#else /* CONFIG_ACPI_APEI_SEI */
> +static inline void ghes_sei_add(struct ghes *ghes) { }
> +static inline void ghes_sei_remove(struct ghes *ghes) { }
> +#endif /* CONFIG_ACPI_APEI_SEI */
> +
>  #ifdef CONFIG_HAVE_ACPI_APEI_NMI
>  /*

> index 8feb0c8..9ba59e2 100644
> --- a/include/acpi/ghes.h
> +++ b/include/acpi/ghes.h
> @@ -120,5 +120,6 @@ static inline void *acpi_hest_get_next(struct acpi_hest_generic_data *gdata)
>  	     section = acpi_hest_get_next(section))
>  
>  int ghes_notify_sea(void);
> +int ghes_notify_sei(void);

It would be nice to have a stub definition when !CONFIG_ACPI_APEI_SEI,
e.g.

#ifdef CONFIG_ACPI_APEI_SEI
int ghes_notify_sei(void);
#else
static in int ghes_notify_sei(void) { return -ENOENT; }
#endif

... as callers could simply call this without additional checks.

As a cleanup, similar would be nice for ghes_notify_sea() with
CONFIG_ACPI_APEI_SEA.

Thanks,
Mark.
