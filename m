From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Dec 2014 16:54:52 +0000
Subject: using DMA-API on ARM
In-Reply-To: <20141208165042.GO16185@e104818-lin.cambridge.arm.com>
References: <5481794E.4050406@broadcom.com> <2863746.4sUSEYqahB@wuerfel>
 <5485D054.7090109@broadcom.com> <2048819.2EPzBi8E3T@wuerfel>
 <20141208165042.GO16185@e104818-lin.cambridge.arm.com>
Message-ID: <20141208165451.GH11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08, 2014 at 04:50:43PM +0000, Catalin Marinas wrote:
> On Mon, Dec 08, 2014 at 04:38:57PM +0000, Arnd Bergmann wrote:
> > On Monday 08 December 2014 17:22:44 Arend van Spriel wrote:
> > > >> The log: first the ring allocation info is printed. Starting at
> > > >> 16.124847, ring 2, 3 and 4 are rings used for device to host. In this
> > > >> log the failure is on a read of ring 3. Ring 3 is 1024 entries of each
> > > >> 16 bytes. The next thing printed is the kernel page tables. Then some
> > > >> OpenWRT info and the logging of part of the connection setup. Then at
> > > >> 1780.130752 the logging of the failure starts. The sequence number is
> > > >> modulo 253 with ring size of 1024 matches an "old" entry (read 40,
> > > >> expected 52). Then the different pointers are printed followed by
> > > >> the kernel page table. The code does then a cache invalidate on the
> > > >> dma_handle and the next read the sequence number is correct.
> > > >
> > > > How do you invalidate the cache? A dma_handle is of type dma_addr_t
> > > > and we don't define an operation for that, nor does it make sense
> > > > on an allocation from dma_alloc_coherent(). What happens if you
> > > > take out the invalidate?
> > > 
> > > dma_sync_single_for_cpu(, DMA_FROM_DEVICE) which ends up invalidating 
> > > the cache (or that is our suspicion).
> > 
> > I'm not sure about that:
> > 
> > static void arm_dma_sync_single_for_cpu(struct device *dev,
> >                 dma_addr_t handle, size_t size, enum dma_data_direction dir)
> > {
> >         unsigned int offset = handle & (PAGE_SIZE - 1);
> >         struct page *page = pfn_to_page(dma_to_pfn(dev, handle-offset));
> >         __dma_page_dev_to_cpu(page, offset, size, dir);
> > }
> > 
> > Assuming a noncoherent linear (no IOMMU, no swiotlb, no dmabounce) mapping,
> > dma_to_pfn will return the correct pfn here, but pfn_to_page will return a
> > page pointer into the kernel linear mapping,
> 
> Or a highmem page, both should be handled by dma_cache_maint_page().

A valid point, but one which is irrelevant to this thread, because we're
talking about a platform with only 128MB, and a PAGE_OFFSET of 2GB (hence
no highmem):

Memory: 125936K/131072K available (2682K kernel code, 103K rwdata,
 744K rodata, 164K init, 188K bss, 5136K reserved)

Can we stay on-point to getting this problem solved, rather than drifting
off topic please?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
