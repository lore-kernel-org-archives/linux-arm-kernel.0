Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B98C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:38:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E9B20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y6Qleoki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E9B20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eYNAHRr0a2qjsgxtW1N5Ybztk6TkCeMbSK/bvZLt7yA=; b=Y6QleokimIn8eC
	eLGmvhZ2Vu8xaMSh9lDl0dyEk1dfrXyfoc7H7smuOOMrxJ0FvBrwDQFo+rg5YYq1l0kvW966vAJDJ
	eDr7yBXPT/Wcj2/g0POqhtQkrgZR4Ped7GE99MhuoRXqLCRjuVo+gKNvWrBwsqYtku8cg7qbbUtf2
	MamZuWFc0uuxWNPChaDeFOX4z4gI/udtwUUEdY9zSQ5RjVgHMt2m/fi1gESvggr8q5mIJJ0WHWXMA
	Mmnaxy9LnG4kqYiW6bxOy6CA4Pba+1LnfcQwqC5gm2jgwjL1eH5yzmMmYP6DamqRguYdxZnLFEP9H
	Qakl+FG+OSLAaWvOoBIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUSh0-00055p-UY; Wed, 05 Dec 2018 08:38:03 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUSgk-0004pK-R5
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 08:37:48 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 14B32207BF; Wed,  5 Dec 2018 09:37:36 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id B3E6520828;
 Wed,  5 Dec 2018 09:37:25 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/22] drm/fourcc: Add format info helpers for checking YUV
 sub-sampling
Date: Wed,  5 Dec 2018 09:36:43 +0100
Message-Id: <20181205083703.21488-3-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
References: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_003747_271945_F977AAAF 
X-CRM114-Status: UNSURE (   9.51  )
X-CRM114-Notice: Please train this message.
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

Display engine drivers often need to distinguish between different types of
YUV sub-sampling. This introduces helpers to check for common sub-sampling
ratios in their commonly-used denomination from the DRM format info.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 include/drm/drm_fourcc.h | 75 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index 01cd353d9302..b3d9d88ab290 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -185,6 +185,81 @@ drm_format_info_is_yuv_planar(const struct drm_format_info *info)
 	return info->is_yuv && info->num_planes == 3;
 }
 
+/**
+ * drm_format_info_is_yuv_sampling_410 - check that the format info matches a
+ * YUV format with 4:1:0 sub-sampling
+ * @info: format info
+ *
+ * Returns:
+ * A boolean indicating whether the format info matches a YUV format with 4:1:0
+ * sub-sampling.
+ */
+static inline bool
+drm_format_info_is_yuv_sampling_410(const struct drm_format_info *info)
+{
+	return info->is_yuv && info->hsub == 4 && info->vsub == 4;
+}
+
+/**
+ * drm_format_info_is_yuv_sampling_411 - check that the format info matches a
+ * YUV format with 4:1:1 sub-sampling
+ * @info: format info
+ *
+ * Returns:
+ * A boolean indicating whether the format info matches a YUV format with 4:1:1
+ * sub-sampling.
+ */
+static inline bool
+drm_format_info_is_yuv_sampling_411(const struct drm_format_info *info)
+{
+	return info->is_yuv && info->hsub == 4 && info->vsub == 1;
+}
+
+/**
+ * drm_format_info_is_yuv_sampling_420 - check that the format info matches a
+ * YUV format with 4:2:0 sub-sampling
+ * @info: format info
+ *
+ * Returns:
+ * A boolean indicating whether the format info matches a YUV format with 4:2:0
+ * sub-sampling.
+ */
+static inline bool
+drm_format_info_is_yuv_sampling_420(const struct drm_format_info *info)
+{
+	return info->is_yuv && info->hsub == 2 && info->vsub == 2;
+}
+
+/**
+ * drm_format_info_is_yuv_sampling_422 - check that the format info matches a
+ * YUV format with 4:2:2 sub-sampling
+ * @info: format info
+ *
+ * Returns:
+ * A boolean indicating whether the format info matches a YUV format with 4:2:2
+ * sub-sampling.
+ */
+static inline bool
+drm_format_info_is_yuv_sampling_422(const struct drm_format_info *info)
+{
+	return info->is_yuv && info->hsub == 2 && info->vsub == 1;
+}
+
+/**
+ * drm_format_info_is_yuv_sampling_444 - check that the format info matches a
+ * YUV format with 4:4:4 sub-sampling
+ * @info: format info
+ *
+ * Returns:
+ * A boolean indicating whether the format info matches a YUV format with 4:4:4
+ * sub-sampling.
+ */
+static inline bool
+drm_format_info_is_yuv_sampling_444(const struct drm_format_info *info)
+{
+	return info->is_yuv && info->hsub == 1 && info->vsub == 1;
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
