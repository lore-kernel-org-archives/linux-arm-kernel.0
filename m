From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 09 Mar 2011 16:17:39 +0100
Subject: [PATCH v2] ARM: S5P: Add platform helpers for camera
	GPIO	configuration
In-Reply-To: <01c701cbd975$c7dcd2d0$57967870$%kim@samsung.com>
References: <01c701cbd975$c7dcd2d0$57967870$%kim@samsung.com>
Message-ID: <1299683859-9242-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add functions for configuration of the parallel camera
bus pins on S5PV210 and Exynos4 SoC.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---

Hello,

this is a corrected version of platform helpers for the peripheral
parallel camera bus configuration in S5PV210 and Exynos4 SoCs.

Changes since v1:
- Renamed files: camera.h/camport.h, setup-camera.c/setup-fimc.c
- Replaced "camif" with "fimc" in function and data type names
- Removed driver strength setup (it turned out than only the clock
  source pin needed maximum driver strength on the test boards, 
  so I've moved its configuration to the board code)


Regards,
Sylwester Nawrocki
---
 arch/arm/mach-exynos4/Kconfig            |    5 +++
 arch/arm/mach-exynos4/Makefile           |    1 +
 arch/arm/mach-exynos4/setup-fimc.c       |   44 ++++++++++++++++++++++++++++++
 arch/arm/mach-s5pv210/Kconfig            |    5 +++
 arch/arm/mach-s5pv210/Makefile           |    1 +
 arch/arm/mach-s5pv210/setup-fimc.c       |   43 +++++++++++++++++++++++++++++
 arch/arm/plat-s5p/include/plat/camport.h |   28 +++++++++++++++++++
 7 files changed, 127 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-exynos4/setup-fimc.c
 create mode 100644 arch/arm/mach-s5pv210/setup-fimc.c
 create mode 100644 arch/arm/plat-s5p/include/plat/camport.h

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index ad03840..cfe8c33 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -71,6 +71,11 @@ config EXYNOS4_SETUP_SDHCI_GPIO
 	help
 	  Common setup code for SDHCI gpio.
 
+config EXYNOS4_SETUP_FIMC
+	bool
+	help
+	  Common setup code for the camera interfaces.
+
 # machine support
 
 menu "EXYNOS4 Machines"
diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index 0558235..57770d6 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -32,6 +32,7 @@ obj-y					+= dev-audio.o
 obj-$(CONFIG_EXYNOS4_DEV_PD)		+= dev-pd.o
 obj-$(CONFIG_EXYNOS4_DEV_SYSMMU)	+= dev-sysmmu.o
 
+obj-$(CONFIG_EXYNOS4_SETUP_FIMC)	+= setup-fimc.o
 obj-$(CONFIG_EXYNOS4_SETUP_I2C1)	+= setup-i2c1.o
 obj-$(CONFIG_EXYNOS4_SETUP_I2C2)	+= setup-i2c2.o
 obj-$(CONFIG_EXYNOS4_SETUP_I2C3)	+= setup-i2c3.o
diff --git a/arch/arm/mach-exynos4/setup-fimc.c b/arch/arm/mach-exynos4/setup-fimc.c
new file mode 100644
index 0000000..6a45078
--- /dev/null
+++ b/arch/arm/mach-exynos4/setup-fimc.c
@@ -0,0 +1,44 @@
+/*
+ * Copyright (C) 2011 Samsung Electronics Co., Ltd.
+ *
+ * Exynos4 camera interface GPIO configuration.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/gpio.h>
+#include <plat/gpio-cfg.h>
+#include <plat/camport.h>
+
+int exynos4_fimc_setup_gpio(enum s5p_camport_id id)
+{
+	u32 gpio8, gpio5;
+	u32 sfn;
+	int ret;
+
+	switch (id) {
+	case S5P_CAMPORT_A:
+		gpio8 = EXYNOS4_GPJ0(0); /* PCLK, VSYNC, HREF, DATA[0:4] */
+		gpio5 = EXYNOS4_GPJ1(0); /* DATA[5:7], CLKOUT, FIELD */
+		sfn = S3C_GPIO_SFN(2);
+		break;
+
+	case S5P_CAMPORT_B:
+		gpio8 = EXYNOS4_GPE0(0); /* DATA[0:7] */
+		gpio5 = EXYNOS4_GPE1(0); /* PCLK, VSYNC, HREF, CLKOUT, FIELD */
+		sfn = S3C_GPIO_SFN(3);
+		break;
+
+	default:
+		WARN(1, "Wrong camport id: %d\n", id);
+		return -EINVAL;
+	}
+
+	ret = s3c_gpio_cfgall_range(gpio8, 8, sfn, S3C_GPIO_PULL_UP);
+	if (ret)
+		return ret;
+
+	return s3c_gpio_cfgall_range(gpio5, 5, sfn, S3C_GPIO_PULL_UP);
+}
diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 53aabef..3b6d0d4 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -53,6 +53,11 @@ config S5PV210_SETUP_SDHCI_GPIO
 	help
 	  Common setup code for SDHCI gpio.
 
+config S5PV210_SETUP_FIMC
+	bool
+	help
+	  Common setup code for the camera interfaces.
+
 menu "S5PC110 Machines"
 
 config MACH_AQUILA
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index ff1a0db..11f1790 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -31,6 +31,7 @@ obj-y				+= dev-audio.o
 obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
 
 obj-$(CONFIG_S5PV210_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
+obj-$(CONFIG_S5PV210_SETUP_FIMC)	+= setup-fimc.o
 obj-$(CONFIG_S5PV210_SETUP_I2C1) 	+= setup-i2c1.o
 obj-$(CONFIG_S5PV210_SETUP_I2C2) 	+= setup-i2c2.o
 obj-$(CONFIG_S5PV210_SETUP_IDE)		+= setup-ide.o
diff --git a/arch/arm/mach-s5pv210/setup-fimc.c b/arch/arm/mach-s5pv210/setup-fimc.c
new file mode 100644
index 0000000..54cc5b1
--- /dev/null
+++ b/arch/arm/mach-s5pv210/setup-fimc.c
@@ -0,0 +1,43 @@
+/*
+ * Copyright (C) 2011 Samsung Electronics Co., Ltd.
+ *
+ * S5PV210 camera interface GPIO configuration.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/gpio.h>
+#include <plat/gpio-cfg.h>
+#include <plat/camport.h>
+
+int s5pv210_fimc_setup_gpio(enum s5p_camport_id id)
+{
+	u32 gpio8, gpio5;
+	int ret;
+
+	switch (id) {
+	case S5P_CAMPORT_A:
+		gpio8 = S5PV210_GPE0(0);
+		gpio5 = S5PV210_GPE1(0);
+		break;
+
+	case S5P_CAMPORT_B:
+		gpio8 = S5PV210_GPJ0(0);
+		gpio5 = S5PV210_GPJ1(0);
+		break;
+
+	default:
+		WARN(1, "Wrong camport id: %d\n", id);
+		return -EINVAL;
+	}
+
+	ret = s3c_gpio_cfgall_range(gpio8, 8, S3C_GPIO_SFN(2),
+				    S3C_GPIO_PULL_UP);
+	if (ret)
+		return ret;
+
+	return s3c_gpio_cfgall_range(gpio5, 5, S3C_GPIO_SFN(2),
+				     S3C_GPIO_PULL_UP);
+}
diff --git a/arch/arm/plat-s5p/include/plat/camport.h b/arch/arm/plat-s5p/include/plat/camport.h
new file mode 100644
index 0000000..71688c8
--- /dev/null
+++ b/arch/arm/plat-s5p/include/plat/camport.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright (C) 2011 Samsung Electronics Co., Ltd.
+ *
+ * S5P series camera interface helper functions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef PLAT_S5P_CAMPORT_H_
+#define PLAT_S5P_CAMPORT_H_ __FILE__
+
+enum s5p_camport_id {
+	S5P_CAMPORT_A,
+	S5P_CAMPORT_B,
+};
+
+/*
+ * The helper functions to configure GPIO for the camera parallel bus.
+ * The camera port can be multiplexed with any FIMC entity, even multiple
+ * FIMC entities are allowed to be attached to a single port simultaneously.
+ * These functions are to be used in the board setup code.
+ */
+int s5pv210_fimc_setup_gpio(enum s5p_camport_id id);
+int exynos4_fimc_setup_gpio(enum s5p_camport_id id);
+
+#endif
-- 
1.7.4.1
