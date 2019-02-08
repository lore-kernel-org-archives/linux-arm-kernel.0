Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D85C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:56:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D610E20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B/UpE5rB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D610E20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dzYNCaWmcl4VbH49PraETWbpSHkzmBtsrOKV7jtE/pk=; b=B/UpE5rBbC246q
	L0m6MGmLuyGiwlOqBdFL/Y5JMxiPk7XFIzK0Dq/YxpFr/qRqb98Vtj1zAm9Ps1NCXHXUvWRYSetIU
	bZNBb4Pd3Lnwm71cJSn4t7iwSEKTx/4YTIYMeWzoAgGQqbTOKI6sKTN9Cq8AvmruNfJbar7hw/SPp
	VpJnS+vEDI8xwMxQcB2TxNDAHn/lbwkP17hZwXNEvikbcM2Q9VdHqZAjmonYzw7aNmtDYx8q+yy3b
	FwmvFtZ/M2fPNh0b42YMb9ZvX+WPsrzc05NnIaOVM2bC7b2rinuuWjo4Vg/5gUNiQPFFUzISJ7NrT
	dUzg9k8LmTxWRBE5+MiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs2t7-0006pB-DH; Fri, 08 Feb 2019 09:56:01 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs2qt-0003Q0-LX
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 09:53:53 +0000
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id D145220000A;
 Fri,  8 Feb 2019 09:53:40 +0000 (UTC)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sean Paul <seanpaul@chromium.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 5/9] drm/sun4i: dsi: Fix front vs back porch calculation
Date: Fri,  8 Feb 2019 10:53:18 +0100
Message-Id: <90c2375b8a853cae0dcc135cedb47edbc26168d8.1549619502.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.23dbbc9b943ff8f36253ac7c617e2eda142b1b69.1549619502.git-series.maxime.ripard@bootlin.com>
References: <cover.23dbbc9b943ff8f36253ac7c617e2eda142b1b69.1549619502.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_015344_422605_8331FD35 
X-CRM114-Status: GOOD (  10.91  )
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

Since I always confuse the back and front porches, a few miscalculation
slipped through. Fix them.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 506f2e8cf454..2518a0d7567c 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -477,7 +477,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	 */
 #define HBP_PACKET_OVERHEAD	6
 	hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
-		  (mode->hsync_start - mode->hdisplay) * Bpp - HBP_PACKET_OVERHEAD);
+		  (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
 
 	/*
 	 * The frontporch is set using a blanking packet (4 bytes +
@@ -485,7 +485,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	 */
 #define HFP_PACKET_OVERHEAD	6
 	hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
-		  (mode->htotal - mode->hsync_end) * Bpp - HFP_PACKET_OVERHEAD);
+		  (mode->hsync_start - mode->hdisplay) * Bpp - HFP_PACKET_OVERHEAD);
 
 	/*
 	 * hblk seems to be the line + porches length.
@@ -531,8 +531,8 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	regmap_write(dsi->regs, SUN6I_DSI_BASIC_SIZE0_REG,
 		     SUN6I_DSI_BASIC_SIZE0_VSA(mode->vsync_end -
 					       mode->vsync_start) |
-		     SUN6I_DSI_BASIC_SIZE0_VBP(mode->vsync_start -
-					       mode->vdisplay));
+		     SUN6I_DSI_BASIC_SIZE0_VBP(mode->vtotal -
+					       mode->vsync_end));
 
 	regmap_write(dsi->regs, SUN6I_DSI_BASIC_SIZE1_REG,
 		     SUN6I_DSI_BASIC_SIZE1_VACT(mode->vdisplay) |
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
