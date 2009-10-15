From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Thu, 15 Oct 2009 19:33:24 +0200
Subject: [PATCH 4/4] [MXC] Armadillo500 Add support for Seiko Instruments
	S-35390A rtc over i2c.
In-Reply-To: <20091015193107.2207de95@Marramao-laptop>
References: <20091015191325.74ba24fb@Marramao-laptop>
	<20091015192451.50ee35c5@Marramao-laptop>
	<20091015192905.2fa228f9@Marramao-laptop>
	<20091015193107.2207de95@Marramao-laptop>
Message-ID: <20091015193324.13059fff@Marramao-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[PATCH] Armadillo500 Add support for Seiko Instruments S-35390A rtc over i2c.

The RTC chip Seiko Instruments S-35390A is connected to the Application
Processor over the second bus i2c with the hard coded address 0x30.

Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---
 arch/arm/mach-mx3/armadillo5x0.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/armadillo5x0.c b/arch/arm/mach-mx3/armadillo5x0.c
index fa973e4..d10ee27 100644
--- a/arch/arm/mach-mx3/armadillo5x0.c
+++ b/arch/arm/mach-mx3/armadillo5x0.c
@@ -35,6 +35,7 @@
 #include <linux/io.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
+#include <linux/i2c.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -104,6 +105,13 @@ static int armadillo5x0_pins[] = {
 	MX31_PIN_CSPI2_MISO__SDA,
 };
 
+/* RTC over I2C*/
+#define ARMADILLO5X0_RTC_GPIO	IOMUX_TO_GPIO(MX31_PIN_SRXD4)
+
+static struct i2c_board_info armadillo5x0_i2c_rtc = {
+	I2C_BOARD_INFO("s35390a", 0x30),
+};
+
 /* GPIO BUTTONS */
 static struct gpio_keys_button armadillo5x0_buttons[] = {
 	{
@@ -373,6 +381,18 @@ static void __init armadillo5x0_init(void)
 
 	/* set NAND page size to 2k if not configured via boot mode pins */
 	__raw_writel(__raw_readl(MXC_CCM_RCSR) | (1 << 30), MXC_CCM_RCSR);
+
+	/* RTC */
+	/* Get RTC IRQ and register the chip */
+	if (gpio_request(ARMADILLO5X0_RTC_GPIO, "rtc") == 0) {
+		if (gpio_direction_input(ARMADILLO5X0_RTC_GPIO) == 0)
+			armadillo5x0_i2c_rtc.irq = gpio_to_irq(ARMADILLO5X0_RTC_GPIO);
+		else
+			gpio_free(ARMADILLO5X0_RTC_GPIO);
+	}
+	if (armadillo5x0_i2c_rtc.irq == 0)
+		pr_warning("armadillo5x0_init: failed to get RTC IRQ\n");
+	i2c_register_board_info(1, &armadillo5x0_i2c_rtc, 1);
 }
 
 static void __init armadillo5x0_timer_init(void)
-- 
1.5.4.3
