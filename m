From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Sat, 26 Nov 2011 07:09:04 +0800
Subject: [PATCH 7/7] ARM: mmp: enable pinmux on ttc dkb
In-Reply-To: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1322262544-7854-8-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove MFP operation. Use pinmux mapping instead.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/Kconfig   |    1 +
 arch/arm/mach-mmp/ttc_dkb.c |   40 ++++++++++------------------------------
 2 files changed, 11 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 323d4c9..bd67c38 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -33,6 +33,7 @@ config MACH_TAVOREVB
 config MACH_TTC_DKB
 	bool "Marvell's PXA910 TavorEVB Development Board"
 	select CPU_PXA910
+	select PINCTRL
 	help
 	  Say 'Y' here if you want to support the Marvell PXA910-based
 	  TTC_DKB Development Board.
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 5ac5d58..28d3cc8 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/onenand.h>
@@ -22,7 +23,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <mach/addr-map.h>
-#include <mach/mfp-pxa910.h>
 #include <mach/pxa910.h>
 #include <mach/irqs.h>
 
@@ -40,34 +40,8 @@
  */
 #define TTCDKB_NR_IRQS		(IRQ_BOARD_START + 16 + 16 + 24)
 
-static unsigned long ttc_dkb_pin_config[] __initdata = {
-	/* UART2 */
-	GPIO47_UART2_RXD,
-	GPIO48_UART2_TXD,
-
-	/* DFI */
-	DF_IO0_ND_IO0,
-	DF_IO1_ND_IO1,
-	DF_IO2_ND_IO2,
-	DF_IO3_ND_IO3,
-	DF_IO4_ND_IO4,
-	DF_IO5_ND_IO5,
-	DF_IO6_ND_IO6,
-	DF_IO7_ND_IO7,
-	DF_IO8_ND_IO8,
-	DF_IO9_ND_IO9,
-	DF_IO10_ND_IO10,
-	DF_IO11_ND_IO11,
-	DF_IO12_ND_IO12,
-	DF_IO13_ND_IO13,
-	DF_IO14_ND_IO14,
-	DF_IO15_ND_IO15,
-	DF_nCS0_SM_nCS2_nCS0,
-	DF_ALE_SM_WEn_ND_ALE,
-	DF_CLE_SM_OEn_ND_CLE,
-	DF_WEn_DF_WEn,
-	DF_REn_DF_REn,
-	DF_RDY0_DF_RDY0,
+static struct pinmux_map ttc_dkb_pmx_map[] = {
+	PINMUX_MAP_PRIMARY("uart2", "uart2", "pxa2xx-uart.1"),
 };
 
 static struct mtd_partition ttc_dkb_onenand_partitions[] = {
@@ -145,14 +119,20 @@ static struct i2c_board_info ttc_dkb_i2c_info[] = {
 
 static void __init ttc_dkb_init(void)
 {
-	mfp_config(ARRAY_AND_SIZE(ttc_dkb_pin_config));
+	int ret;
 
+	ret = pinmux_register_mappings(ARRAY_AND_SIZE(ttc_dkb_pmx_map));
+	if (ret < 0)
+		goto out;
 	/* on-chip devices */
 	pxa910_add_uart(1);
 
 	/* off-chip devices */
 	pxa910_add_twsi(0, NULL, ARRAY_AND_SIZE(ttc_dkb_i2c_info));
 	platform_add_devices(ARRAY_AND_SIZE(ttc_dkb_devices));
+	return;
+out:
+	BUG();
 }
 
 MACHINE_START(TTC_DKB, "PXA910-based TTC_DKB Development Platform")
-- 
1.7.0.4
