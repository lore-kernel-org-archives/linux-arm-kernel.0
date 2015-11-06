From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 6 Nov 2015 14:00:55 +0100
Subject: [PATCH] mm: slab: Only move management objects off-slab for sizes
 larger than KMALLOC_MIN_SIZE
In-Reply-To: <20151105160839.GR7637@e104818-lin.cambridge.arm.com>
References: <20151105043155.GA20374@js1304-P5Q-DELUXE>
 <1446724235-31400-1-git-send-email-catalin.marinas@arm.com>
 <20151105053139.e38214a9.akpm@linux-foundation.org>
 <20151105160839.GR7637@e104818-lin.cambridge.arm.com>
Message-ID: <CAMuHMdWgheBuaS4k2xP1VASOwcRfqNDe-TccSb=8rmV2O=tFvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 5, 2015 at 5:08 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> From fda8f306b6941f4ddbefcbcfaa59fedef4a679a3 Mon Sep 17 00:00:00 2001
> From: Catalin Marinas <catalin.marinas@arm.com>
> Date: Thu, 5 Nov 2015 11:14:48 +0000
> Subject: [PATCH] mm: slab: Only move management objects off-slab for sizes
>  larger than KMALLOC_MIN_SIZE
>
> On systems with a KMALLOC_MIN_SIZE of 128 (arm64, some mips and powerpc
> configurations defining ARCH_DMA_MINALIGN to 128), the first
> kmalloc_caches[] entry to be initialised after slab_early_init = 0 is
> "kmalloc-128" with index 7. Depending on the debug kernel configuration,
> sizeof(struct kmem_cache) can be larger than 128 resulting in an
> INDEX_NODE of 8.
>
> Commit 8fc9cf420b36 ("slab: make more slab management structure off the
> slab") enables off-slab management objects for sizes starting with
> PAGE_SIZE >> 5 (128 bytes for a 4KB page configuration) and the creation
> of the "kmalloc-128" cache would try to place the management objects
> off-slab. However, since KMALLOC_MIN_SIZE is already 128 and
> freelist_size == 32 in __kmem_cache_create(),
> kmalloc_slab(freelist_size) returns NULL (kmalloc_caches[7] not
> populated yet). This triggers the following bug on arm64:
>
> [    0.000000] kernel BUG at /work/Linux/linux-2.6-aarch64/mm/slab.c:2283!
> [    0.000000] Internal error: Oops - BUG: 0 [#1] SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.3.0-rc4+ #540
> [    0.000000] Hardware name: Juno (DT)
> [    0.000000] task: ffffffc0006962b0 ti: ffffffc00068c000 task.ti: ffffffc00068c000
> [    0.000000] PC is at __kmem_cache_create+0x21c/0x280
> [    0.000000] LR is at __kmem_cache_create+0x210/0x280
> [...]
> [    0.000000] Call trace:
> [    0.000000] [<ffffffc000154948>] __kmem_cache_create+0x21c/0x280
> [    0.000000] [<ffffffc000652da4>] create_boot_cache+0x48/0x80
> [    0.000000] [<ffffffc000652e2c>] create_kmalloc_cache+0x50/0x88
> [    0.000000] [<ffffffc000652f14>] create_kmalloc_caches+0x4c/0xf4
> [    0.000000] [<ffffffc000654a9c>] kmem_cache_init+0x100/0x118
> [    0.000000] [<ffffffc0006447d4>] start_kernel+0x214/0x33c
>
> This patch introduces an OFF_SLAB_MIN_SIZE definition to avoid off-slab
> management objects for sizes equal to or smaller than KMALLOC_MIN_SIZE.
>
>
> Fixes: 8fc9cf420b36 ("slab: make more slab management structure off the slab")
> Cc: <stable@vger.kernel.org> # 3.15+
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks a lot!

For the record (the fix is already upstream):

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
