From: chlrbgh0@gmail.com (Kyuho Choi)
Date: Mon, 27 Sep 2010 01:32:33 +0900
Subject: [PATCH] ARM: S5PV210: Add Torbreck board support
Message-ID: <1285518753-30722-1-git-send-email-chlrbgh0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds to support Torbreck board of aESOP community using
Samsung S5PV210 SoC.

Signed-off-by: Kyuho Choi <chlrbgh0@gmail.com>
Signed-off-by: Hyunchul Ko <ghcstop@gmail.com>
---
 arch/arm/mach-s5pv210/Kconfig         |   18 +++++
 arch/arm/mach-s5pv210/Makefile        |    1 +
 arch/arm/mach-s5pv210/mach-torbreck.c |  133 +++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/mach-torbreck.c

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index d3a3895..c5ec466 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -139,6 +139,24 @@ config MACH_SMDKV210
 	help
 	  Machine support for Samsung SMDKV210
 
+config MACH_TORBRECK
+	bool "Torbreck"
+	select CPU_S5PV210
+	select ARCH_SPARSEMEM_ENABLE
+	select S3C_DEV_HSMMC
+	select S3C_DEV_HSMMC1
+	select S3C_DEV_HSMMC2
+	select S3C_DEV_HSMMC3
+	select S3C_DEV_I2C1
+	select S3C_DEV_I2C2
+	select S3C_DEV_RTC
+	select S3C_DEV_WDT
+	select S5PV210_SETUP_I2C1
+	select S5PV210_SETUP_I2C2
+	select S5PV210_SETUP_SDHCI
+	help
+	  Machine support for aESOP Torbreck
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 05048c5..927c2b7 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_MACH_AQUILA)	+= mach-aquila.o
 obj-$(CONFIG_MACH_SMDKV210)	+= mach-smdkv210.o
 obj-$(CONFIG_MACH_SMDKC110)	+= mach-smdkc110.o
 obj-$(CONFIG_MACH_GONI)		+= mach-goni.o
+obj-$(CONFIG_MACH_TORBRECK)	+= mach-torbreck.o
 
 # device support
 
diff --git a/arch/arm/mach-s5pv210/mach-torbreck.c b/arch/arm/mach-s5pv210/mach-torbreck.c
new file mode 100644
index 0000000..3142250
--- /dev/null
+++ b/arch/arm/mach-s5pv210/mach-torbreck.c
@@ -0,0 +1,133 @@
+/* linux/arch/arm/mach-s5pv210/mach-torbreck.c
+ *
+ * Copyright (c) 2010 aESOP Community
+ *		http://www.aesop.or.kr/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/serial_core.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/setup.h>
+#include <asm/mach-types.h>
+
+#include <mach/map.h>
+#include <mach/regs-clock.h>
+
+#include <plat/regs-serial.h>
+#include <plat/s5pv210.h>
+#include <plat/devs.h>
+#include <plat/cpu.h>
+#include <plat/iic.h>
+
+/* Following are default values for UCON, ULCON and UFCON UART registers */
+#define TORBRECK_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
+				 S3C2410_UCON_RXILEVEL |	\
+				 S3C2410_UCON_TXIRQMODE |	\
+				 S3C2410_UCON_RXIRQMODE |	\
+				 S3C2410_UCON_RXFIFO_TOI |	\
+				 S3C2443_UCON_RXERR_IRQEN)
+
+#define TORBRECK_ULCON_DEFAULT	S3C2410_LCON_CS8
+
+#define TORBRECK_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
+				 S5PV210_UFCON_TXTRIG4 |	\
+				 S5PV210_UFCON_RXTRIG4)
+
+static struct s3c2410_uartcfg torbreck_uartcfgs[] __initdata = {
+	[0] = {
+		.hwport		= 0,
+		.flags		= 0,
+		.ucon		= TORBRECK_UCON_DEFAULT,
+		.ulcon		= TORBRECK_ULCON_DEFAULT,
+		.ufcon		= TORBRECK_UFCON_DEFAULT,
+	},
+	[1] = {
+		.hwport		= 1,
+		.flags		= 0,
+		.ucon		= TORBRECK_UCON_DEFAULT,
+		.ulcon		= TORBRECK_ULCON_DEFAULT,
+		.ufcon		= TORBRECK_UFCON_DEFAULT,
+	},
+	[2] = {
+		.hwport		= 2,
+		.flags		= 0,
+		.ucon		= TORBRECK_UCON_DEFAULT,
+		.ulcon		= TORBRECK_ULCON_DEFAULT,
+		.ufcon		= TORBRECK_UFCON_DEFAULT,
+	},
+	[3] = {
+		.hwport		= 3,
+		.flags		= 0,
+		.ucon		= TORBRECK_UCON_DEFAULT,
+		.ulcon		= TORBRECK_ULCON_DEFAULT,
+		.ufcon		= TORBRECK_UFCON_DEFAULT,
+	},
+};
+
+static struct platform_device *torbreck_devices[] __initdata = {
+	&s5pv210_device_iis0,
+	&s3c_device_cfcon,
+	&s3c_device_hsmmc0,
+	&s3c_device_hsmmc1,
+	&s3c_device_hsmmc2,
+	&s3c_device_hsmmc3,
+	&s3c_device_i2c0,
+	&s3c_device_i2c1,
+	&s3c_device_i2c2,
+	&s3c_device_rtc,
+	&s3c_device_wdt,
+};
+
+static struct i2c_board_info torbreck_i2c_devs0[] __initdata = {
+	/* To Be Updated */
+};
+
+static struct i2c_board_info torbreck_i2c_devs1[] __initdata = {
+	/* To Be Updated */
+};
+
+static struct i2c_board_info torbreck_i2c_devs2[] __initdata = {
+	/* To Be Updated */
+};
+
+static void __init torbreck_map_io(void)
+{
+	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
+	s3c24xx_init_clocks(24000000);
+	s3c24xx_init_uarts(torbreck_uartcfgs, ARRAY_SIZE(torbreck_uartcfgs));
+}
+
+static void __init torbreck_machine_init(void)
+{
+	s3c_i2c0_set_platdata(NULL);
+	s3c_i2c1_set_platdata(NULL);
+	s3c_i2c2_set_platdata(NULL);
+	i2c_register_board_info(0, torbreck_i2c_devs0,
+			ARRAY_SIZE(torbreck_i2c_devs0));
+	i2c_register_board_info(1, torbreck_i2c_devs1,
+			ARRAY_SIZE(torbreck_i2c_devs1));
+	i2c_register_board_info(2, torbreck_i2c_devs2,
+			ARRAY_SIZE(torbreck_i2c_devs2));
+
+	platform_add_devices(torbreck_devices, ARRAY_SIZE(torbreck_devices));
+}
+
+MACHINE_START(TORBRECK, "TORBRECK")
+	/* Maintainer: Hyunchul Ko <ghcstop@gmail.com> */
+	.phys_io	= S3C_PA_UART & 0xfff00000,
+	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
+	.boot_params	= S5P_PA_SDRAM + 0x100,
+	.init_irq	= s5pv210_init_irq,
+	.map_io		= torbreck_map_io,
+	.init_machine	= torbreck_machine_init,
+	.timer		= &s3c24xx_timer,
+MACHINE_END
-- 
1.5.6.3
