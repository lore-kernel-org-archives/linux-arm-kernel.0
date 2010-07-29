From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Jul 2010 13:25:47 +0200
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <20100729100108.GQ26098@amd.com>
References: <20100729090607.GN26098@amd.com>
	<20100729184336N.fujita.tomonori@lab.ntt.co.jp>
	<20100729100108.GQ26098@amd.com>
Message-ID: <201007291325.48129.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 July 2010, Roedel, Joerg wrote:

> > You designed it for what you need at the time. It should have been
> > named appropriately to avoid confusion. Later, when we actually
> > understand what other IOMMUs need, we can evolve the specific API for
> > generic purposes. Then we can rename the API to more generic.
> 
> At the time the iommu-api was written is was generic enough for what we
> had. So it was designed as an generic API. At this point in time nobody
> knew what the future requirements would we. So today it turns out that
> it is not generic enough anymore for latest hardware. The logical
> consequence is to fix this in the iommu-api.

Well, I think the real question is why we have two APIs that both claim
to work with IOMMUs in a generic way and how we could unify the two.

The Intel and AMD IOMMU drivers currently register at both the DMA
API and the IOMMU API. The first one is used by everything except
KVM and the second is only used by KVM.

I really think we should not extend the (KVM) IOMMU API further but
just use the generic DMA mapping api for KVM and extend it as necessary.
It already has the concept of cache coherency and mapping/unmapping
that are in the IOMMU API and could be extended to support domains
as well, through the use of dma_attrs.

	Arnd
