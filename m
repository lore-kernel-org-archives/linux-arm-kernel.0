From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 17 Jan 2018 16:11:27 +0000
Subject: [PATCH] arm64/kernel: kaslr: drop special Image placement logic
Message-ID: <20180117161127.15771-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the early kernel mapping logic can tolerate placements of
Image that cross swapper table boundaries, we can remove the logic
that adjusts the offset if the dice roll produced an offset that
puts the kernel right on top of one.

Cc: Steve Capper <steve.capper@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/kaslr.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index 47080c49cc7e..e3d5cbe2167b 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -128,21 +128,6 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	/* use the top 16 bits to randomize the linear region */
 	memstart_offset_seed = seed >> 48;
 
-	/*
-	 * The kernel Image should not extend across a 1GB/32MB/512MB alignment
-	 * boundary (for 4KB/16KB/64KB granule kernels, respectively). If this
-	 * happens, round down the KASLR offset by (1 << SWAPPER_TABLE_SHIFT).
-	 *
-	 * NOTE: The references to _text and _end below will already take the
-	 *       modulo offset (the physical displacement modulo 2 MB) into
-	 *       account, given that the physical placement is controlled by
-	 *       the loader, and will not change as a result of the virtual
-	 *       mapping we choose.
-	 */
-	if ((((u64)_text + offset) >> SWAPPER_TABLE_SHIFT) !=
-	    (((u64)_end + offset) >> SWAPPER_TABLE_SHIFT))
-		offset = round_down(offset, 1 << SWAPPER_TABLE_SHIFT);
-
 	if (IS_ENABLED(CONFIG_KASAN))
 		/*
 		 * KASAN does not expect the module region to intersect the
-- 
2.11.0
