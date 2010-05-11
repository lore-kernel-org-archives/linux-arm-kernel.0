From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 10 May 2010 20:57:37 -0500
Subject: [PATCH] ep93xx: register backlight driver
Message-ID: <0D753D10438DA54287A00B0270842697636EE74BB1@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the platform registration for the ep93xx backlight driver
that is now queued in the backlight tree.

Since the pwm BRIGHT signal only functions if the video system
is operating, register the backlight when the framebuffer device
is registered.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

This is based off next-20100510, if needed I can rebase it off
another tree.

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 8d3f77e..07d7bb9 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -568,6 +568,11 @@ static struct platform_device ep93xx_fb_device = {
 	.resource		= ep93xx_fb_resource,
 };
 
+static struct platform_device ep93xx_bl_device = {
+	.name		= "ep93xx-bl",
+	.id		= -1,
+};
+
 /**
  * ep93xx_register_fb - Register the framebuffer platform device.
  * @data:	platform specific framebuffer configuration (__initdata)
@@ -576,6 +581,7 @@ void __init ep93xx_register_fb(struct ep93xxfb_mach_info *data)
 {
 	ep93xxfb_data = *data;
 	platform_device_register(&ep93xx_fb_device);
+	platform_device_register(&ep93xx_bl_device);
 }
 
 
