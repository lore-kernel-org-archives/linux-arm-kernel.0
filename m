From: jgq516@gmail.com (jgq516 at gmail.com)
Date: Wed, 20 Oct 2010 17:34:43 +0800
Subject: [PATCH v2 1/1] mx35pdk: add debug board support
Message-ID: <1287567283-19488-1-git-send-email-jgq516@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xiao Jiang <jgq516@gmail.com>

Enable debug board support for mx35pdk. As suggested
by Fabio, add MXC_DEBUG_BOARD config and redefinition
EXPIO_PARENT_INT.

Signed-off-by: Xiao Jiang <jgq516@gmail.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx3/Kconfig         |    1 +
 arch/arm/mach-mx3/mach-mx35_3ds.c |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 85beece..cdf6ac5 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -139,6 +139,7 @@ config MACH_ARMADILLO5X0
 config MACH_MX35_3DS
 	bool "Support MX35PDK platform"
 	select ARCH_MX35
+	select MXC_DEBUG_BOARD
 	select IMX_HAVE_PLATFORM_IMX_UART
 	default n
 	help
diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index 1c30d72..326b90a 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -35,10 +35,14 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/iomux-mx35.h>
+#include <mach/irqs.h>
+#include <mach/3ds_debugboard.h>
 
 #include "devices-imx35.h"
 #include "devices.h"
 
+#define EXPIO_PARENT_INT       (MXC_INTERNAL_IRQS + GPIO_PORTA + 1)
+
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
@@ -95,6 +99,10 @@ static void __init mxc_board_init(void)
 	imx35_add_imx_uart0(&uart_pdata);
 
 	mxc_register_device(&mxc_otg_udc_device, &usb_pdata);
+
+	if (mxc_expio_init(MX35_CS5_BASE_ADDR, EXPIO_PARENT_INT))
+		pr_warn("Init of the debugboard failed, all "
+			"devices on the board are unusable.\n");
 }
 
 static void __init mx35pdk_timer_init(void)
-- 
1.6.3.3
