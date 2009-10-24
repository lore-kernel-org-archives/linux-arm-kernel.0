From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 25 Oct 2009 00:08:28 +0400
Subject: [PATCH 07/20] SA1100: h3100/h3600: separate machine-specific LCD
	helpers
In-Reply-To: <1256414658-22611-7-git-send-email-mad_soft@inbox.ru>
References: <1256414658-22611-7-git-send-email-mad_soft@inbox.ru>
Message-ID: <1256414910-22665-1-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

h3100 and h3600 have different sets of LCD-controlling gpios,
which mapped to the same "abstracted" EGPIO.
As we plan to get rid of those abstracted egpios completely, we
need to separate these helper functions.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-sa1100/h3600.c |   29 ++++++++++++++++++++---------
 1 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index 021cecb..1297c11 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -191,14 +191,6 @@ static void __init h3xxx_mach_init(void)
 	sa11x0_register_mtd(&h3xxx_flash_data, &h3xxx_flash_resource, 1);
 }
 
-/*
- * helper for sa1100fb
- */
-static void h3xxx_lcd_power(int enable)
-{
-	assign_h3600_egpio(IPAQ_EGPIO_LCD_POWER, enable);
-}
-
 static struct map_desc h3600_io_desc[] __initdata = {
   	{	/* static memory bank 2  CS#2 */
 		.virtual	=  H3600_BANK_2_VIRT,
@@ -240,7 +232,6 @@ static void __init h3xxx_map_io(void)
 	PCFR = PCFR_OPDE;
 	PSDR = 0;
 
-	sa1100fb_lcd_power = h3xxx_lcd_power;
 }
 
 /************************* H3100 *************************/
@@ -321,11 +312,21 @@ static void h3100_control_egpio(enum ipaq_egpio_type x, int setp)
 			  | GPIO_H3100_AUD_PWR_ON \
 			  | GPIO_H3100_IR_ON	  \
 			  | GPIO_H3100_IR_FSEL)
+/*
+ * helper for sa1100fb
+ */
+static void h3100_lcd_power(int enable)
+{
+	assign_h3600_egpio(IPAQ_EGPIO_LCD_POWER, enable);
+}
+
 
 static void __init h3100_map_io(void)
 {
 	h3xxx_map_io();
 
+	sa1100fb_lcd_power = h3100_lcd_power;
+
 	/* Initialize h3100-specific values here */
 	GPCR = 0x0fffffff;	 /* All outputs are set low by default */
 	GPDR = GPIO_H3600_L3_CLOCK |
@@ -455,10 +456,20 @@ static void h3600_control_egpio(enum ipaq_egpio_type x, int setp)
 	}
 }
 
+/*
+ * helper for sa1100fb
+ */
+static void h3600_lcd_power(int enable)
+{
+	assign_h3600_egpio(IPAQ_EGPIO_LCD_POWER, enable);
+}
+
 static void __init h3600_map_io(void)
 {
 	h3xxx_map_io();
 
+	sa1100fb_lcd_power = h3600_lcd_power;
+
 	/* Initialize h3600-specific values here */
 
 	GPCR = 0x0fffffff;	 /* All outputs are set low by default */
-- 
1.6.5.1.63.ga9d7.dirty
