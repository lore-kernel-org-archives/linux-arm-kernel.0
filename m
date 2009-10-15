From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Thu, 15 Oct 2009 19:24:51 +0200
Subject: [PATCH 1/4] [MXC] Armadillo500 Add support for onboard GPIO Buttons.
In-Reply-To: <20091015191325.74ba24fb@Marramao-laptop>
References: <20091015191325.74ba24fb@Marramao-laptop>
Message-ID: <20091015192451.50ee35c5@Marramao-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two low active Buttons on boards.
This patch connect those to the Input Subsystem over gpio-keys driver.

Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---
 arch/arm/mach-mx3/armadillo5x0.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/armadillo5x0.c b/arch/arm/mach-mx3/armadillo5x0.c
index 776c0ee..309fa7a 100644
--- a/arch/arm/mach-mx3/armadillo5x0.c
+++ b/arch/arm/mach-mx3/armadillo5x0.c
@@ -33,6 +33,8 @@
 #include <linux/irq.h>
 #include <linux/mtd/physmap.h>
 #include <linux/io.h>
+#include <linux/input.h>
+#include <linux/gpio_keys.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -98,6 +100,36 @@ static int armadillo5x0_pins[] = {
 	MX31_PIN_DRDY0__DRDY0,
 	IOMUX_MODE(MX31_PIN_LCS1, IOMUX_CONFIG_GPIO), /*ADV7125_PSAVE*/
 };
+/* GPIO BUTTONS */
+static struct gpio_keys_button armadillo5x0_buttons[] = {
+	{
+		.code		= KEY_ENTER, /*28*/
+		.gpio		= IOMUX_TO_GPIO(MX31_PIN_SCLK0),
+		.active_low	= 1,
+		.desc		= "menu",
+		.wakeup		= 1,
+	}, {
+		.code		= KEY_BACK, /*158*/
+		.gpio		= IOMUX_TO_GPIO(MX31_PIN_SRST0),
+		.active_low	= 1,
+		.desc		= "back",
+		.wakeup		= 1,
+	}
+};
+
+static struct gpio_keys_platform_data armadillo5x0_button_data = {
+	.buttons	= armadillo5x0_buttons,
+	.nbuttons	= ARRAY_SIZE(armadillo5x0_buttons),
+};
+
+static struct platform_device armadillo5x0_button_device = {
+	.name		= "gpio-keys",
+	.id		= -1,
+	.num_resources	= 0,
+	.dev		= {
+		.platform_data	= &armadillo5x0_button_data,
+	}
+};
 
 /*
  * NAND Flash
@@ -300,6 +332,7 @@ static struct imxuart_platform_data uart_pdata = {
 
 static struct platform_device *devices[] __initdata = {
 	&armadillo5x0_smc911x_device,
+	&armadillo5x0_button_device,
 };
 
 /*
-- 
1.5.4.3
