From: will.deacon@arm.com (Will Deacon)
Date: Wed, 22 Jan 2014 16:01:09 +0000
Subject: [PATCH 10/11] arm: dma-mapping: Add additional parameters to
 arm_iommu_create_mapping
In-Reply-To: <1389876263-25759-11-git-send-email-andreas.herrmann@calxeda.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
 <1389876263-25759-11-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <20140122160109.GG14108@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 12:44:22PM +0000, Andreas Herrmann wrote:
> The new parameters are
> 
>   dma_addr_t grow_size
> 
>          Specifies the size by which the mapping will be extended in
>          case that no sufficient space is left in the mapping to
>          handle an iova allocation request. If a grow_size of 0 is
>          specified the mapping is not extended.

How can an IOMMU know what a sensible value is for grow size? I can only
think of two cases:

  (1) Growing is not permitted at all (0 in your current API)
  (2) Growing is permitted up to the maximum input address size of the
      IOMMU.

Maybe the latter should be probable, rather than waiting to get -ERANGE from
iommu_map? Actually, if we assume that the DMA master can't master a wider
address range the its IOMMU, then we could construct the grow_size from the
base and the dma mask already.

Will
