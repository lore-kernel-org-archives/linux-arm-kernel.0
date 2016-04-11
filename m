From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 11 Apr 2016 13:12:27 +0530
Subject: [RESPIN v2 5/6] memory: samsung: exynos-srom: Add support for bank
 configuration
In-Reply-To: <1460360548-32127-1-git-send-email-pankaj.dubey@samsung.com>
References: <1460360548-32127-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1460360548-32127-6-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pavel Fedin <p.fedin@samsung.com>

Implement handling properties in subnodes and adding child devices to the
system. Child devices will not be added if configuration fails.

Since the driver now does more than suspend-resume support, dependency on
CONFIG_PM is removed.

Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-exynos/Kconfig         |  2 +-
 drivers/memory/samsung/Kconfig       |  2 +-
 drivers/memory/samsung/exynos-srom.c | 60 ++++++++++++++++++++++++++++++++++--
 3 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 28f9928..e65aa7d 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -18,7 +18,7 @@ menuconfig ARCH_EXYNOS
 	select COMMON_CLK_SAMSUNG
 	select EXYNOS_THERMAL
 	select EXYNOS_PMU
-	select EXYNOS_SROM if PM
+	select EXYNOS_SROM
 	select HAVE_ARM_SCU if SMP
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
diff --git a/drivers/memory/samsung/Kconfig b/drivers/memory/samsung/Kconfig
index 64ab5dd..9de1222 100644
--- a/drivers/memory/samsung/Kconfig
+++ b/drivers/memory/samsung/Kconfig
@@ -8,6 +8,6 @@ if SAMSUNG_MC
 
 config EXYNOS_SROM
 	bool "Exynos SROM controller driver" if COMPILE_TEST
-	depends on (ARM && ARCH_EXYNOS && PM) || (COMPILE_TEST && HAS_IOMEM)
+	depends on (ARM && ARCH_EXYNOS) || (COMPILE_TEST && HAS_IOMEM)
 
 endif
diff --git a/drivers/memory/samsung/exynos-srom.c b/drivers/memory/samsung/exynos-srom.c
index 68e073c..96756fb 100644
--- a/drivers/memory/samsung/exynos-srom.c
+++ b/drivers/memory/samsung/exynos-srom.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -67,11 +68,50 @@ static struct exynos_srom_reg_dump *exynos_srom_alloc_reg_dump(
 	return rd;
 }
 
+static int exynos_srom_configure_bank(struct exynos_srom *srom,
+				      struct device_node *np)
+{
+	u32 bank, width, pmc = 0;
+	u32 timing[6];
+	u32 cs, bw;
+
+	if (of_property_read_u32(np, "reg", &bank))
+		return -EINVAL;
+	if (of_property_read_u32(np, "reg-io-width", &width))
+		width = 1;
+	if (of_property_read_bool(np, "samsung,srom-page-mode"))
+		pmc = 1 << EXYNOS_SROM_BCX__PMC__SHIFT;
+	if (of_property_read_u32_array(np, "samsung,srom-timing", timing,
+				       ARRAY_SIZE(timing)))
+		return -EINVAL;
+
+	bank *= 4; /* Convert bank into shift/offset */
+
+	cs = 1 << EXYNOS_SROM_BW__BYTEENABLE__SHIFT;
+	if (width == 2)
+		cs |= 1 << EXYNOS_SROM_BW__DATAWIDTH__SHIFT;
+
+	bw = __raw_readl(srom->reg_base + EXYNOS_SROM_BW);
+	bw = (bw & ~(EXYNOS_SROM_BW__CS_MASK << bank)) | (cs << bank);
+	__raw_writel(bw, srom->reg_base + EXYNOS_SROM_BW);
+
+	__raw_writel(pmc | (timing[0] << EXYNOS_SROM_BCX__TACP__SHIFT) |
+		    (timing[1] << EXYNOS_SROM_BCX__TCAH__SHIFT) |
+		    (timing[2] << EXYNOS_SROM_BCX__TCOH__SHIFT) |
+		    (timing[3] << EXYNOS_SROM_BCX__TACC__SHIFT) |
+		    (timing[4] << EXYNOS_SROM_BCX__TCOS__SHIFT) |
+		    (timing[5] << EXYNOS_SROM_BCX__TACS__SHIFT),
+		    srom->reg_base + EXYNOS_SROM_BC0 + bank);
+
+	return 0;
+}
+
 static int exynos_srom_probe(struct platform_device *pdev)
 {
-	struct device_node *np;
+	struct device_node *np, *child;
 	struct exynos_srom *srom;
 	struct device *dev = &pdev->dev;
+	bool bad_bank_config = false;
 
 	np = dev->of_node;
 	if (!np) {
@@ -100,7 +140,23 @@ static int exynos_srom_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	return 0;
+	for_each_child_of_node(np, child) {
+		if (exynos_srom_configure_bank(srom, child)) {
+			dev_err(dev,
+				"Could not decode bank configuration for %s\n",
+				child->name);
+			bad_bank_config = true;
+		}
+	}
+
+	/*
+	 * If any bank failed to configure, we still provide suspend/resume,
+	 * but do not probe child devices
+	 */
+	if (bad_bank_config)
+		return 0;
+
+	return of_platform_populate(np, NULL, NULL, dev);
 }
 
 static int exynos_srom_remove(struct platform_device *pdev)
-- 
2.4.5
