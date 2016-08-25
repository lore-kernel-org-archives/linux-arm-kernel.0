From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 25 Aug 2016 15:19:01 -0600
Subject: [PATCH 11/28] coresight: delay initialisation when children are
 missing
In-Reply-To: <1472159958-5981-1-git-send-email-mathieu.poirier@linaro.org>
References: <1472159958-5981-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1472159958-5981-12-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Depending on when CoreSight device are discovered it is possible
that some IP block may be referencing devices that have not been
added to the bus yet.  The end result is missing nodes in the
CoreSight topology even when the devices are present and properly
initialised.

This patch solves the problem by asking the driver core to
try initialising the device at a later time when the children
of a CoreSight node are missing.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/of_coresight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index b68da1888fd5..18f1c8c4776b 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -166,7 +166,7 @@ struct coresight_platform_data *of_get_coresight_platform_data(
 
 			rdev = of_coresight_get_endpoint_device(rparent);
 			if (!rdev)
-				continue;
+				return ERR_PTR(-EPROBE_DEFER);
 
 			pdata->child_names[i] = dev_name(rdev);
 			pdata->child_ports[i] = rendpoint.id;
-- 
2.7.4
