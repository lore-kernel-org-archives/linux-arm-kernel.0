From: jcd@tribudubois.net (Jean-Christophe DUBOIS)
Date: Tue,  4 May 2010 21:10:48 +0200
Subject: [PATCH] Allow the i.mx25 3DStack target to compile.
Message-ID: <1273000248-10142-1-git-send-email-jcd@tribudubois.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a resend because I wrongly submited this pach to 
linux-arm mailing list instead of linux-arm-kernel.

The FEC driver is not compiling for 3Dstack evaluation board
in the actual state. Fix it.

Signed-off-by: Jean-Chrsitophe DUBOIS <jcd@tribudubois.net>
---
 arch/arm/mach-mx25/mx25pdk.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mx25/mx25pdk.c b/arch/arm/mach-mx25/mx25pdk.c
index 6f06089..cbf45c0 100644
--- a/arch/arm/mach-mx25/mx25pdk.c
+++ b/arch/arm/mach-mx25/mx25pdk.c
@@ -22,7 +22,6 @@
 #include <linux/clk.h>
 #include <linux/irq.h>
 #include <linux/gpio.h>
-#include <linux/fec.h>
 #include <linux/platform_device.h>
 
 #include <mach/hardware.h>
@@ -56,8 +55,9 @@ static struct pad_desc mx25pdk_pads[] = {
 	MX25_PAD_D12__GPIO_4_8, /* FEC_RESET_B, GPIO 104 */
 };
 
-static struct fec_platform_data mx25_fec_pdata = {
-        .phy    = PHY_INTERFACE_MODE_RMII,
+static struct platform_device *platform_devices[] __initdata = {
+	&mxc_usbh2,
+        &mx25_fec_device,
 };
 
 #define FEC_ENABLE_GPIO		35
@@ -83,10 +83,9 @@ static void __init mx25pdk_init(void)
 			ARRAY_SIZE(mx25pdk_pads));
 
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
-	mxc_register_device(&mxc_usbh2, NULL);
 
 	mx25pdk_fec_reset();
-	mxc_register_device(&mx25_fec_device, &mx25_fec_pdata);
+        platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 }
 
 static void __init mx25pdk_timer_init(void)
-- 
1.7.0.4
