From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 15 Dec 2014 19:33:32 +0200
Subject: [PATCH 0/4] Generic IOMMU page table framework
In-Reply-To: <20141215161052.GM20738@arm.com>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
 <2133922.nksBEtjI2q@avalon> <20141215161052.GM20738@arm.com>
Message-ID: <1703241.O5cxT4doxg@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Monday 15 December 2014 16:10:52 Will Deacon wrote:
> On Sun, Dec 14, 2014 at 11:49:30PM +0000, Laurent Pinchart wrote:
> > On Thursday 27 November 2014 11:51:14 Will Deacon wrote:
> > > This series introduces a generic IOMMU page table allocation framework,
> > > implements support for ARM long-descriptors and then ports the arm-smmu
> > > driver over to the new code.
> 
> [...]
> 
> > > All feedback welcome.
> > 
> > I've successfully tested the patch set with the Renesas IPMMU-VMSA driver
> > with the following extension to the allocator.
> > 
> > Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Wahey, that's really cool, thanks! I have a few minor comments on your patch
> below. If you don't object, then I can make them locally and include your
> patch on top of my v2 series?

Sure. Please see my reply below.

> > From 4bebb7f3a5a48541d4c89ce7c61e6ff66686c3a9 Mon Sep 17 00:00:00 2001
> > From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Date: Sun, 14 Dec 2014 23:34:50 +0200
> > Subject: [PATCH] iommu: io-pgtable-arm: Add Non-Secure quirk
> > 
> > The quirk causes the Non-Secure bit to be set in all page table entries.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  drivers/iommu/io-pgtable-arm.c | 7 +++++++
> >  drivers/iommu/io-pgtable.h     | 3 +++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm.c
> > b/drivers/iommu/io-pgtable-arm.c index 669e322a83a4..b6910e142734 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -80,11 +80,13 @@
> > 
> >  #define ARM_LPAE_PTE_TYPE_TABLE		3
> >  #define ARM_LPAE_PTE_TYPE_PAGE		3
> > +#define ARM_LPAE_PTE_NSTABLE		(((arm_lpae_iopte)1) << 63)
> >  #define ARM_LPAE_PTE_XN			(((arm_lpae_iopte)3) << 53)
> >  #define ARM_LPAE_PTE_AF			(((arm_lpae_iopte)1) << 10)
> >  #define ARM_LPAE_PTE_SH_NS		(((arm_lpae_iopte)0) << 8)
> >  #define ARM_LPAE_PTE_SH_OS		(((arm_lpae_iopte)2) << 8)
> >  #define ARM_LPAE_PTE_SH_IS		(((arm_lpae_iopte)3) << 8)
> > +#define ARM_LPAE_PTE_NS			(((arm_lpae_iopte)1) << 5)
> >  #define ARM_LPAE_PTE_VALID		(((arm_lpae_iopte)1) << 0)
> >  #define ARM_LPAE_PTE_ATTR_LO_MASK	(((arm_lpae_iopte)0x3ff) << 2)
> > 
> > @@ -201,6 +203,9 @@ static int arm_lpae_init_pte(struct
> > arm_lpae_io_pgtable *data,> 
> >  	if (iopte_leaf(*ptep, lvl))
> >  		return -EEXIST;
> > 
> > +	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_NON_SECURE)
> > +		pte |= ARM_LPAE_PTE_NS;
> > +
> >  	if (lvl == ARM_LPAE_MAX_LEVELS - 1)
> >  		pte |= ARM_LPAE_PTE_TYPE_PAGE;
> >  	else
> > @@ -244,6 +249,8 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable
> > *data, unsigned long iova,> 
> >  		data->iop.cfg.tlb->flush_pgtable(cptep, 1UL << data->pg_shift,
> >  						 cookie);
> >  		pte = __pa(cptep) | ARM_LPAE_PTE_TYPE_TABLE;
> > +		if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_NON_SECURE)
> > +			pte |= ARM_LPAE_PTE_NSTABLE;
> >  		*ptep = pte;
> >  		data->iop.cfg.tlb->flush_pgtable(ptep, sizeof(*ptep), cookie);
> >  	} else {
> > diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> > index c1cff3d045db..a41a15d30596 100644
> > --- a/drivers/iommu/io-pgtable.h
> > +++ b/drivers/iommu/io-pgtable.h
> > @@ -24,6 +24,9 @@ struct iommu_gather_ops {
> >  	void (*flush_pgtable)(void *ptr, size_t size, void *cookie);
> >  };
> > 
> > +/* Set the Non-Secure bit in the PTEs */
> > +#define IO_PGTABLE_QUIRK_NON_SECURE	(1 << 0)
> 
> I think I'd stick an _ARM_ somewhere in here, so maybe
> IO_PGTABLE_QUIRK_ARM_NS?

I'm fine with that.

By the way, I'm only familiar with the Renesas implementation of the VMSA 
IOMMU, could you double-check whether setting the NSTABLE and NS bits on all 
levels make sense to you ? It seems to be required by my hardware, even though 
the ARM spec mentions that setting the NSTABLE bit causes non-secure accesses 
to page tables for all lower levels regardless of their NSTABLE/NS bits.

> > +
> > 
> >  struct io_pgtable_cfg {
> 
> and I'd put the #define here, next to the member.

They're right before the structure so I don't think they're too far away, but 
if you prefer that coding style that's fine with me.

> >  	int			quirks; /* IO_PGTABLE_QUIRK_* */
> >  	unsigned long		pgsize_bitmap;

-- 
Regards,

Laurent Pinchart
