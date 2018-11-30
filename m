Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961D3C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:49:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A5B920834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SHetbPe4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5B920834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1Pc7FYhlvAPa/mRNkwnCufXLnJYv20AqB1SzM77Fkck=; b=SHetbPe4fDXYdv
	FHI26oFeWCuHKCDUopkHW8/875jI5fZFqhClVyR9+yVWj3+UiAKltgN6vtpTfUbd2VtEVlY4Lg6Qm
	D5H1ep6mQLL5sVNISpJkbfeBmoiZ3QbIYEBz3LjXSfOXVWkKcF12XRn+WITq1+hV1oY61IPFH9NBU
	p7PDQyKQ7PSc/wQJS2lQBhlnq92cKNTgFh0Ge0wMPLGw8QusmElBH2U/LXQ/Mk7RBNycCRrSGEaA0
	cYabEFIblDimC7dR5H96PK76R98nQ90RvVuPB1p+pnRsO48rjvUC9NJ8hv/qusrivzGpCGNcz1rM6
	BOBnEnIsBY5izJpZGbxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSl36-0004lm-En; Fri, 30 Nov 2018 15:49:48 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSl33-0004je-5h
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 15:49:46 +0000
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 0A3DFE2878776;
 Fri, 30 Nov 2018 23:49:30 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Fri, 30 Nov 2018 23:49:24 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <lorenzo.pieralisi@arm.com>, <robin.murphy@arm.com>
Subject: [PATCH v5 3/4] perf/smmuv3: Add MSI irq support
Date: Fri, 30 Nov 2018 15:47:50 +0000
Message-ID: <20181130154751.28580-4-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20181130154751.28580-1-shameerali.kolothum.thodi@huawei.com>
References: <20181130154751.28580-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_074945_388671_5AD75241 
X-CRM114-Status: GOOD (  11.54  )
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

This adds support for MSI-based counter overflow interrupt.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 58 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index fb9dcd8..71d10a0 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -68,6 +68,7 @@
 #define SMMU_PMCG_OVSSET0               0xCC0
 #define SMMU_PMCG_CFGR                  0xE00
 #define SMMU_PMCG_CFGR_RELOC_CTRS       BIT(20)
+#define SMMU_PMCG_CFGR_MSI              BIT(21)
 #define SMMU_PMCG_CFGR_SID_FILTER_TYPE  BIT(23)
 #define SMMU_PMCG_CFGR_SIZE_MASK        GENMASK(13, 8)
 #define SMMU_PMCG_CFGR_NCTR_MASK        GENMASK(5, 0)
@@ -78,6 +79,12 @@
 #define SMMU_PMCG_IRQ_CTRL              0xE50
 #define SMMU_PMCG_IRQ_CTRL_IRQEN        BIT(0)
 #define SMMU_PMCG_IRQ_CFG0              0xE58
+#define SMMU_PMCG_IRQ_CFG1              0xE60
+#define SMMU_PMCG_IRQ_CFG2              0xE64
+
+/* MSI config fields */
+#define MSI_CFG0_ADDR_MASK              GENMASK_ULL(51, 2)
+#define MSI_CFG2_MEMATTR_DEVICE_nGnRE   0x1
 
 #define SMMU_DEFAULT_FILTER_SPAN        1
 #define SMMU_DEFAULT_FILTER_STREAM_ID   GENMASK(31, 0)
@@ -587,11 +594,62 @@ static irqreturn_t smmu_pmu_handle_irq(int irq_num, void *data)
 	return IRQ_HANDLED;
 }
 
+static void smmu_pmu_free_msis(void *data)
+{
+	struct device *dev = data;
+
+	platform_msi_domain_free_irqs(dev);
+}
+
+static void smmu_pmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	phys_addr_t doorbell;
+	struct device *dev = msi_desc_to_dev(desc);
+	struct smmu_pmu *pmu = dev_get_drvdata(dev);
+
+	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
+	doorbell &= MSI_CFG0_ADDR_MASK;
+
+	writeq_relaxed(doorbell, pmu->reg_base + SMMU_PMCG_IRQ_CFG0);
+	writel_relaxed(msg->data, pmu->reg_base + SMMU_PMCG_IRQ_CFG1);
+	writel_relaxed(MSI_CFG2_MEMATTR_DEVICE_nGnRE,
+		       pmu->reg_base + SMMU_PMCG_IRQ_CFG2);
+}
+
+static void smmu_pmu_setup_msi(struct smmu_pmu *pmu)
+{
+	struct msi_desc *desc;
+	struct device *dev = pmu->dev;
+	int ret;
+
+	/* Clear MSI address reg */
+	writeq_relaxed(0, pmu->reg_base + SMMU_PMCG_IRQ_CFG0);
+
+	/* MSI supported or not */
+	if (!(readl(pmu->reg_base + SMMU_PMCG_CFGR) & SMMU_PMCG_CFGR_MSI))
+		return;
+
+	ret = platform_msi_domain_alloc_irqs(dev, 1, smmu_pmu_write_msi_msg);
+	if (ret) {
+		dev_warn(dev, "failed to allocate MSIs\n");
+		return;
+	}
+
+	desc = first_msi_entry(dev);
+	if (desc)
+		pmu->irq = desc->irq;
+
+	/* Add callback to free MSIs on teardown */
+	devm_add_action(dev, smmu_pmu_free_msis, dev);
+}
+
 static int smmu_pmu_setup_irq(struct smmu_pmu *pmu)
 {
 	unsigned long flags = IRQF_NOBALANCING | IRQF_SHARED | IRQF_NO_THREAD;
 	int irq, ret = -ENXIO;
 
+	smmu_pmu_setup_msi(pmu);
+
 	irq = pmu->irq;
 	if (irq)
 		ret = devm_request_irq(pmu->dev, irq, smmu_pmu_handle_irq,
-- 
2.7.4



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
