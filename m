From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jan 2017 12:28:20 +0100
Subject: USB/swiotlb failure on arm64/RPi3
In-Reply-To: <20170124225200.a7qioswpxzh6agvd@raspberrypi-2.musicnaut.iki.fi>
References: <20170124225200.a7qioswpxzh6agvd@raspberrypi-2.musicnaut.iki.fi>
Message-ID: <18757304.xCyYfrPYKi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 25, 2017 12:52:00 AM CET Aaro Koskinen wrote:
> 
> Boot hangs and I/O does not recover.
> 
> I first suspected the dwc2 driver, but the cause turns out to be DMA
> mapping error in usb_hcd_map_urb_for_dma(). This will cause usb_sg_wait()
> to loop forever trying to re-try. On RPi3 dma_mapping_error() is:

Do you know why usb_hcd_map_urb_for_dma() fails here? Are we running
out of swiotlb bounce buffer space, or is there some other problem?

> int
> swiotlb_dma_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
> {
>         return (dma_addr == phys_to_dma(hwdev, io_tlb_overflow_buffer));
> }
> 
> On arm64, swiotlb is not initialized by default, so io_tlb_overflow_buffer
> is 0. But phys_to_dma(hwdev, 0) should be a valid DMA address and not
> be rejected. I tested this by initializing io_tlb_overflow_buffer with
> INVALID_PHYS_ADDR, and then the boot passes and system runs fine.
> 
> Any ideas how this should be fixed properly?

Why is swiotlb not initialized?

	Arnd
