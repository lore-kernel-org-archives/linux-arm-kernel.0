From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 30 Jun 2010 23:34:46 +0200
Subject: [PATCH] ARM: Fixups for the RealView PB1176
Message-ID: <1277933686-17415-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a number of basic fixes to the PB1176 that makes it tick
properly:

- Detect MMC insertion/removal even when PL061 GPIO is not compiled
  in. The register to read this status directly is removed on the
  PB1176.
- Define the UART3 on the DevChip (where is actually is) and define
  the new UART4 serial port on the FPGA.
- Also define the clocks for these two UARTs apropriately.
- Remove the false notion that the PB1176 should have its CLCD
  on the ISSP, this is not the case, it is in the DevChip.
- Remove the defintions and the previously commented-out PL081
  DMAC. As confirmed by mail this was found to be broken on the
  PB1176 board and removed from the subsequent FPGA images.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-realview/core.c                      |   23 +++++++++++++++++++-
 arch/arm/mach-realview/include/mach/board-pb1176.h |    1 +
 arch/arm/mach-realview/realview_pb1176.c           |   14 +++++-------
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 1195e07..4b3d2fd 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -231,6 +231,21 @@ static unsigned int realview_mmc_status(struct device *dev)
 	struct amba_device *adev = container_of(dev, struct amba_device, dev);
 	u32 mask;
 
+	if (machine_is_realview_pb1176()) {
+		static bool inserted = false;
+
+		/*
+		 * The PB1176 does not have the status register,
+		 * assume it is inserted at startup, then invert
+		 * for each call so card insertion/removal will
+		 * be detected anyway. This will not be called if
+		 * GPIO on PL061 is active, which is the proper
+		 * way to do this on the PB1176.
+		 */
+		inserted = !inserted;
+		return inserted ? 0 : 1;
+	}
+
 	if (adev->res.start == REALVIEW_MMCI0_BASE)
 		mask = 1;
 	else
@@ -312,6 +327,12 @@ static struct clk_lookup lookups[] = {
 	}, {	/* UART3 */
 		.dev_id		= "fpga:uart3",
 		.clk		= &ref24_clk,
+	}, {	/* UART3 is on the dev chip in PB1176 */
+		.dev_id		= "dev:uart3",
+		.clk		= &ref24_clk,
+	}, {	/* UART4 only exists in PB1176 */
+		.dev_id		= "fpga:uart4",
+		.clk		= &ref24_clk,
 	}, {	/* KMI0 */
 		.dev_id		= "fpga:kmi0",
 		.clk		= &ref24_clk,
@@ -321,7 +342,7 @@ static struct clk_lookup lookups[] = {
 	}, {	/* MMC0 */
 		.dev_id		= "fpga:mmc0",
 		.clk		= &ref24_clk,
-	}, {	/* EB:CLCD */
+	}, {	/* CLCD is in the PB1176 and EB DevChip */
 		.dev_id		= "dev:clcd",
 		.clk		= &oscvco_clk,
 	}, {	/* PB:CLCD */
diff --git a/arch/arm/mach-realview/include/mach/board-pb1176.h b/arch/arm/mach-realview/include/mach/board-pb1176.h
index 2f5ccb2..002ab5d 100644
--- a/arch/arm/mach-realview/include/mach/board-pb1176.h
+++ b/arch/arm/mach-realview/include/mach/board-pb1176.h
@@ -26,6 +26,7 @@
 /*
  * Peripheral addresses
  */
+#define REALVIEW_PB1176_UART4_BASE		0x10009000 /* UART 4 */
 #define REALVIEW_PB1176_SCTL_BASE		0x10100000 /* System controller */
 #define REALVIEW_PB1176_SMC_BASE		0x10111000 /* SMC */
 #define REALVIEW_PB1176_DMC_BASE		0x10109000 /* DMC configuration */
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index 099a1f1..9f02350 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -144,8 +144,6 @@ static struct pl061_platform_data gpio2_plat_data = {
 #define MPMC_DMA	{ 0, 0 }
 #define PB1176_CLCD_IRQ	{ IRQ_DC1176_CLCD, NO_IRQ }
 #define PB1176_CLCD_DMA	{ 0, 0 }
-#define DMAC_IRQ	{ IRQ_PB1176_DMAC, NO_IRQ }
-#define DMAC_DMA	{ 0, 0 }
 #define SCTL_IRQ	{ NO_IRQ, NO_IRQ }
 #define SCTL_DMA	{ 0, 0 }
 #define PB1176_WATCHDOG_IRQ	{ IRQ_DC1176_WATCHDOG, NO_IRQ }
@@ -166,6 +164,8 @@ static struct pl061_platform_data gpio2_plat_data = {
 #define PB1176_UART2_DMA	{ 11, 10 }
 #define PB1176_UART3_IRQ	{ IRQ_DC1176_UART3, NO_IRQ }
 #define PB1176_UART3_DMA	{ 0x86, 0x87 }
+#define PB1176_UART4_IRQ	{ IRQ_PB1176_UART4, NO_IRQ }
+#define PB1176_UART4_DMA	{ 0, 0 }
 #define PB1176_SSP_IRQ		{ IRQ_PB1176_SSP, NO_IRQ }
 #define PB1176_SSP_DMA		{ 9, 8 }
 
@@ -174,7 +174,7 @@ AMBA_DEVICE(aaci,	"fpga:aaci",	AACI,		NULL);
 AMBA_DEVICE(mmc0,	"fpga:mmc0",	MMCI0,		&realview_mmc0_plat_data);
 AMBA_DEVICE(kmi0,	"fpga:kmi0",	KMI0,		NULL);
 AMBA_DEVICE(kmi1,	"fpga:kmi1",	KMI1,		NULL);
-AMBA_DEVICE(uart3,	"fpga:uart3",	PB1176_UART3,	NULL);
+AMBA_DEVICE(uart4,	"fpga:uart4",	PB1176_UART4,	NULL);
 
 /* DevChip Primecells */
 AMBA_DEVICE(smc,	"dev:smc",	PB1176_SMC,	NULL);
@@ -188,18 +188,16 @@ AMBA_DEVICE(sci0,	"dev:sci0",	SCI,		NULL);
 AMBA_DEVICE(uart0,	"dev:uart0",	PB1176_UART0,	NULL);
 AMBA_DEVICE(uart1,	"dev:uart1",	PB1176_UART1,	NULL);
 AMBA_DEVICE(uart2,	"dev:uart2",	PB1176_UART2,	NULL);
+AMBA_DEVICE(uart3,	"dev:uart3",	PB1176_UART3,	NULL);
 AMBA_DEVICE(ssp0,	"dev:ssp0",	PB1176_SSP,	NULL);
-
-/* Primecells on the NEC ISSP chip */
-AMBA_DEVICE(clcd,	"issp:clcd",	PB1176_CLCD,	&clcd_plat_data);
-//AMBA_DEVICE(dmac,	"issp:dmac",	PB1176_DMAC,	NULL);
+AMBA_DEVICE(clcd,	"dev:clcd",	PB1176_CLCD,	&clcd_plat_data);
 
 static struct amba_device *amba_devs[] __initdata = {
-//	&dmac_device,
 	&uart0_device,
 	&uart1_device,
 	&uart2_device,
 	&uart3_device,
+	&uart4_device,
 	&smc_device,
 	&clcd_device,
 	&sctl_device,
-- 
1.7.0.1
