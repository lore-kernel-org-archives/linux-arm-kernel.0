From: roel.kluin@gmail.com (Roel Kluin)
Date: Wed, 03 Feb 2010 20:19:00 +0100
Subject: [PATCH] MX1/MX2: -EINVAL overwritten in second iteration in
	mxc_gpio_setup_multiple_pins()
Message-ID: <4B69CC24.3050503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to the `ret = gpio_request()' below in the loop, the initial -EINVAL value
of ret is overwritten. 

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Not 100% sure this is needed, please review. One more question: is it ok
to return 0 when count is 0 (and nothing is done)?

diff --git a/arch/arm/plat-mxc/iomux-mx1-mx2.c b/arch/arm/plat-mxc/iomux-mx1-mx2.c
index a37163c..25023ac 100644
--- a/arch/arm/plat-mxc/iomux-mx1-mx2.c
+++ b/arch/arm/plat-mxc/iomux-mx1-mx2.c
@@ -116,14 +116,16 @@ int mxc_gpio_setup_multiple_pins(const int *pin_list, unsigned count,
 	int i;
 	unsigned gpio;
 	unsigned mode;
-	int ret = -EINVAL;
+	int ret;
 
 	for (i = 0; i < count; i++) {
 		gpio = *p & (GPIO_PIN_MASK | GPIO_PORT_MASK);
 		mode = *p & ~(GPIO_PIN_MASK | GPIO_PORT_MASK);
 
-		if (gpio >= (GPIO_PORT_MAX + 1) * 32)
+		if (gpio >= (GPIO_PORT_MAX + 1) * 32) {
+			ret = -EINVAL;
 			goto setup_error;
+		}
 
 		ret = gpio_request(gpio, label);
 		if (ret)
