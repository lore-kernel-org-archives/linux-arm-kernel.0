From: alex.williamson@redhat.com (Alex Williamson)
Date: Wed, 01 Apr 2015 12:18:27 -0600
Subject: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
 iommu_ops
In-Reply-To: <20150401175040.GQ1552@arm.com>
References: <20150327171946.GL1562@arm.com>
 <1427894051.22236.6.camel@infradead.org> <20150401133908.GI1552@arm.com>
 <1427896377.22236.8.camel@infradead.org>
 <1427907064.5567.256.camel@redhat.com> <20150401175040.GQ1552@arm.com>
Message-ID: <1427912307.5567.270.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-04-01 at 18:50 +0100, Will Deacon wrote:
> Hi Alex,
> 
> On Wed, Apr 01, 2015 at 05:51:04PM +0100, Alex Williamson wrote:
> > On Wed, 2015-04-01 at 15:52 +0200, David Woodhouse wrote:
> > > On Wed, 2015-04-01 at 14:39 +0100, Will Deacon wrote:
> > > > In fact, that would also allow us to nuke the whole TLB on VFIO unmap of
> > > > large ranges. We currently iterate over the range page-by-page, which takes
> > > > ages (minutes) in simulation.
> > > 
> > > Which is one of the big reasons we lie about page sizes in VT-d.
> > 
> > I think (hope) we've solved a significant portion of the unmap problem
> > with the chunking patches that are now in v4.0.  We should now be
> > attempting to find the largest contiguous range to unmap instead of
> > doing the page-by-page unmap that was mostly hoping the IOMMU actually
> > used a super page.  I'm not sure how lying about page sizes had any
> > effect on this though.  In order for vfio to get any smarter about it
> > we'd need a "commit" callback and to be able to use the freelist to
> > track pages to unpin after commit.  Thanks,
> 
> Just so I understand this correctly, is that "commit" callback to ensure
> that the domain_destroy has actually taken effect on the IOMMU (e.g. by
> invalidating the TLBs and waiting for that to take effect)?

Not necessarily domain_destroy, but simply large unmaps that require
multiple calls to iommu_unmap().  Each call requires the IOMMU driver to
flush io-tlb page structures.  If we could save the io-tlb flushes all
to the end, I imagine we'd get a good improvement in efficiency.  We
can't unpin pages until after the flush though, so we'd need something
like the page freelist to bridge the gap.

> The io-pgtable API has a tlb_sync callback, but actually I made
> tlb_flush_all (which is called when destroying the page tables) always
> synchronous so that you wouldn't need to unmap anything explicitly in
> that case.

Unfortunately we need to unmap before we destroy the domain because the
IOMMU is tracking the pages we have pinned.  It's again a chicken and
egg problem, we need the IOMMU to know what to unpin, but we can't unpin
it until the IOMMU mapping is removed because that would give the
userspace device access to an IOVA not backed by pinned memory.

> Unfortunately, 4.0 doesn't seem to have improved wrt VFIO unmap for me.
> Is there something extra I need to add to the ARM SMMU driver?

No, but see the comment above
drivers/vfio/vfio_iommu_type1.c:vfio_test_domain_fgsp()  It's an ugly
heuristic, but the only way I could come up with for improving
performance on VT-d w/o degrading performance on AMD-Vi.  I don't know
what your hardware does, but if it's more like AMD-Vi, you may not see a
difference.  Thanks,

Alex
