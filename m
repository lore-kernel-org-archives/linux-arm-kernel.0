From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 28 Apr 2011 15:56:21 +0200
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <20110428131928.GL17290@n2100.arm.linux.org.uk>
References: <201104212129.17013.arnd@arndb.de>
	<20110428122508.GC13402@8bytes.org>
	<20110428124242.GJ17290@n2100.arm.linux.org.uk>
	<201104281502.16296.arnd@arndb.de>
	<20110428131928.GL17290@n2100.arm.linux.org.uk>
Message-ID: <20110428135621.GE13402@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 02:19:28PM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 28, 2011 at 03:02:16PM +0200, Arnd Bergmann wrote:

> You still need this same cache handling code even when you don't have
> an iommu.

You can reference the same code from different places.

> I don't see the point in having a dma_ops level of indirection
> followed by a separate iommu_ops level of indirection - it seems to me
> to be a waste of code and CPU time, and I don't see why its even
> necessary when there's a much simpler way to deal with it (as I
> illustrated).

There is no waste of code, just the opposite. Most of the dma_ops
implementations that use an IOMMU today have a lot of similiarities in
their code. All this code (on x86, alpha, sparc, ia64, ...) can
be unified to a generic solution that fits all (by abstracting the
differences between iommus into the iommu-api). So the current situation
is a much bigger code waste than having this unified. The ARM platforms
supporting iommu hardware will benefit from this as well. It simply
doesn't make sense to have one dma_ops implementation for each iommu
hardware around.

Regards,

	Joerg
