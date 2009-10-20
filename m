From: benoit.fouet@free.fr (Benoit Fouet)
Date: Tue, 20 Oct 2009 18:07:36 +0200
Subject: [PATCH] Use CONFIG_VECTORS_BASE instead of hardcoded 0xffff0000.
Message-ID: <1256054856-20404-1-git-send-email-benoit.fouet@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The configuration option exists but is not used everywhere,
this patch tries to make it the default instead of the
hardcoded value.

Signed-off-by: Benoit Fouet <benoit.fouet@free.fr>
---
 arch/arm/include/asm/system.h |    2 +-
 arch/arm/kernel/traps.c       |    2 +-
 arch/arm/mm/mmu.c             |    6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index d65b2f5..79dc5da 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -30,7 +30,7 @@
 #define CR_F	(1 << 10)	/* Implementation defined		*/
 #define CR_Z	(1 << 11)	/* Implementation defined		*/
 #define CR_I	(1 << 12)	/* Icache enable			*/
-#define CR_V	(1 << 13)	/* Vectors relocated to 0xffff0000	*/
+#define CR_V	(1 << 13)	/* Vectors relocated			*/
 #define CR_RR	(1 << 14)	/* Round Robin cache replacement	*/
 #define CR_L4	(1 << 15)	/* LDR pc can set T bit			*/
 #define CR_DT	(1 << 16)
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index f838f36..14669a9 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -738,7 +738,7 @@ void __init early_trap_init(void)
 
 	/*
 	 * Copy the vectors, stubs and kuser helpers (in entry-armv.S)
-	 * into the vector page, mapped at 0xffff0000, and ensure these
+	 * into the vector page, mapped at CONFIG_VECTORS_BASE, and ensure these
 	 * are visible to the instruction stream.
 	 */
 	memcpy((void *)vectors, __vectors_start, __vectors_end - __vectors_start);
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 02243ee..ce4d7cf 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -475,7 +475,7 @@ static void __init build_mem_type_table(void)
 	}
 }
 
-#define vectors_base()	(vectors_high() ? 0xffff0000 : 0)
+#define vectors_base()	(vectors_high() ? CONFIG_VECTORS_BASE : 0)
 
 static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
 				  unsigned long end, unsigned long pfn,
@@ -964,11 +964,11 @@ static void __init devicemaps_init(struct machine_desc *mdesc)
 
 	/*
 	 * Create a mapping for the machine vectors at the high-vectors
-	 * location (0xffff0000).  If we aren't using high-vectors, also
+	 * location (CONFIG_VECTORS_BASE).  If we aren't using high-vectors, also
 	 * create a mapping@the low-vectors virtual address.
 	 */
 	map.pfn = __phys_to_pfn(virt_to_phys(vectors));
-	map.virtual = 0xffff0000;
+	map.virtual = CONFIG_VECTORS_BASE;
 	map.length = PAGE_SIZE;
 	map.type = MT_HIGH_VECTORS;
 	create_mapping(&map);
-- 
1.6.0.4
