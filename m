From: will.deacon@arm.com (Will Deacon)
Date: Mon, 9 May 2016 10:35:41 +0100
Subject: [PATCH 2/2] iommu/io-pgtable-arm: use
 __dma_sync_single_for_device()
In-Reply-To: <1462705196-10857-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1462705196-10857-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1462705196-10857-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <20160509093540.GF19763@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 08, 2016 at 12:59:56PM +0200, Niklas S?derlund wrote:
> The call to dma_sync_single_for_device() can be reached from
> dma_map_single(). If CONFIG_DMA_API_DEBUG is enabled this would result
> in a check that the mapping being synced is valid. Since the call to
> dma_map_single is not yet completed the mapping is not recorded in
> dma-debug and the check fails and a warning is printed. Avoid this
> warning by calling __dma_sync_single_for_device() which don't preform
> this check.

Hmm, I don't understand why this would trigger that warning. The memory
being sync'd here is the page table memory, not the buffer being mapped.
The page table memory is "mapped" using dma_map_single in
__arm_lpae_alloc_pages, so it sounds like the issue something else.

Will
