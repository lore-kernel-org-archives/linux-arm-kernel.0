From: daniel.vetter@ffwll.ch (Daniel Vetter)
Date: Tue, 27 Nov 2018 18:34:24 +0100
Subject: [PATCH] drm/fbdev: Make skip_vt_switch the default
In-Reply-To: <20181127170952.28507-1-daniel.vetter@ffwll.ch>
References: <20181127170952.28507-1-daniel.vetter@ffwll.ch>
Message-ID: <20181127173424.301-1-daniel.vetter@ffwll.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KMS drivers really should all be able to restore their display state
on resume without fbcon helping out. So make this the default.

Since I'm not entirely foolish, make it only a default, which drivers
can still override. That way when the inevitable regression report
happens I can fix things up with a one-liner plus FIXME comment that
someone should fix up the suspend/resume code in that driver.

But at least all new drivers won't be broken by accident as soon as
you turn off fbcon because "suspend/resume worked when I tested it".

v2: Keep this for radeon because of

commit 18c437caa5b18a235dd65cec224eab54bebcee65
Author: Alex Deucher <alexander.deucher@amd.com>
Date:   Tue Nov 14 17:19:29 2017 -0500

    Revert "drm/radeon: dont switch vt on suspend"

Thanks to Michel D?nzer for pointing this one out.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Michel D?nzer <michel@daenzer.net>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: "Heiko St?bner" <heiko@sntech.de>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian K?nig" <christian.koenig@amd.com>
Cc: Samuel Li <Samuel.Li@amd.com>
Cc: "Michel D?nzer" <michel.daenzer@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Junwei Zhang <Jerry.Zhang@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Shirish S <shirish.s@amd.com>
Cc: Daniel Stone <daniels@collabora.com>
Cc: "Noralf Tr?nnes" <noralf@tronnes.org>
Cc: intel-gfx at lists.freedesktop.org
Cc: nouveau at lists.freedesktop.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-rockchip at lists.infradead.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c        | 1 -
 drivers/gpu/drm/drm_fb_helper.c               | 1 +
 drivers/gpu/drm/i915/intel_fbdev.c            | 3 ---
 drivers/gpu/drm/nouveau/nouveau_fbcon.c       | 1 -
 drivers/gpu/drm/radeon/radeon_fb.c            | 3 +++
 drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c | 2 --
 6 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
index 5cbde74b97dd..24890d8f9ee4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -234,7 +234,6 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
 	}
 
 	info->par = rfbdev;
-	info->skip_vt_switch = true;
 
 	ret = amdgpu_display_framebuffer_init(adev->ddev, &rfbdev->rfb,
 					      &mode_cmd, gobj);
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 5e9ca6f96379..41f37704e0a3 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -934,6 +934,7 @@ struct fb_info *drm_fb_helper_alloc_fbi(struct drm_fb_helper *fb_helper)
 	}
 
 	fb_helper->fbdev = info;
+	info->skip_vt_switch = true;
 
 	return info;
 
diff --git a/drivers/gpu/drm/i915/intel_fbdev.c b/drivers/gpu/drm/i915/intel_fbdev.c
index 2480c7d6edee..d6f8d4bbc9fc 100644
--- a/drivers/gpu/drm/i915/intel_fbdev.c
+++ b/drivers/gpu/drm/i915/intel_fbdev.c
@@ -257,9 +257,6 @@ static int intelfb_create(struct drm_fb_helper *helper,
 	info->screen_base = vaddr;
 	info->screen_size = vma->node.size;
 
-	/* This driver doesn't need a VT switch to restore the mode on resume */
-	info->skip_vt_switch = true;
-
 	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->format->depth);
 	drm_fb_helper_fill_var(info, &ifbdev->helper, sizes->fb_width, sizes->fb_height);
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.c b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
index 032317c81bf0..67572408d9ae 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
@@ -365,7 +365,6 @@ nouveau_fbcon_create(struct drm_fb_helper *helper,
 		ret = PTR_ERR(info);
 		goto out_unlock;
 	}
-	info->skip_vt_switch = 1;
 
 	info->par = fbcon;
 
diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeon/radeon_fb.c
index 1179034024ae..d50bff20f7de 100644
--- a/drivers/gpu/drm/radeon/radeon_fb.c
+++ b/drivers/gpu/drm/radeon/radeon_fb.c
@@ -244,6 +244,9 @@ static int radeonfb_create(struct drm_fb_helper *helper,
 		goto out;
 	}
 
+	/* radeon resume is fragile and needs a vt switch to help it along */
+	info->skip_vt_switch = false;
+
 	info->par = rfbdev;
 
 	ret = radeon_framebuffer_init(rdev->ddev, &rfbdev->fb, &mode_cmd, gobj);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
index e6650553f5d6..361604e51361 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
@@ -111,8 +111,6 @@ static int rockchip_drm_fbdev_create(struct drm_fb_helper *helper,
 		      rk_obj->kvaddr,
 		      offset, size);
 
-	fbi->skip_vt_switch = true;
-
 	return 0;
 
 out:
-- 
2.19.1
