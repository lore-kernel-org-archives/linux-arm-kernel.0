Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839F8C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:33:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A0CE2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Eog/xeVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0CE2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LZ3CFEpMAEi7sueYzS/JRp2/KavZS5BzLHDd5QBP33Y=; b=Eog/xeVVBUYUxs
	HXXerQvQCmc+wMu7fw/PEevdeKQRQO6JnIiLydWIxp/eCXHH5xD+0x/WRhAVceqDjJl3fhBNeMGj0
	qDNtbLgOzBP8HPWwJ5RvmyXqNMogsMlKajfyzPZMMVhAAnjUYBYIVD3mAMxZwQ2tDVlSxG9cLUCm/
	vx8UZbD59GPzxYfLlbFcwgsK0k4rNuf57iEugOsXR2cFR+LaIYR6lMBYwJQD32c2AMLSspkjORetr
	xM9Y/Bnq3AWZRz9ud30VB/7JyABYZJh3dUY/Eh52/iARX6fYJRNyHipuo+p1TMX9YFGuIYkoXvecy
	TMU9EF5+6QRvgizr8L1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUWN3-0005j8-P5; Wed, 05 Dec 2018 12:33:41 +0000
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUWMz-0005fA-JB; Wed, 05 Dec 2018 12:33:39 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: koike) with ESMTPSA id D221C260C86
From: Helen Koike <helen.koike@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 David Airlie <airlied@linux.ie>
Subject: [PATCH v4] drm/rockchip: update cursors asynchronously through atomic.
Date: Wed,  5 Dec 2018 10:33:10 -0200
Message-Id: <20181205123310.7965-1-helen.koike@collabora.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_043337_888625_2DE6E0FE 
X-CRM114-Status: GOOD (  14.09  )
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
Cc: =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@google.com>,
 Sean Paul <seanpaul@google.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Tomasz Figa <tfiga@chromium.org>,
 linux-rockchip@lists.infradead.org,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Add support to async updates of cursors by using the new atomic
interface for that.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
[updated for upstream]
Signed-off-by: Helen Koike <helen.koike@collabora.com>

---
Hello,

This is the forth version of the async-plane update suport to the
Rockchip driver.

I tested running igt kms_cursor_legacy and kms_atomic tests using a 96Boards Ficus.

Note that before the patch, the following igt tests failed:

        basic-flip-before-cursor-atomic
        basic-flip-before-cursor-legacy
        cursor-vs-flip-atomic
        cursor-vs-flip-legacy
        cursor-vs-flip-toggle
        flip-vs-cursor-atomic
        flip-vs-cursor-busy-crc-atomic
        flip-vs-cursor-busy-crc-legacy
        flip-vs-cursor-crc-atomic
        flip-vs-cursor-crc-legacy
        flip-vs-cursor-legacy

Full log: https://people.collabora.com/~koike/results-4.20/html/

Now with only the following fails:
        cursor-vs-flip-legacy
        flip-vs-cursor-busy-crc-atomic
        flip-vs-cursor-busy-crc-legacy
        flip-vs-cursor-crc-atomic
        flip-vs-cursor-crc-legacy

Full log: https://people.collabora.com/~koike/results-4.20-async/html/

Thanks
Helen

Changes in v4:
- Removed vop_crtc_atomic_commit_flush
- Call drm_atomic_set_fb_for_plane() only when framebuffers are
different
- Removed unecessary ret variable from vop_plane_atomic_async_check
- async_update: duplicate plane state for an atomic swap
- async_update: prevent releasing buffer current being scaned out by the
hw by getting a reference and adding a worker

Changes in v3:
- Rebased on top of drm-misc
- Fix missing include in rockchip_drm_vop.c
- New function vop_crtc_atomic_commit_flush

Changes in v2:
- v2: https://patchwork.freedesktop.org/patch/254180/
- Change the framebuffer as well to cover jumpy cursor when hovering
  text boxes or hyperlink. (Tomasz)
- Use the PSR inhibit mechanism when accessing VOP hardware instead of
  PSR flushing (Tomasz)

Changes in v1:
- Rebased on top of drm-misc
- In async_check call drm_atomic_helper_check_plane_state to check that
  the desired plane is valid and update various bits of derived state
  (clipped coordinates etc.)
- In async_check allow to configure new scaling in the fast path.
- In async_update force to flush all registered PSR encoders.
- In async_update call atomic_update directly.
- In async_update call vop_cfg_done needed to set the vop registers and take effect.

 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  | 36 ----------
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c | 37 +++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_psr.h |  3 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 74 +++++++++++++++++++++
 4 files changed, 114 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index ea18cb2a76c0..08bec50d9c5d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -127,42 +127,6 @@ rockchip_user_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 	return ERR_PTR(ret);
 }
 
-static void
-rockchip_drm_psr_inhibit_get_state(struct drm_atomic_state *state)
-{
-	struct drm_crtc *crtc;
-	struct drm_crtc_state *crtc_state;
-	struct drm_encoder *encoder;
-	u32 encoder_mask = 0;
-	int i;
-
-	for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
-		encoder_mask |= crtc_state->encoder_mask;
-		encoder_mask |= crtc->state->encoder_mask;
-	}
-
-	drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
-		rockchip_drm_psr_inhibit_get(encoder);
-}
-
-static void
-rockchip_drm_psr_inhibit_put_state(struct drm_atomic_state *state)
-{
-	struct drm_crtc *crtc;
-	struct drm_crtc_state *crtc_state;
-	struct drm_encoder *encoder;
-	u32 encoder_mask = 0;
-	int i;
-
-	for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
-		encoder_mask |= crtc_state->encoder_mask;
-		encoder_mask |= crtc->state->encoder_mask;
-	}
-
-	drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
-		rockchip_drm_psr_inhibit_put(encoder);
-}
-
 static void
 rockchip_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
 {
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
index 01ff3c858875..22a70ab6e214 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
@@ -13,6 +13,7 @@
  */
 
 #include <drm/drmP.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_crtc_helper.h>
 
 #include "rockchip_drm_drv.h"
@@ -109,6 +110,42 @@ int rockchip_drm_psr_inhibit_put(struct drm_encoder *encoder)
 }
 EXPORT_SYMBOL(rockchip_drm_psr_inhibit_put);
 
+void rockchip_drm_psr_inhibit_get_state(struct drm_atomic_state *state)
+{
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
+	struct drm_encoder *encoder;
+	u32 encoder_mask = 0;
+	int i;
+
+	for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
+		encoder_mask |= crtc_state->encoder_mask;
+		encoder_mask |= crtc->state->encoder_mask;
+	}
+
+	drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
+		rockchip_drm_psr_inhibit_get(encoder);
+}
+EXPORT_SYMBOL(rockchip_drm_psr_inhibit_get_state);
+
+void rockchip_drm_psr_inhibit_put_state(struct drm_atomic_state *state)
+{
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
+	struct drm_encoder *encoder;
+	u32 encoder_mask = 0;
+	int i;
+
+	for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
+		encoder_mask |= crtc_state->encoder_mask;
+		encoder_mask |= crtc->state->encoder_mask;
+	}
+
+	drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
+		rockchip_drm_psr_inhibit_put(encoder);
+}
+EXPORT_SYMBOL(rockchip_drm_psr_inhibit_put_state);
+
 /**
  * rockchip_drm_psr_inhibit_get - acquire PSR inhibit on given encoder
  * @encoder: encoder to obtain the PSR encoder
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
index 860c62494496..25350ba3237b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
@@ -20,6 +20,9 @@ void rockchip_drm_psr_flush_all(struct drm_device *dev);
 int rockchip_drm_psr_inhibit_put(struct drm_encoder *encoder);
 int rockchip_drm_psr_inhibit_get(struct drm_encoder *encoder);
 
+void rockchip_drm_psr_inhibit_get_state(struct drm_atomic_state *state);
+void rockchip_drm_psr_inhibit_put_state(struct drm_atomic_state *state);
+
 int rockchip_drm_psr_register(struct drm_encoder *encoder,
 			int (*psr_set)(struct drm_encoder *, bool enable));
 void rockchip_drm_psr_unregister(struct drm_encoder *encoder);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index fb70fb486fbf..e5fb21e3ccf8 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -15,6 +15,7 @@
 #include <drm/drm.h>
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
+#include <drm/drm_atomic_uapi.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_flip_work.h>
@@ -819,10 +820,83 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	spin_unlock(&vop->reg_lock);
 }
 
+static int vop_plane_atomic_async_check(struct drm_plane *plane,
+					struct drm_plane_state *state)
+{
+	struct vop_win *vop_win = to_vop_win(plane);
+	const struct vop_win_data *win = vop_win->data;
+	int min_scale = win->phy->scl ? FRAC_16_16(1, 8) :
+					DRM_PLANE_HELPER_NO_SCALING;
+	int max_scale = win->phy->scl ? FRAC_16_16(8, 1) :
+					DRM_PLANE_HELPER_NO_SCALING;
+	struct drm_crtc_state *crtc_state;
+
+	if (plane != state->crtc->cursor)
+		return -EINVAL;
+
+	if (!plane->state)
+		return -EINVAL;
+
+	if (!plane->state->fb)
+		return -EINVAL;
+
+	if (state->state)
+		crtc_state = drm_atomic_get_existing_crtc_state(state->state,
+								state->crtc);
+	else /* Special case for asynchronous cursor updates. */
+		crtc_state = plane->crtc->state;
+
+	return drm_atomic_helper_check_plane_state(plane->state, crtc_state,
+						   min_scale, max_scale,
+						   true, true);
+}
+
+static void vop_plane_atomic_async_update(struct drm_plane *plane,
+					  struct drm_plane_state *new_state)
+{
+	struct vop *vop = to_vop(plane->state->crtc);
+	struct drm_plane_state *plane_state;
+
+	plane_state = plane->funcs->atomic_duplicate_state(plane);
+	plane_state->crtc_x = new_state->crtc_x;
+	plane_state->crtc_y = new_state->crtc_y;
+	plane_state->crtc_h = new_state->crtc_h;
+	plane_state->crtc_w = new_state->crtc_w;
+	plane_state->src_x = new_state->src_x;
+	plane_state->src_y = new_state->src_y;
+	plane_state->src_h = new_state->src_h;
+	plane_state->src_w = new_state->src_w;
+
+	if (plane_state->fb != new_state->fb)
+		drm_atomic_set_fb_for_plane(plane_state, new_state->fb);
+
+	swap(plane_state, plane->state);
+
+	if (plane->state->fb && plane->state->fb != new_state->fb) {
+		drm_framebuffer_get(plane->state->fb);
+		WARN_ON(drm_crtc_vblank_get(plane->state->crtc) != 0);
+		drm_flip_work_queue(&vop->fb_unref_work, plane->state->fb);
+		set_bit(VOP_PENDING_FB_UNREF, &vop->pending);
+	}
+
+	if (vop->is_enabled) {
+		rockchip_drm_psr_inhibit_get_state(new_state->state);
+		vop_plane_atomic_update(plane, plane->state);
+		spin_lock(&vop->reg_lock);
+		vop_cfg_done(vop);
+		spin_unlock(&vop->reg_lock);
+		rockchip_drm_psr_inhibit_put_state(new_state->state);
+	}
+
+	plane->funcs->atomic_destroy_state(plane, plane_state);
+}
+
 static const struct drm_plane_helper_funcs plane_helper_funcs = {
 	.atomic_check = vop_plane_atomic_check,
 	.atomic_update = vop_plane_atomic_update,
 	.atomic_disable = vop_plane_atomic_disable,
+	.atomic_async_check = vop_plane_atomic_async_check,
+	.atomic_async_update = vop_plane_atomic_async_update,
 };
 
 static const struct drm_plane_funcs vop_plane_funcs = {
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
