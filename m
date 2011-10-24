From: ming.lei@canonical.com (ming.lei at canonical.com)
Date: Mon, 24 Oct 2011 22:45:59 +0800
Subject: [PATCH v5 7/7] arm: omap4: pmu: support runtime pm
In-Reply-To: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
Message-ID: <1319467559-5518-8-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ming Lei <ming.lei@canonical.com>

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 arch/arm/mach-omap2/devices.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index bc791e0..ab4de0d 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -395,9 +396,11 @@ static struct omap_device_pm_latency omap_pmu_latency[] = {
 };
 
 static struct cti omap4_cti[2];
+static struct platform_device *pmu_dev;
 
 static void omap4_enable_cti(int irq)
 {
+	pm_runtime_get_sync(&pmu_dev->dev);
 	if (irq == OMAP44XX_IRQ_CTI0)
 		cti_enable(&omap4_cti[0]);
 	else if (irq == OMAP44XX_IRQ_CTI1)
@@ -410,6 +413,7 @@ static void omap4_disable_cti(int irq)
 		cti_disable(&omap4_cti[0]);
 	else if (irq == OMAP44XX_IRQ_CTI1)
 		cti_disable(&omap4_cti[1]);
+	pm_runtime_put(&pmu_dev->dev);
 }
 
 static irqreturn_t omap4_pmu_handler(int irq, void *dev, irq_handler_t handler)
@@ -497,8 +501,11 @@ static void __init omap_init_pmu(void)
 		if (!pd)
 			return;
 
-		omap_device_enable(&od->pdev);
+		pmu_dev= pd;
+		pm_runtime_enable(&pd->dev);
+		pm_runtime_get_sync(&pd->dev);
 		omap4_configure_pmu_irq();
+		pm_runtime_put(&pd->dev);
 		return;
 	} else {
 		return;
-- 
1.7.5.4
