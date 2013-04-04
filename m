From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu,  4 Apr 2013 19:51:43 +0900
Subject: [PATCH 1/2] ARM: EXYNOS: Add a platform bus notifier to set dma masks
 for Exynos5440
Message-ID: <1365072704-4568-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

Use a platform bus notifier callback function to set the correct dma_mask and
coherent_dma_mask for every device registered on Exynos5440 based machine.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/mach-exynos5-dt.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index 753b94f..e47c2a5 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -14,6 +14,7 @@
 #include <linux/memblock.h>
 #include <linux/io.h>
 #include <linux/clocksource.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/mach/arch.h>
 #include <mach/regs-pmu.h>
@@ -23,11 +24,30 @@
 
 #include "common.h"
 
+static u64 dma_mask64 = DMA_BIT_MASK(64);
+
 static void __init exynos5_dt_map_io(void)
 {
 	exynos_init_io(NULL, 0);
 }
 
+static int exynos5440_platform_notifier(struct notifier_block *nb,
+				  unsigned long event, void *__dev)
+{
+	struct device *dev = __dev;
+
+	if (event != BUS_NOTIFY_ADD_DEVICE)
+		return NOTIFY_DONE;
+
+	dev->dma_mask = &dma_mask64;
+	dev->coherent_dma_mask = DMA_BIT_MASK(64);
+	return NOTIFY_OK;
+}
+
+static struct notifier_block exynos5440_platform_nb = {
+	.notifier_call = exynos5440_platform_notifier,
+};
+
 static void __init exynos5_dt_machine_init(void)
 {
 	struct device_node *i2c_np;
@@ -52,6 +72,9 @@ static void __init exynos5_dt_machine_init(void)
 		}
 	}
 
+	if (of_machine_is_compatible("samsung,exynos5440"))
+		bus_register_notifier(&platform_bus_type, &exynos5440_platform_nb);
+
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
1.7.4.4
