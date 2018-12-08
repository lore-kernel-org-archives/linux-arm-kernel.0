Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D9DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:42:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4577120868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kFzbZdUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4577120868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TM3MXoCGgExs+rBPj8AbFcSGpLL5GxmOt1SODash790=; b=kFzbZdUZImVlao
	zZl4//HN4qPPqv+OYTolg10f85Xo9OGp+Tk1Gbs1fA29pmBVpFmlq1AM6pabvOHAbjqXK8AHySElU
	Ic1pSLmmstO+oZQ3tWQBWWZowHkDFiGjos83TqzQ/tCUV4RM4E0937iQpFAHz5luIzdPSU9imVP/Y
	mAuqFH8q9Xpk3a+Jqj2NIEl0H4nif9cinlL+6pE55ShF7z6QYoXpFmSZNwAOoqYT2Ku1Rk2dlWEF9
	b+kcFkuOYplaHhp87jADBbtlzgI9147EApaCOeGyR/37hVPK9QsMIOgzfePgCfFSchS44Ln3KksaI
	HJf9qKxlE8JMthWfS+PA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVYBx-0003rP-Gw; Sat, 08 Dec 2018 08:42:29 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVYBZ-0003KT-QI; Sat, 08 Dec 2018 08:42:24 +0000
X-UUID: 295a30747e084767a176675274b82b5f-20181208
X-UUID: 295a30747e084767a176675274b82b5f-20181208
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1859802803; Sat, 08 Dec 2018 16:41:51 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 8 Dec 2018 16:41:50 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 8 Dec 2018 16:41:49 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 07/18] iommu/mediatek: Add bclk can be supported optionally
Date: Sat, 8 Dec 2018 16:39:20 +0800
Message-ID: <1544258371-4600-8-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_004206_253309_AFB326DC 
X-CRM114-Status: GOOD (  12.45  )
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
 yong.wu@mediatek.com, Arvind Yadav <arvind.yadav.cs@gmail.com>,
 yingjoe.chen@mediatek.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In some SoCs, M4U doesn't have its "bclk", it will use the EMI
clock instead which has always been enabled when entering kernel.

This also is a preparing patch for mt8183.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 10 +++++++---
 drivers/iommu/mtk_iommu.h |  3 +++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 8eb110e..eda062a 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -610,9 +610,11 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	if (data->irq < 0)
 		return data->irq;
 
-	data->bclk = devm_clk_get(dev, "bclk");
-	if (IS_ERR(data->bclk))
-		return PTR_ERR(data->bclk);
+	if (data->plat_data->has_bclk) {
+		data->bclk = devm_clk_get(dev, "bclk");
+		if (IS_ERR(data->bclk))
+			return PTR_ERR(data->bclk);
+	}
 
 	larb_nr = of_count_phandle_with_args(dev->of_node,
 					     "mediatek,larbs", NULL);
@@ -736,11 +738,13 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 static const struct mtk_iommu_plat_data mt2712_data = {
 	.m4u_plat     = M4U_MT2712,
 	.has_4gb_mode = true,
+	.has_bclk     = true,
 };
 
 static const struct mtk_iommu_plat_data mt8173_data = {
 	.m4u_plat     = M4U_MT8173,
 	.has_4gb_mode = true,
+	.has_bclk     = true,
 };
 
 static const struct of_device_id mtk_iommu_of_ids[] = {
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 5890e55..b8749ac 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -44,6 +44,9 @@ enum mtk_iommu_plat {
 struct mtk_iommu_plat_data {
 	enum mtk_iommu_plat m4u_plat;
 	bool                has_4gb_mode;
+
+	/* HW will use the EMI clock if there isn't the "bclk". */
+	bool                has_bclk;
 };
 
 struct mtk_iommu_domain;
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
