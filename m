From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Dec 2017 00:19:08 +0100
Subject: [PATCH v2] soc: Add SoC driver for Gemini
Message-ID: <20171221231908.9664-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds an SoC driver for the Gemini. Currently there
is only one thing not fitting into any other framework,
and that is the bus arbitration setting.

All Gemini vendor trees seem to be setting this register to
exactly the same arbitration so we just add a small code
snippet to do this at subsys_init() time before any other
drivers kick in.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Add a multiplatform guard, bail out silently if we are not
  running on Gemini.

ARM SoC folks: please just apply this patch directly somewhere
if you're pleased with it, it is fully idependent.

Arnd wanted some rewording of the commit message but I can't
figure out what, please entertain yourself editing it any way
you like :)
---
 drivers/soc/Makefile            |  1 +
 drivers/soc/gemini/Makefile     |  2 ++
 drivers/soc/gemini/soc-gemini.c | 71 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)
 create mode 100644 drivers/soc/gemini/Makefile
 create mode 100644 drivers/soc/gemini/soc-gemini.c

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index deecb16e7256..342768df3530 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -9,6 +9,7 @@ obj-y				+= bcm/
 obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
+obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
 obj-$(CONFIG_ARCH_MXC)		+= imx/
 obj-$(CONFIG_SOC_XWAY)		+= lantiq/
 obj-y				+= mediatek/
diff --git a/drivers/soc/gemini/Makefile b/drivers/soc/gemini/Makefile
new file mode 100644
index 000000000000..8cbd1e45db78
--- /dev/null
+++ b/drivers/soc/gemini/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y	+= soc-gemini.o
diff --git a/drivers/soc/gemini/soc-gemini.c b/drivers/soc/gemini/soc-gemini.c
new file mode 100644
index 000000000000..642b96c91ad6
--- /dev/null
+++ b/drivers/soc/gemini/soc-gemini.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 Linaro Ltd.
+ *
+ * Author: Linus Walleij <linus.walleij@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/of.h>
+
+#define GLOBAL_WORD_ID				0x00
+#define GEMINI_GLOBAL_ARB1_CTRL			0x2c
+#define GEMINI_ARB1_BURST_MASK			GENMASK(21, 16)
+#define GEMINI_ARB1_BURST_SHIFT			16
+/* These all define the priority on the BUS2 backplane */
+#define GEMINI_ARB1_PRIO_MASK			GENMASK(9, 0)
+#define GEMINI_ARB1_DMAC_HIGH_PRIO		BIT(0)
+#define GEMINI_ARB1_IDE_HIGH_PRIO		BIT(1)
+#define GEMINI_ARB1_RAID_HIGH_PRIO		BIT(2)
+#define GEMINI_ARB1_SECURITY_HIGH_PRIO		BIT(3)
+#define GEMINI_ARB1_GMAC0_HIGH_PRIO		BIT(4)
+#define GEMINI_ARB1_GMAC1_HIGH_PRIO		BIT(5)
+#define GEMINI_ARB1_USB0_HIGH_PRIO		BIT(6)
+#define GEMINI_ARB1_USB1_HIGH_PRIO		BIT(7)
+#define GEMINI_ARB1_PCI_HIGH_PRIO		BIT(8)
+#define GEMINI_ARB1_TVE_HIGH_PRIO		BIT(9)
+
+#define GEMINI_DEFAULT_BURST_SIZE		0x20
+#define GEMINI_DEFAULT_PRIO			(GEMINI_ARB1_GMAC0_HIGH_PRIO | \
+						 GEMINI_ARB1_GMAC1_HIGH_PRIO)
+
+static int __init gemini_soc_init(void)
+{
+	struct regmap *map;
+	u32 rev;
+	u32 val;
+	int ret;
+
+	/* Multiplatform guard, only proceed on Gemini */
+	if (!of_machine_is_compatible("cortina,gemini"))
+		return 0;
+
+	map = syscon_regmap_lookup_by_compatible("cortina,gemini-syscon");
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+	ret = regmap_read(map, GLOBAL_WORD_ID, &rev);
+	if (ret)
+		return ret;
+
+	val = (GEMINI_DEFAULT_BURST_SIZE << GEMINI_ARB1_BURST_SHIFT) |
+		GEMINI_DEFAULT_PRIO;
+
+	/* Set up system arbitration */
+	regmap_update_bits(map,
+			   GEMINI_GLOBAL_ARB1_CTRL,
+			   GEMINI_ARB1_BURST_MASK | GEMINI_ARB1_PRIO_MASK,
+			   val);
+
+	pr_info("Gemini SoC %04x revision %02x, set arbitration %08x\n",
+		rev >> 8, rev & 0xff, val);
+
+	return 0;
+}
+subsys_initcall(gemini_soc_init);
-- 
2.14.3
