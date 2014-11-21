From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Nov 2014 10:32:14 +0000
Subject: For the problem when using swiotlb
In-Reply-To: <20141121093509.GA19783@e104818-lin.cambridge.arm.com>
References: <5469E26B.2010905@huawei.com> <1535751.CcvIi3DN4F@wuerfel>
 <546D58B1.60108@huawei.com> <2522857.bNQToYpBNt@wuerfel>
 <20141121093509.GA19783@e104818-lin.cambridge.arm.com>
Message-ID: <20141121103213.GB19783@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 09:35:10AM +0000, Catalin Marinas wrote:
> @@ -88,11 +89,24 @@ static inline int dma_set_mask(struct device *dev, u64 mask)
>  {
>  	if (!dev->dma_mask || !dma_supported(dev, mask))
>  		return -EIO;
> +	/* if asking for bigger dma mask, limit it to the bus dma ranges */
> +	if (mask > *dev->dma_mask)
> +		mask &= of_dma_get_range_mask(dev);
>  	*dev->dma_mask = mask;
>  
>  	return 0;
>  }

I wonder whether mask &= of_dma_get_range_mask(dev) limiting should
actually be done before actually checking dma_supported(). That's
because a device may try to set a 64-bit mask but being connected to a
more limiting bus, we should check the dma_supported() on the resulting
mask.

-- 
Catalin
