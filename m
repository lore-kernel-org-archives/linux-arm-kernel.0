From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Feb 2012 11:22:24 -0800
Subject: [PATCH 4/6] mach-ux500: export System-on-Chip information ux500 via
 sysfs
In-Reply-To: <1328556146-3730-1-git-send-email-lee.jones@linaro.org>
References: <1328556146-3730-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1328556146-3730-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we make use of the new System-On-Chip bus driver to export
vital SoC information out to userspace via sysfs. This patch
provides a data structure of strings to populate the base
nodes found in:

/sys/devices/soc[0|1|2|...]/[family|machine|revision|soc_id].

It also adds one more node as requested by ST-Ericsson.
'process' depicts the way in which the silicon was manufactured.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/Kconfig                    |    1 +
 arch/arm/mach-ux500/cpu-db5500.c               |   30 +++++++---
 arch/arm/mach-ux500/cpu-db8500.c               |   33 +++++++++--
 arch/arm/mach-ux500/cpu.c                      |   75 ++++++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/db8500-regs.h |    3 +
 arch/arm/mach-ux500/include/mach/setup.h       |    2 +
 6 files changed, 130 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index a3e0c86..ce8bac2 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -27,6 +27,7 @@ config MACH_U8500
 	bool "U8500 Development platform"
 	depends on UX500_SOC_DB8500
 	select TPS6105X
+	select SOC_BUS
 	help
 	  Include support for the mop500 development platform.
 
diff --git a/arch/arm/mach-ux500/cpu-db5500.c b/arch/arm/mach-ux500/cpu-db5500.c
index c402fd6..8f8acfd 100644
--- a/arch/arm/mach-ux500/cpu-db5500.c
+++ b/arch/arm/mach-ux500/cpu-db5500.c
@@ -212,18 +212,32 @@ static int usb_db5500_tx_dma_cfg[] = {
 	DB5500_DMA_DEV38_USB_OTG_OEP_8
 };
 
-struct device* __init u5500_init_devices(void)
+static const char *db5500_read_soc_id(void)
 {
-	/* FIXME: First parameter to be a real parent. */
-	db5500_add_gpios(NULL);
+	return kasprintf(GFP_KERNEL, "u5500 currently unsupported\n");
+}
+
+static struct device * __init db5500_soc_device_init(void)
+{
+	const char *soc_id = db5500_read_soc_id();
+
+	return ux500_soc_device_init(soc_id);
+}
+
+struct device * __init u5500_init_devices(void)
+{
+	struct device *parent;
+
+	parent = db5500_soc_device_init();
+
+	db5500_add_gpios(parent);
 	db5500_pmu_init();
-	db5500_dma_init(NULL);
-	db5500_add_rtc(NULL);
-	db5500_add_usb(NULL, usb_db5500_rx_dma_cfg, usb_db5500_tx_dma_cfg);
+	db5500_dma_init(parent);
+	db5500_add_rtc(parent);
+	db5500_add_usb(parent, usb_db5500_rx_dma_cfg, usb_db5500_tx_dma_cfg);
 
 	platform_add_devices(db5500_platform_devs,
 			     ARRAY_SIZE(db5500_platform_devs));
 
-	/* FIXME: Return value to be a real parent. */
-	return NULL;
+	return parent;
 }
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 1e8a2cb..afcde3d 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -24,6 +24,7 @@
 #include <mach/setup.h>
 #include <mach/devices.h>
 #include <mach/usb.h>
+#include <mach/db8500-regs.h>
 
 #include "devices-db8500.h"
 #include "ste-dma40-db8500.h"
@@ -164,18 +165,38 @@ static int usb_db8500_tx_dma_cfg[] = {
 	DB8500_DMA_DEV39_USB_OTG_OEP_8
 };
 
+static const char *db8500_read_soc_id(void)
+{
+	void __iomem *uid = __io_address(U8500_BB_UID_BASE);
+
+	return kasprintf(GFP_KERNEL, "%08x%08x%08x%08x%08x",
+			 readl((u32 *)uid+1),
+			 readl((u32 *)uid+1), readl((u32 *)uid+2),
+			 readl((u32 *)uid+3), readl((u32 *)uid+4));
+}
+
+static struct device * __init db8500_soc_device_init(void)
+{
+	const char *soc_id = db8500_read_soc_id();
+
+	return ux500_soc_device_init(soc_id);
+}
+
 /*
  * This function is called from the board init
  */
-struct device* __init u8500_init_devices(void)
+struct device * __init u8500_init_devices(void)
 {
-	db8500_add_rtc(NULL);
-	db8500_add_gpios(NULL);
-	db8500_add_usb(NULL, usb_db8500_rx_dma_cfg, usb_db8500_tx_dma_cfg);
+	struct device *parent;
+
+	parent = db8500_soc_device_init();
+
+	db8500_add_rtc(parent);
+	db8500_add_gpios(parent);
+	db8500_add_usb(parent, usb_db8500_rx_dma_cfg, usb_db8500_tx_dma_cfg);
 
 	platform_device_register_simple("cpufreq-u8500", -1, NULL, 0);
 	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
 
-	/* FIXME: Return value to be a real parent. */
-	return NULL;
+	return parent;
 }
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index f418574..055fb6e 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -2,6 +2,7 @@
  * Copyright (C) ST-Ericsson SA 2010
  *
  * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
+ * Author: Lee Jones <lee.jones@linaro.org> for ST-Ericsson
  * License terms: GNU General Public License (GPL) version 2
  */
 
@@ -11,6 +12,10 @@
 #include <linux/mfd/db8500-prcmu.h>
 #include <linux/mfd/db5500-prcmu.h>
 #include <linux/clksrc-dbx500-prcmu.h>
+#include <linux/sys_soc.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/stat.h>
 
 #include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
@@ -50,3 +55,73 @@ void __init ux500_init_irq(void)
 		db8500_prcmu_early_init();
 	clk_init();
 }
+
+static const char * __init ux500_get_machine(void)
+{
+	return kasprintf(GFP_KERNEL, "DB%4x", dbx500_partnumber());
+}
+
+static const char * __init ux500_get_family(void)
+{
+	return kasprintf(GFP_KERNEL, "ux500");
+}
+
+static const char * __init ux500_get_revision(void)
+{
+	unsigned int rev = dbx500_revision();
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
+static void __init soc_info_populate(struct soc_device_attribute *soc_dev_attr,
+				     const char *soc_id)
+{
+	soc_dev_attr->soc_id   = soc_id;
+	soc_dev_attr->machine  = ux500_get_machine();
+	soc_dev_attr->family   = ux500_get_family();
+	soc_dev_attr->revision = ux500_get_revision();
+}
+
+struct device_attribute ux500_soc_attr =
+	__ATTR(process,  S_IRUGO, ux500_get_process,  NULL);
+
+struct device * __init ux500_soc_device_init(const char *soc_id)
+{
+	struct device *parent;
+	struct soc_device *soc_dev;
+	struct soc_device_attribute *soc_dev_attr;
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return ERR_PTR(-ENOMEM);
+
+	soc_info_populate(soc_dev_attr, soc_id);
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR_OR_NULL(soc_dev)) {
+	        kfree(soc_dev_attr);
+		return NULL;
+	}
+
+	parent = soc_device_to_device(soc_dev);
+	if (!IS_ERR_OR_NULL(parent))
+		device_create_file(parent, &ux500_soc_attr);
+
+	return parent;
+}
diff --git a/arch/arm/mach-ux500/include/mach/db8500-regs.h b/arch/arm/mach-ux500/include/mach/db8500-regs.h
index 80e10f5..9ec20b9 100644
--- a/arch/arm/mach-ux500/include/mach/db8500-regs.h
+++ b/arch/arm/mach-ux500/include/mach/db8500-regs.h
@@ -161,4 +161,7 @@
 #define U8500_MODEM_BASE	0xe000000
 #define U8500_APE_BASE		0x6000000
 
+/* SoC identification number information */
+#define U8500_BB_UID_BASE      (U8500_BACKUPRAM1_BASE + 0xFC0)
+
 #endif
diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
index e46b8b1..74b43bb 100644
--- a/arch/arm/mach-ux500/include/mach/setup.h
+++ b/arch/arm/mach-ux500/include/mach/setup.h
@@ -27,6 +27,8 @@ extern void __init u5500_sdi_init(struct device *parent);
 
 extern void __init db5500_dma_init(struct device *parent);
 
+extern struct device *ux500_soc_device_init(const char *soc_id);
+
 /* We re-use nomadik_timer for this platform */
 extern void nmdk_timer_init(void);
 
-- 
1.7.5.4
