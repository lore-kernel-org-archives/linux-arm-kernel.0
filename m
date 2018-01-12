From: andreyknvl@google.com (Andrey Konovalov)
Date: Fri, 12 Jan 2018 17:49:28 +0100
Subject: [PATCH v2 2/2] kasan: clean up KASAN_SHADOW_SCALE_SHIFT usage
In-Reply-To: <cover.1515775666.git.andreyknvl@google.com>
References: <cover.1515775666.git.andreyknvl@google.com>
Message-ID: <34937ca3b90736eaad91b568edf5684091f662e3.1515775666.git.andreyknvl@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Right now the fact that KASAN uses a single shadow byte for 8 bytes of
memory is scattered all over the code.

This change defines KASAN_SHADOW_SCALE_SHIFT early in asm include files
and makes use of this constant where necessary.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/kasan.h  | 17 ++++++++++-------
 arch/arm64/include/asm/memory.h |  3 ++-
 arch/arm64/mm/kasan_init.c      |  3 ++-
 arch/x86/include/asm/kasan.h    | 12 ++++++++----
 include/linux/kasan.h           |  2 --
 5 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
index e266f80e45b7..b1591f4cbbdb 100644
--- a/arch/arm64/include/asm/kasan.h
+++ b/arch/arm64/include/asm/kasan.h
@@ -12,7 +12,8 @@
 
 /*
  * KASAN_SHADOW_START: beginning of the kernel virtual addresses.
- * KASAN_SHADOW_END: KASAN_SHADOW_START + 1/8 of kernel virtual addresses.
+ * KASAN_SHADOW_END: KASAN_SHADOW_START + 1/N of kernel virtual addresses,
+ * where N = (1 << KASAN_SHADOW_SCALE_SHIFT).
  */
 #define KASAN_SHADOW_START      (VA_START)
 #define KASAN_SHADOW_END        (KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
@@ -20,14 +21,16 @@
 /*
  * This value is used to map an address to the corresponding shadow
  * address by the following formula:
- *     shadow_addr = (address >> 3) + KASAN_SHADOW_OFFSET;
+ *     shadow_addr = (address >> KASAN_SHADOW_SCALE_SHIFT) + KASAN_SHADOW_OFFSET
  *
- * (1 << 61) shadow addresses - [KASAN_SHADOW_OFFSET,KASAN_SHADOW_END]
- * cover all 64-bits of virtual addresses. So KASAN_SHADOW_OFFSET
- * should satisfy the following equation:
- *      KASAN_SHADOW_OFFSET = KASAN_SHADOW_END - (1ULL << 61)
+ * (1 << (64 - KASAN_SHADOW_SCALE_SHIFT)) shadow addresses that lie in range
+ * [KASAN_SHADOW_OFFSET, KASAN_SHADOW_END) cover all 64-bits of virtual
+ * addresses. So KASAN_SHADOW_OFFSET should satisfy the following equation:
+ *      KASAN_SHADOW_OFFSET = KASAN_SHADOW_END -
+ * 				(1ULL << (64 - KASAN_SHADOW_SCALE_SHIFT))
  */
-#define KASAN_SHADOW_OFFSET     (KASAN_SHADOW_END - (1ULL << (64 - 3)))
+#define KASAN_SHADOW_OFFSET     (KASAN_SHADOW_END - (1ULL << \
+					(64 - KASAN_SHADOW_SCALE_SHIFT)))
 
 void kasan_init(void);
 void kasan_copy_shadow(pgd_t *pgdir);
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index d4bae7d6e0d8..50fa96a49792 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -85,7 +85,8 @@
  * stack size when KASAN is in use.
  */
 #ifdef CONFIG_KASAN
-#define KASAN_SHADOW_SIZE	(UL(1) << (VA_BITS - 3))
+#define KASAN_SHADOW_SCALE_SHIFT 3
+#define KASAN_SHADOW_SIZE	(UL(1) << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
 #define KASAN_THREAD_SHIFT	1
 #else
 #define KASAN_SHADOW_SIZE	(0)
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index acba49fb5aac..6e02e6fb4c7b 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -135,7 +135,8 @@ static void __init kasan_pgd_populate(unsigned long addr, unsigned long end,
 /* The early shadow maps everything to a single page of zeroes */
 asmlinkage void __init kasan_early_init(void)
 {
-	BUILD_BUG_ON(KASAN_SHADOW_OFFSET != KASAN_SHADOW_END - (1UL << 61));
+	BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=
+		KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
 	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_START, PGDIR_SIZE));
 	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_END, PGDIR_SIZE));
 	kasan_pgd_populate(KASAN_SHADOW_START, KASAN_SHADOW_END, NUMA_NO_NODE,
diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
index b577dd0916aa..13e70da38bed 100644
--- a/arch/x86/include/asm/kasan.h
+++ b/arch/x86/include/asm/kasan.h
@@ -4,6 +4,7 @@
 
 #include <linux/const.h>
 #define KASAN_SHADOW_OFFSET _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
+#define KASAN_SHADOW_SCALE_SHIFT 3
 
 /*
  * Compiler uses shadow offset assuming that addresses start
@@ -12,12 +13,15 @@
  * 'kernel address space start' >> KASAN_SHADOW_SCALE_SHIFT
  */
 #define KASAN_SHADOW_START      (KASAN_SHADOW_OFFSET + \
-					((-1UL << __VIRTUAL_MASK_SHIFT) >> 3))
+					((-1UL << __VIRTUAL_MASK_SHIFT) >> \
+						KASAN_SHADOW_SCALE_SHIFT))
 /*
- * 47 bits for kernel address -> (47 - 3) bits for shadow
- * 56 bits for kernel address -> (56 - 3) bits for shadow
+ * 47 bits for kernel address -> (47 - KASAN_SHADOW_SCALE_SHIFT) bits for shadow
+ * 56 bits for kernel address -> (56 - KASAN_SHADOW_SCALE_SHIFT) bits for shadow
  */
-#define KASAN_SHADOW_END        (KASAN_SHADOW_START + (1ULL << (__VIRTUAL_MASK_SHIFT - 3)))
+#define KASAN_SHADOW_END        (KASAN_SHADOW_START + \
+					(1ULL << (__VIRTUAL_MASK_SHIFT - \
+						  KASAN_SHADOW_SCALE_SHIFT)))
 
 #ifndef __ASSEMBLY__
 
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index e3eb834c9a35..e9eaa964473a 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -11,8 +11,6 @@ struct task_struct;
 
 #ifdef CONFIG_KASAN
 
-#define KASAN_SHADOW_SCALE_SHIFT 3
-
 #include <asm/kasan.h>
 #include <asm/pgtable.h>
 
-- 
2.16.0.rc1.238.g530d649a79-goog
