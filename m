From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 12 Apr 2016 11:54:52 -0600
Subject: [PATCH V2 15/15] coresight: configuring ETF in FIFO mode when acting
 as link
In-Reply-To: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1460483692-25061-16-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When part of a path but not identified as a sink, the EFT has to
be configured as a link and placed in HW FIFO mode.  As such when
enabling a path, call the right configuration function based on
the role the ETF if playing in this trace run.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 2ea5961092c1..bba9f3d653c9 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -257,15 +257,27 @@ static void coresight_disable_source(struct coresight_device *csdev)
 
 void coresight_disable_path(struct list_head *path)
 {
+	u32 type;
 	struct coresight_node *nd;
 	struct coresight_device *csdev, *parent, *child;
 
 	list_for_each_entry(nd, path, link) {
 		csdev = nd->csdev;
+		type = csdev->type;
 
-		switch (csdev->type) {
+		/*
+		 * ETF devices are tricky... They can be a link or a sink,
+		 * depending on how they are configured.  If an ETF has been
+		 * "activated" it will be configured as a sink, otherwise
+		 * go ahead with the link configuration.
+		 */
+		if (type == CORESIGHT_DEV_TYPE_LINKSINK)
+			type = (csdev == coresight_get_sink(path)) ?
+						CORESIGHT_DEV_TYPE_SINK :
+						CORESIGHT_DEV_TYPE_LINK;
+
+		switch (type) {
 		case CORESIGHT_DEV_TYPE_SINK:
-		case CORESIGHT_DEV_TYPE_LINKSINK:
 			coresight_disable_sink(csdev);
 			break;
 		case CORESIGHT_DEV_TYPE_SOURCE:
@@ -286,15 +298,27 @@ int coresight_enable_path(struct list_head *path, u32 mode)
 {
 
 	int ret = 0;
+	u32 type;
 	struct coresight_node *nd;
 	struct coresight_device *csdev, *parent, *child;
 
 	list_for_each_entry_reverse(nd, path, link) {
 		csdev = nd->csdev;
+		type = csdev->type;
+
+		/*
+		 * ETF devices are tricky... They can be a link or a sink,
+		 * depending on how they are configured.  If an ETF has been
+		 * "activated" it will be configured as a sink, otherwise
+		 * go ahead with the link configuration.
+		 */
+		if (type == CORESIGHT_DEV_TYPE_LINKSINK)
+			type = (csdev == coresight_get_sink(path)) ?
+						CORESIGHT_DEV_TYPE_SINK :
+						CORESIGHT_DEV_TYPE_LINK;
 
-		switch (csdev->type) {
+		switch (type) {
 		case CORESIGHT_DEV_TYPE_SINK:
-		case CORESIGHT_DEV_TYPE_LINKSINK:
 			ret = coresight_enable_sink(csdev, mode);
 			if (ret)
 				goto err;
-- 
2.5.0
