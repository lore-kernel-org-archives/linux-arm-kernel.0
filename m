Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F35C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:26:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964E9217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M9rnSd66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964E9217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TsH2lF6nY++thdineq0kxNgjCBjgoTSUuDLHb1YHpZc=; b=M9rnSd66Rp9Lkk
	Oio88r2dSdnfU3d9KYOjjJ+pL6Kl2o3XQQZDxY+OTE8lU7aV11xyzfkzMO3Tve/ccEKy0uaFcRU63
	2QhH6SABPOpEV+4wGimyvjoP7wymt9mt2mznNW82oeleT3eaCPlkzHguXfXBvxnxchVfSnGvfoVxY
	lsmf2C6o7FjZnIXdFPnjy/uq955rQUF3D/RP7VLby+1i55Ojr9B8hAtJpoHhkkNrZ2efpz89jPGmS
	gtYFbEaPMP74kFqES/dkHU0r1Go454PdRmG2mYwIi74QOzWoP7cAg/84o6IOVzk81G9+gHQiiWaeM
	fgzH4izvuIqKkglMxNOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gydh0-0003J9-MA; Tue, 26 Feb 2019 14:26:46 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gydgK-0002dT-OD
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 14:26:08 +0000
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr
 [90.88.147.150]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id 55684200011;
 Tue, 26 Feb 2019 14:25:52 +0000 (UTC)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>,
	Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 1/4] drm/sun4i: Move the panel pointer from the TCON to the
 encoders
Date: Tue, 26 Feb 2019 15:25:46 +0100
Message-Id: <13288b6b8f27b614a6c9aef348923c34b2803ad4.1551191081.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.3a2868d9beb0d45f77f844aa8707810909ffebed.1551191081.git-series.maxime.ripard@bootlin.com>
References: <cover.3a2868d9beb0d45f77f844aa8707810909ffebed.1551191081.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_062605_084862_9B696D6B 
X-CRM114-Status: GOOD (  14.25  )
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
Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The TCON driver used to need the panel pointer in order to configure the
tcon according to the various parameters of the panel. However, this has
evolved over time (especially to support bridges), and therefore the panel
pointer isn't needed anymore by the TCON driver.

Move that pointer to the LVDS and RGB encoders drivers.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_lvds.c | 29 ++++++++++++-----------------
 drivers/gpu/drm/sun4i/sun4i_rgb.c  | 27 ++++++++++++---------------
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  2 --
 3 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.c b/drivers/gpu/drm/sun4i/sun4i_lvds.c
index e7eb0d1e17be..5696f55db5cd 100644
--- a/drivers/gpu/drm/sun4i/sun4i_lvds.c
+++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
@@ -20,7 +20,7 @@ struct sun4i_lvds {
 	struct drm_connector	connector;
 	struct drm_encoder	encoder;
 
-	struct sun4i_tcon	*tcon;
+	struct drm_panel	*panel;
 };
 
 static inline struct sun4i_lvds *
@@ -41,9 +41,8 @@ static int sun4i_lvds_get_modes(struct drm_connector *connector)
 {
 	struct sun4i_lvds *lvds =
 		drm_connector_to_sun4i_lvds(connector);
-	struct sun4i_tcon *tcon = lvds->tcon;
 
-	return drm_panel_get_modes(tcon->panel);
+	return drm_panel_get_modes(lvds->panel);
 }
 
 static struct drm_connector_helper_funcs sun4i_lvds_con_helper_funcs = {
@@ -54,9 +53,8 @@ static void
 sun4i_lvds_connector_destroy(struct drm_connector *connector)
 {
 	struct sun4i_lvds *lvds = drm_connector_to_sun4i_lvds(connector);
-	struct sun4i_tcon *tcon = lvds->tcon;
 
-	drm_panel_detach(tcon->panel);
+	drm_panel_detach(lvds->panel);
 	drm_connector_cleanup(connector);
 }
 
@@ -71,26 +69,24 @@ static const struct drm_connector_funcs sun4i_lvds_con_funcs = {
 static void sun4i_lvds_encoder_enable(struct drm_encoder *encoder)
 {
 	struct sun4i_lvds *lvds = drm_encoder_to_sun4i_lvds(encoder);
-	struct sun4i_tcon *tcon = lvds->tcon;
 
 	DRM_DEBUG_DRIVER("Enabling LVDS output\n");
 
-	if (tcon->panel) {
-		drm_panel_prepare(tcon->panel);
-		drm_panel_enable(tcon->panel);
+	if (lvds->panel) {
+		drm_panel_prepare(lvds->panel);
+		drm_panel_enable(lvds->panel);
 	}
 }
 
 static void sun4i_lvds_encoder_disable(struct drm_encoder *encoder)
 {
 	struct sun4i_lvds *lvds = drm_encoder_to_sun4i_lvds(encoder);
-	struct sun4i_tcon *tcon = lvds->tcon;
 
 	DRM_DEBUG_DRIVER("Disabling LVDS output\n");
 
-	if (tcon->panel) {
-		drm_panel_disable(tcon->panel);
-		drm_panel_unprepare(tcon->panel);
+	if (lvds->panel) {
+		drm_panel_disable(lvds->panel);
+		drm_panel_unprepare(lvds->panel);
 	}
 }
 
@@ -113,11 +109,10 @@ int sun4i_lvds_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 	lvds = devm_kzalloc(drm->dev, sizeof(*lvds), GFP_KERNEL);
 	if (!lvds)
 		return -ENOMEM;
-	lvds->tcon = tcon;
 	encoder = &lvds->encoder;
 
 	ret = drm_of_find_panel_or_bridge(tcon->dev->of_node, 1, 0,
-					  &tcon->panel, &bridge);
+					  &lvds->panel, &bridge);
 	if (ret) {
 		dev_info(drm->dev, "No panel or bridge found... LVDS output disabled\n");
 		return 0;
@@ -138,7 +133,7 @@ int sun4i_lvds_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 	/* The LVDS encoder can only work with the TCON channel 0 */
 	lvds->encoder.possible_crtcs = drm_crtc_mask(&tcon->crtc->crtc);
 
-	if (tcon->panel) {
+	if (lvds->panel) {
 		drm_connector_helper_add(&lvds->connector,
 					 &sun4i_lvds_con_helper_funcs);
 		ret = drm_connector_init(drm, &lvds->connector,
@@ -152,7 +147,7 @@ int sun4i_lvds_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 		drm_connector_attach_encoder(&lvds->connector,
 						  &lvds->encoder);
 
-		ret = drm_panel_attach(tcon->panel, &lvds->connector);
+		ret = drm_panel_attach(lvds->panel, &lvds->connector);
 		if (ret) {
 			dev_err(drm->dev, "Couldn't attach our panel\n");
 			goto err_cleanup_connector;
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index f4a22689eb54..d181ee399b03 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -27,6 +27,7 @@ struct sun4i_rgb {
 	struct drm_encoder	encoder;
 
 	struct sun4i_tcon	*tcon;
+	struct drm_panel	*panel;
 };
 
 static inline struct sun4i_rgb *
@@ -47,9 +48,8 @@ static int sun4i_rgb_get_modes(struct drm_connector *connector)
 {
 	struct sun4i_rgb *rgb =
 		drm_connector_to_sun4i_rgb(connector);
-	struct sun4i_tcon *tcon = rgb->tcon;
 
-	return drm_panel_get_modes(tcon->panel);
+	return drm_panel_get_modes(rgb->panel);
 }
 
 static enum drm_mode_status sun4i_rgb_mode_valid(struct drm_encoder *crtc,
@@ -114,9 +114,8 @@ static void
 sun4i_rgb_connector_destroy(struct drm_connector *connector)
 {
 	struct sun4i_rgb *rgb = drm_connector_to_sun4i_rgb(connector);
-	struct sun4i_tcon *tcon = rgb->tcon;
 
-	drm_panel_detach(tcon->panel);
+	drm_panel_detach(rgb->panel);
 	drm_connector_cleanup(connector);
 }
 
@@ -131,26 +130,24 @@ static const struct drm_connector_funcs sun4i_rgb_con_funcs = {
 static void sun4i_rgb_encoder_enable(struct drm_encoder *encoder)
 {
 	struct sun4i_rgb *rgb = drm_encoder_to_sun4i_rgb(encoder);
-	struct sun4i_tcon *tcon = rgb->tcon;
 
 	DRM_DEBUG_DRIVER("Enabling RGB output\n");
 
-	if (tcon->panel) {
-		drm_panel_prepare(tcon->panel);
-		drm_panel_enable(tcon->panel);
+	if (rgb->panel) {
+		drm_panel_prepare(rgb->panel);
+		drm_panel_enable(rgb->panel);
 	}
 }
 
 static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
 {
 	struct sun4i_rgb *rgb = drm_encoder_to_sun4i_rgb(encoder);
-	struct sun4i_tcon *tcon = rgb->tcon;
 
 	DRM_DEBUG_DRIVER("Disabling RGB output\n");
 
-	if (tcon->panel) {
-		drm_panel_disable(tcon->panel);
-		drm_panel_unprepare(tcon->panel);
+	if (rgb->panel) {
+		drm_panel_disable(rgb->panel);
+		drm_panel_unprepare(rgb->panel);
 	}
 }
 
@@ -183,7 +180,7 @@ int sun4i_rgb_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 	encoder = &rgb->encoder;
 
 	ret = drm_of_find_panel_or_bridge(tcon->dev->of_node, 1, 0,
-					  &tcon->panel, &bridge);
+					  &rgb->panel, &bridge);
 	if (ret) {
 		dev_info(drm->dev, "No panel or bridge found... RGB output disabled\n");
 		return 0;
@@ -204,7 +201,7 @@ int sun4i_rgb_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 	/* The RGB encoder can only work with the TCON channel 0 */
 	rgb->encoder.possible_crtcs = drm_crtc_mask(&tcon->crtc->crtc);
 
-	if (tcon->panel) {
+	if (rgb->panel) {
 		drm_connector_helper_add(&rgb->connector,
 					 &sun4i_rgb_con_helper_funcs);
 		ret = drm_connector_init(drm, &rgb->connector,
@@ -218,7 +215,7 @@ int sun4i_rgb_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 		drm_connector_attach_encoder(&rgb->connector,
 						  &rgb->encoder);
 
-		ret = drm_panel_attach(tcon->panel, &rgb->connector);
+		ret = drm_panel_attach(rgb->panel, &rgb->connector);
 		if (ret) {
 			dev_err(drm->dev, "Couldn't attach our panel\n");
 			goto err_cleanup_connector;
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index b5214d71610f..84cfb1952ff7 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -257,8 +257,6 @@ struct sun4i_tcon {
 	struct reset_control		*lcd_rst;
 	struct reset_control		*lvds_rst;
 
-	struct drm_panel		*panel;
-
 	/* Platform adjustments */
 	const struct sun4i_tcon_quirks	*quirks;
 
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
