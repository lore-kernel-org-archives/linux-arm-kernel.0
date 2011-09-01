From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  1 Sep 2011 13:27:21 +0100
Subject: [PATCH 3/5] mach-ux500: export System-on-Chip information ux500 via
	sysfs
In-Reply-To: <1314880043-22517-1-git-send-email-lee.jones@linaro.org>
References: <1314880043-22517-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1314880043-22517-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we make use of the new drivers/base/soc driver to export
vital SoC information out to userspace via sysfs. This patch
provides a data structure of strings to populate the base
nodes found in:

/sys/devices/soc/[1|2|3|...]/[family|machine|revision|soc_id].

It also adds one more node as requested by ST-Ericsson.
'process' depicts the way in which the silicon was manufactured.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/Kconfig              |    1 +
 arch/arm/mach-ux500/id.c                 |   77 ++++++++++++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/setup.h |    1 +
 3 files changed, 79 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 86188b2..fa70f65 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -27,6 +27,7 @@ config MACH_U8500
 	bool "U8500 Development platform"
 	depends on UX500_SOC_DB8500
 	select TPS6105X
+	select SYS_SOC
 	help
 	  Include support for the mop500 development platform.
 
diff --git a/arch/arm/mach-ux500/id.c b/arch/arm/mach-ux500/id.c
index d35122e..8fd53c7 100644
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
+#include <linux/platform_device.h>
 
 #include <asm/cputype.h>
 #include <asm/tlbflush.h>
@@ -105,3 +109,76 @@ void __init ux500_map_io(void)
 
 	ux500_print_soc_info(asicid);
 }
+
+struct soc_device *soc_dev;
+
+static const char *ux500_get_machine(void)
+{
+	return kasprintf(GFP_KERNEL, "DB%4x", dbx500_partnumber());
+}
+
+static const char *ux500_get_family(void)
+{
+	return kasprintf(GFP_KERNEL, "Ux500");
+}
+
+static const char *ux500_get_revision(void)
+{
+	unsigned int rev = dbx500_revision();
+
+	if (rev == 0x01) {
+		return kasprintf(GFP_KERNEL, "%s", "ED");
+	}
+	else if (rev >= 0xA0) {
+		return kasprintf(GFP_KERNEL, "%d.%d" , (rev >> 4) - 0xA + 1, rev & 0xf);
+	}
+
+	return kasprintf(GFP_KERNEL, "%s", "Unknown");
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
+static void soc_info_populate(struct soc_device *soc_dev)
+{
+	soc_dev->machine  = ux500_get_machine();
+	soc_dev->family   = ux500_get_family();
+	soc_dev->revision = ux500_get_revision();
+}
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
+
+	soc_dev = kzalloc(sizeof(*soc_dev), GFP_KERNEL);
+	if (soc_dev == NULL)
+		return -ENOMEM;
+
+	soc_info_populate(soc_dev);
+
+	ret = soc_device_register(&soc_dev->dev);
+
+	if (ret >= 0) {
+		while (ux500_soc_attrs[i].attr.name != NULL) {
+			ret = device_create_file(&soc_dev->dev, &ux500_soc_attrs[i++]);
+			if (ret)
+				goto out;
+		}
+	}
+out:
+	return ret;
+}
+postcore_initcall(ux500_soc_sysfs_init);
diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
index a7d363f..7d4c35f 100644
--- a/arch/arm/mach-ux500/include/mach/setup.h
+++ b/arch/arm/mach-ux500/include/mach/setup.h
@@ -35,6 +35,7 @@ extern void __init amba_add_devices(struct amba_device *devs[], int num);
 
 struct sys_timer;
 extern struct sys_timer ux500_timer;
+extern struct soc_device *soc_dev;
 
 #define __IO_DEV_DESC(x, sz)	{		\
 	.virtual	= IO_ADDRESS(x),	\
-- 
1.7.4.1
