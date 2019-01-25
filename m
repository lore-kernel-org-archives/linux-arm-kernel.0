Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98269C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:26:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B8562085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lkn7LfRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8562085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2N75gyGUZ0BTh1xp3H6z/7jCBDBvxtZ695ZzzSQCr8Q=; b=lkn7LfRc8HSxQy
	9px5gbR5PMuUHJTzMzItFSoPTlBX2Fc0cBzLuvFJ/biZ66n8+KP83FpqiIEVI4yEVNOn+fYtZYOdc
	pnKMb1K0PvnAKo0+j27w1gZK8c0NRGxPMppeJ3ngBSaoHpJTqdsAT7F/EdbptSd/n1EVmllkbDDc5
	DAkxRsNheSEz1z/cO0W+MDtyf/ghgnk97Bf+I3fG9p47c+T1eLSs3SIMPzJRj6XRTup6zoNT0LDd+
	XlEzXSh0DFthdTOFyNKrP1oFuWu7PYHjIMa3nUvwiNpfBsRdM8jTLYBKaA7tlsTfZhsgyFm7t/xfc
	J+pOmoYx5wjkGKmXHRwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gms8A-0001Lp-Qn; Fri, 25 Jan 2019 03:26:10 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gms5T-0006fo-RB
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 03:23:28 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 45EEB5FDBD; Fri, 25 Jan 2019 11:23:15 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 05/11] drm/sun4i: layer: support just backend formats when
 frontend is unavailable
Date: Fri, 25 Jan 2019 11:23:08 +0800
Message-Id: <20190125032314.20915-6-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125032314.20915-1-wens@csie.org>
References: <20190125032314.20915-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_192324_753314_386134F4 
X-CRM114-Status: GOOD (  14.44  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In some cases, such as running a new kernel with an old device tree that
has the frontend disabled, the backend's matching frontend might be
unavailable.

When this happens, the layers should only declare support for formats
that the backend support. This partially reverts commit 1c29d263f624
("drm/sun4i: Rename sun4i_backend_layer_formats to sun4i_layer_formats")
by bringing back sun4i_backend_layer_formats, and passing it to
drm_universal_plane_init, while also dropping the modifiers list,
in the event no frontend is available.

Fixes: b636d3f97d04 ("drm/sun4i: frontend: Add support for the BGRX8888 input format")
Fixes: 9afe52d54bb0 ("drm/sun4i: frontend: Add support for semi-planar YUV input formats")
Fixes: 8c8152bf4db6 ("drm/sun4i: frontend: Add support for planar YUV input formats")
Fixes: b2ddf277ab5e ("drm/sun4i: layer: Add tiled modifier support and helper")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c | 34 ++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 95d4aaa51a5c..a514fe88d441 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -117,6 +117,11 @@ static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
 static bool sun4i_layer_format_mod_supported(struct drm_plane *plane,
 					     uint32_t format, uint64_t modifier)
 {
+	struct sun4i_layer *layer = plane_to_sun4i_layer(plane);
+
+	if (IS_ERR_OR_NULL(layer->backend->frontend))
+		sun4i_backend_format_is_supported(format, modifier);
+
 	return sun4i_backend_format_is_supported(format, modifier) ||
 	       sun4i_frontend_format_is_supported(format, modifier);
 }
@@ -165,6 +170,21 @@ static const uint32_t sun4i_layer_formats[] = {
 	DRM_FORMAT_YVYU,
 };
 
+static const uint32_t sun4i_backend_layer_formats[] = {
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_ARGB4444,
+	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_RGBA5551,
+	DRM_FORMAT_RGBA4444,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_UYVY,
+	DRM_FORMAT_VYUY,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_YUYV,
+	DRM_FORMAT_YVYU,
+};
+
 static const uint64_t sun4i_layer_modifiers[] = {
 	DRM_FORMAT_MOD_LINEAR,
 	DRM_FORMAT_MOD_ALLWINNER_TILED,
@@ -175,6 +195,9 @@ static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 						struct sun4i_backend *backend,
 						enum drm_plane_type type)
 {
+	const uint64_t *modifiers = sun4i_layer_modifiers;
+	const uint32_t *formats = sun4i_layer_formats;
+	unsigned int formats_len = ARRAY_SIZE(sun4i_layer_formats);
 	struct sun4i_layer *layer;
 	int ret;
 
@@ -184,12 +207,17 @@ static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 
 	layer->backend = backend;
 
+	if (IS_ERR_OR_NULL(backend->frontend)) {
+		formats = sun4i_backend_layer_formats;
+		formats_len = ARRAY_SIZE(sun4i_backend_layer_formats);
+		modifiers = NULL;
+	}
+
 	/* possible crtcs are set later */
 	ret = drm_universal_plane_init(drm, &layer->plane, 0,
 				       &sun4i_backend_layer_funcs,
-				       sun4i_layer_formats,
-				       ARRAY_SIZE(sun4i_layer_formats),
-				       sun4i_layer_modifiers, type, NULL);
+				       formats, formats_len,
+				       modifiers, type, NULL);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't initialize layer\n");
 		return ERR_PTR(ret);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
