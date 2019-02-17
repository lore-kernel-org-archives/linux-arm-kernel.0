Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64485C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:07:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 333B721934
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UeVdkXzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333B721934
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uz8AZnkDmXQ5iL93rMKS7Le0O3WzvfKqCjsN/tBqmIM=; b=UeVdkXzXCbjmoh
	H9n/Nju7OZT/0GO9kxwA/dFUIG45RVR5qC5w01jHS7pCuuQxCD5C7BtFsW5VVnpsjc0Fkr1dD3Zow
	gnJ1B8aAjMxFc9cM9uRZmdemLOpOS84Y/0jziUKIZmrTIiNDs9OB44Gdn4GMCPSbWIUlzH5j6s7qa
	cJZ33OB7+oJ8WvlWkhqoC5gj9vxB+DuVlUq/7Eon2kfUpBuqGFd1uwlPol/nDIP9UfD4rmr/FaKQS
	crlMATEikcxrvnft2abWnivKx7ES2DXfeuLzr3AWUH1kWpiwtpy9wJ6dN2ZOzGoA9ks7JsQOr7svh
	VzfBa9v8qOEdt1VCUqtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvIQD-0004Dc-7k; Sun, 17 Feb 2019 09:07:37 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvIQ8-0004BU-G8; Sun, 17 Feb 2019 09:07:34 +0000
X-UUID: 577eb90fa82d47eebf523857222d3636-20190217
X-UUID: 577eb90fa82d47eebf523857222d3636-20190217
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1617592694; Sun, 17 Feb 2019 01:07:25 -0800
Received: from mtkmbs03n2.mediatek.inc (172.21.101.182) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 17 Feb 2019 01:07:23 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 17 Feb 2019 17:07:22 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 17 Feb 2019 17:07:21 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v6 06/22] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB Mode
Date: Sun, 17 Feb 2019 17:04:44 +0800
Message-ID: <1550394300-17420-7-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 228B7487262AA67B7DA5177A554C5BB0FF3DCA162FB709463A322D9737FBF6A82000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_010732_546735_E6B08E6F 
X-CRM114-Status: GOOD (  21.84  )
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

MediaTek extend the arm v7s descriptor to support the dram over 4GB.

In the mt2712 and mt8173, it's called "4GB mode", the physical address
is from 0x4000_0000 to 0x1_3fff_ffff, but from EMI point of view, it
is remapped to high address from 0x1_0000_0000 to 0x1_ffff_ffff, the
bit32 is always enabled. thus, in the M4U, we always enable the bit9
for all PTEs which means to enable bit32 of physical address.

but in mt8183, M4U support the dram from 0x4000_0000 to 0x3_ffff_ffff
which isn't remaped. We extend the PTEs: the bit9 represent bit32 of
PA and the bit4 represent bit33 of PA. Meanwhile the iova still is
32bits.

In order to unify code, in the "4GB mode", we add the bit32 for the
physical address manually in our driver.

Correspondingly, Adding bit32 and bit33 for the PA in the iova_to_phys
has to been moved into v7s.

Regarding whether the pagetable address could be over 4GB, the mt8183
support it while the previous mt8173 don't. thus keep it as is.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
Comparing the previous version, I add MTK_4GB quirk always since mtk_iommu
has already controlled the PA itself. Helped from Evan.
---
 drivers/iommu/io-pgtable-arm-v7s.c | 31 ++++++++++++++++++++++++-------
 drivers/iommu/io-pgtable.h         |  7 +++----
 drivers/iommu/mtk_iommu.c          | 20 ++++++++++----------
 drivers/iommu/mtk_iommu.h          |  1 +
 4 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 11d8505..8803a35 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -124,7 +124,9 @@
 #define ARM_V7S_TEX_MASK		0x7
 #define ARM_V7S_ATTR_TEX(val)		(((val) & ARM_V7S_TEX_MASK) << ARM_V7S_TEX_SHIFT)
 
-#define ARM_V7S_ATTR_MTK_4GB		BIT(9) /* MTK extend it for 4GB mode */
+/* MediaTek extend the two bits below for over 4GB mode */
+#define ARM_V7S_ATTR_MTK_PA_BIT32	BIT(9)
+#define ARM_V7S_ATTR_MTK_PA_BIT33	BIT(4)
 
 /* *well, except for TEX on level 2 large pages, of course :( */
 #define ARM_V7S_CONT_PAGE_TEX_SHIFT	6
@@ -183,13 +185,22 @@ static dma_addr_t __arm_v7s_dma_addr(void *pages)
 static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
 				    struct io_pgtable_cfg *cfg)
 {
-	return paddr & ARM_V7S_LVL_MASK(lvl);
+	arm_v7s_iopte pte = paddr & ARM_V7S_LVL_MASK(lvl);
+
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
+		if (paddr & BIT_ULL(32))
+			pte |= ARM_V7S_ATTR_MTK_PA_BIT32;
+		if (paddr & BIT_ULL(33))
+			pte |= ARM_V7S_ATTR_MTK_PA_BIT33;
+	}
+	return pte;
 }
 
 static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
 				  struct io_pgtable_cfg *cfg)
 {
 	arm_v7s_iopte mask;
+	phys_addr_t paddr;
 
 	if (ARM_V7S_PTE_IS_TABLE(pte, lvl))
 		mask = ARM_V7S_TABLE_MASK;
@@ -198,7 +209,14 @@ static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
 	else
 		mask = ARM_V7S_LVL_MASK(lvl);
 
-	return pte & mask;
+	paddr = pte & mask;
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
+		if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
+			paddr |= BIT_ULL(32);
+		if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
+			paddr |= BIT_ULL(33);
+	}
+	return paddr;
 }
 
 static arm_v7s_iopte *iopte_deref(arm_v7s_iopte pte, int lvl,
@@ -315,9 +333,6 @@ static arm_v7s_iopte arm_v7s_prot_to_pte(int prot, int lvl,
 	if (lvl == 1 && (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS))
 		pte |= ARM_V7S_ATTR_NS_SECTION;
 
-	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB)
-		pte |= ARM_V7S_ATTR_MTK_4GB;
-
 	return pte;
 }
 
@@ -504,7 +519,9 @@ static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
 	if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
 		return 0;
 
-	if (WARN_ON(upper_32_bits(iova) || upper_32_bits(paddr)))
+	if (WARN_ON(upper_32_bits(iova)) ||
+	    WARN_ON(upper_32_bits(paddr) &&
+		    !(iop->cfg.quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB)))
 		return -ERANGE;
 
 	ret = __arm_v7s_map(data, iova, paddr, size, prot, 1, data->pgd);
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 47d5ae5..69db115 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -62,10 +62,9 @@ struct io_pgtable_cfg {
 	 *	(unmapped) entries but the hardware might do so anyway, perform
 	 *	TLB maintenance when mapping as well as when unmapping.
 	 *
-	 * IO_PGTABLE_QUIRK_ARM_MTK_4GB: (ARM v7s format) Set bit 9 in all
-	 *	PTEs, for Mediatek IOMMUs which treat it as a 33rd address bit
-	 *	when the SoC is in "4GB mode" and they can only access the high
-	 *	remap of DRAM (0x1_00000000 to 0x1_ffffffff).
+	 * IO_PGTABLE_QUIRK_ARM_MTK_4GB: (ARM v7s format) MediaTek IOMMUs extend
+	 *	to support up to 34 bits PA where the bit32 and bit33 are
+	 *	encoded in the bit9 and bit4 of the PTE respectively.
 	 *
 	 * IO_PGTABLE_QUIRK_NO_DMA: Guarantees that the tables will only ever
 	 *	be accessed by a fully cache-coherent IOMMU or CPU (e.g. for a
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 189d1b5..b2d517c 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -271,7 +271,8 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
 	dom->cfg = (struct io_pgtable_cfg) {
 		.quirks = IO_PGTABLE_QUIRK_ARM_NS |
 			IO_PGTABLE_QUIRK_NO_PERMS |
-			IO_PGTABLE_QUIRK_TLBI_ON_MAP,
+			IO_PGTABLE_QUIRK_TLBI_ON_MAP |
+			IO_PGTABLE_QUIRK_ARM_MTK_4GB,
 		.pgsize_bitmap = mtk_iommu_ops.pgsize_bitmap,
 		.ias = 32,
 		.oas = 32,
@@ -279,9 +280,6 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
 		.iommu_dev = data->dev,
 	};
 
-	if (data->enable_4GB)
-		dom->cfg.quirks |= IO_PGTABLE_QUIRK_ARM_MTK_4GB;
-
 	dom->iop = alloc_io_pgtable_ops(ARM_V7S, &dom->cfg, data);
 	if (!dom->iop) {
 		dev_err(data->dev, "Failed to alloc io pgtable\n");
@@ -367,12 +365,16 @@ static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
 			 phys_addr_t paddr, size_t size, int prot)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 	unsigned long flags;
 	int ret;
 
+	/* The "4GB mode" M4U physically can not use the lower remap of Dram. */
+	if (data->plat_data->has_4gb_mode && data->enable_4GB)
+		paddr |= BIT_ULL(32);
+
 	spin_lock_irqsave(&dom->pgtlock, flags);
-	ret = dom->iop->map(dom->iop, iova, paddr & DMA_BIT_MASK(32),
-			    size, prot);
+	ret = dom->iop->map(dom->iop, iova, paddr, size, prot);
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
 	return ret;
@@ -401,7 +403,6 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 					  dma_addr_t iova)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
-	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 	unsigned long flags;
 	phys_addr_t pa;
 
@@ -409,9 +410,6 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 	pa = dom->iop->iova_to_phys(dom->iop, iova);
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
-	if (data->enable_4GB)
-		pa |= BIT_ULL(32);
-
 	return pa;
 }
 
@@ -738,10 +736,12 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 
 static const struct mtk_iommu_plat_data mt2712_data = {
 	.m4u_plat     = M4U_MT2712,
+	.has_4gb_mode = true,
 };
 
 static const struct mtk_iommu_plat_data mt8173_data = {
 	.m4u_plat     = M4U_MT8173,
+	.has_4gb_mode = true,
 };
 
 static const struct of_device_id mtk_iommu_of_ids[] = {
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 333a0ef..5890e55 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -43,6 +43,7 @@ enum mtk_iommu_plat {
 
 struct mtk_iommu_plat_data {
 	enum mtk_iommu_plat m4u_plat;
+	bool                has_4gb_mode;
 };
 
 struct mtk_iommu_domain;
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
