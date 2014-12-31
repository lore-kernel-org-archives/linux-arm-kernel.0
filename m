From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 31 Dec 2014 15:51:48 +0100
Subject: [PATCH v1 1/3] dmaengine: Add support for APM X-Gene SoC DMA
 driver
In-Reply-To: <1420026134-17857-1-git-send-email-rsahu@apm.com>
References: <1420026134-17857-1-git-send-email-rsahu@apm.com>
Message-ID: <1847119.mDQlkgqzsR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 31 December 2014 17:12:14 Rameshwar Prasad Sahu wrote:
> This patch implements the APM X-Gene SoC DMA driver. The APM X-Gene
> SoC DMA engine consists of 4 DMA channels for performing DMA operations.
> These DMA operations include memory copy and scatter gathering offload.

Is the dma engine capable of slave DMA in theory and you just don't use
that, or does it not do that at all?

> +static int xgene_dma_init_mem(struct xgene_dma *pdma)
> +{
> +	int timeout = 1000;
> +
> +	writel(0x0, pdma->csr_dma + DMA_MEM_RAM_SHUTDOWN);
> +
> +	/* Force a barrier */
> +	readl(pdma->csr_dma + DMA_MEM_RAM_SHUTDOWN);
> +
> +	do {
> +		if (readl(pdma->csr_dma + DMA_BLK_MEM_RDY)
> +			== DMA_BLK_MEM_RDY_DEFAULT)
> +			break;
> +		udelay(1);
> +	} while (--timeout);
> +
> +	if (timeout <= 0) {
> +		dev_err(pdma->dev,
> +			"Failed to release memory from shutdown\n");
> +		return -ENODEV;
> +	}
> +	return 0;
> +}

That's a long busy-loop. Can you use a sleeping function instead?

> +	/* Set DMA mask and coherent mask */
> +	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to set DMA mask\n");
> +		goto err_pm_enable;
> +	}

Never use dma_coerce_mask_and_coherent in new drivers. Instead, make
sure that the information in the device tree is correct in the first
place so the driver doesn't need to override it.

	Arnd
