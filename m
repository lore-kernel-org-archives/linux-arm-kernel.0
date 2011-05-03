From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 3 May 2011 17:31:24 +0200
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <201105031705.39957.laurent.pinchart@ideasonboard.com>
References: <201104212129.17013.arnd@arndb.de>
	<201104271243.16868.arnd@arndb.de>
	<201105031705.39957.laurent.pinchart@ideasonboard.com>
Message-ID: <201105031731.24626.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 May 2011, Laurent Pinchart wrote:
> I wish it was that simple.
> 
> The OMAP4 ISS (Imaging Subsystem) has no IOMMU, but it can use the OMAP4 DMM 
> (Dynamic Memory Manager) which acts as a memory remapper. Basically (if my 
> understanding is correct), the ISS is configured to read/write from/to 
> physical addresses. If those physical addresses are in the DMM address range, 
> the DMM translates the accesses to physical accesses, acting as an IOMMU.
> 
> The ISS can thus write to physically contiguous memory directly, or to 
> scattered physical pages through the DMM. Whether an IOMMU (or, to be correct 
> in this case, the IOMMU-like DMM) needs to handle the DMA is a per-buffer 
> decision, not a per-device decision.

This doesn't sound too unusual for IOMMU implementations. A lot of time
you can access e.g. low memory using a direct mapping but you need the
IOMMU code for highmem. I've also seen a machine where a linear mapping
exists for all the memory in strict ordering, while you can use relaxed
DMA ordering when you go through the IOMMU address range. If we manage
to come up with a common dma-mapping API implementation for all IOMMUs,
it certainly needs to handle that case as well.

	Arnd
