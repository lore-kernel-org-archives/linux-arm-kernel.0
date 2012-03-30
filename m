From: vdumpa@nvidia.com (Krishna Reddy)
Date: Thu, 29 Mar 2012 19:24:21 -0700
Subject: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
In-Reply-To: <01b301cd0d81$f935d750$eba185f0$%szyprowski@samsung.com>
References: <1330527862-16234-1-git-send-email-m.szyprowski@samsung.com>
 <1330527862-16234-10-git-send-email-m.szyprowski@samsung.com>
 <20120329101927.8ab6b1993475b7e16ae2258f@nvidia.com>
 <01b301cd0d81$f935d750$eba185f0$%szyprowski@samsung.com>
Message-ID: <401E54CE964CD94BAE1EB4A729C7087E37978A1E66@HQMAIL04.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
I have found a bug in arm_iommu_map_sg(). 

> +int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> +		     enum dma_data_direction dir, struct dma_attrs *attrs) {
> +	struct scatterlist *s = sg, *dma = sg, *start = sg;
> +	int i, count = 0;
> +	unsigned int offset = s->offset;
> +	unsigned int size = s->offset + s->length;
> +	unsigned int max = dma_get_max_seg_size(dev);
> +
> +	for (i = 1; i < nents; i++) {
> +		s->dma_address = ARM_DMA_ERROR;
> +		s->dma_length = 0;
> +
> +		s = sg_next(s);

With above code, the last sg element's dma_length is not getting set to zero.
This causing additional incorrect  unmapping during arm_iommu_unmap_sg call and 
leading to random crashes.
The order of above three lines should be as follows.
		s = sg_next(s);

		s->dma_address = ARM_DMA_ERROR;
		s->dma_length = 0;


-KR
--nvpublic
