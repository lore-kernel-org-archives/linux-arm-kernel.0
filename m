From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 May 2014 18:34:05 -0700
Subject: [PATCH 2/7] mfd: twl4030-power: Fix some defines for SW_EVENTS
In-Reply-To: <1400031250-29542-1-git-send-email-tony@atomide.com>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
Message-ID: <1400031250-29542-3-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have these bits partially defined in two different
places, so let's fix them up and add defines for the
missing bits. These bits are the same for P1_SW_EVENTS,
P2_SW_EVENTS and P3_SW_EVENTS.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mfd/twl4030-power.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 1b30d8a..c0e4fc3 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -35,7 +35,14 @@
 static u8 twl4030_start_script_address = 0x2b;
 
 #define PWR_P1_SW_EVENTS	0x10
+#define PWR_STOPON_PRWON	(1 << 6)
+#define PWR_STOPON_SYSEN	(1 << 5)
+#define PWR_ENABLE_WARMRESET	(1 << 4)
+#define PWR_LVL_WAKEUP		(1 << 3)
+#define PWR_DEVACT		(1 << 2)
+#define PWR_DEVSLP		(1 << 1)
 #define PWR_DEVOFF		(1 << 0)
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
