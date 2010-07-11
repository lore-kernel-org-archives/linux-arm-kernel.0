From: linus.walleij@stericsson.com (Linus Walleij)
Date: Sun, 11 Jul 2010 02:44:11 +0200
Subject: [PATCH] ARM: add SSP platform data for the RealView PB1176
Message-ID: <1278809051-30211-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the required platform data to get the SSP PL022 driver
working on the RealView PB1176.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-realview/core.c                     |    3 +++
 arch/arm/mach-realview/include/mach/irqs-pb1176.h |    2 +-
 arch/arm/mach-realview/realview_pb1176.c          |   13 +++++++++++--
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 4b3d2fd..e8aaeef 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -348,6 +348,9 @@ static struct clk_lookup lookups[] = {
 	}, {	/* PB:CLCD */
 		.dev_id		= "issp:clcd",
 		.clk		= &oscvco_clk,
+	}, {	/* SSP */
+		.dev_id		= "dev:ssp0",
+		.clk		= &ref24_clk,
 	}
 };
 
diff --git a/arch/arm/mach-realview/include/mach/irqs-pb1176.h b/arch/arm/mach-realview/include/mach/irqs-pb1176.h
index 830055b..5c3c625 100644
--- a/arch/arm/mach-realview/include/mach/irqs-pb1176.h
+++ b/arch/arm/mach-realview/include/mach/irqs-pb1176.h
@@ -40,6 +40,7 @@
 #define IRQ_DC1176_L2CC		(IRQ_DC1176_GIC_START + 13)
 #define IRQ_DC1176_RTC		(IRQ_DC1176_GIC_START + 14)
 #define IRQ_DC1176_CLCD		(IRQ_DC1176_GIC_START + 15)	/* CLCD controller */
+#define IRQ_DC1176_SSP		(IRQ_DC1176_GIC_START + 17)	/* SSP port */
 #define IRQ_DC1176_UART0	(IRQ_DC1176_GIC_START + 18)	/* UART 0 on development chip */
 #define IRQ_DC1176_UART1	(IRQ_DC1176_GIC_START + 19)	/* UART 1 on development chip */
 #define IRQ_DC1176_UART2	(IRQ_DC1176_GIC_START + 20)	/* UART 2 on development chip */
@@ -73,7 +74,6 @@
 #define IRQ_PB1176_RTC		(IRQ_PB1176_GIC_START + 25)	/* Real Time Clock */
 
 #define IRQ_PB1176_GPIO0	-1
-#define IRQ_PB1176_SSP		-1
 #define IRQ_PB1176_SCTL		-1
 
 #define NR_GIC_PB1176		2
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index 9f02350..3ed57ca 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -25,6 +25,7 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/pl061.h>
 #include <linux/amba/mmci.h>
+#include <linux/amba/pl022.h>
 #include <linux/io.h>
 
 #include <mach/hardware.h>
@@ -123,6 +124,14 @@ static struct pl061_platform_data gpio2_plat_data = {
 	.irq_base	= -1,
 };
 
+static struct pl022_ssp_controller ssp0_plat_data = {
+	/* If you have several SPI buses this varies, we have only bus 0 */
+	.bus_id = 0,
+	/* Set this to 1 when we think we got DMA working */
+	.enable_dma = 0,
+	.num_chipselect = 1,
+};
+
 /*
  * RealView PB1176 AMBA devices
  */
@@ -166,7 +175,7 @@ static struct pl061_platform_data gpio2_plat_data = {
 #define PB1176_UART3_DMA	{ 0x86, 0x87 }
 #define PB1176_UART4_IRQ	{ IRQ_PB1176_UART4, NO_IRQ }
 #define PB1176_UART4_DMA	{ 0, 0 }
-#define PB1176_SSP_IRQ		{ IRQ_PB1176_SSP, NO_IRQ }
+#define PB1176_SSP_IRQ		{ IRQ_DC1176_SSP, NO_IRQ }
 #define PB1176_SSP_DMA		{ 9, 8 }
 
 /* FPGA Primecells */
@@ -189,7 +198,7 @@ AMBA_DEVICE(uart0,	"dev:uart0",	PB1176_UART0,	NULL);
 AMBA_DEVICE(uart1,	"dev:uart1",	PB1176_UART1,	NULL);
 AMBA_DEVICE(uart2,	"dev:uart2",	PB1176_UART2,	NULL);
 AMBA_DEVICE(uart3,	"dev:uart3",	PB1176_UART3,	NULL);
-AMBA_DEVICE(ssp0,	"dev:ssp0",	PB1176_SSP,	NULL);
+AMBA_DEVICE(ssp0,	"dev:ssp0",	PB1176_SSP,	&ssp0_plat_data);
 AMBA_DEVICE(clcd,	"dev:clcd",	PB1176_CLCD,	&clcd_plat_data);
 
 static struct amba_device *amba_devs[] __initdata = {
-- 
1.7.1
