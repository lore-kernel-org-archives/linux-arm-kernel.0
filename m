Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8E7C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:39:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CCFB20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tg6BDNUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCFB20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cs+WsPBw5KAHtJiWU1ag0L6/P0fqd2Pss5eJqVOzfVE=; b=Tg6BDNUtMWBCHB
	pS1pwGKTzmNAONGb1XtHDl5ykFndyewSwBYT/bx82mkgEAzQzmVoi5YsgAeVRJYBYCbD4AkMjtHy5
	dmYh1Bnov5147z5xkFu+pxMLVKaTMNdbhJHXIlKwcO0lboDTtdq/7A2ARdDBIa3Px5jR+PnHM7opY
	sUo7vzCSN1pw+j+aHQ78OIaRzNggnM9iVT55wJt6rpxpAiBgjfl0zF4njT58Kx31Ftw2Slz+Uh+3n
	RWzpyO9CHLv2Yo96OeJxQ8g91ztZ+ezu3q3L1uQsjpGMAMfzXC1hKu3C8+6RMtOtx4KtFnoi3r9Kb
	jLCVoY5OV4w2vGqmeuyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUShv-0005wi-Iw; Wed, 05 Dec 2018 08:38:59 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUSgl-0004q5-8G
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 08:37:50 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id BFA8520E34; Wed,  5 Dec 2018 09:37:45 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 3104420A44;
 Wed,  5 Dec 2018 09:37:26 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/22] drm/sun4i: frontend: Pass DRM format info to input
 format helpers
Date: Wed,  5 Dec 2018 09:36:45 +0100
Message-Id: <20181205083703.21488-5-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
References: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_003747_558527_AAE0A560 
X-CRM114-Status: GOOD (  12.59  )
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
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
