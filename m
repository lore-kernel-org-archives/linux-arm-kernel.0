From: lost.distance@yahoo.com (Paul Parsons)
Date: Mon, 19 Mar 2012 13:11:21 +0000 (GMT)
Subject: [PATCH] pxa/hx4700: fix the LCD initialization
In-Reply-To: <CA+gwMcd14LVxF=pxyewQRDFUfTFxhmnTzHmxSF=_s2kJyxn5EQ@mail.gmail.com>
Message-ID: <1332162681.93014.YahooMailClassic@web29014.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Philipp,

--- On Mon, 19/3/12, Philipp Zabel <philipp.zabel@gmail.com> wrote:
> Hi Paul,
> 
> On Sat, Mar 17, 2012 at 3:48 PM, Paul Parsons <lost.distance@yahoo.com>
> wrote:
> > After some experimenting it seems that neither GPIO110
> "LCD_LVDD_3V3_ON"
> > nor GPIO112 "LCD_N2V7_7V3_ON" have any effect on the
> hx4700 LCD.
> > After the hx4700 boots I can turn either one off, or
> both off together,
> > and the LCD and touchscreen will continue to work
> normally.
> >
> > Is there an authoritative description of the 7 "LCD"
> GPIOs (GPIO59,
> > GPIO62, GPIO70, GPIO84, GPIO110, GPIO111, GPIO112) that
> are used by
> > the kernel, or the 2 "LCD" GPIOs (GPIO22, GPIO73) that
> are not used?
> > The SDG code provides no enlightenment.
> 
> that is a good question. Not having done any of the reverse
> engineering for hx4700 myself, I've always taken the SDG
> code as
> gospel.
> Unfortunately I am not aware of any hx4700 hardware
> schematics or even
> a datasheet for the acx523akm lcd panel.

I too searched for an LCD datasheet without success.

Consider this patch for LCD initialization which I have been trying for
the past couple of days:

1. Remove all references to GPIO110 and GPIO112.
2. Replace the first half of sony_lcd_init() with a one-time call to
sony_lcd_off() in hx4700_init().

It saves 21 lines and establishes symmetry in the init()/off() calls.

--- clean-3.3-rc7/arch/arm/mach-pxa/hx4700.c	2012-03-10 21:49:52.000000000 +0000
+++ linux-3.3-rc7/arch/arm/mach-pxa/hx4700.c	2012-03-19 12:54:44.420420630 +0000
@@ -331,42 +331,20 @@ static struct platform_device egpio = {
 
 static void sony_lcd_init(void)
 {
-	gpio_set_value(GPIO84_HX4700_LCD_SQN, 1);
-	gpio_set_value(GPIO110_HX4700_LCD_LVDD_3V3_ON, 0);
-	gpio_set_value(GPIO111_HX4700_LCD_AVDD_3V3_ON, 0);
-	gpio_set_value(GPIO70_HX4700_LCD_SLIN1, 0);
-	gpio_set_value(GPIO62_HX4700_LCD_nRESET, 0);
-	mdelay(10);
-	gpio_set_value(GPIO59_HX4700_LCD_PC1, 0);
-	gpio_set_value(GPIO110_HX4700_LCD_LVDD_3V3_ON, 0);
-	mdelay(20);
-
-	gpio_set_value(GPIO110_HX4700_LCD_LVDD_3V3_ON, 1);
-	mdelay(5);
 	gpio_set_value(GPIO111_HX4700_LCD_AVDD_3V3_ON, 1);
-
-	/* FIXME: init w3220 registers here */
-
-	mdelay(5);
+	gpio_set_value(GPIO84_HX4700_LCD_SQN, 1);
 	gpio_set_value(GPIO70_HX4700_LCD_SLIN1, 1);
-	mdelay(10);
-	gpio_set_value(GPIO62_HX4700_LCD_nRESET, 1);
-	mdelay(10);
 	gpio_set_value(GPIO59_HX4700_LCD_PC1, 1);
-	mdelay(10);
-	gpio_set_value(GPIO112_HX4700_LCD_N2V7_7V3_ON, 1);
+	gpio_set_value(GPIO62_HX4700_LCD_nRESET, 1);
 }
 
 static void sony_lcd_off(void)
 {
-	gpio_set_value(GPIO59_HX4700_LCD_PC1, 0);
 	gpio_set_value(GPIO62_HX4700_LCD_nRESET, 0);
-	mdelay(10);
-	gpio_set_value(GPIO112_HX4700_LCD_N2V7_7V3_ON, 0);
-	mdelay(10);
+	gpio_set_value(GPIO59_HX4700_LCD_PC1, 0);
+	gpio_set_value(GPIO70_HX4700_LCD_SLIN1, 0);
+	gpio_set_value(GPIO84_HX4700_LCD_SQN, 0);
 	gpio_set_value(GPIO111_HX4700_LCD_AVDD_3V3_ON, 0);
-	mdelay(10);
-	gpio_set_value(GPIO110_HX4700_LCD_LVDD_3V3_ON, 0);
 }
 
 #ifdef CONFIG_PM
@@ -825,7 +803,6 @@ static struct gpio global_gpios[] = {
 	{ GPIO62_HX4700_LCD_nRESET,       GPIOF_OUT_INIT_HIGH, "LCD_RESET" },
 	{ GPIO70_HX4700_LCD_SLIN1,        GPIOF_OUT_INIT_HIGH, "LCD_SLIN1" },
 	{ GPIO84_HX4700_LCD_SQN,          GPIOF_OUT_INIT_HIGH, "LCD_SQN" },
-	{ GPIO110_HX4700_LCD_LVDD_3V3_ON, GPIOF_OUT_INIT_HIGH, "LCD_LVDD" },
 	{ GPIO111_HX4700_LCD_AVDD_3V3_ON, GPIOF_OUT_INIT_HIGH, "LCD_AVDD" },
 	{ GPIO32_HX4700_RS232_ON,         GPIOF_OUT_INIT_HIGH, "RS232_ON" },
 	{ GPIO71_HX4700_ASIC3_nRESET,     GPIOF_OUT_INIT_HIGH, "ASIC3_nRESET" },
@@ -846,6 +823,8 @@ static void __init hx4700_init(void)
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
+	sony_lcd_off();
+
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	pxa_set_ficp_info(&ficp_info);
