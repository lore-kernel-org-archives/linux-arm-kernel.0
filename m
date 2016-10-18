From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 18 Oct 2016 21:04:01 +0800
Subject: [PATCH V3 05/10] acpi: apei: handle SEA notification type for
 ARMv8
In-Reply-To: <1475875882-2604-6-git-send-email-tbaicar@codeaurora.org>
References: <1475875882-2604-1-git-send-email-tbaicar@codeaurora.org>
 <1475875882-2604-6-git-send-email-tbaicar@codeaurora.org>
Message-ID: <57c81498-78f1-8aac-01b1-b5445415d822@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/10/8 5:31, Tyler Baicar wrote:
> ARM APEI extension proposal added SEA (Synchrounous External
> Abort) notification type for ARMv8.
> Add a new GHES error source handling function for SEA. If an error
> source's notification type is SEA, then this function can be registered
> into the SEA exception handler. That way GHES will parse and report
> SEA exceptions when they occur.
>
> Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> Signed-off-by: Naveen Kaje <nkaje@codeaurora.org>
> ---
>  arch/arm64/Kconfig        |  1 +
>  drivers/acpi/apei/Kconfig | 15 +++++++++
>  drivers/acpi/apei/ghes.c  | 83 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 99 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b380c87..ae34349 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -53,6 +53,7 @@ config ARM64
>  	select HANDLE_DOMAIN_IRQ
>  	select HARDIRQS_SW_RESEND
>  	select HAVE_ACPI_APEI if (ACPI && EFI)
> +	select HAVE_ACPI_APEI_SEA if (ACPI && EFI)
>  	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_ARCH_BITREVERSE
> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
> index b0140c8..fb99c1c 100644
> --- a/drivers/acpi/apei/Kconfig
> +++ b/drivers/acpi/apei/Kconfig
> @@ -4,6 +4,21 @@ config HAVE_ACPI_APEI
>  config HAVE_ACPI_APEI_NMI
>  	bool
>
> +config HAVE_ACPI_APEI_SEA
> +	bool "APEI Synchronous External Abort logging/recovering support"
> +	depends on ARM64
> +	help
> +	  This option should be enabled if the system supports
> +	  firmware first handling of SEA (Synchronous External Abort).
> +	  SEA happens with certain faults of data abort or instruction
> +	  abort synchronous exceptions on ARMv8 systems. If a system
> +	  supports firmware first handling of SEA, the platform analyzes
> +	  and handles hardware error notifications with SEA, and it may then
> +	  form a HW error record for the OS to parse and handle. This
> +	  option allows the OS to look for such HW error record, and
> +	  take appropriate action.

OK, I can see that it's firmware first handling, so it's triggered
by firmware to me, correct me if I'm wrong.

[...]
>  #ifdef CONFIG_HAVE_ACPI_APEI_NMI
>  /*
>   * printk is not safe in NMI context.  So in NMI handler, we allocate
> @@ -1023,6 +1083,14 @@ static int ghes_probe(struct platform_device *ghes_dev)
>  	case ACPI_HEST_NOTIFY_EXTERNAL:
>  	case ACPI_HEST_NOTIFY_SCI:
>  		break;
> +	case ACPI_HEST_NOTIFY_SEA:
> +		if (!IS_ENABLED(CONFIG_HAVE_ACPI_APEI_SEA)) {
> +			pr_warn(GHES_PFX "Generic hardware error source: %d notified via SEA is not supported\n",
> +				generic->header.source_id);
> +			rc = -ENOTSUPP;
> +			goto err;
> +		}
> +		break;
>  	case ACPI_HEST_NOTIFY_NMI:
>  		if (!IS_ENABLED(CONFIG_HAVE_ACPI_APEI_NMI)) {
>  			pr_warn(GHES_PFX "Generic hardware error source: %d notified via NMI interrupt is not supported!\n",
> @@ -1034,6 +1102,13 @@ static int ghes_probe(struct platform_device *ghes_dev)
>  		pr_warning(GHES_PFX "Generic hardware error source: %d notified via local interrupt is not supported!\n",
>  			   generic->header.source_id);
>  		goto err;
> +	case ACPI_HEST_NOTIFY_GPIO:
> +	case ACPI_HEST_NOTIFY_SEI:
> +	case ACPI_HEST_NOTIFY_GSIV:
> +		pr_warn(GHES_PFX "Generic hardware error source: %d notified via notification type %u is not supported\n",
> +			generic->header.source_id, generic->header.source_id);

Hmm, some platform may trigger a interrupt to OS for firmware handling
and it's in the ACPI 6.1 spec, is it a limitation now, or we need to
add code later to support it?

Thanks
Hanjun
