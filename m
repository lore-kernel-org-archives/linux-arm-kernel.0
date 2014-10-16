From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu, 16 Oct 2014 10:11:29 -0700
Subject: [PATCH RFC v2 2/8] pinctrl: pinconf-generic: Add flag to print
 arguments
In-Reply-To: <1413479495-14206-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1413479495-14206-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1413479495-14206-3-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When dumping pinconf information in debugfs, config arguments are only
printed when a unit is present and the argument is != 0. For parameters
like the slew rate, this does not work. The slew rate uses a driver
specific format for the argument, i.e. 0 can be a valid argument and a
unit is not provided for it.
For that reason, add a flag to enable printing the argument instead of
inferring it from the presence of a unit and the value of the argument.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/pinctrl/pinconf-generic.c | 65 ++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index 29ff77f90fcb..e28ef957ca2d 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -32,30 +32,32 @@ struct pin_config_item {
 	const enum pin_config_param param;
 	const char * const display;
 	const char * const format;
+	bool has_arg;
 };
 
-#define PCONFDUMP(a, b, c) { .param = a, .display = b, .format = c }
+#define PCONFDUMP(a, b, c, d) { .param = a, .display = b, .format = c, \
+				.has_arg = d }
 
 static struct pin_config_item conf_items[] = {
-	PCONFDUMP(PIN_CONFIG_BIAS_DISABLE, "input bias disabled", NULL),
-	PCONFDUMP(PIN_CONFIG_BIAS_HIGH_IMPEDANCE, "input bias high impedance", NULL),
-	PCONFDUMP(PIN_CONFIG_BIAS_BUS_HOLD, "input bias bus hold", NULL),
-	PCONFDUMP(PIN_CONFIG_BIAS_PULL_UP, "input bias pull up", NULL),
-	PCONFDUMP(PIN_CONFIG_BIAS_PULL_DOWN, "input bias pull down", NULL),
+	PCONFDUMP(PIN_CONFIG_BIAS_DISABLE, "input bias disabled", NULL, false),
+	PCONFDUMP(PIN_CONFIG_BIAS_HIGH_IMPEDANCE, "input bias high impedance", NULL, false),
+	PCONFDUMP(PIN_CONFIG_BIAS_BUS_HOLD, "input bias bus hold", NULL, false),
+	PCONFDUMP(PIN_CONFIG_BIAS_PULL_UP, "input bias pull up", NULL, false),
+	PCONFDUMP(PIN_CONFIG_BIAS_PULL_DOWN, "input bias pull down", NULL, false),
 	PCONFDUMP(PIN_CONFIG_BIAS_PULL_PIN_DEFAULT,
-				"input bias pull to pin specific state", NULL),
-	PCONFDUMP(PIN_CONFIG_DRIVE_PUSH_PULL, "output drive push pull", NULL),
-	PCONFDUMP(PIN_CONFIG_DRIVE_OPEN_DRAIN, "output drive open drain", NULL),
-	PCONFDUMP(PIN_CONFIG_DRIVE_OPEN_SOURCE, "output drive open source", NULL),
-	PCONFDUMP(PIN_CONFIG_DRIVE_STRENGTH, "output drive strength", "mA"),
-	PCONFDUMP(PIN_CONFIG_INPUT_ENABLE, "input enabled", NULL),
-	PCONFDUMP(PIN_CONFIG_INPUT_SCHMITT_ENABLE, "input schmitt enabled", NULL),
-	PCONFDUMP(PIN_CONFIG_INPUT_SCHMITT, "input schmitt trigger", NULL),
-	PCONFDUMP(PIN_CONFIG_INPUT_DEBOUNCE, "input debounce", "usec"),
-	PCONFDUMP(PIN_CONFIG_POWER_SOURCE, "pin power source", "selector"),
-	PCONFDUMP(PIN_CONFIG_SLEW_RATE, "slew rate", NULL),
-	PCONFDUMP(PIN_CONFIG_LOW_POWER_MODE, "pin low power", "mode"),
-	PCONFDUMP(PIN_CONFIG_OUTPUT, "pin output", "level"),
+				"input bias pull to pin specific state", NULL, false),
+	PCONFDUMP(PIN_CONFIG_DRIVE_PUSH_PULL, "output drive push pull", NULL, false),
+	PCONFDUMP(PIN_CONFIG_DRIVE_OPEN_DRAIN, "output drive open drain", NULL, false),
+	PCONFDUMP(PIN_CONFIG_DRIVE_OPEN_SOURCE, "output drive open source", NULL, false),
+	PCONFDUMP(PIN_CONFIG_DRIVE_STRENGTH, "output drive strength", "mA", true),
+	PCONFDUMP(PIN_CONFIG_INPUT_ENABLE, "input enabled", NULL, false),
+	PCONFDUMP(PIN_CONFIG_INPUT_SCHMITT_ENABLE, "input schmitt enabled", NULL, false),
+	PCONFDUMP(PIN_CONFIG_INPUT_SCHMITT, "input schmitt trigger", NULL, false),
+	PCONFDUMP(PIN_CONFIG_INPUT_DEBOUNCE, "input debounce", "usec", true),
+	PCONFDUMP(PIN_CONFIG_POWER_SOURCE, "pin power source", "selector", true),
+	PCONFDUMP(PIN_CONFIG_SLEW_RATE, "slew rate", NULL, true),
+	PCONFDUMP(PIN_CONFIG_LOW_POWER_MODE, "pin low power", "mode", true),
+	PCONFDUMP(PIN_CONFIG_OUTPUT, "pin output", "level", true),
 };
 
 void pinconf_generic_dump_pin(struct pinctrl_dev *pctldev,
@@ -85,11 +87,14 @@ void pinconf_generic_dump_pin(struct pinctrl_dev *pctldev,
 		seq_puts(s, " ");
 		seq_puts(s, conf_items[i].display);
 		/* Print unit if available */
-		if (conf_items[i].format &&
-		    pinconf_to_config_argument(config) != 0)
-			seq_printf(s, " (%u %s)",
-				   pinconf_to_config_argument(config),
-				   conf_items[i].format);
+		if (conf_items[i].has_arg) {
+			seq_printf(s, " (%u",
+				   pinconf_to_config_argument(config));
+			if (conf_items[i].format)
+				seq_printf(s, " %s)", conf_items[i].format);
+			else
+				seq_puts(s, ")");
+		}
 	}
 }
 
@@ -121,10 +126,14 @@ void pinconf_generic_dump_group(struct pinctrl_dev *pctldev,
 		seq_puts(s, " ");
 		seq_puts(s, conf_items[i].display);
 		/* Print unit if available */
-		if (conf_items[i].format && config != 0)
-			seq_printf(s, " (%u %s)",
-				   pinconf_to_config_argument(config),
-				   conf_items[i].format);
+		if (conf_items[i].has_arg) {
+			seq_printf(s, " (%u",
+				   pinconf_to_config_argument(config));
+			if (conf_items[i].format)
+				seq_printf(s, " %s)", conf_items[i].format);
+			else
+				seq_puts(s, ")");
+		}
 	}
 }
 
-- 
2.1.2.1.g5e69ed6
