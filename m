From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  9 Aug 2010 11:05:40 +0200
Subject: [PATCH 5/8] ARM i.MX3: Add sdma device
In-Reply-To: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
References: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1281344743-2029-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/clock-imx31.c |    4 ++--
 arch/arm/mach-mx3/clock-imx35.c |    2 +-
 arch/arm/mach-mx3/devices.c     |   32 ++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx3/clock-imx31.c b/arch/arm/mach-mx3/clock-imx31.c
index 9a9eb6d..5ad5307 100644
--- a/arch/arm/mach-mx3/clock-imx31.c
+++ b/arch/arm/mach-mx3/clock-imx31.c
@@ -477,7 +477,7 @@ DEFINE_CLOCK(epit1_clk,   0, MXC_CCM_CGR0,  6, NULL, NULL, &perclk_clk);
 DEFINE_CLOCK(epit2_clk,   1, MXC_CCM_CGR0,  8, NULL, NULL, &perclk_clk);
 DEFINE_CLOCK(iim_clk,     0, MXC_CCM_CGR0, 10, NULL, NULL, &ipg_clk);
 DEFINE_CLOCK(ata_clk,     0, MXC_CCM_CGR0, 12, NULL, NULL, &ipg_clk);
-DEFINE_CLOCK(sdma_clk1,   0, MXC_CCM_CGR0, 14, NULL, &sdma_clk1, &ahb_clk);
+DEFINE_CLOCK(sdma_clk1,   0, MXC_CCM_CGR0, 14, NULL, NULL, &ahb_clk);
 DEFINE_CLOCK(cspi3_clk,   2, MXC_CCM_CGR0, 16, NULL, NULL, &ipg_clk);
 DEFINE_CLOCK(rng_clk,     0, MXC_CCM_CGR0, 18, NULL, NULL, &ipg_clk);
 DEFINE_CLOCK(uart1_clk,   0, MXC_CCM_CGR0, 20, NULL, NULL, &perclk_clk);
@@ -564,7 +564,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "ata", ata_clk)
 	_REGISTER_CLOCK(NULL, "rtic", rtic_clk)
 	_REGISTER_CLOCK(NULL, "rng", rng_clk)
-	_REGISTER_CLOCK(NULL, "sdma_ahb", sdma_clk1)
+	_REGISTER_CLOCK("imx-sdma", NULL, sdma_clk1)
 	_REGISTER_CLOCK(NULL, "sdma_ipg", sdma_clk2)
 	_REGISTER_CLOCK(NULL, "mstick", mstick1_clk)
 	_REGISTER_CLOCK(NULL, "mstick", mstick2_clk)
diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index d3af0fd..b5f3281 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -461,7 +461,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "rtc", rtc_clk)
 	_REGISTER_CLOCK(NULL, "rtic", rtic_clk)
 	_REGISTER_CLOCK(NULL, "scc", scc_clk)
-	_REGISTER_CLOCK(NULL, "sdma", sdma_clk)
+	_REGISTER_CLOCK("imx-sdma", NULL, sdma_clk)
 	_REGISTER_CLOCK(NULL, "spba", spba_clk)
 	_REGISTER_CLOCK(NULL, "spdif", spdif_clk)
 	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index a4fd1a2..1c6578a 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -26,6 +26,7 @@
 #include <mach/irqs.h>
 #include <mach/common.h>
 #include <mach/mx3_camera.h>
+#include <mach/sdma.h>
 
 #include "devices.h"
 
@@ -391,6 +392,33 @@ struct platform_device imx_kpp_device = {
 	.resource = imx_kpp_resources,
 };
 
+static struct resource imx_sdma_resources[] = {
+	{
+		.start	= MX3x_SDMA_BASE_ADDR,
+		.end	= MX3x_SDMA_BASE_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM
+	}, {
+		.start	= MX31_INT_SDMA,
+		.end	= MX31_INT_SDMA,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct sdma_platform_data sdma_data_imx31 = {
+	.sdma_version = 1,
+};
+
+static struct sdma_platform_data sdma_data_imx35 = {
+	.sdma_version = 2,
+};
+
+struct platform_device imx_sdma_device = {
+	.name = "imx-sdma",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(imx_sdma_resources),
+	.resource = imx_sdma_resources,
+};
+
 static int __init mx3_devices_init(void)
 {
 #if defined(CONFIG_ARCH_MX31)
@@ -398,6 +426,7 @@ static int __init mx3_devices_init(void)
 		imx_wdt_resources[0].start = MX31_WDOG_BASE_ADDR;
 		imx_wdt_resources[0].end = MX31_WDOG_BASE_ADDR + 0x3fff;
 		mxc_register_device(&mxc_rnga_device, NULL);
+		mxc_register_device(&imx_sdma_device, &sdma_data_imx31);
 	}
 #endif
 #if defined(CONFIG_ARCH_MX35)
@@ -416,6 +445,9 @@ static int __init mx3_devices_init(void)
 		imx_ssi_resources1[1].end = MX35_INT_SSI2;
 		imx_wdt_resources[0].start = MX35_WDOG_BASE_ADDR;
 		imx_wdt_resources[0].end = MX35_WDOG_BASE_ADDR + 0x3fff;
+		imx_sdma_resources[1].start = MX35_INT_SDMA;
+		imx_sdma_resources[1].end = MX35_INT_SDMA;
+		mxc_register_device(&imx_sdma_device, &sdma_data_imx35);
 	}
 #endif
 
-- 
1.7.1
