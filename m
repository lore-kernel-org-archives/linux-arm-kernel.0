From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Sun, 22 Jan 2017 08:52:12 +0530
Subject: [PATCH v2 3/4] ARM: nommu: display vectors base
In-Reply-To: <20170122031652.13074-1-afzal.mohd.ma@gmail.com>
References: <20170122031652.13074-1-afzal.mohd.ma@gmail.com>
Message-ID: <20170122032212.13456-1-afzal.mohd.ma@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exception base address is now dynamically estimated for no-MMU,
display it. As it is the case, now limit VECTORS_BASE usage to MMU
scenario.

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

v2:
 A change to accomodate bisectability resolution on patch 1/4

 arch/arm/include/asm/memory.h | 4 ++--
 arch/arm/mm/init.c            | 5 +++++
 arch/arm/mm/mm.h              | 5 +++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 0b5416fe7709..9ae474bf84fc 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -83,6 +83,8 @@
 #define IOREMAP_MAX_ORDER	24
 #endif
 
+#define VECTORS_BASE		UL(0xffff0000)
+
 #else /* CONFIG_MMU */
 
 /*
@@ -111,8 +113,6 @@
 
 #endif /* !CONFIG_MMU */
 
-#define VECTORS_BASE		UL(0xffff0000)
-
 /*
  * We fix the TCM memories max 32 KiB ITCM resp DTCM at these
  * locations
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 823e119a5daa..9c68e3aba87c 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -522,7 +522,12 @@ void __init mem_init(void)
 			"      .data : 0x%p" " - 0x%p" "   (%4td kB)\n"
 			"       .bss : 0x%p" " - 0x%p" "   (%4td kB)\n",
 
+#ifdef CONFIG_MMU
 			MLK(VECTORS_BASE, VECTORS_BASE + PAGE_SIZE),
+#else
+			MLK(vectors_base, vectors_base + PAGE_SIZE),
+#endif
+
 #ifdef CONFIG_HAVE_TCM
 			MLK(DTCM_OFFSET, (unsigned long) dtcm_end),
 			MLK(ITCM_OFFSET, (unsigned long) itcm_end),
diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
index ce727d47275c..546f09437fca 100644
--- a/arch/arm/mm/mm.h
+++ b/arch/arm/mm/mm.h
@@ -79,8 +79,9 @@ struct static_vm {
 extern struct list_head static_vmlist;
 extern struct static_vm *find_static_vm_vaddr(void *vaddr);
 extern __init void add_static_vm_early(struct static_vm *svm);
-
-#endif
+#else /* CONFIG_MMU */
+extern unsigned long vectors_base;
+#endif /* CONFIG_MMU */
 
 #ifdef CONFIG_ZONE_DMA
 extern phys_addr_t arm_dma_limit;
-- 
2.11.0
