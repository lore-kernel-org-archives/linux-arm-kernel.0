From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:22:41 +0900
Subject: [PATCH 1/5] ARM: shmobile: No R-Car Gen2 CMA reservation when
 HIGHMEM=n
In-Reply-To: <cover.1424931398.git.horms+renesas@verge.net.au>
References: <cover.1424931398.git.horms+renesas@verge.net.au>
Message-ID: <744cadba1ae6b80b413aea87835855dcccad86fd.1424931398.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Allow R-Car Gen2 platforms to boot with CMA enabled
and HIGHMEM disabled. This patch adds code to check
if the R-Car Gen2 specific memory reservation window
is included in the kernel memory range or not. When
HIGHMEM is disabled the R-Car Gen2 reservation area is
outside the kernel memory range and in such case the
memory reservation is simply skipped over.

Without this patch the kernel boot hangs when CMA is
enabled and HIGHMEM is disabled on the r8a7791 Koelsch
hardware platform:

    WARNING: CPU: 1 PID: 1 at mm/cma.c:113 cma_init_reserved_areas+0x88/0x1d4()
    ...
    WARNING: CPU: 1 PID: 1 at mm/cma.c:121 cma_init_reserved_areas+0xf8/0x1d4()
    ...
    Unable to handle kernel NULL pointer dereference at virtual address 00000160
    pgd = c0003000
    [00000160] *pgd=80000040004003, *pmd=00000000
    Internal error: Oops: 206 [#1] SMP ARM
    Modules linked in:
    CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W
3.19.0-rc4-koelsch-01450-g7f9b6075ce12c3ea-dirty #735
    Hardware name: Generic R8A7791 (Flattened Device Tree)
    task: edc553c0 ti: edc56000 task.ti: edc56000
    PC is at set_pfnblock_flags_mask+0x54/0xa0
    LR is at 0x440

In the current shmobile_defconfig HIGHMEM is enabled
while CMA is disabled, so to trigger this the kernel
configuration for both CMA and HIGHMEM needs to be
adjusted.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index d1fa625..8c7ec93 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -21,6 +21,7 @@
 #include <linux/dma-contiguous.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/memblock.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <asm/mach/arch.h>
@@ -199,7 +200,7 @@ void __init rcar_gen2_reserve(void)
 
 	of_scan_flat_dt(rcar_gen2_scan_mem, &mrc);
 #ifdef CONFIG_DMA_CMA
-	if (mrc.size)
+	if (mrc.size && memblock_is_region_memory(mrc.base, mrc.size))
 		dma_contiguous_reserve_area(mrc.size, mrc.base, 0,
 					    &rcar_gen2_dma_contiguous, true);
 #endif
-- 
2.1.4
