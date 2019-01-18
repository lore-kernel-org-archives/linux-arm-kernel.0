Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75311C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:54:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F8E32087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PluN0d33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8E32087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0TPDtW80tW8gbnvNClb82bq38G8MmXvXbMu4xsMSPc0=; b=PluN0d33KuLkXY
	e5h7umKnl2bLpudx8XqXjAnszzLzosZhUpIVtI3z6QTh7PnQGDrtAgNAK4OclBEB8/Lx6AIo2PaVC
	R2ZTCY9qismLap89pq0YJxneii03KUGxi0xNwLYiz60DObP/noJOk7+jVs06HNzs5qMv7eevlOUJ1
	NAdNreYRyElSxYiExyWW0w2oW9L2ETm+W/eVHxzCZYivUO3KAlWp9cAlYts5vLxKoXG/QpwEV+zUC
	/WEoioUoGwb3hTrp3lSonEERA8rvfCobfnEL0PBMSRqvmlbM63/TIVl2HVu+GZAVlUdcd8rtZhEax
	Y0Kv8GHCcq495z+QP/PA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkVXY-0001Mh-Np; Fri, 18 Jan 2019 14:54:36 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkVUu-00074n-JU
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 14:52:28 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 5323820DCD; Fri, 18 Jan 2019 15:51:44 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id 30EB420C2D;
 Fri, 18 Jan 2019 15:51:43 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH RESEND v5 09/23] drm/sun4i: frontend: Add support for
 semi-planar YUV input formats
Date: Fri, 18 Jan 2019 15:51:19 +0100
Message-Id: <20190118145133.21281-10-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
References: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_065153_701138_65DBE85C 
X-CRM114-Status: GOOD (  16.03  )
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
 Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>
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
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 50 +++++++++++++++++++++++---
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  6 ++++
 drivers/gpu/drm/sun4i/sun4i_layer.c    |  4 +++
 3 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 1946dd9e58d9..f262069d348f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -119,11 +119,23 @@ void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
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
 
@@ -133,6 +145,8 @@ sun4i_frontend_drm_format_to_input_fmt(const struct drm_format_info *format,
 {
 	if (!format->is_yuv)
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB;
+	else if (drm_format_info_is_yuv_sampling_420(format))
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV420;
 	else if (drm_format_info_is_yuv_sampling_422(format))
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV422;
 	else
@@ -145,12 +159,18 @@ static int
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
 
 static int
@@ -162,6 +182,22 @@ sun4i_frontend_drm_format_to_input_sequence(const struct drm_format_info *format
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
@@ -205,6 +241,10 @@ static int sun4i_frontend_drm_format_to_output_fmt(uint32_t fmt, u32 *val)
 
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
index e287a71a0db9..2f9e3f84e2ff 100644
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
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
