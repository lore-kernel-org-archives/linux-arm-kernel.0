From: alex.williamson@redhat.com (Alex Williamson)
Date: Wed, 01 Apr 2015 10:51:04 -0600
Subject: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
 iommu_ops
In-Reply-To: <1427896377.22236.8.camel@infradead.org>
References: <20150327171946.GL1562@arm.com>
 <1427894051.22236.6.camel@infradead.org> <20150401133908.GI1552@arm.com>
 <1427896377.22236.8.camel@infradead.org>
Message-ID: <1427907064.5567.256.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-04-01 at 15:52 +0200, David Woodhouse wrote:
> On Wed, 2015-04-01 at 14:39 +0100, Will Deacon wrote:
> > We'd also need to update any page-table code that relies on being called
> > one page at a time (i.e. the new io-pgtable stuff we merged for 4.0) so
> > that we iterate over the requested range.
> 
> Ick. I hadn't noticed we'd entrenched that mistake even harder. It
> certainly *wasn't* that hard to fix it...
> 
> >  That shouldn't be too difficult (i.e. just inline the iommu_map logic
> > into each driver), but it would need some testing.
> 
> Good.
> 
> > In fact, that would also allow us to nuke the whole TLB on VFIO unmap of
> > large ranges. We currently iterate over the range page-by-page, which takes
> > ages (minutes) in simulation.
> 
> Which is one of the big reasons we lie about page sizes in VT-d.

I think (hope) we've solved a significant portion of the unmap problem
with the chunking patches that are now in v4.0.  We should now be
attempting to find the largest contiguous range to unmap instead of
doing the page-by-page unmap that was mostly hoping the IOMMU actually
used a super page.  I'm not sure how lying about page sizes had any
effect on this though.  In order for vfio to get any smarter about it
we'd need a "commit" callback and to be able to use the freelist to
track pages to unpin after commit.  Thanks,

Alex
