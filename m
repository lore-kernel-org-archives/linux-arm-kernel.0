From: joerg.roedel@amd.com (Joerg Roedel)
Date: Tue, 18 Sep 2012 14:49:18 +0200
Subject: [RFC 0/5] ARM: dma-mapping: New dma_map_ops to control IOVA more
 precisely
In-Reply-To: <1346223335-31455-1-git-send-email-hdoyu@nvidia.com>
References: <1346223335-31455-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <20120918124918.GK2505@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 09:55:30AM +0300, Hiroshi Doyu wrote:
> The following APIs are needed for us to support the legacy Tegra
> memory manager for devices("NvMap") with *DMA mapping API*.

Maybe I am not understanding the need completly. Can you elaborate on
why this is needed for legacy Tegra?

> New API:
> 
>  ->iova_alloc(): To allocate IOVA area.
>  ->iova_alloc_at(): To allocate IOVA area at specific address.
>  ->iova_free():  To free IOVA area.
> 
>  ->map_page_at(): To map page at specific IOVA.

This sounds like a layering violation. The situation today is as
follows:

	DMA-API   : Handle DMA-addresses including an address allocator
	IOMMU-API : Full control over DMA address space, no address
	            allocator

So what you want to do add to the DMA-API is already part of the
IOMMU-API.

Here is my suggestion what you can do instead of extending the DMA-API.
You can use the IOMMU-API to initialize the device address space with
any mappings at the IOVAs you need the mappings. In the end you allocate
another free range in the device address space and use that to satisfy
DMA-API allocations. Any reason why that could not work?


Regards,

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
