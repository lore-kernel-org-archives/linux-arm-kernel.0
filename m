From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue,  9 Apr 2013 17:34:56 -0700
Subject: [RFC PATCHv2 1/2] arm: highmem: Add support for flushing kmap_atomic
 mappings
Message-ID: <1365554097-21305-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The highmem code provides kmap_flush_unused to ensure all kmap
mappings are really removed if they are unused. This code does not
handle kmap_atomic mappings since they are managed separately.
This prevents an issue for any code which relies on having absolutely
no mappings for a particular page. Rather than pay the penalty of
having CONFIG_DEBUG_HIGHMEM on all the time, add functionality
to remove the kmap_atomic mappings in a similar way to kmap_flush_unused.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/Kconfig      |    3 ++
 arch/arm/mm/highmem.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1cacda4..d926d46 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -207,6 +207,9 @@ config NEED_RET_TO_USER
 config ARCH_MTD_XIP
 	bool
 
+config ARCH_WANT_KMAP_ATOMIC_FLUSH
+	bool
+
 config VECTORS_BASE
 	hex
 	default 0xffff0000 if MMU || CPU_HIGH_VECTOR
diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
index 21b9e1b..fe3d6d9 100644
--- a/arch/arm/mm/highmem.c
+++ b/arch/arm/mm/highmem.c
@@ -10,6 +10,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/cpu.h>
 #include <linux/module.h>
 #include <linux/highmem.h>
 #include <linux/interrupt.h>
@@ -135,3 +136,59 @@ struct page *kmap_atomic_to_page(const void *ptr)
 
 	return pte_page(get_top_pte(vaddr));
 }
+
+#ifdef CONFIG_ARCH_WANT_KMAP_ATOMIC_FLUSH
+static void kmap_remove_unused_cpu(int cpu)
+{
+	int start_idx, idx, type;
+
+	pagefault_disable();
+	type = kmap_atomic_idx();
+	start_idx = type + 1 + KM_TYPE_NR * cpu;
+
+	for (idx = start_idx; idx < KM_TYPE_NR + KM_TYPE_NR * cpu; idx++) {
+		unsigned long vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+		pte_t ptep;
+
+		ptep = get_top_pte(vaddr);
+		if (ptep)
+			set_top_pte(vaddr, __pte(0));
+	}
+	pagefault_enable();
+}
+
+static void kmap_remove_unused(void *unused)
+{
+	kmap_remove_unused_cpu(smp_processor_id());
+}
+
+void kmap_atomic_flush_unused(void)
+{
+	on_each_cpu(kmap_remove_unused, NULL, 1);
+}
+
+static int hotplug_kmap_atomic_callback(struct notifier_block *nfb,
+                                unsigned long action, void *hcpu)
+{
+        switch (action & (~CPU_TASKS_FROZEN)) {
+        case CPU_DYING:
+		kmap_remove_unused_cpu((int)hcpu);
+                break;
+        default:
+                break;
+        }
+
+        return NOTIFY_OK;
+}
+
+static struct notifier_block hotplug_kmap_atomic_notifier = {
+        .notifier_call = hotplug_kmap_atomic_callback,
+};
+
+static int __init init_kmap_atomic(void)
+{
+
+        return register_hotcpu_notifier(&hotplug_kmap_atomic_notifier);
+}
+early_initcall(init_kmap_atomic);
+#endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
