From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 13 May 2010 18:09:27 +0800
Subject: [PATCH] [ARM] pxa: append tavorevb3 support
Message-ID: <mailman.451.1274095126.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bringup tavorevb3 development platform. Only uart is enabled.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/Kconfig                   |    4 ++
 arch/arm/mach-pxa/Makefile                  |    1 +
 arch/arm/mach-pxa/include/mach/mfp-pxa930.h |    7 ++++
 arch/arm/mach-pxa/pxa930.c                  |    2 +-
 arch/arm/mach-pxa/tavorevb3.c               |   47 +++++++++++++++++++++++++++
 5 files changed, 60 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-pxa/tavorevb3.c

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 3b51741..10bf235 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -44,6 +44,10 @@ config MACH_TAVOREVB
 	select PXA3xx
 	select CPU_PXA930

+config MACH_TAVOREVB3
+	bool "PXA95x Development Platform (aka TavorEVB III)"
+	select CPU_PXA950
+
 config MACH_SAAR
 	bool "PXA930 Handheld Platform (aka SAAR)"
 	select PXA3xx
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index b8f1f4b..55d3368 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_MACH_ZYLONITE300)	+= zylonite.o zylonite_pxa300.o
 obj-$(CONFIG_MACH_ZYLONITE320)	+= zylonite.o zylonite_pxa320.o
 obj-$(CONFIG_MACH_LITTLETON)	+= littleton.o
 obj-$(CONFIG_MACH_TAVOREVB)	+= tavorevb.o
+obj-$(CONFIG_MACH_TAVOREVB3)	+= tavorevb3.o
 obj-$(CONFIG_MACH_SAAR)		+= saar.o

 # 3rd Party Dev Platforms
diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa930.h
b/arch/arm/mach-pxa/include/mach/mfp-pxa930.h
index 0d119d3..04f7c97 100644
--- a/arch/arm/mach-pxa/include/mach/mfp-pxa930.h
+++ b/arch/arm/mach-pxa/include/mach/mfp-pxa930.h
@@ -69,6 +69,7 @@
 #define nBE0_GPIO_60		MFP_CFG(nBE0, AF0)
 #define nBE1_GPIO_61		MFP_CFG(nBE1, AF0)
 #define RDY_GPIO_62		MFP_CFG(RDY, AF0)
+#define PMIC_INT_GPIO83		MFP_CFG_LPM(PMIC_INT, AF0, PULL_HIGH)

 /* Chip Select */
 #define DF_nCS0_nCS2		MFP_CFG_LPM(DF_nCS0, AF3, PULL_HIGH)
@@ -92,6 +93,9 @@
 #define GPIO63_CI2C_SCL		MFP_CFG_LPM(GPIO63, AF4, PULL_HIGH)
 #define GPIO64_CI2C_SDA		MFP_CFG_LPM(GPIO64, AF4, PULL_HIGH)

+#define GPIO73_CI2C_SCL		MFP_CFG_LPM(GPIO73, AF1, PULL_HIGH)
+#define GPIO74_CI2C_SDA		MFP_CFG_LPM(GPIO74, AF1, PULL_HIGH)
+
 #define GPIO77_CI2C_SCL		MFP_CFG_LPM(GPIO77, AF2, PULL_HIGH)
 #define GPIO78_CI2C_SDA		MFP_CFG_LPM(GPIO78, AF2, PULL_HIGH)

@@ -345,6 +349,9 @@
 #define GPIO69_UART1_CTS	MFP_CFG(GPIO69, AF2)
 #define GPIO70_UART1_RTS	MFP_CFG(GPIO70, AF2)

+#define GPIO53_UART1_TXD	MFP_CFG(GPIO53, AF2)
+#define GPIO54_UART1_RXD	MFP_CFG(GPIO54, AF2)
+
 /* UART2 - BTUART */
 #define GPIO91_UART2_RXD	MFP_CFG(GPIO91, AF1)
 #define GPIO92_UART2_TXD	MFP_CFG(GPIO92, AF1)
diff --git a/arch/arm/mach-pxa/pxa930.c b/arch/arm/mach-pxa/pxa930.c
index 0642920..7d29dd3 100644
--- a/arch/arm/mach-pxa/pxa930.c
+++ b/arch/arm/mach-pxa/pxa930.c
@@ -192,7 +192,7 @@ static struct mfp_addr_map pxa935_mfp_addr_map[]
__initdata = {

 static int __init pxa930_init(void)
 {
-	if (cpu_is_pxa930() || cpu_is_pxa935()) {
+	if (cpu_is_pxa930() || cpu_is_pxa935() || cpu_is_pxa950()) {
 		mfp_init_base(io_p2v(MFPR_BASE));
 		mfp_init_addr(pxa930_mfp_addr_map);
 	}
diff --git a/arch/arm/mach-pxa/tavorevb3.c b/arch/arm/mach-pxa/tavorevb3.c
new file mode 100644
index 0000000..501a271
--- /dev/null
+++ b/arch/arm/mach-pxa/tavorevb3.c
@@ -0,0 +1,47 @@
+/*
+ *  linux/arch/arm/mach-pxa/tavorevb3.c
+ *
+ *  Support for the Marvell EVB3 Development Platform.
+ *
+ *  Copyright:  (C) Copyright 2008-2010 Marvell International Ltd.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include <mach/pxa930.h>
+
+#include "devices.h"
+#include "generic.h"
+
+static mfp_cfg_t evb3_mfp_cfg[] __initdata = {
+	/* UART */
+	GPIO53_UART1_TXD,
+	GPIO54_UART1_RXD,
+};
+
+static void __init evb3_init(void)
+{
+	/* initialize MFP configurations */
+	pxa3xx_mfp_config(ARRAY_AND_SIZE(evb3_mfp_cfg));
+
+	pxa_set_ffuart_info(NULL);
+}
+
+MACHINE_START(TAVOREVB3, "PXA950 Evaluation Board (aka TavorEVB3)")
+	.phys_io	= 0x40000000,
+	.boot_params	= 0xa0000100,
+	.map_io         = pxa_map_io,
+	.init_irq       = pxa3xx_init_irq,
+	.timer          = &pxa_timer,
+	.init_machine   = evb3_init,
+MACHINE_END
-- 
1.5.6.5
