From: kiran.padwal@smartplayin.com (Kiran Padwal)
Date: Tue, 30 Sep 2014 11:47:19 +0530
Subject: [RFC 4/7] soc: qcom: Add Shared Memory Manager driver
In-Reply-To: <1412037291-16880-5-git-send-email-bjorn.andersson@sonymobile.com>
References: <1412037291-16880-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1412037291-16880-5-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <542A4AEF.2030402@smartplayin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On Tuesday 30 September 2014 06:04 AM, Bjorn Andersson wrote:
> The Shared Memory Manager driver implements an interface for allocating
> and accessing items in the memory area shared among all of the
> processors in a Qualcomm platform.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---

<snip>

> +
> +static int qcom_smem_probe(struct platform_device *pdev)
> +{
> +	struct qcom_smem *smem;
> +	struct resource *res;
> +	size_t array_size;
> +	int num_regions = 0;
> +	int i;
> +
> +	for (i = 0; i < pdev->num_resources; i++) {
> +		res = &pdev->resource[i];
> +
> +		if (resource_type(res) == IORESOURCE_MEM)
> +			num_regions++;
> +	}
> +
> +	if (num_regions == 0) {
> +		dev_err(&pdev->dev, "no smem regions specified\n");
> +		return -EINVAL;
> +	}
> +
> +	array_size = num_regions * sizeof(struct smem_region);
> +	smem = devm_kzalloc(&pdev->dev, sizeof(*smem) + array_size, GFP_KERNEL);
> +	if (!smem)
> +		return -ENOMEM;
> +
> +	smem->dev = &pdev->dev;
> +	smem->hwlock = of_hwspin_lock_request(pdev->dev.of_node, NULL);

Compilation breaks while I try to compile with this patch.
Do I missing anything? Below is the error I am getting,

drivers/soc/qcom/qcom_smem.c: In function ?qcom_smem_probe?:
drivers/soc/qcom/qcom_smem.c:274:2: error: implicit declaration of function ?of_hwspin_lock_request? [-Werror=implicit-function-declaration]
  smem->hwlock = of_hwspin_lock_request(pdev->dev.of_node, NULL)

Thanks,
--Kiran
