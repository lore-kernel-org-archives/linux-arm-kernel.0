From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 22 Mar 2016 14:23:22 -0600
Subject: [PATCH 14/14] coresight: configuring ETF in FIFO mode when acting as
 link
In-Reply-To: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
References: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1458678202-3447-15-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When part of a path but not identified as a sink, the EFT has to
be configured as a link and placed in HW FIFO mode.  As such when
enabling a path, call the right configuration function based on
the role the ETF if playing in this trace run.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 6ec2b66af9ee..fa7ecbd99901 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -287,15 +287,27 @@ int coresight_enable_path(struct list_head *path, u32 mode)
 {
 
 	int ret = 0;
+	u32 type;
 	struct coresight_node *nd;
 	struct coresight_device *csdev, *parent, *child;
 
 	list_for_each_entry_reverse(nd, path, link) {
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
 			ret = coresight_enable_sink(csdev, mode);
 			if (ret)
 				goto err;
@@ -304,6 +316,7 @@ int coresight_enable_path(struct list_head *path, u32 mode)
 			/* sources are enabled from either sysFS or Perf */
 			break;
 		case CORESIGHT_DEV_TYPE_LINK:
+		case CORESIGHT_DEV_TYPE_LINKSINK:
 			parent = list_prev_entry(nd, link)->csdev;
 			child = list_next_entry(nd, link)->csdev;
 			ret = coresight_enable_link(csdev, parent, child);
-- 
2.1.4
