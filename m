Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7F4C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:54:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1984021019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LJzrNbI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1984021019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cVg7jIxwfU4efI1hftAGIPERM7/tBPtQOy5PY2mV00U=; b=LJzrNbI6EZfteq
	RVtthgH6QKao/S4B/G9oGAFjxBb2FM0ga/tx8fCKmAIJ9YzugSafS+Ak/xgwc0wR70SFM8RbdlWn2
	YrmwH6mKg2bjKR743J2EXMrkZD+TFXO0RbjoRdvkgo8ysTQGzK24yPn+Dg0AuGuwkfofJFfClAIjf
	N3vrFouLHwnY5mLgN+8rLtQsM4YWZXDlBA+7OfWmlFH9EGzuDjs8QjmB5DGdN9b9n4YPSOskuQ1wY
	T9AJyaqlTNywrr9qHTPS1V2XIb+l3o9b31y3OzLQZxD3TvuvBAVczo7fhJgflS67fmXKw56JYtgME
	BhOWY3n1sABJy9UCUYUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmKrR-0004zZ-US; Wed, 23 Jan 2019 15:54:41 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmKrP-0004yR-1w
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 15:54:40 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 6C3EB207B6; Wed, 23 Jan 2019 16:54:37 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id 2A7F9207B6;
 Wed, 23 Jan 2019 16:54:27 +0100 (CET)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sean Paul <seanpaul@chromium.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 1/4] drm/sun4i: dsi: Restrict DSI tcon clock divider
Date: Wed, 23 Jan 2019 16:54:21 +0100
Message-Id: <92e4e5f4c58c8c1a439e93614fdcd8bad6823358.1548236066.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.f7a136448029ab87c498d68164670712639748e7.1548236066.git-series.maxime.ripard@bootlin.com>
References: <cover.f7a136448029ab87c498d68164670712639748e7.1548236066.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_075439_237307_4B1AB5EC 
X-CRM114-Status: GOOD (  12.36  )
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
Cc: bbrezillon@kernel.org, dri-devel@lists.freedesktop.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The current code allows the TCON clock divider to have a range between 4
and 127 when feeding the DSI controller.

The only display supported so far had a display clock rate that ended up
using a divider of 4, but testing with other displays show that only 4
seems to be functional.

This also aligns with what Allwinner is doing in their BSP, so let's just
hardcode that we want a divider of 4 when using the DSI output.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c     | 4 ++--
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 0420f5c978b9..bee73ead732a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -341,8 +341,8 @@ static void sun4i_tcon0_mode_set_cpu(struct sun4i_tcon *tcon,
 	u32 block_space, start_delay;
 	u32 tcon_div;
 
-	tcon->dclk_min_div = 4;
-	tcon->dclk_max_div = 127;
+	tcon->dclk_min_div = SUN6I_DSI_TCON_DIV;
+	tcon->dclk_max_div = SUN6I_DSI_TCON_DIV;
 
 	sun4i_tcon0_mode_set_common(tcon, mode);
 
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
index dbbc5b3ecbda..6d4a3c0fd9b5 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
@@ -13,6 +13,8 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_mipi_dsi.h>
 
+#define SUN6I_DSI_TCON_DIV	4
+
 struct sun6i_dphy {
 	struct clk		*bus_clk;
 	struct clk		*mod_clk;
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
