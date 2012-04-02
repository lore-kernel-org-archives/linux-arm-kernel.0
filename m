From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 2 Apr 2012 10:39:47 -0300
Subject: [PATCH 5/5] ARM: armadillo5x0: Fix smsc911x driver probe
In-Reply-To: <1333373987-30459-1-git-send-email-fabio.estevam@freescale.com>
References: <1333373987-30459-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1333373987-30459-5-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix smsc911x driver probe by adding a fixed dummy regulator.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-armadillo5x0.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-armadillo5x0.c b/arch/arm/mach-imx/mach-armadillo5x0.c
index 27bc27e..c650145 100644
--- a/arch/arm/mach-imx/mach-armadillo5x0.c
+++ b/arch/arm/mach-imx/mach-armadillo5x0.c
@@ -38,6 +38,8 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 #include <linux/delay.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -479,6 +481,11 @@ static struct platform_device *devices[] __initdata = {
 	&armadillo5x0_smc911x_device,
 };
 
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
+	REGULATOR_SUPPLY("vddvario", "smsc911x"),
+};
+
 /*
  * Perform board specific initializations
  */
@@ -489,6 +496,8 @@ static void __init armadillo5x0_init(void)
 	mxc_iomux_setup_multiple_pins(armadillo5x0_pins,
 			ARRAY_SIZE(armadillo5x0_pins), "armadillo5x0");
 
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	imx_add_gpio_keys(&armadillo5x0_button_data);
 	imx31_add_imx_i2c1(NULL);
-- 
1.7.1
