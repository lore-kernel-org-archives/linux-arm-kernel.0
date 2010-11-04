From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu,  4 Nov 2010 22:53:21 +0800
Subject: [PATCH] ARM: pxa: fix the building failue on saar
Message-ID: <1288882401-14859-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since CONFIG_FB_PXA_SMARTPANEL is introduced and it's depend on CONFIG_FB_PXA.
We can't compile CONFIG_FB_PXA as module.

arch/arm/mach-pxa/built-in.o: In function `ltm020d550_update':
saar.c:(.text+0xdc8): undefined reference to `pxafb_smart_queue'
saar.c:(.text+0xdd4): undefined reference to `pxafb_smart_flush'
arch/arm/mach-pxa/built-in.o: In function `ltm020d550_lcd_power':
saar.c:(.text+0xdf8): undefined reference to `pxafb_smart_queue'
saar.c:(.text+0xe08): undefined reference to `pxafb_smart_queue'
saar.c:(.text+0xe10): undefined reference to `pxafb_smart_flush'
saar.c:(.text+0xe2c): undefined reference to `pxafb_smart_queue'
arch/arm/mach-pxa/built-in.o: In function `ltm022a97a_update':
saar.c:(.text+0xe68): undefined reference to `pxafb_smart_queue'
saar.c:(.text+0xe74): undefined reference to `pxafb_smart_flush'
arch/arm/mach-pxa/built-in.o: In function `ltm022a97a_lcd_power':
saar.c:(.text+0xeb0): undefined reference to `pxafb_smart_queue'
saar.c:(.text+0xec0): undefined reference to `pxafb_smart_queue'
saar.c:(.text+0xec8): undefined reference to `pxafb_smart_flush'
saar.c:(.text+0xf08): undefined reference to `pxafb_smart_queue'
saar.c:(.text+0xf18): undefined reference to `pxafb_smart_queue'
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [sub-make] Error 2

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/saar.c     |    2 +-
 arch/arm/mach-pxa/tavorevb.c |    2 +-
 drivers/video/Kconfig        |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
index 115b6f2..f8c3a13 100644
--- a/arch/arm/mach-pxa/saar.c
+++ b/arch/arm/mach-pxa/saar.c
@@ -116,7 +116,7 @@ static struct platform_device smc91x_device = {
 	},
 };
 
-#if defined(CONFIG_FB_PXA) || (CONFIG_FB_PXA_MODULE)
+#if defined(CONFIG_FB_PXA)
 static uint16_t lcd_power_on[] = {
 	/* single frame */
 	SMART_CMD_NOOP,
diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorevb.c
index 0f440c9..0b3abac 100644
--- a/arch/arm/mach-pxa/tavorevb.c
+++ b/arch/arm/mach-pxa/tavorevb.c
@@ -163,7 +163,7 @@ static void __init tavorevb_init_keypad(void)
 static inline void tavorevb_init_keypad(void) {}
 #endif /* CONFIG_KEYBOARD_PXA27x || CONFIG_KEYBOARD_PXA27x_MODULE */
 
-#if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
+#if defined(CONFIG_FB_PXA)
 static struct platform_pwm_backlight_data tavorevb_backlight_data[] = {
 	[0] = {
 		/* primary backlight */
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 8b31fdf..003b84e 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1805,7 +1805,7 @@ config FB_PXA168
 	  MMP processor.
 
 config FB_PXA
-	tristate "PXA LCD framebuffer support"
+	bool "PXA LCD framebuffer support"
 	depends on FB && ARCH_PXA
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
-- 
1.5.6.5
