From: minchan@kernel.org (Minchan Kim)
Date: Thu,  6 Sep 2018 19:22:10 +0900
Subject: [RFC 1/3] arm: mm: reordering memory type table
In-Reply-To: <20180906102212.218294-1-minchan@kernel.org>
References: <20180906102212.218294-1-minchan@kernel.org>
Message-ID: <20180906102212.218294-2-minchan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To use bit 5th in page table, we need a room for that and it seems
we don't need 4 bits for the memory type with ARMv6+.
If so, let's reorder bits to make bit 5 free.

We will use the bit for L_PTE_SPECIAL in next patch.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Steve Capper <steve.capper@linaro.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 arch/arm/include/asm/pgtable-2level.h | 13 +++++++++++--
 arch/arm/mm/proc-macros.S             | 16 ++++++++--------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 92fd2c8a9af0..91b99fadcba1 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -164,14 +164,23 @@
 #define L_PTE_MT_BUFFERABLE	(_AT(pteval_t, 0x01) << 2)	/* 0001 */
 #define L_PTE_MT_WRITETHROUGH	(_AT(pteval_t, 0x02) << 2)	/* 0010 */
 #define L_PTE_MT_WRITEBACK	(_AT(pteval_t, 0x03) << 2)	/* 0011 */
+#define L_PTE_MT_DEV_SHARED	(_AT(pteval_t, 0x04) << 2)	/* 0100 */
 #define L_PTE_MT_MINICACHE	(_AT(pteval_t, 0x06) << 2)	/* 0110 (sa1100, xscale) */
 #define L_PTE_MT_WRITEALLOC	(_AT(pteval_t, 0x07) << 2)	/* 0111 */
-#define L_PTE_MT_DEV_SHARED	(_AT(pteval_t, 0x04) << 2)	/* 0100 */
-#define L_PTE_MT_DEV_NONSHARED	(_AT(pteval_t, 0x0c) << 2)	/* 1100 */
+#if defined(CONFIG_CPU_V7) || defined(CONFIG_CPU_V7M) || \
+	defined (CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K)
+#define L_PTE_MT_DEV_WC		L_PTE_MT_BUFFERABLE
+#define L_PTE_MT_DEV_CACHED	L_PTE_MT_WRITEBACK
+#define L_PTE_MT_DEV_NONSHARED	L_PTE_MT_MINICACHE
+#define L_PTE_MT_VECTORS	(_AT(pteval_t, 0x05) << 2)	/* 0101 */
+#define L_PTE_MT_MASK		(_AT(pteval_t, 0x07) << 2)
+#else
 #define L_PTE_MT_DEV_WC		(_AT(pteval_t, 0x09) << 2)	/* 1001 */
 #define L_PTE_MT_DEV_CACHED	(_AT(pteval_t, 0x0b) << 2)	/* 1011 */
+#define L_PTE_MT_DEV_NONSHARED	(_AT(pteval_t, 0x0c) << 2)	/* 1100 */
 #define L_PTE_MT_VECTORS	(_AT(pteval_t, 0x0f) << 2)	/* 1111 */
 #define L_PTE_MT_MASK		(_AT(pteval_t, 0x0f) << 2)
+#endif
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 81d0efb055c6..f896a30653fa 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -134,21 +134,21 @@
 	.macro	armv6_mt_table pfx
 \pfx\()_mt_table:
 	.long	0x00						@ L_PTE_MT_UNCACHED
-	.long	PTE_EXT_TEX(1)					@ L_PTE_MT_BUFFERABLE
+	.long	PTE_EXT_TEX(1)					@ L_PTE_MT_BUFFERABLE(L_PTE_MT_DEV_WC)
 	.long	PTE_CACHEABLE					@ L_PTE_MT_WRITETHROUGH
-	.long	PTE_CACHEABLE | PTE_BUFFERABLE			@ L_PTE_MT_WRITEBACK
+	.long	PTE_CACHEABLE | PTE_BUFFERABLE			@ L_PTE_MT_WRITEBACK(L_PTE_MT_DEV_CACHED)
 	.long	PTE_BUFFERABLE					@ L_PTE_MT_DEV_SHARED
-	.long	0x00						@ unused
-	.long	0x00						@ L_PTE_MT_MINICACHE (not present)
+	.long	PTE_CACHEABLE | PTE_BUFFERABLE | PTE_EXT_APX	@ L_PTE_MT_VECTORS
+	.long	PTE_EXT_TEX(2)					@ L_PTE_MT_DEV_NONSHARED
 	.long	PTE_EXT_TEX(1) | PTE_CACHEABLE | PTE_BUFFERABLE	@ L_PTE_MT_WRITEALLOC
 	.long	0x00						@ unused
-	.long	PTE_EXT_TEX(1)					@ L_PTE_MT_DEV_WC
 	.long	0x00						@ unused
-	.long	PTE_CACHEABLE | PTE_BUFFERABLE			@ L_PTE_MT_DEV_CACHED
-	.long	PTE_EXT_TEX(2)					@ L_PTE_MT_DEV_NONSHARED
 	.long	0x00						@ unused
 	.long	0x00						@ unused
-	.long	PTE_CACHEABLE | PTE_BUFFERABLE | PTE_EXT_APX	@ L_PTE_MT_VECTORS
+	.long	0x00						@ unused
+	.long	0x00						@ unused
+	.long	0x00						@ unused
+	.long	0x00						@ unused
 	.endm
 
 	.macro	armv6_set_pte_ext pfx
-- 
2.19.0.rc1.350.ge57e33dbd1-goog
