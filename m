From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Aug 2010 14:00:54 -0700
Subject: [PATCH 1/6] ARM: Add inline function smp_on_up() for early init testing
Message-ID: <mailman.220.1283444342.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add inline function smp_on_up() for early init checks, and
change build_mem_type_table to use it.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/include/asm/smp_plat.h |   16 ++++++++++++++++
 arch/arm/mm/mmu.c               |   20 +++++++++++---------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index 8db3512..5ef4114 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -39,4 +39,20 @@ static inline int cache_ops_need_broadcast(void)
 #define UP(instr...)	_str(instr)
 #endif
 
+static inline int smp_on_up(void)
+{
+#ifdef CONFIG_SMP_ON_UP
+	int smp_on_up;
+
+	asm(							\
+		SMP(mov	%0, #0)					\
+		UP(mov	%0, #1)					\
+		: "=r" (smp_on_up));
+
+	return smp_on_up;
+#else
+	return 0;
+#endif
+}
+
 #endif
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 6e1c4f6..f320901 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -430,15 +430,17 @@ static void __init build_mem_type_table(void)
 		/*
 		 * Mark memory with the "shared" attribute for SMP systems
 		 */
-		user_pgprot |= L_PTE_SHARED;
-		kern_pgprot |= L_PTE_SHARED;
-		vecs_pgprot |= L_PTE_SHARED;
-		mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_S;
-		mem_types[MT_DEVICE_WC].prot_pte |= L_PTE_SHARED;
-		mem_types[MT_DEVICE_CACHED].prot_sect |= PMD_SECT_S;
-		mem_types[MT_DEVICE_CACHED].prot_pte |= L_PTE_SHARED;
-		mem_types[MT_MEMORY].prot_sect |= PMD_SECT_S;
-		mem_types[MT_MEMORY_NONCACHED].prot_sect |= PMD_SECT_S;
+		if (!smp_on_up()) {
+			user_pgprot |= L_PTE_SHARED;
+			kern_pgprot |= L_PTE_SHARED;
+			vecs_pgprot |= L_PTE_SHARED;
+			mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_S;
+			mem_types[MT_DEVICE_WC].prot_pte |= L_PTE_SHARED;
+			mem_types[MT_DEVICE_CACHED].prot_sect |= PMD_SECT_S;
+			mem_types[MT_DEVICE_CACHED].prot_pte |= L_PTE_SHARED;
+			mem_types[MT_MEMORY].prot_sect |= PMD_SECT_S;
+			mem_types[MT_MEMORY_NONCACHED].prot_sect |= PMD_SECT_S;
+		}
 #endif
 	}
 
-- 
1.7.1
