Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADF0C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:27:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57445206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RM/2mdBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57445206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s60gV9Hs3p+FzBDKbD4YfprUE7SE0vzI8Gg3Xe/Ei7w=; b=RM/2mdBpLOV1d0
	2hvC0YddXl7yDJgjZo2snsvhWFd2LUkaLpiv03OgKe9P9Kr4QO580Nm3/jFqoKCZXne1c5Xi2Mry9
	83eN9S+YkFbCLLNgMH5sQjgBDrma/ydSX33L4jYQTniIeHJJAdsaGs8sCDgeWlrwPGKQ/+PnW0LIR
	2LLU4YNaZS0r9wIAQWrCgdOA0XboysgSITET3eks3LVjPZ8sFvh2MheYvDqHGa2wWQtLVbh3yWBce
	qM9+FWMgy9Yy7ukCl2GemJe/jav17bKoHChBHd1Ut1oAQ6xg+piVi7GUJZB3T5FrFwuvjqe9i/MJS
	4dPxN4PsojbrvCDUIF7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUBfC-0004LX-8c; Tue, 04 Dec 2018 14:27:02 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBbl-0007oP-6P
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:23:36 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 1CE1E20E81; Tue,  4 Dec 2018 15:23:18 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 8565520DC9;
 Tue,  4 Dec 2018 15:22:41 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/21] drm/sun4i: frontend: Add support for tiled YUV input
 mode configuration
Date: Tue,  4 Dec 2018 15:22:08 +0100
Message-Id: <20181204142218.16284-12-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_062330_000151_E76E0DF8 
X-CRM114-Status: GOOD (  12.83  )
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
Cc: Daniel Vetter <daniel@ffwll.ch>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-sunxi@googlegroups.com,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This introduces the data input mode definitions for the tiled YUV mode,
that are used in the input mode helper if tiling is requested.

The modifier is passed to the helper from the framebuffer to determine
if tiling is requested.

Only semiplanar and planar YUV formats are supported for tiling mode.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 14 ++++++++++----
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  2 ++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 8e6e1f2d1a18..3dcb05147e41 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -190,19 +190,23 @@ sun4i_frontend_drm_format_to_input_fmt(const struct drm_format_info *format,
 
 static int
 sun4i_frontend_drm_format_to_input_mode(const struct drm_format_info *format,
-					u32 *val)
+					uint64_t modifier, u32 *val)
 {
+	bool tiled = (modifier == DRM_FORMAT_MOD_ALLWINNER_TILED);
+
 	switch (format->num_planes) {
 	case 1:
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED;
 		return 0;
 
 	case 2:
-		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_SEMIPLANAR;
+		*val = tiled ? SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_MB32_SEMIPLANAR
+			     : SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_SEMIPLANAR;
 		return 0;
 
 	case 3:
-		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PLANAR;
+		*val = tiled ? SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_MB32_PLANAR
+			     : SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PLANAR;
 		return 0;
 
 	default:
@@ -324,6 +328,7 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
 	const struct drm_format_info *format = fb->format;
+	uint64_t modifier = fb->modifier;
 	u32 out_fmt_val;
 	u32 in_fmt_val, in_mod_val, in_ps_val;
 	unsigned int i;
@@ -336,7 +341,8 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 		return ret;
 	}
 
-	ret = sun4i_frontend_drm_format_to_input_mode(format, &in_mod_val);
+	ret = sun4i_frontend_drm_format_to_input_mode(format, modifier,
+						      &in_mod_val);
 	if (ret) {
 		DRM_DEBUG_DRIVER("Invalid input mode\n");
 		return ret;
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index b209eacdf8c2..ae53ee644694 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -33,6 +33,8 @@
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PLANAR	(0 << 8)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED	(1 << 8)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_SEMIPLANAR	(2 << 8)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_MB32_PLANAR	(4 << 8)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_MB32_SEMIPLANAR (6 << 8)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV444	(0 << 4)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV422	(1 << 4)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV420	(2 << 4)
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
