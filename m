From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Jun 2011 15:42:47 +0100
Subject: [PATCH 5/8] ARM: dma-mapping: move all dma bounce code to
	separate dma ops structure
In-Reply-To: <1308556213-24970-6-git-send-email-m.szyprowski@samsung.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-6-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20110620144247.GF26089@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 09:50:10AM +0200, Marek Szyprowski wrote:
> This patch removes dma bounce hooks from the common dma mapping
> implementation on ARM architecture and creates a separate set of
> dma_map_ops for dma bounce devices.

Why all this additional indirection for no gain?

> @@ -278,7 +278,7 @@ static inline dma_addr_t map_single(struct device *dev, void *ptr, size_t size,
>  		 * We don't need to sync the DMA buffer since
>  		 * it was allocated via the coherent allocators.
>  		 */
> -		__dma_single_cpu_to_dev(ptr, size, dir);
> +		dma_ops.sync_single_for_device(dev, dma_addr, size, dir);
>  	}
>  
>  	return dma_addr;
> @@ -317,7 +317,7 @@ static inline void unmap_single(struct device *dev, dma_addr_t dma_addr,
>  		}
>  		free_safe_buffer(dev->archdata.dmabounce, buf);
>  	} else {
> -		__dma_single_dev_to_cpu(dma_to_virt(dev, dma_addr), size, dir);
> +		dma_ops.sync_single_for_cpu(dev, dma_addr, size, dir);
>  	}
>  }
>  
