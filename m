From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 06 May 2015 11:13:25 +0800
Subject: [V2 PATCH 1/5] ACPI / scan: Parse _CCA and setup device coherency
In-Reply-To: <1430838729-21572-2-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1430838729-21572-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1430838729-21572-2-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <554986D5.5010102@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?05?05? 23:12, Suravee Suthikulpanit wrote:
> This patch implements support for ACPI _CCA object, which is introduced in
> ACPIv5.1, can be used for specifying device DMA coherency attribute.
>
> The parsing logic traverses device namespace to parse coherency
> information, and stores it in acpi_device_flags. Then uses it to call
> arch_setup_dma_ops() when creating each device enumerated in DSDT
> during ACPI scan.
>
> This patch also introduces acpi_dma_is_coherent(), which provides
> an interface for device drivers to check the coherency information
> similarly to the of_dma_is_coherent().
>
> Signed-off-by: Mark Salter <msalter@redhat.com>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> ---
> NOTE:
>   * Since there seem to be conflict opinions regarding how
>     architecture should handle _CCA=0. So, I am proposing the
>     CONFIG_ARCH_SUPPORT_CCA_ZERO, which can be specified by
>     for each architecture to define behavior of the ACPI
>     scanning code when _CCA=0. Let me know if this is acceptable.
>
>   drivers/acpi/Kconfig         |  6 +++++
>   drivers/acpi/acpi_platform.c |  4 ++-
>   drivers/acpi/scan.c          | 62 ++++++++++++++++++++++++++++++++++++++++++++
>   include/acpi/acpi_bus.h      | 11 +++++++-
>   include/linux/acpi.h         |  5 ++++
>   5 files changed, 86 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index ab2cbb5..dd386e9 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -54,6 +54,12 @@ config ACPI_GENERIC_GSI
>   config ACPI_SYSTEM_POWER_STATES_SUPPORT
>   	bool
>
> +config ACPI_MUST_HAVE_CCA
> +	bool
> +
> +config ACPI_SUPPORT_CCA_ZERO
> +	bool
> +
>   config ACPI_SLEEP
>   	bool
>   	depends on SUSPEND || HIBERNATION
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index 4bf7559..a6feca4 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -108,9 +108,11 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
>   	if (IS_ERR(pdev))
>   		dev_err(&adev->dev, "platform device creation failed: %ld\n",
>   			PTR_ERR(pdev));
> -	else
> +	else {
> +		acpi_setup_device_dma(adev, &pdev->dev);
>   		dev_dbg(&adev->dev, "created platform device %s\n",
>   			dev_name(&pdev->dev));
> +	}
>
>   	kfree(resources);
>   	return pdev;
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 849b699..ac33b29 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -11,6 +11,7 @@
>   #include <linux/kthread.h>
>   #include <linux/dmi.h>
>   #include <linux/nls.h>
> +#include <linux/dma-mapping.h>
>
>   #include <asm/pgtable.h>
>
> @@ -2137,6 +2138,66 @@ void acpi_free_pnp_ids(struct acpi_device_pnp *pnp)
>   	kfree(pnp->unique_id);
>   }
>
> +void acpi_setup_device_dma(struct acpi_device *adev, struct device *dev)

I aasume adev->dev in struct *adev is the same as struct device *dev
passed here, so

> +{
> +	int coherent = acpi_dma_is_coherent(adev);
> +
> +	/**
> +	 * Currently, we only support DMA for devices that _CCA=1
> +	 * since this seems to be the case on most ACPI platforms.
> +	 *
> +	 * For the case when _CCA=0 (i.e. is_coherent=0 && cca_seen=1),
> +	 * we would rely on arch-specific cache maintenance for
> +	 * non-coherence DMA operations if architecture enables
> +	 * CONFIG_ACPI_SUPPORT_CCA_ZERO.
> +	 *
> +	 * For the case when _CCA is missing but platform requires it
> +	 * (i.e. is_coherent=0 && cca_seen=0), we do not call
> +	 * arch_setup_dma_ops() and fallback to arch-specific default
> +	 * handling.
> +	 */
> +	if (adev->flags.cca_seen) {
> +		if (!coherent && !IS_ENABLED(CONFIG_ACPI_SUPPORT_CCA_ZERO))
> +			return;
> +		arch_setup_dma_ops(dev, 0, 0, NULL, coherent);

how about using &adev->dev here, and just pass struct acpi_device *adev
for this function?

Thanks
Hanjun
