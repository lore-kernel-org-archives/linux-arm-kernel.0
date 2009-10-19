From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Oct 2009 16:46:01 +0100
Subject: [PATCH 4/4] RealView: Add sparsemem support for the RealView
	PBX platform
In-Reply-To: <20091015122209.739.42849.stgit@pc1117.cambridge.arm.com>
References: <20091015121927.739.32071.stgit@pc1117.cambridge.arm.com>
	<20091015122209.739.42849.stgit@pc1117.cambridge.arm.com>
Message-ID: <20091019154601.GG13614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2009 at 01:22:09PM +0100, Catalin Marinas wrote:
> +#ifdef CONFIG_ZONE_DMA
> +/*
> + * Adjust the zones if there are restrictions for DMA access.
> + */
> +void __init realview_adjust_zones(int node, unsigned long *size,
> +				  unsigned long *hole)
> +{
> +	unsigned long dma_size = SZ_256M >> PAGE_SHIFT;
> +
> +	if (!machine_is_realview_pbx() || node || (size[0] <= dma_size))
> +		return;
> +
> +	size[ZONE_NORMAL] = size[0] - dma_size;
> +	size[ZONE_DMA] = dma_size;
> +	hole[ZONE_NORMAL] = hole[0];
> +	hole[ZONE_DMA] = 0;
> +}

You also need to set ISA_DMA_THRESHOLD and MAX_DMA_ADDRESS:

#define ISA_DMA_THRESHOLD       (PHYS_OFFSET + SZ_256M - 1)
#define MAX_DMA_ADDRESS         (PAGE_OFFSET + SZ_256M)

so that other bits of code know what to expect from a GFP_DMA-type
allocation.
