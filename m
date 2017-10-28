From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 28 Oct 2017 15:37:17 +0200
Subject: [PATCH 2/4] pinctrl: Add skew-delay pin config and bindings
In-Reply-To: <20171028133719.27528-1-linus.walleij@linaro.org>
References: <20171028133719.27528-1-linus.walleij@linaro.org>
Message-ID: <20171028133719.27528-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some pin controllers (such as the Gemini) can control the
expected clock skew and output delay on certain pins with a
sub-nanosecond granularity. This is typically done by shunting
in a number of double inverters in front of or behind the pin.
Make it possible to configure this with a generic binding.

Cc: devicetree at vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt | 4 ++++
 drivers/pinctrl/pinconf-generic.c                              | 2 ++
 include/linux/pinctrl/pinconf-generic.h                        | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
index 4483cc31e531..ad9bbbba36e9 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
@@ -271,6 +271,10 @@ output-high		- set the pin to output mode with high level
 sleep-hardware-state	- indicate this is sleep related state which will be programmed
 			  into the registers for the sleep state.
 slew-rate		- set the slew rate
+skew-delay		- this affects the expected clock skew on input pins
+			  and the delay before latching a value to an output
+			  pin. Typically indicates how many double-inverters are
+			  used to delay the signal.
 
 For example:
 
diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index 8eaa25c3384f..b4f7f8a458ea 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -49,6 +49,7 @@ static const struct pin_config_item conf_items[] = {
 	PCONFDUMP(PIN_CONFIG_POWER_SOURCE, "pin power source", "selector", true),
 	PCONFDUMP(PIN_CONFIG_SLEEP_HARDWARE_STATE, "sleep hardware state", NULL, false),
 	PCONFDUMP(PIN_CONFIG_SLEW_RATE, "slew rate", NULL, true),
+	PCONFDUMP(PIN_CONFIG_SKEW_DELAY, "skew delay", NULL, true),
 };
 
 static void pinconf_generic_dump_one(struct pinctrl_dev *pctldev,
@@ -181,6 +182,7 @@ static const struct pinconf_generic_params dt_params[] = {
 	{ "power-source", PIN_CONFIG_POWER_SOURCE, 0 },
 	{ "sleep-hardware-state", PIN_CONFIG_SLEEP_HARDWARE_STATE, 0 },
 	{ "slew-rate", PIN_CONFIG_SLEW_RATE, 0 },
+	{ "skew-delay", PIN_CONFIG_SKEW_DELAY, 0 },
 };
 
 /**
diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
index 5d8bc7f21c2a..ec6dadcc1fde 100644
--- a/include/linux/pinctrl/pinconf-generic.h
+++ b/include/linux/pinctrl/pinconf-generic.h
@@ -90,6 +90,10 @@
  * @PIN_CONFIG_SLEW_RATE: if the pin can select slew rate, the argument to
  *	this parameter (on a custom format) tells the driver which alternative
  *	slew rate to use.
+ * @PIN_CONFIG_SKEW_DELAY: if the pin has programmable skew rate (on inputs)
+ *	or latch delay (on outputs) this parameter (in a custom format)
+ *	specifies the clock skew or latch delay. It typically controls how
+ *	many double inverters are put in front of the line.
  * @PIN_CONFIG_END: this is the last enumerator for pin configurations, if
  *	you need to pass in custom configurations to the pin controller, use
  *	PIN_CONFIG_END+1 as the base offset.
@@ -117,6 +121,7 @@ enum pin_config_param {
 	PIN_CONFIG_POWER_SOURCE,
 	PIN_CONFIG_SLEEP_HARDWARE_STATE,
 	PIN_CONFIG_SLEW_RATE,
+	PIN_CONFIG_SKEW_DELAY,
 	PIN_CONFIG_END = 0x7F,
 	PIN_CONFIG_MAX = 0xFF,
 };
-- 
2.13.6
