From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 29 Oct 2013 09:19:23 +0100
Subject: [RESEND PATCH 1/2] w1-gpio: Detect of_gpio_error for first gpio
Message-ID: <1383034764-22091-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first DT gpio is necessary for this driver, but errors returned for
of_get_gpio are ignored.

This patch adds a return value check for the first of_get_gpio.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
---
 drivers/w1/masters/w1-gpio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/w1/masters/w1-gpio.c b/drivers/w1/masters/w1-gpio.c
index f54ece2..ae53e88 100644
--- a/drivers/w1/masters/w1-gpio.c
+++ b/drivers/w1/masters/w1-gpio.c
@@ -58,6 +58,7 @@ static int w1_gpio_probe_dt(struct platform_device *pdev)
 {
 	struct w1_gpio_platform_data *pdata = pdev->dev.platform_data;
 	struct device_node *np = pdev->dev.of_node;
+	int gpio;
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -66,7 +67,11 @@ static int w1_gpio_probe_dt(struct platform_device *pdev)
 	if (of_get_property(np, "linux,open-drain", NULL))
 		pdata->is_open_drain = 1;
 
-	pdata->pin = of_get_gpio(np, 0);
+	gpio = of_get_gpio(np, 0);
+	if (gpio < 0)
+		return gpio;
+	pdata->pin = gpio;
+
 	pdata->ext_pullup_enable_pin = of_get_gpio(np, 1);
 	pdev->dev.platform_data = pdata;
 
-- 
1.8.4.rc3
