From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Dec 2010 14:22:47 +0100
Subject: dma_cache_sync replacement call
In-Reply-To: <AANLkTi=XVZLcGut44xO8_MM=MH=VbiDtks5MATG5BSyq@mail.gmail.com>
References: <AANLkTi=p3eaVKUNvxLCThhDC534j_SX+TUtxYgGfu40Q@mail.gmail.com>
	<20101215225903.GJ9937@n2100.arm.linux.org.uk>
	<AANLkTi=XVZLcGut44xO8_MM=MH=VbiDtks5MATG5BSyq@mail.gmail.com>
Message-ID: <201012161422.47667.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 December 2010, y bhanu wrote:
> Alternative for dma_cache_sync:
>  dma_sync_single_for_cpu()  and dma_unmap_single()
>  These do the same operation of (i.e.__dma_single_dev_to_cpu ) to
> trasfer the buffer ownership.
> 
> But, I really dont understand what is the differnec between
> dma_sync_single_for_cpu()  and dma_unmap_single()? (Is it is just to
> make the name clear?)
> I think  dma_sync_single_for_cpu() bests suites to situation.

The difference is mainly on platforms with an IOMMU, where you have
to explicitly manage the bus addresses using dma_map_* / dma_unmap_*.

dma_sync_single_for_cpu is for cases where you have a long-lived
(mapping with multiple accesses from both CPU and device, e.g. doing

dma_map_single(); /* gives returns a dma address
		     and allows the device to access it */

while (running) {
	dma_sync_single_for_cpu(); /* lets the CPU access the buffer */

	dma_sync_single_for_device(); /* lets the device access the buffer */
}

dma_unmap_single(); /*  invalidates the dma address and returns it
			to the CPU */

If the device only accesses the buffer once, you don't need to do an
explicit sync at all, just unmap after the access is done.

	Arnd
