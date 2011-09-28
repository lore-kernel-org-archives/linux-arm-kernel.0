From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 28 Sep 2011 17:16:03 +0800
Subject: [PATCH 1/6] arm/imx: merge mm-imx35.c into mm-imx31.c
In-Reply-To: <1317201368-6403-1-git-send-email-shawn.guo@linaro.org>
References: <1317201368-6403-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1317201368-6403-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As imx31 and imx35 have much in common at soc level, this patch merges
mm-imx35.c into mm-imx31.c, so that the common functions between imx31
and imx35 can be added in one file later.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Makefile   |    2 +-
 arch/arm/mach-imx/mm-imx31.c |   78 ++++++++++++++++++++++++++++++
 arch/arm/mach-imx/mm-imx35.c |  109 ------------------------------------------
 3 files changed, 79 insertions(+), 110 deletions(-)
 delete mode 100644 arch/arm/mach-imx/mm-imx35.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index e6c36b4..940f130 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_SOC_IMX27) += cpu-imx27.o pm-imx27.o
 obj-$(CONFIG_SOC_IMX27) += clock-imx27.o mm-imx27.o ehci-imx27.o
 
 obj-$(CONFIG_SOC_IMX31) += mm-imx31.o cpu-imx31.o clock-imx31.o iomux-imx31.o ehci-imx31.o
-obj-$(CONFIG_SOC_IMX35) += mm-imx35.o cpu-imx35.o clock-imx35.o ehci-imx35.o
+obj-$(CONFIG_SOC_IMX35) += mm-imx31.o cpu-imx35.o clock-imx35.o ehci-imx35.o
 obj-$(CONFIG_CACHE_L2X0) += cache-l2x0.o
 
 # Support for CMOS sensor interface
diff --git a/arch/arm/mach-imx/mm-imx31.c b/arch/arm/mach-imx/mm-imx31.c
index b7c55e7..e06eed1 100644
--- a/arch/arm/mach-imx/mm-imx31.c
+++ b/arch/arm/mach-imx/mm-imx31.c
@@ -47,17 +47,42 @@ void __init mx31_map_io(void)
 	iotable_init(mx31_io_desc, ARRAY_SIZE(mx31_io_desc));
 }
 
+static struct map_desc mx35_io_desc[] __initdata = {
+	imx_map_entry(MX35, X_MEMC, MT_DEVICE),
+	imx_map_entry(MX35, AVIC, MT_DEVICE_NONSHARED),
+	imx_map_entry(MX35, AIPS1, MT_DEVICE_NONSHARED),
+	imx_map_entry(MX35, AIPS2, MT_DEVICE_NONSHARED),
+	imx_map_entry(MX35, SPBA0, MT_DEVICE_NONSHARED),
+};
+
+void __init mx35_map_io(void)
+{
+	iotable_init(mx35_io_desc, ARRAY_SIZE(mx35_io_desc));
+}
+
 void __init imx31_init_early(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX31);
 	mxc_arch_reset_init(MX31_IO_ADDRESS(MX31_WDOG_BASE_ADDR));
 }
 
+void __init imx35_init_early(void)
+{
+	mxc_set_cpu_type(MXC_CPU_MX35);
+	mxc_iomux_v3_init(MX35_IO_ADDRESS(MX35_IOMUXC_BASE_ADDR));
+	mxc_arch_reset_init(MX35_IO_ADDRESS(MX35_WDOG_BASE_ADDR));
+}
+
 void __init mx31_init_irq(void)
 {
 	mxc_init_irq(MX31_IO_ADDRESS(MX31_AVIC_BASE_ADDR));
 }
 
+void __init mx35_init_irq(void)
+{
+	mxc_init_irq(MX35_IO_ADDRESS(MX35_AVIC_BASE_ADDR));
+}
+
 static struct sdma_script_start_addrs imx31_to1_sdma_script __initdata = {
 	.per_2_per_addr = 1677,
 };
@@ -89,3 +114,56 @@ void __init imx31_soc_init(void)
 
 	imx_add_imx_sdma("imx31-sdma", MX31_SDMA_BASE_ADDR, MX31_INT_SDMA, &imx31_sdma_pdata);
 }
+
+static struct sdma_script_start_addrs imx35_to1_sdma_script __initdata = {
+	.ap_2_ap_addr = 642,
+	.uart_2_mcu_addr = 817,
+	.mcu_2_app_addr = 747,
+	.uartsh_2_mcu_addr = 1183,
+	.per_2_shp_addr = 1033,
+	.mcu_2_shp_addr = 961,
+	.ata_2_mcu_addr = 1333,
+	.mcu_2_ata_addr = 1252,
+	.app_2_mcu_addr = 683,
+	.shp_2_per_addr = 1111,
+	.shp_2_mcu_addr = 892,
+};
+
+static struct sdma_script_start_addrs imx35_to2_sdma_script __initdata = {
+	.ap_2_ap_addr = 729,
+	.uart_2_mcu_addr = 904,
+	.per_2_app_addr = 1597,
+	.mcu_2_app_addr = 834,
+	.uartsh_2_mcu_addr = 1270,
+	.per_2_shp_addr = 1120,
+	.mcu_2_shp_addr = 1048,
+	.ata_2_mcu_addr = 1429,
+	.mcu_2_ata_addr = 1339,
+	.app_2_per_addr = 1531,
+	.app_2_mcu_addr = 770,
+	.shp_2_per_addr = 1198,
+	.shp_2_mcu_addr = 979,
+};
+
+static struct sdma_platform_data imx35_sdma_pdata __initdata = {
+	.fw_name = "sdma-imx35-to2.bin",
+	.script_addrs = &imx35_to2_sdma_script,
+};
+
+void __init imx35_soc_init(void)
+{
+	int to_version = mx35_revision() >> 4;
+
+	/* i.mx35 has the i.mx31 type gpio */
+	mxc_register_gpio("imx31-gpio", 0, MX35_GPIO1_BASE_ADDR, SZ_16K, MX35_INT_GPIO1, 0);
+	mxc_register_gpio("imx31-gpio", 1, MX35_GPIO2_BASE_ADDR, SZ_16K, MX35_INT_GPIO2, 0);
+	mxc_register_gpio("imx31-gpio", 2, MX35_GPIO3_BASE_ADDR, SZ_16K, MX35_INT_GPIO3, 0);
+
+	if (to_version == 1) {
+		strncpy(imx35_sdma_pdata.fw_name, "sdma-imx35-to1.bin",
+			strlen(imx35_sdma_pdata.fw_name));
+		imx35_sdma_pdata.script_addrs = &imx35_to1_sdma_script;
+	}
+
+	imx_add_imx_sdma("imx35-sdma", MX35_SDMA_BASE_ADDR, MX35_INT_SDMA, &imx35_sdma_pdata);
+}
diff --git a/arch/arm/mach-imx/mm-imx35.c b/arch/arm/mach-imx/mm-imx35.c
deleted file mode 100644
index f49bac7..0000000
--- a/arch/arm/mach-imx/mm-imx35.c
+++ /dev/null
@@ -1,109 +0,0 @@
-/*
- *  Copyright (C) 1999,2000 Arm Limited
- *  Copyright (C) 2000 Deep Blue Solutions Ltd
- *  Copyright (C) 2002 Shane Nay (shane at minirl.com)
- *  Copyright 2005-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- *    - add MX31 specific definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/mm.h>
-#include <linux/init.h>
-#include <linux/err.h>
-
-#include <asm/pgtable.h>
-#include <asm/mach/map.h>
-#include <asm/hardware/cache-l2x0.h>
-
-#include <mach/common.h>
-#include <mach/devices-common.h>
-#include <mach/hardware.h>
-#include <mach/iomux-v3.h>
-#include <mach/irqs.h>
-
-static struct map_desc mx35_io_desc[] __initdata = {
-	imx_map_entry(MX35, X_MEMC, MT_DEVICE),
-	imx_map_entry(MX35, AVIC, MT_DEVICE_NONSHARED),
-	imx_map_entry(MX35, AIPS1, MT_DEVICE_NONSHARED),
-	imx_map_entry(MX35, AIPS2, MT_DEVICE_NONSHARED),
-	imx_map_entry(MX35, SPBA0, MT_DEVICE_NONSHARED),
-};
-
-void __init mx35_map_io(void)
-{
-	iotable_init(mx35_io_desc, ARRAY_SIZE(mx35_io_desc));
-}
-
-void __init imx35_init_early(void)
-{
-	mxc_set_cpu_type(MXC_CPU_MX35);
-	mxc_iomux_v3_init(MX35_IO_ADDRESS(MX35_IOMUXC_BASE_ADDR));
-	mxc_arch_reset_init(MX35_IO_ADDRESS(MX35_WDOG_BASE_ADDR));
-}
-
-void __init mx35_init_irq(void)
-{
-	mxc_init_irq(MX35_IO_ADDRESS(MX35_AVIC_BASE_ADDR));
-}
-
-static struct sdma_script_start_addrs imx35_to1_sdma_script __initdata = {
-	.ap_2_ap_addr = 642,
-	.uart_2_mcu_addr = 817,
-	.mcu_2_app_addr = 747,
-	.uartsh_2_mcu_addr = 1183,
-	.per_2_shp_addr = 1033,
-	.mcu_2_shp_addr = 961,
-	.ata_2_mcu_addr = 1333,
-	.mcu_2_ata_addr = 1252,
-	.app_2_mcu_addr = 683,
-	.shp_2_per_addr = 1111,
-	.shp_2_mcu_addr = 892,
-};
-
-static struct sdma_script_start_addrs imx35_to2_sdma_script __initdata = {
-	.ap_2_ap_addr = 729,
-	.uart_2_mcu_addr = 904,
-	.per_2_app_addr = 1597,
-	.mcu_2_app_addr = 834,
-	.uartsh_2_mcu_addr = 1270,
-	.per_2_shp_addr = 1120,
-	.mcu_2_shp_addr = 1048,
-	.ata_2_mcu_addr = 1429,
-	.mcu_2_ata_addr = 1339,
-	.app_2_per_addr = 1531,
-	.app_2_mcu_addr = 770,
-	.shp_2_per_addr = 1198,
-	.shp_2_mcu_addr = 979,
-};
-
-static struct sdma_platform_data imx35_sdma_pdata __initdata = {
-	.fw_name = "sdma-imx35-to2.bin",
-	.script_addrs = &imx35_to2_sdma_script,
-};
-
-void __init imx35_soc_init(void)
-{
-	int to_version = mx35_revision() >> 4;
-
-	/* i.mx35 has the i.mx31 type gpio */
-	mxc_register_gpio("imx31-gpio", 0, MX35_GPIO1_BASE_ADDR, SZ_16K, MX35_INT_GPIO1, 0);
-	mxc_register_gpio("imx31-gpio", 1, MX35_GPIO2_BASE_ADDR, SZ_16K, MX35_INT_GPIO2, 0);
-	mxc_register_gpio("imx31-gpio", 2, MX35_GPIO3_BASE_ADDR, SZ_16K, MX35_INT_GPIO3, 0);
-
-	if (to_version == 1) {
-		strncpy(imx35_sdma_pdata.fw_name, "sdma-imx35-to1.bin",
-			strlen(imx35_sdma_pdata.fw_name));
-		imx35_sdma_pdata.script_addrs = &imx35_to1_sdma_script;
-	}
-
-	imx_add_imx_sdma("imx35-sdma", MX35_SDMA_BASE_ADDR, MX35_INT_SDMA, &imx35_sdma_pdata);
-}
-- 
1.7.4.1
