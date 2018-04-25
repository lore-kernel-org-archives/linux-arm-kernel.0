From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 25 Apr 2018 08:20:49 -0700
Subject: [PATCH v2 3/5] ARM: dma-mapping: Implement
 arch_iommu_detach_device()
In-Reply-To: <20180425101051.15349-3-thierry.reding@gmail.com>
References: <20180425101051.15349-1-thierry.reding@gmail.com>
 <20180425101051.15349-3-thierry.reding@gmail.com>
Message-ID: <20180425152049.GD16075@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +void arch_iommu_detach_device(struct device *dev)
> +{
> +#ifdef CONFIG_ARM_DMA_USE_IOMMU
> +	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
> +	const struct dma_map_ops *dma_ops;
> +
> +	if (!mapping)
> +		return;
> +
> +	arm_iommu_release_mapping(mapping);
> +	arm_iommu_detach_device(dev);
> +
> +	dma_ops = arm_get_dma_map_ops(dev->archdata.dma_coherent);
> +	set_dma_ops(dev, dma_ops);

Why not simply:

	set_dma_ops(dev, arm_get_dma_map_ops(dev->archdata.dma_coherent));
