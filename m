From: linux@roeck-us.net (Guenter Roeck)
Date: Thu,  9 Oct 2014 09:18:38 -0700
Subject: [PATCH] mfd: ab8500-sysctrl: Drop ab8500_restart
Message-ID: <1412871518-11359-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ab8500_restart is not called from anywhere in the kernel, so drop it.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/mfd/ab8500-sysctrl.c              | 57 -------------------------------
 include/linux/mfd/abx500/ab8500-sysctrl.h |  1 -
 2 files changed, 58 deletions(-)

diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index 8e0dae5..94dbcdd 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -85,63 +85,6 @@ shutdown:
 	}
 }
 
-/*
- * Use the AB WD to reset the platform. It will perform a hard
- * reset instead of a soft reset. Write the reset reason to
- * the AB before reset, which can be read upon restart.
- */
-void ab8500_restart(char mode, const char *cmd)
-{
-	struct ab8500_platform_data *plat;
-	struct ab8500_sysctrl_platform_data *pdata;
-	u16 reason = 0;
-	u8 val;
-
-	if (sysctrl_dev == NULL) {
-		pr_err("%s: sysctrl not initialized\n", __func__);
-		return;
-	}
-
-	plat = dev_get_platdata(sysctrl_dev->parent);
-	pdata = plat->sysctrl;
-	if (pdata && pdata->reboot_reason_code)
-		reason = pdata->reboot_reason_code(cmd);
-	else
-		pr_warn("[%s] No reboot reason set. Default reason %d\n",
-			__func__, reason);
-
-	/*
-	 * Disable RTC alarm, just a precaution so that no alarm
-	 * is running when WD reset is executed.
-	 */
-	abx500_get_register_interruptible(sysctrl_dev, AB8500_RTC,
-		RTC_CTRL , &val);
-	abx500_set_register_interruptible(sysctrl_dev, AB8500_RTC,
-		RTC_CTRL , (val & ~RTC_ALARM_ENABLE));
-
-	/*
-	 * Android is not using the RTC alarm registers during reboot
-	 * so we borrow them for writing the reason of reset
-	 */
-
-	/* reason[8 LSB] */
-	val = reason & 0xFF;
-	abx500_set_register_interruptible(sysctrl_dev, AB8500_RTC,
-		AB8500_ALARM_MIN_LOW , val);
-
-	/* reason[8 MSB] */
-	val = (reason>>8) & 0xFF;
-	abx500_set_register_interruptible(sysctrl_dev, AB8500_RTC,
-		AB8500_ALARM_MIN_MID , val);
-
-	/* Setting WD timeout to 0 */
-	ab8500_sysctrl_write(AB8500_MAINWDOGTIMER, 0xFF, 0x0);
-
-	/* Setting the parameters to AB8500 WD*/
-	ab8500_sysctrl_write(AB8500_MAINWDOGCTRL, 0xFF, (AB8500_ENABLE_WD |
-		AB8500_WD_RESTART_ON_EXPIRE | AB8500_KICK_WD));
-}
-
 static inline bool valid_bank(u8 bank)
 {
 	return ((bank == AB8500_SYS_CTRL1_BLOCK) ||
diff --git a/include/linux/mfd/abx500/ab8500-sysctrl.h b/include/linux/mfd/abx500/ab8500-sysctrl.h
index adba89d..6893127 100644
--- a/include/linux/mfd/abx500/ab8500-sysctrl.h
+++ b/include/linux/mfd/abx500/ab8500-sysctrl.h
@@ -12,7 +12,6 @@
 
 int ab8500_sysctrl_read(u16 reg, u8 *value);
 int ab8500_sysctrl_write(u16 reg, u8 mask, u8 value);
-void ab8500_restart(char mode, const char *cmd);
 
 #else
 
-- 
1.9.1
