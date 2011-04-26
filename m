From: snow.jhkim@gmail.com (JeongHyeon Kim)
Date: Tue, 26 Apr 2011 14:37:08 +0900
Subject: [PATCH] ARM: EXYNOS4: Add to support ORIGEN board
Message-ID: <1303796228-9729-1-git-send-email-snow.jhkim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: JeongHyeon Kim <jhkim@insignal.co.kr>

This patch adds to support Insignal's ORIGEN board.

Signed-off-by: JeongHyeon Kim <jhkim@insignal.co.kr>
---
 arch/arm/mach-exynos4/Kconfig       |   10 +++
 arch/arm/mach-exynos4/Makefile      |    1 +
 arch/arm/mach-exynos4/mach-origen.c |  108 +++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-exynos4/mach-origen.c

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index e849f67..0a61cf3 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -177,6 +177,16 @@ config MACH_NURI
 	help
 	  Machine support for Samsung Mobile NURI Board.
 
+config MACH_ORIGEN
+        bool "ORIGEN"
+        select CPU_EXYNOS4210
+        select S3C_DEV_RTC
+        select S3C_DEV_WDT
+        select S3C_DEV_HSMMC2
+        select EXYNOS4_SETUP_SDHCI
+        help
+          Machine support for ORIGEN based on Samsung S5PV310
+
 endmenu
 
 comment "Configuration for HSMMC bus width"
diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index 9be104f..681e01d 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_MACH_SMDKV310)		+= mach-smdkv310.o
 obj-$(CONFIG_MACH_ARMLEX4210)		+= mach-armlex4210.o
 obj-$(CONFIG_MACH_UNIVERSAL_C210)	+= mach-universal_c210.o
 obj-$(CONFIG_MACH_NURI)			+= mach-nuri.o
+obj-$(CONFIG_MACH_ORIGEN)		+= mach-origen.o
 
 # device support
 
diff --git a/arch/arm/mach-exynos4/mach-origen.c b/arch/arm/mach-exynos4/mach-origen.c
new file mode 100644
index 0000000..282de71
--- /dev/null
+++ b/arch/arm/mach-exynos4/mach-origen.c
@@ -0,0 +1,108 @@
+/* linux/arch/arm/mach-exynos4/mach-origen.c
+ *
+ * Copyright (c) 2011 Insignal Co., Ltd.
+ *              http://www.insignal.co.kr/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/serial_core.h>
+#include <linux/gpio.h>
+#include <linux/mmc/host.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/input.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+
+#include <plat/regs-serial.h>
+#include <plat/exynos4.h>
+#include <plat/cpu.h>
+#include <plat/devs.h>
+#include <plat/sdhci.h>
+#include <plat/iic.h>
+
+#include <mach/map.h>
+
+/* Following are default values for UCON, ULCON and UFCON UART registers */
+#define ORIGEN_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
+				 S3C2410_UCON_RXILEVEL |	\
+				 S3C2410_UCON_TXIRQMODE |	\
+				 S3C2410_UCON_RXIRQMODE |	\
+				 S3C2410_UCON_RXFIFO_TOI |	\
+				 S3C2443_UCON_RXERR_IRQEN)
+
+#define ORIGEN_ULCON_DEFAULT	S3C2410_LCON_CS8
+
+#define ORIGEN_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
+				 S5PV210_UFCON_TXTRIG4 |	\
+				 S5PV210_UFCON_RXTRIG4)
+
+static struct s3c2410_uartcfg origen_uartcfgs[] __initdata = {
+	[0] = {
+		.hwport		= 0,
+		.flags		= 0,
+		.ucon		= ORIGEN_UCON_DEFAULT,
+		.ulcon		= ORIGEN_ULCON_DEFAULT,
+		.ufcon		= ORIGEN_UFCON_DEFAULT,
+	},
+	[1] = {
+		.hwport		= 1,
+		.flags		= 0,
+		.ucon		= ORIGEN_UCON_DEFAULT,
+		.ulcon		= ORIGEN_ULCON_DEFAULT,
+		.ufcon		= ORIGEN_UFCON_DEFAULT,
+	},
+	[2] = {
+		.hwport		= 2,
+		.flags		= 0,
+		.ucon		= ORIGEN_UCON_DEFAULT,
+		.ulcon		= ORIGEN_ULCON_DEFAULT,
+		.ufcon		= ORIGEN_UFCON_DEFAULT,
+	},
+	[3] = {
+		.hwport		= 3,
+		.flags		= 0,
+		.ucon		= ORIGEN_UCON_DEFAULT,
+		.ulcon		= ORIGEN_ULCON_DEFAULT,
+		.ufcon		= ORIGEN_UFCON_DEFAULT,
+	},
+};
+
+static struct s3c_sdhci_platdata origen_hsmmc2_pdata __initdata = {
+	.cd_type		= S3C_SDHCI_CD_GPIO,
+	.ext_cd_gpio		= EXYNOS4_GPK2(2),
+	.ext_cd_gpio_invert	= 1,
+	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
+};
+
+static struct platform_device *origen_devices[] __initdata = {
+	&s3c_device_hsmmc2,
+	&s3c_device_rtc,
+	&s3c_device_wdt,
+};
+
+static void __init origen_map_io(void)
+{
+	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
+	s3c24xx_init_clocks(24000000);
+	s3c24xx_init_uarts(origen_uartcfgs, ARRAY_SIZE(origen_uartcfgs));
+}
+
+static void __init origen_machine_init(void)
+{
+	s3c_sdhci2_set_platdata(&origen_hsmmc2_pdata);
+	platform_add_devices(origen_devices, ARRAY_SIZE(origen_devices));
+}
+
+MACHINE_START(ORIGEN, "ORIGEN")
+       /* Maintainer: JeongHyeon Kim <jhkim@insignal.co.kr> */
+	.boot_params	= S5P_PA_SDRAM + 0x100,
+	.init_irq	= exynos4_init_irq,
+	.map_io		= origen_map_io,
+	.init_machine	= origen_machine_init,
+	.timer		= &exynos4_timer,
+MACHINE_END
-- 
1.7.1
