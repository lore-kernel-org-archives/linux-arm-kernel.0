Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F828C2F441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:48:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C882C20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jqS77U2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C882C20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oxIODukrWXgjH8yJnDON0a9X07ecw59V4t6IVH/iHK8=; b=jqS77U2OYGIzqf
	xIETsuXprpiXxB1J0H6tiVY9lvmnnrHy/5+T/0AUuPqEDRIyQPSf8zYGsQsVx10RI8uoT7EKsGSen
	sUMnOvesAQJPb/zwUNpUfit2scaH4YIZvQ7lMcGPa+gYNamIIuhTv2MmbT3JTe0cgRuOPP2xVwpBX
	PFyqIFhbn4r7HKbx7rVRBtZgIsrNFlnymxjzwYxnjMHGZ/3sKCdiOD0qirH3RA5RYPq7iZ87ADH6C
	hQ3sTqnB0XYdE2RwF6t4yBRKOIL0XtdJ2yUksGuMwHczDUfsRpI8PbDqYcbTxa63Y7tG357wtAuTF
	FqrvaWnbmlH8mOhUfSjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbok-0003uC-NQ; Mon, 21 Jan 2019 15:48:54 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbmL-0001un-A4
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:47:02 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id EA94620C9F; Mon, 21 Jan 2019 16:46:16 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id 52EB520C59;
 Mon, 21 Jan 2019 16:45:59 +0100 (CET)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v5 6/9] drm/bridge: cdns: Separate DSI and D-PHY configuration
Date: Mon, 21 Jan 2019 16:45:51 +0100
Message-Id: <0b3bea44e05745b65c23af7926ca546bc80a1bcc.1548085432.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.fbf0776c70c0cfb7b7fd88ce6a96b4597d620cac.1548085432.git-series.maxime.ripard@bootlin.com>
References: <cover.fbf0776c70c0cfb7b7fd88ce6a96b4597d620cac.1548085432.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_074626_035025_830C98E1 
X-CRM114-Status: GOOD (  14.69  )
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
Cc: Archit Taneja <architt@codeaurora.org>, Rafal Ciepiela <rafalc@cadence.com>,
 Krzysztof Witos <kwitos@cadence.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Andrzej Hajda <a.hajda@samsung.com>, Chen-Yu Tsai <wens@csie.org>,
 Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The current configuration of the DSI bridge and its associated D-PHY is
intertwined. In order to ease the future conversion to the phy framework
for the D-PHY part, let's split the configuration in two.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/bridge/cdns-dsi.c | 101 ++++++++++++++++++++++---------
 1 file changed, 73 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
index ce9496d13986..796874e76308 100644
--- a/drivers/gpu/drm/bridge/cdns-dsi.c
+++ b/drivers/gpu/drm/bridge/cdns-dsi.c
@@ -545,6 +545,15 @@ bridge_to_cdns_dsi_input(struct drm_bridge *bridge)
 	return container_of(bridge, struct cdns_dsi_input, bridge);
 }
 
+static unsigned int mode_to_dpi_hfp(const struct drm_display_mode *mode,
+				    bool mode_valid_check)
+{
+	if (mode_valid_check)
+		return mode->hsync_start - mode->hdisplay;
+
+	return mode->crtc_hsync_start - mode->crtc_hdisplay;
+}
+
 static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
 				     struct cdns_dphy_cfg *cfg,
 				     unsigned int dpi_htotal,
@@ -731,14 +740,12 @@ static unsigned int dpi_to_dsi_timing(unsigned int dpi_timing,
 static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
 			     const struct drm_display_mode *mode,
 			     struct cdns_dsi_cfg *dsi_cfg,
-			     struct cdns_dphy_cfg *dphy_cfg,
 			     bool mode_valid_check)
 {
-	unsigned long dsi_htotal = 0, dsi_hss_hsa_hse_hbp = 0;
 	struct cdns_dsi_output *output = &dsi->output;
-	unsigned int dsi_hfp_ext = 0, dpi_hfp, tmp;
+	unsigned int tmp;
 	bool sync_pulse = false;
-	int bpp, nlanes, ret;
+	int bpp, nlanes;
 
 	memset(dsi_cfg, 0, sizeof(*dsi_cfg));
 
@@ -757,8 +764,6 @@ static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
 		       mode->crtc_hsync_end : mode->crtc_hsync_start);
 
 	dsi_cfg->hbp = dpi_to_dsi_timing(tmp, bpp, DSI_HBP_FRAME_OVERHEAD);
-	dsi_htotal += dsi_cfg->hbp + DSI_HBP_FRAME_OVERHEAD;
-	dsi_hss_hsa_hse_hbp += dsi_cfg->hbp + DSI_HBP_FRAME_OVERHEAD;
 
 	if (sync_pulse) {
 		if (mode_valid_check)
@@ -768,49 +773,91 @@ static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
 
 		dsi_cfg->hsa = dpi_to_dsi_timing(tmp, bpp,
 						 DSI_HSA_FRAME_OVERHEAD);
-		dsi_htotal += dsi_cfg->hsa + DSI_HSA_FRAME_OVERHEAD;
-		dsi_hss_hsa_hse_hbp += dsi_cfg->hsa + DSI_HSA_FRAME_OVERHEAD;
 	}
 
 	dsi_cfg->hact = dpi_to_dsi_timing(mode_valid_check ?
 					  mode->hdisplay : mode->crtc_hdisplay,
 					  bpp, 0);
-	dsi_htotal += dsi_cfg->hact;
+	dsi_cfg->hfp = dpi_to_dsi_timing(mode_to_dpi_hfp(mode, mode_valid_check),
+					 bpp, DSI_HFP_FRAME_OVERHEAD);
 
-	if (mode_valid_check)
-		dpi_hfp = mode->hsync_start - mode->hdisplay;
-	else
-		dpi_hfp = mode->crtc_hsync_start - mode->crtc_hdisplay;
+	return 0;
+}
+
+static int cdns_dphy_validate(struct cdns_dsi *dsi,
+			      struct cdns_dsi_cfg *dsi_cfg,
+			      struct cdns_dphy_cfg *dphy_cfg,
+			      const struct drm_display_mode *mode,
+			      bool mode_valid_check)
+{
+	struct cdns_dsi_output *output = &dsi->output;
+	unsigned long dsi_htotal;
+	unsigned int dsi_hfp_ext = 0;
+
+	int ret;
+
+	dsi_htotal = dsi_cfg->hbp + DSI_HBP_FRAME_OVERHEAD;
+	if (output->dev->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
+		dsi_htotal += dsi_cfg->hsa + DSI_HSA_FRAME_OVERHEAD;
 
-	dsi_cfg->hfp = dpi_to_dsi_timing(dpi_hfp, bpp, DSI_HFP_FRAME_OVERHEAD);
+	dsi_htotal += dsi_cfg->hact;
 	dsi_htotal += dsi_cfg->hfp + DSI_HFP_FRAME_OVERHEAD;
 
 	if (mode_valid_check)
 		ret = cdns_dsi_get_dphy_pll_cfg(dsi->dphy, dphy_cfg,
-						mode->htotal, bpp,
+						mode->htotal,
 						mode->clock * 1000,
-						dsi_htotal, nlanes,
+						mipi_dsi_pixel_format_to_bpp(output->dev->format),
+						dsi_htotal,
+						output->dev->lanes,
 						&dsi_hfp_ext);
 	else
 		ret = cdns_dsi_get_dphy_pll_cfg(dsi->dphy, dphy_cfg,
-						mode->crtc_htotal, bpp,
+						mode->crtc_htotal,
+						mipi_dsi_pixel_format_to_bpp(output->dev->format),
 						mode->crtc_clock * 1000,
-						dsi_htotal, nlanes,
+						dsi_htotal,
+						output->dev->lanes,
 						&dsi_hfp_ext);
-
 	if (ret)
 		return ret;
 
 	dsi_cfg->hfp += dsi_hfp_ext;
-	dsi_htotal += dsi_hfp_ext;
-	dsi_cfg->htotal = dsi_htotal;
+	dsi_cfg->htotal = dsi_htotal + dsi_hfp_ext;
+
+	return 0;
+}
+
+static int cdns_dsi_check_conf(struct cdns_dsi *dsi,
+			       const struct drm_display_mode *mode,
+			       struct cdns_dsi_cfg *dsi_cfg,
+			       struct cdns_dphy_cfg *dphy_cfg,
+			       bool mode_valid_check)
+{
+	struct cdns_dsi_output *output = &dsi->output;
+	unsigned long dsi_hss_hsa_hse_hbp;
+	unsigned int nlanes = output->dev->lanes;
+	int ret;
+
+	ret = cdns_dsi_mode2cfg(dsi, mode, dsi_cfg, mode_valid_check);
+	if (ret)
+		return ret;
+
+	ret = cdns_dphy_validate(dsi, dsi_cfg, dphy_cfg, mode, mode_valid_check);
+	if (ret)
+		return ret;
+
+	dsi_hss_hsa_hse_hbp = dsi_cfg->hbp + DSI_HBP_FRAME_OVERHEAD;
+	if (output->dev->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
+		dsi_hss_hsa_hse_hbp += dsi_cfg->hsa + DSI_HSA_FRAME_OVERHEAD;
 
 	/*
 	 * Make sure DPI(HFP) > DSI(HSS+HSA+HSE+HBP) to guarantee that the FIFO
 	 * is empty before we start a receiving a new line on the DPI
 	 * interface.
 	 */
-	if ((u64)dphy_cfg->lane_bps * dpi_hfp * nlanes <
+	if ((u64)dphy_cfg->lane_bps *
+	    mode_to_dpi_hfp(mode, mode_valid_check) * nlanes <
 	    (u64)dsi_hss_hsa_hse_hbp *
 	    (mode_valid_check ? mode->clock : mode->crtc_clock) * 1000)
 		return -EINVAL;
@@ -842,7 +889,7 @@ cdns_dsi_bridge_mode_valid(struct drm_bridge *bridge,
 	struct cdns_dsi_output *output = &dsi->output;
 	struct cdns_dphy_cfg dphy_cfg;
 	struct cdns_dsi_cfg dsi_cfg;
-	int bpp, nlanes, ret;
+	int bpp, ret;
 
 	/*
 	 * VFP_DSI should be less than VFP_DPI and VFP_DSI should be at
@@ -860,11 +907,9 @@ cdns_dsi_bridge_mode_valid(struct drm_bridge *bridge,
 	if ((mode->hdisplay * bpp) % 32)
 		return MODE_H_ILLEGAL;
 
-	nlanes = output->dev->lanes;
-
-	ret = cdns_dsi_mode2cfg(dsi, mode, &dsi_cfg, &dphy_cfg, true);
+	ret = cdns_dsi_check_conf(dsi, mode, &dsi_cfg, &dphy_cfg, true);
 	if (ret)
-		return MODE_CLOCK_RANGE;
+		return MODE_BAD;
 
 	return MODE_OK;
 }
@@ -990,7 +1035,7 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
 	bpp = mipi_dsi_pixel_format_to_bpp(output->dev->format);
 	nlanes = output->dev->lanes;
 
-	WARN_ON_ONCE(cdns_dsi_mode2cfg(dsi, mode, &dsi_cfg, &dphy_cfg, false));
+	WARN_ON_ONCE(cdns_dsi_check_conf(dsi, mode, &dsi_cfg, &dphy_cfg, false));
 
 	cdns_dsi_hs_init(dsi, &dphy_cfg);
 	cdns_dsi_init_link(dsi);
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
