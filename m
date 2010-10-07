From: x0132446@ti.com (David Anders)
Date: Thu,  7 Oct 2010 14:36:30 -0500
Subject: [PATCH 3/3] omap4: pandaboard: enable the ehci port on pandaboard
In-Reply-To: <1286480190-20632-1-git-send-email-x0132446@ti.com>
References: <1286480190-20632-1-git-send-email-x0132446@ti.com>
Message-ID: <1286480190-20632-4-git-send-email-x0132446@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP4 PandaBoard has EHCI port1 hooked up to an external
SMSC3320 transciever. GPIO 1 is used to power on the transceiver
and GPIO 62 for reset on the transceiver.

Signed-off-by: David Anders <x0132446@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |   54 ++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 9327ad4..a9d8a19 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -41,6 +41,9 @@
 #include "hsmmc.h"
 #include "control.h"
 
+#define GPIO_HUB_POWER		1
+#define GPIO_HUB_NRESET		62
+
 static struct gpio_led gpio_leds[] = {
 	{
 		.name			= "pandaboard::status1",
@@ -78,6 +81,56 @@ static void __init omap4_panda_init_irq(void)
 	omap_gpio_init();
 }
 
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
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_UTMI,
 	.mode			= MUSB_PERIPHERAL,
@@ -314,6 +367,7 @@ static void __init omap4_panda_init(void)
 	omap4_twl6030_hsmmc_init(mmc);
 	/* OMAP4 Panda uses internal transceiver so register nop transceiver */
 	usb_nop_xceiv_register();
+	omap4_ehci_init();
 	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */
 	if (!cpu_is_omap44xx())
 		usb_musb_init(&musb_board_data);
-- 
1.7.0.4
