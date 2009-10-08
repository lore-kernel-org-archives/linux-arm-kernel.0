From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 8 Oct 2009 19:39:31 -0400
Subject: [PATCH] ep93xx: add keypad core support
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB7CE7@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the core support needed by the ep93xx matrix keypad driver.

The keypad driver unfortunately was merged early and the core
support is missing.  The clkdev support has been resolved and
is now merged.  This adds the platform device to the ep93xx
core and supplies the functions needed to acquire/free the gpio
pins and actually enable/disable the controller peripheral.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

Note: this patch will need to be rebased once a few patches in
the ARM patch tracker are applied.  Please consider this patch
for review.


diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index f7ebed9..0481587 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -31,6 +31,7 @@
 
 #include <mach/hardware.h>
 #include <mach/fb.h>
+#include <mach/ep93xx_keypad.h>
 
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
@@ -714,6 +715,82 @@ void __init ep93xx_register_fb(struct ep93xxfb_mach_info *data)
 	platform_device_register(&ep93xx_fb_device);
 }
 
+
+/*************************************************************************
+ * EP93xx matrix keypad peripheral handling
+ *************************************************************************/
+static struct resource ep93xx_keypad_resource[] = {
+	{
+		.start	= EP93XX_KEY_MATRIX_PHYS_BASE,
+		.end	= EP93XX_KEY_MATRIX_PHYS_BASE + 0x0c - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_EP93XX_KEY,
+		.end	= IRQ_EP93XX_KEY,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device ep93xx_keypad_device = {
+	.name			= "ep93xx-keypad",
+	.id			= -1,
+	.num_resources		= ARRAY_SIZE(ep93xx_keypad_resource),
+	.resource		= ep93xx_keypad_resource,
+};
+
+void __init ep93xx_register_keypad(struct ep93xx_keypad_platform_data *data)
+{
+	ep93xx_keypad_device.dev.platform_data = data;
+	platform_device_register(&ep93xx_keypad_device);
+}
+
+int ep93xx_keypad_acquire_gpio(struct platform_device *pdev)
+{
+	int err;
+	int i;
+
+	for (i = 0; i < 8; i++) {
+		err = gpio_request(EP93XX_GPIO_LINE_C(i), dev_name(&pdev->dev));
+		if (err)
+			goto fail_gpio_c;
+		err = gpio_request(EP93XX_GPIO_LINE_D(i), dev_name(&pdev->dev));
+		if (err)
+			goto fail_gpio_d;
+	}
+
+	/* Enable the keypad controller; ports C and D used for keypad */
+	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_KEYS |
+				EP93XX_SYSCON_DEVCFG_GONK);
+
+	return 0;
+
+fail_gpio_d:
+	gpio_free(EP93XX_GPIO_LINE_C(i));
+fail_gpio_c:
+	for ( ; i >= 0; --i) {
+		gpio_free(EP93XX_GPIO_LINE_C(i));
+		gpio_free(EP93XX_GPIO_LINE_D(i));
+	}
+	return err;
+}
+EXPORT_SYMBOL(ep93xx_keypad_acquire_gpio);
+
+void ep93xx_keypad_release_gpio(struct platform_device *pdev)
+{
+	int i;
+
+	for (i = 0; i < 8; i++) {
+		gpio_free(EP93XX_GPIO_LINE_C(i));
+		gpio_free(EP93XX_GPIO_LINE_D(i));
+	}
+
+	/* Disable the keypad controller; ports C and D used for GPIO */
+	ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_KEYS |
+				EP93XX_SYSCON_DEVCFG_GONK);
+}
+EXPORT_SYMBOL(ep93xx_keypad_release_gpio);
+
+
 extern void ep93xx_gpio_init(void);
 
 void __init ep93xx_init_devices(void)
diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
index 0fbf87b..4526bf0 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
@@ -143,6 +143,7 @@
 #define EP93XX_UART3_PHYS_BASE		(EP93XX_APB_PHYS_BASE + 0x000e0000)
 #define EP93XX_UART3_BASE		EP93XX_APB_IOMEM(0x000e0000)
 
+#define EP93XX_KEY_MATRIX_PHYS_BASE		EP93XX_APB_PHYS(0x000f0000)
 #define EP93XX_KEY_MATRIX_BASE		EP93XX_APB_IOMEM(0x000f0000)
 
 #define EP93XX_ADC_BASE			EP93XX_APB_IOMEM(0x00100000)
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index 01a0f08..442e03b 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -7,6 +7,7 @@
 struct i2c_board_info;
 struct platform_device;
 struct ep93xxfb_mach_info;
+struct ep93xx_keypad_platform_data;
 
 struct ep93xx_eth_data
 {
@@ -38,6 +39,9 @@ void ep93xx_register_fb(struct ep93xxfb_mach_info *data);
 void ep93xx_register_pwm(int pwm0, int pwm1);
 int ep93xx_pwm_acquire_gpio(struct platform_device *pdev);
 void ep93xx_pwm_release_gpio(struct platform_device *pdev);
+void ep93xx_register_keypad(struct ep93xx_keypad_platform_data *data);
+int ep93xx_keypad_acquire_gpio(struct platform_device *pdev);
+void ep93xx_keypad_release_gpio(struct platform_device *pdev);
 
 void ep93xx_init_devices(void);
 extern struct sys_timer ep93xx_timer; 
