From: mark.yao@rock-chips.com (Mark Yao)
Date: Wed,  3 Aug 2016 16:13:45 +0800
Subject: [PATCH] drm/rockchip: fix fbdev crash when not use DRM_FBDEV_EMULATION
Message-ID: <1470212025-30336-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[    1.162571] Unable to handle kernel NULL pointer dereference at virtual address 00000200
[    1.165656] Modules linked in:
[    1.165941] CPU: 5 PID: 143 Comm: kworker/5:2 Not tainted 4.4.15 #237
[    1.166506] Hardware name: Rockchip RK3399 Evaluation Board v1 (Android) (DT)
[    1.167153] Workqueue: events output_poll_execute
[    1.168231] PC is at mutex_lock+0x14/0x44
[    1.168586] LR is at drm_fb_helper_hotplug_event+0x28/0xcc
[    1.172192] [<ffffff8008982110>] mutex_lock+0x14/0x44
[    1.172196] [<ffffff80084025a4>] drm_fb_helper_hotplug_event+0x28/0xcc
[    1.172201] [<ffffff8008427ae4>] rockchip_drm_output_poll_changed+0x14/0x1c
[    1.172204] [<ffffff80083f7c4c>] drm_kms_helper_hotplug_event+0x28/0x34
[    1.172207] [<ffffff80083f7ddc>] output_poll_execute+0x150/0x198
[    1.172212] [<ffffff80080b0ea8>] process_one_work+0x218/0x3dc
[    1.172215] [<ffffff80080b1578>] worker_thread+0x24c/0x374
[    1.172217] [<ffffff80080b5bcc>] kthread+0xdc/0xe4
[    1.172222] [<ffffff8008084cd0>] ret_from_fork+0x10/0x40

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c   | 13 ++++++++++---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h   |  8 ++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c    |  6 +++---
 drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c | 26 +++++++++++++++++---------
 4 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index a822d49..1a4dad6 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -261,7 +261,10 @@ static void rockchip_drm_lastclose(struct drm_device *dev)
 {
 	struct rockchip_drm_private *priv = dev->dev_private;
 
-	drm_fb_helper_restore_fbdev_mode_unlocked(&priv->fbdev_helper);
+	if (!priv->fbdev)
+		return;
+
+	drm_fb_helper_restore_fbdev_mode_unlocked(&priv->fbdev->fbdev_helper);
 }
 
 static const struct file_operations rockchip_drm_driver_fops = {
@@ -310,8 +313,10 @@ void rockchip_drm_fb_suspend(struct drm_device *drm)
 {
 	struct rockchip_drm_private *priv = drm->dev_private;
 
+	if (!priv->fbdev)
+		return;
 	console_lock();
-	drm_fb_helper_set_suspend(&priv->fbdev_helper, 1);
+	drm_fb_helper_set_suspend(&priv->fbdev->fbdev_helper, 1);
 	console_unlock();
 }
 
@@ -319,8 +324,10 @@ void rockchip_drm_fb_resume(struct drm_device *drm)
 {
 	struct rockchip_drm_private *priv = drm->dev_private;
 
+	if (!priv->fbdev)
+		return;
 	console_lock();
-	drm_fb_helper_set_suspend(&priv->fbdev_helper, 0);
+	drm_fb_helper_set_suspend(&priv->fbdev->fbdev_helper, 0);
 	console_unlock();
 }
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index ea39329..c054fc2 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -50,6 +50,11 @@ struct rockchip_crtc_state {
 #define to_rockchip_crtc_state(s) \
 		container_of(s, struct rockchip_crtc_state, base)
 
+struct rockchip_drm_fbdev {
+	struct drm_fb_helper fbdev_helper;
+	struct drm_gem_object *fbdev_bo;
+};
+
 /*
  * Rockchip drm private structure.
  *
@@ -57,8 +62,7 @@ struct rockchip_crtc_state {
  * @num_pipe: number of pipes for this device.
  */
 struct rockchip_drm_private {
-	struct drm_fb_helper fbdev_helper;
-	struct drm_gem_object *fbdev_bo;
+	struct rockchip_drm_fbdev *fbdev;
 	const struct rockchip_crtc_funcs *crtc_funcs[ROCKCHIP_MAX_CRTC];
 	struct drm_atomic_state *state;
 };
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 55c5273..fef6f8d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -156,10 +156,10 @@ err_gem_object_unreference:
 static void rockchip_drm_output_poll_changed(struct drm_device *dev)
 {
 	struct rockchip_drm_private *private = dev->dev_private;
-	struct drm_fb_helper *fb_helper = &private->fbdev_helper;
+	struct rockchip_drm_fbdev *fbdev = private->fbdev;
 
-	if (fb_helper)
-		drm_fb_helper_hotplug_event(fb_helper);
+	if (fbdev)
+		drm_fb_helper_hotplug_event(&fbdev->fbdev_helper);
 }
 
 static void rockchip_crtc_wait_for_update(struct drm_crtc *crtc)
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
index 207e01d..cc5781a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
@@ -22,16 +22,16 @@
 #include "rockchip_drm_fb.h"
 
 #define PREFERRED_BPP		32
-#define to_drm_private(x) \
-		container_of(x, struct rockchip_drm_private, fbdev_helper)
+#define to_rockchip_fbdev(x) \
+		container_of(x, struct rockchip_drm_fbdev, fbdev_helper)
 
 static int rockchip_fbdev_mmap(struct fb_info *info,
 			       struct vm_area_struct *vma)
 {
 	struct drm_fb_helper *helper = info->par;
-	struct rockchip_drm_private *private = to_drm_private(helper);
+	struct rockchip_drm_fbdev *fbdev = to_rockchip_fbdev(helper);
 
-	return rockchip_gem_mmap_buf(private->fbdev_bo, vma);
+	return rockchip_gem_mmap_buf(fbdev->fbdev_bo, vma);
 }
 
 static struct fb_ops rockchip_drm_fbdev_ops = {
@@ -50,7 +50,7 @@ static struct fb_ops rockchip_drm_fbdev_ops = {
 static int rockchip_drm_fbdev_create(struct drm_fb_helper *helper,
 				     struct drm_fb_helper_surface_size *sizes)
 {
-	struct rockchip_drm_private *private = to_drm_private(helper);
+	struct rockchip_drm_fbdev *fbdev = to_rockchip_fbdev(helper);
 	struct drm_mode_fb_cmd2 mode_cmd = { 0 };
 	struct drm_device *dev = helper->dev;
 	struct rockchip_gem_object *rk_obj;
@@ -75,7 +75,7 @@ static int rockchip_drm_fbdev_create(struct drm_fb_helper *helper,
 	if (IS_ERR(rk_obj))
 		return -ENOMEM;
 
-	private->fbdev_bo = &rk_obj->base;
+	fbdev->fbdev_bo = &rk_obj->base;
 
 	fbi = drm_fb_helper_alloc_fbi(helper);
 	if (IS_ERR(fbi)) {
@@ -85,7 +85,7 @@ static int rockchip_drm_fbdev_create(struct drm_fb_helper *helper,
 	}
 
 	helper->fb = rockchip_drm_framebuffer_init(dev, &mode_cmd,
-						   private->fbdev_bo);
+						   fbdev->fbdev_bo);
 	if (IS_ERR(helper->fb)) {
 		dev_err(dev->dev, "Failed to allocate DRM framebuffer.\n");
 		ret = PTR_ERR(helper->fb);
@@ -130,6 +130,7 @@ static const struct drm_fb_helper_funcs rockchip_drm_fb_helper_funcs = {
 int rockchip_drm_fbdev_init(struct drm_device *dev)
 {
 	struct rockchip_drm_private *private = dev->dev_private;
+	struct rockchip_drm_fbdev *fbdev;
 	struct drm_fb_helper *helper;
 	unsigned int num_crtc;
 	int ret;
@@ -139,7 +140,12 @@ int rockchip_drm_fbdev_init(struct drm_device *dev)
 
 	num_crtc = dev->mode_config.num_crtc;
 
-	helper = &private->fbdev_helper;
+	fbdev = devm_kzalloc(dev->dev, sizeof(*fbdev), GFP_KERNEL);
+	if (!fbdev)
+		return -ENOMEM;
+
+	private->fbdev = fbdev;
+	helper = &fbdev->fbdev_helper;
 
 	drm_fb_helper_prepare(dev, helper, &rockchip_drm_fb_helper_funcs);
 
@@ -175,7 +181,9 @@ void rockchip_drm_fbdev_fini(struct drm_device *dev)
 	struct rockchip_drm_private *private = dev->dev_private;
 	struct drm_fb_helper *helper;
 
-	helper = &private->fbdev_helper;
+	if (!private || private->fbdev)
+		return;
+	helper = &private->fbdev->fbdev_helper;
 
 	drm_fb_helper_unregister_fbi(helper);
 	drm_fb_helper_release_fbi(helper);
-- 
1.9.1
