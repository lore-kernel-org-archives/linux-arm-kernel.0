From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Mar 2011 15:07:59 +0100
Subject: [PATCH 3/7] ARM: Samsung: update/rewrite Samsung SYSMMU (IOMMU)
	driver
In-Reply-To: <000001cbdfe8$ce444b20$6acce160$%szyprowski@samsung.com>
References: <1299229274-9753-4-git-send-email-m.szyprowski@samsung.com>
	<201103111250.51252.arnd@arndb.de>
	<000001cbdfe8$ce444b20$6acce160$%szyprowski@samsung.com>
Message-ID: <201103111507.59825.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 March 2011, Marek Szyprowski wrote:
> > The iommu API is not really meant to be KVM specific, it's just that the
> > in-tree users are basically limited to KVM at the moment. Another user that
> > is coming up soon is the vmio device driver that can be used to transparently
> > pass devices to user space. The idea behind the IOMMU API is that you can
> > map arbitrary bus addresses to physical memory addresses, but it does not
> > deal with allocating the bus addresses or providing buffer management such
> > as cache flushes.
> 
> Yea, I've noticed this and this basically what we expect from iommu driver. 
> However the iommu.h API requires a separate call to map each single memory page.
> This is quite ineffective approach and imho the API need to be extended to allow
> mapping of the arbitrary set of pages.

We can always discuss extensions to the existing infrastructure, adding
an interface for mapping an array of page pointers in the iommu API
sounds like a good idea.

I also think that we should not really have separate iommu and dma-mapping
interfaces, but rather have a portable way to define an iommu so that it
can be used through the dma-mapping interfaces. I'm not asking you to
do that as a prerequisite to merging your driver, but it may be good to
keep in mind that the current situation is still lacking and that any
suggestion for improving this as part of your work to support the
samsung IOMMU is welcome.

Note that the ARM implementation of the dma-mapping.h interface currently
does not support IOMMUs, but that could be changed by wrapping it
using the include/asm-generic/dma-mapping-common.h infrastructure.

	Arnd
