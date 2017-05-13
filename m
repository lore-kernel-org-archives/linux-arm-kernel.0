From: shameerali.kolothum.thodi@huawei.com (shameer)
Date: Sat, 13 May 2017 10:47:26 +0100
Subject: [RFC v1 2/7] iommu/arm-smmu-v3: Add erratum framework functions
In-Reply-To: <20170513094731.3676-1-shameerali.kolothum.thodi@huawei.com>
References: <20170513094731.3676-1-shameerali.kolothum.thodi@huawei.com>
Message-ID: <20170513094731.3676-3-shameerali.kolothum.thodi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will provide a way to replace the existing skip_prefetch_cmd
erratum using the new framework.

Signed-off-by: shameer <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 58 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index a166590..f20d5d5 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -664,16 +664,72 @@ enum smmu_erratum_match_type {
 	se_match_dt,
 };
 
+void erratum_skip_prefetch_cmd(struct arm_smmu_device *smmu, void *arg)
+{
+	smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
+}
+
 struct smmu_erratum_workaround {
 	enum smmu_erratum_match_type match_type;
 	const void *id;	/* Indicate the Erratum ID */
 	const char *desc_str;
+	void (*enable)(struct arm_smmu_device *, void *);
 };
 
 static const struct smmu_erratum_workaround smmu_workarounds[] = {
 
 };
 
+typedef bool (*se_match_fn_t)(const struct smmu_erratum_workaround *,
+							  const void *);
+static
+bool smmu_check_dt_erratum(const struct smmu_erratum_workaround *wa,
+						   const void *arg)
+{
+	const struct device_node *np = arg;
+
+	return of_property_read_bool(np, wa->id);
+}
+
+static void smmu_enable_errata(struct arm_smmu_device *smmu,
+				enum smmu_erratum_match_type type,
+				se_match_fn_t match_fn,
+				void *arg)
+{
+	const struct smmu_erratum_workaround *wa = smmu_workarounds;
+
+	for (; wa->desc_str; wa++) {
+		if (wa->match_type != type)
+			continue;
+
+		if (match_fn(wa, arg)) {
+			if (wa->enable) {
+				wa->enable(smmu, arg);
+				dev_info(smmu->dev,
+					"Enabling workaround for %s\n",
+					 wa->desc_str);
+			}
+		}
+	}
+}
+
+
+static void smmu_check_workarounds(struct arm_smmu_device *smmu,
+				  enum smmu_erratum_match_type type,
+				  void *arg)
+{
+	se_match_fn_t match_fn = NULL;
+
+	switch (type) {
+	case se_match_dt:
+		match_fn = smmu_check_dt_erratum;
+		break;
+	}
+
+	smmu_enable_errata(smmu, type, match_fn, arg);
+
+}
+
 static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct arm_smmu_domain, domain);
@@ -2641,6 +2697,8 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 
 	parse_driver_options(smmu);
 
+	smmu_check_workarounds(smmu, se_match_dt, dev->of_node);
+
 	if (of_dma_is_coherent(dev->of_node))
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
-- 
2.5.0
