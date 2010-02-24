From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:34 +0100
Subject: [PATCH 39/39] arm/imx/iomux-v1: check for invalid modes in
	mxc_gpio_mode
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-39-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mxc_gpio_mode checks for invalid pins and so it returns zero for
success, -EINVAL for invalid pins.

While at it, remove definitions of GPIO_PORT_MAX removed as they are
unused now.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/Makefile                 |    1 -
 arch/arm/plat-mxc/include/mach/iomux-mx3.h |    5 --
 arch/arm/plat-mxc/include/mach/iomux-v1.h  |   17 ++----
 arch/arm/plat-mxc/iomux-v1.c               |   77 ++++++++++++++++++----------
 4 files changed, 54 insertions(+), 46 deletions(-)

diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index 41d3176..9465a01 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -8,7 +8,6 @@ obj-y := irq.o clock.o gpio.o time.o devices.o cpu.o system.o
 obj-$(CONFIG_ARCH_MX1) += dma-mx1-mx2.o
 obj-$(CONFIG_ARCH_MX2) += dma-mx1-mx2.o
 obj-$(CONFIG_IMX_HAVE_IOMUX_V1) += iomux-v1.o
-CFLAGS_iomux-v1.o = -DIMX_NEEDS_DEPRECATED_SYMBOLS
 obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
 obj-$(CONFIG_MXC_PWM)  += pwm.o
 obj-$(CONFIG_USB_EHCI_MXC) += ehci.o
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx3.h b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
index e5e5861..e51465d 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx3.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
@@ -165,11 +165,6 @@ int mxc_iomux_mode(unsigned int pin_mode);
 	MXC_GPIO_IRQ_START)
 
 /*
- * The number of gpio devices among the pads
- */
-#define GPIO_PORT_MAX 3
-
-/*
  * This enumeration is constructed based on the Section
  * "sw_pad_ctl & sw_mux_ctl details" of the MX31 IC Spec. Each enumerated
  * value is constructed based on the rules described above.
diff --git a/arch/arm/plat-mxc/include/mach/iomux-v1.h b/arch/arm/plat-mxc/include/mach/iomux-v1.h
index 54abfc0..884f575 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-v1.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-v1.h
@@ -41,16 +41,9 @@
 #define MXC_SWR(x)	(0x3c + ((x) << 8))
 #define MXC_PUEN(x)	(0x40 + ((x) << 8))
 
-#ifdef CONFIG_ARCH_MX1
-# define GPIO_PORT_MAX  3
-#endif
-#ifdef CONFIG_ARCH_MX2
-# define GPIO_PORT_MAX  5
-#endif
-
-#ifndef GPIO_PORT_MAX
-# error "GPIO config port count unknown!"
-#endif
+#define MX1_NUM_GPIO_PORT	4
+#define MX21_NUM_GPIO_PORT	6
+#define MX27_NUM_GPIO_PORT	6
 
 #define GPIO_PIN_MASK 0x1f
 
@@ -102,9 +95,9 @@
 #define IRQ_GPIOE(x)  (IRQ_GPIOD(32) + x)
 #define IRQ_GPIOF(x)  (IRQ_GPIOE(32) + x)
 
-extern void mxc_gpio_mode(int gpio_mode);
+extern int mxc_gpio_mode(int gpio_mode);
 extern int mxc_gpio_setup_multiple_pins(const int *pin_list, unsigned count,
-	const char *label);
+		const char *label);
 extern void mxc_gpio_release_multiple_pins(const int *pin_list, int count);
 
 #endif /* __MACH_IOMUX_V1_H__ */
diff --git a/arch/arm/plat-mxc/iomux-v1.c b/arch/arm/plat-mxc/iomux-v1.c
index 5798b35..960a02c 100644
--- a/arch/arm/plat-mxc/iomux-v1.c
+++ b/arch/arm/plat-mxc/iomux-v1.c
@@ -33,6 +33,7 @@
 #include <mach/iomux-v1.h>
 
 static void __iomem *imx_iomuxv1_baseaddr;
+static unsigned imx_iomuxv1_numports;
 
 static inline unsigned long imx_iomuxv1_readl(unsigned offset)
 {
@@ -120,7 +121,7 @@ static inline void imx_iomuxv1_set_iconfb(
 	imx_iomuxv1_rmwl(offset, mask, value);
 }
 
-void mxc_gpio_mode(int gpio_mode)
+int mxc_gpio_mode(int gpio_mode)
 {
 	unsigned int pin = gpio_mode & GPIO_PIN_MASK;
 	unsigned int port = (gpio_mode & GPIO_PORT_MASK) >> GPIO_PORT_SHIFT;
@@ -128,6 +129,9 @@ void mxc_gpio_mode(int gpio_mode)
 	unsigned int aout = (gpio_mode >> GPIO_AOUT_SHIFT) & 3;
 	unsigned int bout = (gpio_mode >> GPIO_BOUT_SHIFT) & 3;
 
+	if (port >= imx_iomuxv1_numports)
+		return -EINVAL;
+
 	/* Pullup enable */
 	imx_iomuxv1_set_puen(port, pin, gpio_mode & GPIO_PUEN);
 
@@ -145,50 +149,64 @@ void mxc_gpio_mode(int gpio_mode)
 	imx_iomuxv1_set_iconfa(port, pin, aout);
 
 	imx_iomuxv1_set_iconfb(port, pin, bout);
+
+	return 0;
 }
 EXPORT_SYMBOL(mxc_gpio_mode);
 
+static int imx_iomuxv1_setup_multiple(const int *list, unsigned count)
+{
+	size_t i;
+	int ret;
+
+	for (i = 0; i < count; ++i) {
+		ret = mxc_gpio_mode(list[i]);
+
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 int mxc_gpio_setup_multiple_pins(const int *pin_list, unsigned count,
 		const char *label)
 {
-	const int *p = pin_list;
-	int i;
-	unsigned gpio;
-	unsigned mode;
-	int ret = -EINVAL;
+	size_t i;
+	int ret;
 
-	for (i = 0; i < count; i++) {
-		gpio = *p & (GPIO_PIN_MASK | GPIO_PORT_MASK);
-		mode = *p & ~(GPIO_PIN_MASK | GPIO_PORT_MASK);
-
-		if (gpio >= (GPIO_PORT_MAX + 1) * 32)
-			goto setup_error;
+	for (i = 0; i < count; ++i) {
+		unsigned gpio = pin_list[i] & (GPIO_PIN_MASK | GPIO_PORT_MASK);
 
 		ret = gpio_request(gpio, label);
 		if (ret)
-			goto setup_error;
+			goto err_gpio_request;
+	}
 
-		mxc_gpio_mode(gpio | mode);
+	ret = imx_iomuxv1_setup_multiple(pin_list, count);
+	if (ret)
+		goto err_setup;
 
-		p++;
-	}
 	return 0;
 
-setup_error:
+err_setup:
+	BUG_ON(i != count);
+
+err_gpio_request:
 	mxc_gpio_release_multiple_pins(pin_list, i);
+
 	return ret;
 }
 EXPORT_SYMBOL(mxc_gpio_setup_multiple_pins);
 
 void mxc_gpio_release_multiple_pins(const int *pin_list, int count)
 {
-	const int *p = pin_list;
-	int i;
+	size_t i;
+
+	for (i = 0; i < count; ++i) {
+		unsigned gpio = pin_list[i] & (GPIO_PIN_MASK | GPIO_PORT_MASK);
 
-	for (i = 0; i < count; i++) {
-		unsigned gpio = *p & (GPIO_PIN_MASK | GPIO_PORT_MASK);
 		gpio_free(gpio);
-		p++;
 	}
 }
 EXPORT_SYMBOL(mxc_gpio_release_multiple_pins);
@@ -196,19 +214,22 @@ EXPORT_SYMBOL(mxc_gpio_release_multiple_pins);
 static int imx_iomuxv1_init(void)
 {
 #ifdef CONFIG_ARCH_MX1
-	if (cpu_is_mx1())
+	if (cpu_is_mx1()) {
 		imx_iomuxv1_baseaddr = MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR);
-	else
+		imx_iomuxv1_numports = MX1_NUM_GPIO_PORT;
+	} else
 #endif
 #ifdef CONFIG_MACH_MX21
-	if (cpu_is_mx21())
+	if (cpu_is_mx21()) {
 		imx_iomuxv1_baseaddr = MX21_IO_ADDRESS(MX21_GPIO_BASE_ADDR);
-	else
+		imx_iomuxv1_numports = MX21_NUM_GPIO_PORT;
+	} else
 #endif
 #ifdef CONFIG_MACH_MX27
-	if (cpu_is_mx27())
+	if (cpu_is_mx27()) {
 		imx_iomuxv1_baseaddr = MX27_IO_ADDRESS(MX27_GPIO_BASE_ADDR);
-	else
+		imx_iomuxv1_numports = MX27_NUM_GPIO_PORT;
+	} else
 #endif
 		return -ENODEV;
 
-- 
1.6.6.2
