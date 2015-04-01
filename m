From: will.deacon@arm.com (Will Deacon)
Date: Wed, 1 Apr 2015 15:05:12 +0100
Subject: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
 iommu_ops
In-Reply-To: <1427896377.22236.8.camel@infradead.org>
References: <20150327171946.GL1562@arm.com>
 <1427894051.22236.6.camel@infradead.org>
 <20150401133908.GI1552@arm.com>
 <1427896377.22236.8.camel@infradead.org>
Message-ID: <20150401140512.GJ1552@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 01, 2015 at 02:52:57PM +0100, David Woodhouse wrote:
> On Wed, 2015-04-01 at 14:39 +0100, Will Deacon wrote:
> > We'd also need to update any page-table code that relies on being called
> > one page at a time (i.e. the new io-pgtable stuff we merged for 4.0) so
> > that we iterate over the requested range.
> 
> Ick. I hadn't noticed we'd entrenched that mistake even harder. It
> certainly *wasn't* that hard to fix it...

Well, at least it's now in one place! (before, the same mistake was in
each driver).

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

Makes sense for now.

That just leaves the case where the caller tries to map something smaller
than a page. Do we want to return the amount mapped in iommu_map?

Will
