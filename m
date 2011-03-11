From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Mar 2011 17:00:17 +0100
Subject: [PATCH 3/7] ARM: Samsung: update/rewrite Samsung SYSMMU (IOMMU)
	driver
In-Reply-To: <000201cbe002$768d9de0$63a8d9a0$%szyprowski@samsung.com>
References: <1299229274-9753-4-git-send-email-m.szyprowski@samsung.com>
	<201103111615.01829.arnd@arndb.de>
	<000201cbe002$768d9de0$63a8d9a0$%szyprowski@samsung.com>
Message-ID: <201103111700.17373.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 March 2011, Marek Szyprowski wrote:
> > > > does not support IOMMUs, but that could be changed by wrapping it
> > > > using the include/asm-generic/dma-mapping-common.h infrastructure.
> > >
> > > ARM dma-mapping framework also requires some additional research for better DMA
> > > support (there are still issues with multiple mappings to be resolved).
> > 
> > You mean mapping the same memory into multiple devices, or a different problem?
> 
> Mapping the same memory area multiple times with different cache settings is not
> legal on ARMv7+ systems. Currently the problems might caused by the low-memory
> kernel linear mapping and second mapping created for example by dma_alloc_coherent()
> function.

Yes, I know this problem, but I don't think the case you describe is a serious
limitation (there are more interesting cases, though): dma_map_single() etc
will create additional *bus* addresses for a physical address, not additional
virtual addresses.

dma_alloc_coherent should allocate memory that is not also mapped cached,
which is what I thought we do correctly.

	Arnd
