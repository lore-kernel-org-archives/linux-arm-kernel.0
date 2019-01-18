Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E840AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:06:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86B22086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rwBosNIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86B22086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ou1J6Xh+aKH0EHNfTVK2X9pl5B/h+FpzMiSz69VpQnQ=; b=rwBosNIVU5aBll
	M5B4VTd6axGallMccyJYaBvBvysQEeQnxzPEmmh87y60cbDMJHSUk/cObUQr/KHKbvdmSXw///EQ3
	1L3VNZjZEtQkhP5SjbjABS1WEIBRj1xYE3k5p8OIWI8yTwJgFYhEyz/gebEyOemGq36UPp0tkMVn8
	tbQIcIsUFQ71jjmaQWix1NzPsVEwmnFwd96RJYUebPkn58DeS1ZcgmScXC78tcUNlU6NZRpWd90Oo
	0gDrsAbovymQRU6TADQ2eUximihACmIKV6VkvZIv03RpfC6/Gu5TdmhPODEAExKJ3Flf0lPmUGZj/
	lBCmrSZdN7fap8k56p1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkVjE-0001XQ-EJ; Fri, 18 Jan 2019 15:06:40 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkVUt-00072R-Ly
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 14:52:24 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 31A4820C58; Fri, 18 Jan 2019 15:51:43 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id A41A120BCD;
 Fri, 18 Jan 2019 15:51:42 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH RESEND v5 07/23] drm/sun4i: frontend: Configure and enable YUV
 to RGB CSC when needed
Date: Fri, 18 Jan 2019 15:51:17 +0100
Message-Id: <20190118145133.21281-8-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
References: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_065152_737602_149EC2CE 
X-CRM114-Status: GOOD (  14.44  )
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

In prevision of adding support for YUV formats, set the YUV to RGB
colorspace conversion coefficients if required and don't bypass the
CSC engine when converting.

The BT601 coefficients from the A33 BSP are copied over from the backend
code. Because of module inter-dependency, we can't have the frontend use
these coefficients from the backend directly.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
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
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
