From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 6 Nov 2017 18:03:16 +0000
Subject: [PATCH 2/3] dmaengine: qcom_hidma: add support for the new
 revision
In-Reply-To: <1509989180-22617-2-git-send-email-okaya@codeaurora.org>
References: <1509989180-22617-1-git-send-email-okaya@codeaurora.org>
 <1509989180-22617-2-git-send-email-okaya@codeaurora.org>
Message-ID: <428c7106-8ebe-0c12-4576-1cfac422923e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/17 17:26, Sinan Kaya wrote:
> Add support for probing the newer HW.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/dma/qcom/hidma.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
> index e366985..29d6aaa 100644
> --- a/drivers/dma/qcom/hidma.c
> +++ b/drivers/dma/qcom/hidma.c
> @@ -749,9 +749,13 @@ static bool hidma_msi_capable(struct device *dev)
>  			return false;
>  
>  		ret = strcmp(of_compat, "qcom,hidma-1.1");
> +		if (ret)
> +			ret = strcmp(of_compat, "qcom,hidma-1.2");
>  	} else {
>  #ifdef CONFIG_ACPI
>  		ret = strcmp(acpi_device_hid(adev), "QCOM8062");
> +		if (ret)
> +			ret = strcmp(acpi_device_hid(adev), "QCOM8063");

This string-juggling looks to have already hit the point at which it
doesn't scale well - it would be a lot nicer to make use of
of_device_get_match_data() and the ACPI equivalent to abstract the
version-specific data appropriately.

Robin.

>  #endif
>  	}
>  	return ret == 0;
> @@ -954,6 +958,7 @@ static int hidma_remove(struct platform_device *pdev)
>  static const struct acpi_device_id hidma_acpi_ids[] = {
>  	{"QCOM8061"},
>  	{"QCOM8062"},
> +	{"QCOM8063"},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(acpi, hidma_acpi_ids);
> @@ -962,6 +967,7 @@ static int hidma_remove(struct platform_device *pdev)
>  static const struct of_device_id hidma_match[] = {
>  	{.compatible = "qcom,hidma-1.0",},
>  	{.compatible = "qcom,hidma-1.1",},
> +	{.compatible = "qcom,hidma-1.2",},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, hidma_match);
> 
