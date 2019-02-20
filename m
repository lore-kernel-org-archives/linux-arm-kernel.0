Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7ADC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:54:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBF6B2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y1/MaIVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF6B2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RR8uSZgIk3+uLfyVI3DwRZWkHlgDtqTlet5cLdX9TzM=; b=Y1/MaIVXHIyJHv
	mNiJIK2gIpSbYMPzDtcoDmiPcEoqyEJ7OTYlat56LNBTJoZLOh9A0CuSQcJpGUBzkL/sk3TedWStD
	7hkFArpKch/bYJDmsR9rOBYX/Z9aglfyv4FAWnME1ND0yJlqXQuXiGHC6KZpYMdE9+IuTAekUPrFA
	DTVMgwwIxU1Sz51kHKbYNuq125UP1EV1q9vzjbcp+XW/4WrS2QOLEeruBIVwPuWJCnRwcE01QSOTv
	ir+f3yKHJYiOPcZFwTFoEnHxBWKmnF7vED9tPUA4ARffURID06nq3AudMGC7jjSsJMtXJQzsz2q0h
	S2SdONz4UzlHZ8vg4AKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwI1o-0007FG-0E; Wed, 20 Feb 2019 02:54:32 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwI1X-0006uK-Bu; Wed, 20 Feb 2019 02:54:18 +0000
X-UUID: deb311da0ebe43fcaac3f986036db9dc-20190219
X-UUID: deb311da0ebe43fcaac3f986036db9dc-20190219
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <wangyan.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 846836117; Tue, 19 Feb 2019 18:54:10 -0800
Received: from MTKMBS33N2.mediatek.inc (172.27.4.76) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Feb 2019 18:54:09 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Wed, 20 Feb 2019 10:54:08 +0800
Received: from mszsdaap41.mediatek.inc (10.16.6.141) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Feb 2019 10:54:07 +0800
From: wangyan wang <wangyan.wang@mediatek.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, CK Hu <ck.hu@mediatek.com>
Subject: [PATCH V5 2/8] drm/mediatek: move the setting of fixed divider
Date: Wed, 20 Feb 2019 10:53:51 +0800
Message-ID: <20190220025357.7354-3-wangyan.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190220025357.7354-1-wangyan.wang@mediatek.com>
References: <20190220025357.7354-1-wangyan.wang@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_185415_559645_78FF00F4 
X-CRM114-Status: GOOD (  10.10  )
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

move the setting of fixed divider from enable/disable
to the function of setting rate.

the patch is for hdmi pll divider, the divder should
be configured before clock calculation to ensure the
clock is right.

Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
Signed-off-by: wangyan wang <wangyan.wang@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
index b25c9dfc432a..b26fb7dbdb28 100644
--- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
@@ -79,7 +79,6 @@ static int mtk_hdmi_pll_prepare(struct clk_hw *hw)
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SLDO_MASK);
 	usleep_range(80, 100);
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_MBIAS_LPF_EN);
-	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_POSDIV);
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SER_MASK);
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_PRED_MASK);
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_DRV_MASK);
@@ -94,7 +93,6 @@ static void mtk_hdmi_pll_unprepare(struct clk_hw *hw)
 	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_DRV_MASK);
 	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_PRED_MASK);
 	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SER_MASK);
-	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_POSDIV);
 	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_MBIAS_LPF_EN);
 	usleep_range(80, 100);
 	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SLDO_MASK);
@@ -123,6 +121,7 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_PREDIV_MASK);
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_POSDIV_MASK);
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_POSDIV);
 	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON6, (0x1 << RG_HTPLL_IC),
 			  RG_HTPLL_IC_MASK);
 	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON6, (0x1 << RG_HTPLL_IR),
@@ -209,7 +208,6 @@ static void mtk_hdmi_phy_enable_tmds(struct mtk_hdmi_phy *hdmi_phy)
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SLDO_MASK);
 	usleep_range(80, 100);
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_MBIAS_LPF_EN);
-	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_POSDIV);
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SER_MASK);
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_PRED_MASK);
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_DRV_MASK);
@@ -221,7 +219,6 @@ static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi_phy *hdmi_phy)
 	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_DRV_MASK);
 	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_PRED_MASK);
 	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SER_MASK);
-	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_POSDIV);
 	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_MBIAS_LPF_EN);
 	usleep_range(80, 100);
 	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SLDO_MASK);
-- 
2.14.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
