From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 18 Dec 2015 17:44:49 +0000
Subject: [PATCH v7 4/5] iommu/mediatek: Add mt8173 IOMMU driver
In-Reply-To: <1450426183-1571-5-git-send-email-yong.wu@mediatek.com>
References: <1450426183-1571-1-git-send-email-yong.wu@mediatek.com>
 <1450426183-1571-5-git-send-email-yong.wu@mediatek.com>
Message-ID: <56744611.3070604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/12/15 08:09, Yong Wu wrote:
> This patch adds support for mediatek m4u (MultiMedia Memory Management
> Unit).
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/Kconfig     |  14 +
>   drivers/iommu/Makefile    |   1 +
>   drivers/iommu/mtk_iommu.c | 734 ++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 749 insertions(+)
>   create mode 100644 drivers/iommu/mtk_iommu.c
>

> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> new file mode 100644
> index 0000000..d000d31
> --- /dev/null
> +++ b/drivers/iommu/mtk_iommu.c

[...]

> +#define REG_MMU_CTRL_REG			0x110
> +#define F_MMU_PREFETCH_RT_REPLACE_MOD		BIT(4)
> +#define F_MMU_TF_PROTECT_SEL(prot)		(((prot) & 0x3) << 5)
> +#define F_COHERENCE_EN				BIT(8)

[...]

> +static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
> +{
> +	u32 regval;
> +	int ret;
> +
> +	ret = clk_prepare_enable(data->bclk);
> +	if (ret) {
> +		dev_err(data->dev, "Failed to enable iommu bclk(%d)\n", ret);
> +		return ret;
> +	}
> +
> +	regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
> +		F_MMU_TF_PROTECT_SEL(2) |
> +		F_COHERENCE_EN;

I meant to ask this last time - does setting F_COHERENCE_EN here imply 
that the M4U is capable of cache-coherent page table walks, or something 
else? If it's the former, and assuming the MT8173 is actually wired up 
to support that, then you should add a dma-coherent property to its DT 
node in patch 5 (which will also save you all the cache flushes on page 
table updates).

> +	writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
> +
> +	regval = F_L2_MULIT_HIT_EN |
> +		F_TABLE_WALK_FAULT_INT_EN |
> +		F_PREETCH_FIFO_OVERFLOW_INT_EN |
> +		F_MISS_FIFO_OVERFLOW_INT_EN |
> +		F_PREFETCH_FIFO_ERR_INT_EN |
> +		F_MISS_FIFO_ERR_INT_EN;
> +	writel_relaxed(regval, data->base + REG_MMU_INT_CONTROL0);
> +
> +	regval = F_INT_TRANSLATION_FAULT |
> +		F_INT_MAIN_MULTI_HIT_FAULT |
> +		F_INT_INVALID_PA_FAULT |
> +		F_INT_ENTRY_REPLACEMENT_FAULT |
> +		F_INT_TLB_MISS_FAULT |
> +		F_INT_MISS_TRANSATION_FIFO_FAULT |
> +		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
> +	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
> +
> +	regval = F_MMU_IVRP_PA_SET(data->protect_base);
> +	writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
> +
> +	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
> +	writel_relaxed(0, data->base + REG_MMU_STANDARD_AXI_MODE);
> +
> +	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
> +			     dev_name(data->dev), (void *)data)) {
> +		writel_relaxed(0, data->base + REG_MMU_PT_BASE_ADDR);
> +		clk_disable_unprepare(data->bclk);
> +		dev_err(data->dev, "Failed @ IRQ-%d Request\n", data->irq);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}

Otherwise, I've not had the chance to go through this thoroughly but at 
a glance it seems in pretty good shape now - nothing immediately jumps 
out as looking wrong or worth making a fuss over.

Thanks,
Robin.
