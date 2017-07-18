From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 18 Jul 2017 10:48:06 +0100
Subject: [PATCH v4 09/18] coresight replicator: Expose replicator management
 registers
In-Reply-To: <1500371295-30472-1-git-send-email-suzuki.poulose@arm.com>
References: <1500371295-30472-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1500371295-30472-10-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Expose the idfilter* registers of the programmable replicator.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-dynamic-replicator.c        | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index f8bf995..93c2206 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -95,6 +95,26 @@ static const struct coresight_ops replicator_cs_ops = {
 	.link_ops	= &replicator_link_ops,
 };
 
+coresight_simple_func(struct replicator_state, NULL, idfilter0,
+				 REPLICATOR_IDFILTER0);
+coresight_simple_func(struct replicator_state, NULL, idfilter1,
+				REPLICATOR_IDFILTER1);
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
@@ -139,6 +159,7 @@ static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.ops = &replicator_cs_ops;
 	desc.pdata = adev->dev.platform_data;
 	desc.dev = &adev->dev;
+	desc.groups = replicator_groups;
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev))
 		return PTR_ERR(drvdata->csdev);
-- 
2.7.5
