From: lauraa@codeaurora.org (Laura Abbott)
Date: Fri,  5 Apr 2013 14:42:51 -0700
Subject: [RFC][PATCH] arm: highmem: Add support for flushing kmap_atomic
 mappings
Message-ID: <1365198171-8469-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The highmem code provides kmap_flush_unused to ensure all kmap
mappings are really removed if they are used. This code does not
handle kmap_atomic mappings since they are managed separately.
This prevents an issue for any code which relies on having absolutely
no mappings for a particular page. Rather than pay the penalty of
having CONFIG_DEBUG_HIGHMEM on all the time, add functionality
to remove the kmap_atomic mappings in a similar way to kmap_flush_unused.

This is intended to be an RFC to make sure this approach is
reasonable. The goal is to have kmap_atomic_flush_unused be a public
API.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/mm/highmem.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
index 21b9e1b..f4c0466 100644
--- a/arch/arm/mm/highmem.c
+++ b/arch/arm/mm/highmem.c
@@ -10,6 +10,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/cpu.h>
 #include <linux/module.h>
 #include <linux/highmem.h>
 #include <linux/interrupt.h>
@@ -135,3 +136,53 @@ struct page *kmap_atomic_to_page(const void *ptr)
 
 	return pte_page(get_top_pte(vaddr));
 }
+
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
+		set_top_pte(vaddr, __pte(0));
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
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
