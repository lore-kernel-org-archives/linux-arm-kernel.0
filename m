From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 20 May 2015 15:20:41 +0200
Subject: [PATCH 11/16] thermal: bang-bang governor: act on lower trip boundary
In-Reply-To: <1432128046-12921-1-git-send-email-s.hauer@pengutronix.de>
References: <1432128046-12921-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1432128046-12921-12-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With interrupt driven thermal zones we pass the lower and upper temperature
on which shall be acted, so in the governor we have to act on the exact lower
temperature to be consistent. Otherwise an interrupt may be generated on the
exact lower temperature, but the bang bang governor does not react.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/thermal/gov_bang_bang.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index 70836c5..9d1dfea 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -59,7 +59,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 		if (instance->target == 0 && tz->temperature >= trip_temp)
 			instance->target = 1;
 		else if (instance->target == 1 &&
-				tz->temperature < trip_temp - trip_hyst)
+				tz->temperature <= trip_temp - trip_hyst)
 			instance->target = 0;
 
 		dev_dbg(&instance->cdev->device, "target=%d\n",
-- 
2.1.4
