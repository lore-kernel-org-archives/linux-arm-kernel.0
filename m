Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03046C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:26:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2505217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jn/R/5hf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2505217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8cLSmayHJpnvNK/0zibh8QwpMSoMrLhZ7PZGndmUdvg=; b=Jn/R/5hfrE0iLw
	oXjZEjfSm6zYh0IcZc29vcafnhiBCKylu8bVb2ui7pbbYvsCKr6J3e9eWWYiThIeHVYRSCNj+oW9q
	YOojigE1oTnZ4NF1d3400aHe171hsOJugPygm0ViWIx8KLe4IFoOZSoyoSI+cllARF3WxABY5v9Ka
	oNJsj7NJlwV2CAnTVfs7Mumf1LQKojsLvzRCdfxe+NyVYVQB+f9VgKCvITSE8OGpH7yYodm6l8Tcm
	SyYsKcUZZZqtFmQTXm+q9GwU/vAY/KPKO+1KIKnb0mqOkPWjilLxrhmyzeSzmGilmIK+lH+DvtHSw
	mjdEKinGP+P02RluZ+aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gydgt-0003An-QA; Tue, 26 Feb 2019 14:26:39 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gydgK-0002dS-MG
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 14:26:08 +0000
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr
 [90.88.147.150]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id 32BAC20000B;
 Tue, 26 Feb 2019 14:25:58 +0000 (UTC)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>,
	Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 2/4] drm/sun4i: rgb: Store the bridge pointer
Date: Tue, 26 Feb 2019 15:25:47 +0100
Message-Id: <2f16d70fb09613b3a030fd6a016343047d519d43.1551191081.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.3a2868d9beb0d45f77f844aa8707810909ffebed.1551191081.git-series.maxime.ripard@bootlin.com>
References: <cover.3a2868d9beb0d45f77f844aa8707810909ffebed.1551191081.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_062604_883035_E1CA0BC2 
X-CRM114-Status: GOOD (  11.14  )
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

We'll need the bridge pointer, if any, in the mode_valid callback in
addition to the init function. Store the pointer to the bridge in the
rgb private structure.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_rgb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index d181ee399b03..8a43ed46af82 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -28,6 +28,7 @@ struct sun4i_rgb {
 
 	struct sun4i_tcon	*tcon;
 	struct drm_panel	*panel;
+	struct drm_bridge	*bridge;
 };
 
 static inline struct sun4i_rgb *
@@ -169,7 +170,6 @@ static struct drm_encoder_funcs sun4i_rgb_enc_funcs = {
 int sun4i_rgb_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 {
 	struct drm_encoder *encoder;
-	struct drm_bridge *bridge;
 	struct sun4i_rgb *rgb;
 	int ret;
 
@@ -180,7 +180,7 @@ int sun4i_rgb_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 	encoder = &rgb->encoder;
 
 	ret = drm_of_find_panel_or_bridge(tcon->dev->of_node, 1, 0,
-					  &rgb->panel, &bridge);
+					  &rgb->panel, &rgb->bridge);
 	if (ret) {
 		dev_info(drm->dev, "No panel or bridge found... RGB output disabled\n");
 		return 0;
@@ -222,8 +222,8 @@ int sun4i_rgb_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 		}
 	}
 
-	if (bridge) {
-		ret = drm_bridge_attach(encoder, bridge, NULL);
+	if (rgb->bridge) {
+		ret = drm_bridge_attach(encoder, rgb->bridge, NULL);
 		if (ret) {
 			dev_err(drm->dev, "Couldn't attach our bridge\n");
 			goto err_cleanup_connector;
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
