From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 16 Feb 2017 11:31:06 +0100
Subject: [PATCH] ARM: at91: move SoC detection to its own driver
Message-ID: <20170216103106.8041-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To simplify machine init and as the soc_device struct is not used as the
parent for on-chip devices anymore, move SoC detection to its own driver.

Change in dmesg:
 - before:
DMA: preallocated 256 KiB pool for atomic coherent allocations
AT91: Detected SoC family: sama5d2
AT91: Detected SoC: sama5d27, revision 0
No ATAGs?
clocksource: tcb_clksrc: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 184217874325 ns
at_xdmac f0010000.dma-controller: 16 channels, mapped at 0xe085b000
SCSI subsystem initialized

 - after:
DMA: preallocated 256 KiB pool for atomic coherent allocations
No ATAGs?
clocksource: tcb_clksrc: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 184217874325 ns
at_xdmac f0010000.dma-controller: 16 channels, mapped at 0xe0859000
AT91: Detected SoC family: sama5d2
AT91: Detected SoC: sama5d27, revision 0
SCSI subsystem initialized

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/Makefile                     |   1 -
 arch/arm/mach-at91/at91rm9200.c                 |  15 +-
 arch/arm/mach-at91/at91sam9.c                   |  46 +----
 arch/arm/mach-at91/sama5.c                      |  52 +-----
 arch/arm/mach-at91/soc.c                        | 142 ---------------
 drivers/soc/Kconfig                             |   1 +
 drivers/soc/Makefile                            |   1 +
 drivers/soc/atmel/Kconfig                       |   6 +
 drivers/soc/atmel/Makefile                      |   1 +
 drivers/soc/atmel/soc.c                         | 231 ++++++++++++++++++++++++
 {arch/arm/mach-at91 => drivers/soc/atmel}/soc.h |   0
 11 files changed, 243 insertions(+), 253 deletions(-)
 delete mode 100644 arch/arm/mach-at91/soc.c
 create mode 100644 drivers/soc/atmel/Kconfig
 create mode 100644 drivers/soc/atmel/Makefile
 create mode 100644 drivers/soc/atmel/soc.c
 rename {arch/arm/mach-at91 => drivers/soc/atmel}/soc.h (100%)

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index c5bbf8bb8c0f..ae913484712e 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -1,7 +1,6 @@
 #
 # Makefile for the linux kernel.
 #
-obj-y		:= soc.o
 
 # CPU-specific support
 obj-$(CONFIG_SOC_AT91RM9200)	+= at91rm9200.o
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index d068ec3cd1f6..656ad409a253 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -14,23 +14,10 @@
 #include <asm/mach/arch.h>
 
 #include "generic.h"
-#include "soc.h"
-
-static const struct at91_soc rm9200_socs[] = {
-	AT91_SOC(AT91RM9200_CIDR_MATCH, 0, "at91rm9200 BGA", "at91rm9200"),
-	{ /* sentinel */ },
-};
 
 static void __init at91rm9200_dt_device_init(void)
 {
-	struct soc_device *soc;
-	struct device *soc_dev = NULL;
-
-	soc = at91_soc_init(rm9200_socs);
-	if (soc != NULL)
-		soc_dev = soc_device_to_device(soc);
-
-	of_platform_default_populate(NULL, NULL, soc_dev);
+	of_platform_default_populate(NULL, NULL, NULL);
 
 	at91rm9200_pm_init();
 }
diff --git a/arch/arm/mach-at91/at91sam9.c b/arch/arm/mach-at91/at91sam9.c
index ba28e9cc584d..b5280d42dece 100644
--- a/arch/arm/mach-at91/at91sam9.c
+++ b/arch/arm/mach-at91/at91sam9.c
@@ -14,54 +14,10 @@
 #include <asm/system_misc.h>
 
 #include "generic.h"
-#include "soc.h"
-
-static const struct at91_soc at91sam9_socs[] = {
-	AT91_SOC(AT91SAM9260_CIDR_MATCH, 0, "at91sam9260", NULL),
-	AT91_SOC(AT91SAM9261_CIDR_MATCH, 0, "at91sam9261", NULL),
-	AT91_SOC(AT91SAM9263_CIDR_MATCH, 0, "at91sam9263", NULL),
-	AT91_SOC(AT91SAM9G20_CIDR_MATCH, 0, "at91sam9g20", NULL),
-	AT91_SOC(AT91SAM9RL64_CIDR_MATCH, 0, "at91sam9rl64", NULL),
-	AT91_SOC(AT91SAM9G45_CIDR_MATCH, AT91SAM9M11_EXID_MATCH,
-		 "at91sam9m11", "at91sam9g45"),
-	AT91_SOC(AT91SAM9G45_CIDR_MATCH, AT91SAM9M10_EXID_MATCH,
-		 "at91sam9m10", "at91sam9g45"),
-	AT91_SOC(AT91SAM9G45_CIDR_MATCH, AT91SAM9G46_EXID_MATCH,
-		 "at91sam9g46", "at91sam9g45"),
-	AT91_SOC(AT91SAM9G45_CIDR_MATCH, AT91SAM9G45_EXID_MATCH,
-		 "at91sam9g45", "at91sam9g45"),
-	AT91_SOC(AT91SAM9X5_CIDR_MATCH, AT91SAM9G15_EXID_MATCH,
-		 "at91sam9g15", "at91sam9x5"),
-	AT91_SOC(AT91SAM9X5_CIDR_MATCH, AT91SAM9G35_EXID_MATCH,
-		 "at91sam9g35", "at91sam9x5"),
-	AT91_SOC(AT91SAM9X5_CIDR_MATCH, AT91SAM9X35_EXID_MATCH,
-		 "at91sam9x35", "at91sam9x5"),
-	AT91_SOC(AT91SAM9X5_CIDR_MATCH, AT91SAM9G25_EXID_MATCH,
-		 "at91sam9g25", "at91sam9x5"),
-	AT91_SOC(AT91SAM9X5_CIDR_MATCH, AT91SAM9X25_EXID_MATCH,
-		 "at91sam9x25", "at91sam9x5"),
-	AT91_SOC(AT91SAM9N12_CIDR_MATCH, AT91SAM9CN12_EXID_MATCH,
-		 "at91sam9cn12", "at91sam9n12"),
-	AT91_SOC(AT91SAM9N12_CIDR_MATCH, AT91SAM9N12_EXID_MATCH,
-		 "at91sam9n12", "at91sam9n12"),
-	AT91_SOC(AT91SAM9N12_CIDR_MATCH, AT91SAM9CN11_EXID_MATCH,
-		 "at91sam9cn11", "at91sam9n12"),
-	AT91_SOC(AT91SAM9XE128_CIDR_MATCH, 0, "at91sam9xe128", "at91sam9xe128"),
-	AT91_SOC(AT91SAM9XE256_CIDR_MATCH, 0, "at91sam9xe256", "at91sam9xe256"),
-	AT91_SOC(AT91SAM9XE512_CIDR_MATCH, 0, "at91sam9xe512", "at91sam9xe512"),
-	{ /* sentinel */ },
-};
 
 static void __init at91sam9_common_init(void)
 {
-	struct soc_device *soc;
-	struct device *soc_dev = NULL;
-
-	soc = at91_soc_init(at91sam9_socs);
-	if (soc != NULL)
-		soc_dev = soc_device_to_device(soc);
-
-	of_platform_default_populate(NULL, NULL, soc_dev);
+	of_platform_default_populate(NULL, NULL, NULL);
 }
 
 static void __init at91sam9_dt_device_init(void)
diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
index b272c45b400f..6d157d0ead8e 100644
--- a/arch/arm/mach-at91/sama5.c
+++ b/arch/arm/mach-at91/sama5.c
@@ -15,60 +15,10 @@
 #include <asm/system_misc.h>
 
 #include "generic.h"
-#include "soc.h"
-
-static const struct at91_soc sama5_socs[] = {
-	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D21CU_EXID_MATCH,
-		 "sama5d21", "sama5d2"),
-	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D22CU_EXID_MATCH,
-		 "sama5d22", "sama5d2"),
-	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D23CU_EXID_MATCH,
-		 "sama5d23", "sama5d2"),
-	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D24CX_EXID_MATCH,
-		 "sama5d24", "sama5d2"),
-	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D24CU_EXID_MATCH,
-		 "sama5d24", "sama5d2"),
-	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D26CU_EXID_MATCH,
-		 "sama5d26", "sama5d2"),
-	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D27CU_EXID_MATCH,
-		 "sama5d27", "sama5d2"),
-	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D27CN_EXID_MATCH,
-		 "sama5d27", "sama5d2"),
-	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D28CU_EXID_MATCH,
-		 "sama5d28", "sama5d2"),
-	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D28CN_EXID_MATCH,
-		 "sama5d28", "sama5d2"),
-	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D31_EXID_MATCH,
-		 "sama5d31", "sama5d3"),
-	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D33_EXID_MATCH,
-		 "sama5d33", "sama5d3"),
-	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D34_EXID_MATCH,
-		 "sama5d34", "sama5d3"),
-	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D35_EXID_MATCH,
-		 "sama5d35", "sama5d3"),
-	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D36_EXID_MATCH,
-		 "sama5d36", "sama5d3"),
-	AT91_SOC(SAMA5D4_CIDR_MATCH, SAMA5D41_EXID_MATCH,
-		 "sama5d41", "sama5d4"),
-	AT91_SOC(SAMA5D4_CIDR_MATCH, SAMA5D42_EXID_MATCH,
-		 "sama5d42", "sama5d4"),
-	AT91_SOC(SAMA5D4_CIDR_MATCH, SAMA5D43_EXID_MATCH,
-		 "sama5d43", "sama5d4"),
-	AT91_SOC(SAMA5D4_CIDR_MATCH, SAMA5D44_EXID_MATCH,
-		 "sama5d44", "sama5d4"),
-	{ /* sentinel */ },
-};
 
 static void __init sama5_dt_device_init(void)
 {
-	struct soc_device *soc;
-	struct device *soc_dev = NULL;
-
-	soc = at91_soc_init(sama5_socs);
-	if (soc != NULL)
-		soc_dev = soc_device_to_device(soc);
-
-	of_platform_default_populate(NULL, NULL, soc_dev);
+	of_platform_default_populate(NULL, NULL, NULL);
 	sama5_pm_init();
 }
 
diff --git a/arch/arm/mach-at91/soc.c b/arch/arm/mach-at91/soc.c
deleted file mode 100644
index c6fda75ddb89..000000000000
--- a/arch/arm/mach-at91/soc.c
+++ /dev/null
@@ -1,142 +0,0 @@
-/*
- * Copyright (C) 2015 Atmel
- *
- * Alexandre Belloni <alexandre.belloni at free-electrons.com
- * Boris Brezillon <boris.brezillon@free-electrons.com
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
- */
-
-#define pr_fmt(fmt)	"AT91: " fmt
-
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
-#include <linux/slab.h>
-#include <linux/sys_soc.h>
-
-#include "soc.h"
-
-#define AT91_DBGU_CIDR			0x40
-#define AT91_DBGU_EXID			0x44
-#define AT91_CHIPID_CIDR		0x00
-#define AT91_CHIPID_EXID		0x04
-#define AT91_CIDR_VERSION(x)		((x) & 0x1f)
-#define AT91_CIDR_EXT			BIT(31)
-#define AT91_CIDR_MATCH_MASK		0x7fffffe0
-
-static int __init at91_get_cidr_exid_from_dbgu(u32 *cidr, u32 *exid)
-{
-	struct device_node *np;
-	void __iomem *regs;
-
-	np = of_find_compatible_node(NULL, NULL, "atmel,at91rm9200-dbgu");
-	if (!np)
-		np = of_find_compatible_node(NULL, NULL,
-					     "atmel,at91sam9260-dbgu");
-	if (!np)
-		return -ENODEV;
-
-	regs = of_iomap(np, 0);
-	of_node_put(np);
-
-	if (!regs) {
-		pr_warn("Could not map DBGU iomem range");
-		return -ENXIO;
-	}
-
-	*cidr = readl(regs + AT91_DBGU_CIDR);
-	*exid = readl(regs + AT91_DBGU_EXID);
-
-	iounmap(regs);
-
-	return 0;
-}
-
-static int __init at91_get_cidr_exid_from_chipid(u32 *cidr, u32 *exid)
-{
-	struct device_node *np;
-	void __iomem *regs;
-
-	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-chipid");
-	if (!np)
-		return -ENODEV;
-
-	regs = of_iomap(np, 0);
-	of_node_put(np);
-
-	if (!regs) {
-		pr_warn("Could not map DBGU iomem range");
-		return -ENXIO;
-	}
-
-	*cidr = readl(regs + AT91_CHIPID_CIDR);
-	*exid = readl(regs + AT91_CHIPID_EXID);
-
-	iounmap(regs);
-
-	return 0;
-}
-
-struct soc_device * __init at91_soc_init(const struct at91_soc *socs)
-{
-	struct soc_device_attribute *soc_dev_attr;
-	const struct at91_soc *soc;
-	struct soc_device *soc_dev;
-	u32 cidr, exid;
-	int ret;
-
-	/*
-	 * With SAMA5D2 and later SoCs, CIDR and EXID registers are no more
-	 * in the dbgu device but in the chipid device whose purpose is only
-	 * to expose these two registers.
-	 */
-	ret = at91_get_cidr_exid_from_dbgu(&cidr, &exid);
-	if (ret)
-		ret = at91_get_cidr_exid_from_chipid(&cidr, &exid);
-	if (ret) {
-		if (ret == -ENODEV)
-			pr_warn("Could not find identification node");
-		return NULL;
-	}
-
-	for (soc = socs; soc->name; soc++) {
-		if (soc->cidr_match != (cidr & AT91_CIDR_MATCH_MASK))
-			continue;
-
-		if (!(cidr & AT91_CIDR_EXT) || soc->exid_match == exid)
-			break;
-	}
-
-	if (!soc->name) {
-		pr_warn("Could not find matching SoC description\n");
-		return NULL;
-	}
-
-	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
-	if (!soc_dev_attr)
-		return NULL;
-
-	soc_dev_attr->family = soc->family;
-	soc_dev_attr->soc_id = soc->name;
-	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%X",
-					   AT91_CIDR_VERSION(cidr));
-	soc_dev = soc_device_register(soc_dev_attr);
-	if (IS_ERR(soc_dev)) {
-		kfree(soc_dev_attr->revision);
-		kfree(soc_dev_attr);
-		pr_warn("Could not register SoC device\n");
-		return NULL;
-	}
-
-	if (soc->family)
-		pr_info("Detected SoC family: %s\n", soc->family);
-	pr_info("Detected SoC: %s, revision %X\n", soc->name,
-		AT91_CIDR_VERSION(cidr));
-
-	return soc_dev;
-}
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index e6e90e80519a..d7728ad4574f 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -1,5 +1,6 @@
 menu "SOC (System On Chip) specific Drivers"
 
+source "drivers/soc/atmel/Kconfig"
 source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/fsl/qbman/Kconfig"
 source "drivers/soc/fsl/qe/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 50c23d0bd457..aca402073e7e 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the Linux Kernel SOC specific device drivers.
 #
 
+obj-$(CONFIG_ARCH_AT91)		+= atmel/
 obj-y				+= bcm/
 obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
diff --git a/drivers/soc/atmel/Kconfig b/drivers/soc/atmel/Kconfig
new file mode 100644
index 000000000000..6242ebb41abb
--- /dev/null
+++ b/drivers/soc/atmel/Kconfig
@@ -0,0 +1,6 @@
+config AT91_SOC_ID
+	bool "SoC bus for Atmel ARM SoCs"
+	depends on ARCH_AT91 || COMPILE_TEST
+	default ARCH_AT91
+	help
+	  Include support for the SoC bus on the Atmel ARM SoCs.
diff --git a/drivers/soc/atmel/Makefile b/drivers/soc/atmel/Makefile
new file mode 100644
index 000000000000..2d92f32e4ea5
--- /dev/null
+++ b/drivers/soc/atmel/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_AT91_SOC_ID) += soc.o
diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
new file mode 100644
index 000000000000..4790094b498e
--- /dev/null
+++ b/drivers/soc/atmel/soc.c
@@ -0,0 +1,231 @@
+/*
+ * Copyright (C) 2015 Atmel
+ *
+ * Alexandre Belloni <alexandre.belloni at free-electrons.com
+ * Boris Brezillon <boris.brezillon@free-electrons.com
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ */
+
+#define pr_fmt(fmt)	"AT91: " fmt
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+
+#include "soc.h"
+
+#define AT91_DBGU_CIDR			0x40
+#define AT91_DBGU_EXID			0x44
+#define AT91_CHIPID_CIDR		0x00
+#define AT91_CHIPID_EXID		0x04
+#define AT91_CIDR_VERSION(x)		((x) & 0x1f)
+#define AT91_CIDR_EXT			BIT(31)
+#define AT91_CIDR_MATCH_MASK		0x7fffffe0
+
+static const struct at91_soc __initconst socs[] = {
+#ifdef CONFIG_SOC_AT91RM9200
+	AT91_SOC(AT91RM9200_CIDR_MATCH, 0, "at91rm9200 BGA", "at91rm9200"),
+#endif
+#ifdef CONFIG_SOC_AT91SAM9
+	AT91_SOC(AT91SAM9260_CIDR_MATCH, 0, "at91sam9260", NULL),
+	AT91_SOC(AT91SAM9261_CIDR_MATCH, 0, "at91sam9261", NULL),
+	AT91_SOC(AT91SAM9263_CIDR_MATCH, 0, "at91sam9263", NULL),
+	AT91_SOC(AT91SAM9G20_CIDR_MATCH, 0, "at91sam9g20", NULL),
+	AT91_SOC(AT91SAM9RL64_CIDR_MATCH, 0, "at91sam9rl64", NULL),
+	AT91_SOC(AT91SAM9G45_CIDR_MATCH, AT91SAM9M11_EXID_MATCH,
+		 "at91sam9m11", "at91sam9g45"),
+	AT91_SOC(AT91SAM9G45_CIDR_MATCH, AT91SAM9M10_EXID_MATCH,
+		 "at91sam9m10", "at91sam9g45"),
+	AT91_SOC(AT91SAM9G45_CIDR_MATCH, AT91SAM9G46_EXID_MATCH,
+		 "at91sam9g46", "at91sam9g45"),
+	AT91_SOC(AT91SAM9G45_CIDR_MATCH, AT91SAM9G45_EXID_MATCH,
+		 "at91sam9g45", "at91sam9g45"),
+	AT91_SOC(AT91SAM9X5_CIDR_MATCH, AT91SAM9G15_EXID_MATCH,
+		 "at91sam9g15", "at91sam9x5"),
+	AT91_SOC(AT91SAM9X5_CIDR_MATCH, AT91SAM9G35_EXID_MATCH,
+		 "at91sam9g35", "at91sam9x5"),
+	AT91_SOC(AT91SAM9X5_CIDR_MATCH, AT91SAM9X35_EXID_MATCH,
+		 "at91sam9x35", "at91sam9x5"),
+	AT91_SOC(AT91SAM9X5_CIDR_MATCH, AT91SAM9G25_EXID_MATCH,
+		 "at91sam9g25", "at91sam9x5"),
+	AT91_SOC(AT91SAM9X5_CIDR_MATCH, AT91SAM9X25_EXID_MATCH,
+		 "at91sam9x25", "at91sam9x5"),
+	AT91_SOC(AT91SAM9N12_CIDR_MATCH, AT91SAM9CN12_EXID_MATCH,
+		 "at91sam9cn12", "at91sam9n12"),
+	AT91_SOC(AT91SAM9N12_CIDR_MATCH, AT91SAM9N12_EXID_MATCH,
+		 "at91sam9n12", "at91sam9n12"),
+	AT91_SOC(AT91SAM9N12_CIDR_MATCH, AT91SAM9CN11_EXID_MATCH,
+		 "at91sam9cn11", "at91sam9n12"),
+	AT91_SOC(AT91SAM9XE128_CIDR_MATCH, 0, "at91sam9xe128", "at91sam9xe128"),
+	AT91_SOC(AT91SAM9XE256_CIDR_MATCH, 0, "at91sam9xe256", "at91sam9xe256"),
+	AT91_SOC(AT91SAM9XE512_CIDR_MATCH, 0, "at91sam9xe512", "at91sam9xe512"),
+#endif
+#ifdef CONFIG_SOC_SAMA5
+	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D21CU_EXID_MATCH,
+		 "sama5d21", "sama5d2"),
+	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D22CU_EXID_MATCH,
+		 "sama5d22", "sama5d2"),
+	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D23CU_EXID_MATCH,
+		 "sama5d23", "sama5d2"),
+	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D24CX_EXID_MATCH,
+		 "sama5d24", "sama5d2"),
+	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D24CU_EXID_MATCH,
+		 "sama5d24", "sama5d2"),
+	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D26CU_EXID_MATCH,
+		 "sama5d26", "sama5d2"),
+	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D27CU_EXID_MATCH,
+		 "sama5d27", "sama5d2"),
+	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D27CN_EXID_MATCH,
+		 "sama5d27", "sama5d2"),
+	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D28CU_EXID_MATCH,
+		 "sama5d28", "sama5d2"),
+	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D28CN_EXID_MATCH,
+		 "sama5d28", "sama5d2"),
+	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D31_EXID_MATCH,
+		 "sama5d31", "sama5d3"),
+	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D33_EXID_MATCH,
+		 "sama5d33", "sama5d3"),
+	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D34_EXID_MATCH,
+		 "sama5d34", "sama5d3"),
+	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D35_EXID_MATCH,
+		 "sama5d35", "sama5d3"),
+	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D36_EXID_MATCH,
+		 "sama5d36", "sama5d3"),
+	AT91_SOC(SAMA5D4_CIDR_MATCH, SAMA5D41_EXID_MATCH,
+		 "sama5d41", "sama5d4"),
+	AT91_SOC(SAMA5D4_CIDR_MATCH, SAMA5D42_EXID_MATCH,
+		 "sama5d42", "sama5d4"),
+	AT91_SOC(SAMA5D4_CIDR_MATCH, SAMA5D43_EXID_MATCH,
+		 "sama5d43", "sama5d4"),
+	AT91_SOC(SAMA5D4_CIDR_MATCH, SAMA5D44_EXID_MATCH,
+		 "sama5d44", "sama5d4"),
+#endif
+	{ /* sentinel */ },
+};
+
+static int __init at91_get_cidr_exid_from_dbgu(u32 *cidr, u32 *exid)
+{
+	struct device_node *np;
+	void __iomem *regs;
+
+	np = of_find_compatible_node(NULL, NULL, "atmel,at91rm9200-dbgu");
+	if (!np)
+		np = of_find_compatible_node(NULL, NULL,
+					     "atmel,at91sam9260-dbgu");
+	if (!np)
+		return -ENODEV;
+
+	regs = of_iomap(np, 0);
+	of_node_put(np);
+
+	if (!regs) {
+		pr_warn("Could not map DBGU iomem range");
+		return -ENXIO;
+	}
+
+	*cidr = readl(regs + AT91_DBGU_CIDR);
+	*exid = readl(regs + AT91_DBGU_EXID);
+
+	iounmap(regs);
+
+	return 0;
+}
+
+static int __init at91_get_cidr_exid_from_chipid(u32 *cidr, u32 *exid)
+{
+	struct device_node *np;
+	void __iomem *regs;
+
+	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-chipid");
+	if (!np)
+		return -ENODEV;
+
+	regs = of_iomap(np, 0);
+	of_node_put(np);
+
+	if (!regs) {
+		pr_warn("Could not map DBGU iomem range");
+		return -ENXIO;
+	}
+
+	*cidr = readl(regs + AT91_CHIPID_CIDR);
+	*exid = readl(regs + AT91_CHIPID_EXID);
+
+	iounmap(regs);
+
+	return 0;
+}
+
+struct soc_device * __init at91_soc_init(const struct at91_soc *socs)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	const struct at91_soc *soc;
+	struct soc_device *soc_dev;
+	u32 cidr, exid;
+	int ret;
+
+	/*
+	 * With SAMA5D2 and later SoCs, CIDR and EXID registers are no more
+	 * in the dbgu device but in the chipid device whose purpose is only
+	 * to expose these two registers.
+	 */
+	ret = at91_get_cidr_exid_from_dbgu(&cidr, &exid);
+	if (ret)
+		ret = at91_get_cidr_exid_from_chipid(&cidr, &exid);
+	if (ret) {
+		if (ret == -ENODEV)
+			pr_warn("Could not find identification node");
+		return NULL;
+	}
+
+	for (soc = socs; soc->name; soc++) {
+		if (soc->cidr_match != (cidr & AT91_CIDR_MATCH_MASK))
+			continue;
+
+		if (!(cidr & AT91_CIDR_EXT) || soc->exid_match == exid)
+			break;
+	}
+
+	if (!soc->name) {
+		pr_warn("Could not find matching SoC description\n");
+		return NULL;
+	}
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return NULL;
+
+	soc_dev_attr->family = soc->family;
+	soc_dev_attr->soc_id = soc->name;
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%X",
+					   AT91_CIDR_VERSION(cidr));
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->revision);
+		kfree(soc_dev_attr);
+		pr_warn("Could not register SoC device\n");
+		return NULL;
+	}
+
+	if (soc->family)
+		pr_info("Detected SoC family: %s\n", soc->family);
+	pr_info("Detected SoC: %s, revision %X\n", soc->name,
+		AT91_CIDR_VERSION(cidr));
+
+	return soc_dev;
+}
+
+static int __init atmel_soc_device_init(void)
+{
+	at91_soc_init(socs);
+
+	return 0;
+}
+subsys_initcall(atmel_soc_device_init);
diff --git a/arch/arm/mach-at91/soc.h b/drivers/soc/atmel/soc.h
similarity index 100%
rename from arch/arm/mach-at91/soc.h
rename to drivers/soc/atmel/soc.h
-- 
2.11.0
