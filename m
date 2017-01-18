From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Thu, 19 Jan 2017 02:08:37 +0530
Subject: [PATCH 3/4] ARM: nommu: display vectors base
In-Reply-To: <20170118203525.6246-1-afzal.mohd.ma@gmail.com>
References: <20170118203525.6246-1-afzal.mohd.ma@gmail.com>
Message-ID: <20170118203837.6536-1-afzal.mohd.ma@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exception base address is now dynamically estimated for no-MMU
case, display it.

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---
 arch/arm/mm/init.c | 5 +++++
 arch/arm/mm/mm.h   | 5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index cf47f86f79ed..9e11f255c3bf 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -522,7 +522,12 @@ void __init mem_init(void)
 			"      .data : 0x%p" " - 0x%p" "   (%4td kB)\n"
 			"       .bss : 0x%p" " - 0x%p" "   (%4td kB)\n",
 
+#ifdef CONFIG_MMU
 			MLK(UL(VECTORS_BASE), UL(VECTORS_BASE) + (PAGE_SIZE)),
+#else
+			MLK_ROUNDUP(vectors_base, vectors_base + PAGE_SIZE),
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
