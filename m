From: will.deacon@arm.com (Will Deacon)
Date: Wed, 1 Apr 2015 18:50:40 +0100
Subject: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
 iommu_ops
In-Reply-To: <1427907064.5567.256.camel@redhat.com>
References: <20150327171946.GL1562@arm.com>
 <1427894051.22236.6.camel@infradead.org>
 <20150401133908.GI1552@arm.com>
 <1427896377.22236.8.camel@infradead.org>
 <1427907064.5567.256.camel@redhat.com>
Message-ID: <20150401175040.GQ1552@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On Wed, Apr 01, 2015 at 05:51:04PM +0100, Alex Williamson wrote:
> On Wed, 2015-04-01 at 15:52 +0200, David Woodhouse wrote:
> > On Wed, 2015-04-01 at 14:39 +0100, Will Deacon wrote:
> > > In fact, that would also allow us to nuke the whole TLB on VFIO unmap of
> > > large ranges. We currently iterate over the range page-by-page, which takes
> > > ages (minutes) in simulation.
> > 
> > Which is one of the big reasons we lie about page sizes in VT-d.
> 
> I think (hope) we've solved a significant portion of the unmap problem
> with the chunking patches that are now in v4.0.  We should now be
> attempting to find the largest contiguous range to unmap instead of
> doing the page-by-page unmap that was mostly hoping the IOMMU actually
> used a super page.  I'm not sure how lying about page sizes had any
> effect on this though.  In order for vfio to get any smarter about it
> we'd need a "commit" callback and to be able to use the freelist to
> track pages to unpin after commit.  Thanks,

Just so I understand this correctly, is that "commit" callback to ensure
that the domain_destroy has actually taken effect on the IOMMU (e.g. by
invalidating the TLBs and waiting for that to take effect)?

The io-pgtable API has a tlb_sync callback, but actually I made
tlb_flush_all (which is called when destroying the page tables) always
synchronous so that you wouldn't need to unmap anything explicitly in
that case.

Unfortunately, 4.0 doesn't seem to have improved wrt VFIO unmap for me.
Is there something extra I need to add to the ARM SMMU driver?

Will
