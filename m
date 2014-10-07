From: linux@roeck-us.net (Guenter Roeck)
Date: Mon,  6 Oct 2014 22:28:17 -0700
Subject: [PATCH 15/44] mfd: dm355evm_msp: Register with kernel poweroff handler
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
Message-ID: <1412659726-29957-16-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register with kernel poweroff handler instead of setting pm_power_off
directly. Register with a low priority value of 64 to reflect that
the original code only sets pm_power_off if it was not already set.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/mfd/dm355evm_msp.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/dm355evm_msp.c b/drivers/mfd/dm355evm_msp.c
index 4c826f7..52a82f3 100644
--- a/drivers/mfd/dm355evm_msp.c
+++ b/drivers/mfd/dm355evm_msp.c
@@ -14,6 +14,8 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/pm.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
@@ -352,14 +354,22 @@ static void dm355evm_command(unsigned command)
 				command, status);
 }
 
-static void dm355evm_power_off(void)
+static int dm355evm_power_off(struct notifier_block *this,
+			      unsigned long unused1, void *unused2)
 {
 	dm355evm_command(MSP_COMMAND_POWEROFF);
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block dm355evm_msp_poweroff_nb = {
+	.notifier_call = dm355evm_power_off,
+	.priority = 64,
+};
+
 static int dm355evm_msp_remove(struct i2c_client *client)
 {
-	pm_power_off = NULL;
+	unregister_poweroff_handler(&dm355evm_msp_poweroff_nb);
 	msp430 = NULL;
 	return 0;
 }
@@ -398,7 +408,9 @@ dm355evm_msp_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		goto fail;
 
 	/* PM hookup */
-	pm_power_off = dm355evm_power_off;
+	status = register_poweroff_handler(&dm355evm_msp_poweroff_nb);
+	if (status)
+		dev_err(&client->dev, "Failed to register poweroff handler\n");
 
 	return 0;
 
-- 
1.9.1
