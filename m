From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri,  9 Aug 2013 15:35:14 +0530
Subject: [PATCH] ARM: EXYNOS: Set 64-bit DMA mask for EXYNOS5250
Message-ID: <1376042714-26513-1-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When LPAE is enabled, we need to set 64bit DMA mask bits.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
Based on v3.11-rc4.

 arch/arm/mach-exynos/mach-exynos5-dt.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index f874b77..2217631 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -14,6 +14,7 @@
 #include <linux/memblock.h>
 #include <linux/io.h>
 #include <linux/clocksource.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/mach/arch.h>
 #include <mach/regs-pmu.h>
@@ -23,6 +24,26 @@
 
 #include "common.h"
 
+static u64 dma_mask64 = DMA_BIT_MASK(64);
+
+static int exynos5250_platform_notifier(struct notifier_block *nb,
+				  unsigned long event, void *__dev)
+{
+	struct device *dev = __dev;
+
+	if (event != BUS_NOTIFY_ADD_DEVICE)
+		return NOTIFY_DONE;
+
+	dev->dma_mask = &dma_mask64;
+	dev->coherent_dma_mask = DMA_BIT_MASK(64);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block exynos5250_platform_nb = {
+	.notifier_call = exynos5250_platform_notifier,
+};
+
 static void __init exynos5_dt_machine_init(void)
 {
 	struct device_node *i2c_np;
@@ -47,6 +68,11 @@ static void __init exynos5_dt_machine_init(void)
 		}
 	}
 
+	if (config_enabled(CONFIG_ARM_LPAE) &&
+			of_machine_is_compatible("samsung,exynos5250"))
+		bus_register_notifier(&platform_bus_type,
+				&exynos5250_platform_nb);
+
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
1.7.9.5
