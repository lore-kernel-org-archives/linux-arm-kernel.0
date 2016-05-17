From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Tue, 17 May 2016 10:50:02 -0400
Subject: [PATCHv6 2/8] dma-debug: add support for resource mappings
In-Reply-To: <1462812247-3414-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1462812247-3414-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1462812247-3414-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <20160517145002.GD4074@char.us.oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +void debug_dma_map_resource(struct device *dev, phys_addr_t addr, size_t size,
> +			    int direction, dma_addr_t dma_addr)
> +{
> +	struct dma_debug_entry *entry;
> +
> +	if (unlikely(dma_debug_disabled()))
> +		return;
> +
> +	entry = dma_entry_alloc();
> +	if (!entry)
> +		return;
> +
> +	entry->type		= dma_debug_resource;
> +	entry->dev		= dev;
> +	entry->pfn		= __phys_to_pfn(addr);
> +	entry->offset		= addr - PHYS_PFN(entry->pfn);

Is that right? 

__phys_to_pfn(addr) is PHYS_PFN(addr), so what you get here is

addr - PHYS_PFN(PHYS_PFN(addr)) ?


> +	entry->size		= size;
> +	entry->dev_addr		= dma_addr;
> +	entry->direction	= direction;
> +	entry->map_err_type	= MAP_ERR_NOT_CHECKED;
> +
> +	add_dma_entry(entry);
> +}
> +EXPORT_SYMBOL(debug_dma_map_resource);
> +
