From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Mar 2013 16:55:44 +0800
Subject: [PATCH 08/13] ARM: mxs: use debug_ll_io_init for low-level debug
In-Reply-To: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
References: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364547350-30498-9-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only user of the static mapping done in mx23_map_io and mx28_map_io
is low-level debug now.  Use debug_ll_io_init() instead, so that the
static mapping is used nowhere and can be removed completely later.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/include/mach/debug-macro.S |    9 +++------
 arch/arm/mach-mxs/mach-mxs.c                 |    5 +++--
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/debug-macro.S b/arch/arm/mach-mxs/include/mach/debug-macro.S
index 90c6b78..d869515 100644
--- a/arch/arm/mach-mxs/include/mach/debug-macro.S
+++ b/arch/arm/mach-mxs/include/mach/debug-macro.S
@@ -11,16 +11,13 @@
  *
  */
 
-#include <mach/mx23.h>
-#include <mach/mx28.h>
-
 #ifdef CONFIG_DEBUG_IMX23_UART
-#define UART_PADDR	MX23_DUART_BASE_ADDR
+#define UART_PADDR	0x80070000
 #elif defined (CONFIG_DEBUG_IMX28_UART)
-#define UART_PADDR	MX28_DUART_BASE_ADDR
+#define UART_PADDR	0x80074000
 #endif
 
-#define UART_VADDR	MXS_IO_ADDRESS(UART_PADDR)
+#define UART_VADDR	0xfe100000
 
 		.macro	addruart, rp, rv, tmp
 		ldr	\rp, =UART_PADDR	@ physical
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index a8fe453..cf73976 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -27,6 +27,7 @@
 #include <linux/phy.h>
 #include <linux/pinctrl/consumer.h>
 #include <asm/mach/arch.h>
+#include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/system_misc.h>
 #include <mach/common.h>
@@ -507,7 +508,7 @@ static const char *imx28_dt_compat[] __initdata = {
 };
 
 DT_MACHINE_START(IMX23, "Freescale i.MX23 (Device Tree)")
-	.map_io		= mx23_map_io,
+	.map_io		= debug_ll_io_init,
 	.init_irq	= irqchip_init,
 	.handle_irq	= icoll_handle_irq,
 	.init_time	= imx23_timer_init,
@@ -517,7 +518,7 @@ DT_MACHINE_START(IMX23, "Freescale i.MX23 (Device Tree)")
 MACHINE_END
 
 DT_MACHINE_START(IMX28, "Freescale i.MX28 (Device Tree)")
-	.map_io		= mx28_map_io,
+	.map_io		= debug_ll_io_init,
 	.init_irq	= irqchip_init,
 	.handle_irq	= icoll_handle_irq,
 	.init_time	= imx28_timer_init,
-- 
1.7.9.5
