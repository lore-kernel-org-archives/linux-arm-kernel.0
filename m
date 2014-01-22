From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Jan 2014 14:31:10 +0100
Subject: [PATCH 4/5] ARM: integrator: register the IM-PD1 VIC
In-Reply-To: <1390397471-6802-1-git-send-email-linus.walleij@linaro.org>
References: <1390397471-6802-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1390397471-6802-5-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The peripherals on the IM-PD1 has never really been able to
properly fire their IRQs to the main FPGA IRQ controller.
Cascade it properly and register interrupts for all the
devices in the array.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/Kconfig |  1 +
 arch/arm/mach-integrator/impd1.c | 45 ++++++++++++++++++++++++++++++++--------
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index abeff25532ab..46be99007529 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -30,6 +30,7 @@ config ARCH_CINTEGRATOR
 config INTEGRATOR_IMPD1
 	tristate "Include support for Integrator/IM-PD1"
 	depends on ARCH_INTEGRATOR_AP
+	select ARM_VIC
 	help
 	  The IM-PD1 is an add-on logic module for the Integrator which
 	  allows ARM(R) Ltd PrimeCells to be developed and evaluated.
diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index aeeae0d79a18..d9b784824808 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/platform_data/clk-integrator.h>
 #include <linux/slab.h>
+#include <linux/irqchip/arm-vic.h>
 
 #include <mach/lm.h>
 #include <mach/impd1.h>
@@ -35,6 +36,7 @@ MODULE_PARM_DESC(lmid, "logic module stack position");
 
 struct impd1_module {
 	void __iomem	*base;
+	void __iomem	*vic_base;
 };
 
 void impd1_tweak_control(struct device *dev, u32 mask, u32 val)
@@ -262,9 +264,6 @@ struct impd1_device {
 
 static struct impd1_device impd1_devs[] = {
 	{
-		.offset	= 0x03000000,
-		.id	= 0x00041190,
-	}, {
 		.offset	= 0x00100000,
 		.irq	= { 1 },
 		.id	= 0x00141011,
@@ -304,9 +303,15 @@ static struct impd1_device impd1_devs[] = {
 	}
 };
 
-static int impd1_probe(struct lm_device *dev)
+/*
+ * Valid IRQs: 0 thru 9 and 11, 10 unused.
+ */
+#define IMPD1_VALID_IRQS 0x00000bffU
+
+static int __init impd1_probe(struct lm_device *dev)
 {
 	struct impd1_module *impd1;
+	int irq_base;
 	int i;
 
 	if (dev->id != module_id)
@@ -325,23 +330,45 @@ static int impd1_probe(struct lm_device *dev)
 	if (!impd1->base)
 		return -ENOMEM;
 
-	lm_set_drvdata(dev, impd1);
+	integrator_impd1_clk_init(impd1->base, dev->id);
+
+	if (!devm_request_mem_region(&dev->dev,
+				     dev->resource.start + 0x03000000,
+				     SZ_4K, "VIC"))
+		return -EBUSY;
 
-	printk("IM-PD1 found at 0x%08lx\n",
-		(unsigned long)dev->resource.start);
+	impd1->vic_base = devm_ioremap(&dev->dev,
+				       dev->resource.start + 0x03000000,
+				       SZ_4K);
+	if (!impd1->vic_base)
+		return -ENOMEM;
 
-	integrator_impd1_clk_init(impd1->base, dev->id);
+	irq_base = vic_init_cascaded(impd1->vic_base, dev->irq,
+				     IMPD1_VALID_IRQS, 0);
+
+	lm_set_drvdata(dev, impd1);
+
+	dev_info(&dev->dev, "IM-PD1 found at 0x%08lx\n",
+		 (unsigned long)dev->resource.start);
 
 	for (i = 0; i < ARRAY_SIZE(impd1_devs); i++) {
 		struct impd1_device *idev = impd1_devs + i;
 		struct amba_device *d;
 		unsigned long pc_base;
 		char devname[32];
+		int irq1 = idev->irq[0];
+		int irq2 = idev->irq[1];
+
+		/* Translate IRQs to IM-PD1 local numberspace */
+		if (irq1)
+			irq1 += irq_base;
+		if (irq2)
+			irq2 += irq_base;
 
 		pc_base = dev->resource.start + idev->offset;
 		snprintf(devname, 32, "lm%x:%5.5lx", dev->id, idev->offset >> 12);
 		d = amba_ahb_device_add_res(&dev->dev, devname, pc_base, SZ_4K,
-					    dev->irq, dev->irq,
+					    irq1, irq2,
 					    idev->platform_data, idev->id,
 					    &dev->resource);
 		if (IS_ERR(d)) {
-- 
1.8.4.2
