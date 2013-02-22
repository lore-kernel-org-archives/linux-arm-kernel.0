From: murzin.v@gmail.com (Vladimir Murzin)
Date: Fri, 22 Feb 2013 20:47:42 +0400
Subject: [PATCH v2] arm: add check for global exclusive monitor
Message-ID: <1361551662-5241-1-git-send-email-murzin.v@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since ARMv6 new atomic instructions have been introduced:
ldrex/strex. Several implementation are possible based on (1) global
and local exclusive monitors and (2) local exclusive monitor and snoop
unit.

In case of the 2nd options exclusive store operation on uncached
region may be faulty.

Check for availability of global monitor to provide some hint about
possible issues.

Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
---
Changes since
	v1: 
	- Using L_PTE_MT_BUFFERABLE instead of L_PTE_MT_UNCACHABLE
	  Thanks to Russell for ponting this silly error
	- added comment about how checking is done
		
 arch/arm/include/asm/bugs.h |   14 +++++++++--
 arch/arm/mm/fault-armv.c    |   55 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/bugs.h b/arch/arm/include/asm/bugs.h
index a97f1ea..29d73cd 100644
--- a/arch/arm/include/asm/bugs.h
+++ b/arch/arm/include/asm/bugs.h
@@ -13,9 +13,19 @@
 #ifdef CONFIG_MMU
 extern void check_writebuffer_bugs(void);
 
-#define check_bugs() check_writebuffer_bugs()
+#if  __LINUX_ARM_ARCH__ < 6
+static void check_gmonitor_bugs(void) {};
 #else
-#define check_bugs() do { } while (0)
+extern void check_gmonitor_bugs(void);
+#endif
+
+static inline void check_bugs(void)
+{
+	check_writebuffer_bugs();
+	check_gmonitor_bugs();
+}
+#else
+static inline void check_bugs(void) { }
 #endif
 
 #endif
diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 2a5907b..6a1a07e 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -205,6 +205,61 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
 			__flush_icache_all();
 	}
 }
+#else
+/*
+ * Check for the global exclusive monitor. The global monitor is a external
+ * transaction monitoring block for tracking exclusive accesses to sharable
+ * memory regions. LDREX/STREX rely on this monitor when accessing uncached
+ * shared memory.
+ * If global monitor is not implemented STREX operation on uncached shared
+ * memory region always fail, returning 0 in the destination register.
+ * We rely on this property to check whether global monitor is implemented
+ * or not.
+ * NB: The name of L_PTE_MT_BUFFERABLE is not for B bit, but for normal
+ * non-cacheable memory type (XXCB = 0001).
+ */
+void __init check_gmonitor_bugs(void)
+{
+	struct page *page;
+	const char *reason;
+	unsigned long res = 1;
+
+	printk(KERN_INFO "CPU: Testing for global monitor: ");
+
+	page = alloc_page(GFP_KERNEL);
+	if (page) {
+		unsigned long *p;
+		pgprot_t prot = __pgprot_modify(PAGE_KERNEL,
+					L_PTE_MT_MASK, L_PTE_MT_BUFFERABLE);
+
+		p = vmap(&page, 1, VM_IOREMAP, prot);
+
+		if (p) {
+			int temp, res;
+
+			__asm__ __volatile__(
+				"ldrex   %1, [%2]\n"
+				"strex   %0, %1, [%2]"
+				: "=&r" (res), "=&r" (temp)
+				: "r" (p)
+				: "cc", "memory");
+
+			reason = "n/a (atomic ops may be faulty)";
+		} else {
+			reason = "unable to map memory\n";
+		}
+
+		vunmap(p);
+		put_page(page);
+	} else {
+		reason = "unable to grab page\n";
+	}
+
+	if (res)
+		printk("failed, %s\n", reason);
+	else
+		printk("ok\n");
+}
 #endif	/* __LINUX_ARM_ARCH__ < 6 */
 
 /*
-- 
1.7.10.4
