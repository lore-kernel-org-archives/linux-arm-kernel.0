From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 20 May 2015 15:20:33 +0200
Subject: [PATCH 03/16] thermal: remove useless call to
 thermal_zone_device_set_polling
In-Reply-To: <1432128046-12921-1-git-send-email-s.hauer@pengutronix.de>
References: <1432128046-12921-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1432128046-12921-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the thermal zone has no get_temp callback then thermal_zone_device_register()
calls thermal_zone_device_set_polling() with a polling delay of 0. This
only cancels the poll_queue. Since the poll_queue hasn't been scheduled this
is a no-op. Remove it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 244784f..1b68d20 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1571,9 +1571,6 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 
 	INIT_DELAYED_WORK(&(tz->poll_queue), thermal_zone_device_check);
 
-	if (!tz->ops->get_temp)
-		thermal_zone_device_set_polling(tz, 0);
-
 	thermal_zone_device_update(tz);
 
 	return tz;
-- 
2.1.4
