Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516DBC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:53:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A28E2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KfHVEqYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A28E2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soulik.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=ZDVo/HGrH1W5z4RTz8ST/k2+AABzOQ9BYW0JI1/H3gc=; b=KfH
	VEqYDh5Tmj6gr8+Tw2/H15GBplOQKrdc4iNxY304F/x3m4GE9m0z+dax/eF4q73wwWK3p1VGnISJl
	VqstgIPpDVAstMkwX4DkgEyhlRKr83vDYrRpK8znl5k/nXSdyTSRujZVzQYayZDznh2IpVmPag5bg
	+FbkBXCXFPv+l3SCNUaSWQexBPf1IosA9nL48f/jdhRb7yW4xDKeaAyZwYpIyTa6TuFZSIlOppJW7
	76m2iHYLZXCGD+cvhMCQeq/NxBIhHfnP2uyK+MU48OWVSkxWuOZtIrBpVN5S0hc/2AsLw7vpiL6yW
	l5J6fRw3HMDu8GYpZHgHrld2Fl4pWQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUXbz-0007dg-5h; Wed, 05 Dec 2018 13:53:11 +0000
Received: from kozue.soulik.info ([2001:19f0:7000:8404:5054:ff:fe75:428f])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUXbw-0007ck-CK; Wed, 05 Dec 2018 13:53:10 +0000
Received: from misaki.sumomo.pri (unknown
 [IPv6:2001:470:b30d:2:c604:15ff:0:f0e])
 by kozue.soulik.info (Postfix) with ESMTPA id EB1AB1001C5;
 Wed,  5 Dec 2018 22:52:46 +0900 (JST)
From: Randy Li <ayaka@soulik.info>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v3] drm/rockchip: support hwc layer
Date: Wed,  5 Dec 2018 21:52:30 +0800
Message-Id: <20181205135230.17677-1-ayaka@soulik.info>
X-Mailer: git-send-email 2.14.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_055308_624988_3858A51F 
X-CRM114-Status: GOOD (  12.12  )
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
Cc: heiko@sntech.de, airlied@linux.ie, ayaka <ayaka@soulik.info>,
 linux-kernel@vger.kernel.org, hjc@rock-chips.com,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: ayaka <ayaka@soulik.info>

The Windows 2/3 or a RGB UI layer is a high performance flexibly
plane. It is too waste to use it as a cursor plane.

I have verified this patch with weston git version, I am not
sure whether X would meet with this patch. As the previous
author is gone, I can't confirm this problem with him.

Also the weston only use the only two achors with a same
size and pixel format, I need more users to verify this
patch.

changelog:
v2: the previous version is mixed with the code for the other
patches, I forget to remove it.
v3: fix the error for the rk3399 vop little.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 20 ++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 42 ++++++++++++++++++++++++++---
 2 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index fb70fb486fbf..1a3b72391ee8 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -751,6 +751,26 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 
 	dsp_info = (drm_rect_height(dest) - 1) << 16;
 	dsp_info |= (drm_rect_width(dest) - 1) & 0xffff;
+	/* HWC layer only supports various of square icon */
+	if (plane->type == DRM_PLANE_TYPE_CURSOR) {
+		switch (actual_w) {
+		case 32:
+			dsp_info = 0;
+			break;
+		case 64:
+			dsp_info = 0x1;
+			break;
+		case 94:
+			dsp_info = 0x10;
+			break;
+		case 128:
+			dsp_info = 0x11;
+			break;
+		/* Unsupported pixel resolution */
+		default:
+			return;
+		}
+	}
 
 	dsp_stx = dest->x1 + crtc->mode.htotal - crtc->mode.hsync_start;
 	dsp_sty = dest->y1 + crtc->mode.vtotal - crtc->mode.vsync_start;
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 08fc40af52c8..694f43fdeb23 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -63,6 +63,15 @@ static const uint32_t formats_win_lite[] = {
 	DRM_FORMAT_BGR565,
 };
 
+static const uint32_t formats_win_hwc[] = {
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_BGR565,
+};
+
 static const struct vop_scl_regs rk3036_win_scl = {
 	.scale_yrgb_x = VOP_REG(RK3036_WIN0_SCL_FACTOR_YRGB, 0xffff, 0x0),
 	.scale_yrgb_y = VOP_REG(RK3036_WIN0_SCL_FACTOR_YRGB, 0xffff, 16),
@@ -456,6 +465,19 @@ static const struct vop_win_phy rk3288_win23_data = {
 	.dst_alpha_ctl = VOP_REG(RK3288_WIN2_DST_ALPHA_CTRL, 0xff, 0),
 };
 
+static const struct vop_win_phy rk3288_winhwc_data = {
+	.data_formats = formats_win_hwc,
+	.nformats = ARRAY_SIZE(formats_win_hwc),
+	.enable = VOP_REG(RK3288_HWC_CTRL0, 0x1, 0),
+	.format = VOP_REG(RK3288_HWC_CTRL0, 0x7, 1),
+	.rb_swap = VOP_REG(RK3288_HWC_CTRL0, 0x1, 12),
+	.dsp_info = VOP_REG(RK3288_HWC_CTRL0, 0x3, 5),
+	.dsp_st = VOP_REG(RK3288_HWC_DSP_ST, 0x1fff1fff, 0),
+	.yrgb_mst = VOP_REG(RK3288_HWC_MST, 0xffffffff, 0),
+	.src_alpha_ctl = VOP_REG(RK3288_HWC_SRC_ALPHA_CTRL, 0xffff, 0),
+	.dst_alpha_ctl = VOP_REG(RK3288_HWC_DST_ALPHA_CTRL, 0xffffffff, 0),
+};
+
 static const struct vop_modeset rk3288_modeset = {
 	.htotal_pw = VOP_REG(RK3288_DSP_HTOTAL_HS_END, 0x1fff1fff, 0),
 	.hact_st_end = VOP_REG(RK3288_DSP_HACT_ST_END, 0x1fff1fff, 0),
@@ -500,7 +522,10 @@ static const struct vop_win_data rk3288_vop_win_data[] = {
 	{ .base = 0x00, .phy = &rk3288_win23_data,
 	  .type = DRM_PLANE_TYPE_OVERLAY },
 	{ .base = 0x50, .phy = &rk3288_win23_data,
-	  .type = DRM_PLANE_TYPE_CURSOR },
+	  .type = DRM_PLANE_TYPE_OVERLAY },
+	{ .base = 0x00, .phy = &rk3288_winhwc_data,
+	  .type = DRM_PLANE_TYPE_CURSOR,
+	},
 };
 
 static const int rk3288_vop_intrs[] = {
@@ -573,7 +598,10 @@ static const struct vop_win_data rk3368_vop_win_data[] = {
 	{ .base = 0x00, .phy = &rk3368_win23_data,
 	  .type = DRM_PLANE_TYPE_OVERLAY },
 	{ .base = 0x50, .phy = &rk3368_win23_data,
-	  .type = DRM_PLANE_TYPE_CURSOR },
+	  .type = DRM_PLANE_TYPE_OVERLAY },
+	{ .base = 0x00, .phy = &rk3288_winhwc_data,
+	  .type = DRM_PLANE_TYPE_CURSOR,
+	},
 };
 
 static const struct vop_output rk3368_output = {
@@ -653,7 +681,10 @@ static const struct vop_win_data rk3399_vop_lit_win_data[] = {
 	{ .base = 0x00, .phy = &rk3288_win01_data,
 	  .type = DRM_PLANE_TYPE_PRIMARY },
 	{ .base = 0x00, .phy = &rk3368_win23_data,
-	  .type = DRM_PLANE_TYPE_CURSOR},
+	  .type = DRM_PLANE_TYPE_OVERLAY},
+	{ .base = 0x00, .phy = &rk3288_winhwc_data,
+	  .type = DRM_PLANE_TYPE_CURSOR,
+	},
 };
 
 static const struct vop_data rk3399_vop_lit = {
@@ -735,7 +766,10 @@ static const struct vop_win_data rk3328_vop_win_data[] = {
 	{ .base = 0x1d0, .phy = &rk3288_win01_data,
 	  .type = DRM_PLANE_TYPE_OVERLAY },
 	{ .base = 0x2d0, .phy = &rk3288_win01_data,
-	  .type = DRM_PLANE_TYPE_CURSOR },
+	  .type = DRM_PLANE_TYPE_OVERLAY },
+	{ .base = 0x3d0, .phy = &rk3288_winhwc_data,
+	  .type = DRM_PLANE_TYPE_CURSOR,
+	},
 };
 
 static const struct vop_data rk3328_vop = {
-- 
2.14.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
