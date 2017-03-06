From: james.morse@arm.com (James Morse)
Date: Mon, 06 Mar 2017 10:00:53 +0000
Subject: [PATCH 2/2] acpi: apei: handle SEI notification type for ARMv8
In-Reply-To: <1488537595-72161-2-git-send-email-xiexiuqi@huawei.com>
References: <1488537595-72161-1-git-send-email-xiexiuqi@huawei.com>
 <1488537595-72161-2-git-send-email-xiexiuqi@huawei.com>
Message-ID: <58BD3355.2010201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xie XiuQi,

On 03/03/17 10:39, Xie XiuQi wrote:
> ARM APEI extension proposal added SEI (asynchronous SError interrupt)
> notification type for ARMv8.
> 
> Add a new GHES error source handling function for SEI. In firmware
> first mode, if an error source's notification type is SEI. Then GHES
> could parse and report the detail error information.

This patch doesn't apply to any upstream tree. Is this based on Tyler's larger
UEFI/ACPI update series? If so, please mention this in your cover letter, (Nit:
please include a cover letter when sending two or more patches!).

What happens if the SError Interrupt arrives while KVM was doing its work? We
set the HCR_EL2.AMO bit when running a guest, so KVM may receive these instead
of the host kernel.


> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
> index 1122d7f..a32f046 100644
> --- a/drivers/acpi/apei/Kconfig
> +++ b/drivers/acpi/apei/Kconfig
> @@ -18,6 +18,20 @@ config HAVE_ACPI_APEI_SEA
>  	  option allows the OS to look for such hardware error record, and
>  	  take appropriate action.
>  
> +config ACPI_APEI_SEI
> +	bool "APEI Asynchronous SError Interrupt logging/recovering support"
> +	depends on ARM64 && ACPI_APEI_GHES
> +	help
> +	  This option should be enabled if the system supports
> +	  firmware first handling of SEI (asynchronous SError interrupt).
> +
> +	  SEI happens with invalid instruction access or asynchronous exceptions
> +	  on ARMv8 systems. If a system supports firmware first handling of SEI,
> +	  the platform analyzes and handles hardware error notifications from
> +	  SEI, and it may then form a HW error record for the OS to parse and
> +	  handle. This option allows the OS to look for such hardware error
> +	  record, and take appropriate action.
> +
>  config ACPI_APEI
>  	bool "ACPI Platform Error Interface (APEI)"
>  	select MISC_FILESYSTEMS
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3e4ea1b..d084a09 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -850,6 +850,50 @@ static inline void ghes_sea_remove(struct ghes *ghes)
>  }
>  #endif /* CONFIG_HAVE_ACPI_APEI_SEA */
>  
> +#ifdef CONFIG_ACPI_APEI_SEI
> +static LIST_HEAD(ghes_sei);
> +
> +void ghes_notify_sei(void)
> +{
> +	struct ghes *ghes;
> +
> +	/*
> +	 * synchronize_rcu() will wait for nmi_exit(), so no need to

Where nmi_exit()?

This nmi enter/exit was to prevent APEI being interrupted by APEI and trying to
take the same set of locks. APEI masks IRQs to prevent this happening normally,
but Synchronous External Abort couldn't be masked.
We don't mask Asynchronous Exceptions in APEI so the same thing can happen here.
Adding nmi_{enter,exit}() round the ghes call in the arch bad_mode() will
prevent this lockup.


Thanks,

James


> +	 * rcu_read_lock().
> +	 */
> +	list_for_each_entry_rcu(ghes, &ghes_sei, list) {
> +		ghes_proc(ghes);
> +	}
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
> +static inline void ghes_sei_add(struct ghes *ghes)
> +{
> +	pr_err(GHES_PFX "ID: %d, trying to add SEI notification which is not supported\n",
> +	       ghes->generic->header.source_id);
> +}
> +
> +static inline void ghes_sei_remove(struct ghes *ghes)
> +{
> +	pr_err(GHES_PFX "ID: %d, trying to remove SEI notification which is not supported\n",
> +	       ghes->generic->header.source_id);
> +}
> +#endif /* CONFIG_HAVE_ACPI_APEI_SEI */
> +
>  #ifdef CONFIG_HAVE_ACPI_APEI_NMI
>  /*
>   * printk is not safe in NMI context.  So in NMI handler, we allocate
