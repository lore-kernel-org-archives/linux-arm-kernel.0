Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE98C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:40:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCF3206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nYjKGt/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCF3206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8ksugyQbfjI6/3INHRQsB4qqRFz21Awzum/jrQ/Q8ko=; b=nYjKGt/FpQ0pUN
	v3BJbQGSsuVqLgde7WE1YaIFtWTCPso1tI+hiMzyE8ElzRaPt63lsDMGOX+SlodiVdoAhv+7MUxxX
	93OSl2C3pqFxs8ueu05rMSyT9sIx6zwr59GUVeONwMpBSpTdxDcPYOGI4xmA+jeCeDoEU/O97FFU8
	OPaTTg5bA1BtZWPd3F2ylW1J8ImqQATJYsGnxkygXDXnXDHbU+9yXegVMwkP/aTcKmUYLxnJE8PDC
	7zQw0XUdSqgM8uIpFxv/0/2M+q9zmAmx+bSWVlaMEcyeA6VwJyOeJhAYe5UnmagYSZ2CckW1FzPgE
	C7yYna0oF2dyEeYpHNMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUSiz-00078T-76; Wed, 05 Dec 2018 08:40:05 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUSgx-0004rO-2J
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 08:38:08 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 31CCE20A58; Wed,  5 Dec 2018 09:37:46 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id E95DF20A5A;
 Wed,  5 Dec 2018 09:37:26 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/22] drm/sun4i: frontend: Configure and enable YUV to RGB
 CSC when needed
Date: Wed,  5 Dec 2018 09:36:48 +0100
Message-Id: <20181205083703.21488-8-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
References: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_003800_374456_B8A5BF91 
X-CRM114-Status: GOOD (  14.52  )
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

In prevision of adding support for YUV formats, set the YUV to RGB
colorspace conversion coefficients if required and don't bypass the
CSC engine when converting.

The BT601 coefficients from the A33 BSP are copied over from the backend
code. Because of module inter-dependency, we can't have the frontend use
these coefficients from the backend directly.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 23 +++++++++++++++++++++--
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 045013efdc57..bf37a4ea81c5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -213,6 +213,8 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 	const struct drm_format_info *format = fb->format;
 	u32 out_fmt_val;
 	u32 in_fmt_val, in_mod_val, in_ps_val;
+	unsigned int i;
+	u32 bypass;
 	int ret;
 
 	ret = sun4i_frontend_drm_format_to_input_fmt(format, &in_fmt_val);
@@ -250,9 +252,26 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_VERTPHASE1_REG, 0x400);
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_VERTPHASE1_REG, 0x400);
 
+	/*
+	 * Checking the input format is sufficient since we currently only
+	 * support RGB output formats to the backend. If YUV output formats
+	 * ever get supported, an YUV input and output would require bypassing
+	 * the CSC engine too.
+	 */
+	if (format->is_yuv) {
+		/* Setup the CSC engine for YUV to RGB conversion. */
+		bypass = 0;
+
+		for (i = 0; i < ARRAY_SIZE(sunxi_bt601_yuv2rgb_coef); i++)
+			regmap_write(frontend->regs,
+				     SUN4I_FRONTEND_CSC_COEF_REG(i),
+				     sunxi_bt601_yuv2rgb_coef[i]);
+	} else {
+		bypass = SUN4I_FRONTEND_BYPASS_CSC_EN;
+	}
+
 	regmap_update_bits(frontend->regs, SUN4I_FRONTEND_BYPASS_REG,
-			   SUN4I_FRONTEND_BYPASS_CSC_EN,
-			   SUN4I_FRONTEND_BYPASS_CSC_EN);
+			   SUN4I_FRONTEND_BYPASS_CSC_EN, bypass);
 
 	regmap_write(frontend->regs, SUN4I_FRONTEND_INPUT_FMT_REG,
 		     in_mod_val | in_fmt_val | in_ps_val);
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index 3df2bd8a7a95..17b46ecf7d9e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -35,6 +35,8 @@
 #define SUN4I_FRONTEND_OUTPUT_FMT_DATA_FMT_BGRX8888	1
 #define SUN4I_FRONTEND_OUTPUT_FMT_DATA_FMT_XRGB8888	2
 
+#define SUN4I_FRONTEND_CSC_COEF_REG(c)		(0x070 + (0x4 * (c)))
+
 #define SUN4I_FRONTEND_CH0_INSIZE_REG		0x100
 #define SUN4I_FRONTEND_INSIZE(h, w)			((((h) - 1) << 16) | (((w) - 1)))
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
