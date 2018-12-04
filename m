Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAA7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:27:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD50206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mMGdOR1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD50206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C9usXJIQMk058lwQDs3QooYNs5wNtdhXLOA5BjW8rok=; b=mMGdOR1MY2OCrd
	tof34lSdlhGmCk0oIozUQ1x8BSI6Kxp5910oWWKQfLYV/6GZ1jvYBIv5uktWXwjXC9vs9iywbLrL0
	qx+MrJL25tRrWNYdHFgoRpeAo6yo8NFAsec8m+YBi4ZcGSTKlarmMEG1sG8Sny6yN2SukYrT4wKt2
	OTH5Hjr0uzm/4E0srKtH5fEDa/1i9u85hXrqo4+dMm6SuDYyuH4vd/AGQ7v9BgMzfP4OAtAkr9EqJ
	9bG6CaQXmGXM0T+DPCgnYelMIgdy5jnoN2ud5mccDHkwD3/Vbn8CulKtdKJEbFQVtdkH9e4j9ZmHz
	dhUxAYYvn71DNBI9tngA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUBfj-0004s9-0E; Tue, 04 Dec 2018 14:27:35 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBbl-0007fg-56
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:23:38 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 8433420E0C; Tue,  4 Dec 2018 15:23:18 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id C1EC320E0C;
 Tue,  4 Dec 2018 15:22:41 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/21] drm/sun4i: Add buffer stride and offset
 configuration for tiling mode
Date: Tue,  4 Dec 2018 15:22:09 +0100
Message-Id: <20181204142218.16284-13-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_062330_239603_FB4E66C6 
X-CRM114-Status: GOOD (  17.15  )
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

This introduces stride and offset configuration for the VPU tiling mode.
Stride is calculated differently than it is for linear formats and an
offset is calculated, for which new register definitions are introduced.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 60 ++++++++++++++++++++++++--
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  8 ++++
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 3dcb05147e41..151b78d3c02e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -125,21 +125,75 @@ void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
+	unsigned int strides[3] = {};
+
 	dma_addr_t paddr;
 	bool swap;
 
+	if (fb->modifier == DRM_FORMAT_MOD_ALLWINNER_TILED) {
+		unsigned int width = state->src_w >> 16;
+		unsigned int offset;
+
+		/*
+		 * In MB32 tiled mode, the stride is defined as the distance
+		 * between the start of the end line of the current tile and
+		 * the start of the first line in the next vertical tile.
+		 *
+		 * Tiles are represented in row-major order, thus the end line
+		 * of current tile starts at: 31 * 32 (31 lines of 32 cols),
+		 * the next vertical tile starts at: 32-bit-aligned-width * 32
+		 * and the distance is: 32 * (32-bit-aligned-width - 31).
+		 */
+
+		strides[0] = SUN4I_FRONTEND_LINESTRD_TILED(fb->pitches[0]);
+
+		/*
+		 * The X1 offset is the offset to the bottom-right point in the
+		 * end tile, which is the final pixel (at offset width - 1)
+		 * within the end tile (with a 32-byte mask).
+		 */
+		offset = (width - 1) & (32 - 1);
+
+		regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF0_REG,
+			     SUN4I_FRONTEND_TB_OFF_X1(offset));
+
+		if (fb->format->num_planes > 1) {
+			strides[1] =
+				SUN4I_FRONTEND_LINESTRD_TILED(fb->pitches[1]);
+
+			regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF1_REG,
+				     SUN4I_FRONTEND_TB_OFF_X1(offset));
+		}
+
+		if (fb->format->num_planes > 2) {
+			strides[2] =
+				SUN4I_FRONTEND_LINESTRD_TILED(fb->pitches[2]);
+
+			regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF2_REG,
+				     SUN4I_FRONTEND_TB_OFF_X1(offset));
+		}
+	} else {
+		strides[0] = fb->pitches[0];
+
+		if (fb->format->num_planes > 1)
+			strides[1] = fb->pitches[1];
+
+		if (fb->format->num_planes > 2)
+			strides[2] = fb->pitches[2];
+	}
+
 	/* Set the line width */
 	DRM_DEBUG_DRIVER("Frontend stride: %d bytes\n", fb->pitches[0]);
 	regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD0_REG,
-		     fb->pitches[0]);
+		     strides[0]);
 
 	if (fb->format->num_planes > 1)
 		regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD1_REG,
-			     fb->pitches[1]);
+			     strides[1]);
 
 	if (fb->format->num_planes > 2)
 		regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD2_REG,
-			     fb->pitches[2]);
+			     strides[2]);
 
 	/* Some planar formats require chroma channel swapping by hand. */
 	swap = sun4i_frontend_format_chroma_requires_swap(fb->format->format);
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index ae53ee644694..9434407ea40d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -25,9 +25,17 @@
 #define SUN4I_FRONTEND_BUF_ADDR1_REG		0x024
 #define SUN4I_FRONTEND_BUF_ADDR2_REG		0x028
 
+#define SUN4I_FRONTEND_TB_OFF0_REG		0x030
+#define SUN4I_FRONTEND_TB_OFF1_REG		0x034
+#define SUN4I_FRONTEND_TB_OFF2_REG		0x038
+#define SUN4I_FRONTEND_TB_OFF_X1(x1)			((x1) << 16)
+#define SUN4I_FRONTEND_TB_OFF_Y0(y0)			((y0) << 8)
+#define SUN4I_FRONTEND_TB_OFF_X0(x0)			(x0)
+
 #define SUN4I_FRONTEND_LINESTRD0_REG		0x040
 #define SUN4I_FRONTEND_LINESTRD1_REG		0x044
 #define SUN4I_FRONTEND_LINESTRD2_REG		0x048
+#define SUN4I_FRONTEND_LINESTRD_TILED(stride)		(((stride) - 31) * 32)
 
 #define SUN4I_FRONTEND_INPUT_FMT_REG		0x04c
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PLANAR	(0 << 8)
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
