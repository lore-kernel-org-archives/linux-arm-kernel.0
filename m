From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 2 Mar 2016 09:16:10 +0100
Subject: [PATCH v2] iommu/io-pgtable-armv7s: Fix kmem_cache_alloc() flags
In-Reply-To: <526555051e63e72a4b1e68461e51a7b6e33df352.1456859025.git.robin.murphy@arm.com>
References: <526555051e63e72a4b1e68461e51a7b6e33df352.1456859025.git.robin.murphy@arm.com>
Message-ID: <CAMuHMdV2_nz=LHYkrk-dYFfm2x9ny0egw3DauAt7qoyYMcqrKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 1, 2016 at 8:07 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> Whilst the default SLUB allocator happily just merges the original
> allocation flags from kmem_cache_create() with those passed through
> kmem_cache_alloc(), there is a code path in the SLAB allocator which
> will aggressively BUG_ON() if the cache was created with SLAB_CACHE_DMA
> but GFP_DMA is not specified for an allocation:
>
>   kernel BUG at mm/slab.c:2536!
>   Internal error: Oops - BUG: 0 [#1] SMP ARM
>   Modules linked in:[    1.299311] Modules linked in:
>
>   CPU: 1 PID: 1 Comm: swapper/0 Not tainted
>   4.5.0-rc6-koelsch-05892-ge7e45ad53ab6795e #2270
>   Hardware name: Generic R8A7791 (Flattened Device Tree)
>   task: ef422040 ti: ef442000 task.ti: ef442000
>   PC is at cache_alloc_refill+0x2a0/0x530
>   LR is at _raw_spin_unlock+0x8/0xc
> ...
>   [<c02c6928>] (cache_alloc_refill) from [<c02c6630>] (kmem_cache_alloc+0x7c/0xd4)
>   [<c02c6630>] (kmem_cache_alloc) from [<c04444bc>]
>   (__arm_v7s_alloc_table+0x5c/0x278)
>   [<c04444bc>] (__arm_v7s_alloc_table) from [<c0444e1c>]
>   (__arm_v7s_map.constprop.6+0x68/0x25c)
>   [<c0444e1c>] (__arm_v7s_map.constprop.6) from [<c0445044>]
>   (arm_v7s_map+0x34/0xa4)
>   [<c0445044>] (arm_v7s_map) from [<c0c18ee4>] (arm_v7s_do_selftests+0x140/0x418)
>   [<c0c18ee4>] (arm_v7s_do_selftests) from [<c0201760>]
>   (do_one_initcall+0x100/0x1b4)
>   [<c0201760>] (do_one_initcall) from [<c0c00d4c>]
>   (kernel_init_freeable+0x120/0x1e8)
>   [<c0c00d4c>] (kernel_init_freeable) from [<c067a364>] (kernel_init+0x8/0xec)
>   [<c067a364>] (kernel_init) from [<c0206b68>] (ret_from_fork+0x14/0x2c)
>   Code: 1a000003 e7f001f2 e3130001 0a000000 (e7f001f2)
>   ---[ end trace 190f6f6b84352efd ]---
>
> Keep the peace by adding GFP_DMA when allocating a table.

Thanks, this makes the test succeed:

        arm-v7s io-pgtable: self test ok

> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
