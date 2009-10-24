From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 25 Oct 2009 00:16:14 +0400
Subject: [PATCH 12/20] SA1100: h3100/h3600: configure all unused gpios as
	inputs
In-Reply-To: <1256415251-22735-2-git-send-email-mad_soft@inbox.ru>
References: <1256415251-22735-2-git-send-email-mad_soft@inbox.ru>
Message-ID: <1256415376-22778-1-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After conversion to gpiolib there's still some GPIOs left, that get
configured in *_mach_init() as outputs (using direct operations
on GPCR/GPDR registers), but otherwise unused. These GPIOs are mainly
sound related and should be configured by corresponding driver once
it is written.

Drop this initialisation and configure all GPIOs as input.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-sa1100/h3600.c |   26 +++-----------------------
 1 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index 6792dd1..3d52190 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -297,20 +297,14 @@ static void __init h3xxx_map_io(void)
 	PCFR = PCFR_OPDE;
 	PSDR = 0;
 
+	GPCR = 0x0fffffff;	/* All outputs are set low by default */
+	GPDR = 0;		/* Configure all GPIOs as input */
 }
 
 /************************* H3100 *************************/
 
 #ifdef CONFIG_SA1100_H3100
 
-#define H3100_DIRECT_EGPIO (GPIO_H3100_BT_ON	  \
-			  | GPIO_H3100_GPIO3	  \
-			  | GPIO_H3100_QMUTE	  \
-			  | GPIO_H3100_LCD_3V_ON  \
-			  | GPIO_H3100_AUD_ON	  \
-			  | GPIO_H3100_AUD_PWR_ON \
-			  | GPIO_H3100_IR_ON	  \
-			  | GPIO_H3100_IR_FSEL)
 /*
  * helper for sa1100fb
  */
@@ -330,16 +324,9 @@ static void __init h3100_map_io(void)
 
 	sa1100fb_lcd_power = h3100_lcd_power;
 
-	/* Initialize h3100-specific values here */
-	GPCR = 0x0fffffff;	 /* All outputs are set low by default */
-	GPDR = GPIO_H3600_L3_CLOCK |
-	       GPIO_H3600_L3_MODE  | GPIO_H3600_L3_DATA  |
-	       GPIO_H3600_CLK_SET1 | GPIO_H3600_CLK_SET0 |
-	       H3100_DIRECT_EGPIO;
-
 	/* Older bootldrs put GPIO2-9 in alternate mode on the
 	   assumption that they are used for video */
-	GAFR &= ~H3100_DIRECT_EGPIO;
+	GAFR &= ~0x000001fb;
 }
 
 /*
@@ -424,13 +411,6 @@ static void __init h3600_map_io(void)
 	h3xxx_map_io();
 
 	sa1100fb_lcd_power = h3600_lcd_power;
-
-	/* Initialize h3600-specific values here */
-
-	GPCR = 0x0fffffff;	 /* All outputs are set low by default */
-	GPDR = GPIO_H3600_L3_CLOCK |
-	       GPIO_H3600_L3_MODE  | GPIO_H3600_L3_DATA  |
-	       GPIO_H3600_CLK_SET1 | GPIO_H3600_CLK_SET0;
 }
 
 /*
-- 
1.6.5.1.63.ga9d7.dirty
