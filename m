From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  7 Dec 2015 11:50:20 +0000
Subject: [PATCH 07/19] mfd: ab8500-sysctrl: Fix Constify,
 printk => pr_info and formatting issues
In-Reply-To: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
References: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449489032-14374-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: char * array declaration might be better as static const
+       static char *pss[] = {"ab8500_ac", "pm2301", "ab8500_usb"};

WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then dev_info(dev, ... then
 pr_info(...  to printk(KERN_INFO ...
+                       printk(KERN_INFO

WARNING: quoted string split across lines
+                              "Charger \"%s\" is connected with known battery."
+                              " Rebooting.\n",

WARNING: quoted string split across lines
+                                       "unable to set sysClkReq%dRfClkBuf: "
+                                       "%d\n", j + 1, ret);

total: 0 errors, 4 warnings, 199 lines checked

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-sysctrl.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index 0d18256..b9f0010 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -27,7 +27,7 @@ static void ab8500_power_off(void)
 {
 	sigset_t old;
 	sigset_t all;
-	static char *pss[] = {"ab8500_ac", "pm2301", "ab8500_usb"};
+	static const char * const pss[] = {"ab8500_ac", "pm2301", "ab8500_usb"};
 	int i;
 	bool charger_present = false;
 	union power_supply_propval val;
@@ -68,10 +68,9 @@ static void ab8500_power_off(void)
 		ret = power_supply_get_property(psy,
 				POWER_SUPPLY_PROP_TECHNOLOGY, &val);
 		if (!ret && val.intval != POWER_SUPPLY_TECHNOLOGY_UNKNOWN) {
-			printk(KERN_INFO
-			       "Charger \"%s\" is connected with known battery."
-			       " Rebooting.\n",
-			       pss[i]);
+			pr_info("Charger '%s' is connected with known battery",
+				pss[i]);
+			pr_info(" - Rebooting.\n");
 			machine_restart("charging");
 		}
 		power_supply_put(psy);
@@ -161,8 +160,8 @@ static int ab8500_sysctrl_probe(struct platform_device *pdev)
 					pdata->initial_req_buf_config[j]);
 			if (ret < 0) {
 				dev_err(&pdev->dev,
-					"unable to set sysClkReq%dRfClkBuf: "
-					"%d\n", j + 1, ret);
+					"Can't set sysClkReq%dRfClkBuf: %d\n",
+					j + 1, ret);
 			}
 		}
 	}
-- 
1.9.1
