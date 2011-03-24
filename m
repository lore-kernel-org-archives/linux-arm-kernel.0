From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Mar 2011 08:25:21 +0000
Subject: Hit BUG_ON in dma-mapping.c:425 (RFC)
In-Reply-To: <4D8AFE45.8050609@atmel.com>
References: <4D24A108.2080609@atmel.com> <4D8AFE45.8050609@atmel.com>
Message-ID: <20110324082521.GB9844@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2011 at 04:18:13PM +0800, Nicolas Ferre wrote:
> diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
> --- a/drivers/spi/atmel_spi.c
> +++ b/drivers/spi/atmel_spi.c
> @@ -647,6 +647,22 @@ static void atmel_spi_next_message(struct spi_master *master)
>  	atmel_spi_next_xfer(master, msg);
>  }
>  
> +static void *adjust_buffer_location(struct device *dev, void *buf)
> +{
> +	if (likely(buf < high_memory)) {
> +		return buf;
> +	} else {
> +		struct page *pg;
> +
> +		pg = vmalloc_to_page(buf);
> +		if (pg == 0) {
> +			dev_err(dev, "failed to vmalloc_to_page\n");
> +			return NULL;
> +		}
> +		return page_address(pg) + ((size_t)buf & ~PAGE_MASK);
> +	}
> +}
> +

This really doesn't fix the problem.  If the page is read or written via
the vmalloc mapping, you'll have stale data.

DMA to vmalloc areas is dodgy at best.
