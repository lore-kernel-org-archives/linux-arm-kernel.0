From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 6 Jan 2010 16:49:42 -0500
Subject: [PATCH] [ARM] mmp: support jasper development board
Message-ID: <mailman.127.1262786842.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/Kconfig  |   10 +++++
 arch/arm/mach-mmp/Makefile |    1 +
 arch/arm/mach-mmp/jasper.c |   80 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mmp/jasper.c

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 14cd7df..741eec7 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -30,6 +30,16 @@ config MACH_TTC_DKB
 	  Say 'Y' here if you want to support the Marvell PXA910-based
 	  TTC_DKB Development Board.

+config MACH_JASPER
+	bool "Marvell's Jasper Development Platform"
+	select CPU_MMP2
+	help
+	  Say 'Y' here if you want to support the Marvell MMP2-base
+	  Jasper Development Platform.
+	  MMP2-based board can't be co-existed with PXA168-based &
+	  PXA910-based development board. Since MMP2 is compatible to
+	  ARMv6 architecture.
+
 config MACH_FLINT
 	bool "Marvell's Flint Development Platform"
 	select CPU_MMP2
diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index 3ef6363..20dccc2 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -14,4 +14,5 @@ obj-$(CONFIG_MACH_ASPENITE)	+= aspenite.o
 obj-$(CONFIG_MACH_ZYLONITE2)	+= aspenite.o
 obj-$(CONFIG_MACH_TAVOREVB)	+= tavorevb.o
 obj-$(CONFIG_MACH_TTC_DKB)	+= ttc_dkb.o
+obj-$(CONFIG_MACH_JASPER)	+= jasper.o
 obj-$(CONFIG_MACH_FLINT)	+= flint.o
diff --git a/arch/arm/mach-mmp/jasper.c b/arch/arm/mach-mmp/jasper.c
new file mode 100644
index 0000000..cfd4d66
--- /dev/null
+++ b/arch/arm/mach-mmp/jasper.c
@@ -0,0 +1,80 @@
+/*
+ *  linux/arch/arm/mach-mmp/jasper.c
+ *
+ *  Support for the Marvell Jasper Development Platform.
+ *
+ *  Copyright (C) 2009-2010 Marvell International Ltd.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/addr-map.h>
+#include <mach/mfp-mmp2.h>
+#include <mach/mmp2.h>
+
+#include "common.h"
+
+static unsigned long jasper_pin_config[] __initdata = {
+	/* UART1 */
+	GPIO29_UART1_RXD,
+	GPIO30_UART1_TXD,
+
+	/* UART3 */
+	GPIO51_UART3_RXD,
+	GPIO52_UART3_TXD,
+
+	/* DFI */
+	GPIO168_DFI_D0,
+	GPIO167_DFI_D1,
+	GPIO166_DFI_D2,
+	GPIO165_DFI_D3,
+	GPIO107_DFI_D4,
+	GPIO106_DFI_D5,
+	GPIO105_DFI_D6,
+	GPIO104_DFI_D7,
+	GPIO111_DFI_D8,
+	GPIO164_DFI_D9,
+	GPIO163_DFI_D10,
+	GPIO162_DFI_D11,
+	GPIO161_DFI_D12,
+	GPIO110_DFI_D13,
+	GPIO109_DFI_D14,
+	GPIO108_DFI_D15,
+	GPIO143_ND_nCS0,
+	GPIO144_ND_nCS1,
+	GPIO147_ND_nWE,
+	GPIO148_ND_nRE,
+	GPIO150_ND_ALE,
+	GPIO149_ND_CLE,
+	GPIO112_ND_RDY0,
+	GPIO160_ND_RDY1,
+};
+
+static void __init jasper_init(void)
+{
+	mfp_config(ARRAY_AND_SIZE(jasper_pin_config));
+
+	/* on-chip devices */
+	mmp2_add_uart(1);
+	mmp2_add_uart(3);
+}
+
+MACHINE_START(MARVELL_JASPER, "Jasper Development Platform")
+	.phys_io        = APB_PHYS_BASE,
+	.boot_params    = 0x00000100,
+	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
+	.map_io		= pxa_map_io,
+	.init_irq       = mmp2_init_irq,
+	.timer          = &mmp2_timer,
+	.init_machine   = jasper_init,
+MACHINE_END
-- 
1.5.6.5
