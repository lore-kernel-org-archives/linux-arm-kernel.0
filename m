Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3168EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:27:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF7D20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mn4pOzuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF7D20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y/bRTgL0p3aX9/8pjgfAJvAKqELAwiKxSzKXguth3tU=; b=mn4pOzuzAwzox2
	m1PPM3HhbVytQBDNylXqq006J1s61dy2Yz4fHqz78cnkzrDiQa/va7E8XohR1TT48nOsHSJ+IETdW
	3/1iRb/dVQrv29muBo9ZDYuN5C11JnB9VYXPvmA/O5s4cIa2S7fOLGxgRtSnwOYBjmchX891p+t0w
	1tVCw9OWeyUZSMISKoqeB/3TIUccU2f71OZWskoizStr/4+DpRrjDwWb8uiqU5lftP7hAhCh44Ahz
	uQJY/ZkT5bWZLA5OP6q2QfGrqDLF/0vS/Rm5CzAbkHZIOgOaCvlr2NIXaoPb7BSfIPHbDV03/S0Oe
	eY7XYXP7Au+w/8YY5uKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gydhB-0003Xy-Ev; Tue, 26 Feb 2019 14:26:57 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gydgU-0002iO-NX
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 14:26:21 +0000
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr
 [90.88.147.150]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 432DDFF80D;
 Tue, 26 Feb 2019 14:26:01 +0000 (UTC)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>,
	Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 4/4] drm/sun4i: rgb: Change the pixel clock validation check
Date: Tue, 26 Feb 2019 15:25:49 +0100
Message-Id: <ec2dc2a7b3d4bd44f7a2a6e1c1813f92449a7310.1551191081.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.3a2868d9beb0d45f77f844aa8707810909ffebed.1551191081.git-series.maxime.ripard@bootlin.com>
References: <cover.3a2868d9beb0d45f77f844aa8707810909ffebed.1551191081.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_062615_348473_06E65F97 
X-CRM114-Status: GOOD (  21.04  )
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

The current code, since commit bb43d40d7c83 ("drm/sun4i: rgb: Validate the
clock rate"), perform some validation on the pixel clock to filter out the
EDID modes provided by monitors (through bridges) that we wouldn't be able
to reach. For the usual modes, we're able to generate a perfect clock rate,
so a strict check was enough.

However, this had the side effect of preventing displays that would work
otherwise to operate properly, since we would pretty much never be able to
generate an exact rate for those displays, even though we would fall within
that panel tolerance.

This was also shown to happen for unusual modes exposed through EDIDs, for
example on eDP panels.

We can work around this by simplifying a bit the problem: no panels we've
encountered so far actually needed that check. All of them are tied to a
particular board when it is produced, and made to work with the Allwinner
BSP. That pretty much guarantees that we never have a pixel clock out of
reach.

On the other hand, the EDIDs modes that needed to be validated have always
been exposed through bridges.

Let's just use that metric to instead of validating all modes, only
validate modes when we have a bridge attached. It should be good enough for
now, while we still have room for improvements or refinements using the
display_timings structure for example for panels.

We also add a tolerance for EDID-based modes instead of doing a strict
check. This tolerance is of 0.5% which is the one advertised in the VESA
DVT and CVT specs. If that needed to be extended in the future, we can add
a custom module parameter to relax it a bit.

Fixes: bb43d40d7c83 ("drm/sun4i: rgb: Validate the clock rate")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_rgb.c | 37 ++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index 893b6e6d4d85..05beefe93989 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -53,6 +53,14 @@ static int sun4i_rgb_get_modes(struct drm_connector *connector)
 	return drm_panel_get_modes(rgb->panel);
 }
 
+/*
+ * VESA DMT defines a tolerance of 0.5% on the pixel clock, while the
+ * CVT spec reuses that tolerance in its examples, so it looks to be a
+ * good default tolerance for the EDID-based modes. Define it to 5 per
+ * mille to avoid floating point operations.
+ */
+DEFINE SUN4I_RGB_DOTCLOCK_TOLERANCE	5
+
 static enum drm_mode_status sun4i_rgb_mode_valid(struct drm_encoder *crtc,
 						 const struct drm_display_mode *mode)
 {
@@ -61,6 +69,7 @@ static enum drm_mode_status sun4i_rgb_mode_valid(struct drm_encoder *crtc,
 	u32 hsync = mode->hsync_end - mode->hsync_start;
 	u32 vsync = mode->vsync_end - mode->vsync_start;
 	unsigned long long rate = mode->clock * 1000;
+	unsigned long long lowest, highest;
 	unsigned long long rounded_rate;
 
 	DRM_DEBUG_DRIVER("Validating modes...\n");
@@ -93,15 +102,39 @@ static enum drm_mode_status sun4i_rgb_mode_valid(struct drm_encoder *crtc,
 
 	DRM_DEBUG_DRIVER("Vertical parameters OK\n");
 
+	/*
+	 * TODO: We should use the struct display_timing if available
+	 * and / or trying to stretch the timings within that
+	 * tolerancy to take care of panels that we wouldn't be able
+	 * to have a exact match for.
+	 */
+	if (rgb->panel) {
+		DRM_DEBUG_DRIVER("RGB panel used, skipping clock rate checks");
+		goto out;
+	}
+
+	/*
+	 * That shouldn't ever happen unless something is really wrong, but it
+	 * doesn't harm to check.
+	 */
+	if (!rgb->bridge)
+		goto out;
+
 	tcon->dclk_min_div = 6;
 	tcon->dclk_max_div = 127;
 	rounded_rate = clk_round_rate(tcon->dclk, rate);
-	if (rounded_rate < rate)
+
+	lowest = rate * (1000 - SUN4I_RGB_DOTCLOCK_TOLERANCE);
+	do_div(lowest, 1000);
+	if (rounded_rate < lowest)
 		return MODE_CLOCK_LOW;
 
-	if (rounded_rate > rate)
+	highest = rate * (1000 + SUN4I_RGB_DOTCLOCK_TOLERANCE);
+	do_div(highest, 1000);
+	if (rounded_rate > highest)
 		return MODE_CLOCK_HIGH;
 
+out:
 	DRM_DEBUG_DRIVER("Clock rate OK\n");
 
 	return MODE_OK;
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
