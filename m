Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F66C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:41:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B3B206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IswtiBA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B3B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SXnUOnssJZRHervYZLQtLtC1JFroNXqsd5PMpuS40R0=; b=IswtiBA6O6V78I
	W6n7BKLvQAot3+fVC9i5xid5/yaQy7SsmalH7fBe+8Fwy1T9LTi5jNmTW6YFfEpwikNDgkCs2Ntv3
	96MaQKYkGPMK+Qm28sx/RoNKQYn4sPNdYfvcOXT1gct8GjjT4GcG3cBtfC4IrNx+hwOpmmbuc2yom
	gbNKcafJeCnLC2HzVA43+Lm2GmJegOGo6v1UdtVvEj/i+IFZEPjJTaDwZnKdoHLuT/uPb5xmqnrm/
	3koj4vSK8vekpaYRzPIonYXAhnXK5GkMrW7mMSqD7kgJGzIt4xgq1fcfIaP+chBGdLR0FhLd4zsLj
	n8TbylRd9jF037pauaDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUSkP-0001ER-VK; Wed, 05 Dec 2018 08:41:34 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUSgx-0004uE-2f
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 08:38:10 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id A90F020A5F; Wed,  5 Dec 2018 09:37:51 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id A8ED820A60;
 Wed,  5 Dec 2018 09:37:27 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/22] drm/sun4i: frontend: Add support for planar YUV
 input formats
Date: Wed,  5 Dec 2018 09:36:51 +0100
Message-Id: <20181205083703.21488-11-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
References: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_003800_435511_ACF1A10F 
X-CRM114-Status: GOOD (  18.09  )
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

Planar YUV formats come with 3 distinct planes, which requires
configuring the frontend line stride and address registers for the
third plane.

Our hardware only supports the YUV planes order and in order to support
formats with a YVU plane order, a helper is introduced to indicate
whether to invert the address of the two chroma planes.

Missing definitions for YUV411 and YUV444 input format configuration are
also introduced as support is added for these formats. For the input
sequence part, no configuration is required for planar YUV formats so
zero is returned in that case.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 54 +++++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  5 +++
 drivers/gpu/drm/sun4i/sun4i_layer.c    |  8 ++++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index f262069d348f..6219f5d0dc53 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -107,12 +107,27 @@ void sun4i_frontend_exit(struct sun4i_frontend *frontend)
 }
 EXPORT_SYMBOL(sun4i_frontend_exit);
 
+static bool sun4i_frontend_format_chroma_requires_swap(uint32_t fmt)
+{
+	switch (fmt) {
+	case DRM_FORMAT_YVU411:
+	case DRM_FORMAT_YVU420:
+	case DRM_FORMAT_YVU422:
+	case DRM_FORMAT_YVU444:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
 void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
 				  struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
 	dma_addr_t paddr;
+	bool swap;
 
 	/* Set the line width */
 	DRM_DEBUG_DRIVER("Frontend stride: %d bytes\n", fb->pitches[0]);
@@ -123,6 +138,13 @@ void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
 		regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD1_REG,
 			     fb->pitches[1]);
 
+	if (fb->format->num_planes > 2)
+		regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD2_REG,
+			     fb->pitches[2]);
+
+	/* Some planar formats require chroma channel swapping by hand. */
+	swap = sun4i_frontend_format_chroma_requires_swap(fb->format->format);
+
 	/* Set the physical address of the buffer in memory */
 	paddr = drm_fb_cma_get_gem_addr(fb, state, 0);
 	paddr -= PHYS_OFFSET;
@@ -130,12 +152,20 @@ void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
 	regmap_write(frontend->regs, SUN4I_FRONTEND_BUF_ADDR0_REG, paddr);
 
 	if (fb->format->num_planes > 1) {
-		paddr = drm_fb_cma_get_gem_addr(fb, state, 1);
+		paddr = drm_fb_cma_get_gem_addr(fb, state, swap ? 2 : 1);
 		paddr -= PHYS_OFFSET;
 		DRM_DEBUG_DRIVER("Setting buffer #1 address to %pad\n", &paddr);
 		regmap_write(frontend->regs, SUN4I_FRONTEND_BUF_ADDR1_REG,
 			     paddr);
 	}
+
+	if (fb->format->num_planes > 2) {
+		paddr = drm_fb_cma_get_gem_addr(fb, state, swap ? 1 : 2);
+		paddr -= PHYS_OFFSET;
+		DRM_DEBUG_DRIVER("Setting buffer #2 address to %pad\n", &paddr);
+		regmap_write(frontend->regs, SUN4I_FRONTEND_BUF_ADDR2_REG,
+			     paddr);
+	}
 }
 EXPORT_SYMBOL(sun4i_frontend_update_buffer);
 
@@ -145,10 +175,14 @@ sun4i_frontend_drm_format_to_input_fmt(const struct drm_format_info *format,
 {
 	if (!format->is_yuv)
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB;
+	else if (drm_format_info_is_yuv_sampling_411(format))
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV411;
 	else if (drm_format_info_is_yuv_sampling_420(format))
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV420;
 	else if (drm_format_info_is_yuv_sampling_422(format))
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV422;
+	else if (drm_format_info_is_yuv_sampling_444(format))
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV444;
 	else
 		return -EINVAL;
 
@@ -168,6 +202,10 @@ sun4i_frontend_drm_format_to_input_mode(const struct drm_format_info *format,
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_SEMIPLANAR;
 		return 0;
 
+	case 3:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PLANAR;
+		return 0;
+
 	default:
 		return -EINVAL;
 	}
@@ -177,6 +215,12 @@ static int
 sun4i_frontend_drm_format_to_input_sequence(const struct drm_format_info *format,
 					    u32 *val)
 {
+	/* Planar formats have an explicit input sequence. */
+	if (drm_format_info_is_yuv_planar(format)) {
+		*val = 0;
+		return 0;
+	}
+
 	switch (format->format) {
 	case DRM_FORMAT_BGRX8888:
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_BGRX;
@@ -248,7 +292,15 @@ static const uint32_t sun4i_frontend_formats[] = {
 	DRM_FORMAT_UYVY,
 	DRM_FORMAT_VYUY,
 	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_YUV411,
+	DRM_FORMAT_YUV420,
+	DRM_FORMAT_YUV422,
+	DRM_FORMAT_YUV444,
 	DRM_FORMAT_YUYV,
+	DRM_FORMAT_YVU411,
+	DRM_FORMAT_YVU420,
+	DRM_FORMAT_YVU422,
+	DRM_FORMAT_YVU444,
 	DRM_FORMAT_YVYU,
 };
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index 2f9e3f84e2ff..c62735c2dc4b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -23,15 +23,20 @@
 
 #define SUN4I_FRONTEND_BUF_ADDR0_REG		0x020
 #define SUN4I_FRONTEND_BUF_ADDR1_REG		0x024
+#define SUN4I_FRONTEND_BUF_ADDR2_REG		0x028
 
 #define SUN4I_FRONTEND_LINESTRD0_REG		0x040
 #define SUN4I_FRONTEND_LINESTRD1_REG		0x044
+#define SUN4I_FRONTEND_LINESTRD2_REG		0x048
 
 #define SUN4I_FRONTEND_INPUT_FMT_REG		0x04c
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PLANAR	(0 << 8)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED	(1 << 8)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_SEMIPLANAR	(2 << 8)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV444	(0 << 4)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV422	(1 << 4)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV420	(2 << 4)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV411	(3 << 4)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB		(5 << 4)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_UYVY		0
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_YUYV		1
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 185ef38649aa..8cf8ca997b1d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -145,7 +145,15 @@ static const uint32_t sun4i_layer_formats[] = {
 	DRM_FORMAT_UYVY,
 	DRM_FORMAT_VYUY,
 	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_YUV411,
+	DRM_FORMAT_YUV420,
+	DRM_FORMAT_YUV422,
+	DRM_FORMAT_YUV444,
 	DRM_FORMAT_YUYV,
+	DRM_FORMAT_YVU411,
+	DRM_FORMAT_YVU420,
+	DRM_FORMAT_YVU422,
+	DRM_FORMAT_YVU444,
 	DRM_FORMAT_YVYU,
 };
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
