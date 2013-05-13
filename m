From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 13 May 2013 21:07:27 +0400
Subject: [PATCH 05/15] ARM: clps711x: autcpu12: Special driver for handling
 memory is removed
In-Reply-To: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
References: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
Message-ID: <1368464857-5038-8-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provide migration to using "mtd-ram" driver instead of using
special driver for handling NVRAM memory.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/board-autcpu12.c        |  68 ++++++++++---
 arch/arm/mach-clps711x/include/mach/autcpu12.h |   2 -
 drivers/mtd/maps/Kconfig                       |   7 --
 drivers/mtd/maps/Makefile                      |   1 -
 drivers/mtd/maps/autcpu12-nvram.c              | 129 -------------------------
 5 files changed, 56 insertions(+), 151 deletions(-)
 delete mode 100644 drivers/mtd/maps/autcpu12-nvram.c

diff --git a/arch/arm/mach-clps711x/board-autcpu12.c b/arch/arm/mach-clps711x/board-autcpu12.c
index 3e22d0b..91a3ab5 100644
--- a/arch/arm/mach-clps711x/board-autcpu12.c
+++ b/arch/arm/mach-clps711x/board-autcpu12.c
@@ -27,6 +27,7 @@
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/mtd/physmap.h>
+#include <linux/mtd/plat-ram.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand-gpio.h>
 #include <linux/platform_device.h>
@@ -49,6 +50,9 @@
 /* NOR flash */
 #define AUTCPU12_FLASH_BASE	(CS0_PHYS_BASE)
 
+/* NVRAM */
+#define AUTCPU12_NVRAM_BASE	(CS1_PHYS_BASE + 0x02000000)
+
 /* SmartMedia flash */
 #define AUTCPU12_SMC_BASE	(CS1_PHYS_BASE + 0x06000000)
 #define AUTCPU12_SMC_SEL_BASE	(AUTCPU12_SMC_BASE + 0x10)
@@ -74,17 +78,6 @@ static struct resource autcpu12_cs8900_resource[] __initdata = {
 	DEFINE_RES_IRQ(AUTCPU12_CS8900_IRQ),
 };
 
-static struct resource autcpu12_nvram_resource[] __initdata = {
-	DEFINE_RES_MEM_NAMED(AUTCPU12_PHYS_NVRAM, SZ_128K, "SRAM"),
-};
-
-static struct platform_device autcpu12_nvram_pdev __initdata = {
-	.name		= "autcpu12_nvram",
-	.id		= -1,
-	.resource	= autcpu12_nvram_resource,
-	.num_resources	= ARRAY_SIZE(autcpu12_nvram_resource),
-};
-
 static struct resource autcpu12_nand_resource[] __initdata = {
 	DEFINE_RES_MEM(AUTCPU12_SMC_BASE, SZ_16),
 };
@@ -194,6 +187,57 @@ static struct platform_device autcpu12_flash_pdev __initdata = {
 	},
 };
 
+static struct resource autcpu12_nvram_resource[] __initdata = {
+	DEFINE_RES_MEM(AUTCPU12_NVRAM_BASE, 0),
+};
+
+static struct platdata_mtd_ram autcpu12_nvram_pdata = {
+	.bankwidth	= 4,
+};
+
+static struct platform_device autcpu12_nvram_pdev __initdata = {
+	.name		= "mtd-ram",
+	.id		= 0,
+	.resource	= autcpu12_nvram_resource,
+	.num_resources	= ARRAY_SIZE(autcpu12_nvram_resource),
+	.dev		= {
+		.platform_data	= &autcpu12_nvram_pdata,
+	},
+};
+
+static void __init autcpu12_nvram_init(void)
+{
+	void __iomem *nvram;
+	unsigned int save[2];
+	resource_size_t nvram_size = SZ_128K;
+
+	/*
+	 * Check for 32K/128K
+	 * Read ofs 0K
+	 * Read ofs 64K
+	 * Write complement to ofs 64K
+	 * Read and check result on ofs 0K
+	 * Restore contents
+	 */
+	nvram = ioremap(autcpu12_nvram_resource[0].start, SZ_128K);
+	if (nvram) {
+		save[0] = readl(nvram + 0);
+		save[1] = readl(nvram + SZ_64K);
+		writel(~save[0], nvram + SZ_64K);
+		if (readl(nvram + 0) != save[0]) {
+			writel(save[0], nvram + 0);
+			nvram_size = SZ_32K;
+		} else
+			writel(save[1], nvram + SZ_64K);
+		iounmap(nvram);
+
+		autcpu12_nvram_resource[0].end =
+			autcpu12_nvram_resource[0].start + nvram_size - 1;
+		platform_device_register(&autcpu12_nvram_pdev);
+	} else
+		pr_err("Failed to remap NVRAM resource\n");
+}
+
 static void __init autcpu12_init(void)
 {
 	clps711x_devices_init();
@@ -202,7 +246,7 @@ static void __init autcpu12_init(void)
 	platform_device_register_simple("cs89x0", 0, autcpu12_cs8900_resource,
 					ARRAY_SIZE(autcpu12_cs8900_resource));
 	platform_device_register(&autcpu12_mmgpio_pdev);
-	platform_device_register(&autcpu12_nvram_pdev);
+	autcpu12_nvram_init();
 }
 
 static void __init autcpu12_init_late(void)
diff --git a/arch/arm/mach-clps711x/include/mach/autcpu12.h b/arch/arm/mach-clps711x/include/mach/autcpu12.h
index 0db6f18..0e00148 100644
--- a/arch/arm/mach-clps711x/include/mach/autcpu12.h
+++ b/arch/arm/mach-clps711x/include/mach/autcpu12.h
@@ -31,8 +31,6 @@
 */
 #define AUTCPU12_PHYS_CHAR_LCD         	CS1_PHYS_BASE +0x00000000  /* physical */
 
-#define AUTCPU12_PHYS_NVRAM            	CS1_PHYS_BASE +0x02000000  /* physical */
-
 #define AUTCPU12_PHYS_CSAUX1           	CS1_PHYS_BASE +0x04000000  /* physical */
 
 #define AUTCPU12_PHYS_CAN              	CS1_PHYS_BASE +0x08000000  /* physical */
diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index bed9d58..8b27ca0 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -297,13 +297,6 @@ config MTD_IXP4XX
 	  IXDP425 and Coyote. If you have an IXP4xx based board and
 	  would like to use the flash chips on it, say 'Y'.
 
-config MTD_AUTCPU12
-	bool "NV-RAM mapping AUTCPU12 board"
-	depends on ARCH_AUTCPU12
-	help
-	  This enables access to the NV-RAM on autronix autcpu12 board.
-	  If you have such a board, say 'Y'.
-
 config MTD_IMPA7
 	tristate "JEDEC Flash device mapped on impA7"
 	depends on ARM && MTD_JEDECPROBE
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index 395a124..9fdbd4b 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -32,7 +32,6 @@ obj-$(CONFIG_MTD_VMAX)		+= vmax301.o
 obj-$(CONFIG_MTD_SCx200_DOCFLASH)+= scx200_docflash.o
 obj-$(CONFIG_MTD_SOLUTIONENGINE)+= solutionengine.o
 obj-$(CONFIG_MTD_PCI)		+= pci.o
-obj-$(CONFIG_MTD_AUTCPU12)	+= autcpu12-nvram.o
 obj-$(CONFIG_MTD_IMPA7)		+= impa7.o
 obj-$(CONFIG_MTD_UCLINUX)	+= uclinux.o
 obj-$(CONFIG_MTD_NETtel)	+= nettel.o
diff --git a/drivers/mtd/maps/autcpu12-nvram.c b/drivers/mtd/maps/autcpu12-nvram.c
deleted file mode 100644
index c3525d2..0000000
--- a/drivers/mtd/maps/autcpu12-nvram.c
+++ /dev/null
@@ -1,129 +0,0 @@
-/*
- * NV-RAM memory access on autcpu12
- * (C) 2002 Thomas Gleixner (gleixner at autronix.de)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#include <linux/err.h>
-#include <linux/sizes.h>
-
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/device.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/map.h>
-
-struct autcpu12_nvram_priv {
-	struct mtd_info *mtd;
-	struct map_info map;
-};
-
-static int autcpu12_nvram_probe(struct platform_device *pdev)
-{
-	map_word tmp, save0, save1;
-	struct resource *res;
-	struct autcpu12_nvram_priv *priv;
-
-	priv = devm_kzalloc(&pdev->dev,
-			    sizeof(struct autcpu12_nvram_priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	platform_set_drvdata(pdev, priv);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "failed to get memory resource\n");
-		return -ENOENT;
-	}
-
-	priv->map.bankwidth	= 4;
-	priv->map.phys		= res->start;
-	priv->map.size		= resource_size(res);
-	priv->map.virt = devm_ioremap_resource(&pdev->dev, res);
-	strcpy((char *)priv->map.name, res->name);
-	if (IS_ERR(priv->map.virt))
-		return PTR_ERR(priv->map.virt);
-
-	simple_map_init(&priv->map);
-
-	/*
-	 * Check for 32K/128K
-	 * read ofs 0
-	 * read ofs 0x10000
-	 * Write complement to ofs 0x100000
-	 * Read	and check result on ofs 0x0
-	 * Restore contents
-	 */
-	save0 = map_read(&priv->map, 0);
-	save1 = map_read(&priv->map, 0x10000);
-	tmp.x[0] = ~save0.x[0];
-	map_write(&priv->map, tmp, 0x10000);
-	tmp = map_read(&priv->map, 0);
-	/* if we find this pattern on 0x0, we have 32K size */
-	if (!map_word_equal(&priv->map, tmp, save0)) {
-		map_write(&priv->map, save0, 0x0);
-		priv->map.size = SZ_32K;
-	} else
-		map_write(&priv->map, save1, 0x10000);
-
-	priv->mtd = do_map_probe("map_ram", &priv->map);
-	if (!priv->mtd) {
-		dev_err(&pdev->dev, "probing failed\n");
-		return -ENXIO;
-	}
-
-	priv->mtd->owner	= THIS_MODULE;
-	priv->mtd->erasesize	= 16;
-	priv->mtd->dev.parent	= &pdev->dev;
-	if (!mtd_device_register(priv->mtd, NULL, 0)) {
-		dev_info(&pdev->dev,
-			 "NV-RAM device size %ldKiB registered on AUTCPU12\n",
-			 priv->map.size / SZ_1K);
-		return 0;
-	}
-
-	map_destroy(priv->mtd);
-	dev_err(&pdev->dev, "NV-RAM device addition failed\n");
-	return -ENOMEM;
-}
-
-static int autcpu12_nvram_remove(struct platform_device *pdev)
-{
-	struct autcpu12_nvram_priv *priv = platform_get_drvdata(pdev);
-
-	mtd_device_unregister(priv->mtd);
-	map_destroy(priv->mtd);
-
-	return 0;
-}
-
-static struct platform_driver autcpu12_nvram_driver = {
-	.driver		= {
-		.name	= "autcpu12_nvram",
-		.owner	= THIS_MODULE,
-	},
-	.probe		= autcpu12_nvram_probe,
-	.remove		= autcpu12_nvram_remove,
-};
-module_platform_driver(autcpu12_nvram_driver);
-
-MODULE_AUTHOR("Thomas Gleixner");
-MODULE_DESCRIPTION("autcpu12 NVRAM map driver");
-MODULE_LICENSE("GPL");
-- 
1.8.1.5
