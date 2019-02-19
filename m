Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB08C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:57:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D30D21903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JceY4k1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D30D21903
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J7rJSwaYL/mB/3HH4d7bcDMxFZsB1tfqBUWVIsqKqtQ=; b=JceY4k1l8uK9f3
	yMl0IGTffC9iXZDedVbOCvjkwLStROeebXlKcso+FZw6s/ud+S9lIZJU0Z55jK507ZzHT2oIalAzf
	iFd0zHiFvEjtzfUl+e/8y+WTQWVN9aqXYP3ZQ6/kOcHCeeorxAOGnv6Vp8mDbeVOPCYBFPk4uHWDY
	qYVGmwQKRS0pUDQyyECHvap/+JMFbrvdYzUbsUjch3pC1M87qjcPsff+jBtMQKnd9E0fZMLNxPF+/
	9K0/I1868wIpzZQs4PyOt8HnZWRDUVE2LVAcDRS7NLWiRjHRXmjzMSFK+jXwNJLqSYn3e6lym1+8p
	C5dtQsFDxpx7plv3n5Tg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw0HW-00023a-Co; Tue, 19 Feb 2019 07:57:34 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw0H9-0001at-9G
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 07:57:13 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id BADA7EB5788C8B2F511F;
 Tue, 19 Feb 2019 15:57:05 +0800 (CST)
Received: from HGHY1l002753561.china.huawei.com (10.177.23.164) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Tue, 19 Feb 2019 15:56:55 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel
 <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 iommu <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] iommu/arm-smmu-v3: make smmu can be enabled in kdump
 kernel
Date: Tue, 19 Feb 2019 15:54:40 +0800
Message-ID: <20190219075443.17732-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <20190219075443.17732-1-thunder.leizhen@huawei.com>
References: <20190219075443.17732-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_235711_490192_876BFBB9 
X-CRM114-Status: GOOD (  19.40  )
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

To reduce the risk of further crash, the device_shutdown() was not called
by the first kernel. That means some devices may still working in the
secondary kernel. For example, a netcard may still using ring buffer to
receive the broadcast messages in the kdump kernel. No events are reported
utill the related smmu reinitialized by the kdump kernel.

commit b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is
enabled in kdump kernel") set SMMU_GBPA.ABORT to prevent the unexpected
devices accessing, but it also prevent the devices accessing which we
needed, like hard disk, netcard.

In fact, we can use STE.config=0b000 to abort the unexpected devices
accessing only. As below:
1. In the first kernel, all buffers used by the "unexpected" devices are
   correctly mapped, and it will not be used by the secondary kernel
   because the latter has its dedicated reserved memory.
2. In the secondary kernel, set SMMU_GBPA.ABORT=1 before "disable smmu".
3. In the secondary kernel, after the smmu was disabled, preset all
   STE.config=0b000. For 2-level Stream Table, make all L1STD.l2ptr
   pointer to a dummy L2ST. The dummy L2ST is shared by all L1STDs.
4. In the secondary kernel, enable smmu. For the needed devices, allocate
   new L2STs accordingly.

For phase 1 and 2, the unexpected devices base the old mapping access
memory, it will not corrupt others. For phase 3, SMMU_GBPA abort it. For
phase 4 STE abort it.

Fixes: commit b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions ...")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 72 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 2072897..c3c4ff2 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1219,35 +1219,57 @@ static void arm_smmu_init_bypass_stes(u64 *strtab, unsigned int nent)
 	}
 }

-static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
+static int __arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid,
+				     struct arm_smmu_strtab_l1_desc *desc)
 {
-	size_t size;
 	void *strtab;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
-	struct arm_smmu_strtab_l1_desc *desc = &cfg->l1_desc[sid >> STRTAB_SPLIT];

-	if (desc->l2ptr)
-		return 0;
-
-	size = 1 << (STRTAB_SPLIT + ilog2(STRTAB_STE_DWORDS) + 3);
 	strtab = &cfg->strtab[(sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS];

-	desc->span = STRTAB_SPLIT + 1;
-	desc->l2ptr = dmam_alloc_coherent(smmu->dev, size, &desc->l2ptr_dma,
-					  GFP_KERNEL | __GFP_ZERO);
 	if (!desc->l2ptr) {
-		dev_err(smmu->dev,
-			"failed to allocate l2 stream table for SID %u\n",
-			sid);
-		return -ENOMEM;
+		size_t size;
+
+		size = 1 << (STRTAB_SPLIT + ilog2(STRTAB_STE_DWORDS) + 3);
+		desc->l2ptr = dmam_alloc_coherent(smmu->dev, size,
+						  &desc->l2ptr_dma,
+						  GFP_KERNEL | __GFP_ZERO);
+		if (!desc->l2ptr) {
+			dev_err(smmu->dev,
+				"failed to allocate l2 stream table for SID %u\n",
+				sid);
+			return -ENOMEM;
+		}
+
+		desc->span = STRTAB_SPLIT + 1;
+		arm_smmu_init_bypass_stes(desc->l2ptr, 1 << STRTAB_SPLIT);
 	}

-	arm_smmu_init_bypass_stes(desc->l2ptr, 1 << STRTAB_SPLIT);
 	arm_smmu_write_strtab_l1_desc(strtab, desc);
+	return 0;
+}
+
+static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
+{
+	int ret;
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	struct arm_smmu_strtab_l1_desc *desc = &cfg->l1_desc[sid >> STRTAB_SPLIT];
+
+	ret = __arm_smmu_init_l2_strtab(smmu, sid, desc);
+	if (ret)
+		return ret;
+
 	arm_smmu_sync_std_for_sid(smmu, sid);
 	return 0;
 }

+static int arm_smmu_init_dummy_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
+{
+	static struct arm_smmu_strtab_l1_desc dummy_desc;
+
+	return __arm_smmu_init_l2_strtab(smmu, sid, &dummy_desc);
+}
+
 /* IRQ and event handlers */
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
@@ -2150,8 +2172,12 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
 	}

 	for (i = 0; i < cfg->num_l1_ents; ++i) {
-		arm_smmu_write_strtab_l1_desc(strtab, &cfg->l1_desc[i]);
-		strtab += STRTAB_L1_DESC_DWORDS << 3;
+		if (is_kdump_kernel()) {
+			arm_smmu_init_dummy_l2_strtab(smmu, i << STRTAB_SPLIT);
+		} else {
+			arm_smmu_write_strtab_l1_desc(strtab, &cfg->l1_desc[i]);
+			strtab += STRTAB_L1_DESC_DWORDS << 3;
+		}
 	}

 	return 0;
@@ -2467,11 +2493,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	/* Clear CR0 and sync (disables SMMU and queue processing) */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
 	if (reg & CR0_SMMUEN) {
-		if (is_kdump_kernel()) {
+		if (is_kdump_kernel())
 			arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
-			arm_smmu_device_disable(smmu);
-			return -EBUSY;
-		}

 		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
 	}
@@ -2859,6 +2882,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	bool bypass;

+	/*
+	 * Force to disable bypass for the kdump kernel, abort all incoming
+	 * transactions from the unknown devices.
+	 */
+	if (is_kdump_kernel())
+		disable_bypass = 1;
+
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu) {
 		dev_err(dev, "failed to allocate arm_smmu_device\n");
--
1.8.3



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
