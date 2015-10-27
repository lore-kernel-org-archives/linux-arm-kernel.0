From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 27 Oct 2015 12:08:32 -0700
Subject: [PATCH v3] EDAC: Add ARM64 EDAC
In-Reply-To: <1445966985-5777-1-git-send-email-brijeshkumar.singh@amd.com>
References: <1445966985-5777-1-git-send-email-brijeshkumar.singh@amd.com>
Message-ID: <20151027190832.GN19782@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27, Brijesh Singh wrote:
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index ef25000..84507b5 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -390,4 +390,12 @@ config EDAC_XGENE
>  	  Support for error detection and correction on the
>  	  APM X-Gene family of SOCs.
>  
> +config EDAC_CORTEX_ARM64
> +	tristate "ARM Cortex A57/A53"
> +	depends on EDAC_MM_EDAC && ARM64
> +	default n

n is the default so this can be removed.

> +	help
> +	  Support for error detection and correction on the
> +	  ARM Cortex A57 and A53.
> +
>  endif # EDAC
> diff --git a/drivers/edac/cortex_arm64_edac.c b/drivers/edac/cortex_arm64_edac.c
> new file mode 100644
> index 0000000..7c936b66
> --- /dev/null
> +++ b/drivers/edac/cortex_arm64_edac.c
> +
> +static struct platform_driver cortex_arm64_edac_driver = {
> +	.probe = cortex_arm64_edac_probe,
> +	.remove = cortex_arm64_edac_remove,
> +	.driver = {
> +		.name = DRV_NAME,
> +		.owner = THIS_MODULE,

This line can be removed. THIS_MODULE is assigned by
platform_driver_register().

> +		.of_match_table = cortex_arm64_edac_of_match,
> +	},
> +};
> +
> +static int __init cortex_arm64_edac_init(void)
> +{
> +	return platform_driver_register(&cortex_arm64_edac_driver);
> +}
> +module_init(cortex_arm64_edac_init);
> +
> +static void __exit cortex_arm64_edac_exit(void)
> +{
> +	platform_driver_unregister(&cortex_arm64_edac_driver);
> +}
> +module_exit(cortex_arm64_edac_exit);

This can be module_platform_driver(cortex_arm64_edac_driver) now.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
