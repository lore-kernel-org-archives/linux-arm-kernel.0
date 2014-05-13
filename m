From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 13 May 2014 17:54:41 +0200
Subject: [PATCH] ARM: mvebu: use hardware I/O coherency also for PCI devices
Message-ID: <1399996481-11242-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the beginning of the introduction of hardware I/O coherency
support for Armada 370 and Armada XP, the special DMA operations
should have applied to all DMA capable devices. Unfortunately, while
the original code properly took into account platform devices, it
didn't take into account PCI devices, which can also be DMA masters.

This commit fixes that by registering a bus notifier on pci_bus_type,
to register our custom DMA operations, like is already done for
platform devices. While doing this, we also rename
mvebu_hwcc_platform_notifier() to mvebu_hwcc_notifier() and
mvebu_hwcc_platform_nb to mvebu_hwcc_nb because they are no longer
specific to platform devices.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Fixes: e60304f8cb7b ("arm: mvebu: Add hardware I/O Coherency support")
Cc: <stable@vger.kernel.org> # v3.8+
---
Applies to mvebu/soc.

Whether this commit qualifies as stable material can be
discussed. Technically, it was a mistake from the original I/O
coherency implementation. But in practice, besides not using the I/O
coherency, I don't think it's causing any specific problem other than
DMA transactions on PCI devices triggering unneeded cache maintenance
operations. So I'll leave it to the mvebu maintainers to decide
whether this qualifies as stable material or not. I've included the
relevant Fixes: and Cc: fields, but don't hesitate to rip them out if
you don't think this should go to stable.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index d5a975b..177c5ff 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -29,6 +29,7 @@
 #include <linux/slab.h>
 #include <linux/mbus.h>
 #include <linux/clk.h>
+#include <linux/pci.h>
 #include <asm/smp_plat.h>
 #include <asm/cacheflush.h>
 #include "armada-370-xp.h"
@@ -274,8 +275,8 @@ static struct dma_map_ops mvebu_hwcc_dma_ops = {
 	.set_dma_mask		= arm_dma_set_mask,
 };
 
-static int mvebu_hwcc_platform_notifier(struct notifier_block *nb,
-				       unsigned long event, void *__dev)
+static int mvebu_hwcc_notifier(struct notifier_block *nb,
+			       unsigned long event, void *__dev)
 {
 	struct device *dev = __dev;
 
@@ -286,8 +287,8 @@ static int mvebu_hwcc_platform_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static struct notifier_block mvebu_hwcc_platform_nb = {
-	.notifier_call = mvebu_hwcc_platform_notifier,
+static struct notifier_block mvebu_hwcc_nb = {
+	.notifier_call = mvebu_hwcc_notifier,
 };
 
 static void __init armada_370_coherency_init(struct device_node *np)
@@ -375,9 +376,19 @@ static int __init coherency_late_init(void)
 	}
 
 	bus_register_notifier(&platform_bus_type,
-			      &mvebu_hwcc_platform_nb);
+			      &mvebu_hwcc_nb);
 
 	return 0;
 }
 
 postcore_initcall(coherency_late_init);
+
+static int __init coherency_pci_init(void)
+{
+        if (coherency_available())
+                bus_register_notifier(&pci_bus_type,
+                                       &mvebu_hwcc_nb);
+        return 0;
+}
+
+arch_initcall(coherency_pci_init);
-- 
1.9.2
