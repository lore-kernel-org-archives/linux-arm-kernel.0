From: x0132446@ti.com (David Anders)
Date: Wed,  6 Oct 2010 16:20:20 -0500
Subject: [PATCH 4/4] omap4: pandaboard: enable the ehci port on pandaboard
In-Reply-To: <1286400020-1010-1-git-send-email-x0132446@ti.com>
References: <1286400020-1010-1-git-send-email-x0132446@ti.com>
Message-ID: <1286400020-1010-5-git-send-email-x0132446@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP4 PandaBoard has EHCI port1 hooked up to an external
SMSC3320 transciever. GPIO 1 is used to power on the transceiver
and GPIO 62 for reset on the transceiver.

Signed-off-by: David Anders <x0132446@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |   54 ++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 94e819c..6163a59 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -39,6 +39,8 @@
 #include <plat/mmc.h>
 #include "hsmmc.h"
 
+#define GPIO_HUB_POWER		1
+#define GPIO_HUB_NRESET		62
 
 static void __init omap4_panda_init_irq(void)
 {
@@ -280,6 +282,57 @@ static int __init omap4_panda_i2c_init(void)
 	omap_register_i2c_bus(4, 400, NULL, 0);
 	return 0;
 }
+
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.phy_reset  = false,
+	.reset_gpio_port[0]  = -EINVAL,
+	.reset_gpio_port[1]  = -EINVAL,
+	.reset_gpio_port[2]  = -EINVAL
+};
+
+static void __init omap4_ehci_init(void)
+{
+	int ret;
+
+
+	/* disable the power to the usb hub prior to init */
+	ret = gpio_request(GPIO_HUB_POWER, "hub_power");
+	if (ret) {
+		pr_err("Cannot request GPIO %d\n", GPIO_HUB_POWER);
+		goto error1;
+	}
+	gpio_export(GPIO_HUB_POWER, 0);
+	gpio_direction_output(GPIO_HUB_POWER, 0);
+	gpio_set_value(GPIO_HUB_POWER, 0);
+
+	/* reset phy+hub */
+	ret = gpio_request(GPIO_HUB_NRESET, "hub_nreset");
+	if (ret) {
+		pr_err("Cannot request GPIO %d\n", GPIO_HUB_NRESET);
+		goto error2;
+	}
+	gpio_export(GPIO_HUB_NRESET, 0);
+	gpio_direction_output(GPIO_HUB_NRESET, 0);
+	gpio_set_value(GPIO_HUB_NRESET, 0);
+	gpio_set_value(GPIO_HUB_NRESET, 1);
+
+	usb_ehci_init(&ehci_pdata);
+
+	/* enable power to hub */
+	gpio_set_value(GPIO_HUB_POWER, 1);
+	return;
+
+error2:
+	gpio_free(GPIO_HUB_POWER);
+error1:
+	pr_err("Unable to initialize EHCI power/reset\n");
+	return;
+
+}
+
 static void __init omap4_panda_init(void)
 {
 	omap4_panda_i2c_init();
@@ -287,6 +340,7 @@ static void __init omap4_panda_init(void)
 	omap4_twl6030_hsmmc_init(mmc);
 	/* OMAP4 Panda uses internal transceiver so register nop transceiver */
 	usb_nop_xceiv_register();
+	omap4_ehci_init();
 	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */
 	if (!cpu_is_omap44xx())
 		usb_musb_init(&musb_board_data);
-- 
1.7.0.4
