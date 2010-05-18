From: sundar.iyer@stericsson.com (Sundar Iyer)
Date: Tue, 18 May 2010 14:06:26 +0530
Subject: [PATCH 3/3] ux500: Add CPUFreq support
In-Reply-To: <1274171786-22990-1-git-send-email-sundar.iyer@stericsson.com>
References: <1274171786-22990-1-git-send-email-sundar.iyer@stericsson.com>
Message-ID: <1274171786-22990-4-git-send-email-sundar.iyer@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sundar R Iyer <sundar.iyer@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Sundar R Iyer <sundar.iyer@stericsson.com>
---
 arch/arm/mach-ux500/Kconfig                       |    1 +
 arch/arm/mach-ux500/Makefile                      |    2 +
 arch/arm/mach-ux500/include/mach/u8500-prcm-api.h |   21 ++++++
 arch/arm/mach-ux500/u8500-prcm.c                  |   74 +++++++++++++++++++++
 4 files changed, 98 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 6625e5b..2df43be 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -6,6 +6,7 @@ config UX500_SOC_COMMON
 	select ARM_GIC
 	select HAS_MTU
 	select NOMADIK_GPIO
+	select ARCH_HAS_CPUFREQ
 
 config UX500_SOC_DB8500
 	bool
diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index d3613ca..5afcd97 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -9,3 +9,5 @@ obj-$(CONFIG_MACH_U8500_MOP)	+= board-mop500.o
 obj-$(CONFIG_MACH_U5500)	+= board-u5500.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o localtimer.o
 obj-$(CONFIG_HOTPLUG_CPU)       += hotplug.o
+obj-$(CONFIG_CPU_FREQ)		+= cpufreq-ux500.o
+
diff --git a/arch/arm/mach-ux500/include/mach/u8500-prcm-api.h b/arch/arm/mach-ux500/include/mach/u8500-prcm-api.h
index 5f113c1..60a4281 100644
--- a/arch/arm/mach-ux500/include/mach/u8500-prcm-api.h
+++ b/arch/arm/mach-ux500/include/mach/u8500-prcm-api.h
@@ -9,13 +9,34 @@
  * U8500 PRCMU APIs
  */
 
+#ifndef __U8500_PRCM_API_H
+#define __U8500_PRCM_API_H
+
+/* PRCM take care to populate the frequencies */
+#include <linux/cpufreq.h>
+
+struct ux500_cpufreq_config {
+	int scaling_available_freqs;
+	struct cpufreq_frequency_table *cpu_freq_table;
+};
+
 /* ux500 subsystem */
 enum ux500_subsys {
 	SUBSYS_ARM,
 	SUBSYS_APE,
 };
 
+/* suported ARM OPPs */
+enum ux500_arm_opp {
+	ARM_OPP_INIT = 0x00,
+	ARM_NO_CHANGE = 0x01,
+	ARM_100_OPP = 0x02,
+	ARM_50_OPP = 0x03,
+	ARM_EXTCLK = 0x07
+};
+
 int prcm_set_subsys_opp(unsigned int subsys_opp_idx,
 		unsigned int subsys);
 int prcm_get_subsys_opp(unsigned int subsys);
 
+#endif /* __U8500_PRCM_API_H */
diff --git a/arch/arm/mach-ux500/u8500-prcm.c b/arch/arm/mach-ux500/u8500-prcm.c
index 2703768..b5be8aa 100644
--- a/arch/arm/mach-ux500/u8500-prcm.c
+++ b/arch/arm/mach-ux500/u8500-prcm.c
@@ -129,6 +129,71 @@ static irqreturn_t prcm_irq_handler (int irq, void *ctrlr)
 }
 
 /**
+ * ux500_prcm_register_device() - Register a device like cpufreq/cpuidle
+ * @dev_name: name of device to be registered
+ * @id: device id
+ * @priv_data: any private data for device
+ *
+ * This function creates and registers a platform device according to the
+ * name and id passed. The device can also be passed platform specific data
+ * this is very needed when client drivers handling SoC specific power mgmnt
+ * are dependent on this PRCM unit for operations.
+ */
+static int prcm_register_device(const char *dev_name, int id,
+		void *priv_data)
+{
+	int ret = 0;
+	struct platform_device *pdev;
+
+	pdev = platform_device_alloc(dev_name, id);
+	if (!pdev)
+		return -ENOMEM;
+
+	pdev->dev.platform_data = priv_data;
+
+	ret = platform_device_add(pdev);
+	if (ret != 0) {
+		printk(KERN_WARNING "Failed to register %s device\n",
+					 dev_name);
+		platform_device_put(pdev);
+		return ret;
+	}
+
+	return ret;
+}
+
+#ifdef CONFIG_CPU_FREQ
+/*
+ * We make a frequency table until we get the PRCM
+ * supporting us the dynamic table detection
+ */
+struct cpufreq_frequency_table db8500_freq_table[] = {
+	{
+		.index          = 0,
+		.frequency      = 200000,
+	},
+	{
+		.index          = 1,
+		.frequency      = 300000,
+	},
+	{
+		.index          = 2,
+		.frequency      = 600000,
+	},
+	{
+		.index          = 3,
+		.frequency      = CPUFREQ_TABLE_END,
+	},
+};
+
+/* wrap it up into a platform data */
+static struct ux500_cpufreq_config db8500_cpufreq_info = {
+	.scaling_available_freqs = ARRAY_SIZE(db8500_freq_table),
+	.cpu_freq_table = db8500_freq_table,
+};
+#endif
+
+/**
  * u8500_prcm_init() - U8500 PRCM driver init
  */
 static int u8500_prcm_init(void)
@@ -146,6 +211,15 @@ static int u8500_prcm_init(void)
 		return -ENODEV;
 	}
 
+#ifdef CONFIG_CPU_FREQ
+	/* register cpufreq device */
+	err = prcm_register_device("cpufreq-ux500", 0,
+			&db8500_cpufreq_info);
+	if (err < 0)
+		printk(KERN_ERR
+			"ux500-prcm: failed to register cpufreq-ux500\n");
+#endif
+
 	/*
 	 * clear all prcm interrupts.
 	 * possibly some transaction can happen (from u-boot)
-- 
1.6.3.3
