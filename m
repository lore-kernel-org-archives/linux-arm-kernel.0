From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 11 Sep 2018 15:49:52 -0600
Subject: [PATCH 2/5] coresight: Make link components aware of operation mode
In-Reply-To: <1536702595-9999-1-git-send-email-mathieu.poirier@linaro.org>
References: <1536702595-9999-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1536702595-9999-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following what has been done for source and sinks, make link
devices aware of the mode they are being operated from so that
their verbosity can be controlled.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-dynamic-replicator.c |  4 ++--
 drivers/hwtracing/coresight/coresight-funnel.c             |  4 ++--
 drivers/hwtracing/coresight/coresight-replicator.c         |  4 ++--
 drivers/hwtracing/coresight/coresight-tmc-etf.c            |  4 ++--
 drivers/hwtracing/coresight/coresight.c                    | 13 +++++++------
 include/linux/coresight.h                                  |  6 ++++--
 6 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index ebb80438f6a5..de2c197886c6 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -35,7 +35,7 @@ struct replicator_state {
 };
 
 static int replicator_enable(struct coresight_device *csdev, int inport,
-			      int outport)
+			      int outport, u32 mode)
 {
 	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -61,7 +61,7 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 }
 
 static void replicator_disable(struct coresight_device *csdev, int inport,
-				int outport)
+				int outport, u32 mode)
 {
 	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
 
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index ee7a30bf9480..c1c9f5fccc4b 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -59,7 +59,7 @@ static void funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
 }
 
 static int funnel_enable(struct coresight_device *csdev, int inport,
-			 int outport)
+			 int outport, u32 mode)
 {
 	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -83,7 +83,7 @@ static void funnel_disable_hw(struct funnel_drvdata *drvdata, int inport)
 }
 
 static void funnel_disable(struct coresight_device *csdev, int inport,
-			   int outport)
+			   int outport, u32 mode)
 {
 	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index feac98315471..0b749302c066 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -31,7 +31,7 @@ struct replicator_drvdata {
 };
 
 static int replicator_enable(struct coresight_device *csdev, int inport,
-			     int outport)
+			     int outport, u32 mode)
 {
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -40,7 +40,7 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 }
 
 static void replicator_disable(struct coresight_device *csdev, int inport,
-			       int outport)
+			       int outport, u32 mode)
 {
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 4156c95ce1bb..28b3ff830597 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -269,7 +269,7 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev)
 }
 
 static int tmc_enable_etf_link(struct coresight_device *csdev,
-			       int inport, int outport)
+			       int inport, int outport, u32 mode)
 {
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -289,7 +289,7 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 }
 
 static void tmc_disable_etf_link(struct coresight_device *csdev,
-				 int inport, int outport)
+				 int inport, int outport, u32 mode)
 {
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 118b435f0887..edfb7f8d2f0b 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -161,7 +161,7 @@ static void coresight_disable_sink(struct coresight_device *csdev)
 
 static int coresight_enable_link(struct coresight_device *csdev,
 				 struct coresight_device *parent,
-				 struct coresight_device *child)
+				 struct coresight_device *child, u32 mode)
 {
 	int ret;
 	int link_subtype;
@@ -186,7 +186,8 @@ static int coresight_enable_link(struct coresight_device *csdev,
 
 	if (atomic_inc_return(&csdev->refcnt[refport]) == 1) {
 		if (link_ops(csdev)->enable) {
-			ret = link_ops(csdev)->enable(csdev, inport, outport);
+			ret = link_ops(csdev)->enable(csdev, inport,
+						      outport, mode);
 			if (ret)
 				return ret;
 		}
@@ -199,7 +200,7 @@ static int coresight_enable_link(struct coresight_device *csdev,
 
 static void coresight_disable_link(struct coresight_device *csdev,
 				   struct coresight_device *parent,
-				   struct coresight_device *child)
+				   struct coresight_device *child, u32 mode)
 {
 	int i, nr_conns;
 	int link_subtype;
@@ -225,7 +226,7 @@ static void coresight_disable_link(struct coresight_device *csdev,
 
 	if (atomic_dec_return(&csdev->refcnt[refport]) == 0) {
 		if (link_ops(csdev)->disable)
-			link_ops(csdev)->disable(csdev, inport, outport);
+			link_ops(csdev)->disable(csdev, inport, outport, mode);
 	}
 
 	for (i = 0; i < nr_conns; i++)
@@ -308,7 +309,7 @@ void coresight_disable_path(struct list_head *path, u32 mode)
 		case CORESIGHT_DEV_TYPE_LINK:
 			parent = list_prev_entry(nd, link)->csdev;
 			child = list_next_entry(nd, link)->csdev;
-			coresight_disable_link(csdev, parent, child);
+			coresight_disable_link(csdev, parent, child, mode);
 			break;
 		default:
 			break;
@@ -357,7 +358,7 @@ int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
 		case CORESIGHT_DEV_TYPE_LINK:
 			parent = list_prev_entry(nd, link)->csdev;
 			child = list_next_entry(nd, link)->csdev;
-			ret = coresight_enable_link(csdev, parent, child);
+			ret = coresight_enable_link(csdev, parent, child, mode);
 			if (ret)
 				goto err;
 			break;
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 53535821dc25..8fc6f1e82c17 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -205,8 +205,10 @@ struct coresight_ops_sink {
  * @disable:	disables flow between iport and oport.
  */
 struct coresight_ops_link {
-	int (*enable)(struct coresight_device *csdev, int iport, int oport);
-	void (*disable)(struct coresight_device *csdev, int iport, int oport);
+	int (*enable)(struct coresight_device *csdev,
+		      int iport, int oport, u32 mode);
+	void (*disable)(struct coresight_device *csdev,
+			int iport, int oport, u32 mode);
 };
 
 /**
-- 
2.7.4
