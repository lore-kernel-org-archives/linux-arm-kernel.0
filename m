From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 25 Nov 2009 11:42:18 +0100
Subject: [PATCH 04/17] ARM: pxa/raumfeld: add OHCI function
In-Reply-To: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
Message-ID: <1259145751-3331-5-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All Raumfeld devices feature an USB (OHCI) host port.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-pxa/raumfeld.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 82af0dc..2d47dc2 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -31,6 +31,7 @@
 #include <mach/pxa3xx-regs.h>
 #include <mach/mfp-pxa3xx.h>
 #include <mach/mfp-pxa300.h>
+#include <mach/ohci.h>
 
 #include "generic.h"
 #include "devices.h"
@@ -93,6 +94,10 @@ static mfp_cfg_t raumfeld_pin_config[] __initdata = {
 
 	/* UART3 */
 	GPIO110_UART3_RXD,
+
+	/* USB Host */
+	GPIO0_2_USBH_PEN,
+	GPIO1_2_USBH_PWR,
 };
 
 /*
@@ -140,6 +145,13 @@ static void __init raumfeld_eth_init(void)
 	platform_device_register(&smc91x_device);
 }
 
+/**
+ * USB (OHCI) support
+ */
+static struct pxaohci_platform_data raumfeld_ohci_info = {
+	.port_mode      = PMM_GLOBAL_MODE,
+	.flags		= ENABLE_PORT1,
+};
 
 static void __init raumfeld_common_init(void)
 {
@@ -157,6 +169,7 @@ static void __init raumfeld_common_init(void)
 	gpio_direction_output(mfp_to_gpio(GPIO_SHUTDOWN_SUPPLY), 0);
 
 	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_pin_config));
+	pxa_set_ohci_info(&raumfeld_ohci_info);
 }
 
 static void __init raumfeld_controller_init(void)
-- 
1.6.5.2
