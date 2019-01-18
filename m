Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221FDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:52:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4072087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CaXH3BU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4072087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mNYdxRb6TcX5gKcxpQLEwr4D4bWz17vZO0RR1F5lHM0=; b=CaXH3BU5yfjZI8
	VoFdVDZicgWxk8MgG6agfiQ7ymGaMhlK5zfHJyiy9kBueJnIgn1fcV8iSvf2WFRjV4HPPAk5Pachk
	eBQGoTPv+/71bDgQtCs+61bPNWn71httd/E/XwsnaIBmU4ate6DPRYsqWdze8pfXP6pfFXGmt072+
	XVEMbgVs3dX/jYQVS07w8p3rxpmmrcQaiHRDjpCU3zFsPlINNbA9jCkCzA3ACUKOJLvUpt8L+uUBz
	0bqEVtKGePir3I3iUPrQBZoAL9PvmAY0gx/ClNVcJpzLQmVOWQb90x4ysKnV3Or+dm5/ZO2PFCnvf
	auBbcx6iruYYxRXV7LnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkVVK-0007X2-Ap; Fri, 18 Jan 2019 14:52:18 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkVUk-0006nl-Pc
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 14:51:51 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 69169209C0; Fri, 18 Jan 2019 15:51:41 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id 1AB9D207B6;
 Fri, 18 Jan 2019 15:51:41 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH RESEND v5 01/23] drm/fourcc: Add format info helpers for
 checking YUV planes disposition
Date: Fri, 18 Jan 2019 15:51:11 +0100
Message-Id: <20190118145133.21281-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
References: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_065143_450314_46A5C327 
X-CRM114-Status: GOOD (  10.30  )
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
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
