From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 21 Jan 2016 09:17:16 +0800
Subject: [PATCH] drm/rockchip: fix wrong pitch/size using on gem
Message-ID: <1453339036-22864-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

args->pitch and args->size may not be set by userspace, sometimes
userspace only malloc args and not memset args to zero, then
args->pitch and args->size is random, it is very danger to use
pitch/size on gem.

pitch's type is u32, and min_pitch's type is int, example,
pitch is 0xffffffff, then pitch < min_pitch return true, then gem will
alloc very very big bufffer, it would eat all the memory and cause kernel
crash.

Stop using pitch/size from args, calc them from other args.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index d908321..18e0733 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -234,13 +234,8 @@ int rockchip_gem_dumb_create(struct drm_file *file_priv,
 	/*
 	 * align to 64 bytes since Mali requires it.
 	 */
-	min_pitch = ALIGN(min_pitch, 64);
-
-	if (args->pitch < min_pitch)
-		args->pitch = min_pitch;
-
-	if (args->size < args->pitch * args->height)
-		args->size = args->pitch * args->height;
+	args->pitch = ALIGN(min_pitch, 64);
+	args->size = args->pitch * args->height;
 
 	rk_obj = rockchip_gem_create_with_handle(file_priv, dev, args->size,
 						 &args->handle);
-- 
1.7.9.5
