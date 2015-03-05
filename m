From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  5 Mar 2015 13:11:22 +0100
Subject: [PATCH v2 5/9] ARM: at91: add soc detection infrastructure
In-Reply-To: <1425557486-3534-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425557486-3534-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1425557486-3534-6-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris BREZILLON <boris.brezillon@free-electrons.com>

Add new structures and functions to handle AT91 SoC detection.

[alexandre.belloni at free-electrons.com: reworked DBGU detection]
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 arch/arm/Kconfig            |   1 +
 arch/arm/mach-at91/Makefile |   2 +-
 arch/arm/mach-at91/soc.c    | 111 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/soc.h    |  48 +++++++++++++++++++
 4 files changed, 161 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-at91/soc.c
 create mode 100644 arch/arm/mach-at91/soc.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e7ce6612bc42..f6c5b05e8de8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -363,6 +363,7 @@ config ARCH_AT91
 	select IRQ_DOMAIN
 	select PINCTRL
 	select PINCTRL_AT91
+	select SOC_BUS
 	select USE_OF
 	help
 	  This enables support for systems based on Atmel
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 827fdbcce1c7..44a5c1a92b39 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-obj-y		:= setup.o
+obj-y		:= setup.o soc.o
 
 obj-$(CONFIG_SOC_AT91SAM9)	+= sam9_smc.o
 
diff --git a/arch/arm/mach-at91/soc.c b/arch/arm/mach-at91/soc.c
new file mode 100644
index 000000000000..227872246fd9
--- /dev/null
+++ b/arch/arm/mach-at91/soc.c
@@ -0,0 +1,111 @@
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
+#define AT91_DBGU_CIDR_ARCH(x)		(((x) >> 20) & 0xff)
+#define AT91_DBGU_CIDR_VERSION(x)	((x) & 0x1f)
+#define AT91_DBGU_CIDR_EXT		BIT(31)
+#define AT91_DBGU_CIDR_MATCH_MASK	0x7fffffe0
+#define AT91_DBGU_EXID			0x44
+
+struct soc_device * __init at91_soc_init(const struct at91_soc_family *families)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	const struct at91_soc_family *family;
+	const struct at91_soc *soc;
+	struct soc_device *soc_dev;
+	struct device_node *np;
+	void __iomem *regs;
+	u32 cidr, exid;
+
+
+	np = of_find_compatible_node(NULL, NULL, "atmel,at91rm9200-dbgu");
+	if (!np)
+		np = of_find_compatible_node(NULL, NULL,
+					     "atmel,at91sam9260-dbgu");
+
+	if (!np) {
+		pr_warn("Could not find DBGU node");
+		return NULL;
+	}
+
+	regs = of_iomap(np, 0);
+	of_node_put(np);
+
+	if (!regs) {
+		pr_warn("Could not map DBGU iomem range");
+		iounmap(regs);
+		return NULL;
+	}
+
+	cidr = readl(regs + AT91_DBGU_CIDR);
+	exid = readl(regs + AT91_DBGU_EXID);
+
+	iounmap(regs);
+
+	for (family = families; family->name; family++) {
+		if (family->id == AT91_DBGU_CIDR_ARCH(cidr))
+			break;
+	}
+
+	if (!family->name) {
+		pr_warn("Could not find matching SoC family\n");
+		return NULL;
+	}
+
+	for (soc = family->socs; soc->name; soc++) {
+		if (soc->cidr_match != (cidr & AT91_DBGU_CIDR_MATCH_MASK))
+			continue;
+
+		if (!(cidr & AT91_DBGU_CIDR_EXT) || soc->exid_match == exid)
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
+	soc_dev_attr->family = family->name;
+	soc_dev_attr->soc_id = soc->subname ? soc->subname : soc->name;
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%X",
+					   AT91_DBGU_CIDR_VERSION(cidr));
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->revision);
+		kfree(soc_dev_attr);
+		pr_warn("Could not register SoC device\n");
+		return NULL;
+	}
+
+	pr_info("Detected soc type: %s, revision %X\n", soc->name,
+		AT91_DBGU_CIDR_VERSION(cidr));
+	if (soc->subname)
+		pr_info("Detected soc subtype: %s\n", soc->subname);
+
+	return soc_dev;
+}
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
new file mode 100644
index 000000000000..66dcd146601a
--- /dev/null
+++ b/arch/arm/mach-at91/soc.h
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2015 Atmel
+ *
+ * Boris Brezillon <boris.brezillon@free-electrons.com
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ */
+
+#ifndef __AT91_SOC_H
+#define __AT91_SOC_H
+
+#include <linux/sys_soc.h>
+
+struct at91_soc {
+	u32 cidr_match;
+	u32 exid_match;
+	const char *name;
+	const char *subname;
+};
+
+struct at91_soc_family {
+	int id;
+	const char *name;
+	const struct at91_soc *socs;
+};
+
+#define AT91_SOC(__cidr, __exid, __name, __subname)		\
+	{							\
+		.cidr_match = (__cidr),				\
+		.exid_match = (__exid),				\
+		.name = (__name),				\
+		.subname = (__subname),				\
+	}
+
+#define AT91_SOC_FAMILY(__id, __name, __socs)			\
+	{							\
+		.id = (__id),					\
+		.name = (__name),				\
+		.socs = (__socs),				\
+	}
+
+struct soc_device * __init
+at91_soc_init(const struct at91_soc_family *families);
+
+#endif /* __AT91_SOC_H */
-- 
2.1.0
