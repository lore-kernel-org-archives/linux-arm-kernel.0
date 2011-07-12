From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jul 2011 14:08:09 +0100
Subject: [PATCH 2/3] mach-ux500: export System-on-Chip information via sysfs
In-Reply-To: <1310476090-9807-1-git-send-email-lee.jones@linaro.org>
References: <1310476090-9807-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1310476090-9807-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/Kconfig |    1 +
 arch/arm/mach-ux500/id.c    |  115 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 4210cb4..4d2f2c2 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -26,6 +26,7 @@ config MACH_U8500
 	bool "U8500 Development platform"
 	depends on UX500_SOC_DB8500
 	select TPS6105X
+	select SYS_SOC
 	help
 	  Include support for the mop500 development platform.
 
diff --git a/arch/arm/mach-ux500/id.c b/arch/arm/mach-ux500/id.c
index d35122e..5156438 100644
--- a/arch/arm/mach-ux500/id.c
+++ b/arch/arm/mach-ux500/id.c
@@ -2,12 +2,16 @@
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
 
 #include <asm/cputype.h>
 #include <asm/tlbflush.h>
@@ -105,3 +109,114 @@ void __init ux500_map_io(void)
 
 	ux500_print_soc_info(asicid);
 }
+
+#ifdef CONFIG_SYS_SOC
+#define U8500_BB_UID_BASE (U8500_BACKUPRAM1_BASE + 0xFC0)
+#define U8500_BB_UID_LENGTH 5
+
+static struct device soc_parent;
+
+static ssize_t ux500_get_family(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	return sprintf(buf, "Ux500\n");
+}
+
+static ssize_t ux500_get_machine(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	return sprintf(buf, "DB%4x\n", dbx500_partnumber());
+}
+
+static ssize_t ux500_get_soc_id(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	void __iomem *uid_base;
+	int i;
+	ssize_t sz = 0;
+
+	if (dbx500_partnumber() == 0x8500) {
+		uid_base = __io_address(U8500_BB_UID_BASE);
+		for (i = 0; i < U8500_BB_UID_LENGTH; i++)
+			sz += sprintf(buf + sz, "%08x",
+				readl(uid_base + i * sizeof(u32)));
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
+				struct device_attribute *attr,
+				char *buf)
+{
+	unsigned int rev = dbx500_revision();
+
+	if (rev == 0x01)
+		return sprintf(buf, "%s\n", "ED");
+	else if (rev >= 0xA0)
+		return sprintf(buf, "%d.%d\n" ,
+			(rev >> 4) - 0xA + 1, rev & 0xf);
+
+	return sprintf(buf, "%s", "Unknown\n");
+}
+
+static ssize_t ux500_get_process(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	if (dbx500_id.process == 0x00)
+		return sprintf(buf, "Standard\n");
+
+	return sprintf(buf, "%02xnm\n", dbx500_id.process);
+}
+
+struct soc_callback_functions soc_callbacks = {
+	.get_machine_fn  = ux500_get_machine,
+	.get_family_fn   = ux500_get_family,
+	.get_soc_id_fn   = ux500_get_soc_id,
+	.get_revision_fn = ux500_get_revision,
+};
+
+struct device_attribute ux500_soc_attrs[] = {
+	__ATTR(process,  S_IRUGO, ux500_get_process,  NULL),
+	__ATTR_NULL,
+};
+
+static int __init ux500_soc_sysfs_init(void)
+{
+	int ret;
+	int i = 0;
+	ret = soc_device_register(&soc_parent,
+				  &soc_callbacks);
+	if (ret >= 0) {
+		while (ux500_soc_attrs[i].attr.name != NULL) {
+			ret = device_create_file(&soc_parent,
+						&ux500_soc_attrs[i++]);
+			if (ret)
+				goto out;
+		}
+	}
+ out:
+	return ret;
+}
+module_init(ux500_soc_sysfs_init);
+
+static void __exit ux500_soc_sysfs_exit(void)
+{
+	int i = 0;
+
+	while (ux500_soc_attrs[i].attr.name != NULL)
+		device_remove_file(&soc_parent, &ux500_soc_attrs[i++]);
+
+	soc_device_unregister(&soc_parent);
+}
+module_exit(ux500_soc_sysfs_exit);
+
+#endif
-- 
1.7.4.1
