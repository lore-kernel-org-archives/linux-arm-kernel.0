From: kristoffer.ericson@gmail.com (Kristoffer Ericson)
Date: Wed, 22 Sep 2010 18:52:37 +0200
Subject: Unable to get CF working on HP Jornada 700 flashrom
Message-ID: <20100922165237.GE874@boggieman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

Ive looked at this for a couple of days now and havent reached any solution.
So any feedback whatsoever is greatly appreciated.

It boots up (from u-boot) but is unable to find the compact flash card and therefore
panics. I have however earlier (cant seem to reproduce it now) had a situation when the CF worked at the expense of the MCU, havent managed to get both working at same time.





Best wishes
Kristoffer Ericson

-------------- next part --------------
diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
index d3ec620..c3dd677 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -35,12 +35,13 @@
 
 #include "generic.h"
 
+#define SBI_SKCR	__REG(SA1111_VBASE)
+
 /*
  * HP Documentation referred in this file:
  * http://www.jlime.com/downloads/development/docs/jornada7xx/jornada720.txt
  */
 
-/* line 110 of HP's doc */
 #define TUCR_VAL	0x20000400
 
 /* memory space (line 52 of HP's doc) */
@@ -241,32 +242,104 @@ static struct platform_device jornada_ts_device = {
 	.id		= -1,
 };
 
+static struct platform_device jornada_bl_device = {
+	.name		= "jornada_bl",
+	.id		= -1,
+};
+
+static struct platform_device jornada_lcd_device = {
+	.name		= "jornada_lcd",
+	.id		= -1,
+};
+
+
 static struct platform_device *devices[] __initdata = {
 	&sa1111_device,
 	&jornada_ssp_device,
 	&s1d13xxxfb_device,
 	&jornada_kbd_device,
 	&jornada_ts_device,
+	&jornada_bl_device,
+	&jornada_lcd_device,
 };
 
 static int __init jornada720_init(void)
 {
 	int ret = -ENODEV;
+	int i;
 
-	if (machine_is_jornada720()) {
-		/* we want to use gpio20 as input to drive the clock of our uart 3 */
-		GPDR |= GPIO_GPIO20;	/* Clear gpio20 pin as input */
-		TUCR = TUCR_VAL;
-		GPSR = GPIO_GPIO20;	/* start gpio20 pin */
-		udelay(1);
-		GPCR = GPIO_GPIO20;	/* stop gpio20 */
-		udelay(1);
-		GPSR = GPIO_GPIO20;	/* restart gpio20 */
-		udelay(20);		/* give it some time to restart */
-
-		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
-	}
+	printk(KERN_INFO "HP Jornada 710/720/728 Machine Init\n");
+
+/*
+ * PIN Settings from wince
+ *
+ * (GPDR) PINs configured as outputs (all others are inputs)
+ * GPIO8, GPIO11, GPIO17, GPIO19, GPIO20, GPIO21, GPIO24, GPIO25, GPIO27
+ *
+ * (GPSR) PINs configures as outputs with level high
+ * GPIO11, GPIO20, GPIO25
+ *
+ * (GPCR) PINs configured as pin level low
+ * GPIO08, GPIO17, GPIO19, GPIO21, GPIO24, GPIO27
+ *
+ * (GRER) PINs configured to detect rising edge GPIOs
+ * GPIO01, GPIO15, GPIO18
+ *
+ * (GFER) PINs configured to detect falling edge GPIOs
+ * GPIO15, GPIO18
+ *
+ * (GAFR) PINs configure to use alternate function
+ * GPIO21, GPIO22, GPIO27
+ *
+ * (PPDR) PIN directions (default after reset is input)
+ *  LDD(0,1,2,3) = General Purpose Output
+ *
+ * (PPSR) Pin Directions
+ *  LDD(4,5,6)
+ *  L_BIAS
+ */
+
+	sa1110_mb_disable();
+
+	/* we want to use gpio20 as input to drive the clock of our uart 3 */
+	GPDR |= GPIO_GPIO20;	/* make sure its set as ouput */
+	TUCR = TUCR_VAL; // reserve GPIO21/22 for use as MBGNT/MBREQ
+	GPSR = GPIO_GPIO20;	/* start gpio20 pin */
+	udelay(50);
+	GPCR = GPIO_GPIO20;	/* clear pin level gpio20 */
+	udelay(50);
+	GPSR = GPIO_GPIO20;	/* restart gpio20 */
+	udelay(50);		/* give it some time to restart */
+
+	SBI_SKCR = (SKCR_OE_EN | SKCR_PLL_BYPASS | SKCR_RDYEN);
+	mdelay(200);
+
+	SBI_SKCR = (SKCR_OE_EN | SKCR_PLL_BYPASS | SKCR_RDYEN | SKCR_RCLKEN);
+	PPDR = 0x000049FF;
+
+	/* Reset the MCU */
+	PPSR &= (PPC_L_FCLK | 0x80 | PPC_LDD(1) | PPC_LDD(0));
+	udelay(1000);
+
+	PPDR |= (PPC_L_FCLK | 0x80 | PPC_LDD(1) | PPC_LDD(0));
+	udelay(1000);
+
+	PPSR |= PPC_L_FCLK;
+	udelay(1000);
+
+	GPSR = GPIO_GPIO25;
+	GPDR |= GPIO_GPIO25;
+
+	Ser4SSCR0 = 0x0307;	// set 8-bit data, setting transmission rate
+	Ser4MCCR0 = 0x0;	// disable MCP and leave everything to the SSP
+	Ser4SSSR = 0x0;	// remove overruns (rest is read-only)
+	Ser4SSCR1 = 0x18;	// Inactive SCLK = high, starting position
+	Ser4SSCR0 = 0x0387;
+
+	while(Ser4SSSR & SSSR_RNE)
+		i = Ser4SSDR;
 
+	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 	return ret;
 }
 
@@ -353,7 +426,7 @@ static struct flash_platform_data jornada720_flash_data = {
 
 static struct resource jornada720_flash_resource = {
 	.start		= SA1100_CS0_PHYS,
-	.end		= SA1100_CS0_PHYS + SZ_32M - 1,
+	.end		= SA1100_CS0_PHYS + SZ_64M - 1,
 	.flags		= IORESOURCE_MEM,
 };
 
