From: jtzhou@marvell.com (Jett.Zhou)
Date: Thu, 21 Jun 2012 14:19:47 +0800
Subject: [V2 3/3] ARM: MMP: add 88pm860x battery-charger support
Message-ID: <1340259587-24316-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 88pm860x chg_desc platform data for ttc platform.

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 arch/arm/mach-mmp/ttc_dkb.c |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 7a7de2b..5e70cbf 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -18,6 +18,8 @@
 #include <linux/i2c/pca953x.h>
 #include <linux/gpio.h>
 #include <linux/mfd/88pm860x.h>
+#include <linux/regulator/consumer.h>
+#include <linux/power/charger-manager.h>
 #include <linux/platform_data/mv_usb.h>
 
 #include <asm/mach-types.h>
@@ -138,8 +140,32 @@ static struct pca953x_platform_data max7312_data[] = {
 	},
 };
 
+static char *ttc_psy_chg_stat[] = {"usb", NULL};
+/*
+ * Temperature can be handled by battery monitor base on interrupt
+ * scheme, so dummy it to make sure charger-manager initialize ok.
+ */
+static int dummy_temp_out_of_range(int *mC)
+{
+	*mC = 2500;
+	return 0;
+}
+
+struct charger_desc chg_desc_data = {
+	.polling_mode		= CM_POLL_ALWAYS,
+	.polling_interval_ms	= 180000,
+	.battery_present	= CM_FUEL_GAUGE,
+	.psy_charger_stat	= &ttc_psy_chg_stat[0],
+	.psy_fuel_gauge		= "battery-monitor",
+	.temperature_out_of_range	= dummy_temp_out_of_range,
+};
+
 static struct pm860x_platform_data ttc_dkb_pm8607_info = {
-	.irq_base       = IRQ_BOARD_START,
+	.chg_desc	= &chg_desc_data,
+	.companion_addr	= 0x11,
+	.irq_mode	= 0,
+	.irq_base	= IRQ_BOARD_START,
+	.i2c_port	= GI2C_PORT,
 };
 
 static struct i2c_board_info ttc_dkb_i2c_info[] = {
-- 
1.7.0.4
