From: jgq516@gmail.com (jgq516 at gmail.com)
Date: Fri, 15 Oct 2010 16:00:33 +0800
Subject: [PATCH 1/1] Mx35pdk: enable debug board support
Message-ID: <1287129633-9244-1-git-send-email-jgq516@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xiao Jiang <jgq516@gmail.com>

Add debug board support, then kernel can boot from lan9217 ethernet.

Signed-off-by: Xiao Jiang <jgq516@gmail.com>
---
 arch/arm/mach-mx3/mach-mx35_3ds.c          |    9 +++++++++
 arch/arm/plat-mxc/include/mach/iomux-mx3.h |    4 ++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index 1c30d72..78e0657 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -34,11 +34,16 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
+#include <mach/irqs.h>
+#include <mach/iomux-mx3.h>
 #include <mach/iomux-mx35.h>
+#include <mach/3ds_debugboard.h>
 
 #include "devices-imx35.h"
 #include "devices.h"
 
+#define EXPIO_PARENT_INT	IOMUX_TO_IRQ(MX35_PIN_GPIO1_1)
+
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
@@ -95,6 +100,10 @@ static void __init mxc_board_init(void)
 	imx35_add_imx_uart0(&uart_pdata);
 
 	mxc_register_device(&mxc_otg_udc_device, &usb_pdata);
+
+	if (mxc_expio_init(MX35_CS5_BASE_ADDR, EXPIO_PARENT_INT))
+		pr_warn("Init of the debugboard failed, all "
+			"devices on the board are unusable.\n");
 }
 
 static void __init mx35pdk_timer_init(void)
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx3.h b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
index cbaed29..c686d2a 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx3.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
@@ -170,6 +170,10 @@ int mxc_iomux_mode(unsigned int pin_mode);
  * value is constructed based on the rules described above.
  */
 
+enum iomux_mx35_pins {
+	MX35_PIN_GPIO1_1	= IOMUX_PIN(1,   338),
+};
+
 enum iomux_pins {
 	MX31_PIN_TTM_PAD	= IOMUX_PIN(0xff,   0),
 	MX31_PIN_CSPI3_SPI_RDY	= IOMUX_PIN(0xff,   1),
-- 
1.6.3.3
