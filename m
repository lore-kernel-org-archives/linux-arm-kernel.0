From: andre.przywara@arm.com (Andre Przywara)
Date: Wed,  7 Mar 2018 02:07:16 +0000
Subject: [PATCH 2/5] pwm: sun4i: simplify controller mapping
In-Reply-To: <20180307020719.6675-1-andre.przywara@arm.com>
References: <20180307020719.6675-1-andre.przywara@arm.com>
Message-ID: <20180307020719.6675-3-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the moment we assign our supported compatible strings to a respective
instance of our sun4i_pwm_data structure, even though some of them
are the same.
To avoid further clutter, split out the three different combinations of
features we have at the moment and name them accordingly.
This should make it more obvious which compatible string to use for new
SoCs.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/pwm/pwm-sun4i.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index b3e4a4b3774d..078172dee462 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -310,27 +310,17 @@ static const struct pwm_ops sun4i_pwm_ops = {
 	.owner = THIS_MODULE,
 };
 
-static const struct sun4i_pwm_data sun4i_pwm_data_a10 = {
+static const struct sun4i_pwm_data sun4i_pwm_dual_nobypass = {
 	.has_prescaler_bypass = false,
 	.npwm = 2,
 };
 
-static const struct sun4i_pwm_data sun4i_pwm_data_a10s = {
+static const struct sun4i_pwm_data sun4i_pwm_dual_bypass = {
 	.has_prescaler_bypass = true,
 	.npwm = 2,
 };
 
-static const struct sun4i_pwm_data sun4i_pwm_data_a13 = {
-	.has_prescaler_bypass = true,
-	.npwm = 1,
-};
-
-static const struct sun4i_pwm_data sun4i_pwm_data_a20 = {
-	.has_prescaler_bypass = true,
-	.npwm = 2,
-};
-
-static const struct sun4i_pwm_data sun4i_pwm_data_h3 = {
+static const struct sun4i_pwm_data sun4i_pwm_single_bypass = {
 	.has_prescaler_bypass = true,
 	.npwm = 1,
 };
@@ -338,19 +328,19 @@ static const struct sun4i_pwm_data sun4i_pwm_data_h3 = {
 static const struct of_device_id sun4i_pwm_dt_ids[] = {
 	{
 		.compatible = "allwinner,sun4i-a10-pwm",
-		.data = &sun4i_pwm_data_a10,
+		.data = &sun4i_pwm_dual_nobypass,
 	}, {
 		.compatible = "allwinner,sun5i-a10s-pwm",
-		.data = &sun4i_pwm_data_a10s,
+		.data = &sun4i_pwm_dual_bypass,
 	}, {
 		.compatible = "allwinner,sun5i-a13-pwm",
-		.data = &sun4i_pwm_data_a13,
+		.data = &sun4i_pwm_single_bypass,
 	}, {
 		.compatible = "allwinner,sun7i-a20-pwm",
-		.data = &sun4i_pwm_data_a20,
+		.data = &sun4i_pwm_dual_bypass,
 	}, {
 		.compatible = "allwinner,sun8i-h3-pwm",
-		.data = &sun4i_pwm_data_h3,
+		.data = &sun4i_pwm_single_bypass,
 	}, {
 		/* sentinel */
 	},
-- 
2.14.1
