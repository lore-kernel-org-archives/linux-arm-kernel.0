From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 10 Jan 2011 14:42:41 -0200
Subject: [PATCH] ARM: imx/mx27_3ds: Add debug board support
Message-ID: <1294677761-11971-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/Kconfig         |    1 +
 arch/arm/mach-imx/mach-mx27_3ds.c |    7 +++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 17d2e60..56684b5 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -243,6 +243,7 @@ config MACH_MX27_3DS
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_SPI_IMX
+	select MXC_DEBUG_BOARD
 	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for MX27PDK platform. This includes specific
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 83f8e2b..4d72891 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -37,12 +37,15 @@
 #include <mach/common.h>
 #include <mach/iomux-mx27.h>
 #include <mach/ulpi.h>
+#include <mach/irqs.h>
+#include <mach/3ds_debugboard.h>
 
 #include "devices-imx27.h"
 
 #define SD1_EN_GPIO (GPIO_PORTB + 25)
 #define OTG_PHY_RESET_GPIO (GPIO_PORTB + 23)
 #define SPI2_SS0 (GPIO_PORTD + 21)
+#define EXPIO_PARENT_INT	(MXC_INTERNAL_IRQS + GPIO_PORTC + 28)
 
 static const int mx27pdk_pins[] __initconst = {
 	/* UART1 */
@@ -276,6 +279,10 @@ static void __init mx27pdk_init(void)
 	imx27_add_spi_imx1(&spi2_pdata);
 	spi_register_board_info(mx27_3ds_spi_devs,
 						ARRAY_SIZE(mx27_3ds_spi_devs));
+
+	if (mxc_expio_init(MX27_CS5_BASE_ADDR, EXPIO_PARENT_INT))
+		pr_warn("Init of the debugboard failed, all "
+				"devices on the debugboard are unusable.\n");
 }
 
 static void __init mx27pdk_timer_init(void)
-- 
1.6.0.4
