From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 May 2016 14:47:10 +0200
Subject: [PATCH 10/20] drm/sun4i: remove simplefb at probe
In-Reply-To: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1463402840-17062-11-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If simplefb was setup by our bootloader and enabled in the DT, we will have
a first framebuffer loaded in our system.

However, as soon as our DRM driver will load, it will reset the controller,
initialise it and, if the framebuffer emulation is enabled, register a
second framebuffer device.

This is obviously pretty bad, since the first framebuffer will be some kind
of a black hole, with memory still reserved that we can write to safely,
but not displayed anywhere.

Make sure we remove that framebuffer when we probe so we don't end up in
that situation.

Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 76e922bb60e5..af62b24c39b1 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -125,6 +125,22 @@ static struct drm_driver sun4i_drv_driver = {
 	.disable_vblank		= sun4i_drv_disable_vblank,
 };
 
+static void sun4i_remove_framebuffers(void)
+{
+	struct apertures_struct *ap;
+
+	ap = alloc_apertures(1);
+	if (!ap)
+		return;
+
+	/* The framebuffer can be located anywhere in RAM */
+	ap->ranges[0].base = 0;
+	ap->ranges[0].size = ~0;
+
+	remove_conflicting_framebuffers(ap, "sun4i-drm-fb", false);
+	kfree(ap);
+}
+
 static int sun4i_drv_bind(struct device *dev)
 {
 	struct drm_device *drm;
@@ -172,6 +188,9 @@ static int sun4i_drv_bind(struct device *dev)
 	}
 	drm->irq_enabled = true;
 
+	/* Remove early framebuffers (ie. simplefb) */
+	sun4i_remove_framebuffers();
+
 	/* Create our framebuffer */
 	drv->fbdev = sun4i_framebuffer_init(drm);
 	if (IS_ERR(drv->fbdev)) {
-- 
2.8.2
