From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Oct 2017 12:02:10 +0100
Subject: =?utf-8?B?44CQQlVH44CRVGhlIGtlcm5lbCBz?= =?utf-8?Q?tart_fai?=
 =?utf-8?Q?l?= when enable CONFIG_ARM64_LSE_ATOMICS and KCOV_INSTRUMENT_ALL
In-Reply-To: <59E59B1B.9030206@huawei.com>
References: <59E59B1B.9030206@huawei.com>
Message-ID: <20171017110210.fz7srr2p5jiawvkg@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 01:54:35PM +0800, Bixuan Cui wrote:
> Hi,

Hi,

> I try to start the kernel(v4.14.0-rc4) by qemu while enable CONFIG_ARM64_LSE_ATOMICS and KCOV_INSTRUMENT_ALL(use arch/arm64/configs/defconfig) at the same time. Then
> it hang:
> qemu-system-aarch64 -kernel Image -m 2048 -smp 8 -initrd qemu-le.rootfs -cpu cortex-a57 -nographic -machine virt,kernel_irqchip=on -append 'console=ttyAMA0 root=/dev/ram rdinit=/sbin/init nohz_full=1 earlycon=pl011,0x9000000' -rtc base=localtime -device virtio-net-device,netdev=net0 -netdev type=tap,id=net0,script=no,downscript=no,ifname=tap2
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.14.0-rc4 #24 SMP PREEMPT Mon Oct 16 11:02:11 CST 2017
> [    0.000000] Boot CPU: AArch64 Processor [411fd070]
> [    0.000000] Machine model: linux,dummy-virt
> [    0.000000] earlycon: pl11 at MMIO 0x0000000009000000 (options '')
> [    0.000000] bootconsole [pl11] enabled
> [    0.000000] efi: Getting EFI parameters from FDT:
> [    0.000000] efi: UEFI not found.
> [    0.000000] cma: Reserved 64 MiB at 0x00000000bc000000

This is a known issue [1,2] that's being worked on at the moment.

The problem is that the out-of-line LL/SC atomics are built with a
special ABI, but KCOV inserts calls to other code that does not follow
this ABI, resulting in register corruption.

When I saw this happen, this resulted in cmpxchg() spuriously failing
somewhere in the page init code, which looks similar to what you're
seeing.

The patch at [1] is sufficient to work around this for the time being.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-September/533105.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-October/537018.html

> 
> After I try kernel v4.13 and it's the same result.
> I trace the code and find it stop at the end of '__init_single_page(page, pfn, zone, nid)' in memmap_init_zone() of mm/page_alloc.c ?
> 
> static void __meminit __init_single_page(struct page *page, unsigned long pfn,
>                                 unsigned long zone, int nid)
> {
>         set_page_links(page, zone, nid, pfn);
>         init_page_count(page);
>         page_mapcount_reset(page);
>         page_cpupid_reset_last(page);
> 
>         INIT_LIST_HEAD(&page->lru);
> 
> #ifdef WANT_PAGE_VIRTUAL
>         /* The shift won't overflow because ZONE_NORMAL is below 4G. */
>         if (!is_highmem_idx(zone))
>                 set_page_address(page, __va(pfn << PAGE_SHIFT));
> #endif
> //      printk("stop here\n");
> }
> 
> Anyone can give me advice?
> 
> Thanks,
> Bixuan Cui
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
