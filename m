Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFACC10F06
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:08:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F06D721934
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iE20i937"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06D721934
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OMSje7DuMA/CtJcppUTvZXF7F8p3tYiP3bIGwA7tOkI=; b=iE20i937zgMalS
	s4TusYGbIISKnky+g7LHccQb3zkOCBKL9ncov07sJvfh/OjkmbH8Q6oxQ3JGIc1N2uGOo8emxQe2A
	hTZatu5Z2MLNNey87PeX7kpOmzNzD02jHA9Li2jsuBBnRbQ/wYztKuAusmfSA+veUkry+eNZnPkJs
	OpN6uyqXHJSE+URDMNl6PtXVJzRivcCEfuFjb38BPAsFA48tSJx2kVwAHip61R6/ay5IxITkUWJBp
	rMKhsEB3DpUza7tWZuYxn+nIEOXa/fnAuDNwcvKPJwHgiz/6tvrT/QypPu7pSSm/u3ICqW45RE/sV
	TB9uL3F3VObI3IQQSvjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvIQx-00058b-V1; Sun, 17 Feb 2019 09:08:23 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvIQA-0004CI-A0; Sun, 17 Feb 2019 09:07:36 +0000
X-UUID: 8a6e49a334d74e1dbd2b0fb4222ff260-20190217
X-UUID: 8a6e49a334d74e1dbd2b0fb4222ff260-20190217
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 313379416; Sun, 17 Feb 2019 01:07:16 -0800
Received: from mtkmbs03n1.mediatek.inc (172.21.101.181) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 17 Feb 2019 01:07:15 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 17 Feb 2019 17:07:13 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 17 Feb 2019 17:07:12 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v6 05/22] iommu/io-pgtable-arm-v7s: Add paddr_to_iopte and
 iopte_to_paddr helpers
Date: Sun, 17 Feb 2019 17:04:43 +0800
Message-ID: <1550394300-17420-6-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_010734_484737_439A888C 
X-CRM114-Status: GOOD (  12.94  )
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
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com, Will
 Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Matthias Kaehlcke <mka@chromium.org>,
 linux-mediatek@lists.infradead.org, yong.wu@mediatek.com,
 yingjoe.chen@mediatek.com, anan.sun@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add two helper functions: paddr_to_iopte and iopte_to_paddr.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 45 ++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index cec29bf..11d8505 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -173,18 +173,38 @@ struct arm_v7s_io_pgtable {
 	spinlock_t		split_lock;
 };
 
+static bool arm_v7s_pte_is_cont(arm_v7s_iopte pte, int lvl);
+
 static dma_addr_t __arm_v7s_dma_addr(void *pages)
 {
 	return (dma_addr_t)virt_to_phys(pages);
 }
 
-static arm_v7s_iopte *iopte_deref(arm_v7s_iopte pte, int lvl)
+static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
+				    struct io_pgtable_cfg *cfg)
 {
+	return paddr & ARM_V7S_LVL_MASK(lvl);
+}
+
+static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
+				  struct io_pgtable_cfg *cfg)
+{
+	arm_v7s_iopte mask;
+
 	if (ARM_V7S_PTE_IS_TABLE(pte, lvl))
-		pte &= ARM_V7S_TABLE_MASK;
+		mask = ARM_V7S_TABLE_MASK;
+	else if (arm_v7s_pte_is_cont(pte, lvl))
+		mask = ARM_V7S_LVL_MASK(lvl) * ARM_V7S_CONT_PAGES;
 	else
-		pte &= ARM_V7S_LVL_MASK(lvl);
-	return phys_to_virt(pte);
+		mask = ARM_V7S_LVL_MASK(lvl);
+
+	return pte & mask;
+}
+
+static arm_v7s_iopte *iopte_deref(arm_v7s_iopte pte, int lvl,
+				  struct arm_v7s_io_pgtable *data)
+{
+	return phys_to_virt(iopte_to_paddr(pte, lvl, &data->iop.cfg));
 }
 
 static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
@@ -396,7 +416,7 @@ static int arm_v7s_init_pte(struct arm_v7s_io_pgtable *data,
 	if (num_entries > 1)
 		pte = arm_v7s_pte_to_cont(pte, lvl);
 
-	pte |= paddr & ARM_V7S_LVL_MASK(lvl);
+	pte |= paddr_to_iopte(paddr, lvl, cfg);
 
 	__arm_v7s_set_pte(ptep, pte, num_entries, cfg);
 	return 0;
@@ -462,7 +482,7 @@ static int __arm_v7s_map(struct arm_v7s_io_pgtable *data, unsigned long iova,
 	}
 
 	if (ARM_V7S_PTE_IS_TABLE(pte, lvl)) {
-		cptep = iopte_deref(pte, lvl);
+		cptep = iopte_deref(pte, lvl, data);
 	} else if (pte) {
 		/* We require an unmap first */
 		WARN_ON(!selftest_running);
@@ -512,7 +532,8 @@ static void arm_v7s_free_pgtable(struct io_pgtable *iop)
 		arm_v7s_iopte pte = data->pgd[i];
 
 		if (ARM_V7S_PTE_IS_TABLE(pte, 1))
-			__arm_v7s_free_table(iopte_deref(pte, 1), 2, data);
+			__arm_v7s_free_table(iopte_deref(pte, 1, data),
+					     2, data);
 	}
 	__arm_v7s_free_table(data->pgd, 1, data);
 	kmem_cache_destroy(data->l2_tables);
@@ -582,7 +603,7 @@ static size_t arm_v7s_split_blk_unmap(struct arm_v7s_io_pgtable *data,
 		if (!ARM_V7S_PTE_IS_TABLE(pte, 1))
 			return 0;
 
-		tablep = iopte_deref(pte, 1);
+		tablep = iopte_deref(pte, 1, data);
 		return __arm_v7s_unmap(data, iova, size, 2, tablep);
 	}
 
@@ -641,7 +662,7 @@ static size_t __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
 				io_pgtable_tlb_add_flush(iop, iova, blk_size,
 					ARM_V7S_BLOCK_SIZE(lvl + 1), false);
 				io_pgtable_tlb_sync(iop);
-				ptep = iopte_deref(pte[i], lvl);
+				ptep = iopte_deref(pte[i], lvl, data);
 				__arm_v7s_free_table(ptep, lvl + 1, data);
 			} else if (iop->cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT) {
 				/*
@@ -666,7 +687,7 @@ static size_t __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
 	}
 
 	/* Keep on walkin' */
-	ptep = iopte_deref(pte[0], lvl);
+	ptep = iopte_deref(pte[0], lvl, data);
 	return __arm_v7s_unmap(data, iova, size, lvl + 1, ptep);
 }
 
@@ -692,7 +713,7 @@ static phys_addr_t arm_v7s_iova_to_phys(struct io_pgtable_ops *ops,
 	do {
 		ptep += ARM_V7S_LVL_IDX(iova, ++lvl);
 		pte = READ_ONCE(*ptep);
-		ptep = iopte_deref(pte, lvl);
+		ptep = iopte_deref(pte, lvl, data);
 	} while (ARM_V7S_PTE_IS_TABLE(pte, lvl));
 
 	if (!ARM_V7S_PTE_IS_VALID(pte))
@@ -701,7 +722,7 @@ static phys_addr_t arm_v7s_iova_to_phys(struct io_pgtable_ops *ops,
 	mask = ARM_V7S_LVL_MASK(lvl);
 	if (arm_v7s_pte_is_cont(pte, lvl))
 		mask *= ARM_V7S_CONT_PAGES;
-	return (pte & mask) | (iova & ~mask);
+	return iopte_to_paddr(pte, lvl, &data->iop.cfg) | (iova & ~mask);
 }
 
 static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
