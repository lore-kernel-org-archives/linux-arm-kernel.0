From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 30 Jun 2011 10:55:25 +0300
Subject: [PATCH] mtd: OneNAND: samsung: Write DMA support
In-Reply-To: <20110608101804.GA5527@july>
References: <20110608101804.GA5527@july>
Message-ID: <1309420530.23597.153.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-06-08 at 19:18 +0900, Kyungmin Park wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Implement the write DMA feature. It can reduce the CPU usage when write.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> diff --git a/drivers/mtd/onenand/samsung.c b/drivers/mtd/onenand/samsung.c
> index 3306b5b..f24cb6f 100644
> --- a/drivers/mtd/onenand/samsung.c
> +++ b/drivers/mtd/onenand/samsung.c
> @@ -712,6 +712,74 @@ normal:
>  	return 0;
>  }
>  
> +static int s5pc110_write_bufferram(struct mtd_info *mtd, int area,
> +		const unsigned char *buffer, int offset, size_t count)
> +{
> +	struct onenand_chip *this = mtd->priv;
> +	struct device *dev = &onenand->pdev->dev;
> +	void __iomem *p;
> +	void *buf = (void *) buffer;

No, this is bad - if buffer is marked as const then it should be
constant, or remove the const modifier in the function declaration. And
when you remove the const modifier you can kill the cast, because
assigning to a void pointer does not require it. 

> +	dma_addr_t dma_src, dma_dst;
> +	int err, ofs, page_dma = 0;
> +
> +	p = this->base + area;
> +	if (ONENAND_CURRENT_BUFFERRAM(this)) {
> +		if (area == ONENAND_DATARAM)
> +			p += this->writesize;
> +		else
> +			p += mtd->oobsize;
> +	}
> +
> +	if (count != mtd->writesize || offset & 3 || (size_t) buf & 3)
> +		goto normal;
> +
> +	/* Handle vmalloc address */
> +	if (buf >= high_memory) {
> +		struct page *page;

OK, Russell will yell at this, but we do DMA vmalloc'ed addresses for
many years in the OneNAND driver and it works, and there are products
out there with this code (e.g., Nokia N900) and it works. But I'd like
to understand better why exactly this is a no-no, and why this works in
practice - were we lucky and how exactly ....

> +
> +		if (((size_t) buf & PAGE_MASK) !=
> +		    ((size_t) (buf + count - 1) & PAGE_MASK))

Something is fishy with these size_t casts, could you revisit this piece
of code - and turn it to something simpler, if possible?

> +			goto normal;
> +
> +		page = vmalloc_to_page(buf);
> +		if (unlikely(!page))
> +			goto normal;
> +
> +		/* Page offset */
> +		ofs = ((size_t) buf & ~PAGE_MASK);
> +		page_dma = 1;
> +
> +		/* DMA routine */
> +		dma_src = dma_map_page(dev, page, ofs, count, DMA_TO_DEVICE);
> +		dma_dst = onenand->phys_base + (p - this->base);
> +	} else {
> +		/* DMA routine */
> +		dma_src = dma_map_single(dev, buf, count, DMA_TO_DEVICE);
> +		dma_dst = onenand->phys_base + (p - this->base);
> +	}
> +
> +	if (dma_mapping_error(dev, dma_src)) {
> +		dev_err(dev, "Couldn't map a %d byte buffer for DMA\n", count);
> +		goto normal;
> +	}
> +
> +	err = s5pc110_dma_ops((void *) dma_dst, (void *) dma_src,
> +			count, S5PC110_DMA_DIR_WRITE);

Why casting to void? Please, revise all casts you do.

> +
> +	if (page_dma)
> +		dma_unmap_page(dev, dma_src, count, DMA_TO_DEVICE);
> +	else
> +		dma_unmap_single(dev, dma_src, count, DMA_TO_DEVICE);
> +
> +	if (!err)
> +		return 0;
> +
> +normal:
> +	memcpy(p + offset, buffer, count);

p is iomem, and it cannot be involved in memcpy as Russell pointed
recently in another e-mail, see Documentation/bus-virt-phys-mapping.txt

Please, re-send this with the arm mailing list in CC.

-- 
Best Regards,
Artem Bityutskiy
