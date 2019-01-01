Return-Path: <SRS0=AJAW=PJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD78C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 04:55:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C132075D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 04:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hWc8lXoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C132075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DG/CsVTGAGMdeKlxBHGNe2B0T0/Uomqj/0duzkNkb0Q=; b=hWc8lXoEX2AayD
	RMBn9q6AYNAo+OfghP7CQ1T6Qf2xhAbvzfDc6aFTFD034Tk4+XLwn2V0jweeIBN3Gs4QhVxhm2yEW
	Dsi6S45woCcYreDf/BqWf+yVaFSzFydtGEtyJ4UasVhiGhZc2jGgGqvZiP4LKLFsUNgFGmFhCT2VY
	eyjcdkPa/C3TsMU51WF3xwm/eSDqqEqTP/YmmZCSTnG8pOVA58oochArqOdKMzl5cmmfDlkVsMk3h
	g0hsLyRkQBSi0yYr8tS0wKZsP9RGsfo4TjtQCNMd38Lfh5kjfm+tgFBpjQhFXM3x3/50CdS3vCHHp
	g4LG0kq0v+0Wo2gvsKyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geC4l-0004HP-Rs; Tue, 01 Jan 2019 04:54:47 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geC33-0002yI-Vh; Tue, 01 Jan 2019 04:53:23 +0000
X-UUID: dbc6801cfd184678bb02a869185fa74b-20190101
X-UUID: dbc6801cfd184678bb02a869185fa74b-20190101
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 790189475; Tue, 01 Jan 2019 12:52:58 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 1 Jan 2019 12:52:57 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 1 Jan 2019 12:52:56 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob
 Herring <robh+dt@kernel.org>
Subject: [PATCH 10/13] memory: mtk-smi: Get rid of mtk_smi_larb_get/put
Date: Tue, 1 Jan 2019 12:51:13 +0800
Message-ID: <1546318276-18993-11-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_205303_545505_23172B1F 
X-CRM114-Status: GOOD (  11.32  )
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
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

After adding device_link between the iommu consumer and smi-larb,
the pm_runtime_get(_sync) of smi-larb and smi-common will be called
automatically. we can get rid of mtk_smi_larb_get/put.

CC: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c   | 14 --------------
 include/soc/mediatek/smi.h | 20 --------------------
 2 files changed, 34 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 30930e4..a1dc34b 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -123,20 +123,6 @@ static void mtk_smi_clk_disable(const struct mtk_smi *smi)
 	clk_disable_unprepare(smi->clk_apb);
 }
 
-int mtk_smi_larb_get(struct device *larbdev)
-{
-	int ret = pm_runtime_get_sync(larbdev);
-
-	return (ret < 0) ? ret : 0;
-}
-EXPORT_SYMBOL_GPL(mtk_smi_larb_get);
-
-void mtk_smi_larb_put(struct device *larbdev)
-{
-	pm_runtime_put_sync(larbdev);
-}
-EXPORT_SYMBOL_GPL(mtk_smi_larb_put);
-
 static int
 mtk_smi_larb_bind(struct device *dev, struct device *master, void *data)
 {
diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
index 2b410d2..b993aa2 100644
--- a/include/soc/mediatek/smi.h
+++ b/include/soc/mediatek/smi.h
@@ -25,26 +25,6 @@ struct mtk_smi_iommu {
 	struct mtk_smi_larb_iommu larb_imu[MTK_LARB_NR_MAX];
 };
 
-/*
- * mtk_smi_larb_get: Enable the power domain and clocks for this local arbiter.
- *                   It also initialize some basic setting(like iommu).
- * mtk_smi_larb_put: Disable the power domain and clocks for this local arbiter.
- * Both should be called in non-atomic context.
- *
- * Returns 0 if successful, negative on failure.
- */
-int mtk_smi_larb_get(struct device *larbdev);
-void mtk_smi_larb_put(struct device *larbdev);
-
-#else
-
-static inline int mtk_smi_larb_get(struct device *larbdev)
-{
-	return 0;
-}
-
-static inline void mtk_smi_larb_put(struct device *larbdev) { }
-
 #endif
 
 #endif
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
