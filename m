From: will.deacon@arm.com (Will Deacon)
Date: Fri, 10 Mar 2017 20:32:23 +0000
Subject: [PATCH 4/6] arm64: cache: Merge cachetype.h into cache.h
In-Reply-To: <1489177945-8590-1-git-send-email-will.deacon@arm.com>
References: <1489177945-8590-1-git-send-email-will.deacon@arm.com>
Message-ID: <1489177945-8590-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cachetype.h and cache.h are small and both obviously related to caches.
Merge them together to reduce clutter.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cache.h     | 31 ++++++++++++++++++++-
 arch/arm64/include/asm/cachetype.h | 55 --------------------------------------
 arch/arm64/include/asm/kvm_mmu.h   |  2 +-
 arch/arm64/kernel/cpuinfo.c        |  2 +-
 arch/arm64/mm/flush.c              |  2 +-
 5 files changed, 33 insertions(+), 59 deletions(-)
 delete mode 100644 arch/arm64/include/asm/cachetype.h

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 5082b30bc2c0..7acb52634299 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -16,7 +16,17 @@
 #ifndef __ASM_CACHE_H
 #define __ASM_CACHE_H
 
-#include <asm/cachetype.h>
+#include <asm/cputype.h>
+
+#define CTR_L1IP_SHIFT		14
+#define CTR_L1IP_MASK		3
+#define CTR_CWG_SHIFT		24
+#define CTR_CWG_MASK		15
+
+#define CTR_L1IP(ctr)		(((ctr) >> CTR_L1IP_SHIFT) & CTR_L1IP_MASK)
+
+#define ICACHE_POLICY_VIPT	2
+#define ICACHE_POLICY_PIPT	3
 
 #define L1_CACHE_SHIFT		7
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
@@ -32,6 +42,25 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/bitops.h>
+
+#define ICACHEF_ALIASING	0
+extern unsigned long __icache_flags;
+
+/*
+ * Whilst the D-side always behaves as PIPT on AArch64, aliasing is
+ * permitted in the I-cache.
+ */
+static inline int icache_is_aliasing(void)
+{
+	return test_bit(ICACHEF_ALIASING, &__icache_flags);
+}
+
+static inline u32 cache_type_cwg(void)
+{
+	return (read_cpuid_cachetype() >> CTR_CWG_SHIFT) & CTR_CWG_MASK;
+}
+
 #define __read_mostly __attribute__((__section__(".data..read_mostly")))
 
 static inline int cache_line_size(void)
diff --git a/arch/arm64/include/asm/cachetype.h b/arch/arm64/include/asm/cachetype.h
deleted file mode 100644
index fbab37c669a0..000000000000
--- a/arch/arm64/include/asm/cachetype.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * Copyright (C) 2012 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef __ASM_CACHETYPE_H
-#define __ASM_CACHETYPE_H
-
-#include <asm/cputype.h>
-
-#define CTR_L1IP_SHIFT		14
-#define CTR_L1IP_MASK		3
-#define CTR_CWG_SHIFT		24
-#define CTR_CWG_MASK		15
-
-#define ICACHE_POLICY_VIPT	2
-#define ICACHE_POLICY_PIPT	3
-
-#ifndef __ASSEMBLY__
-
-#include <linux/bitops.h>
-
-#define CTR_L1IP(ctr)	(((ctr) >> CTR_L1IP_SHIFT) & CTR_L1IP_MASK)
-
-#define ICACHEF_ALIASING	0
-
-extern unsigned long __icache_flags;
-
-/*
- * Whilst the D-side always behaves as PIPT on AArch64, aliasing is
- * permitted in the I-cache.
- */
-static inline int icache_is_aliasing(void)
-{
-	return test_bit(ICACHEF_ALIASING, &__icache_flags);
-}
-
-static inline u32 cache_type_cwg(void)
-{
-	return (read_cpuid_cachetype() >> CTR_CWG_SHIFT) & CTR_CWG_MASK;
-}
-
-#endif	/* __ASSEMBLY__ */
-
-#endif	/* __ASM_CACHETYPE_H */
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 4be5773d4606..dc3624d8b9db 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -108,7 +108,7 @@ alternative_else_nop_endif
 #else
 
 #include <asm/pgalloc.h>
-#include <asm/cachetype.h>
+#include <asm/cache.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index efe74ecc9738..260b54f415b8 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -15,7 +15,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include <asm/arch_timer.h>
-#include <asm/cachetype.h>
+#include <asm/cache.h>
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/cpufeature.h>
diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 1e968222a544..21a8d828cbf4 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -22,7 +22,7 @@
 #include <linux/pagemap.h>
 
 #include <asm/cacheflush.h>
-#include <asm/cachetype.h>
+#include <asm/cache.h>
 #include <asm/tlbflush.h>
 
 void sync_icache_aliases(void *kaddr, unsigned long len)
-- 
2.1.4
