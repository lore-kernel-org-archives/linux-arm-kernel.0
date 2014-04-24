From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 24 Apr 2014 11:42:20 -0400
Subject: [PATCH 2/4] ARM: keystone: Update the dma offset for non-dt platform
 devices
In-Reply-To: <1398354142-2767-1-git-send-email-santosh.shilimkar@ti.com>
References: <1398354142-2767-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1398354142-2767-3-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-keystone/keystone.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index 155eb06..59b8383 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -31,6 +31,27 @@
 #define PLL_RESET				BIT(16)
 
 static void __iomem *keystone_rstctrl;
+static struct notifier_block platform_nb;
+static unsigned long keystone_dma_pfn_offset __read_mostly;
+
+static int keystone_platform_notifier(struct notifier_block *nb,
+				      unsigned long event, void *data)
+{
+	struct device *dev = data;
+
+	if (event != BUS_NOTIFY_ADD_DEVICE)
+		return NOTIFY_DONE;
+
+	if (!dev)
+		return NOTIFY_BAD;
+
+	if (!dev->of_node) {
+		dev->dma_pfn_offset = keystone_dma_pfn_offset;
+		dev_err(dev, "set dma_pfn_offset%08lx\n",
+			dev->dma_pfn_offset);
+	}
+	return NOTIFY_OK;
+}
 
 static void __init keystone_init(void)
 {
@@ -45,6 +66,8 @@ static void __init keystone_init(void)
 		pr_warn("ti,keystone-reset iomap error\n");
 
 	keystone_pm_runtime_init();
+	if (platform_nb.notifier_call)
+		bus_register_notifier(&platform_bus_type, &platform_nb);
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
@@ -88,6 +111,9 @@ static void __init keystone_init_meminfo(void)
 
 	/* Populate the arch idmap hook */
 	arch_virt_to_idmap = keystone_virt_to_idmap;
+	platform_nb.notifier_call = keystone_platform_notifier;
+	keystone_dma_pfn_offset = PFN_DOWN(KEYSTONE_HIGH_PHYS_START -
+						KEYSTONE_LOW_PHYS_START);
 
 	pr_info("Switching to high address space at 0x%llx\n", (u64)offset);
 }
-- 
1.7.9.5
