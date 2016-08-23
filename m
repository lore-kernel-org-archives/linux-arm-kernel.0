From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Tue, 23 Aug 2016 18:14:22 +0300
Subject: [PATCH v2 2/4] remoteproc: Introduce Qualcomm ADSP PIL
In-Reply-To: <1471931866-3107-2-git-send-email-bjorn.andersson@linaro.org>
References: <1471931866-3107-1-git-send-email-bjorn.andersson@linaro.org>
 <1471931866-3107-2-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <ae9f06c0-6e5e-8c33-f239-2fd60e2e6682@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On 08/23/2016 08:57 AM, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> 
> The Qualcomm ADSP Peripheral Image Loader is used on a variety of
> different Qualcomm platforms for loading firmware into and controlling
> the Hexagon based ADSP.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Added platform names to compatibility
> - Removed some incorrect quirks that tried to handle older platforms
> 

<cut>

> +
> +static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
> +{
> +	struct device_node *node;
> +	struct resource r;
> +	int ret;
> +
> +	node = of_parse_phandle(adsp->dev->of_node, "memory-region", 0);
> +	if (!node) {
> +		dev_err(adsp->dev, "no memory-region specified\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = of_address_to_resource(node, 0, &r);
> +	if (ret)
> +		return ret;
> +

I think that the parsing of memory-region and subsequent
address_to_resource is not so good. I had the same issue with Venus
remoteproc driver and come to the more standard way by using
of_reserved_mem_device_init() and dma_alloc_coherent.

Could you review "[PATCH 0/4] Venus remoteproc driver" patchset in this
regard?

> +	adsp->mem_phys = adsp->mem_reloc = r.start;
> +	adsp->mem_size = resource_size(&r);
> +	adsp->mem_region = devm_ioremap_wc(adsp->dev, adsp->mem_phys, adsp->mem_size);
> +	if (!adsp->mem_region) {
> +		dev_err(adsp->dev, "unable to map memory region: %pa+%zx\n",
> +			&r.start, adsp->mem_size);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +

-- 
regards,
Stan
