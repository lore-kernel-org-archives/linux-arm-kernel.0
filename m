From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 27 Jan 2015 01:21:16 +0100
Subject: [RFC PATCH 3/5] iommu: implement common IOMMU ops for DMA mapping
In-Reply-To: <09e5515a9afcb3235f4c425520cd18a6032d31b4.1421086706.git.robin.murphy@arm.com>
References: <cover.1421086706.git.robin.murphy@arm.com>
 <09e5515a9afcb3235f4c425520cd18a6032d31b4.1421086706.git.robin.murphy@arm.com>
Message-ID: <20150127002116.GI30345@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

thanks for the patch, I think it is good start to move forward. See my
comments below.

On Mon, Jan 12, 2015 at 08:48:55PM +0000, Robin Murphy wrote:
> Taking inspiration from the existing arch/arm code, break out some
> generic functions to interface the DMA-API to the IOMMU-API. This will
> do the bulk of the heavy lifting for IOMMU-backed dma-mapping.
> 
> Whilst the target is arm64, rather than introduce yet another private
> implementation, place this in common code as the first step towards
> consolidating the numerous versions spread around between architecture
> code and IOMMU drivers.

Is there any reason you implemented that only for AArch64? I think it
makes a lot of sense to have a common implementation of that across
architectures (AArch64, ARM and X86).
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  include/linux/dma-iommu.h |  78 ++++++++
>  lib/Kconfig               |   8 +
>  lib/Makefile              |   1 +
>  lib/dma-iommu.c           | 455 ++++++++++++++++++++++++++++++++++++++++++++++

I'd like this to live in drivers/iommu, as most other dma-api
implementations for iommu-drivers also live there.

> +/*
> + * This little guy is filling in until iommu_map_sg lands and we can hook that
> + * up instead (which is going to be rather involved thanks to page alignment)
> + */

iommu_map_sg should be there now. You can convert this function to it.

> +static int __iommu_dma_map_sg_simple(struct device *dev, struct scatterlist *sg,
> +		int nents, enum dma_data_direction dir, struct dma_attrs *attrs,
> +		bool coherent)
> +{
> +	struct scatterlist *s;
> +	int i;
> +
> +	for_each_sg(sg, s, nents, i) {
> +		sg_dma_address(s) = __iommu_dma_map_page(dev, sg_page(s), s->offset,
> +						s->length, dir, coherent);
> +		sg_dma_len(s) = s->length;
> +	}
> +	return nents;
> +}

So long,

        Joerg
