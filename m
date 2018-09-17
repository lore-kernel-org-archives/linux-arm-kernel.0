From: minchan@kernel.org (Minchan Kim)
Date: Mon, 17 Sep 2018 09:44:49 +0900
Subject: [PATCH v1 1/3] arm: mm: reordering memory type table
In-Reply-To: <20180917004451.174527-1-minchan@kernel.org>
References: <20180917004451.174527-1-minchan@kernel.org>
Message-ID: <20180917004451.174527-2-minchan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To use bit 5 in page table as L_PTE_SPECIAL, we need a room for that.
It seems we don't need 4 bits for the memory type with ARMv6+.
If it's true, let's reorder bits to make bit 5 free.

We will use the bit for L_PTE_SPECIAL in next patch.

A note from Catalin
"
> Anyway, on ARMv7 or ARMv6+LPAE, the non-shared device gets mapped to
> shared device in hardware. Looking through the arm32 code, it seems that
> MT_DEVICE_NONSHARED is used by arch/arm/mach-shmobile/setup-r8a7779.c
> and IIUC that's a v7 platform (R-Car H1, Cortex-A9). I think the above
> should be defined to L_PTE_MT_DEV_SHARED, unless I miss any place where
> DEV_NONSHARED is relevant on ARMv6 (adding Simon to confirm on shmbile).
"

Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Steve Capper <steve.capper@linaro.org>
Cc: Simon Horman <horms@verge.net.au>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 arch/arm/include/asm/pgtable-2level.h | 19 +++++++++++++++----
 arch/arm/mm/proc-macros.S             |  4 ++--
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 92fd2c8a9af0..514b13c27b43 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -164,14 +164,25 @@
 #define L_PTE_MT_BUFFERABLE	(_AT(pteval_t, 0x01) << 2)	/* 0001 */
 #define L_PTE_MT_WRITETHROUGH	(_AT(pteval_t, 0x02) << 2)	/* 0010 */
 #define L_PTE_MT_WRITEBACK	(_AT(pteval_t, 0x03) << 2)	/* 0011 */
+#define L_PTE_MT_DEV_SHARED	(_AT(pteval_t, 0x04) << 2)	/* 0100 */
+#define L_PTE_MT_VECTORS	(_AT(pteval_t, 0x05) << 2)	/* 0101 */
 #define L_PTE_MT_MINICACHE	(_AT(pteval_t, 0x06) << 2)	/* 0110 (sa1100, xscale) */
 #define L_PTE_MT_WRITEALLOC	(_AT(pteval_t, 0x07) << 2)	/* 0111 */
-#define L_PTE_MT_DEV_SHARED	(_AT(pteval_t, 0x04) << 2)	/* 0100 */
-#define L_PTE_MT_DEV_NONSHARED	(_AT(pteval_t, 0x0c) << 2)	/* 1100 */
+#if defined(CONFIG_CPU_V7) || defined (CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K)
+/*
+ * On ARMv7 or ARMv6+LPAE, the non-shared device gets mapped to
+ * shared device in hardware.
+ */
+#define L_PTE_MT_DEV_NONSHARED	L_PTE_MT_DEV_SHARED
+#define L_PTE_MT_DEV_WC		L_PTE_MT_BUFFERABLE
+#define L_PTE_MT_DEV_CACHED	L_PTE_MT_WRITEBACK
+#define L_PTE_MT_MASK		(_AT(pteval_t, 0x07) << 2)
+#else
 #define L_PTE_MT_DEV_WC		(_AT(pteval_t, 0x09) << 2)	/* 1001 */
 #define L_PTE_MT_DEV_CACHED	(_AT(pteval_t, 0x0b) << 2)	/* 1011 */
-#define L_PTE_MT_VECTORS	(_AT(pteval_t, 0x0f) << 2)	/* 1111 */
-#define L_PTE_MT_MASK		(_AT(pteval_t, 0x0f) << 2)
+#define L_PTE_MT_DEV_NONSHARED	(_AT(pteval_t, 0x0c) << 2)	/* 1100 */
+#define L_PTE_MT_MASK           (_AT(pteval_t, 0x0f) << 2)
+#endif
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 81d0efb055c6..367a89d5aeca 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -138,7 +138,7 @@
 	.long	PTE_CACHEABLE					@ L_PTE_MT_WRITETHROUGH
 	.long	PTE_CACHEABLE | PTE_BUFFERABLE			@ L_PTE_MT_WRITEBACK
 	.long	PTE_BUFFERABLE					@ L_PTE_MT_DEV_SHARED
-	.long	0x00						@ unused
+	.long	PTE_CACHEABLE | PTE_BUFFERABLE | PTE_EXT_APX	@ L_PTE_MT_VECTORS
 	.long	0x00						@ L_PTE_MT_MINICACHE (not present)
 	.long	PTE_EXT_TEX(1) | PTE_CACHEABLE | PTE_BUFFERABLE	@ L_PTE_MT_WRITEALLOC
 	.long	0x00						@ unused
@@ -148,7 +148,7 @@
 	.long	PTE_EXT_TEX(2)					@ L_PTE_MT_DEV_NONSHARED
 	.long	0x00						@ unused
 	.long	0x00						@ unused
-	.long	PTE_CACHEABLE | PTE_BUFFERABLE | PTE_EXT_APX	@ L_PTE_MT_VECTORS
+	.long	0x00						@ unused
 	.endm
 
 	.macro	armv6_set_pte_ext pfx
-- 
2.19.0.397.gdd90340f6a-goog
