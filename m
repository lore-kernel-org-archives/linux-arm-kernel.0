From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon,  5 Dec 2011 20:32:49 +0000
Subject: [PATCH] ARM: S3C64XX: Add basic cpuidle driver
Message-ID: <1323117169-9817-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a very basic cpuidle driver for S3C64xx which merely drives the CPU
into IDLE mode. We could do this with pm_idle but the more modern idiom
is to use cpuidle and the intention is to go further and support STOP
and DEEP-STOP states in conjunction with the pm_domain framework.

The actual state entry code was lifted from Tomasz Figa's work on spica.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/Makefile  |    1 +
 arch/arm/mach-s3c64xx/cpuidle.c |   91 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s3c64xx/cpuidle.c

diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index e32093c..8f5574b 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_PM)		+= sleep.o
 obj-$(CONFIG_PM)		+= irq-pm.o
+obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 
 # Machine support
 
diff --git a/arch/arm/mach-s3c64xx/cpuidle.c b/arch/arm/mach-s3c64xx/cpuidle.c
new file mode 100644
index 0000000..625d2c7
--- /dev/null
+++ b/arch/arm/mach-s3c64xx/cpuidle.c
@@ -0,0 +1,91 @@
+/* linux/arch/arm/mach-s3c64xx/cpuidle.c
+ *
+ * Copyright (c) 2011 Wolfson Microelectronics, plc
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/cpuidle.h>
+#include <linux/io.h>
+#include <linux/export.h>
+#include <linux/time.h>
+
+#include <asm/proc-fns.h>
+
+#include <mach/map.h>
+
+#include <mach/regs-sys.h>
+#include <mach/regs-syscon-power.h>
+
+static int s3c64xx_enter_idle(struct cpuidle_device *dev,
+			      struct cpuidle_driver *drv,
+			      int index)
+{
+	struct timeval before, after;
+	unsigned long tmp;
+	int idle_time;
+
+	local_irq_disable();
+	do_gettimeofday(&before);
+
+	/* Setup PWRCFG to enter idle mode */
+	tmp = __raw_readl(S3C64XX_PWR_CFG);
+	tmp &= ~S3C64XX_PWRCFG_CFG_WFI_MASK;
+	tmp |= S3C64XX_PWRCFG_CFG_WFI_IDLE;
+	__raw_writel(tmp, S3C64XX_PWR_CFG);
+
+	cpu_do_idle();
+
+	do_gettimeofday(&after);
+	local_irq_enable();
+	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
+		    (after.tv_usec - before.tv_usec);
+
+	dev->last_residency = idle_time;
+	return index;
+}
+
+static struct cpuidle_state s3c64xx_cpuidle_set[] = {
+	[0] = {
+		.enter			= s3c64xx_enter_idle,
+		.exit_latency		= 1,
+		.target_residency	= 100000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "IDLE",
+		.desc			= "System active, ARM gated",
+	},
+};
+
+static struct cpuidle_driver s3c64xx_cpuidle_driver = {
+	.name		= "s3c64xx_cpuidle",
+	.owner		= THIS_MODULE,
+	.state_count	= ARRAY_SIZE(s3c64xx_cpuidle_set),
+};
+
+static struct cpuidle_device s3c64xx_cpuidle_device = {
+	.state_count	= ARRAY_SIZE(s3c64xx_cpuidle_set),
+};
+
+static int __init s3c64xx_init_cpuidle(void)
+{
+	int ret;
+
+	memcpy(s3c64xx_cpuidle_driver.states, s3c64xx_cpuidle_set,
+	       sizeof(s3c64xx_cpuidle_set));
+	cpuidle_register_driver(&s3c64xx_cpuidle_driver);
+
+	ret = cpuidle_register_device(&s3c64xx_cpuidle_device);
+	if (ret) {
+		pr_err("Failed to register cpuidle device: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+device_initcall(s3c64xx_init_cpuidle);
-- 
1.7.7.3
