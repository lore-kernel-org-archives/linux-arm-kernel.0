From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 Dec 2010 16:32:40 +0000
Subject: [PATCH] ARM: add PrimeCell generic DMA to MMCI/PL180
In-Reply-To: <1286358159-6994-1-git-send-email-linus.walleij@stericsson.com>
References: <1286358159-6994-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20101219163240.GA27929@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 06, 2010 at 11:42:39AM +0200, Linus Walleij wrote:
> This extends the MMCI/PL180 driver with generic DMA engine support
> using the PrimeCell DMA engine interface.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>

The latest revision of this doesn't work with non-DMA setups.

You map the DMA scatterlist in mmci_dma_start_data(), called from
mmci_start_data() if host->dma_enable is true (it isn't.)  So the
scatterlist in PIO mode is not mapped.

However, in the IRQ handler, it calls mmci_dma_data_end() irrespective
of whether DMA is being used.  This unconditionally calls dma_unmap_sg(),
which results in an DMA unmap operation happening without a previous
map of the scatterlist.

mmci-pl18x mb:mmci: no DMA platform data!
mmci-pl18x mb:mmci: mmc0: MMCI/PL180 manf 41 rev 0 cfg 00 at 0x0000000010005000
mmci-pl18x mb:mmci: IRQ 41, 42 (pio)
...
Unable to handle kernel paging request at virtual address bf81d000
pgd = c0004000
[bf81d000] *pgd=00000000
Internal error: Oops: 5 [#1] SMP
last sysfs file:
Modules linked in:
CPU: 0    Not tainted  (2.6.37-rc6+ #410)
PC is at dma_cache_maint_page+0x28/0x11c
LR is at ___dma_page_dev_to_cpu+0x78/0xb8
pc : [<c003dd88>]    lr : [<c003def4>]    psr: 60000193
sp : c03a1e28  ip : c03a1e60  fp : c03a1e5c
r10: c00416a8  r9 : 00000fff  r8 : 00000002
r7 : 00000008  r6 : 00000002  r5 : bf81d000  r4 : 00000000
r3 : 00000002  r2 : 00000008  r1 : 00000000  r0 : bf81d000
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 6000404a  DAC: 00000015
Process swapper (pid: 0, stack limit = 0xc03a02f0)
Stack: (0xc03a1e28 to 0xc03a2000)
1e20:                   c0c245c0 a0000193 c03a1e5c 00000000 00000008 00000002
1e40: bf81d000 c03f79a0 00000001 c03b881c c03a1e84 c03a1e60 c003def4 c003dd6c
1e60: c00416a8 2a846e12 e784fe40 00000001 00000002 00000001 c03a1eac c03a1e88
1e80: c003dfcc c003de88 c03a1eac e7ba0200 00000500 00000000 00000500 e784fe00
1ea0: c03a1ee4 c03a1eb0 c0222f8c c003df8c 00000029 e7ba0288 c03a1edc e7b32440
1ec0: 00000000 00000000 00000029 60020474 410fc091 00000000 c03a1f04 c03a1ee8
1ee0: c0085e64 c0222d1c c03a3580 00000029 c03a35c4 c02d696c c03a1f24 c03a1f08
1f00: c00886dc c0085e44 c0059bc0 00000029 00000000 00000029 c03a1f3c c03a1f28
1f20: c0028090 c00885fc ffffffff f8e00100 c03a1f94 c03a1f40 c0034038 c002800c
1f40: 30479e80 c03a6350 00000000 00000000 c03a0000 c03a9db0 c03bf6f4 c02d696c
1f60: 60020474 410fc091 00000000 c03a1f94 c03a1f98 c03a1f88 c0035858 c003585c
1f80: 60000013 ffffffff c03a1fb4 c03a1f98 c0035edc c0035840 c03a6be4 c002199c
1fa0: c03bf640 c03a9da4 c03a1fc4 c03a1fb8 c02ca24c c0035e68 c03a1ff4 c03a1fc8
1fc0: c0008c7c c02ca1f8 c00087a4 00000000 00000000 c002199c 00000000 10c5387d
1fe0: c03a6290 c0021da0 00000000 c03a1ff8 60008038 c0008a48 00000000 00000000
Backtrace:
[<c003dd60>] (dma_cache_maint_page+0x0/0x11c) from [<c003def4>] (___dma_page_dev_to_cpu+0x78/0xb8)
[<c003de7c>] (___dma_page_dev_to_cpu+0x0/0xb8) from [<c003dfcc>] (dma_unmap_sg+0x4c/0x70)
 r7:00000001 r6:00000002 r5:00000001 r4:e784fe40
[<c003df80>] (dma_unmap_sg+0x0/0x70) from [<c0222f8c>] (mmci_irq+0x27c/0x414)
 r8:e784fe00 r7:00000500 r6:00000000 r5:00000500 r4:e7ba0200
[<c0222d10>] (mmci_irq+0x0/0x414) from [<c0085e64>] (handle_IRQ_event+0x2c/0xc8)[<c0085e38>] (handle_IRQ_event+0x0/0xc8) from [<c00886dc>] (handle_level_irq+0xec/0x180)
 r7:c02d696c r6:c03a35c4 r5:00000029 r4:c03a3580
[<c00885f0>] (handle_level_irq+0x0/0x180) from [<c0028090>] (asm_do_IRQ+0x90/0xcc)
atkbd serio0: keyboard reset failed on mb:kmi0
 r6:00000029 r5:00000000 r4:00000029
[<c0028000>] (asm_do_IRQ+0x0/0xcc) from [<c0034038>] (__irq_svc+0x38/0xc0)
Exception stack(0xc03a1f40 to 0xc03a1f88)
1f40: 30479e80 c03a6350 00000000 00000000 c03a0000 c03a9db0 c03bf6f4 c02d696c
1f60: 60020474 410fc091 00000000 c03a1f94 c03a1f98 c03a1f88 c0035858 c003585c
1f80: 60000013 ffffffff
 r5:f8e00100 r4:ffffffff
[<c0035834>] (default_idle+0x0/0x2c) from [<c0035edc>] (cpu_idle+0x80/0xc4)
[<c0035e5c>] (cpu_idle+0x0/0xc4) from [<c02ca24c>] (rest_init+0x60/0x78)
 r7:c03a9da4 r6:c03bf640 r5:c002199c r4:c03a6be4
[<c02ca1ec>] (rest_init+0x0/0x78) from [<c0008c7c>] (start_kernel+0x240/0x298)
[<c0008a3c>] (start_kernel+0x0/0x298) from [<60008038>] (0x60008038)
 r6:c0021da0 r5:c03a6290 r4:10c5387d
Code: e1a04001 e1a08003 e1a07002 e3009fff (e5953000)
---[ end trace 791035a14e7db7d4 ]---
