Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17573C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:55:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA5521019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CV3CxjHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA5521019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ThaS+V7bj4gPseZMZgqlqEPN+pMusBBC9nHfa8UBy44=; b=CV3CxjHeKvzMNv
	CmncqbFasWNJKlOnmPWc+2tEwmhytsHiHkJoV4/BQfiQ0Jr4U5rxCc0S+wQzutgzNtVe323LmI13y
	FACu1yjLfh/XMwaq1po93Urh51I0XjVGQwriz/iTb4C428/4gpxlv8nM4kikBbZnKA/W0O7n0TiqD
	zOzlx198Fz1ix+r3rZGVYUi+tuwA0qvBXzJwG9vYj4To7oTEo3kj3/VXIWcleNSJxmZgyk1+lSNfc
	9pIQGfIQFPnKY4xiXwDhbaVa3Vvnt3OYQkAcmw74YQj6FoPjSZ+7QuuQftrKyiF6e4VNqmLyJvEgU
	G+ndUIeQxvEQgo7l5LiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmKs9-0006mH-9y; Wed, 23 Jan 2019 15:55:25 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmKrQ-0004yu-51
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 15:54:42 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id C52642084E; Wed, 23 Jan 2019 16:54:38 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id 6DAD0209B6;
 Wed, 23 Jan 2019 16:54:28 +0100 (CET)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sean Paul <seanpaul@chromium.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 3/4] drm/sun4i: dsi: Add burst support
Date: Wed, 23 Jan 2019 16:54:23 +0100
Message-Id: <1416f6a45cf6da7ea28e17becd5f257a49746e04.1548236066.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.f7a136448029ab87c498d68164670712639748e7.1548236066.git-series.maxime.ripard@bootlin.com>
References: <cover.f7a136448029ab87c498d68164670712639748e7.1548236066.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_075440_462523_2E18A000 
X-CRM114-Status: GOOD (  19.29  )
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
Cc: Konstantin Sudakov <k.sudakov@integrasources.com>, bbrezillon@kernel.org,
 dri-devel@lists.freedesktop.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Konstantin Sudakov <k.sudakov@integrasources.com>

The current driver doesn't support the DSI burst operation mode.

Let's add the needed quirks to make it work.

Signed-off-by: Konstantin Sudakov <k.sudakov@integrasources.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 178 +++++++++++++++++++-------
 1 file changed, 136 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index e3e4ba90c059..6840b3512a45 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -23,7 +23,9 @@
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
 
+#include "sun4i_crtc.h"
 #include "sun4i_drv.h"
+#include "sun4i_tcon.h"
 #include "sun6i_mipi_dsi.h"
 
 #include <video/mipi_display.h>
@@ -32,6 +34,8 @@
 #define SUN6I_DSI_CTL_EN			BIT(0)
 
 #define SUN6I_DSI_BASIC_CTL_REG		0x00c
+#define SUN6I_DSI_BASIC_CTL_TRAIL_INV(n)		(((n) & 0xf) << 4)
+#define SUN6I_DSI_BASIC_CTL_TRAIL_FILL		BIT(3)
 #define SUN6I_DSI_BASIC_CTL_HBP_DIS		BIT(2)
 #define SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS		BIT(1)
 #define SUN6I_DSI_BASIC_CTL_VIDEO_BURST		BIT(0)
@@ -152,6 +156,8 @@
 
 #define SUN6I_DSI_CMD_TX_REG(n)		(0x300 + (n) * 0x04)
 
+#define SUN6I_DSI_SYNC_POINT		40
+
 enum sun6i_dsi_start_inst {
 	DSI_START_LPRX,
 	DSI_START_LPTX,
@@ -365,31 +371,101 @@ static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 	return delay;
 }
 
+static u16 sun6i_dsi_get_line_num(struct sun6i_dsi *dsi,
+				  struct drm_display_mode *mode)
+{
+	struct mipi_dsi_device *device = dsi->device;
+	unsigned Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
+
+	return mode->htotal * Bpp / device->lanes;
+}
+
+static u16 sun6i_dsi_get_drq_edge0(struct sun6i_dsi *dsi,
+				   struct drm_display_mode *mode,
+				   u16 line_num, u16 edge1)
+{
+	u16 edge0 = edge1;
+
+	edge0 += (mode->hdisplay + 40) * SUN6I_DSI_TCON_DIV / 8;
+
+	if (edge0 > line_num)
+		return edge0 - line_num;
+
+	return 1;
+}
+
+static u16 sun6i_dsi_get_drq_edge1(struct sun6i_dsi *dsi,
+				   struct drm_display_mode *mode,
+				   u16 line_num)
+{
+	struct mipi_dsi_device *device = dsi->device;
+	unsigned Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
+	unsigned hbp = mode->htotal - mode->hsync_end;
+	u16 edge1;
+
+
+	edge1 = SUN6I_DSI_SYNC_POINT;
+	edge1 += mode->hdisplay + hbp + 20;
+	edge1 = edge1 * Bpp / device->lanes;
+
+	if (edge1 > line_num)
+		return line_num;
+
+	return edge1;
+}
+
 static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 				  struct drm_display_mode *mode)
 {
 	struct mipi_dsi_device *device = dsi->device;
-	u32 val = 0;
+	u32 bpp = mipi_dsi_pixel_format_to_bpp(device->format);
+	u32 tcon0_drq = 0;
+
+	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
+		u16 line_num = sun6i_dsi_get_line_num(dsi, mode);
+		u16 edge0, edge1;
+
+		edge1 = sun6i_dsi_get_drq_edge1(dsi, mode, line_num);
+		edge0 = sun6i_dsi_get_drq_edge0(dsi, mode, line_num, edge1);
 
-	if ((mode->hsync_end - mode->hdisplay) > 20) {
+		regmap_write(dsi->regs, SUN6I_DSI_BURST_DRQ_REG,
+			     SUN6I_DSI_BURST_DRQ_EDGE0(edge0) |
+			     SUN6I_DSI_BURST_DRQ_EDGE1(edge1));
+
+		regmap_write(dsi->regs, SUN6I_DSI_BURST_LINE_REG,
+			     SUN6I_DSI_BURST_LINE_NUM(line_num) |
+			     SUN6I_DSI_BURST_LINE_SYNC_POINT(SUN6I_DSI_SYNC_POINT));
+
+		tcon0_drq = SUN6I_DSI_TCON_DRQ_ENABLE_MODE;
+	} else if ((mode->hsync_end - mode->hdisplay) > 20) {
 		/* Maaaaaagic */
 		u16 drq = (mode->hsync_end - mode->hdisplay) - 20;
-
-		drq *= mipi_dsi_pixel_format_to_bpp(device->format);
+		drq *= bpp;
 		drq /= 32;
 
-		val = (SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
-		       SUN6I_DSI_TCON_DRQ_SET(drq));
+		tcon0_drq = SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
+			SUN6I_DSI_TCON_DRQ_SET(drq);
 	}
 
-	regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG, val);
+	regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG, tcon0_drq);
 }
 
 static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
 				      struct drm_display_mode *mode)
 {
+	struct mipi_dsi_device *device = dsi->device;
 	u16 delay = 50 - 1;
 
+	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
+		delay = (mode->htotal - mode->hdisplay) * 150;
+		delay /= (mode->clock / 1000) * 8;
+		delay -= 50;
+	}
+
+	regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_SEL_REG,
+			 2 << (4 * DSI_INST_ID_LP11) |
+			 3 << (4 * DSI_INST_ID_DLY));
+
 	regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_NUM_REG(0),
 		     SUN6I_DSI_INST_LOOP_NUM_N0(50 - 1) |
 		     SUN6I_DSI_INST_LOOP_NUM_N1(delay));
@@ -456,48 +532,66 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	struct mipi_dsi_device *device = dsi->device;
 	unsigned int Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
 	u16 hbp, hfp, hsa, hblk, vblk;
+	u32 basic_ctl = 0;
 	size_t bytes;
 	u8 *buffer;
 
 	/* Do all timing calculations up front to allocate buffer space */
 
-	/*
-	 * A sync period is composed of a blanking packet (4 bytes +
-	 * payload + 2 bytes) and a sync event packet (4 bytes). Its
-	 * minimal size is therefore 10 bytes
-	 */
+	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
+		hsa = 0;
+		hbp = 0;
+		hfp = 0;
+		hblk = mode->hdisplay * Bpp;
+		vblk = 0;
+		basic_ctl = SUN6I_DSI_BASIC_CTL_VIDEO_BURST |
+			    SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS |
+			    SUN6I_DSI_BASIC_CTL_HBP_DIS;
+
+		if (device->lanes == 4)
+			basic_ctl |= SUN6I_DSI_BASIC_CTL_TRAIL_FILL |
+				     SUN6I_DSI_BASIC_CTL_TRAIL_INV(0xc);
+	} else {
+		/*
+		 * A sync period is composed of a blanking packet (4 bytes +
+		 * payload + 2 bytes) and a sync event packet (4 bytes). Its
+		 * minimal size is therefore 10 bytes
+		 */
 #define HSA_PACKET_OVERHEAD	10
-	hsa = max((unsigned int)HSA_PACKET_OVERHEAD,
-		  (mode->hsync_end - mode->hsync_start) * Bpp - HSA_PACKET_OVERHEAD);
-
-	/*
-	 * The backporch is set using a blanking packet (4 bytes +
-	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
-	 */
+		hsa = max((unsigned int)HSA_PACKET_OVERHEAD,
+			  (mode->hsync_end - mode->hsync_start) * Bpp -
+			  HSA_PACKET_OVERHEAD);
+
+		/*
+		 * The backporch is set using a blanking packet (4 bytes +
+		 * payload + 2 bytes). Its minimal size is therefore 6 bytes
+		 */
 #define HBP_PACKET_OVERHEAD	6
-	hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
-		  (mode->hsync_start - mode->hdisplay) * Bpp - HBP_PACKET_OVERHEAD);
-
-	/*
-	 * The frontporch is set using a blanking packet (4 bytes +
-	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
-	 */
+		hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
+			  (mode->hsync_start - mode->hdisplay) * Bpp -
+			  HBP_PACKET_OVERHEAD);
+
+		/*
+		 * The frontporch is set using a blanking packet (4 bytes +
+		 * payload + 2 bytes). Its minimal size is therefore 6 bytes
+		 */
 #define HFP_PACKET_OVERHEAD	6
-	hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
-		  (mode->htotal - mode->hsync_end) * Bpp - HFP_PACKET_OVERHEAD);
-
-	/*
-	 * hblk seems to be the line + porches length.
-	 */
-	hblk = mode->htotal * Bpp - hsa;
-
-	/*
-	 * And I'm not entirely sure what vblk is about. The driver in
-	 * Allwinner BSP is using a rather convoluted calculation
-	 * there only for 4 lanes. However, using 0 (the !4 lanes
-	 * case) even with a 4 lanes screen seems to work...
-	 */
-	vblk = 0;
+		hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
+			  (mode->htotal - mode->hsync_end) * Bpp - HFP_PACKET_OVERHEAD);
+
+		/*
+		 * hblk seems to be the line + porches length.
+		 */
+		hblk = mode->htotal * Bpp - hsa;
+
+		/*
+		 * And I'm not entirely sure what vblk is about. The driver in
+		 * Allwinner BSP is using a rather convoluted calculation
+		 * there only for 4 lanes. However, using 0 (the !4 lanes
+		 * case) even with a 4 lanes screen seems to work...
+		 */
+		vblk = 0;
+	}
 
 	/* How many bytes do we need to send all payloads? */
 	bytes = max_t(size_t, max(max(hfp, hblk), max(hsa, hbp)), vblk);
@@ -505,7 +599,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	if (WARN_ON(!buffer))
 		return;
 
-	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, 0);
+	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, basic_ctl);
 
 	regmap_write(dsi->regs, SUN6I_DSI_SYNC_HSS_REG,
 		     sun6i_dsi_build_sync_pkt(MIPI_DSI_H_SYNC_START,
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
