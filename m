From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 22 Jan 2017 13:21:54 +0100
Subject: [PATCH 10/22] mtd: physmap_of: add a hook for Gemini flash probing
Message-ID: <20170122122154.10561-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support device tree probing of Gemini NOR flash
chips, a certain register in the syscon needs to be poked
to enable parallel flash mode.

Such things used to happen in "necessarily different" board
file code, and this indeed was also done for the Gemini, so
the MTD driver could treat it as any memory-mapped NOR flash,
but this is not the way in the future: board files need to
go, and hardware concerns distributed down to the applicable
drivers.

This adds a hook in the same way that the Versatile did: if
the Kconfig symbol is not selected the net total of supporting
Gemini should be zero bytes of added code. To live up to this
promise, also the return value error print from the Versatile
extra probe call get to be removed in this patch, all printing
need to happen in the add-ons.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
MTD maintainers: please just apply this to the MTD tree when
you are happy with it. It is functionally orthogonal to the rest
of the series and is just in the series for context.
---
 drivers/mtd/maps/Kconfig             |  10 +++
 drivers/mtd/maps/Makefile            |   3 +
 drivers/mtd/maps/physmap_of.c        |   9 ++-
 drivers/mtd/maps/physmap_of_gemini.c | 120 +++++++++++++++++++++++++++++++++++
 drivers/mtd/maps/physmap_of_gemini.h |  16 +++++
 5 files changed, 155 insertions(+), 3 deletions(-)
 create mode 100644 drivers/mtd/maps/physmap_of_gemini.c
 create mode 100644 drivers/mtd/maps/physmap_of_gemini.h

diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 5bcc896a48c3..e9206060c598 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -84,6 +84,16 @@ config MTD_PHYSMAP_OF_VERSATILE
 	  platforms, basically to add a VPP (write protection) callback so
 	  the flash can be taken out of write protection.
 
+config MTD_PHYSMAP_OF_GEMINI
+	bool "Support Gemini physmap OF"
+	depends on MTD_PHYSMAP_OF
+	depends on MFD_SYSCON
+	default ARCH_GEMINI
+	help
+	  This provides some extra DT physmap parsing for the Gemini
+	  platforms, some detection and setting up parallel mode on the
+	  external interface.
+
 config MTD_PMC_MSP_EVM
 	tristate "CFI Flash device mapped on PMC-Sierra MSP"
 	depends on PMC_MSP && MTD_CFI
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index 644f7d36d35d..36fe05ec9fab 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -21,6 +21,9 @@ obj-$(CONFIG_MTD_PHYSMAP_OF)	+= physmap_of.o
 ifdef CONFIG_MTD_PHYSMAP_OF_VERSATILE
 obj-$(CONFIG_MTD_PHYSMAP_OF)	+= physmap_of_versatile.o
 endif
+ifdef CONFIG_MTD_PHYSMAP_OF_GEMINI
+obj-$(CONFIG_MTD_PHYSMAP_OF)	+= physmap_of_gemini.o
+endif
 obj-$(CONFIG_MTD_PISMO)		+= pismo.o
 obj-$(CONFIG_MTD_PMC_MSP_EVM)   += pmcmsp-flash.o
 obj-$(CONFIG_MTD_PCMCIA)	+= pcmciamtd.o
diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.c
index 3fad35942895..14e8909c9955 100644
--- a/drivers/mtd/maps/physmap_of.c
+++ b/drivers/mtd/maps/physmap_of.c
@@ -24,6 +24,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/slab.h>
+#include "physmap_of_gemini.h"
 #include "physmap_of_versatile.h"
 
 struct of_flash_list {
@@ -241,11 +242,13 @@ static int of_flash_probe(struct platform_device *dev)
 		info->list[i].map.size = res_size;
 		info->list[i].map.bankwidth = be32_to_cpup(width);
 		info->list[i].map.device_node = dp;
+
+		err = of_flash_probe_gemini(dev, dp, &info->list[i].map);
+		if (err)
+			return err;
 		err = of_flash_probe_versatile(dev, dp, &info->list[i].map);
-		if (err) {
-			dev_err(&dev->dev, "Can't probe Versatile VPP\n");
+		if (err)
 			return err;
-		}
 
 		err = -ENOMEM;
 		info->list[i].map.virt = ioremap(info->list[i].map.phys,
diff --git a/drivers/mtd/maps/physmap_of_gemini.c b/drivers/mtd/maps/physmap_of_gemini.c
new file mode 100644
index 000000000000..1d60ef779b99
--- /dev/null
+++ b/drivers/mtd/maps/physmap_of_gemini.c
@@ -0,0 +1,120 @@
+/*
+ * Cortina Systems Gemini OF physmap add-on
+ * Copyright (C) 2017 Linus Walleij <linus.walleij@linaro.org>
+ *
+ * This SoC has an elaborate flash control register, so we need to
+ * detect and set it up when booting on this platform.
+ */
+#include <linux/export.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/mtd/map.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/bitops.h>
+#include "physmap_of_gemini.h"
+
+/*
+ * The Flash-relevant parts of the global status register
+ * These would also be relevant for a NAND driver.
+ */
+#define GLOBAL_STATUS			0x04
+#define FLASH_TYPE_MASK			(0x3 << 24)
+#define FLASH_TYPE_NAND_2K		(0x3 << 24)
+#define FLASH_TYPE_NAND_512		(0x2 << 24)
+#define FLASH_TYPE_PARALLEL		(0x1 << 24)
+#define FLASH_TYPE_SERIAL		(0x0 << 24)
+/* if parallel */
+#define FLASH_WIDTH_16BIT		(1 << 23)	/* else 8 bit */
+/* if serial */
+#define FLASH_ATMEL			(1 << 23)	/* else STM */
+
+#define FLASH_SIZE_MASK			(0x3 << 21)
+#define NAND_256M			(0x3 << 21)	/* and more */
+#define NAND_128M			(0x2 << 21)
+#define NAND_64M			(0x1 << 21)
+#define NAND_32M			(0x0 << 21)
+#define ATMEL_16M			(0x3 << 21)	/* and more */
+#define ATMEL_8M			(0x2 << 21)
+#define ATMEL_4M_2M			(0x1 << 21)
+#define ATMEL_1M			(0x0 << 21)	/* and less */
+#define STM_32M				(1 << 22)	/* and more */
+#define STM_16M				(0 << 22)	/* and less */
+
+#define FLASH_PARALLEL_HIGH_PIN_CNT	(1 << 20)	/* else low pin cnt */
+
+/* Miscellaneous Control Register */
+#define GLOBAL_MISC_CTRL		0x30
+#define FLASH_PADS_MASK			0x07
+#define NAND_PADS_DISABLE		BIT(2)
+#define PFLASH_PADS_DISABLE		BIT(1)
+#define SFLASH_PADS_DISABLE		BIT(0)
+
+static const struct of_device_id syscon_match[] = {
+	{ .compatible = "cortina,gemini-syscon" },
+	{ },
+};
+
+int of_flash_probe_gemini(struct platform_device *pdev,
+			  struct device_node *np,
+			  struct map_info *map)
+{
+	static struct regmap *rmap;
+	struct device *dev = &pdev->dev;
+	u32 val;
+	int ret;
+
+	/* Multiplatform guard */
+	if (!of_device_is_compatible(np, "cortina,gemini-flash"))
+		return 0;
+
+	rmap = syscon_regmap_lookup_by_phandle(np, "syscon");
+	if (IS_ERR(rmap)) {
+		dev_err(dev, "no syscon\n");
+		return PTR_ERR(rmap);
+	}
+
+	ret = regmap_read(rmap, GLOBAL_STATUS, &val);
+	if (ret) {
+		dev_err(dev, "failed to read global status register\n");
+		return -ENODEV;
+	}
+	dev_info(dev, "global status reg: %08x\n", val);
+
+	/*
+	 * It would be contradictory if a physmap flash was NOT parallel.
+	 */
+	if ((val & FLASH_TYPE_MASK) != FLASH_TYPE_PARALLEL) {
+		dev_err(dev, "flash is not parallel\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * Complain if DT data and hardware definition is different.
+	 */
+	if (val & FLASH_WIDTH_16BIT) {
+		if (map->bankwidth != 2)
+			dev_warn(dev, "flash hardware say flash is 16 bit wide "
+				 "but DT says it is %d bits wide\n",
+				 map->bankwidth * 8);
+	} else {
+		if (map->bankwidth != 1)
+			dev_warn(dev, "flash hardware say flash is 8 bit wide "
+				 "but DT says it is %d bits wide\n",
+				 map->bankwidth * 8);
+	}
+
+	/* Activate parallel (NOR flash) mode */
+	ret = regmap_update_bits(rmap, GLOBAL_MISC_CTRL,
+				 FLASH_PADS_MASK,
+				 SFLASH_PADS_DISABLE | NAND_PADS_DISABLE);
+	if (ret) {
+		dev_err(dev, "unable to set up physmap pads\n");
+		return -ENODEV;
+	}
+
+	dev_info(&pdev->dev, "initialized Gemini-specific physmap control\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_flash_probe_gemini);
diff --git a/drivers/mtd/maps/physmap_of_gemini.h b/drivers/mtd/maps/physmap_of_gemini.h
new file mode 100644
index 000000000000..c675025288dd
--- /dev/null
+++ b/drivers/mtd/maps/physmap_of_gemini.h
@@ -0,0 +1,16 @@
+#include <linux/of.h>
+#include <linux/mtd/map.h>
+
+#ifdef CONFIG_MTD_PHYSMAP_OF_GEMINI
+int of_flash_probe_gemini(struct platform_device *pdev,
+			  struct device_node *np,
+			  struct map_info *map);
+#else
+static inline
+int of_flash_probe_gemini(struct platform_device *pdev,
+			  struct device_node *np,
+			  struct map_info *map)
+{
+	return 0;
+}
+#endif
-- 
2.9.3
