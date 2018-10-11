From: hch@lst.de (Christoph Hellwig)
Date: Thu, 11 Oct 2018 15:30:09 +0200
Subject: [PATCH 1/5] mm/sparse: add common helper to mark all memblocks
 present
In-Reply-To: <20181005161642.2462-2-logang@deltatee.com>
References: <20181005161642.2462-1-logang@deltatee.com>
 <20181005161642.2462-2-logang@deltatee.com>
Message-ID: <20181011133009.GA7276@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	for_each_memblock(memory, reg) {
> +		int nid = memblock_get_region_node(reg);
> +
> +		memory_present(nid, memblock_region_memory_base_pfn(reg),
> +			       memblock_region_memory_end_pfn(reg));

Any reason you have a local variable for the node id while you happily
get away without one for the others?  Why not simply:

	for_each_memblock(memory, reg) {
		memory_present(memblock_get_region_node(reg)
			       memblock_region_memory_base_pfn(reg),
			       memblock_region_memory_end_pfn(reg));
	}
