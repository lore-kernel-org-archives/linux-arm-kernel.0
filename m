From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 23 Apr 2014 15:17:43 +0200
Subject: [PATCH] arm: dma-mapping: Fix mapping size value
In-Reply-To: <CAD15agYETzLJZ26wh8c=+PCSoQ9dR9vLgg7VmZTnQquXxoW+2Q@mail.gmail.com>
References: <1398062847-5770-1-git-send-email-ritesh.harjani@gmail.com>
 <20140422085307.GB5747@arm.com> <53577F84.1080101@samsung.com>
 <4662711.Ubz0jaKMvq@avalon>
 <CAD15agYETzLJZ26wh8c=+PCSoQ9dR9vLgg7VmZTnQquXxoW+2Q@mail.gmail.com>
Message-ID: <5357BD77.3060908@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-04-23 12:04, Ritesh Harjani wrote:
> Hi Marek/Will
>
> On Wed, Apr 23, 2014 at 3:00 PM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > Hi Marek,
> >
> > On Wednesday 23 April 2014 10:53:24 Marek Szyprowski wrote:
> >> On 2014-04-22 10:53, Will Deacon wrote:
> >> > On Mon, Apr 21, 2014 at 07:47:27AM +0100, Ritesh Harjani wrote:
> >> > > 68efd7d2fb("arm: dma-mapping: remove order parameter from
> >> > > arm_iommu_create_mapping()") is causing kernel panic
> >> > > because it wrongly sets the value of mapping->size:
> >> > >
> >> > > Unable to handle kernel NULL pointer dereference at virtual
> >> > > address 000000a0
> >> > > pgd = e7a84000
> >> > > [000000a0] *pgd=00000000
> >> > > ...
> >> > > PC is at bitmap_clear+0x48/0xd0
> >> > > LR is at __iommu_remove_mapping+0x130/0x164
> >> > >
> >> > > Fix it by correcting mapping->size value.
> >> > >
> >> > > Signed-off-by: Ritesh Harjani <ritesh.harjani@gmail.com>
> >> > > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >> > > ---
> >> > >
> >> > >  arch/arm/mm/dma-mapping.c | 2 +-
> >> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> > >
> >> > > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> >> > > index f62aa06..6b00be1 100644
> >> > > --- a/arch/arm/mm/dma-mapping.c
> >> > > +++ b/arch/arm/mm/dma-mapping.c
> >> > > @@ -1963,8 +1963,8 @@ arm_iommu_create_mapping(struct bus_type *bus,
> >> > > dma_addr_t base, size_t size)> >
> >> > >   mapping->nr_bitmaps = 1;
> >> > >   mapping->extensions = extensions;
> >> > >   mapping->base = base;
> >> > >
> >> > > - mapping->size = bitmap_size << PAGE_SHIFT;
> >> > >
> >> > >   mapping->bits = BITS_PER_BYTE * bitmap_size;
> >> > >
> >> > > + mapping->size = mapping->bits << PAGE_SHIFT;
> >> >
> >> > Ok, but given that mapping->size is derived from mapping->bits, do we
> >> > really need both of these fields in struct dma_iommu_mapping?
> >>
> >> You are right. I didn't notice this while I was refactoring the code.
> >> Ritesh, could you update your patch and simply replace all references of
> >> mapping->size with (mapping->bits << PAGE_SHIFT), probably with some
> >> temporary variable to make the code easier to understand? I've didn't apply
> >> your patch yet.
> >
> > As this patch fixes a v3.15 regression, shouldn't it be applied as-is and
> > ASAP, with the cleanup that removes mapping->size coming in a later, less
> > urgent patch ?
>
> I agree with Laurent. Anyway this cleanup can be taken care when we will be
> doing refactoring of common code to lib/iommu-helper.c.
>
> Anyways, if you still insist I can prepare and submit the patch. Let me know
> again on this.

Ok, I've merged the patch as is and I will send pull request soon.
Please include the above discussed cleanup while refactoring common code 
to lib.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
