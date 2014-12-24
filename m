From: vigneshr@ti.com (Vignesh R)
Date: Wed, 24 Dec 2014 12:33:38 +0530
Subject: [PATCH v5 5/6] input: touchscreen: ti_am335x_tsc: Use charge delay DT
 parameter
In-Reply-To: <1419404619-10744-1-git-send-email-vigneshr@ti.com>
References: <1419404619-10744-1-git-send-email-vigneshr@ti.com>
Message-ID: <1419404619-10744-6-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch reads charge delay from tsc DT node and writes to
REG_CHARGEDELAY register. If the charge delay is not specified in DT
then default value of 0x400(CHARGEDLY_OPENDLY) is used.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
v5:
 - print out a warning when ti,charge-delay is not specified

 drivers/input/touchscreen/ti_am335x_tsc.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 8650b1dd24dc..9cb8b4a01dca 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -52,6 +52,7 @@ struct titsc {
 	u32			bit_xp, bit_xn, bit_yp, bit_yn;
 	u32			inp_xp, inp_xn, inp_yp, inp_yn;
 	u32			step_mask;
+	u32			charge_delay;
 };
 
 static unsigned int titsc_readl(struct titsc *ts, unsigned int reg)
@@ -177,7 +178,7 @@ static void titsc_step_config(struct titsc *ts_dev)
 
 	config = titsc_readl(ts_dev, REG_IDLECONFIG);
 	titsc_writel(ts_dev, REG_CHARGECONFIG, config);
-	titsc_writel(ts_dev, REG_CHARGEDELAY, CHARGEDLY_OPENDLY);
+	titsc_writel(ts_dev, REG_CHARGEDELAY, ts_dev->charge_delay);
 
 	/* coordinate_readouts + 1 ... coordinate_readouts + 2 is for Z */
 	config = STEPCONFIG_MODE_HWSYNC |
@@ -368,6 +369,17 @@ static int titsc_parse_dt(struct platform_device *pdev,
 	if (err < 0)
 		return err;
 
+	err = of_property_read_u32(node, "ti,charge-delay",
+				   &ts_dev->charge_delay);
+	/*
+	 * If ti,charge-delay value is not specified, then use CHARGEDLY_OPENDLY
+	 * as the default value.
+	 */
+	if (err < 0) {
+		ts_dev->charge_delay = CHARGEDLY_OPENDLY;
+		dev_warn(&pdev->dev, "ti,charge-delay not specified\n");
+	}
+
 	return of_property_read_u32_array(node, "ti,wire-config",
 			ts_dev->config_inp, ARRAY_SIZE(ts_dev->config_inp));
 }
-- 
1.9.1
