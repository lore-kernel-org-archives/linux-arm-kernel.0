From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  2 Aug 2017 10:22:09 -0600
Subject: [PATCH 15/26] coresight replicator: Expose replicator management
 registers
In-Reply-To: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
References: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1501690940-4137-16-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Expose the idfilter* registers of the programmable replicator.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-dynamic-replicator.c       | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index c6900f2301de..b00ea2d7d13f 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -95,6 +95,28 @@ static const struct coresight_ops replicator_cs_ops = {
 	.link_ops	= &replicator_link_ops,
 };
 
+#define coresight_replicator_reg(name, offset) \
+	coresight_simple_reg32(struct replicator_state, name, offset)
+
+coresight_replicator_reg(idfilter0, REPLICATOR_IDFILTER0);
+coresight_replicator_reg(idfilter1, REPLICATOR_IDFILTER1);
+
+static struct attribute *replicator_mgmt_attrs[] = {
+	&dev_attr_idfilter0.attr,
+	&dev_attr_idfilter1.attr,
+	NULL,
+};
+
+static const struct attribute_group replicator_mgmt_group = {
+	.attrs = replicator_mgmt_attrs,
+	.name = "mgmt",
+};
+
+static const struct attribute_group *replicator_groups[] = {
+	&replicator_mgmt_group,
+	NULL,
+};
+
 static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	int ret;
@@ -139,6 +161,7 @@ static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.ops = &replicator_cs_ops;
 	desc.pdata = adev->dev.platform_data;
 	desc.dev = &adev->dev;
+	desc.groups = replicator_groups;
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev))
 		return PTR_ERR(drvdata->csdev);
-- 
2.7.4
