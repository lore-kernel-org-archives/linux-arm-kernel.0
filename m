From: alex.williamson@redhat.com (Alex Williamson)
Date: Wed, 28 Oct 2015 12:15:13 -0600
Subject: [RFC] vfio/type1: handle case where IOMMU does not support
 PAGE_SIZE size
In-Reply-To: <56310D39.6090500@linaro.org>
References: <1446037965-2341-1-git-send-email-eric.auger@linaro.org>
 <1446049648.8018.397.camel@redhat.com> <563101A0.7020404@linaro.org>
 <1446053858.8018.406.camel@redhat.com> <56310A79.4020309@linaro.org>
 <20151028175533.GM18966@arm.com> <56310D39.6090500@linaro.org>
Message-ID: <1446056113.8018.419.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-10-28 at 19:00 +0100, Eric Auger wrote:
> On 10/28/2015 06:55 PM, Will Deacon wrote:
> > On Wed, Oct 28, 2015 at 06:48:41PM +0100, Eric Auger wrote:
> >> On 10/28/2015 06:37 PM, Alex Williamson wrote:
> >>> Ok, so with hopefully correcting my understand of what this does, isn't
> >>> this effectively the same:
> >>>
> >>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> >>> index 57d8c37..7db4f5a 100644
> >>> --- a/drivers/vfio/vfio_iommu_type1.c
> >>> +++ b/drivers/vfio/vfio_iommu_type1.c
> >>> @@ -403,13 +403,19 @@ static void vfio_remove_dma(struct vfio_iommu *iommu, stru
> >>>  static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu)
> >>>  {
> >>>         struct vfio_domain *domain;
> >>> -       unsigned long bitmap = PAGE_MASK;
> >>> +       unsigned long bitmap = ULONG_MAX;
> >>>  
> >>>         mutex_lock(&iommu->lock);
> >>>         list_for_each_entry(domain, &iommu->domain_list, next)
> >>>                 bitmap &= domain->domain->ops->pgsize_bitmap;
> >>>         mutex_unlock(&iommu->lock);
> >>>  
> >>> +       /* Some comment about how the IOMMU API splits requests */
> >>> +       if (bitmap & ~PAGE_MASK) {
> >>> +               bitmap &= PAGE_MASK;
> >>> +               bitmap |= PAGE_SIZE;
> >>> +       }
> >>> +
> >>>         return bitmap;
> >>>  }
> >> Yes, to me it is indeed the same
> >>>  
> >>> This would also expose to the user that we're accepting PAGE_SIZE, which
> >>> we weren't before, so it was not quite right to just let them do it
> >>> anyway.  I don't think we even need to get rid of the WARN_ONs, do we?
> >>> Thanks,
> >>
> >> The end-user might be afraid of those latter. Personally I would get rid
> >> of them but that's definitively up to you.
> > 
> > I think Alex's point is that the WARN_ON's won't trigger with this patch,
> > because he clears those lower bits in the bitmap.
> ah yes sure!

The WARN_ON triggers when the IOMMU mask is greater than PAGE_SIZE,
which means we can't operate on the IOMMU with PAGE_SIZE granularity,
which we do in a couple places.  So I think the WARN_ON is actually
valid for the code and won't trigger for you now that the IOMMU mask is
always at least ~PAGE_MASK if we can use the IOMMU at anything less than
PAGE_SIZE granularity.  Thanks,

Alex
