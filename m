From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Jul 2011 14:54:28 +0100
Subject: at91sam9g45: Issues while working with RAM that is separated
	on physical address space
In-Reply-To: <20110726133702.GA14526@taskit.de>
References: <CAA2DH4u1kcky3xzxpepS=gtDK1Xas17zDxcRkDR7qRNLHQyoxw@mail.gmail.com>
	<20110722135505.GB25947@n2100.arm.linux.org.uk>
	<CAA2DH4u9GANxUTnTqRzUR=GihNLS8EEDAKm8u8SFZ_Yq48qXOg@mail.gmail.com>
	<CAA2DH4sviHkHEHZTR+0AHP3pToC7fEgTc+irw0vk_WU5q0XEQQ@mail.gmail.com>
	<20110726133702.GA14526@taskit.de>
Message-ID: <20110726135428.GC1655@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2011 at 03:37:02PM +0200, Christian Glindkamp wrote:
> The only problem that still exits with highmem for me is the following:
> Even on non-highmem/non-sparsemem systems I get the following warning
> when using an mmc as the rootfs:
> 
> ------------[ cut here ]------------
> WARNING: at kernel/irq/handle.c:130 handle_irq_event_percpu+0x70/0x194()
> irq 29 handler atmci_interrupt+0x0/0x64c enabled interrupts
> Backtrace: 
> [<c018ed00>] (dump_backtrace+0x0/0x110) from [<c018f274>] (dump_stack+0x18/0x1c)
>  r6:c01c9254 r5:c04831ac r4:00000082
> [<c018f25c>] (dump_stack+0x0/0x1c) from [<c019c73c>] (warn_slowpath_common+0x54/0x6c)
> [<c019c6e8>] (warn_slowpath_common+0x0/0x6c) from [<c019c7f8>] (warn_slowpath_fmt+0x38/0x40)
>  r8:00000000 r7:c04ba500 r6:00000001 r5:0000001d r4:cf8f7b40
> [<c019c7c0>] (warn_slowpath_fmt+0x0/0x40) from [<c01c9254>] (handle_irq_event_percpu+0x70/0x194)
>  r3:0000001d r2:c04831c0
> [<c01c91e4>] (handle_irq_event_percpu+0x0/0x194) from [<c01c93ac>] (handle_irq_event+0x34/0x44)
> [<c01c9378>] (handle_irq_event+0x0/0x44) from [<c01cb6c0>] (handle_level_irq+0xd4/0xe8)
>  r4:c04ba500
> [<c01cb5ec>] (handle_level_irq+0x0/0xe8) from [<c01c8f5c>] (generic_handle_irq+0x34/0x3c)
>  r4:0000001d
> [<c01c8f28>] (generic_handle_irq+0x0/0x3c) from [<c018b068>] (asm_do_IRQ+0x68/0x98)
>  r4:0000001d
> [<c018b000>] (asm_do_IRQ+0x0/0x98) from [<c018ba54>] (__irq_svc+0x34/0x60)
> Exception stack(0xc04b1f40 to 0xc04b1f88)
> 1f40: 00000000 0005317f 0005217f 60000013 c04b0000 c04b4b80 c04d32b0 c04b2000
> 1f60: 70004000 41069265 70022940 c04b1f94 600000d3 c04b1f88 c018cdb0 c018cdbc
> 1f80: 60000013 ffffffff
>  r5:fefff000 r4:ffffffff
> [<c018cd80>] (default_idle+0x0/0x40) from [<c018cbcc>] (cpu_idle+0x68/0xb0)
> [<c018cb64>] (cpu_idle+0x0/0xb0) from [<c041db78>] (rest_init+0x5c/0x74)
>  r6:c018730c r5:c04d3200 r4:c04b20e4
> [<c041db1c>] (rest_init+0x0/0x74) from [<c0008d08>] (start_kernel+0x358/0x3c8)
> [<c00089b0>] (start_kernel+0x0/0x3c8) from [<70008040>] (0x70008040)
> ---[ end trace ac1fb351351e0957 ]---

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
