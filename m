From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 4 Dec 2009 10:21:33 -0500
Subject: [PATCH] [ARM] mmp: support flint development board
Message-ID: <mailman.74.1260166852.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support Marvell Flint development board. ARMADA610 is installed on it.

UART and ethernet is supported.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/Makefile |    1 +
 arch/arm/mach-mmp/flint.c  |  125 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mmp/flint.c

diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index a6da617..c068715 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_MACH_ASPENITE)	+= aspenite.o
 obj-$(CONFIG_MACH_ZYLONITE2)	+= aspenite.o
 obj-$(CONFIG_MACH_TAVOREVB)	+= tavorevb.o
 obj-$(CONFIG_MACH_TTC_DKB)	+= ttc_dkb.o
+obj-$(CONFIG_MACH_FLINT)	+= flint.o
diff --git a/arch/arm/mach-mmp/flint.c b/arch/arm/mach-mmp/flint.c
new file mode 100644
index 0000000..be4e132
--- /dev/null
+++ b/arch/arm/mach-mmp/flint.c
@@ -0,0 +1,125 @@
+/*
+ *  linux/arch/arm/mach-mmp/flint.c
+ *
+ *  Support for the Marvell Flint Development Platform.
+ *
+ *  Copyright (C) 2009 Marvell International Ltd.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/smc91x.h>
+#include <linux/io.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/addr-map.h>
+#include <mach/gpio.h>
+#include <mach/mfp-armada610.h>
+#include <mach/armada610.h>
+
+#include "common.h"
+
+#define ARRAY_AND_SIZE(x)       (x), ARRAY_SIZE(x)
+
+static unsigned long flint_pin_config[] __initdata = {
+	/* UART1 */
+	GPIO45_UART1_RXD,
+	GPIO46_UART1_TXD,
+
+	/* UART2 */
+	GPIO47_UART2_RXD,
+	GPIO48_UART2_TXD,
+
+	/* SMC */
+	GPIO151_SMC_SCLK,
+	GPIO145_SMC_nCS0,
+	GPIO146_SMC_nCS1,
+	GPIO152_SMC_BE0,
+	GPIO153_SMC_BE1,
+	GPIO154_SMC_IRQ,
+	GPIO113_SMC_RDY,
+
+	/*Ethernet*/
+	GPIO155_GPIO155,
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
+static struct smc91x_platdata flint_smc91x_info = {
+	.flags  = SMC91X_USE_16BIT | SMC91X_NOWAIT,
+};
+
+static struct resource smc91x_resources[] = {
+	[0] = {
+		.start  = SMC_CS1_PHYS_BASE + 0x300,
+		.end    = SMC_CS1_PHYS_BASE + 0xfffff,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = gpio_to_irq(155),
+		.end    = gpio_to_irq(155),
+		.flags  = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
+	}
+};
+
+static struct platform_device smc91x_device = {
+	.name           = "smc91x",
+	.id             = 0,
+	.dev            = {
+		.platform_data = &flint_smc91x_info,
+	},
+	.num_resources  = ARRAY_SIZE(smc91x_resources),
+	.resource       = smc91x_resources,
+};
+
+static void __init flint_init(void)
+{
+	mfp_config(ARRAY_AND_SIZE(flint_pin_config));
+
+	/* on-chip devices */
+	armada610_add_uart(1);
+	armada610_add_uart(2);
+
+	/* off-chip devices */
+	platform_device_register(&smc91x_device);
+}
+
+MACHINE_START(FLINT, "Flint Development Platform")
+	.phys_io        = APB_PHYS_BASE,
+	.boot_params    = 0x00000100,
+	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
+	.map_io		= pxa_map_io,
+	.init_irq       = armada610_init_irq,
+	.timer          = &armada610_timer,
+	.init_machine   = flint_init,
+MACHINE_END
-- 
1.5.6.5
