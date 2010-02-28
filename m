From: walsimou@walsimou.com (Abdoulaye Walsimou Gaye)
Date: Mon,  1 Mar 2010 00:19:38 +0100
Subject: [PATCH] ARM: s3c2440: mini2440: remove improper __initdata in struct
	s3c2410fb_display
Message-ID: <1267399178-11478-1-git-send-email-walsimou@walsimou.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch remove improper __initdata in struct s3c2410fb_display for for
mini2440 board.
This __initdata prevents for example directfb to work properly
(see below).

Error from directFB before this patch:

   ~~~~~~~~~~~~~~~~~~~~~~~~~~| DirectFB 1.4.3 |~~~~~~~~~~~~~~~~~~~~~~~~~~
        (c) 2001-2009  The world wide DirectFB Open Source Community
        (c) 2000-2004  Convergence (integrated media) GmbH
      ----------------------------------------------------------------

(*) DirectFB/Core: Single Application Core. (2010-02-28 15:16)
(*) Direct/Memcpy: Using armasm_memcpy()
(*) Direct/Thread: Started 'VT Switcher' (-1) [CRITICAL OTHER/OTHER 0/0] <8388608>...
(*) Direct/Thread: Started 'VT Flusher' (-1) [DEFAULT OTHER/OTHER 0/0] <8388608>...
(*) DirectFB/FBDev: Found 's3c2410fb' (ID 0) with frame buffer at 0x33900000, 150k (MMIO 0x00000000, 0k)
(*) DirectFB/Graphics: Generic Software Rasterizer 0.6 (directfb.org)
(!) DirectFB/FBDev: No supported modes found in /etc/fb.modes and current mode not supported!
(!) DirectFB/FBDev: Current mode's pixelformat: rgba 5/11, 6/5, 5/0, 0/0 (16bit)
(!) DirectFB/Core/layers: Failed to initialize layer 0!
    --> Initialization error!
(!) DirectFB/Core: Could not initialize 'layer_core' core!
    --> Initialization error!
(#) DirectFBError [DirectFBCreate() failed]: Initialization error!

Good behaviour after this patch :

   ~~~~~~~~~~~~~~~~~~~~~~~~~~| DirectFB 1.4.3 |~~~~~~~~~~~~~~~~~~~~~~~~~~
        (c) 2001-2009  The world wide DirectFB Open Source Community
        (c) 2000-2004  Convergence (integrated media) GmbH
      ----------------------------------------------------------------

(*) DirectFB/Core: Single Application Core. (2010-02-28 15:16)
(*) Direct/Memcpy: Using armasm_memcpy()
(*) Direct/Thread: Started 'VT Switcher' (-1) [CRITICAL OTHER/OTHER 0/0] <8388608>...
(*) Direct/Thread: Started 'VT Flusher' (-1) [DEFAULT OTHER/OTHER 0/0] <8388608>...
(*) DirectFB/FBDev: Found 's3c2410fb' (ID 0) with frame buffer at 0x33900000, 150k (MMIO 0x00000000, 0k)
(*) DirectFB/Graphics: Generic Software Rasterizer 0.6 (directfb.org)
(*) DirectFB/Core/WM: Default 0.3 (directfb.org)

Screen (00) FBDev Primary Screen            (primary screen)
   Caps: VSYNC POWER_MANAGEMENT

     Layer (00) FBDev Primary Layer             (primary layer)
        Type:    GRAPHICS
        Caps:    SURFACE BRIGHTNESS CONTRAST SATURATION

Signed-off-by: Abdoulaye Walsimou Gaye <walsimou@walsimou.com>
---
 arch/arm/mach-s3c2440/mach-mini2440.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c2440/mach-mini2440.c b/arch/arm/mach-s3c2440/mach-mini2440.c
index 2068e90..1506733 100644
--- a/arch/arm/mach-s3c2440/mach-mini2440.c
+++ b/arch/arm/mach-s3c2440/mach-mini2440.c
@@ -144,7 +144,7 @@ static struct s3c2410_udc_mach_info mini2440_udc_cfg __initdata = {
 	.type		= (S3C2410_LCDCON1_TFT16BPP |\
 			   S3C2410_LCDCON1_TFT)
 
-static struct s3c2410fb_display mini2440_lcd_cfg[] __initdata = {
+static struct s3c2410fb_display mini2440_lcd_cfg[] = {
 	[0] = {	/* mini2440 + 3.5" TFT + touchscreen */
 		_LCD_DECLARE(
 			7,			/* The 3.5 is quite fast */
-- 
1.6.3.3
