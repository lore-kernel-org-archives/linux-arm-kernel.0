From: will.deacon@arm.com (Will Deacon)
Date: Wed, 1 Apr 2015 14:39:09 +0100
Subject: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
 iommu_ops
In-Reply-To: <1427894051.22236.6.camel@infradead.org>
References: <20150327171946.GL1562@arm.com>
 <1427894051.22236.6.camel@infradead.org>
Message-ID: <20150401133908.GI1552@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 01, 2015 at 02:14:11PM +0100, David Woodhouse wrote:
> On Fri, 2015-03-27 at 17:19 +0000, Will Deacon wrote:
> > 
> > Please can you pull the following IOMMU changes for 4.1? They move the
> > per-iommu_ops pgsize_bitmap field into the iommu_domain, which allows
> > IOMMUs such as the ARM SMMU to support different page sizes within a
> > given SoC.
> 
> Can't we kill it entirely? It's always been horrid. Just let the IOMMU
> driver fill the page tables as it sees according to the virtual/physical
> size and alignment of the range it's asked to map.
> 
> We already lie about the supported page sizes in the Intel VT-d driver
> and claim to support everything, just to make the caller "Just Ask" as
> it should.
> 
> We might have to fix the loop that KVM uses to unmap pages, and
> potentially the bizarre unmap() API which returns the page size that it
> unmapped, but we should do that anyway :)

We'd also need to update any page-table code that relies on being called
one page at a time (i.e. the new io-pgtable stuff we merged for 4.0) so
that we iterate over the requested range. That shouldn't be too difficult
(i.e. just inline the iommu_map logic into each driver), but it would
need some testing.

In fact, that would also allow us to nuke the whole TLB on VFIO unmap of
large ranges. We currently iterate over the range page-by-page, which takes
ages (minutes) in simulation.

Will
