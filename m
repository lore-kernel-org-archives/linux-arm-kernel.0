Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE8FC10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:54:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A8C2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WEjOBcXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A8C2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uOsvsBOkabYokFXYdSId4Gzbykx4N0yzzv399738EXg=; b=WEjOBcXvV6cODd
	MtlXz28Cv6Qw2fmzWuV4OIaaKp83sL2PNv5ZPYhW1YHtkPaNutgLqr8ybqWhr78dTuRwBvw4V3pDG
	JqzrTs28oNMoQn+8e31t/DIKEdtob1iodbVfRDM7CKGXrDSQgmYV/MxdZDlKWoJro326gwmpJoFyI
	ZJhlHnSsfW0yE+LdsGKtgB3HFbktorgutv1pB0Fv9fjUTUvc0S7GRHKjhmXGBnVuX+ToQRzR0uxjB
	MKenpYR+wzdQQoMlzN1RFwyhD3CcZXXDGqmAAm5QG83DCZLC/nsMRpN2bBUHfLEtRgmzP8dq3ROao
	ecIMG0GlqmeBqnP0AZuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwI1x-0007Rv-0v; Wed, 20 Feb 2019 02:54:41 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwI1X-0006uT-Bt; Wed, 20 Feb 2019 02:54:19 +0000
X-UUID: d5de37517b99486b812666bb6d81809c-20190219
X-UUID: d5de37517b99486b812666bb6d81809c-20190219
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <wangyan.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 716743772; Tue, 19 Feb 2019 18:54:10 -0800
Received: from MTKMBS33N2.mediatek.inc (172.27.4.76) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Feb 2019 18:54:08 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Wed, 20 Feb 2019 10:54:05 +0800
Received: from mszsdaap41.mediatek.inc (10.16.6.141) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Feb 2019 10:54:04 +0800
From: wangyan wang <wangyan.wang@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, CK Hu <ck.hu@mediatek.com>
Subject: [PATCH v5 1/8] drm/mediatek: recalculate hdmi phy clock of MT2701 by
 querying hardware
Date: Wed, 20 Feb 2019 10:53:50 +0800
Message-ID: <20190220025357.7354-2-wangyan.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190220025357.7354-1-wangyan.wang@mediatek.com>
References: <20190220025357.7354-1-wangyan.wang@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_185415_564018_1875AB7F 
X-CRM114-Status: GOOD (  13.02  )
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
Cc: Ryder Lee <ryder.lee@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 srv_heupstream@mediatek.com, chunhui dai <chunhui.dai@mediatek.com>, David
 Airlie <airlied@linux.ie>, Sean
 Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 wangyan wang <wangyan.wang@mediatek.com>, linux-mediatek@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Colin Ian King <colin.king@canonical.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: chunhui dai <chunhui.dai@mediatek.com>

Recalculate the rate of this clock, by querying hardware.

Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
Signed-off-by: wangyan wang <wangyan.wang@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        |  7 ++----
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  3 +--
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 35 ++++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c |  8 ++++++
 4 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
index 4ef9c57ffd44..13c5e65b9ead 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
@@ -29,12 +29,9 @@ long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 	return rate;
 }
 
-unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
-				       unsigned long parent_rate)
+u32 mtk_hdmi_phy_read(struct mtk_hdmi_phy *hdmi_phy, u32 offset)
 {
-	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
-
-	return hdmi_phy->pll_rate;
+	return readl(hdmi_phy->regs + offset);
 }
 
 void mtk_hdmi_phy_clear_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
index f39b1fc66612..fdad8b17a915 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
@@ -41,6 +41,7 @@ struct mtk_hdmi_phy {
 	unsigned int ibias_up;
 };
 
+u32 mtk_hdmi_phy_read(struct mtk_hdmi_phy *hdmi_phy, u32 offset);
 void mtk_hdmi_phy_clear_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
 			     u32 bits);
 void mtk_hdmi_phy_set_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
@@ -50,8 +51,6 @@ void mtk_hdmi_phy_mask(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
 struct mtk_hdmi_phy *to_mtk_hdmi_phy(struct clk_hw *hw);
 long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 			     unsigned long *parent_rate);
-unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
-				       unsigned long parent_rate);
 
 extern struct platform_driver mtk_hdmi_phy_driver;
 extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_8173_conf;
diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
index fcc42dc6ea7f..b25c9dfc432a 100644
--- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
@@ -153,6 +153,41 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 			  RG_HDMITX_DRV_IBIAS_MASK);
 	return 0;
 }
+static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
+				       unsigned long parent_rate)
+{
+	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
+	unsigned long out_rate, val;
+
+	val = (mtk_hdmi_phy_read(hdmi_phy, HDMI_CON6)
+			& RG_HTPLL_PREDIV_MASK) >> RG_HTPLL_PREDIV;
+	switch (val) {
+	case 0x00:
+		out_rate = parent_rate;
+		break;
+	case 0x01:
+		out_rate = parent_rate / 2;
+		break;
+	default:
+		out_rate = parent_rate / 4;
+		break;
+	}
+
+	val = (mtk_hdmi_phy_read(hdmi_phy, HDMI_CON6)
+			& RG_HTPLL_FBKDIV_MASK) >> RG_HTPLL_FBKDIV;
+	out_rate *= (val + 1) * 2;
+	val = (mtk_hdmi_phy_read(hdmi_phy, HDMI_CON2)
+			& RG_HDMITX_TX_POSDIV_MASK);
+
+	out_rate >>= (val >> RG_HDMITX_TX_POSDIV);
+
+	if (mtk_hdmi_phy_read(hdmi_phy, HDMI_CON2) & RG_HDMITX_EN_TX_POSDIV)
+		out_rate = out_rate / 5;
+
+	hdmi_phy->pll_rate = out_rate;
+
+	return hdmi_phy->pll_rate;
+}
 
 static const struct clk_ops mtk_hdmi_phy_pll_ops = {
 	.prepare = mtk_hdmi_pll_prepare,
diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
index ed5916b27658..cb23c1e4692a 100644
--- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
@@ -285,6 +285,14 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
+				       unsigned long parent_rate)
+{
+	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
+
+	return hdmi_phy->pll_rate;
+}
+
 static const struct clk_ops mtk_hdmi_phy_pll_ops = {
 	.prepare = mtk_hdmi_pll_prepare,
 	.unprepare = mtk_hdmi_pll_unprepare,
-- 
2.14.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
