From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 8 Aug 2014 15:54:34 +0100
Subject: [PATCH v3 2/3] xen/arm: reimplement xen_dma_unmap_page & friends
In-Reply-To: <CAG4opy9ChMRYFkMz+RHqacGO3=d+mS=6ZS2qMALHpPUDzhSYsQ@mail.gmail.com>
References: <alpine.DEB.2.02.1408011552460.2293@kaball.uk.xensource.com>
 <1406904984-16068-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.DEB.2.02.1408081530580.2293@kaball.uk.xensource.com>
 <20140808143851.GF29341@zion.uk.xensource.com>
 <CAG4opy9ChMRYFkMz+RHqacGO3=d+mS=6ZS2qMALHpPUDzhSYsQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1408081554110.2293@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Aug 2014, Thomas Leonard wrote:
> On 8 August 2014 15:38, Wei Liu <wei.liu2@citrix.com> wrote:
> > On Fri, Aug 08, 2014 at 03:32:41PM +0100, Stefano Stabellini wrote:
> >> On Fri, 1 Aug 2014, Stefano Stabellini wrote:
> >> > +static void __xen_dma_page_dev_to_cpu(struct device *hwdev, dma_addr_t handle,
> >> > +           size_t size, enum dma_data_direction dir)
> >> > +{
> >> > +   /* Cannot use __dma_page_dev_to_cpu because we don't have a
> >> > +    * struct page for handle */
> >> > +
> >> > +   if (dir == DMA_TO_DEVICE)
> >>
> >> This should be:
> >>     if (dir != DMA_TO_DEVICE)
> >>
> >> Thomas, could you please confirm that with this small fix
> >> http://pastebin.com/FPRf7pgL goes away?
> >>
> >
> > Thomas, please try this fix with my ref-counting patch.
> >
> > The old "working" version might actually cover this latent bug due to
> > it's long delay.
> 
> I'm not sure how to apply this. The function
> "__xen_dma_page_dev_to_cpu" doesn't appear in your "for-thomas"
> branch. If you push the change to that branch I can test it.

That's the patch for you:

diff --git a/arch/arm/xen/mm32.c b/arch/arm/xen/mm32.c
index 534f362..3b99860 100644
--- a/arch/arm/xen/mm32.c
+++ b/arch/arm/xen/mm32.c
@@ -131,7 +131,7 @@ static void __xen_dma_page_dev_to_cpu(struct device *hwdev, dma_addr_t handle,
 	/* Cannot use __dma_page_dev_to_cpu because we don't have a
 	 * struct page for handle */
 
-	if (dir == DMA_TO_DEVICE)
+	if (dir != DMA_TO_DEVICE)
 		outer_inv_range(handle, handle + size);
 
 	dma_cache_maint(handle & PAGE_MASK, handle & ~PAGE_MASK, size, dir, dmac_unmap_area);
