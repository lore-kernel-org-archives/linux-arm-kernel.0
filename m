From: alex.williamson@redhat.com (Alex Williamson)
Date: Wed, 01 Apr 2015 10:45:39 -0600
Subject: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
 iommu_ops
In-Reply-To: <20150401115340.GG1552@arm.com>
References: <20150327171946.GL1562@arm.com>
 <20150331142440.GD22683@8bytes.org> <20150331144956.GA24094@arm.com>
 <1427817050.5567.148.camel@redhat.com> <20150401115340.GG1552@arm.com>
Message-ID: <1427906739.5567.251.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-04-01 at 12:53 +0100, Will Deacon wrote:
> On Tue, Mar 31, 2015 at 04:50:50PM +0100, Alex Williamson wrote:
> > It makes sense to me that supported page sizes has a similar problem to
> > IOMMU_CACHE; IOMMU mappings can be made that are dependent on the
> > composition of the domain at the time of mapping and there's no
> > requirement that all the IOMMU hardware units support the exact same
> > features.  VFIO already assumes that separate domains don't necessarily
> > use the same ops and we make sure mappings and un-mappings are aligned
> > to the smallest common size.  We'll have some work to do though if there
> > is no common size between the domains and we may need to add a test to
> > our notion of compatible domains if pgsize_bitmap moves from iommu_ops
> > (sorry, I forget whether you already had a patch for that in this pull
> > request).  Thanks,
> 
> The series updates vfio_pgsize_bitmap to use the domains, so dma_do_map
> will fail if there's no common page size amongst the IOMMUs referenced
> by the container. That preserves the existing behaviour, but I'm not
> sure why it's actually required. Couldn't we potentially allow different
> domains to use different page sizes?

We can.  I think the only thing we're trying to do with it now is
confirm that the user mapping meets the minimum size and alignment
requirements of the IOMMU.  We don't use it as a basis for our actual
mappings, it's the IOMMU API's job to do that.  Thanks,

Alex
