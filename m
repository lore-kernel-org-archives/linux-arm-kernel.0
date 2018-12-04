Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C0BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:27:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE0A206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="izOhOcQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE0A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0VlKFmKZtehnhFJklGhzXEgv3n360ot59gnE5WLyF0I=; b=izOhOcQMAHJrHQ
	5y90w2WMlR36lsU+0JdHm+gFbMiqRW3XBa818mwhcEcr2g97WIIkF3IF6yG2t2J3lUMc0CLZb9Dva
	UVQyW3jF3sjO/vITlcb5VOt45OlujGxEKfDySAqKWhaSHzeKOTQEumdh/9mw4geNck4mUTS24Zj8P
	+fhlb91lpQBrYs1Nj1PyoDuWYNQNQ3UWjD9QSIexZc9RhsQVvTOtMvxAW6PqalpeyB1DqHrEoNlSL
	eqI7qn++nsjRLWrDJSKLEpwD+8vsIZMjCakLmopXEQY8iw9OZvYiMCrinqpAwUd6ATUCk5bDBAx/6
	kIucZLKccYQQdl1qCkfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUBfT-0004b1-Le; Tue, 04 Dec 2018 14:27:19 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBbd-0007mH-3N
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:23:37 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id E0A6620E53; Tue,  4 Dec 2018 15:23:15 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id B9ABA20CFB;
 Tue,  4 Dec 2018 15:22:40 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/21] drm/sun4i: frontend: Add support for semi-planar YUV
 input formats
Date: Tue,  4 Dec 2018 15:22:05 +0100
Message-Id: <20181204142218.16284-9-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_062322_321489_84992702 
X-CRM114-Status: GOOD (  16.76  )
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

Semi-planar YUV formats use two distinct planes, one for luminance and
one for chrominance. To add support for them, we need to configure the
second line stride and buffer address registers to setup the second YUV
plane.

New definitions are introduced to configure the input format register
for the YUV420 and YUV422 semi-planar formats.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 50 +++++++++++++++++++++++---
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  6 ++++
 drivers/gpu/drm/sun4i/sun4i_layer.c    |  4 +++
 3 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index ff34ac9bcf05..d5b8c1a20835 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -118,11 +118,23 @@ void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
 	regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD0_REG,
 		     fb->pitches[0]);
 
+	if (fb->format->num_planes > 1)
+		regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD1_REG,
+			     fb->pitches[1]);
+
 	/* Set the physical address of the buffer in memory */
 	paddr = drm_fb_cma_get_gem_addr(fb, state, 0);
 	paddr -= PHYS_OFFSET;
-	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
+	DRM_DEBUG_DRIVER("Setting buffer #0 address to %pad\n", &paddr);
 	regmap_write(frontend->regs, SUN4I_FRONTEND_BUF_ADDR0_REG, paddr);
+
+	if (fb->format->num_planes > 1) {
+		paddr = drm_fb_cma_get_gem_addr(fb, state, 1);
+		paddr -= PHYS_OFFSET;
+		DRM_DEBUG_DRIVER("Setting buffer #1 address to %pad\n", &paddr);
+		regmap_write(frontend->regs, SUN4I_FRONTEND_BUF_ADDR1_REG,
+			     paddr);
+	}
 }
 EXPORT_SYMBOL(sun4i_frontend_update_buffer);
 
@@ -132,6 +144,8 @@ sun4i_frontend_drm_format_to_input_fmt(const struct drm_format_info *format,
 {
 	if (!format->is_yuv)
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB;
+	else if (drm_format_info_is_yuv_sampling_420(format))
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV420;
 	else if (drm_format_info_is_yuv_sampling_422(format))
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV422;
 	else
@@ -144,12 +158,18 @@ static int
 sun4i_frontend_drm_format_to_input_mode(const struct drm_format_info *format,
 					u32 *val)
 {
-	if (format->num_planes == 1)
+	switch (format->num_planes) {
+	case 1:
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED;
-	else
-		return -EINVAL;
+		return 0;
 
-	return 0;
+	case 2:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_SEMIPLANAR;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
 }
 
 static int sun4i_frontend_drm_format_to_input_sequence(uint32_t fmt, u32 *val)
@@ -159,6 +179,22 @@ static int sun4i_frontend_drm_format_to_input_sequence(uint32_t fmt, u32 *val)
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_BGRX;
 		return 0;
 
+	case DRM_FORMAT_NV12:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_UV;
+		return 0;
+
+	case DRM_FORMAT_NV16:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_UV;
+		return 0;
+
+	case DRM_FORMAT_NV21:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_VU;
+		return 0;
+
+	case DRM_FORMAT_NV61:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_VU;
+		return 0;
+
 	case DRM_FORMAT_UYVY:
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_UYVY;
 		return 0;
@@ -202,6 +238,10 @@ static int sun4i_frontend_drm_format_to_output_fmt(uint32_t fmt, u32 *val)
 
 static const uint32_t sun4i_frontend_formats[] = {
 	DRM_FORMAT_BGRX8888,
+	DRM_FORMAT_NV12,
+	DRM_FORMAT_NV16,
+	DRM_FORMAT_NV21,
+	DRM_FORMAT_NV61,
 	DRM_FORMAT_UYVY,
 	DRM_FORMAT_VYUY,
 	DRM_FORMAT_XRGB8888,
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index 750dda9352fc..021d4404d35d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -22,17 +22,23 @@
 #define SUN4I_FRONTEND_BYPASS_CSC_EN			BIT(1)
 
 #define SUN4I_FRONTEND_BUF_ADDR0_REG		0x020
+#define SUN4I_FRONTEND_BUF_ADDR1_REG		0x024
 
 #define SUN4I_FRONTEND_LINESTRD0_REG		0x040
+#define SUN4I_FRONTEND_LINESTRD1_REG		0x044
 
 #define SUN4I_FRONTEND_INPUT_FMT_REG		0x04c
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED	(1 << 8)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_SEMIPLANAR	(2 << 8)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV422	(1 << 4)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV420	(2 << 4)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB		(5 << 4)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_UYVY		0
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_YUYV		1
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_VYUY		2
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_YVYU		3
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_UV		0
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_VU		1
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_BGRX		0
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_XRGB		1
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 29631e0efde3..185ef38649aa 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -138,6 +138,10 @@ static const uint32_t sun4i_layer_formats[] = {
 	DRM_FORMAT_RGBA4444,
 	DRM_FORMAT_RGB888,
 	DRM_FORMAT_RGB565,
+	DRM_FORMAT_NV12,
+	DRM_FORMAT_NV16,
+	DRM_FORMAT_NV21,
+	DRM_FORMAT_NV61,
 	DRM_FORMAT_UYVY,
 	DRM_FORMAT_VYUY,
 	DRM_FORMAT_XRGB8888,
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
