From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri,  1 Jun 2018 14:16:04 +0100
Subject: [RFC PATCH 5/8] coresight: Handle errors in finding input/output ports
In-Reply-To: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1527858967-16047-6-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we fail to find the input / output port for a LINK component
while enabling a path, we should fail gracefully rather than
assuming port "0".

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 3b3756e..4dcea6e 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -115,7 +115,7 @@ static int coresight_find_link_inport(struct coresight_device *csdev,
 	dev_err(&csdev->dev, "couldn't find inport, parent: %s, child: %s\n",
 		dev_name(&parent->dev), dev_name(&csdev->dev));
 
-	return 0;
+	return -ENODEV;
 }
 
 static int coresight_find_link_outport(struct coresight_device *csdev,
@@ -133,7 +133,7 @@ static int coresight_find_link_outport(struct coresight_device *csdev,
 	dev_err(&csdev->dev, "couldn't find outport, parent: %s, child: %s\n",
 		dev_name(&csdev->dev), dev_name(&child->dev));
 
-	return 0;
+	return -ENODEV;
 }
 
 static int coresight_enable_sink(struct coresight_device *csdev, u32 mode)
@@ -186,6 +186,9 @@ static int coresight_enable_link(struct coresight_device *csdev,
 	else
 		refport = 0;
 
+	if (refport < 0)
+		return refport;
+
 	if (atomic_inc_return(&csdev->refcnt[refport]) == 1) {
 		if (link_ops(csdev)->enable) {
 			ret = link_ops(csdev)->enable(csdev, inport, outport);
-- 
2.7.4
