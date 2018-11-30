Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EC1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:50:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8101320867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B944zPbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8101320867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S5KJpzjr7T6E7zFKvbljfNyd/4Ig7k2oxYK2hqSH7OA=; b=B944zPbWyW3qGm
	bERxv+6Dha9ahsvlP4pPZljrRxgdqiA2UNCCaGKJ3tf6q8+wVTJJDN1aCfpEekaCnt6E1frNbpuvZ
	p7n2h2b3pVPQD4Un0Yb7EnutUTC8RRcv+vBTwQIKIqjmQ3U/OAQNEkk2fpwbk5YqVt5SsgyfzuXpp
	/2W8lr3d9/AfY+jOWdhyDUeC3o4vrQLg1V/yuf1/eQiz6nF/9QpRGVBY3CdaG0MGLKFkpJ4d6ui0u
	h54PIn7icziG2frkR/K/72FqyrGEHEuWzXW5ak2302zKEx8xVSaHREfm5xNEf5/0vvGxr/sbImOf0
	HR9mIzV3+ly6MXO0Gu8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSl3p-0006aU-Hg; Fri, 30 Nov 2018 15:50:33 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSl32-0004hY-H5
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 15:49:48 +0000
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 87FE59AF47056;
 Fri, 30 Nov 2018 23:49:24 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Fri, 30 Nov 2018 23:49:16 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <lorenzo.pieralisi@arm.com>, <robin.murphy@arm.com>
Subject: [PATCH v5 1/4] acpi: arm64: add iort support for PMCG
Date: Fri, 30 Nov 2018 15:47:48 +0000
Message-ID: <20181130154751.28580-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20181130154751.28580-1-shameerali.kolothum.thodi@huawei.com>
References: <20181130154751.28580-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_074945_458288_DF987A74 
X-CRM114-Status: GOOD (  15.16  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, vkilari@codeaurora.org, neil.m.leeder@gmail.com,
 jean-philippe.brucker@arm.com, pabba@codeaurora.org, john.garry@huawei.com,
 will.deacon@arm.com, rruigrok@codeaurora.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, guohanjun@huawei.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Neil Leeder <nleeder@codeaurora.org>

Add support for the SMMU Performance Monitor Counter Group
information from ACPI. This is in preparation for its use
in the SMMUv3 PMU driver.

Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/acpi/arm64/iort.c | 97 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 2a361e2..2da08e1 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -356,7 +356,8 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
 		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
 		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
-		    node->type == ACPI_IORT_NODE_SMMU_V3) {
+		    node->type == ACPI_IORT_NODE_SMMU_V3 ||
+		    node->type == ACPI_IORT_NODE_PMCG) {
 			*id_out = map->output_base;
 			return parent;
 		}
@@ -394,6 +395,8 @@ static int iort_get_id_mapping_index(struct acpi_iort_node *node)
 		}
 
 		return smmu->id_mapping_index;
+	case ACPI_IORT_NODE_PMCG:
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -1216,14 +1219,23 @@ static void __init arm_smmu_v3_init_resources(struct resource *res,
 	}
 }
 
-static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
+static void __init arm_smmu_v3_dma_configure(struct device *dev,
+					     struct acpi_iort_node *node)
 {
 	struct acpi_iort_smmu_v3 *smmu;
+	enum dev_dma_attr attr;
 
 	/* Retrieve SMMUv3 specific data */
 	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
 
-	return smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
+	attr = (smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE) ?
+			DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
+
+	/* We expect the dma masks to be equivalent for all SMMUv3 set-ups */
+	dev->dma_mask = &dev->coherent_dma_mask;
+
+	/* Configure DMA for the page table walker */
+	acpi_dma_configure(dev, attr);
 }
 
 #if defined(CONFIG_ACPI_NUMA)
@@ -1299,20 +1311,64 @@ static void __init arm_smmu_init_resources(struct resource *res,
 	}
 }
 
-static bool __init arm_smmu_is_coherent(struct acpi_iort_node *node)
+static void __init arm_smmu_dma_configure(struct device *dev,
+					  struct acpi_iort_node *node)
 {
 	struct acpi_iort_smmu *smmu;
+	enum dev_dma_attr attr;
 
 	/* Retrieve SMMU specific data */
 	smmu = (struct acpi_iort_smmu *)node->node_data;
 
-	return smmu->flags & ACPI_IORT_SMMU_COHERENT_WALK;
+	attr = (smmu->flags & ACPI_IORT_SMMU_COHERENT_WALK) ?
+			DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
+
+	/* We expect the dma masks to be equivalent for SMMU set-ups */
+	dev->dma_mask = &dev->coherent_dma_mask;
+
+	/* Configure DMA for the page table walker */
+	acpi_dma_configure(dev, attr);
+}
+
+static int __init arm_smmu_v3_pmcg_count_resources(struct acpi_iort_node *node)
+{
+	struct acpi_iort_pmcg *pmcg;
+
+	/* Retrieve PMCG specific data */
+	pmcg = (struct acpi_iort_pmcg *)node->node_data;
+
+	/*
+	 * There are always 2 memory resources.
+	 * If the overflow_gsiv is present then add that for a total of 3.
+	 */
+	return pmcg->overflow_gsiv ? 3 : 2;
+}
+
+static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
+					       struct acpi_iort_node *node)
+{
+	struct acpi_iort_pmcg *pmcg;
+
+	/* Retrieve PMCG specific data */
+	pmcg = (struct acpi_iort_pmcg *)node->node_data;
+
+	res[0].start = pmcg->page0_base_address;
+	res[0].end = pmcg->page0_base_address + SZ_4K - 1;
+	res[0].flags = IORESOURCE_MEM;
+	res[1].start = pmcg->page1_base_address;
+	res[1].end = pmcg->page1_base_address + SZ_4K - 1;
+	res[1].flags = IORESOURCE_MEM;
+
+	if (pmcg->overflow_gsiv)
+		acpi_iort_register_irq(pmcg->overflow_gsiv, "overflow",
+				       ACPI_EDGE_SENSITIVE, &res[2]);
 }
 
 struct iort_dev_config {
 	const char *name;
 	int (*dev_init)(struct acpi_iort_node *node);
-	bool (*dev_is_coherent)(struct acpi_iort_node *node);
+	void (*dev_dma_configure)(struct device *dev,
+				    struct acpi_iort_node *node);
 	int (*dev_count_resources)(struct acpi_iort_node *node);
 	void (*dev_init_resources)(struct resource *res,
 				     struct acpi_iort_node *node);
@@ -1322,7 +1378,7 @@ struct iort_dev_config {
 
 static const struct iort_dev_config iort_arm_smmu_v3_cfg __initconst = {
 	.name = "arm-smmu-v3",
-	.dev_is_coherent = arm_smmu_v3_is_coherent,
+	.dev_dma_configure = arm_smmu_v3_dma_configure,
 	.dev_count_resources = arm_smmu_v3_count_resources,
 	.dev_init_resources = arm_smmu_v3_init_resources,
 	.dev_set_proximity = arm_smmu_v3_set_proximity,
@@ -1330,19 +1386,28 @@ static const struct iort_dev_config iort_arm_smmu_v3_cfg __initconst = {
 
 static const struct iort_dev_config iort_arm_smmu_cfg __initconst = {
 	.name = "arm-smmu",
-	.dev_is_coherent = arm_smmu_is_coherent,
+	.dev_dma_configure = arm_smmu_dma_configure,
 	.dev_count_resources = arm_smmu_count_resources,
-	.dev_init_resources = arm_smmu_init_resources
+	.dev_init_resources = arm_smmu_init_resources,
+};
+
+static const struct iort_dev_config iort_arm_smmu_v3_pmcg_cfg __initconst = {
+	.name = "arm-smmu-v3-pmu",
+	.dev_count_resources = arm_smmu_v3_pmcg_count_resources,
+	.dev_init_resources = arm_smmu_v3_pmcg_init_resources,
 };
 
 static __init const struct iort_dev_config *iort_get_dev_cfg(
 			struct acpi_iort_node *node)
 {
+
 	switch (node->type) {
 	case ACPI_IORT_NODE_SMMU_V3:
 		return &iort_arm_smmu_v3_cfg;
 	case ACPI_IORT_NODE_SMMU:
 		return &iort_arm_smmu_cfg;
+	case ACPI_IORT_NODE_PMCG:
+		return &iort_arm_smmu_v3_pmcg_cfg;
 	default:
 		return NULL;
 	}
@@ -1360,7 +1425,6 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
 	struct fwnode_handle *fwnode;
 	struct platform_device *pdev;
 	struct resource *r;
-	enum dev_dma_attr attr;
 	int ret, count;
 
 	pdev = platform_device_alloc(ops->name, PLATFORM_DEVID_AUTO);
@@ -1398,12 +1462,6 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
 	if (ret)
 		goto dev_put;
 
-	/*
-	 * We expect the dma masks to be equivalent for
-	 * all SMMUs set-ups
-	 */
-	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
-
 	fwnode = iort_get_fwnode(node);
 
 	if (!fwnode) {
@@ -1413,11 +1471,8 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
 
 	pdev->dev.fwnode = fwnode;
 
-	attr = ops->dev_is_coherent && ops->dev_is_coherent(node) ?
-			DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
-
-	/* Configure DMA for the page table walker */
-	acpi_dma_configure(&pdev->dev, attr);
+	if (ops->dev_dma_configure)
+		ops->dev_dma_configure(&pdev->dev, node);
 
 	iort_set_device_domain(&pdev->dev, node);
 
-- 
2.7.4



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
