From: p.fedin@samsung.com (Pavel Fedin)
Date: Mon, 26 Oct 2015 14:47:42 +0300
Subject: [PATCH 2/4] drivers: exynos-srom: Add support for bank configuration
In-Reply-To: <cover.1445859834.git.p.fedin@samsung.com>
References: <cover.1445859834.git.p.fedin@samsung.com>
Message-ID: <7ce074e2ca045f58f19cad1dfc205476535f16a2.1445859834.git.p.fedin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bindings are based on u-boot implementation, however they are stored in
subnodes, providing support for more than one bank.

Since the driver now does more than suspend-resume support, dependency on
CONFIG_PM is removed.

Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
---
 arch/arm/mach-exynos/Kconfig      |  2 +-
 drivers/soc/samsung/Kconfig       |  2 +-
 drivers/soc/samsung/exynos-srom.c | 42 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 43 insertions(+), 3 deletions(-)

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
index 57a232d..6c8c56a 100644
--- a/drivers/soc/samsung/exynos-srom.c
+++ b/drivers/soc/samsung/exynos-srom.c
@@ -67,9 +67,46 @@ static struct exynos_srom_reg_dump *exynos_srom_alloc_reg_dump(
 	return rd;
 }
 
+static int decode_sromc(struct exynos_srom *srom, struct device_node *np)
+{
+	u32 bank, width;
+	u32 timing[7];
+	u32 bw;
+
+	if (of_property_read_u32(np, "bank", &bank))
+		return -ENXIO;
+	if (of_property_read_u32(np, "width", &width))
+		width = 1;
+	if (of_property_read_u32_array(np, "srom-timing", timing, 7)) {
+		pr_err("Could not decode SROMC configuration\n");
+		return -ENXIO;
+	}
+
+	bank *= 4; /* Convert bank into shift/offset */
+
+	bw = 1 << EXYNOS_SROM_BW__BYTEENABLE__SHIFT;
+	if (width == 2)
+		bw |= 1 << EXYNOS_SROM_BW__DATAWIDTH__SHIFT;
+	bw <<= bank;
+	bw |= __raw_readl(srom->reg_base + EXYNOS_SROM_BW) &
+	      ~(EXYNOS_SROM_BW__CS_MASK << bank);
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
 
@@ -100,6 +137,9 @@ static int exynos_srom_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	for_each_child_of_node(np, child)
+		decode_sromc(srom, child);
+
 	return 0;
 }
 
-- 
2.4.4
