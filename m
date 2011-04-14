From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 14 Apr 2011 15:49:51 +0100
Subject: [PATCH 2/3] mach-ux500: export System-on-Chip information via sysfs
In-Reply-To: <1302792592-17484-1-git-send-email-lee.jones@linaro.org>
References: <1302792592-17484-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1302792592-17484-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/Kconfig |    1 +
 arch/arm/mach-ux500/id.c    |   96 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index c6b2375..ffee422 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -25,6 +25,7 @@ config MACH_U8500
 	bool "U8500 Development platform"
 	depends on UX500_SOC_DB8500
 	select TPS6105X
+	select SYS_SOC
 	help
 	  Include support for the mop500 development platform.
 
diff --git a/arch/arm/mach-ux500/id.c b/arch/arm/mach-ux500/id.c
index d35122e..74492ee 100644
--- a/arch/arm/mach-ux500/id.c
+++ b/arch/arm/mach-ux500/id.c
@@ -2,12 +2,17 @@
  * Copyright (C) ST-Ericsson SA 2010
  *
  * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
+ * Author: Lee Jones <lee.jones@linaro.org> for ST-Ericsson
  * License terms: GNU General Public License (GPL) version 2
  */
 
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/sys_soc.h>
+#include <linux/slab.h>
+#include <linux/stat.h>
+#include <linux/platform_device.h>
 
 #include <asm/cputype.h>
 #include <asm/tlbflush.h>
@@ -105,3 +110,94 @@ void __init ux500_map_io(void)
 
 	ux500_print_soc_info(asicid);
 }
+
+#ifdef CONFIG_SYS_SOC
+#define U8500_BB_UID_BASE (U8500_BACKUPRAM1_BASE + 0xFC0)
+#define U8500_BB_UID_LENGTH 5
+
+static ssize_t ux500_get_family(struct device *dev,
+                                struct device_attribute *attr,
+                                char *buf)
+{
+	return sprintf(buf, "Ux500\n");
+}
+
+static ssize_t ux500_get_machine(struct device *dev,
+                                 struct device_attribute *attr,
+                                 char *buf)
+{
+	return sprintf(buf, "DB%4x\n", dbx500_partnumber());
+}
+
+static ssize_t ux500_get_soc_id(struct device *dev,
+                                struct device_attribute *attr,
+                                char *buf)
+{
+	void __iomem *uid_base;
+	int i;
+	ssize_t sz = 0;
+
+	if (dbx500_partnumber() == 0x8500) {
+		uid_base = __io_address(U8500_BB_UID_BASE);
+		for (i = 0; i < U8500_BB_UID_LENGTH; i++)
+			sz += sprintf(buf + sz, "%08x", readl(uid_base + i * sizeof(u32)));
+		sz += sprintf(buf + sz, "\n");
+	} else {
+		/* Don't know where it is located for U5500 */
+		sz = sprintf(buf, "N/A\n");
+	}
+
+	return sz;
+}
+
+static ssize_t ux500_get_revision(struct device *dev,
+                                  struct device_attribute *attr,
+                                  char *buf)
+{
+	unsigned int rev = dbx500_revision();
+
+	if (rev == 0x01)
+		return sprintf(buf, "%s\n", "ED");
+	else if (rev >= 0xA0)
+		return sprintf(buf, "%d.%d\n" , (rev >> 4) - 0xA + 1, rev & 0xf);
+
+	return sprintf(buf, "%s", "Unknown\n");
+}
+
+static ssize_t ux500_get_process(struct device *dev,
+                                 struct device_attribute *attr,
+                                 char *buf)
+{
+	if (dbx500_id.process == 0x00)
+		return sprintf(buf, "Standard\n");
+
+	return sprintf(buf, "%02xnm\n", dbx500_id.process);
+}
+
+struct device_attribute soc_one_attrs[] = {
+	__ATTR(machine,  S_IRUGO, ux500_get_machine,  NULL),
+	__ATTR(family,   S_IRUGO, ux500_get_family,   NULL),
+	__ATTR(soc_id,   S_IRUGO, ux500_get_soc_id,   NULL),
+	__ATTR(revision, S_IRUGO, ux500_get_revision, NULL),
+	__ATTR(process,  S_IRUGO, ux500_get_process,  NULL),
+	__ATTR_NULL,
+};
+
+struct device_attribute *each_soc_attrs[] = {
+	soc_one_attrs,
+	NULL,
+};
+
+static int __init ux500_soc_sysfs_init(void)
+{
+	return soc_device_register(each_soc_attrs, ARRAY_SIZE(each_soc_attrs));
+}
+module_init(ux500_soc_sysfs_init);
+
+static void __exit ux500_soc_sysfs_exit(void)
+{
+	return soc_device_unregister(each_soc_attrs, ARRAY_SIZE(each_soc_attrs));
+}
+module_exit(ux500_soc_sysfs_exit);
+
+#endif
-- 
1.7.4.1
