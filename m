From: srinath@mistralsolutions.com (srinath at mistralsolutions.com)
Date: Mon, 20 Dec 2010 18:38:43 +0530
Subject: [Patch v5] AM35xx: Craneboard: Add USB EHCI support
In-Reply-To: <[PATCH] AM35xx-Craneboard-Add-USB-EHCI-support>
References: <[PATCH] AM35xx-Craneboard-Add-USB-EHCI-support>
Message-ID: <1292850523-14583-1-git-send-email-srinath@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinath <srinath@mistralsolutions.com>

AM3517/05 Craneboard has one EHCI interface on board using port1.

GPIO35 is used as power enable.
GPIO38 is used as port1 PHY reset.

History:
http://marc.info/?l=linux-omap&w=2&r=1&s=Craneboard%253A%2BAdd%2BUSB%2BEHCI%2Bsupport&q=b

Signed-off-by: Srinath <srinath@mistralsolutions.com>
---
 arch/arm/mach-omap2/board-am3517crane.c |   48 +++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index 8ba4047..e56900f 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -19,6 +19,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/gpio.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -27,8 +28,14 @@
 
 #include <plat/board.h>
 #include <plat/common.h>
+#include <plat/usb.h>
 
 #include "mux.h"
+#include "control.h"
+
+#define GPIO_USB_POWER		35
+#define GPIO_USB_NRESET		38
+
 
 /* Board initialization */
 static struct omap_board_config_kernel am3517_crane_config[] __initdata = {
@@ -51,10 +58,51 @@ static void __init am3517_crane_init_irq(void)
 	omap_init_irq();
 }
 
+static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+
+	.phy_reset  = true,
+	.reset_gpio_port[0]  = GPIO_USB_NRESET,
+	.reset_gpio_port[1]  = -EINVAL,
+	.reset_gpio_port[2]  = -EINVAL
+};
+
 static void __init am3517_crane_init(void)
 {
+	int ret;
+
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_serial_init();
+
+	/* Configure GPIO for EHCI port */
+	if (omap_mux_init_gpio(GPIO_USB_NRESET, OMAP_PIN_OUTPUT)) {
+		pr_err("Can not configure mux for GPIO_USB_NRESET %d\n",
+			GPIO_USB_NRESET);
+		return;
+	}
+
+	if (omap_mux_init_gpio(GPIO_USB_POWER, OMAP_PIN_OUTPUT)) {
+		pr_err("Can not configure mux for GPIO_USB_POWER %d\n",
+			GPIO_USB_POWER);
+		return;
+	}
+
+	ret = gpio_request(GPIO_USB_POWER, "usb_ehci_enable");
+	if (ret < 0) {
+		pr_err("Can not request GPIO %d\n", GPIO_USB_POWER);
+		return;
+	}
+
+	ret = gpio_direction_output(GPIO_USB_POWER, 1);
+	if (ret < 0) {
+		gpio_free(GPIO_USB_POWER);
+		pr_err("Unable to initialize EHCI power\n");
+		return;
+	}
+
+	usb_ehci_init(&ehci_pdata);
 }
 
 MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")
-- 
1.7.1.226.g770c5
