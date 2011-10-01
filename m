From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 22:03:43 +0200
Subject: [PATCH 11/26] ARM: pxa: allow building palm27x without pxafb
In-Reply-To: <1317499438-14058-1-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
Message-ID: <1317499438-14058-12-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The frame buffer device is defined conditionally on whether the
driver is configured. However, the #ifdef guard around the
declaration of palm27x_lcd_init also removes the visibility
of the lcd mode declarations, which need to be available in
order to build correctly, even if they are not defined in the
end.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/include/mach/palm27x.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/palm27x.h b/arch/arm/mach-pxa/include/mach/palm27x.h
index 0a5e5ea..030a916 100644
--- a/arch/arm/mach-pxa/include/mach/palm27x.h
+++ b/arch/arm/mach-pxa/include/mach/palm27x.h
@@ -27,10 +27,10 @@ extern void __init palm27x_pm_init(unsigned long str_base);
 static inline void palm27x_pm_init(unsigned long str_base) {}
 #endif
 
-#if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
 extern struct pxafb_mode_info palm_320x480_lcd_mode;
 extern struct pxafb_mode_info palm_320x320_lcd_mode;
 extern struct pxafb_mode_info palm_320x320_new_lcd_mode;
+#if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
 extern void __init palm27x_lcd_init(int power,
 					struct pxafb_mode_info *mode);
 #else
-- 
1.7.5.4
