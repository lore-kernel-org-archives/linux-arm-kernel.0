From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  5 Jul 2016 14:45:09 +0200
Subject: [PATCH 10/11] ARM: ux500: move soc_id driver to drivers/soc
In-Reply-To: <1467722710-1577-1-git-send-email-linus.walleij@linaro.org>
References: <1467722710-1577-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1467722710-1577-10-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

As the ux500 id code is basically a standalone driver, we can move it
out of the arch code into drivers/soc/ux500.

This is a user-visible change, as it moves all the devices in sysfs
from /sys/devices/soc0/ to /sys/devices/ and leaves the soc0 node as a
separate device.

Originally the idea was to put all on-chip devices under the soc node,
and ux500 was the first platform to have this device, but later platforms
almost all didn't follow that pattern, so this makes the platform do
the same thing as everyone else.

Since the platform is really obsolete now, I am optimistic that nothing
will break after moving the devices around.

As the SoC driver no longer has access to the private header files,
I'm changing the code to instead look up the address of the backupram
from devicetree, which is a good idea anyway.

Finally, having a separate Kconfig symbol means the driver is now
optional and could even be a loadable module rather than always being
built-in if we allowed that for soc_device.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[Fixup mising Makefile, fixup BB_UID_BASE to fc0]
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/Makefile     |   2 +-
 arch/arm/mach-ux500/cpu-db8500.c |   6 +-
 arch/arm/mach-ux500/id.c         | 213 -------------------------------------
 arch/arm/mach-ux500/setup.h      |   2 -
 drivers/soc/Kconfig              |   1 +
 drivers/soc/Makefile             |   1 +
 drivers/soc/ux500/Kconfig        |   7 ++
 drivers/soc/ux500/Makefile       |   1 +
 drivers/soc/ux500/ux500-soc-id.c | 222 +++++++++++++++++++++++++++++++++++++++
 9 files changed, 235 insertions(+), 220 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/id.c
 create mode 100644 drivers/soc/ux500/Kconfig
 create mode 100644 drivers/soc/ux500/Makefile
 create mode 100644 drivers/soc/ux500/ux500-soc-id.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index ea8893fd128f..753d3eed1985 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel, U8500 machine.
 #
 
-obj-y				:= cpu.o id.o pm.o
+obj-y				:= cpu.o pm.o
 obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o
 obj-$(CONFIG_MACH_MOP500)	+= board-mop500-audio.o
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 881cafbc4d97..c9c9832f79e9 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -88,15 +88,13 @@ static const struct of_device_id u8500_local_bus_nodes[] = {
 
 static void __init u8500_init_machine(void)
 {
-	struct device *parent = ux500_soc_device_init();
-
 	/* automatically probe child nodes of dbx5x0 devices */
 	if (of_machine_is_compatible("st-ericsson,u8540"))
 		of_platform_populate(NULL, u8500_local_bus_nodes,
-				     u8540_auxdata_lookup, parent);
+				     u8540_auxdata_lookup, NULL);
 	else
 		of_platform_populate(NULL, u8500_local_bus_nodes,
-				     u8500_auxdata_lookup, parent);
+				     u8500_auxdata_lookup, NULL);
 }
 
 static const char * stericsson_dt_platform_compat[] = {
diff --git a/arch/arm/mach-ux500/id.c b/arch/arm/mach-ux500/id.c
deleted file mode 100644
index 983004d0fef2..000000000000
--- a/arch/arm/mach-ux500/id.c
+++ /dev/null
@@ -1,213 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
- * License terms: GNU General Public License (GPL) version 2
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/random.h>
-#include <linux/slab.h>
-#include <linux/sys_soc.h>
-
-#include <asm/cputype.h>
-#include <asm/tlbflush.h>
-#include <asm/cacheflush.h>
-#include <asm/mach/map.h>
-
-#include "setup.h"
-
-#include "db8500-regs.h"
-
-/**
- * struct dbx500_asic_id - fields of the ASIC ID
- * @process: the manufacturing process, 0x40 is 40 nm 0x00 is "standard"
- * @partnumber: hithereto 0x8500 for DB8500
- * @revision: version code in the series
- */
-struct dbx500_asic_id {
-	u16	partnumber;
-	u8	revision;
-	u8	process;
-};
-
-static struct dbx500_asic_id dbx500_id;
-
-static unsigned int __init ux500_read_asicid(phys_addr_t addr)
-{
-	void __iomem *virt = ioremap(addr, 4);
-	unsigned int asicid;
-
-	if (!virt)
-		return 0;
-
-	asicid = readl(virt);
-	iounmap(virt);
-
-	return asicid;
-}
-
-static void ux500_print_soc_info(unsigned int asicid)
-{
-	unsigned int rev = dbx500_id.revision;
-
-	pr_info("DB%4x ", dbx500_id.partnumber);
-
-	if (rev == 0x01)
-		pr_cont("Early Drop");
-	else if (rev >= 0xA0)
-		pr_cont("v%d.%d" , (rev >> 4) - 0xA + 1, rev & 0xf);
-	else
-		pr_cont("Unknown");
-
-	pr_cont(" [%#010x]\n", asicid);
-}
-
-static unsigned int partnumber(unsigned int asicid)
-{
-	return (asicid >> 8) & 0xffff;
-}
-
-/*
- * SOC		MIDR		ASICID ADDRESS		ASICID VALUE
- * DB8500ed	0x410fc090	0x9001FFF4		0x00850001
- * DB8500v1	0x411fc091	0x9001FFF4		0x008500A0
- * DB8500v1.1	0x411fc091	0x9001FFF4		0x008500A1
- * DB8500v2	0x412fc091	0x9001DBF4		0x008500B0
- * DB8520v2.2	0x412fc091	0x9001DBF4		0x008500B2
- * DB5500v1	0x412fc091	0x9001FFF4		0x005500A0
- * DB9540	0x413fc090	0xFFFFDBF4		0x009540xx
- */
-
-static void __init ux500_setup_id(void)
-{
-	unsigned int cpuid = read_cpuid_id();
-	unsigned int asicid = 0;
-	phys_addr_t addr = 0;
-
-	switch (cpuid) {
-	case 0x410fc090: /* DB8500ed */
-	case 0x411fc091: /* DB8500v1 */
-		addr = 0x9001FFF4;
-		break;
-
-	case 0x412fc091: /* DB8520 / DB8500v2 / DB5500v1 */
-		asicid = ux500_read_asicid(0x9001DBF4);
-		if (partnumber(asicid) == 0x8500 ||
-		    partnumber(asicid) == 0x8520)
-			/* DB8500v2 */
-			break;
-
-		/* DB5500v1 */
-		addr = 0x9001FFF4;
-		break;
-
-	case 0x413fc090: /* DB9540 */
-		addr = 0xFFFFDBF4;
-		break;
-	}
-
-	if (addr)
-		asicid = ux500_read_asicid(addr);
-
-	if (!asicid) {
-		pr_err("Unable to identify SoC\n");
-		BUG();
-	}
-
-	dbx500_id.process = asicid >> 24;
-	dbx500_id.partnumber = partnumber(asicid);
-	dbx500_id.revision = asicid & 0xff;
-
-	ux500_print_soc_info(asicid);
-}
-
-static const char * __init ux500_get_machine(void)
-{
-	return kasprintf(GFP_KERNEL, "DB%4x", dbx500_id.partnumber);
-}
-
-static const char * __init ux500_get_family(void)
-{
-	return kasprintf(GFP_KERNEL, "ux500");
-}
-
-static const char * __init ux500_get_revision(void)
-{
-	unsigned int rev = dbx500_id.revision;
-
-	if (rev == 0x01)
-		return kasprintf(GFP_KERNEL, "%s", "ED");
-	else if (rev >= 0xA0)
-		return kasprintf(GFP_KERNEL, "%d.%d",
-				 (rev >> 4) - 0xA + 1, rev & 0xf);
-
-	return kasprintf(GFP_KERNEL, "%s", "Unknown");
-}
-
-static ssize_t ux500_get_process(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	if (dbx500_id.process == 0x00)
-		return sprintf(buf, "Standard\n");
-
-	return sprintf(buf, "%02xnm\n", dbx500_id.process);
-}
-
-static const char *db8500_read_soc_id(void)
-{
-	void __iomem *uid;
-	const char *retstr;
-
-	uid = ioremap(U8500_BB_UID_BASE, 0x20);
-	if (!uid)
-		return NULL;
-	/* Throw these device-specific numbers into the entropy pool */
-	add_device_randomness(uid, 0x14);
-	retstr = kasprintf(GFP_KERNEL, "%08x%08x%08x%08x%08x",
-			 readl((u32 *)uid+0),
-			 readl((u32 *)uid+1), readl((u32 *)uid+2),
-			 readl((u32 *)uid+3), readl((u32 *)uid+4));
-	iounmap(uid);
-	return retstr;
-}
-
-static void __init soc_info_populate(struct soc_device_attribute *soc_dev_attr)
-{
-	soc_dev_attr->soc_id   = db8500_read_soc_id();
-	soc_dev_attr->machine  = ux500_get_machine();
-	soc_dev_attr->family   = ux500_get_family();
-	soc_dev_attr->revision = ux500_get_revision();
-}
-
-static const struct device_attribute ux500_soc_attr =
-	__ATTR(process,  S_IRUGO, ux500_get_process,  NULL);
-
-struct device * __init ux500_soc_device_init(void)
-{
-	struct device *parent;
-	struct soc_device *soc_dev;
-	struct soc_device_attribute *soc_dev_attr;
-
-	ux500_setup_id();
-
-	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
-	if (!soc_dev_attr)
-		return ERR_PTR(-ENOMEM);
-
-	soc_info_populate(soc_dev_attr);
-
-	soc_dev = soc_device_register(soc_dev_attr);
-	if (IS_ERR(soc_dev)) {
-	        kfree(soc_dev_attr);
-		return NULL;
-	}
-
-	parent = soc_device_to_device(soc_dev);
-	device_create_file(parent, &ux500_soc_attr);
-
-	return parent;
-}
diff --git a/arch/arm/mach-ux500/setup.h b/arch/arm/mach-ux500/setup.h
index 1e9e7c55df75..85b7819a40ab 100644
--- a/arch/arm/mach-ux500/setup.h
+++ b/arch/arm/mach-ux500/setup.h
@@ -21,8 +21,6 @@ void ux500_restart(enum reboot_mode mode, const char *cmd);
 
 extern void __init ux500_init_irq(void);
 
-extern struct device *ux500_soc_device_init(void);
-
 extern void ux500_cpu_die(unsigned int cpu);
 
 #endif /*  __ASM_ARCH_SETUP_H */
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index cb58ef0d9b2c..b9c1bf43ebec 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -10,6 +10,7 @@ source "drivers/soc/samsung/Kconfig"
 source "drivers/soc/sunxi/Kconfig"
 source "drivers/soc/tegra/Kconfig"
 source "drivers/soc/ti/Kconfig"
+source "drivers/soc/ux500/Kconfig"
 source "drivers/soc/versatile/Kconfig"
 
 endmenu
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 380230f03874..02359c95d7f3 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -15,4 +15,5 @@ obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
 obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-$(CONFIG_SOC_TI)		+= ti/
+obj-$(CONFIG_ARCH_U8500)	+= ux500/
 obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
diff --git a/drivers/soc/ux500/Kconfig b/drivers/soc/ux500/Kconfig
new file mode 100644
index 000000000000..025a44aef5db
--- /dev/null
+++ b/drivers/soc/ux500/Kconfig
@@ -0,0 +1,7 @@
+config UX500_SOC_ID
+	bool "SoC bus for ST-Ericsson ux500"
+	depends on ARCH_U8500 || COMPILE_TEST
+	default ARCH_U8500
+	help
+	  Include support for the SoC bus on the ARM RealView platforms
+	  providing some sysfs information about the ASIC variant.
diff --git a/drivers/soc/ux500/Makefile b/drivers/soc/ux500/Makefile
new file mode 100644
index 000000000000..0b87ad04b018
--- /dev/null
+++ b/drivers/soc/ux500/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_UX500_SOC_ID) += ux500-soc-id.o
diff --git a/drivers/soc/ux500/ux500-soc-id.c b/drivers/soc/ux500/ux500-soc-id.c
new file mode 100644
index 000000000000..6c1be74e5fcc
--- /dev/null
+++ b/drivers/soc/ux500/ux500-soc-id.c
@@ -0,0 +1,222 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/sys_soc.h>
+
+#include <asm/cputype.h>
+#include <asm/tlbflush.h>
+#include <asm/cacheflush.h>
+#include <asm/mach/map.h>
+
+/**
+ * struct dbx500_asic_id - fields of the ASIC ID
+ * @process: the manufacturing process, 0x40 is 40 nm 0x00 is "standard"
+ * @partnumber: hithereto 0x8500 for DB8500
+ * @revision: version code in the series
+ */
+struct dbx500_asic_id {
+	u16	partnumber;
+	u8	revision;
+	u8	process;
+};
+
+static struct dbx500_asic_id dbx500_id;
+
+static unsigned int __init ux500_read_asicid(phys_addr_t addr)
+{
+	void __iomem *virt = ioremap(addr, 4);
+	unsigned int asicid;
+
+	if (!virt)
+		return 0;
+
+	asicid = readl(virt);
+	iounmap(virt);
+
+	return asicid;
+}
+
+static void ux500_print_soc_info(unsigned int asicid)
+{
+	unsigned int rev = dbx500_id.revision;
+
+	pr_info("DB%4x ", dbx500_id.partnumber);
+
+	if (rev == 0x01)
+		pr_cont("Early Drop");
+	else if (rev >= 0xA0)
+		pr_cont("v%d.%d" , (rev >> 4) - 0xA + 1, rev & 0xf);
+	else
+		pr_cont("Unknown");
+
+	pr_cont(" [%#010x]\n", asicid);
+}
+
+static unsigned int partnumber(unsigned int asicid)
+{
+	return (asicid >> 8) & 0xffff;
+}
+
+/*
+ * SOC		MIDR		ASICID ADDRESS		ASICID VALUE
+ * DB8500ed	0x410fc090	0x9001FFF4		0x00850001
+ * DB8500v1	0x411fc091	0x9001FFF4		0x008500A0
+ * DB8500v1.1	0x411fc091	0x9001FFF4		0x008500A1
+ * DB8500v2	0x412fc091	0x9001DBF4		0x008500B0
+ * DB8520v2.2	0x412fc091	0x9001DBF4		0x008500B2
+ * DB5500v1	0x412fc091	0x9001FFF4		0x005500A0
+ * DB9540	0x413fc090	0xFFFFDBF4		0x009540xx
+ */
+
+static void __init ux500_setup_id(void)
+{
+	unsigned int cpuid = read_cpuid_id();
+	unsigned int asicid = 0;
+	phys_addr_t addr = 0;
+
+	switch (cpuid) {
+	case 0x410fc090: /* DB8500ed */
+	case 0x411fc091: /* DB8500v1 */
+		addr = 0x9001FFF4;
+		break;
+
+	case 0x412fc091: /* DB8520 / DB8500v2 / DB5500v1 */
+		asicid = ux500_read_asicid(0x9001DBF4);
+		if (partnumber(asicid) == 0x8500 ||
+		    partnumber(asicid) == 0x8520)
+			/* DB8500v2 */
+			break;
+
+		/* DB5500v1 */
+		addr = 0x9001FFF4;
+		break;
+
+	case 0x413fc090: /* DB9540 */
+		addr = 0xFFFFDBF4;
+		break;
+	}
+
+	if (addr)
+		asicid = ux500_read_asicid(addr);
+
+	if (!asicid) {
+		pr_err("Unable to identify SoC\n");
+		BUG();
+	}
+
+	dbx500_id.process = asicid >> 24;
+	dbx500_id.partnumber = partnumber(asicid);
+	dbx500_id.revision = asicid & 0xff;
+
+	ux500_print_soc_info(asicid);
+}
+
+static const char * __init ux500_get_machine(void)
+{
+	return kasprintf(GFP_KERNEL, "DB%4x", dbx500_id.partnumber);
+}
+
+static const char * __init ux500_get_family(void)
+{
+	return kasprintf(GFP_KERNEL, "ux500");
+}
+
+static const char * __init ux500_get_revision(void)
+{
+	unsigned int rev = dbx500_id.revision;
+
+	if (rev == 0x01)
+		return kasprintf(GFP_KERNEL, "%s", "ED");
+	else if (rev >= 0xA0)
+		return kasprintf(GFP_KERNEL, "%d.%d",
+				 (rev >> 4) - 0xA + 1, rev & 0xf);
+
+	return kasprintf(GFP_KERNEL, "%s", "Unknown");
+}
+
+static ssize_t ux500_get_process(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	if (dbx500_id.process == 0x00)
+		return sprintf(buf, "Standard\n");
+
+	return sprintf(buf, "%02xnm\n", dbx500_id.process);
+}
+
+static const char *db8500_read_soc_id(struct device_node *backupram)
+{
+	void __iomem *base;
+	void __iomem *uid;
+	const char *retstr;
+
+	base = of_iomap(backupram, 0);
+	if (!base)
+		return NULL;
+	uid = base + 0x1fc0;
+
+	/* Throw these device-specific numbers into the entropy pool */
+	add_device_randomness(uid, 0x14);
+	retstr = kasprintf(GFP_KERNEL, "%08x%08x%08x%08x%08x",
+			 readl((u32 *)uid+0),
+			 readl((u32 *)uid+1), readl((u32 *)uid+2),
+			 readl((u32 *)uid+3), readl((u32 *)uid+4));
+	iounmap(base);
+	return retstr;
+}
+
+static void __init soc_info_populate(struct soc_device_attribute *soc_dev_attr,
+				     struct device_node *backupram)
+{
+	soc_dev_attr->soc_id   = db8500_read_soc_id(backupram);
+	soc_dev_attr->machine  = ux500_get_machine();
+	soc_dev_attr->family   = ux500_get_family();
+	soc_dev_attr->revision = ux500_get_revision();
+}
+
+static const struct device_attribute ux500_soc_attr =
+	__ATTR(process,  S_IRUGO, ux500_get_process,  NULL);
+
+static int __init ux500_soc_device_init(void)
+{
+	struct device *parent;
+	struct soc_device *soc_dev;
+	struct soc_device_attribute *soc_dev_attr;
+	struct device_node *backupram;
+
+	backupram = of_find_compatible_node(NULL, NULL, "ste,dbx500-backupram");
+	if (!backupram)
+		return 0;
+
+	ux500_setup_id();
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	soc_info_populate(soc_dev_attr, backupram);
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+	        kfree(soc_dev_attr);
+		return PTR_ERR(soc_dev);
+	}
+
+	parent = soc_device_to_device(soc_dev);
+	device_create_file(parent, &ux500_soc_attr);
+
+	return 0;
+}
+subsys_initcall(ux500_soc_device_init);
-- 
2.4.11
