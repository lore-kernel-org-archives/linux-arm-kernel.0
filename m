From: giometti@linux.it (Rodolfo Giometti)
Date: Thu,  1 Apr 2010 13:38:11 +0200
Subject: [PATCH 02/19] arm pxafb: add Pixel Clock Divisor (LCCR4_PCDDIV) bit
	support.
Message-ID: <1270121891-3193-1-git-send-email-giometti@linux.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rodolfo Giometti <giometti@linux.it>
Acked-by: Raffaele Recalcati <raffaele.recalcati@bticino.it>
Acked-by: Enrico Valtolina <enrico.valtolina@bticino.it>
---
 arch/arm/mach-pxa/include/mach/pxafb.h    |    1 +
 arch/arm/mach-pxa/include/mach/regs-lcd.h |    1 +
 drivers/video/pxafb.c                     |    4 +++-
 3 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/pxafb.h b/arch/arm/mach-pxa/include/mach/pxafb.h
index 160ec83..b2530c5 100644
--- a/arch/arm/mach-pxa/include/mach/pxafb.h
+++ b/arch/arm/mach-pxa/include/mach/pxafb.h
@@ -61,6 +61,7 @@
 #define LCD_PCLK_EDGE_RISE	(0 << 19)
 #define LCD_PCLK_EDGE_FALL	(1 << 19)
 #define LCD_ALTERNATE_MAPPING	(1 << 20)
+#define LCD_PCDDIV_1		(1 << 21)
 
 /*
  * This structure describes the machine which we are running on.
diff --git a/arch/arm/mach-pxa/include/mach/regs-lcd.h b/arch/arm/mach-pxa/include/mach/regs-lcd.h
index f82dcea..65b711a 100644
--- a/arch/arm/mach-pxa/include/mach/regs-lcd.h
+++ b/arch/arm/mach-pxa/include/mach/regs-lcd.h
@@ -46,6 +46,7 @@
 #define LCCR4_PAL_FOR_2	(2 << 15)
 #define LCCR4_PAL_FOR_3	(3 << 15)
 #define LCCR4_PAL_FOR_MASK	(3 << 15)
+#define LCCR4_PCDDIV	(1 << 31)
 
 #define FDADR0		(0x200)	/* DMA Channel 0 Frame Descriptor Address Register */
 #define FDADR1		(0x210)	/* DMA Channel 1 Frame Descriptor Address Register */
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 825b665..8cba420 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -1355,7 +1355,7 @@ static int pxafb_activate_var(struct fb_var_screeninfo *var,
 	fbi->reg_lccr3 |= pxafb_var_to_lccr3(var);
 
 	fbi->reg_lccr4 = lcd_readl(fbi, LCCR4) & ~LCCR4_PAL_FOR_MASK;
-	fbi->reg_lccr4 |= (fbi->lccr4 & LCCR4_PAL_FOR_MASK);
+	fbi->reg_lccr4 |= (fbi->lccr4 & (LCCR4_PAL_FOR_MASK | LCCR4_PCDDIV));
 	local_irq_restore(flags);
 
 	/*
@@ -1738,6 +1738,8 @@ static void pxafb_decode_mach_info(struct pxafb_info *fbi,
 	fbi->lccr3 |= (lcd_conn & LCD_BIAS_ACTIVE_LOW) ? LCCR3_OEP : 0;
 	fbi->lccr3 |= (lcd_conn & LCD_PCLK_EDGE_FALL)  ? LCCR3_PCP : 0;
 
+	fbi->lccr4 |= (lcd_conn & LCD_PCDDIV_1) ? LCCR4_PCDDIV : 0;
+
 decode_mode:
 	pxafb_setmode(&fbi->fb.var, &inf->modes[0]);
 
-- 
1.6.3.3
