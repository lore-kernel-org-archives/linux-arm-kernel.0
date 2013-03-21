From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 21 Mar 2013 17:42:07 -0300
Subject: [PATCH for 3.9] thermal: mvebu: Fix valid check for thermal register
Message-ID: <1363898527-3660-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The correct value is obtain by first shifting the register by the offset,
later applying the valid mask and finally invert the result.
This check was lacking an extra parenthesis to be strictly correct.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
I've taken this fix out of the thermal patchset,
so we can apply it earlier on v3.9.

 drivers/thermal/kirkwood_thermal.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
index 65cb4f0..ee433b7 100644
--- a/drivers/thermal/kirkwood_thermal.c
+++ b/drivers/thermal/kirkwood_thermal.c
@@ -41,8 +41,8 @@ static int kirkwood_get_temp(struct thermal_zone_device *thermal,
 	reg = readl_relaxed(priv->sensor);
 
 	/* Valid check */
-	if (!(reg >> KIRKWOOD_THERMAL_VALID_OFFSET) &
-	    KIRKWOOD_THERMAL_VALID_MASK) {
+	if (!((reg >> KIRKWOOD_THERMAL_VALID_OFFSET) &
+	    KIRKWOOD_THERMAL_VALID_MASK)) {
 		dev_err(&thermal->device,
 			"Temperature sensor reading not valid\n");
 		return -EIO;
-- 
1.7.8.6
