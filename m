From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 25 Jan 2017 17:23:16 +0100
Subject: [PATCH 0/2] Fix incorrect warning from dma-debug
In-Reply-To: <57305A4B.70401@arm.com>
References: <1462705196-10857-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <57305A4B.70401@arm.com>
Message-ID: <CAMuHMdUnznBCt=V5_PgTaXM5JAZjBvZK-44bahUx+7NFg+f0rA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Mon, May 9, 2016 at 11:37 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 08/05/16 11:59, Niklas S?derlund wrote:
>> While using CONFIG_DMA_API_DEBUG i came across this warning which I
>> think is a false positive. As shown dma_sync_single_for_device() are
>> called from the dma_map_single() call path. This triggers the warning
>> since the dma-debug code have not yet been made aware of the mapping.
>
> Almost right ;) The thing being mapped (the SPI device's buffer) and the
> thing being synced (the IOMMU's PTE) are entirely unrelated. Due to the
> current of_iommu_init() setup, the IOMMU is probed long before
> dma_debug_init() gets called, therefore DMA debug is missing entries for
> some of the initial page table mappings and gets confused when we update
> them later.

I think I've been seeing the same as Niklas since quite a while.
Finally I had a deeper look, and it looks like there is a bug somewhere,
causing the wrong IOMMU PTE to be synced.

>> I try to solve this by introducing __dma_sync_single_for_device() which
>> do not call into the dma-debug code. I'm no expert and this might be a
>> bad way of solving the problem but it allowed me to keep working.
>
> The simple fix should be to just call dma_debug_init() from a sufficiently
> earlier initcall level. The best would be to sort out a proper device
> dependency order to avoid the whole early-IOMMU-creation thing entirely.

And so I did. After disabling the call to dma_debug_fs_init(), you can call
dma_debug_init() quite early. But the warning didn't go away:

    ipmmu-vmsa e67b0000.mmu: DMA-API: device driver tries to sync DMA memory
        it has not allocated [device address=0x000000067bab2ff8] [size=8 bytes]
    ------------[ cut here ]------------
    WARNING: CPU: 0 PID: 174 at lib/dma-debug.c:1235 check_sync+0xcc/0x568
    ...
    [<ffffff800823a3a4>] check_sync+0xcc/0x568
    [<ffffff800823a8d0>] debug_dma_sync_single_for_device+0x44/0x4c
    [<ffffff80082b8d34>] __arm_lpae_set_pte.isra.3+0x6c/0x78
    [<ffffff80082b977c>] __arm_lpae_map+0x318/0x384
    [<ffffff80082b9c58>] arm_lpae_map+0xb0/0xc4
    [<ffffff80082bbc58>] ipmmu_map+0x48/0x58
    [<ffffff80082b6754>] iommu_map+0x120/0x1fc
    [<ffffff80082b7bc8>] __iommu_dma_map+0xb8/0xec
    [<ffffff80082b8514>] iommu_dma_map_page+0x50/0x58
    [<ffffff8008092d28>] __iommu_map_page+0x54/0x98

So, who allocated that memory?

During early kernel init (before fs_initcall(dma_debug_init)):

    arm-lpae io-pgtable: arm_lpae_alloc_pgtable:652: cfg->ias = 32
        data->pg_shift = 12 va_bits = 20
    arm-lpae io-pgtable: arm_lpae_alloc_pgtable:657: data->bits_per_level = 9
        data->levels = 3 pgd_bits = 2
    ipmmu-vmsa e67b0000.mmu: __arm_lpae_alloc_pages:224
        dma_map_single(0xffffffc63bab2000, 32) returned 0x000000067bab2000

Hence 0x67bab2000 is the PGD, which has only 4 entries (32 bytes).
Call stack:

    [<ffffff80082b9240>] __arm_lpae_alloc_pages.isra.11+0x144/0x1e8
    [<ffffff80082b93c0>] arm_64_lpae_alloc_pgtable_s1+0xdc/0x118
    [<ffffff80082b9440>] arm_32_lpae_alloc_pgtable_s1+0x44/0x68
    [<ffffff80082b8b1c>] alloc_io_pgtable_ops+0x4c/0x80
    [<ffffff80082bbf28>] ipmmu_attach_device+0xd0/0x3b0

When starting DMA from the device:

    iommu: map: iova 0xfffffff000 pa 0x000000067a555000 size 0x1000 pgsize 4096
    arm-lpae io-pgtable: __arm_lpae_map:318: iova 0xfffffff000
        phys 0x000000067a555000 size 4096 lvl 1 ptep 0xffffffc63bab2000
    arm-lpae io-pgtable: __arm_lpae_map:320: incr. ptep to 0xffffffc63bab2ff8
    ipmmu-vmsa e67b0000.mmu: __arm_lpae_alloc_pages:224
        dma_map_single(0xffffffc63a490000, 4096) returned 0x000000067a490000
    ipmmu-vmsa e67b0000.mmu: DMA-API: device driver tries to sync DMA memory
        it has not allocated [device address=0x000000067bab2ff8] [size=8 bytes]

__arm_lpae_map() added "ARM_LPAE_LVL_IDX(iova, lvl, data)" == 0xff8 to ptep
(the PGD base address), but the PGD has only 32 bytes, leading to the warning.

Does my analysis make sense?
Do you have a clue?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
