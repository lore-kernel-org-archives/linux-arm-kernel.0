From: cuibixuan@huawei.com (Bixuan Cui)
Date: Tue, 17 Oct 2017 13:54:35 +0800
Subject: =?UTF-8?B?44CQQlVH44CRVGhlIGtlcm5lbCBzdGFydCBmYWlsIHdoZW4gZW5hYmw=?=
 =?UTF-8?B?ZSBDT05GSUdfQVJNNjRfTFNFX0FUT01JQ1MgYW5kIEtDT1ZfSU5TVFJVTUVOVF8=?=
 =?UTF-8?B?QUxM?=
Message-ID: <59E59B1B.9030206@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
I try to start the kernel(v4.14.0-rc4) by qemu while enable CONFIG_ARM64_LSE_ATOMICS and KCOV_INSTRUMENT_ALL(use arch/arm64/configs/defconfig) at the same time. Then
it hang:
qemu-system-aarch64 -kernel Image -m 2048 -smp 8 -initrd qemu-le.rootfs -cpu cortex-a57 -nographic -machine virt,kernel_irqchip=on -append 'console=ttyAMA0 root=/dev/ram rdinit=/sbin/init nohz_full=1 earlycon=pl011,0x9000000' -rtc base=localtime -device virtio-net-device,netdev=net0 -netdev type=tap,id=net0,script=no,downscript=no,ifname=tap2
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.14.0-rc4 #24 SMP PREEMPT Mon Oct 16 11:02:11 CST 2017
[    0.000000] Boot CPU: AArch64 Processor [411fd070]
[    0.000000] Machine model: linux,dummy-virt
[    0.000000] earlycon: pl11 at MMIO 0x0000000009000000 (options '')
[    0.000000] bootconsole [pl11] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] cma: Reserved 64 MiB at 0x00000000bc000000

After I try kernel v4.13 and it's the same result.
I trace the code and find it stop at the end of '__init_single_page(page, pfn, zone, nid)' in memmap_init_zone() of mm/page_alloc.c ?

static void __meminit __init_single_page(struct page *page, unsigned long pfn,
                                unsigned long zone, int nid)
{
        set_page_links(page, zone, nid, pfn);
        init_page_count(page);
        page_mapcount_reset(page);
        page_cpupid_reset_last(page);

        INIT_LIST_HEAD(&page->lru);

#ifdef WANT_PAGE_VIRTUAL
        /* The shift won't overflow because ZONE_NORMAL is below 4G. */
        if (!is_highmem_idx(zone))
                set_page_address(page, __va(pfn << PAGE_SHIFT));
#endif
//      printk("stop here\n");
}

Anyone can give me advice?

Thanks,
Bixuan Cui
