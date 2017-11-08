From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 8 Nov 2017 17:51:01 +0000
Subject: [PATCH V2 2/3] dmaengine: qcom_hidma: add support for the new
 revision
In-Reply-To: <1510158582-5343-2-git-send-email-okaya@codeaurora.org>
References: <1510158582-5343-1-git-send-email-okaya@codeaurora.org>
 <1510158582-5343-2-git-send-email-okaya@codeaurora.org>
Message-ID: <e781fe6c-a4ad-4a96-c705-dfcd9a8d10b0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/17 16:29, Sinan Kaya wrote:
> Add support for probing the newer HW and also organize MSI capable hardware
> into an array for maintenance reasons.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>   drivers/dma/qcom/hidma.c | 41 +++++++++++++++++++++++++++++------------
>   1 file changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
> index e366985..4ef7d6f 100644
> --- a/drivers/dma/qcom/hidma.c
> +++ b/drivers/dma/qcom/hidma.c
> @@ -50,6 +50,7 @@
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
>   #include <linux/of_dma.h>
> +#include <linux/of_device.h>
>   #include <linux/property.h>
>   #include <linux/delay.h>
>   #include <linux/acpi.h>
> @@ -104,6 +105,26 @@ static void hidma_free(struct hidma_dev *dmadev)
>   module_param(nr_desc_prm, uint, 0644);
>   MODULE_PARM_DESC(nr_desc_prm, "number of descriptors (default: 0)");
>   
> +#define HIDMA_MAX_DEV_MATCH 10
> +
> +struct hidma_cap {
> +	const struct of_device_id of[HIDMA_MAX_DEV_MATCH];
> +	const struct acpi_device_id acpi[HIDMA_MAX_DEV_MATCH];
> +};
> +
> +static struct hidma_cap hidma_msi_cap = {
> +	.of = {
> +		{.compatible = "qcom,hidma-1.1",},
> +		{.compatible = "qcom,hidma-1.2",},
> +		{},
> +	},
> +
> +	.acpi = {
> +		{"QCOM8062"},
> +		{"QCOM8063"},
> +		{},
> +	}
> +};

Yikes, I dread to imagine where this is going...

Apologies if I wasn't very clear, but what I meant to imply by dropping 
the of_device_get_match_data() hint was to follow one of the common 
patterns where you either just have some version token:

	enum foo_ver {
		FOO_V1,
		...
	}

	struct acpi_device_id foo_acpi_ids[] = {
		{ "_FOO0001", FOO_V1 },
		...
	}

	struct of_device_id foo_of_match[] = {
		{ .compatible = "foo,v1", .data = (void *)FOO_V1 },
		...
	}

	int foo_probe(struct device *dev) {
		...
		foodev->version = (enum foo_ver)
				of_device_get_match_data(&dev->of_node)
		...
	}

	int foo_reset(struct foodev *foodev) {
		if (foodev->version == FOO_V1)
			writel(0, foodev->base + 0x20);
		else
			writel(0, foodev->base + 0x30);
	}

or if it fits the code better, encapsulate the relevant details directly:

	struct foodata {
		.offset = 0x20,
	} foo_v1_data;

	struct acpi_device_id foo_acpi_ids[] = {
		{ "_FOO0001", (unsigned long)&foo_v1_data },
		...
	}

	struct of_device_id foo_of_match[] = {
		{ .compatible = "foo,v1", .data = &foo_v1_data },
		...
	}

	int foo_probe(struct device *dev) {
		...
		foodev->data = of_device_get_match_data(dev->of_node)
		...
	}

	int foo_reset(struct foodev *foodev) {
		writel(0, foodev->base + foodev->data->offset);
	}
			
Creating multiple sets of match tables seems completely backwards, and 
frankly looks worse than the open-coded strcmps IMO.

Robin.

>   
>   /* process completed descriptors */
>   static void hidma_process_completed(struct hidma_chan *mchan)
> @@ -739,22 +760,16 @@ static int hidma_request_msi(struct hidma_dev *dmadev,
>   static bool hidma_msi_capable(struct device *dev)
>   {
>   	struct acpi_device *adev = ACPI_COMPANION(dev);
> -	const char *of_compat;
> -	int ret = -EINVAL;
> -
> -	if (!adev || acpi_disabled) {
> -		ret = device_property_read_string(dev, "compatible",
> -						  &of_compat);
> -		if (ret)
> -			return false;
> +	int ret;
>   
> -		ret = strcmp(of_compat, "qcom,hidma-1.1");
> -	} else {
> +	if (!adev || acpi_disabled)
> +		ret = of_match_device(hidma_msi_cap.of, dev) != NULL;
> +	else {
>   #ifdef CONFIG_ACPI
> -		ret = strcmp(acpi_device_hid(adev), "QCOM8062");
> +		ret = acpi_match_device(hidma_msi_cap.acpi, dev) != NULL;
>   #endif
>   	}
> -	return ret == 0;
> +	return ret;
>   }
>   
>   static int hidma_probe(struct platform_device *pdev)
> @@ -954,6 +969,7 @@ static int hidma_remove(struct platform_device *pdev)
>   static const struct acpi_device_id hidma_acpi_ids[] = {
>   	{"QCOM8061"},
>   	{"QCOM8062"},
> +	{"QCOM8063"},
>   	{},
>   };
>   MODULE_DEVICE_TABLE(acpi, hidma_acpi_ids);
> @@ -962,6 +978,7 @@ static int hidma_remove(struct platform_device *pdev)
>   static const struct of_device_id hidma_match[] = {
>   	{.compatible = "qcom,hidma-1.0",},
>   	{.compatible = "qcom,hidma-1.1",},
> +	{.compatible = "qcom,hidma-1.2",},
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, hidma_match);
> 
