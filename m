Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8817AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:58:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5578721905
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nD3Pb/Ls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5578721905
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=17N2zTWNXjsWlrafCGFhYJSkeTw/BhKQOLz8uCPDTpo=; b=nD3Pb/LsrDGrfb
	o/5iz4Zk0wVZv0ruQkLRBEzU9CXvWKendSrjkdHa7rsbHAz0bDXf/gFWy/BnJhNkdELoFY1nt+6QQ
	i/ure9w2atzhKjoGSGOpuSNlFHRDL1IYra/HlXYupilPhRuidJgKRZpe8fvqu+qYjIpHLVRAUJkES
	9G28UNu7XxqH9bfhaXgxeHxmaEX31pTGTv7PYa4WYkDhbl8iM3n/OftlsB6ANrp5bboDYVUeILrWO
	DtwznhqMkdoWB+HBW7saULwJMNW/pCLr49iZuOb+lY8bNS3LFEIaRXQCX1nNAqmECOcCXGLq8OJ0t
	1CCVLkLoTWUUJt9IJxTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw0I5-0002oU-9q; Tue, 19 Feb 2019 07:58:09 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw0HA-0001as-N2
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 07:57:15 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id B5739DA62C566277D21B;
 Tue, 19 Feb 2019 15:57:05 +0800 (CST)
Received: from HGHY1l002753561.china.huawei.com (10.177.23.164) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Tue, 19 Feb 2019 15:56:57 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel
 <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 iommu <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] iommu/arm-smmu-v3: move arm_smmu_get_step_for_sid() a
 little ahead
Date: Tue, 19 Feb 2019 15:54:42 +0800
Message-ID: <20190219075443.17732-5-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <20190219075443.17732-1-thunder.leizhen@huawei.com>
References: <20190219075443.17732-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_235712_915624_1BE2E44A 
X-CRM114-Status: GOOD (  11.48  )
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
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

No functional change, just prepare for the next patch.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 5bb5dcd..84adecc 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1273,6 +1273,28 @@ static int arm_smmu_init_dummy_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 	return __arm_smmu_init_l2_strtab(smmu, sid, &dummy_desc);
 }

+static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
+{
+	__le64 *step;
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
+		struct arm_smmu_strtab_l1_desc *l1_desc;
+		int idx;
+
+		/* Two-level walk */
+		idx = (sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS;
+		l1_desc = &cfg->l1_desc[idx];
+		idx = (sid & ((1 << STRTAB_SPLIT) - 1)) * STRTAB_STE_DWORDS;
+		step = &l1_desc->l2ptr[idx];
+	} else {
+		/* Simple linear lookup */
+		step = &cfg->strtab[sid * STRTAB_STE_DWORDS];
+	}
+
+	return step;
+}
+
 /* IRQ and event handlers */
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
@@ -1704,28 +1726,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	return 0;
 }

-static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
-{
-	__le64 *step;
-	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
-
-	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
-		struct arm_smmu_strtab_l1_desc *l1_desc;
-		int idx;
-
-		/* Two-level walk */
-		idx = (sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS;
-		l1_desc = &cfg->l1_desc[idx];
-		idx = (sid & ((1 << STRTAB_SPLIT) - 1)) * STRTAB_STE_DWORDS;
-		step = &l1_desc->l2ptr[idx];
-	} else {
-		/* Simple linear lookup */
-		step = &cfg->strtab[sid * STRTAB_STE_DWORDS];
-	}
-
-	return step;
-}
-
 static void arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
 {
 	int i, j;
--
1.8.3



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
