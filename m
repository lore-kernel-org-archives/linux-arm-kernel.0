From: niklas.soderlund@ragnatech.se (Niklas =?iso-8859-1?Q?S=F6derlund?=)
Date: Wed, 13 Apr 2016 15:29:17 +0200
Subject: [PATCH v5 3/9] dma-mapping: add dma_{map,unmap}_resource
In-Reply-To: <20160321152601.GA11674@infradead.org>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160311125846.GF1111@bigcity.dyn.berto.se>
 <20160315082254.GE9136@infradead.org> <3286525.zPAGiD4Xk2@avalon>
 <20160321152601.GA11674@infradead.org>
Message-ID: <20160413132916.GC19650@bigcity.dyn.berto.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

On 2016-03-21 08:26:01 -0700, Christoph Hellwig wrote:
> On Thu, Mar 17, 2016 at 01:33:51PM +0200, Laurent Pinchart wrote:
> > The good news is that, given that no code uses this new API at the moment, 
> > there isn't much to audit. The patch series implements the resource mapping 
> > for arch/arm only, and makes use of it in the rcar-dmac driver only. Would you 
> > like anything audited else than the arch/arm dma mapping implementation, the 
> > rcar-dmac driver and the code that then deals with the dma addresses (I'm 
> > thinking about the IOMMU subsystem and the ipmmu-vmsa driver in particular) ?
> 
> Yes, it would be good to do an audit of all the ARM dma_ops as well
> as generic code like drivers/base/dma-*.c, lib/dma-debug.c and
> include/linux/dma-*.h

I have now done an audit to the best of my abilities, thanks to Laurent 
for pointing me in the right direction. And from what I can tell we are 
good.

* drivers/dma/sh/rcar-dmac.c
  Once the phys_addr_t is mapped to a dma_addr_t using 
  dma_map_resource() it is only used to check that the transfere do not 
  cross 4GB boundaries and then only directly written to HW registers.

* drivers/iommu/iommu.c
  - iommu_map()
    Check that it's align to min page size or return -EINVAL then calls
    domain->ops->map()

* drivers/iommu/ipmmu-vmsa.c
  - ipmmu_map()
    No logic only calls domain->ops->map()

* drivers/iommu/io-pgtable-arm.c
  - arm_lpae_map()
    No logic only calls __arm_lpae_map()
  - __arm_lpae_map()
    No logic only calls arm_lpae_init_pte()
  - arm_lpae_init_pte()
    Used to get a pte:
      pte |= pfn_to_iopte(paddr >> data->pg_shift, data);

* drivers/iommu/io-pgtable-arm-v7s.c
  - arm_v7s_map()
    No logic only calls __arm_v7s_map()
  - __arm_v7s_map()
    No logic only calls arm_v7s_init_pte()
  - arm_v7s_init_pte
    Used to get a pte:
      pte |= paddr & ARM_V7S_LVL_MASK(lvl);

* ARM dma-mapping
  - dma_unmap_*
    Only valid unmap is dma_unmap_resource() all others are an invalid 
    use case.
  - dma_sync_single_*
    Invalid use case, memmory that is mapped is device memmory
  - dma_common_mmap() and dma_mmap_attrs()
    Invalid use case
  - dma_common_get_sgtable() and dma_get_sgtable_attrs()
    Invalid use case, only for dma_alloc_* allocated memory,
  - dma_mapping_error()
    OK

-- 
Regards,
Niklas S?derlund
