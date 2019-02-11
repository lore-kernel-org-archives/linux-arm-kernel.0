Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0042EC282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:43:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C153B2070C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ELuREXQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C153B2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hpJCZ9EA/UPZOHxdpsDU4XifrJKzufSzSYvDdt789W0=; b=ELuREXQLEFu1U7
	QKkFu8RYNgfQ6oUFkxIeYmh8ibqjBXK+cVgqIUW4GeCFYh8HdZ1PzC4JDt/TMd556A0PAJoT9bKy4
	0AXpQiAY3ydNE2w9K01RRhtgw8Vu63EdeywEelEvNUMyTLmacUS75GkccbRuU74D9OI3kvuKCl/az
	UoqOBryxCsFOPv/K9rHBbXFhXVtahKpbgkHxUbWJTAWS8fqE71Qyy6P0x2taE1789cmYKpGmlBtdq
	27IYpDqs3CnLuiz+CHGJwCRVCW4QGlO7peurgbQeLRjkrSInq4CuI//fEhZ/DBFI99NinIuEYZl9s
	NCOi6x/RhCJcAFkmoIVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtCoF-0006nu-HW; Mon, 11 Feb 2019 14:43:47 +0000
Received: from relay7-d.mail.gandi.net ([217.70.183.200])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtCmJ-0004vN-OP
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 14:42:04 +0000
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 785FC20003;
 Mon, 11 Feb 2019 14:41:44 +0000 (UTC)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sean Paul <seanpaul@chromium.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v3 7/8] drm/sun4i: dsi: Add burst support
Date: Mon, 11 Feb 2019 15:41:28 +0100
Message-Id: <1dcabf2b38d3f0d3387b1cf02575e3d14e3ecd4e.1549896081.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.f28d9994585553a089a519392616b0d26ed54af1.1549896081.git-series.maxime.ripard@bootlin.com>
References: <cover.f28d9994585553a089a519392616b0d26ed54af1.1549896081.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_064148_727249_2FF31F36 
X-CRM114-Status: GOOD (  18.60  )
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
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 171 ++++++++++++++++++++------
 1 file changed, 132 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index e0288e7dc64e..4cb715dc9100 100644
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
@@ -366,13 +372,70 @@ static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 	return max_t(u16, delay, 1);
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
+	edge1 = SUN6I_DSI_SYNC_POINT;
+	edge1 += (mode->hdisplay + hbp + 20) * Bpp / device->lanes;
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
 	u32 val = 0;
 
-	if ((mode->hsync_start - mode->hdisplay) > 20) {
+	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
+		u16 line_num = sun6i_dsi_get_line_num(dsi, mode);
+		u16 edge0, edge1;
+
+		edge1 = sun6i_dsi_get_drq_edge1(dsi, mode, line_num);
+		edge0 = sun6i_dsi_get_drq_edge0(dsi, mode, line_num, edge1);
+
+		regmap_write(dsi->regs, SUN6I_DSI_BURST_DRQ_REG,
+			     SUN6I_DSI_BURST_DRQ_EDGE0(edge0) |
+			     SUN6I_DSI_BURST_DRQ_EDGE1(edge1));
+
+		regmap_write(dsi->regs, SUN6I_DSI_BURST_LINE_REG,
+			     SUN6I_DSI_BURST_LINE_NUM(line_num) |
+			     SUN6I_DSI_BURST_LINE_SYNC_POINT(SUN6I_DSI_SYNC_POINT));
+
+		val = SUN6I_DSI_TCON_DRQ_ENABLE_MODE;
+	} else if ((mode->hsync_start - mode->hdisplay) > 20) {
 		/* Maaaaaagic */
 		u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
 
@@ -389,8 +452,19 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
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
@@ -457,52 +531,71 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
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
+		 * A sync period is composed of a blanking packet (4
+		 * bytes + payload + 2 bytes) and a sync event packet
+		 * (4 bytes). Its minimal size is therefore 10 bytes
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
+			  (mode->hsync_end - mode->hsync_start) * Bpp - HSA_PACKET_OVERHEAD);
+
+		/*
+		 * The backporch is set using a blanking packet (4
+		 * bytes + payload + 2 bytes). Its minimal size is
+		 * therefore 6 bytes
+		 */
 #define HBP_PACKET_OVERHEAD	6
-	hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
-		  (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
-
-	/*
-	 * The frontporch is set using a blanking packet (4 bytes +
-	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
-	 */
+		hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
+			  (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
+
+		/*
+		 * The frontporch is set using a blanking packet (4
+		 * bytes + payload + 2 bytes). Its minimal size is
+		 * therefore 6 bytes
+		 */
 #define HFP_PACKET_OVERHEAD	6
-	hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
-		  (mode->hsync_start - mode->hdisplay) * Bpp - HFP_PACKET_OVERHEAD);
-
-	/*
-	 * The blanking is set using a sync event (4 bytes) and a
-	 * blanking packet (4 bytes + payload + 2 bytes). Its minimal
-	 * size is therefore 10 bytes.
-	 */
+		hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
+			  (mode->hsync_start - mode->hdisplay) * Bpp - HFP_PACKET_OVERHEAD);
+
+		/*
+		 * The blanking is set using a sync event (4 bytes)
+		 * and a blanking packet (4 bytes + payload + 2
+		 * bytes). Its minimal size is therefore 10 bytes.
+		 */
 #define HBLK_PACKET_OVERHEAD	10
-	hblk = max((unsigned int)HBLK_PACKET_OVERHEAD,
-		   (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp - HBLK_PACKET_OVERHEAD);
-
-	/*
-	 * And I'm not entirely sure what vblk is about. The driver in
-	 * Allwinner BSP is using a rather convoluted calculation
-	 * there only for 4 lanes. However, using 0 (the !4 lanes
-	 * case) even with a 4 lanes screen seems to work...
-	 */
-	vblk = 0;
+		hblk = max((unsigned int)HBLK_PACKET_OVERHEAD,
+			   (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp -
+			   HBLK_PACKET_OVERHEAD);
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
@@ -510,7 +603,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
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
