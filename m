From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 18 Dec 2017 11:05:42 -0700
Subject: [PATCH 1/4] coresight: Deduplicate bus_find_device() by name matching
In-Reply-To: <1513620345-1366-1-git-send-email-mathieu.poirier@linaro.org>
References: <1513620345-1366-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1513620345-1366-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lukas Wunner <lukas@wunner.de>

No need to reinvent the wheel, we have bus_find_device_by_name().

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index b8091bef21dc..389c4baeca9d 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -843,32 +843,17 @@ static void coresight_fixup_orphan_conns(struct coresight_device *csdev)
 }
 
 
-static int coresight_name_match(struct device *dev, void *data)
-{
-	char *to_match;
-	struct coresight_device *i_csdev;
-
-	to_match = data;
-	i_csdev = to_coresight_device(dev);
-
-	if (to_match && !strcmp(to_match, dev_name(&i_csdev->dev)))
-		return 1;
-
-	return 0;
-}
-
 static void coresight_fixup_device_conns(struct coresight_device *csdev)
 {
 	int i;
-	struct device *dev = NULL;
-	struct coresight_connection *conn;
 
 	for (i = 0; i < csdev->nr_outport; i++) {
-		conn = &csdev->conns[i];
-		dev = bus_find_device(&coresight_bustype, NULL,
-				      (void *)conn->child_name,
-				      coresight_name_match);
+		struct coresight_connection *conn = &csdev->conns[i];
+		struct device *dev = NULL;
 
+		if (conn->child_name)
+			dev = bus_find_device_by_name(&coresight_bustype, NULL,
+						      conn->child_name);
 		if (dev) {
 			conn->child_dev = to_coresight_device(dev);
 			/* and put reference from 'bus_find_device()' */
-- 
2.7.4
