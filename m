Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A51C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:12:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 115B521900
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="edh/lrk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115B521900
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E+OG/Y//aMD5EE9IoZjBGzT+qppsM2qL+xai6JtGBp0=; b=edh/lrk45tDFp+
	6HLxJA+5adC2L73kPDnTWBJGcfvYaPhqQRFoO3PAZL8ii7sQ7RmogmBGqNS7KR7mzJVZP7SJ0Kh8z
	jgTwwkAnJ89sT8dVCK/Zkbx0CShC442czKKlvm07khpXGq+HDledETOJAZ/UudpDUncOosXssl9Gu
	2BZNwnCcPSq+P6sLH1ytmOvpAn6Lfu6ehPE/c4l2aO95QmLD0dDPaBSt0fRce6+FuCwHZOOcc+Okx
	/4QUb8cSn4YCF38dHFWZLvBU6irFnidT1GXq80c4Bfd6zYceeUaGGN/V4nz7eyYOrOtOEJNaL8OhQ
	Cl1jj3y5cFMO75lGLx0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvIUS-0001vl-CW; Sun, 17 Feb 2019 09:12:00 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvITV-0008RB-Gy; Sun, 17 Feb 2019 09:11:26 +0000
X-UUID: 76f43875e80c4e2eb264b7dbb407814d-20190217
X-UUID: 76f43875e80c4e2eb264b7dbb407814d-20190217
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1676904146; Sun, 17 Feb 2019 01:09:38 -0800
Received: from mtkmbs03n2.mediatek.inc (172.21.101.182) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 17 Feb 2019 01:09:36 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 17 Feb 2019 17:09:34 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 17 Feb 2019 17:09:33 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v6 21/22] iommu/mediatek: Fix iova_to_phys PA start for 4GB
 mode
Date: Sun, 17 Feb 2019 17:04:59 +0800
Message-ID: <1550394300-17420-22-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: A03FC85A1534744839235B7610B674A00EC328C3D11EB0E0D3B1E3A261BAEF602000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_011101_888588_1BBFCBBE 
X-CRM114-Status: GOOD (  11.95  )
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

In the 4GB mode, the physical address is remapped,

Here is the detailed remap relationship.
CPU PA         ->    HW PA
0x4000_0000          0x1_4000_0000 (Add bit32)
0x8000_0000          0x1_8000_0000 ...
0xc000_0000          0x1_c000_0000 ...
0x1_0000_0000        0x1_0000_0000 (No change)

Thus, we always add bit32 for PA when entering mtk_iommu_map.
But in the iova_to_phys, the CPU don't need this bit32 if the
PA is from 0x1_4000_0000 to 0x1_ffff_ffff.
This patch discards the bit32 in this iova_to_phys in the 4GB mode.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 0277396..076d333 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -119,6 +119,19 @@ struct mtk_iommu_domain {
 
 static const struct iommu_ops mtk_iommu_ops;
 
+/*
+ * In M4U 4GB mode, the physical address is remapped as below:
+ *  CPU PA         ->   M4U HW PA
+ *  0x4000_0000         0x1_4000_0000 (Add bit32)
+ *  0x8000_0000         0x1_8000_0000 ...
+ *  0xc000_0000         0x1_c000_0000 ...
+ *  0x1_0000_0000       0x1_0000_0000 (No change)
+ *
+ * Thus, We always add BIT32 in the iommu_map and disable BIT32 if PA is >=
+ * 0x1_4000_0000 in the iova_to_phys.
+ */
+#define MTK_IOMMU_4GB_MODE_PA_140000000     0x140000000UL
+
 static LIST_HEAD(m4ulist);	/* List all the M4U HWs */
 
 #define for_each_m4u(data)	list_for_each_entry(data, &m4ulist, list)
@@ -415,6 +428,7 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 					  dma_addr_t iova)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 	unsigned long flags;
 	phys_addr_t pa;
 
@@ -422,6 +436,10 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 	pa = dom->iop->iova_to_phys(dom->iop, iova);
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
+	if (data->plat_data->has_4gb_mode && data->dram_is_4gb &&
+	    pa >= MTK_IOMMU_4GB_MODE_PA_140000000)
+		pa &= ~BIT_ULL(32);
+
 	return pa;
 }
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
