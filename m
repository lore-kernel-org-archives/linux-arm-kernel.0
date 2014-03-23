From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 23 Mar 2014 01:34:16 +0100
Subject: [PATCH 1/3] IXP4xx: Fix Goramo Multilink GPIO conversion.
In-Reply-To: <m3siq9iyt2.fsf@intrepid.localdomain> (Krzysztof Halasa's message
 of "Sun, 23 Mar 2014 00:44:09 +0100")
References: <m3siq9iyt2.fsf@intrepid.localdomain>
Message-ID: <m3bnwxiwhj.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-ixp4xx/goramo_mlr.c: In function 'set_scl':
arch/arm/mach-ixp4xx/goramo_mlr.c:82: error: implicit declaration of function 'gpio_line_set'

arch/arm/mach-ixp4xx/goramo_mlr.c: In function 'output_control':
arch/arm/mach-ixp4xx/goramo_mlr.c:111: error: implicit declaration of function 'gpio_line_config'
arch/arm/mach-ixp4xx/goramo_mlr.c:111: error: 'IXP4XX_GPIO_OUT' undeclared

arch/arm/mach-ixp4xx/goramo_mlr.c: In function 'hss_dcd_irq':
arch/arm/mach-ixp4xx/goramo_mlr.c:155: error: implicit declaration of function 'gpio_line_get'

arch/arm/mach-ixp4xx/goramo_mlr.c: In function 'gmlr_init':
arch/arm/mach-ixp4xx/goramo_mlr.c:416: error: 'IXP4XX_GPIO_OUT' undeclared
arch/arm/mach-ixp4xx/goramo_mlr.c:421: error: 'IXP4XX_GPIO_IN' undeclared

Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>

diff --git a/arch/arm/mach-ixp4xx/goramo_mlr.c b/arch/arm/mach-ixp4xx/goramo_mlr.c
index e54ff49..80bd9d6 100644
--- a/arch/arm/mach-ixp4xx/goramo_mlr.c
+++ b/arch/arm/mach-ixp4xx/goramo_mlr.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/hdlc.h>
 #include <linux/i2c-gpio.h>
 #include <linux/io.h>
@@ -79,19 +80,19 @@ static u8 control_value;
 
 static void set_scl(u8 value)
 {
-	gpio_line_set(GPIO_SCL, !!value);
+	gpio_set_value(GPIO_SCL, !!value);
 	udelay(3);
 }
 
 static void set_sda(u8 value)
 {
-	gpio_line_set(GPIO_SDA, !!value);
+	gpio_set_value(GPIO_SDA, !!value);
 	udelay(3);
 }
 
 static void set_str(u8 value)
 {
-	gpio_line_set(GPIO_STR, !!value);
+	gpio_set_value(GPIO_STR, !!value);
 	udelay(3);
 }
 
@@ -108,8 +109,8 @@ static void output_control(void)
 {
 	int i;
 
-	gpio_line_config(GPIO_SCL, IXP4XX_GPIO_OUT);
-	gpio_line_config(GPIO_SDA, IXP4XX_GPIO_OUT);
+	gpio_direction_output(GPIO_SCL, 1);
+	gpio_direction_output(GPIO_SDA, 1);
 
 	for (i = 0; i < 8; i++) {
 		set_scl(0);
@@ -151,8 +152,8 @@ static int hss_set_clock(int port, unsigned int clock_type)
 
 static irqreturn_t hss_dcd_irq(int irq, void *pdev)
 {
-	int i, port = (irq == IXP4XX_GPIO_IRQ(GPIO_HSS1_DCD_N));
-	gpio_line_get(port ? GPIO_HSS1_DCD_N : GPIO_HSS0_DCD_N, &i);
+	int port = (irq == IXP4XX_GPIO_IRQ(GPIO_HSS1_DCD_N));
+	int i = gpio_get_value(port ? GPIO_HSS1_DCD_N : GPIO_HSS0_DCD_N);
 	set_carrier_cb_tab[port](pdev, !i);
 	return IRQ_HANDLED;
 }
@@ -168,7 +169,7 @@ static int hss_open(int port, void *pdev,
 	else
 		irq = IXP4XX_GPIO_IRQ(GPIO_HSS1_DCD_N);
 
-	gpio_line_get(port ? GPIO_HSS1_DCD_N : GPIO_HSS0_DCD_N, &i);
+	i = gpio_get_value(port ? GPIO_HSS1_DCD_N : GPIO_HSS0_DCD_N);
 	set_carrier_cb(pdev, !i);
 
 	set_carrier_cb_tab[!!port] = set_carrier_cb;
@@ -181,7 +182,7 @@ static int hss_open(int port, void *pdev,
 
 	set_control(port ? CONTROL_HSS1_DTR_N : CONTROL_HSS0_DTR_N, 0);
 	output_control();
-	gpio_line_set(port ? GPIO_HSS1_RTS_N : GPIO_HSS0_RTS_N, 0);
+	gpio_set_value(port ? GPIO_HSS1_RTS_N : GPIO_HSS0_RTS_N, 0);
 	return 0;
 }
 
@@ -193,7 +194,7 @@ static void hss_close(int port, void *pdev)
 
 	set_control(port ? CONTROL_HSS1_DTR_N : CONTROL_HSS0_DTR_N, 1);
 	output_control();
-	gpio_line_set(port ? GPIO_HSS1_RTS_N : GPIO_HSS0_RTS_N, 1);
+	gpio_set_value(port ? GPIO_HSS1_RTS_N : GPIO_HSS0_RTS_N, 1);
 }
 
 
@@ -413,13 +414,21 @@ static void __init gmlr_init(void)
 	if (hw_bits & CFG_HW_HAS_EEPROM)
 		device_tab[devices++] = &device_i2c; /* max index 6 */
 
-	gpio_line_config(GPIO_SCL, IXP4XX_GPIO_OUT);
-	gpio_line_config(GPIO_SDA, IXP4XX_GPIO_OUT);
-	gpio_line_config(GPIO_STR, IXP4XX_GPIO_OUT);
-	gpio_line_config(GPIO_HSS0_RTS_N, IXP4XX_GPIO_OUT);
-	gpio_line_config(GPIO_HSS1_RTS_N, IXP4XX_GPIO_OUT);
-	gpio_line_config(GPIO_HSS0_DCD_N, IXP4XX_GPIO_IN);
-	gpio_line_config(GPIO_HSS1_DCD_N, IXP4XX_GPIO_IN);
+	gpio_request(GPIO_SCL, "SCL/clock");
+	gpio_request(GPIO_SDA, "SDA/data");
+	gpio_request(GPIO_STR, "strobe");
+	gpio_request(GPIO_HSS0_RTS_N, "HSS0 RTS");
+	gpio_request(GPIO_HSS1_RTS_N, "HSS1 RTS");
+	gpio_request(GPIO_HSS0_DCD_N, "HSS0 DCD");
+	gpio_request(GPIO_HSS1_DCD_N, "HSS1 DCD");
+
+	gpio_direction_output(GPIO_SCL, 1);
+	gpio_direction_output(GPIO_SDA, 1);
+	gpio_direction_output(GPIO_STR, 0);
+	gpio_direction_output(GPIO_HSS0_RTS_N, 1);
+	gpio_direction_output(GPIO_HSS1_RTS_N, 1);
+	gpio_direction_input(GPIO_HSS0_DCD_N);
+	gpio_direction_input(GPIO_HSS1_DCD_N);
 	irq_set_irq_type(IXP4XX_GPIO_IRQ(GPIO_HSS0_DCD_N), IRQ_TYPE_EDGE_BOTH);
 	irq_set_irq_type(IXP4XX_GPIO_IRQ(GPIO_HSS1_DCD_N), IRQ_TYPE_EDGE_BOTH);
 
