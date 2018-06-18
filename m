From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 18 Jun 2018 11:56:14 +0100
Subject: [PATCH 1/6] coresight: Cleanup device subtype struct
In-Reply-To: <1529319379-17895-1-git-send-email-suzuki.poulose@arm.com>
References: <1529319379-17895-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1529319379-17895-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clean up our struct a little bit by using a union instead of
a struct for tracking the subtype of a device.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 include/linux/coresight.h | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 69a5c9f..7c188c2 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -63,17 +63,20 @@ enum coresight_dev_subtype_source {
 };
 
 /**
- * struct coresight_dev_subtype - further characterisation of a type
+ * union coresight_dev_subtype - further characterisation of a type
  * @sink_subtype:	type of sink this component is, as defined
-			by @coresight_dev_subtype_sink.
+ *			by @coresight_dev_subtype_sink.
  * @link_subtype:	type of link this component is, as defined
-			by @coresight_dev_subtype_link.
+ *			by @coresight_dev_subtype_link.
  * @source_subtype:	type of source this component is, as defined
-			by @coresight_dev_subtype_source.
+ *			by @coresight_dev_subtype_source.
  */
-struct coresight_dev_subtype {
-	enum coresight_dev_subtype_sink sink_subtype;
-	enum coresight_dev_subtype_link link_subtype;
+union coresight_dev_subtype {
+	/* We have some devices which acts as LINK and SINK */
+	struct {
+		enum coresight_dev_subtype_sink sink_subtype;
+		enum coresight_dev_subtype_link link_subtype;
+	};
 	enum coresight_dev_subtype_source source_subtype;
 };
 
@@ -111,7 +114,7 @@ struct coresight_platform_data {
  */
 struct coresight_desc {
 	enum coresight_dev_type type;
-	struct coresight_dev_subtype subtype;
+	union coresight_dev_subtype subtype;
 	const struct coresight_ops *ops;
 	struct coresight_platform_data *pdata;
 	struct device *dev;
@@ -155,7 +158,7 @@ struct coresight_device {
 	int nr_inport;
 	int nr_outport;
 	enum coresight_dev_type type;
-	struct coresight_dev_subtype subtype;
+	union coresight_dev_subtype subtype;
 	const struct coresight_ops *ops;
 	struct device dev;
 	atomic_t *refcnt;
-- 
2.7.4
