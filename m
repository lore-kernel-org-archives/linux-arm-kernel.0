Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87D3C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:37:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8654F206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cxB3s2uF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8654F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ui9z05LkFxr1NL5DA0pIFzUM3UxwM67yCAtu2Usae9Q=; b=cxB3s2uFaewGkq
	wnhG/TG+GrgnKzHccSFCcjd3PJJ6xQRKVBawTP1754gBhoTMn4/0Fku4VPGnWD9Xk786VXereqILG
	5MMFukUMuMVO4Mdk3LL217gpQJiL5NvTcxwpP8dVKMzEXpdTE2ARmEKL66pvfcq8NjzPS1NaD2lxA
	OyTkjoHoYQUNG+keDqXK6kG6R+OvphBMylynvKdtC4oWK7P2C7xRbZT7rwsUL7NKOQ5Fw+yofpIVt
	IvYYvpATkcc1XIjMlyR8b55kK//Cd//wruKBhdWxTyqqGglS9grnRUE2mabW07x93VsWx0S+i/GE7
	oM4oXAZmvs61UC2JIDtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUSgn-0004rS-PS; Wed, 05 Dec 2018 08:37:49 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUSgk-0004pJ-R6
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 08:37:48 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id CF0FA20E22; Wed,  5 Dec 2018 09:37:35 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 7C404207BF;
 Wed,  5 Dec 2018 09:37:25 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/22] drm/fourcc: Add format info helpers for checking YUV
 planes disposition
Date: Wed,  5 Dec 2018 09:36:42 +0100
Message-Id: <20181205083703.21488-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
References: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_003747_011549_CD468F46 
X-CRM114-Status: GOOD (  10.48  )
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

It is often useful to check whether the DRM format info retrieved from
the DRM framebuffer matches a specific YUV planes disposition.

This introduces helpers to quickly check that a provided format info
matches a YUV format with a specific disposition, in commonly-used
terminology.

The intent of providing helpers taking the format info instead of the
fourcc alone is to avoid the overhead of iterating through all formats
when the whole format info structure is available. As a result, these
helpers are very simple so they are made inline.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 include/drm/drm_fourcc.h | 42 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index bcb389f04618..01cd353d9302 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -143,6 +143,48 @@ struct drm_format_name_buf {
 	char str[32];
 };
 
+/**
+ * drm_format_info_is_yuv_packed - check that the format info matches a YUV
+ * format with data laid in a single plane
+ * @info: format info
+ *
+ * Returns:
+ * A boolean indicating whether the format info matches a packed YUV format.
+ */
+static inline bool
+drm_format_info_is_yuv_packed(const struct drm_format_info *info)
+{
+	return info->is_yuv && info->num_planes == 1;
+}
+
+/**
+ * drm_format_info_is_yuv_semiplanar - check that the format info matches a YUV
+ * format with data laid in two planes (luminance and chrominance)
+ * @info: format info
+ *
+ * Returns:
+ * A boolean indicating whether the format info matches a semiplanar YUV format.
+ */
+static inline bool
+drm_format_info_is_yuv_semiplanar(const struct drm_format_info *info)
+{
+	return info->is_yuv && info->num_planes == 2;
+}
+
+/**
+ * drm_format_info_is_yuv_planar - check that the format info matches a YUV
+ * format with data laid in three planes (one for each YUV component)
+ * @info: format info
+ *
+ * Returns:
+ * A boolean indicating whether the format info matches a planar YUV format.
+ */
+static inline bool
+drm_format_info_is_yuv_planar(const struct drm_format_info *info)
+{
+	return info->is_yuv && info->num_planes == 3;
+}
+
 const struct drm_format_info *__drm_format_info(u32 format);
 const struct drm_format_info *drm_format_info(u32 format);
 const struct drm_format_info *
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
