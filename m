From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri,  1 Apr 2011 10:39:28 +0800
Subject: [PATCH 9/9] ARM: mmp: enable max7312 gpio expander in dkb
In-Reply-To: <1301625568-16583-8-git-send-email-haojian.zhuang@marvell.com>
References: <040101>
	<1301625568-16583-1-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-2-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-3-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-4-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-5-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-6-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-7-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-8-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1301625568-16583-9-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support max7312 gpio expander in TTC DKB.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/ttc_dkb.c |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index e411039..9d3ef01 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -15,17 +15,29 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/onenand.h>
 #include <linux/interrupt.h>
+#include <linux/i2c/pca953x.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <mach/addr-map.h>
+#include <mach/gpio.h>
 #include <mach/mfp-pxa910.h>
 #include <mach/pxa910.h>
 
 #include "common.h"
 
-#define TTCDKB_NR_IRQS		(IRQ_BOARD_START + 24)
+#define TTCDKB_GPIO_EXT0(x)	(NR_BUILTIN_GPIO + ((x < 0) ? 0 :	\
+				((x < 16) ? x : 15)))
+#define TTCDKB_GPIO_EXT1(x)	(NR_BUILTIN_GPIO + 16 + ((x < 0) ? 0 :	\
+				((x < 16) ? x : 15)))
+
+/*
+ * 16 board interrupts -- MAX7312 GPIO expander
+ * 16 board interrupts -- PCA9575 GPIO expander
+ * 24 board interrupts -- 88PM860x PMIC
+ */
+#define TTCDKB_NR_IRQS		(IRQ_BOARD_START + 16 + 16 + 24)
 
 static unsigned long ttc_dkb_pin_config[] __initdata = {
 	/* UART2 */
@@ -113,6 +125,22 @@ static struct platform_device *ttc_dkb_devices[] = {
 	&ttc_dkb_device_onenand,
 };
 
+static struct pca953x_platform_data max7312_data[] = {
+	{
+		.gpio_base	= TTCDKB_GPIO_EXT0(0),
+		.irq_base	= IRQ_BOARD_START,
+	},
+};
+
+static struct i2c_board_info ttc_dkb_i2c_info[] = {
+	{
+		.type		= "max7312",
+		.addr		= 0x23,
+		.irq		= IRQ_GPIO(80),
+		.platform_data	= &max7312_data,
+	},
+};
+
 static void __init ttc_dkb_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(ttc_dkb_pin_config));
@@ -121,6 +149,7 @@ static void __init ttc_dkb_init(void)
 	pxa910_add_uart(1);
 
 	/* off-chip devices */
+	pxa910_add_twsi(0, NULL, ARRAY_AND_SIZE(ttc_dkb_i2c_info));
 	platform_add_devices(ARRAY_AND_SIZE(ttc_dkb_devices));
 }
 
-- 
1.5.6.5
