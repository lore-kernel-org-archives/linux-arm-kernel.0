From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  6 Jan 2013 11:10:35 +0100
Subject: [PATCH 02/11] Power: gpio-poweroff: Fix documentation and
 gpio_is_valid
In-Reply-To: <1357467044-4914-1-git-send-email-andrew@lunn.ch>
References: <1357467044-4914-1-git-send-email-andrew@lunn.ch>
Message-ID: <1357467044-4914-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Improve the documentation to clarify level vs edge triggered power off.
Improve the comments for level vs edge triggered power off.
Make use of gpio_is_valid().

Reported-by: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 .../devicetree/bindings/gpio/gpio-poweroff.txt     |   20 ++++++++++--
 drivers/power/reset/gpio-poweroff.c                |   33 +++++++++-----------
 2 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt b/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
index 558cdf3..d4eab92 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
@@ -1,4 +1,19 @@
-GPIO line that should be set high/low to power off a device
+Driver a GPIO line that can be used to turn the power off.
+
+The driver supports both level triggered and edge triggered power off.
+At driver load time, the driver will request the given gpio line and
+install a pm_power_off handler. If the optional properties 'input' is
+not found, the GPIO line will be driven in the inactive
+state. Otherwise its configured as an input.
+
+When the pm_power_off is called, the gpio is configured as an output,
+and drive active, so triggering a level triggered power off
+condition. This will also cause an inactive->active edge condition, so
+triggering positive edge triggered power off. After a delay of 100ms,
+the GPIO is set to inactive, thus causing an active->inactive edge,
+triggering negative edge triggered power off. After another 100ms
+delay the GPIO is driver active again. If the power is still on and
+the CPU still running after a 3000ms delay, a WARN_ON(1) is emitted.
 
 Required properties:
 - compatible : should be "gpio-poweroff".
@@ -13,10 +28,9 @@ Optional properties:
   property is not specified, the GPIO is initialized as an output in its
   inactive state.
 
-
 Examples:
 
 gpio-poweroff {
 	compatible = "gpio-poweroff";
-	gpios = <&gpio 4 0>; /* GPIO 4 Active Low */
+	gpios = <&gpio 4 0>;
 };
diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gpio-poweroff.c
index 0491e53..adc943b 100644
--- a/drivers/power/reset/gpio-poweroff.c
+++ b/drivers/power/reset/gpio-poweroff.c
@@ -29,15 +29,16 @@ static int gpio_active_low;
 
 static void gpio_poweroff_do_poweroff(void)
 {
-	BUG_ON(gpio_num == -1);
+	BUG_ON(!gpio_is_valid(gpio_num));
 
-	/* drive it active */
+	/* drive it active, also inactive->active edge */
 	gpio_direction_output(gpio_num, !gpio_active_low);
 	mdelay(100);
-	/* rising edge or drive inactive */
+	/* drive inactive, also active->inactive edge */
 	gpio_set_value(gpio_num, gpio_active_low);
 	mdelay(100);
-	/* falling edge */
+
+	/* drive it active, also inactive->active edge */
 	gpio_set_value(gpio_num, !gpio_active_low);
 
 	/* give it some time */
@@ -60,15 +61,12 @@ static int __devinit gpio_poweroff_probe(struct platform_device *pdev)
 	}
 
 	gpio_num = of_get_gpio_flags(pdev->dev.of_node, 0, &flags);
-	if (gpio_num < 0) {
-		pr_err("%s: Could not get GPIO configuration: %d",
-		       __func__, gpio_num);
-		return -ENODEV;
-	}
+	if (!gpio_is_valid(gpio_num))
+		return gpio_num;
+
 	gpio_active_low = flags & OF_GPIO_ACTIVE_LOW;
 
-	if (of_get_property(pdev->dev.of_node, "input", NULL))
-		input = true;
+	input = of_property_read_bool(pdev->dev.of_node, "input");
 
 	ret = gpio_request(gpio_num, "poweroff-gpio");
 	if (ret) {
@@ -98,8 +96,7 @@ err:
 
 static int __devexit gpio_poweroff_remove(struct platform_device *pdev)
 {
-	if (gpio_num != -1)
-		gpio_free(gpio_num);
+	gpio_free(gpio_num);
 	if (pm_power_off == &gpio_poweroff_do_poweroff)
 		pm_power_off = NULL;
 
@@ -115,15 +112,15 @@ static struct platform_driver gpio_poweroff_driver = {
 	.probe = gpio_poweroff_probe,
 	.remove = __devexit_p(gpio_poweroff_remove),
 	.driver = {
-		   .name = "poweroff-gpio",
-		   .owner = THIS_MODULE,
-		   .of_match_table = of_gpio_poweroff_match,
-		   },
+		.name = "poweroff-gpio",
+		.owner = THIS_MODULE,
+		.of_match_table = of_gpio_poweroff_match,
+	},
 };
 
 module_platform_driver(gpio_poweroff_driver);
 
 MODULE_AUTHOR("Jamie Lentin <jm@lentin.co.uk>");
 MODULE_DESCRIPTION("GPIO poweroff driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:poweroff-gpio");
-- 
1.7.10.4
