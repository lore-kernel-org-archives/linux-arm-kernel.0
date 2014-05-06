From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 May 2014 11:54:16 +0200
Subject: [PATCH v3 4/7] of: configure the platform device dma parameters
In-Reply-To: <1399347878.20388.96.camel@pasglop>
References: <1398353407-2345-1-git-send-email-santosh.shilimkar@ti.com>
 <CAErSpo6gYT34-sOvNgEdV+3wxv=Fdqtx7c1d-4577mFydLtZMg@mail.gmail.com>
 <1399347878.20388.96.camel@pasglop>
Message-ID: <5699845.615YLDid8d@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 May 2014 13:44:38 Benjamin Herrenschmidt wrote:
> On Mon, 2014-05-05 at 16:28 -0600, Bjorn Helgaas wrote:
> > I still wonder whether arm, powerpc, and tile (and I just noticed
> > microblaze also has a similar dma_direct_map_page()) could all be
> > handled by attaching devices to a generic trivial IOMMU driver
> > parameterized with the appropriate constant offset.

It gets complex at that point, but it can be done. We are going to
need support for IOMMU and swiotlb in the same place, as well
as coherent and noncoherent ops, so the code here will be something
like

	/* default is noncoherent, non-offset, no iommu */
	if (offset) {
		if (coherent)
			set_arch_dma_coherent_offset_ops(dev);
		else
			set_arch_dma_offset_ops(dev);
	} else if (coherent)
		set_arch_dma_coherent_ops(dev);

	if (iommu) {
		if (coherent)
			set_arch_dma_coherent_iommu_ops(dev);
		else
			set_arch_dma_iommu_ops(dev);
	}

Doing it in the default ops would reduce the number of cases
from 5 to 3.

It may be easier to replace set_arch_dma_coherent_ops() with
a generic function that handles all cases:

int set_arch_dma_ops(struct device *dev, bool coherent,
		phys_addr_t offset, struct device_node *iommu);

and let the architecture handle the cases it needs.

> On powerpc, the offset is not constant, it can be per-device.

I think that's the case on all of them. The code under review here
is what parses the dma-ranges property in order to put the correct
value into the per-device structure.

	Arnd
