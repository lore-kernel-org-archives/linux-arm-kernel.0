From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 14 Jul 2010 00:44:15 +0200
Subject: [PATCH 1/2] ARM: PL022 SSP platform data for the RealViews
Message-ID: <1279061055-20306-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds platform data for the PL022 to the ARM RealView reference
designs, adds the necessary clock definition and fixes a badly
defined IRQ line on the PB1176.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
This replaces the earlier patch that would only add the platform
data to the PB1176.
---
 arch/arm/mach-realview/core.c                     |    3 +++
 arch/arm/mach-realview/include/mach/irqs-pb1176.h |    2 +-
 arch/arm/mach-realview/realview_eb.c              |    9 ++++++++-
 arch/arm/mach-realview/realview_pb1176.c          |   11 +++++++++--
 arch/arm/mach-realview/realview_pb11mp.c          |    9 ++++++++-
 arch/arm/mach-realview/realview_pba8.c            |    9 ++++++++-
 arch/arm/mach-realview/realview_pbx.c             |    9 ++++++++-
 7 files changed, 45 insertions(+), 7 deletions(-)

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
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 4425018..b450075 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -25,6 +25,7 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/pl061.h>
 #include <linux/amba/mmci.h>
+#include <linux/amba/pl022.h>
 #include <linux/io.h>
 
 #include <mach/hardware.h>
@@ -129,6 +130,12 @@ static struct pl061_platform_data gpio2_plat_data = {
 	.irq_base	= -1,
 };
 
+static struct pl022_ssp_controller ssp0_plat_data = {
+	.bus_id = 0,
+	.enable_dma = 0,
+	.num_chipselect = 1,
+};
+
 /*
  * RealView EB AMBA devices
  */
@@ -213,7 +220,7 @@ AMBA_DEVICE(sci0,  "dev:sci0",  SCI,      NULL);
 AMBA_DEVICE(uart0, "dev:uart0", EB_UART0, NULL);
 AMBA_DEVICE(uart1, "dev:uart1", EB_UART1, NULL);
 AMBA_DEVICE(uart2, "dev:uart2", EB_UART2, NULL);
-AMBA_DEVICE(ssp0,  "dev:ssp0",  EB_SSP,   NULL);
+AMBA_DEVICE(ssp0,  "dev:ssp0",  EB_SSP,   &ssp0_plat_data);
 
 static struct amba_device *amba_devs[] __initdata = {
 	&dmac_device,
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index 9f02350..1766deb 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -25,6 +25,7 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/pl061.h>
 #include <linux/amba/mmci.h>
+#include <linux/amba/pl022.h>
 #include <linux/io.h>
 
 #include <mach/hardware.h>
@@ -123,6 +124,12 @@ static struct pl061_platform_data gpio2_plat_data = {
 	.irq_base	= -1,
 };
 
+static struct pl022_ssp_controller ssp0_plat_data = {
+	.bus_id = 0,
+	.enable_dma = 0,
+	.num_chipselect = 1,
+};
+
 /*
  * RealView PB1176 AMBA devices
  */
@@ -166,7 +173,7 @@ static struct pl061_platform_data gpio2_plat_data = {
 #define PB1176_UART3_DMA	{ 0x86, 0x87 }
 #define PB1176_UART4_IRQ	{ IRQ_PB1176_UART4, NO_IRQ }
 #define PB1176_UART4_DMA	{ 0, 0 }
-#define PB1176_SSP_IRQ		{ IRQ_PB1176_SSP, NO_IRQ }
+#define PB1176_SSP_IRQ		{ IRQ_DC1176_SSP, NO_IRQ }
 #define PB1176_SSP_DMA		{ 9, 8 }
 
 /* FPGA Primecells */
@@ -189,7 +196,7 @@ AMBA_DEVICE(uart0,	"dev:uart0",	PB1176_UART0,	NULL);
 AMBA_DEVICE(uart1,	"dev:uart1",	PB1176_UART1,	NULL);
 AMBA_DEVICE(uart2,	"dev:uart2",	PB1176_UART2,	NULL);
 AMBA_DEVICE(uart3,	"dev:uart3",	PB1176_UART3,	NULL);
-AMBA_DEVICE(ssp0,	"dev:ssp0",	PB1176_SSP,	NULL);
+AMBA_DEVICE(ssp0,	"dev:ssp0",	PB1176_SSP,	&ssp0_plat_data);
 AMBA_DEVICE(clcd,	"dev:clcd",	PB1176_CLCD,	&clcd_plat_data);
 
 static struct amba_device *amba_devs[] __initdata = {
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 0e07a5c..d591bc0 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -25,6 +25,7 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/pl061.h>
 #include <linux/amba/mmci.h>
+#include <linux/amba/pl022.h>
 #include <linux/io.h>
 
 #include <mach/hardware.h>
@@ -124,6 +125,12 @@ static struct pl061_platform_data gpio2_plat_data = {
 	.irq_base	= -1,
 };
 
+static struct pl022_ssp_controller ssp0_plat_data = {
+	.bus_id = 0,
+	.enable_dma = 0,
+	.num_chipselect = 1,
+};
+
 /*
  * RealView PB11MPCore AMBA devices
  */
@@ -190,7 +197,7 @@ AMBA_DEVICE(sci0,	"dev:sci0",	SCI,		NULL);
 AMBA_DEVICE(uart0,	"dev:uart0",	PB11MP_UART0,	NULL);
 AMBA_DEVICE(uart1,	"dev:uart1",	PB11MP_UART1,	NULL);
 AMBA_DEVICE(uart2,	"dev:uart2",	PB11MP_UART2,	NULL);
-AMBA_DEVICE(ssp0,	"dev:ssp0",	PB11MP_SSP,	NULL);
+AMBA_DEVICE(ssp0,	"dev:ssp0",	PB11MP_SSP,	&ssp0_plat_data);
 
 /* Primecells on the NEC ISSP chip */
 AMBA_DEVICE(clcd,	"issp:clcd",	PB11MP_CLCD,	&clcd_plat_data);
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index ac2f06f..6c37621 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -25,6 +25,7 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/pl061.h>
 #include <linux/amba/mmci.h>
+#include <linux/amba/pl022.h>
 #include <linux/io.h>
 
 #include <asm/irq.h>
@@ -114,6 +115,12 @@ static struct pl061_platform_data gpio2_plat_data = {
 	.irq_base	= -1,
 };
 
+static struct pl022_ssp_controller ssp0_plat_data = {
+	.bus_id = 0,
+	.enable_dma = 0,
+	.num_chipselect = 1,
+};
+
 /*
  * RealView PBA8Core AMBA devices
  */
@@ -180,7 +187,7 @@ AMBA_DEVICE(sci0,	"dev:sci0",	SCI,		NULL);
 AMBA_DEVICE(uart0,	"dev:uart0",	PBA8_UART0,	NULL);
 AMBA_DEVICE(uart1,	"dev:uart1",	PBA8_UART1,	NULL);
 AMBA_DEVICE(uart2,	"dev:uart2",	PBA8_UART2,	NULL);
-AMBA_DEVICE(ssp0,	"dev:ssp0",	PBA8_SSP,	NULL);
+AMBA_DEVICE(ssp0,	"dev:ssp0",	PBA8_SSP,	&ssp0_plat_data);
 
 /* Primecells on the NEC ISSP chip */
 AMBA_DEVICE(clcd,	"issp:clcd",	PBA8_CLCD,	&clcd_plat_data);
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 08fd683..9428eff 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -24,6 +24,7 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/pl061.h>
 #include <linux/amba/mmci.h>
+#include <linux/amba/pl022.h>
 #include <linux/io.h>
 
 #include <asm/irq.h>
@@ -136,6 +137,12 @@ static struct pl061_platform_data gpio2_plat_data = {
 	.irq_base	= -1,
 };
 
+static struct pl022_ssp_controller ssp0_plat_data = {
+	.bus_id = 0,
+	.enable_dma = 0,
+	.num_chipselect = 1,
+};
+
 /*
  * RealView PBXCore AMBA devices
  */
@@ -202,7 +209,7 @@ AMBA_DEVICE(sci0,	"dev:sci0",	SCI,		NULL);
 AMBA_DEVICE(uart0,	"dev:uart0",	PBX_UART0,	NULL);
 AMBA_DEVICE(uart1,	"dev:uart1",	PBX_UART1,	NULL);
 AMBA_DEVICE(uart2,	"dev:uart2",	PBX_UART2,	NULL);
-AMBA_DEVICE(ssp0,	"dev:ssp0",	PBX_SSP,	NULL);
+AMBA_DEVICE(ssp0,	"dev:ssp0",	PBX_SSP,	&ssp0_plat_data);
 
 /* Primecells on the NEC ISSP chip */
 AMBA_DEVICE(clcd,	"issp:clcd",	PBX_CLCD,	&clcd_plat_data);
-- 
1.7.1
