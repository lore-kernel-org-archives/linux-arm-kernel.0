From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri,  3 Mar 2017 23:18:45 +0000
Subject: [PATCH V10 2/6] thermal: of-thermal: Implement signed coefficient
 support
In-Reply-To: <1488583129-4159-1-git-send-email-stefan.wahren@i2se.com>
References: <1488583129-4159-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1488583129-4159-3-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new function of_property_read_s32_array() to prepare
of-thermal for negative coefficients. These are used by
the upcoming bcm2835_thermal driver.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/thermal/of-thermal.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index d04ec3b..491d58a 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -821,7 +821,8 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 	struct device_node *child = NULL, *gchild;
 	struct __thermal_zone *tz;
 	int ret, i;
-	u32 prop, coef[2];
+	u32 prop;
+	s32 coef[2];
 
 	if (!np) {
 		pr_err("no thermal zone np\n");
@@ -851,7 +852,7 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 	 * one sensor per thermal zone. Thus, we are considering
 	 * only the first two values as slope and offset.
 	 */
-	ret = of_property_read_u32_array(np, "coefficients", coef, 2);
+	ret = of_property_read_s32_array(np, "coefficients", coef, 2);
 	if (ret == 0) {
 		tz->slope = coef[0];
 		tz->offset = coef[1];
-- 
1.7.9.5
