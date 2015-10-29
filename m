From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 29 Oct 2015 15:42:19 +0300
Subject: [PATCH v4 3/4] drivers: exynos-srom: Add support for bank
 configuration
In-Reply-To: <cover.1446122247.git.p.fedin@samsung.com>
References: <cover.1446122247.git.p.fedin@samsung.com>
Message-ID: <4312ee676afb81377610ae05d0373ebd3b51ddde.1446122247.git.p.fedin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement handling properties in subnodes and adding child devices to the
system. Child devices will not be added if configuration fails.

Since the driver now does more than suspend-resume support, dependency on
CONFIG_PM is removed.

Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
---
 arch/arm/mach-exynos/Kconfig      |  2 +-
 drivers/soc/samsung/Kconfig       |  2 +-
 drivers/soc/samsung/exynos-srom.c | 58 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 83c85f5..c22dc42 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -16,7 +16,7 @@ menuconfig ARCH_EXYNOS
 	select ARM_GIC
 	select COMMON_CLK_SAMSUNG
 	select EXYNOS_THERMAL
-	select EXYNOS_SROM if PM
+	select EXYNOS_SROM
 	select HAVE_ARM_SCU if SMP
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index 2833b5b..ea4bc2a 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -8,6 +8,6 @@ config SOC_SAMSUNG
 
 config EXYNOS_SROM
 	bool
-	depends on ARM && ARCH_EXYNOS && PM
+	depends on ARM && ARCH_EXYNOS
 
 endmenu
diff --git a/drivers/soc/samsung/exynos-srom.c b/drivers/soc/samsung/exynos-srom.c
index 57a232d..68e894f 100644
--- a/drivers/soc/samsung/exynos-srom.c
+++ b/drivers/soc/samsung/exynos-srom.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -67,11 +68,48 @@ static struct exynos_srom_reg_dump *exynos_srom_alloc_reg_dump(
 	return rd;
 }
 
+static int decode_sromc(struct exynos_srom *srom, struct device_node *np)
+{
+	u32 bank, width;
+	u32 timing[7];
+	u32 cs, bw;
+
+	if (of_property_read_u32(np, "samsung,srom-bank", &bank))
+		return -EINVAL;
+	if (of_property_read_u32(np, "samsung,srom-data-width", &width))
+		width = 1;
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
+	__raw_writel((timing[0] << EXYNOS_SROM_BCX__PMC__SHIFT) |
+		    (timing[1] << EXYNOS_SROM_BCX__TACP__SHIFT) |
+		    (timing[2] << EXYNOS_SROM_BCX__TCAH__SHIFT) |
+		    (timing[3] << EXYNOS_SROM_BCX__TCOH__SHIFT) |
+		    (timing[4] << EXYNOS_SROM_BCX__TACC__SHIFT) |
+		    (timing[5] << EXYNOS_SROM_BCX__TCOS__SHIFT) |
+		    (timing[6] << EXYNOS_SROM_BCX__TACS__SHIFT),
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
+	bool error = false;
 
 	np = dev->of_node;
 	if (!np) {
@@ -100,7 +138,23 @@ static int exynos_srom_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	return 0;
+	for_each_child_of_node(np, child) {
+		if (decode_sromc(srom, child)) {
+			dev_err(dev,
+				"Could not decode bank configuration for %s\n",
+				child->name);
+			error = true;
+		}
+	}
+
+	/*
+	 * If any bank failed to configure, we still provide suspend/resume,
+	 * but do not probe child devices
+	 */
+	if (error)
+		return 0;
+
+	return of_platform_populate(np, NULL, NULL, dev);
 }
 
 static int exynos_srom_remove(struct platform_device *pdev)
-- 
2.4.4
