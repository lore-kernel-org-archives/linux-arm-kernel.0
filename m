From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat,  3 Mar 2012 12:40:01 +0100
Subject: [PATCH 1/4] regulator fixed: Do not report enumaratable voltages if
 there are none
In-Reply-To: <1330774804-7310-1-git-send-email-s.hauer@pengutronix.de>
References: <1330774804-7310-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1330774804-7310-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If used as a dummy voltage provider the fixed regulator should
not set n_voltages to make the core accept the device.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/regulator/fixed.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index e24e3a1..40f3803 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -192,7 +192,9 @@ static int __devinit reg_fixed_voltage_probe(struct platform_device *pdev)
 	drvdata->desc.type = REGULATOR_VOLTAGE;
 	drvdata->desc.owner = THIS_MODULE;
 	drvdata->desc.ops = &fixed_voltage_ops;
-	drvdata->desc.n_voltages = 1;
+
+	if (config->microvolts)
+		drvdata->desc.n_voltages = 1;
 
 	drvdata->microvolts = config->microvolts;
 	drvdata->gpio = config->gpio;
-- 
1.7.9.1
