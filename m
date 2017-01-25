From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 25 Jan 2017 09:05:06 +0100
Subject: USB/swiotlb failure on arm64/RPi3
In-Reply-To: <20170124225200.a7qioswpxzh6agvd@raspberrypi-2.musicnaut.iki.fi>
References: <20170124225200.a7qioswpxzh6agvd@raspberrypi-2.musicnaut.iki.fi>
Message-ID: <48ab00f8-2a32-d879-c903-50d15a7176f6@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Add John and linux-usb]

Am 24.01.2017 um 23:52 schrieb Aaro Koskinen:
> Hi,
>
> Booting Debian rootfs from USB hard disk (ext4) using 64-bit 4.9 kernel
> on Raspberry Pi 3 fails early in the boot as follows:
>
> [   15.162466] systemd[1]: Detected architecture arm64.
>
> Welcome to Debian GNU/Linux 9 (stretch)!
>
> [   15.200822] systemd[1]: Set hostname to <raspberrypi-3>.
> [   46.135227] usb 1-1.5: reset high-speed USB device number 4 using dwc2
> [   76.844211] usb 1-1.5: reset high-speed USB device number 4 using dwc2
> [  105.257888] systemd[1]: system-generators terminated by signal ALRM.
> [  108.087234] usb 1-1.5: reset high-speed USB device number 4 using dwc2
> [  138.796224] usb 1-1.5: reset high-speed USB device number 4 using dwc2
> [  170.039222] usb 1-1.5: reset high-speed USB device number 4 using dwc2
> [  201.261222] usb 1-1.5: reset high-speed USB device number 4 using dwc2
> [  201.405906] sd 0:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x05 driverbyte=0x00
> [  201.414234] sd 0:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 02 c7 c5 90 00 00 68 00
> [  201.421951] blk_update_request: I/O error, dev sda, sector 46646672
>
> Boot hangs and I/O does not recover.
>
> I first suspected the dwc2 driver, but the cause turns out to be DMA
> mapping error in usb_hcd_map_urb_for_dma(). This will cause usb_sg_wait()
> to loop forever trying to re-try. On RPi3 dma_mapping_error() is:
>
> int
> swiotlb_dma_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
> {
> 	return (dma_addr == phys_to_dma(hwdev, io_tlb_overflow_buffer));
> }
>
> On arm64, swiotlb is not initialized by default, so io_tlb_overflow_buffer
> is 0. But phys_to_dma(hwdev, 0) should be a valid DMA address and not
> be rejected. I tested this by initializing io_tlb_overflow_buffer with
> INVALID_PHYS_ADDR, and then the boot passes and system runs fine.
>
> Any ideas how this should be fixed properly?
>
> A.
>
> _______________________________________________
> linux-rpi-kernel mailing list
> linux-rpi-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
