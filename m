From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Jun 2016 11:41:29 +0200
Subject: [PATCH 4/7] ARM: ux500: consolidate soc_device code in id.c
In-Reply-To: <20160624094132.1852086-1-arnd@arndb.de>
References: <20160624094132.1852086-1-arnd@arndb.de>
Message-ID: <20160624094132.1852086-5-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nothing else uses the global dbx500_asic_id structure, so
we can merge the two small files that reference it into one.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ux500/cache-l2x0.c |   1 -
 arch/arm/mach-ux500/cpu-db8500.c |  28 +---------
 arch/arm/mach-ux500/cpu.c        |  70 -------------------------
 arch/arm/mach-ux500/id.c         | 110 +++++++++++++++++++++++++++++++++++++--
 arch/arm/mach-ux500/id.h         |  37 -------------
 arch/arm/mach-ux500/platsmp.c    |   1 -
 arch/arm/mach-ux500/setup.h      |   4 +-
 7 files changed, 107 insertions(+), 144 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/id.h

diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index d7abc1187769..adec59cc2e1d 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -12,7 +12,6 @@
 #include <asm/hardware/cache-l2x0.h>
 
 #include "db8500-regs.h"
-#include "id.h"
 
 static int __init ux500_l2x0_unlock(void)
 {
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 3874e9c236e9..e7eba473d3bd 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -20,7 +20,6 @@
 #include <linux/of_platform.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/regulator/machine.h>
-#include <linux/random.h>
 
 #include <asm/mach/map.h>
 
@@ -60,31 +59,6 @@ static struct arm_pmu_platdata db8500_pmu_platdata = {
 	.handle_irq		= db8500_pmu_handler,
 };
 
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
-static struct device * __init db8500_soc_device_init(void)
-{
-	const char *soc_id = db8500_read_soc_id();
-
-	return ux500_soc_device_init(soc_id);
-}
-
 static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	/* Requires call-back bindings. */
 	OF_DEV_AUXDATA("arm,cortex-a9-pmu", 0, "arm-pmu", &db8500_pmu_platdata),
@@ -121,7 +95,7 @@ static const struct of_device_id u8500_local_bus_nodes[] = {
 
 static void __init u8500_init_machine(void)
 {
-	struct device *parent = db8500_soc_device_init();
+	struct device *parent = ux500_soc_device_init();
 
 	/* automatically probe child nodes of dbx5x0 devices */
 	if (of_machine_is_compatible("st-ericsson,u8540"))
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 63853e76a4e1..a34af283ee23 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -27,7 +27,6 @@
 
 #include "board-mop500.h"
 #include "db8500-regs.h"
-#include "id.h"
 
 void ux500_restart(enum reboot_mode mode, const char *cmd)
 {
@@ -66,72 +65,3 @@ void __init ux500_init_irq(void)
 	ux500_pm_init(r.start, r.end-r.start);
 	ux500_l2x0_init();
 }
-
-static const char * __init ux500_get_machine(void)
-{
-	return kasprintf(GFP_KERNEL, "DB%4x", dbx500_partnumber());
-}
-
-static const char * __init ux500_get_family(void)
-{
-	return kasprintf(GFP_KERNEL, "ux500");
-}
-
-static const char * __init ux500_get_revision(void)
-{
-	unsigned int rev = dbx500_revision();
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
-static void __init soc_info_populate(struct soc_device_attribute *soc_dev_attr,
-				     const char *soc_id)
-{
-	soc_dev_attr->soc_id   = soc_id;
-	soc_dev_attr->machine  = ux500_get_machine();
-	soc_dev_attr->family   = ux500_get_family();
-	soc_dev_attr->revision = ux500_get_revision();
-}
-
-static const struct device_attribute ux500_soc_attr =
-	__ATTR(process,  S_IRUGO, ux500_get_process,  NULL);
-
-struct device * __init ux500_soc_device_init(const char *soc_id)
-{
-	struct device *parent;
-	struct soc_device *soc_dev;
-	struct soc_device_attribute *soc_dev_attr;
-
-	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
-	if (!soc_dev_attr)
-		return ERR_PTR(-ENOMEM);
-
-	soc_info_populate(soc_dev_attr, soc_id);
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
diff --git a/arch/arm/mach-ux500/id.c b/arch/arm/mach-ux500/id.c
index 1e81e990044b..17f80ef44c58 100644
--- a/arch/arm/mach-ux500/id.c
+++ b/arch/arm/mach-ux500/id.c
@@ -8,6 +8,9 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
 
 #include <asm/cputype.h>
 #include <asm/tlbflush.h>
@@ -17,9 +20,20 @@
 #include "setup.h"
 
 #include "db8500-regs.h"
-#include "id.h"
 
-struct dbx500_asic_id dbx500_id;
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
 
 static unsigned int __init ux500_read_asicid(phys_addr_t addr)
 {
@@ -42,9 +56,9 @@ static unsigned int __init ux500_read_asicid(phys_addr_t addr)
 
 static void ux500_print_soc_info(unsigned int asicid)
 {
-	unsigned int rev = dbx500_revision();
+	unsigned int rev = dbx500_id.revision;
 
-	pr_info("DB%4x ", dbx500_partnumber());
+	pr_info("DB%4x ", dbx500_id.partnumber);
 
 	if (rev == 0x01)
 		pr_cont("Early Drop");
@@ -105,7 +119,7 @@ void __init ux500_setup_id(void)
 
 	if (!asicid) {
 		pr_err("Unable to identify SoC\n");
-		ux500_unknown_soc();
+		BUG();
 	}
 
 	dbx500_id.process = asicid >> 24;
@@ -114,3 +128,89 @@ void __init ux500_setup_id(void)
 
 	ux500_print_soc_info(asicid);
 }
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
+static const char *db8500_read_soc_id(void)
+{
+	void __iomem *uid;
+	const char *retstr;
+
+	uid = ioremap(U8500_BB_UID_BASE, 0x20);
+	if (!uid)
+		return NULL;
+	/* Throw these device-specific numbers into the entropy pool */
+	add_device_randomness(uid, 0x14);
+	retstr = kasprintf(GFP_KERNEL, "%08x%08x%08x%08x%08x",
+			 readl((u32 *)uid+0),
+			 readl((u32 *)uid+1), readl((u32 *)uid+2),
+			 readl((u32 *)uid+3), readl((u32 *)uid+4));
+	iounmap(uid);
+	return retstr;
+}
+
+static void __init soc_info_populate(struct soc_device_attribute *soc_dev_attr)
+{
+	soc_dev_attr->soc_id   = db8500_read_soc_id();
+	soc_dev_attr->machine  = ux500_get_machine();
+	soc_dev_attr->family   = ux500_get_family();
+	soc_dev_attr->revision = ux500_get_revision();
+}
+
+static const struct device_attribute ux500_soc_attr =
+	__ATTR(process,  S_IRUGO, ux500_get_process,  NULL);
+
+struct device * __init ux500_soc_device_init(void)
+{
+	struct device *parent;
+	struct soc_device *soc_dev;
+	struct soc_device_attribute *soc_dev_attr;
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return ERR_PTR(-ENOMEM);
+
+	soc_info_populate(soc_dev_attr);
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+	        kfree(soc_dev_attr);
+		return NULL;
+	}
+
+	parent = soc_device_to_device(soc_dev);
+	device_create_file(parent, &ux500_soc_attr);
+
+	return parent;
+}
diff --git a/arch/arm/mach-ux500/id.h b/arch/arm/mach-ux500/id.h
deleted file mode 100644
index 929f78ecf3df..000000000000
--- a/arch/arm/mach-ux500/id.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
- * License terms: GNU General Public License (GPL) version 2
- */
-
-#ifndef __MACH_UX500_ID
-#define __MACH_UX500_ID
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
-extern struct dbx500_asic_id dbx500_id;
-
-static inline unsigned int __attribute_const__ dbx500_partnumber(void)
-{
-	return dbx500_id.partnumber;
-}
-
-static inline unsigned int __attribute_const__ dbx500_revision(void)
-{
-	return dbx500_id.revision;
-}
-
-#define ux500_unknown_soc()	BUG()
-
-#endif
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 88b8ab4f300c..8f2f615ff958 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -26,7 +26,6 @@
 #include "setup.h"
 
 #include "db8500-regs.h"
-#include "id.h"
 
 /* Magic triggers in backup RAM */
 #define UX500_CPU1_JUMPADDR_OFFSET 0x1FF4
diff --git a/arch/arm/mach-ux500/setup.h b/arch/arm/mach-ux500/setup.h
index 8b44b646b191..1e9e7c55df75 100644
--- a/arch/arm/mach-ux500/setup.h
+++ b/arch/arm/mach-ux500/setup.h
@@ -19,11 +19,9 @@ void ux500_l2x0_init(void);
 
 void ux500_restart(enum reboot_mode mode, const char *cmd);
 
-void __init ux500_setup_id(void);
-
 extern void __init ux500_init_irq(void);
 
-extern struct device *ux500_soc_device_init(const char *soc_id);
+extern struct device *ux500_soc_device_init(void);
 
 extern void ux500_cpu_die(unsigned int cpu);
 
-- 
2.9.0
