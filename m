Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7E3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:44:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE70E2054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z6BpbyhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE70E2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZmQ0bcffYM9lkbl2aSq0C96dmyTsCteS/PVF/O05VBo=; b=Z6BpbyhZoTfpAb
	PrTrZNzMSUd+jPjbb3xh+0EApk73c7ydUtyMrn4lY6MLFhT+1XyoVs12vSfLILNTvHtuPd853PnN/
	H86tU8DQ0SHLyRssjVzHBFre/mFaFgjcs1KUQIQeszFmtFn/x4rIS9+eGOi9BeMRYOYY5XOp86QXC
	F6swCyppjmSPbl0zfDg7jnRv6FR3lOvn2DoqEcG0kmTzvpK0taZEnL+xbDkkziIdaRgxQRJW/XgPP
	jhLwKHSb8ipwC594JDMF8ANWMTEPJgFeuJyXB8vJxuaZ88fY8skB2AWE/RdSMzddJXa6Yi1Br361J
	6cYmkk3m+y4TLOhu0UZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkVNs-0007Ew-1E; Fri, 18 Jan 2019 14:44:36 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkVNA-0006V7-Cs
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 14:43:54 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id D837720A2E; Fri, 18 Jan 2019 15:43:49 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id 95CD4206A7;
 Fri, 18 Jan 2019 15:43:49 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v5 04/23] drm/sun4i: frontend: Pass DRM format info to input
 format helpers
Date: Fri, 18 Jan 2019 15:43:09 +0100
Message-Id: <20190118144328.20649-5-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118144328.20649-1-paul.kocialkowski@bootlin.com>
References: <20190118144328.20649-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_064352_702319_0E12089C 
X-CRM114-Status: GOOD (  12.61  )
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

The helper returning the input mode needs to know the number of planes
for the provided format. Passing the fourcc requires iterating through
the format info list in order to return the number of planes.

Pass the DRM format info structure directly instead to all helpers
related to configuring the input format, since it's available to the
caller. Also rename the input format in the caller function to keep
things consistent.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 1a7ebc45747e..dd5af3019099 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -104,9 +104,11 @@ void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
 }
 EXPORT_SYMBOL(sun4i_frontend_update_buffer);
 
-static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32 *val)
+static int
+sun4i_frontend_drm_format_to_input_fmt(const struct drm_format_info *format,
+				       u32 *val)
 {
-	switch (fmt) {
+	switch (format->format) {
 	case DRM_FORMAT_XRGB8888:
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB;
 		return 0;
@@ -116,9 +118,11 @@ static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32 *val)
 	}
 }
 
-static int sun4i_frontend_drm_format_to_input_mode(uint32_t fmt, u32 *val)
+static int
+sun4i_frontend_drm_format_to_input_mode(const struct drm_format_info *format,
+					u32 *val)
 {
-	if (drm_format_num_planes(fmt) == 1)
+	if (format->num_planes == 1)
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED;
 	else
 		return -EINVAL;
@@ -126,9 +130,11 @@ static int sun4i_frontend_drm_format_to_input_mode(uint32_t fmt, u32 *val)
 	return 0;
 }
 
-static int sun4i_frontend_drm_format_to_input_sequence(uint32_t fmt, u32 *val)
+static int
+sun4i_frontend_drm_format_to_input_sequence(const struct drm_format_info *format,
+					    u32 *val)
 {
-	switch (fmt) {
+	switch (format->format) {
 	case DRM_FORMAT_BGRX8888:
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_BGRX;
 		return 0;
@@ -183,7 +189,7 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
-	uint32_t format = fb->format->format;
+	const struct drm_format_info *format = fb->format;
 	u32 out_fmt_val;
 	u32 in_fmt_val, in_mod_val, in_ps_val;
 	int ret;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
