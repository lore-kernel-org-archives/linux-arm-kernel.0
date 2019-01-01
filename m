Return-Path: <SRS0=AJAW=PJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D7DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 03:59:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C2D32075D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 03:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f2hWpd5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2D32075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Puij5B6ogXMrymPY1A2Z/GXVmD0y1hXNZXA3nE7sVFc=; b=f2hWpd5X+0fLcj
	B98y51v3dcLSGhALlfq5qcTmrOz/COg2Sk8iHptkLDI+7vKoE04KHp4XnrDN/jjfw1OIFr/2P8i98
	Ha8MewYSJ/DYn5Ig3uLZu69dyj3bWB2OI2ckDQqWO9M3kv7/FhR43eh/eNmEQnuZRAlZ2972BN/0h
	mNR/FwbPbMG46urjhjfIJ2qMRIpk9NXHzpA6XOK0tcHZ/aYaG2Po0Y7Bk1DXoy6BBjExxIzmgqUSX
	F6DDEFbXcetoCisWMb92Q6dkhaX1bOD/ng9v/8Ufjg0jXOg/QHUw2oOF4MTgmpD7K6+0nyqRa9gR3
	cNFiDX/UTDuazAjw16ww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geBD8-0006v1-L2; Tue, 01 Jan 2019 03:59:22 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geBC2-0005wR-Np; Tue, 01 Jan 2019 03:58:21 +0000
X-UUID: 6e23c38c6c35491799d0ab1a90c20da0-20190101
X-UUID: 6e23c38c6c35491799d0ab1a90c20da0-20190101
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1085665192; Tue, 01 Jan 2019 11:58:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 1 Jan 2019 11:58:10 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 1 Jan 2019 11:58:09 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v5 09/20] iommu/mediatek: Refine protect memory definition
Date: Tue, 1 Jan 2019 11:55:41 +0800
Message-ID: <1546314952-15990-10-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_195815_364267_20BC12C8 
X-CRM114-Status: GOOD (  14.42  )
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
 Nicolas Boichat <drinkcat@chromium.org>, arnd@arndb.de,
 srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 yong.wu@mediatek.com, yingjoe.chen@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The protect memory setting is a little different in the different SoCs.
In the register REG_MMU_CTRL_REG(0x110), the TF_PROT(translation fault
protect) shift bit is normally 4 while it shift 5 bits only in the
mt8173. This patch delete the complex MACRO and use a common if-else
instead.

Also, use "F_MMU_TF_PROT_TO_PROGRAM_ADDR" instead of the hard code(2)
which means the M4U will output the dirty data to the programmed
address that we allocated dynamically when translation fault occurs.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
@Nicalos, I don't put it in the plat_data since only the previous mt8173
shift 5. As I know, the latest SoC always use the new setting like mt2712
and mt8183. Thus, I think it is unnecessary to put it in plat_data and
let all the latest SoC set it. Hence, I still keep "== mt8173" for this
like the reg REG_MMU_CTRL_REG.
---
 drivers/iommu/mtk_iommu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index eca1536..35a1263 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -53,11 +53,7 @@
 
 #define REG_MMU_CTRL_REG			0x110
 #define F_MMU_PREFETCH_RT_REPLACE_MOD		BIT(4)
-#define F_MMU_TF_PROTECT_SEL_SHIFT(data) \
-	((data)->plat_data->m4u_plat == M4U_MT2712 ? 4 : 5)
-/* It's named by F_MMU_TF_PROT_SEL in mt2712. */
-#define F_MMU_TF_PROTECT_SEL(prot, data) \
-	(((prot) & 0x3) << F_MMU_TF_PROTECT_SEL_SHIFT(data))
+#define F_MMU_TF_PROT_TO_PROGRAM_ADDR		2
 
 #define REG_MMU_IVRP_PADDR			0x114
 
@@ -521,9 +517,11 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		return ret;
 	}
 
-	regval = F_MMU_TF_PROTECT_SEL(2, data);
 	if (data->plat_data->m4u_plat == M4U_MT8173)
-		regval |= F_MMU_PREFETCH_RT_REPLACE_MOD;
+		regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
+			  (F_MMU_TF_PROT_TO_PROGRAM_ADDR << 5);
+	else
+		regval = F_MMU_TF_PROT_TO_PROGRAM_ADDR << 4;
 	writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
 
 	regval = F_L2_MULIT_HIT_EN |
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
