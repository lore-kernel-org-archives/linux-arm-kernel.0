From: will.deacon@arm.com (Will Deacon)
Date: Wed, 1 Apr 2015 15:39:04 +0100
Subject: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
 iommu_ops
In-Reply-To: <1427898490.22236.10.camel@infradead.org>
References: <20150327171946.GL1562@arm.com>
 <1427894051.22236.6.camel@infradead.org>
 <20150401133908.GI1552@arm.com>
 <1427896377.22236.8.camel@infradead.org>
 <20150401140512.GJ1552@arm.com>
 <1427898490.22236.10.camel@infradead.org>
Message-ID: <20150401143904.GL1552@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 01, 2015 at 03:28:10PM +0100, David Woodhouse wrote:
> On Wed, 2015-04-01 at 15:05 +0100, Will Deacon wrote:
> > That just leaves the case where the caller tries to map something
> > smaller than a page. Do we want to return the amount mapped in
> > iommu_map?
> 
> Perhaps we should just expose the *minimum* page size? Although for the
> IOMMU API I thought that was always assumed to be the same as PAGE_SIZE,
> and for the DMA API it doesn't matter much because you're *given* the
> IOVA, and you just know that it's mapped *enough*.

We can certainly run with a 64k CPU page size and a 4k IOMMU page size on
arm64 systems. The other way around is much more problematic, so I think
you're right to suggest the minimum page size.

However, once we have that, we run into the same problem that we've got
with the current pgsize_bitmap. Namely, that it needs to be a per-domain
property to avoid it changing dynamically following an initial map request
or a probe of a new IOMMU device.

Will
