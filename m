From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Jun 2016 11:41:31 +0200
Subject: [PATCH 6/7] ARM: ux500: move soc_id driver to drivers/soc
In-Reply-To: <20160624094132.1852086-1-arnd@arndb.de>
References: <20160624094132.1852086-1-arnd@arndb.de>
Message-ID: <20160624094132.1852086-7-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
---
 arch/arm/mach-ux500/Makefile                       |  2 +-
 arch/arm/mach-ux500/cpu-db8500.c                   |  6 ++--
 arch/arm/mach-ux500/setup.h                        |  2 --
 drivers/soc/Kconfig                                |  1 +
 drivers/soc/Makefile                               |  1 +
 drivers/soc/ux500/Kconfig                          |  7 ++++
 .../id.c => drivers/soc/ux500/ux500-soc-id.c       | 39 +++++++++++++---------
 7 files changed, 36 insertions(+), 22 deletions(-)
 create mode 100644 drivers/soc/ux500/Kconfig
 rename arch/arm/mach-ux500/id.c => drivers/soc/ux500/ux500-soc-id.c (86%)

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
index 58547f48ebcd..f31bceb69c0d 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -9,6 +9,7 @@ source "drivers/soc/samsung/Kconfig"
 source "drivers/soc/sunxi/Kconfig"
 source "drivers/soc/tegra/Kconfig"
 source "drivers/soc/ti/Kconfig"
+source "drivers/soc/ux500/Kconfig"
 source "drivers/soc/versatile/Kconfig"
 
 endmenu
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index b75e3bd0a01e..50c23d0bd457 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -14,4 +14,5 @@ obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
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
diff --git a/arch/arm/mach-ux500/id.c b/drivers/soc/ux500/ux500-soc-id.c
similarity index 86%
rename from arch/arm/mach-ux500/id.c
rename to drivers/soc/ux500/ux500-soc-id.c
index 983004d0fef2..49a811edce25 100644
--- a/arch/arm/mach-ux500/id.c
+++ b/drivers/soc/ux500/ux500-soc-id.c
@@ -8,8 +8,11 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/random.h>
 #include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/sys_soc.h>
 
 #include <asm/cputype.h>
@@ -17,10 +20,6 @@
 #include <asm/cacheflush.h>
 #include <asm/mach/map.h>
 
-#include "setup.h"
-
-#include "db8500-regs.h"
-
 /**
  * struct dbx500_asic_id - fields of the ASIC ID
  * @process: the manufacturing process, 0x40 is 40 nm 0x00 is "standard"
@@ -157,27 +156,31 @@ static ssize_t ux500_get_process(struct device *dev,
 	return sprintf(buf, "%02xnm\n", dbx500_id.process);
 }
 
-static const char *db8500_read_soc_id(void)
+static const char *db8500_read_soc_id(struct device_node *backupram)
 {
+	void __iomem *base;
 	void __iomem *uid;
 	const char *retstr;
 
-	uid = ioremap(U8500_BB_UID_BASE, 0x20);
-	if (!uid)
+	base = of_iomap(backupram, 0);
+	if (!base)
 		return NULL;
+	uid = base + 0xfc0;
+
 	/* Throw these device-specific numbers into the entropy pool */
 	add_device_randomness(uid, 0x14);
 	retstr = kasprintf(GFP_KERNEL, "%08x%08x%08x%08x%08x",
 			 readl((u32 *)uid+0),
 			 readl((u32 *)uid+1), readl((u32 *)uid+2),
 			 readl((u32 *)uid+3), readl((u32 *)uid+4));
-	iounmap(uid);
+	iounmap(base);
 	return retstr;
 }
 
-static void __init soc_info_populate(struct soc_device_attribute *soc_dev_attr)
+static void __init soc_info_populate(struct soc_device_attribute *soc_dev_attr,
+				     struct device_node *backupram)
 {
-	soc_dev_attr->soc_id   = db8500_read_soc_id();
+	soc_dev_attr->soc_id   = db8500_read_soc_id(backupram);
 	soc_dev_attr->machine  = ux500_get_machine();
 	soc_dev_attr->family   = ux500_get_family();
 	soc_dev_attr->revision = ux500_get_revision();
@@ -186,28 +189,34 @@ static void __init soc_info_populate(struct soc_device_attribute *soc_dev_attr)
 static const struct device_attribute ux500_soc_attr =
 	__ATTR(process,  S_IRUGO, ux500_get_process,  NULL);
 
-struct device * __init ux500_soc_device_init(void)
+static int __init ux500_soc_device_init(void)
 {
 	struct device *parent;
 	struct soc_device *soc_dev;
 	struct soc_device_attribute *soc_dev_attr;
+	struct device_node *backupram;
+
+	backupram = of_find_compatible_node(NULL, NULL, "ste,dbx500-backupram");
+	if (!backupram)
+		return 0;
 
 	ux500_setup_id();
 
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
-	soc_info_populate(soc_dev_attr);
+	soc_info_populate(soc_dev_attr, backupram);
 
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
 	        kfree(soc_dev_attr);
-		return NULL;
+		return PTR_ERR(soc_dev);
 	}
 
 	parent = soc_device_to_device(soc_dev);
 	device_create_file(parent, &ux500_soc_attr);
 
-	return parent;
+	return 0;
 }
+subsys_initcall(ux500_soc_device_init);
-- 
2.9.0
