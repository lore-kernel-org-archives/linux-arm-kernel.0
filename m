From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 May 2014 11:08:56 -0700
Subject: [PATCH 2/6] mfd: twl4030-power: Fix some defines for SW_EVENTS
In-Reply-To: <1401214140-9828-1-git-send-email-tony@atomide.com>
References: <1401214140-9828-1-git-send-email-tony@atomide.com>
Message-ID: <1401214140-9828-3-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have these bits partially defined in two different
places, so let's fix them up and add defines for the
missing bits. These bits are the same for P1_SW_EVENTS,
P2_SW_EVENTS and P3_SW_EVENTS.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mfd/twl4030-power.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 1b30d8a..0b037dc 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -34,8 +34,15 @@
 
 static u8 twl4030_start_script_address = 0x2b;
 
-#define PWR_P1_SW_EVENTS	0x10
-#define PWR_DEVOFF		(1 << 0)
+/* Register bits for P1, P2 and P3_SW_EVENTS */
+#define PWR_STOPON_PRWON	BIT(6)
+#define PWR_STOPON_SYSEN	BIT(5)
+#define PWR_ENABLE_WARMRESET	BIT(4)
+#define PWR_LVL_WAKEUP		BIT(3)
+#define PWR_DEVACT		BIT(2)
+#define PWR_DEVSLP		BIT(1)
+#define PWR_DEVOFF		BIT(0)
+
 #define SEQ_OFFSYNC		(1 << 0)
 
 #define PHY_TO_OFF_PM_MASTER(p)		(p - 0x36)
@@ -52,10 +59,6 @@ static u8 twl4030_start_script_address = 0x2b;
 #define R_CFG_P2_TRANSITION	PHY_TO_OFF_PM_MASTER(0x37)
 #define R_CFG_P3_TRANSITION	PHY_TO_OFF_PM_MASTER(0x38)
 
-#define LVL_WAKEUP	0x08
-
-#define ENABLE_WARMRESET (1<<4)
-
 #define END_OF_SCRIPT		0x3f
 
 #define R_SEQ_ADD_A2S		PHY_TO_OFF_PM_MASTER(0x55)
@@ -196,7 +199,7 @@ static int twl4030_config_wakeup3_sequence(u8 address)
 	err = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &data, R_P3_SW_EVENTS);
 	if (err)
 		goto out;
-	data |= LVL_WAKEUP;
+	data |= PWR_LVL_WAKEUP;
 	err = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, data, R_P3_SW_EVENTS);
 out:
 	if (err)
@@ -219,7 +222,7 @@ static int twl4030_config_wakeup12_sequence(u8 address)
 	if (err)
 		goto out;
 
-	data |= LVL_WAKEUP;
+	data |= PWR_LVL_WAKEUP;
 	err = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, data, R_P1_SW_EVENTS);
 	if (err)
 		goto out;
@@ -228,7 +231,7 @@ static int twl4030_config_wakeup12_sequence(u8 address)
 	if (err)
 		goto out;
 
-	data |= LVL_WAKEUP;
+	data |= PWR_LVL_WAKEUP;
 	err = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, data, R_P2_SW_EVENTS);
 	if (err)
 		goto out;
@@ -281,7 +284,7 @@ static int twl4030_config_warmreset_sequence(u8 address)
 	if (err)
 		goto out;
 
-	rd_data |= ENABLE_WARMRESET;
+	rd_data |= PWR_ENABLE_WARMRESET;
 	err = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, rd_data, R_P1_SW_EVENTS);
 	if (err)
 		goto out;
@@ -290,7 +293,7 @@ static int twl4030_config_warmreset_sequence(u8 address)
 	if (err)
 		goto out;
 
-	rd_data |= ENABLE_WARMRESET;
+	rd_data |= PWR_ENABLE_WARMRESET;
 	err = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, rd_data, R_P2_SW_EVENTS);
 	if (err)
 		goto out;
@@ -299,7 +302,7 @@ static int twl4030_config_warmreset_sequence(u8 address)
 	if (err)
 		goto out;
 
-	rd_data |= ENABLE_WARMRESET;
+	rd_data |= PWR_ENABLE_WARMRESET;
 	err = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, rd_data, R_P3_SW_EVENTS);
 out:
 	if (err)
-- 
1.8.1.1
