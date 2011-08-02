From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Aug 2011 15:03:44 +0100
Subject: at91sam9g45: MMC: Issues with MMC driver
In-Reply-To: <CAA2DH4v+v2Vvv_2MzD1dGqbc5a4W1h+30FqwwpsqKmYk6nvZxQ@mail.gmail.com>
References: <CAA2DH4v+v2Vvv_2MzD1dGqbc5a4W1h+30FqwwpsqKmYk6nvZxQ@mail.gmail.com>
Message-ID: <20110802140344.GF19079@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2011 at 04:35:58PM +0530, Prasant J wrote:
> Hi,
> 
> I'm using Linux 3.0.0 on a custom board design based on AT91SAM9G45-EKES
> 
> I'm getting this kernel dump while booting:
> 
> 
> Waiting 3sec before mounting root device...
> mmc0: host does not support reading read-only switch. assuming write-enable.
> mmc0: new SD card at address 0007
> mmcblk0: mmc0:0007 SU02G 1.83 GiB
>  mmcblk0: p1 p2
> eth0: link up (100/Full)
> EXT3-fs: barriers not enabled
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs (mmcblk0p2): using internal journal
> EXT3-fs (mmcblk0p2): mounted filesystem with writeback data mode
> VFS: Mounted root (ext3 filesystem) on device 179:2.
> Freeing init memory: 116K
> ------------[ cut here ]------------
> WARNING: at kernel/irq/handle.c:130 handle_irq_event_percpu+0x6c/0x18c()
> 
> Can someone tell me what is possibly wrong in the mmc driver's
> interrupt handler?

This is what I said to someone who asked about this a week ago.  It
desperately needs fixing properly.

Subject: at91sam9g45: Issues while working with RAM that is separated
        on physical address space

On Tue, Jul 26, 2011 at 03:37:02PM +0200, Christian Glindkamp wrote:
> The only problem that still exits with highmem for me is the following:
> Even on non-highmem/non-sparsemem systems I get the following warning
> when using an mmc as the rootfs:
> 
> ------------[ cut here ]------------
> WARNING: at kernel/irq/handle.c:130 handle_irq_event_percpu+0x70/0x194()

That'll be because the driver is still using flush_dcache_page(), whereas
it should be using flush_kernel_dcache_page().  flush_dcache_page()
unfortunately results in IRQs being enabled due to the
flush_dcache_mmap_lock().

> The system is still stable, but if switch to highmem, the kernel crashes
> completely when doing this (using and USB drive as rootfs still works
> flawlessly):

That's because the driver is basically broken:

        void                    *buf = sg_virt(sg);
        unsigned int            offset = host->pio_offset;

                        memcpy(buf + offset, &value, remaining);

Highmem pages have a NULL sg_virt(sg) because they're by definition not
mapped.  Drivers really should not be using sg_virt() directly - who
knows how this got through the review process...

There's a well defined API for walking scatterlists in drivers - see
the sg_miter_* API in linux/scatterlist.h.  This takes care of the
highmem issues automatically, as well as using flush_kernel_dcache_page().

In short: the Atmel MCI driver is buggy and needs fixing.
