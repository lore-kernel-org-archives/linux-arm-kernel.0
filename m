From: Claudiu.Beznea@microchip.com (Claudiu.Beznea at microchip.com)
Date: Tue, 27 Nov 2018 11:57:17 +0000
Subject: [PATCH v2 3/5] regulator: act8945a-regulator: add shutdown function
In-Reply-To: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
References: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1543319801-19100-4-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Implement shutdown method to make sure the PMIC will not enter the suspend
state when the system is shutdown.

This work is based on work done by Borris Brezillon on [1].

[1] https://www.spinics.net/lists/kernel/msg2942960.html

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/act8945a-regulator.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act8945a-regulator.c
index f4d60743efb3..90572b6370c6 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -339,12 +339,23 @@ static int act8945a_suspend(struct device *pdev)
 
 SIMPLE_DEV_PM_OPS(act8945a_pm, act8945a_suspend, NULL);
 
+static void act8945a_pmic_shutdown(struct platform_device *pdev)
+{
+	struct act8945a_pmic *act8945a = platform_get_drvdata(pdev);
+
+	/*
+	 * Ask the PMIC to shutdown everything on the next PWRHLD transition.
+	 */
+	regmap_write(act8945a->regmap, ACT8945A_SYS_CTRL, 0x0);
+}
+
 static struct platform_driver act8945a_pmic_driver = {
 	.driver = {
 		.name = "act8945a-regulator",
 		.pm = &act8945a_pm,
 	},
 	.probe = act8945a_pmic_probe,
+	.shutdown = act8945a_pmic_shutdown,
 };
 module_platform_driver(act8945a_pmic_driver);
 
-- 
2.7.4
