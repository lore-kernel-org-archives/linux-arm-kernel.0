From: jm@lentin.co.uk (Jamie Lentin)
Date: Thu,  1 Nov 2012 23:55:43 +0000
Subject: [PATCH] hwmon: Only include of_match_table with CONFIG_OF_GPIO
Message-ID: <1351814143-13714-1-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following fixes build errors on sparc. Without any DT support,
of_match_ptr is NULL and the below is a no-op. However, if just
CONFIG_OF is defined then so is of_match_ptr.

All useful parts of the gpio-fan DT support rely on CONFIG_OF_GPIO
anyway, so of_match_table should too.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 drivers/hwmon/gpio-fan.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index 36509ae..1381a2e 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -630,7 +630,9 @@ static struct platform_driver gpio_fan_driver = {
 	.driver	= {
 		.name	= "gpio-fan",
 		.pm	= GPIO_FAN_PM,
+#ifdef CONFIG_OF_GPIO
 		.of_match_table = of_match_ptr(of_gpio_fan_match),
+#endif
 	},
 };
 
-- 
1.7.10.4
