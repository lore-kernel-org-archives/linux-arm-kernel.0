From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 21 Jun 2011 14:49:37 -0300
Subject: [PATCH 3/3] mxc: iomuxv1: Do not use gpio_request when setting the
	pin as GPIO
In-Reply-To: <1308678577-25277-2-git-send-email-fabio.estevam@freescale.com>
References: <1308678577-25277-1-git-send-email-fabio.estevam@freescale.com>
	<1308678577-25277-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1308678577-25277-3-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When setting the IOMUX of multiple pins via mxc_gpio_setup_multiple_pins, gpio_request 
is called and this prevents subsequent calls of gpio_request done by drivers to succeed.

Remove gpio_request call from mxc_gpio_setup_multiple_pins function.

As gpio_request is removed from mxc_gpio_setup_multiple_pins, there is no need to have 
mxc_gpio_release_multiple_pins anymore, so remove this function.

Tested on a mx27_3ds board and after applying this patch it is possible to define all the
IOMUX setup in a static array

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/plat-mxc/include/mach/iomux-v1.h |    1 -
 arch/arm/plat-mxc/iomux-v1.c              |   32 -----------------------------
 2 files changed, 0 insertions(+), 33 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-v1.h b/arch/arm/plat-mxc/include/mach/iomux-v1.h
index a7fc51e..6fa8a70 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-v1.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-v1.h
@@ -95,7 +95,6 @@
 extern int mxc_gpio_mode(int gpio_mode);
 extern int mxc_gpio_setup_multiple_pins(const int *pin_list, unsigned count,
 		const char *label);
-extern void mxc_gpio_release_multiple_pins(const int *pin_list, int count);
 
 extern int __init imx_iomuxv1_init(void __iomem *base, int numports);
 
diff --git a/arch/arm/plat-mxc/iomux-v1.c b/arch/arm/plat-mxc/iomux-v1.c
index 3238c10..d76f3ac 100644
--- a/arch/arm/plat-mxc/iomux-v1.c
+++ b/arch/arm/plat-mxc/iomux-v1.c
@@ -172,45 +172,13 @@ static int imx_iomuxv1_setup_multiple(const int *list, unsigned count)
 int mxc_gpio_setup_multiple_pins(const int *pin_list, unsigned count,
 		const char *label)
 {
-	size_t i;
 	int ret;
 
-	for (i = 0; i < count; ++i) {
-		unsigned gpio = pin_list[i] & (GPIO_PIN_MASK | GPIO_PORT_MASK);
-
-		ret = gpio_request(gpio, label);
-		if (ret)
-			goto err_gpio_request;
-	}
-
 	ret = imx_iomuxv1_setup_multiple(pin_list, count);
-	if (ret)
-		goto err_setup;
-
-	return 0;
-
-err_setup:
-	BUG_ON(i != count);
-
-err_gpio_request:
-	mxc_gpio_release_multiple_pins(pin_list, i);
-
 	return ret;
 }
 EXPORT_SYMBOL(mxc_gpio_setup_multiple_pins);
 
-void mxc_gpio_release_multiple_pins(const int *pin_list, int count)
-{
-	size_t i;
-
-	for (i = 0; i < count; ++i) {
-		unsigned gpio = pin_list[i] & (GPIO_PIN_MASK | GPIO_PORT_MASK);
-
-		gpio_free(gpio);
-	}
-}
-EXPORT_SYMBOL(mxc_gpio_release_multiple_pins);
-
 int __init imx_iomuxv1_init(void __iomem *base, int numports)
 {
 	imx_iomuxv1_baseaddr = base;
-- 
1.6.0.4
