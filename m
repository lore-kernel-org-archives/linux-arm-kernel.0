From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Wed, 20 Jul 2011 19:02:29 +0530
Subject: [PATCH 1/3] ARM: S5PC100: Cleanup mach/regs-fb.h from mach-s5pc100
In-Reply-To: <1311168751-30336-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1311168751-30336-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1311168751-30336-2-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use plat/regs-fb-v4.h in machine files instead of mach/regs-fb.h.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 arch/arm/mach-s5pc100/include/mach/regs-fb.h |  105 --------------------------
 arch/arm/mach-s5pc100/mach-smdkc100.c        |    2 +-
 arch/arm/mach-s5pc100/setup-fb-24bpp.c       |    1 -
 3 files changed, 1 insertions(+), 107 deletions(-)
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/regs-fb.h

diff --git a/arch/arm/mach-s5pc100/include/mach/regs-fb.h b/arch/arm/mach-s5pc100/include/mach/regs-fb.h
deleted file mode 100644
index 07aa4d6..0000000
--- a/arch/arm/mach-s5pc100/include/mach/regs-fb.h
+++ /dev/null
@@ -1,105 +0,0 @@
-/* arch/arm/mach-s5pc100/include/mach/regs-fb.h
- *
- * Copyright 2009 Samsung Electronics Co.
- *   Pawel Osciak <p.osciak@samsung.com>
- *
- * Framebuffer register definitions for Samsung S5PC100.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_REGS_FB_H
-#define __ASM_ARCH_REGS_FB_H __FILE__
-
-#include <plat/regs-fb-v4.h>
-
-/* VP1 interface timing control */
-#define VP1CON0						(0x118)
-#define VP1_RATECON_EN					(1 << 31)
-#define VP1_CLKRATE_MASK				(0xff)
-
-#define VP1CON1						(0x11c)
-#define VP1_VTREGCON_EN					(1 << 31)
-#define VP1_VBPD_MASK					(0xfff)
-#define VP1_VBPD_SHIFT					(16)
-
-
-#define WPALCON_H					(0x19c)
-#define WPALCON_L					(0x1a0)
-
-/* Palette control for WPAL0 and WPAL1 is the same as in S3C64xx, but
- * different for WPAL2-4
- */
-/* In WPALCON_L (aka WPALCON) */
-#define WPALCON_W1PAL_32BPP_A888			(0x7 << 3)
-#define WPALCON_W0PAL_32BPP_A888			(0x7 << 0)
-
-/* To set W2PAL-W4PAL consist of one bit from WPALCON_L and two from WPALCON_H,
- * e.g. W2PAL[2..0] is made of (WPALCON_H[10..9], WPALCON_L[6]).
- */
-#define WPALCON_L_WxPAL_L_MASK				(0x1)
-#define WPALCON_L_W2PAL_L_SHIFT				(6)
-#define WPALCON_L_W3PAL_L_SHIFT				(7)
-#define WPALCON_L_W4PAL_L_SHIFT				(8)
-
-#define WPALCON_L_WxPAL_H_MASK				(0x3)
-#define WPALCON_H_W2PAL_H_SHIFT				(9)
-#define WPALCON_H_W3PAL_H_SHIFT				(13)
-#define WPALCON_H_W4PAL_H_SHIFT				(17)
-
-/* Per-window alpha value registers */
-/* For window 0 8-bit alpha values are in VIDW0ALPHAx,
- * for windows 1-4 alpha values consist of two parts, the 4 low bits are
- * taken from VIDWxALPHAx and 4 high bits are from VIDOSDxC,
- * e.g. WIN1_ALPHA0_B[7..0] = (VIDOSD1C[3..0], VIDW1ALPHA0[3..0])
- */
-#define VIDWxALPHA0(_win)				(0x200 + (_win * 8))
-#define VIDWxALPHA1(_win)				(0x204 + (_win * 8))
-
-/* Only for window 0 in VIDW0ALPHAx. */
-#define VIDW0ALPHAx_R(_x)				((_x) << 16)
-#define VIDW0ALPHAx_R_MASK				(0xff << 16)
-#define VIDW0ALPHAx_R_SHIFT				(16)
-#define VIDW0ALPHAx_G(_x)				((_x) << 8)
-#define VIDW0ALPHAx_G_MASK				(0xff << 8)
-#define VIDW0ALPHAx_G_SHIFT				(8)
-#define VIDW0ALPHAx_B(_x)				((_x) << 0)
-#define VIDW0ALPHAx_B_MASK				(0xff << 0)
-#define VIDW0ALPHAx_B_SHIFT				(0)
-
-/* Low 4 bits of alpha0-1 for windows 1-4 */
-#define VIDW14ALPHAx_R_L(_x)				((_x) << 16)
-#define VIDW14ALPHAx_R_L_MASK				(0xf << 16)
-#define VIDW14ALPHAx_R_L_SHIFT				(16)
-#define VIDW14ALPHAx_G_L(_x)				((_x) << 8)
-#define VIDW14ALPHAx_G_L_MASK				(0xf << 8)
-#define VIDW14ALPHAx_G_L_SHIFT				(8)
-#define VIDW14ALPHAx_B_L(_x)				((_x) << 0)
-#define VIDW14ALPHAx_B_L_MASK				(0xf << 0)
-#define VIDW14ALPHAx_B_L_SHIFT				(0)
-
-
-/* Per-window blending equation control registers */
-#define BLENDEQx(_win)					(0x244 + ((_win) * 4))
-#define BLENDEQ1					(0x244)
-#define BLENDEQ2					(0x248)
-#define BLENDEQ3					(0x24c)
-#define BLENDEQ4					(0x250)
-
-#define BLENDEQx_Q_FUNC(_x)				((_x) << 18)
-#define BLENDEQx_Q_FUNC_MASK				(0xf << 18)
-#define BLENDEQx_P_FUNC(_x)				((_x) << 12)
-#define BLENDEQx_P_FUNC_MASK				(0xf << 12)
-#define BLENDEQx_B_FUNC(_x)				((_x) << 6)
-#define BLENDEQx_B_FUNC_MASK				(0xf << 6)
-#define BLENDEQx_A_FUNC(_x)				((_x) << 0)
-#define BLENDEQx_A_FUNC_MASK				(0xf << 0)
-
-#define BLENDCON					(0x260)
-#define BLENDCON_8BIT_ALPHA				(1 << 0)
-
-
-#endif /* __ASM_ARCH_REGS_FB_H */
-
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index 0525cb3..38789f7 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -29,7 +29,6 @@
 #include <asm/mach/map.h>
 
 #include <mach/map.h>
-#include <mach/regs-fb.h>
 #include <mach/regs-gpio.h>
 
 #include <video/platform_lcd.h>
@@ -51,6 +50,7 @@
 #include <plat/keypad.h>
 #include <plat/ts.h>
 #include <plat/audio.h>
+#include <plat/regs-fb-v4.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKC100_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
diff --git a/arch/arm/mach-s5pc100/setup-fb-24bpp.c b/arch/arm/mach-s5pc100/setup-fb-24bpp.c
index d31c0f3..8978e4c 100644
--- a/arch/arm/mach-s5pc100/setup-fb-24bpp.c
+++ b/arch/arm/mach-s5pc100/setup-fb-24bpp.c
@@ -15,7 +15,6 @@
 #include <linux/fb.h>
 #include <linux/gpio.h>
 
-#include <mach/regs-fb.h>
 #include <mach/map.h>
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
-- 
1.7.0.4
