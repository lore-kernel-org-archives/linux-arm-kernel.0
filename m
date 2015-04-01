From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 1 Apr 2015 23:24:40 +0200
Subject: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
 iommu_ops
In-Reply-To: <20150401170330.GO1552@arm.com>
References: <20150327171946.GL1562@arm.com> <20150331142440.GD22683@8bytes.org>
 <20150331144956.GA24094@arm.com> <20150401153854.GG4441@8bytes.org>
 <20150401170330.GO1552@arm.com>
Message-ID: <20150401212440.GJ4441@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Wed, Apr 01, 2015 at 06:03:30PM +0100, Will Deacon wrote:
> Agreed. How would you feel about restricting domains to be per-IOMMU
> instance?

If we find a good way to do that it would be fine. We need to expose
information about individual IOMMUs for that. The question is whether we
need to expose them to the IOMMU-API user or just from the drivers to
the IOMMU core code.

I prefer the second option, but if there is a good and clean way for the
first one I am open for discussions.

> VFIO already copes with this, so I think we'd just need something to
> keep legacy KVM device passthrough working on x86.

VFIO uses a lot of implicit and internal knowledge about the backend
IOMMU drivers to decide if a second domain is needed. I think this logic
should either be moved into the iommu core code or made generic enough
that it works not only for different supported page-size, but also for
snooping flags or whatever differences exist between iommus in a system.

> Maybe we could add a new domain type using your new series
> (DOMAIN_X86_KVM_LEGACY or something) and avoid the cross-IOMMU domain
> checks for that.

The legacy device assignment code can also be adapted to whatever
changes we agree upon, no need to support a stable API in the iommu
code.


	Joerg
