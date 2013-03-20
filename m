From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 20 Mar 2013 19:36:26 -0300
Subject: [PATCH 05/16] thermal: mvebu: Fix valid check for thermal register
In-Reply-To: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1363818997-23137-6-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The correct value is obtain by first shifting the register by the offset,
later applying the valid mask and finally invert the result.
This check was lacking an extra parenthesis to be strictly correct.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/thermal/mvebu_thermal.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
index d54f90c..ef04e4e 100644
--- a/drivers/thermal/mvebu_thermal.c
+++ b/drivers/thermal/mvebu_thermal.c
@@ -41,8 +41,8 @@ static int mvebu_get_temp(struct thermal_zone_device *thermal,
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
