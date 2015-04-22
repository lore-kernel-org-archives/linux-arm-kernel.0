From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Wed, 22 Apr 2015 14:19:43 +0200
Subject: I.MX6Q slow pci_dma_sync_single_for_cpu()
Message-ID: <m3a8y0uzhc.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm testing a video frame grabber driver on IMX6 (ARMv7 PL310) and I'm
having a problem with slow pci_dma_sync_single_for_cpu().

For tests I'm using buffers which are 811008 bytes long (704 * 576 * 2):

void *virt = kmalloc(811008, GFP_KERNEL);
phys = pci_map_single(dev->pci_dev, virt, 811008, PCI_DMA_FROMDEVICE);

Now the device (a PCIe bus mastering frame grabber) transfers frame data
and I'm doing (repeatedly):

pci_dma_sync_single_for_cpu(dev->pci_dev, phys, 811008, PCI_DMA_FROMDEVICE);

The problem is this call takes up to about 20 milliseconds.

I imagine the sync operation should only invalidate the caches - the
buffers are one way device->cpu only (read-only from the CPU side), so
there is no need to flush anything out.

It seems pci_dma_sync_single_for_cpu() ends up here:

static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
	size_t size, enum dma_data_direction dir)
{
	phys_addr_t paddr = page_to_phys(page) + off;

	/* FIXME: non-speculating: not required */
	/* in any case, don't bother invalidating if DMA to device */
	if (dir != DMA_TO_DEVICE) {
		outer_inv_range(paddr, paddr + size);

		dma_cache_maint_page(page, off, size, dir, dmac_unmap_area);
	}
	...

the outer_inv_range() usually takes a bit less than half of the time
(up to 6 ms) while dma_cache_maint_page() takes the rest (up to 14 ms).

The real driver uses SG buffers (of the same size), the SG sync
operations take as much time as the "single" one.

Any ideas?
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
