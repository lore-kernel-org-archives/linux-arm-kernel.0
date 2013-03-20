From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 20 Mar 2013 19:36:29 -0300
Subject: [PATCH 08/16] thermal: mvebu: Fix temperature output formula for
 kirkwood
In-Reply-To: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1363818997-23137-9-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The temperature formula was taken from the Armada 510 datasheet.
This is wrong because the Kirkwood SoC thermal sensor has
different coefficients.

Fix it using values from 88F682/88F683 Kirkwood datasheet.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/thermal/mvebu_thermal.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
index 5886a9c..ed4c9b0 100644
--- a/drivers/thermal/mvebu_thermal.c
+++ b/drivers/thermal/mvebu_thermal.c
@@ -48,14 +48,9 @@ static int mvebu_get_temp(struct thermal_zone_device *thermal,
 		return -EIO;
 	}
 
-	/*
-	 * Calculate temperature. See Section 8.10.1 of the 88AP510,
-	 * datasheet, which has the same sensor.
-	 * Documentation/arm/Marvell/README
-	 */
 	reg = (reg >> KIRKWOOD_THERMAL_TEMP_OFFSET) &
 		KIRKWOOD_THERMAL_TEMP_MASK;
-	*temp = ((2281638UL - (7298*reg)) / 10);
+	*temp = ((2363302UL - (7339*reg)) / 10);
 
 	return 0;
 }
-- 
1.7.8.6
