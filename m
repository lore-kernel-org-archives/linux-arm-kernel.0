From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 23 Apr 2014 10:53:24 +0200
Subject: [PATCH] arm: dma-mapping: Fix mapping size value
In-Reply-To: <20140422085307.GB5747@arm.com>
References: <1398062847-5770-1-git-send-email-ritesh.harjani@gmail.com>
 <1398062847-5770-2-git-send-email-ritesh.harjani@gmail.com>
 <20140422085307.GB5747@arm.com>
Message-ID: <53577F84.1080101@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-04-22 10:53, Will Deacon wrote:
> On Mon, Apr 21, 2014 at 07:47:27AM +0100, Ritesh Harjani wrote:
> > 68efd7d2fb("arm: dma-mapping: remove order parameter from
> > arm_iommu_create_mapping()") is causing kernel panic
> > because it wrongly sets the value of mapping->size:
> >
> > Unable to handle kernel NULL pointer dereference at virtual
> > address 000000a0
> > pgd = e7a84000
> > [000000a0] *pgd=00000000
> > ...
> > PC is at bitmap_clear+0x48/0xd0
> > LR is at __iommu_remove_mapping+0x130/0x164
> >
> > Fix it by correcting mapping->size value.
> >
> > Signed-off-by: Ritesh Harjani <ritesh.harjani@gmail.com>
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> >  arch/arm/mm/dma-mapping.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index f62aa06..6b00be1 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -1963,8 +1963,8 @@ arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
> >  	mapping->nr_bitmaps = 1;
> >  	mapping->extensions = extensions;
> >  	mapping->base = base;
> > -	mapping->size = bitmap_size << PAGE_SHIFT;
> >  	mapping->bits = BITS_PER_BYTE * bitmap_size;
> > +	mapping->size = mapping->bits << PAGE_SHIFT;
>
> Ok, but given that mapping->size is derived from mapping->bits, do we really
> need both of these fields in struct dma_iommu_mapping?

You are right. I didn't notice this while I was refactoring the code. 
Ritesh,
could you update your patch and simply replace all references of 
mapping->size
with (mapping->bits << PAGE_SHIFT), probably with some temporary variable to
make the code easier to understand? I've didn't apply your patch yet.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
