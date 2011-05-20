From: manjunath.hadli@ti.com (Manjunath Hadli)
Date: Fri, 20 May 2011 19:38:40 +0530
Subject: [PATCH 2/4] davinci: dm365: move macros local to dm365.c to that file
Message-ID: <1305900520-3725-1-git-send-email-manjunath.hadli@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

move the register base addresses and offsets used only by dm365
platform file from platform header dm365.h to dm365.c as they
are used only in the c file.

Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
---
 arch/arm/mach-davinci/dm365.c              |   20 ++++++++++++++++++--
 arch/arm/mach-davinci/include/mach/dm365.h |   12 ------------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 02d2cc3..7e2464e 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -39,8 +39,6 @@
 #include "clock.h"
 #include "mux.h"
 
-#define DM365_REF_FREQ		24000000	/* 24 MHz on the DM365 EVM */
-
 static struct pll_data pll1_data = {
 	.num		= 1,
 	.phys_base	= DAVINCI_PLL1_BASE,
@@ -53,6 +51,8 @@ static struct pll_data pll2_data = {
 	.flags		= PLL_HAS_POSTDIV | PLL_HAS_PREDIV,
 };
 
+#define DM365_REF_FREQ		24000000	/* 24 MHz on the DM365 EVM */
+
 static struct clk ref_clk = {
 	.name		= "ref_clk",
 	.rate		= DM365_REF_FREQ,
@@ -681,6 +681,10 @@ void __init dm365_init_spi0(unsigned chipselect_mask,
 	platform_device_register(&dm365_spi0_device);
 }
 
+#define DM365_EMAC_CNTRL_OFFSET		0x0000
+#define DM365_EMAC_CNTRL_MOD_OFFSET	0x3000
+#define DM365_EMAC_CNTRL_RAM_OFFSET	0x1000
+#define DM365_EMAC_CNTRL_RAM_SIZE	0x2000
 static struct emac_platform_data dm365_emac_pdata = {
 	.ctrl_reg_offset	= DM365_EMAC_CNTRL_OFFSET,
 	.ctrl_mod_reg_offset	= DM365_EMAC_CNTRL_MOD_OFFSET,
@@ -689,6 +693,8 @@ static struct emac_platform_data dm365_emac_pdata = {
 	.version		= EMAC_VERSION_2,
 };
 
+#define DM365_EMAC_BASE		0x01D07000
+
 static struct resource dm365_emac_resources[] = {
 	{
 		.start	= DM365_EMAC_BASE,
@@ -727,6 +733,8 @@ static struct platform_device dm365_emac_device = {
 	.resource	= dm365_emac_resources,
 };
 
+#define DM365_EMAC_MDIO_BASE	(DM365_EMAC_BASE + 0x4000)
+
 static struct resource dm365_mdio_resources[] = {
 	{
 		.start	= DM365_EMAC_MDIO_BASE,
@@ -922,6 +930,10 @@ static struct platform_device dm365_asp_device = {
 	.resource	= dm365_asp_resources,
 };
 
+#define DAVINCI_DM365_VC_BASE	0x01D0C000
+#define DAVINCI_DMA_VC_TX	2
+#define DAVINCI_DMA_VC_RX	3
+
 static struct resource dm365_vc_resources[] = {
 	{
 		.start	= DAVINCI_DM365_VC_BASE,
@@ -947,6 +959,8 @@ static struct platform_device dm365_vc_device = {
 	.resource	= dm365_vc_resources,
 };
 
+#define DM365_RTC_BASE		0x01C69000
+
 static struct resource dm365_rtc_resources[] = {
 	{
 		.start = DM365_RTC_BASE,
@@ -981,6 +995,8 @@ static struct map_desc dm365_io_desc[] = {
 	},
 };
 
+#define DM365_KEYSCAN_BASE	0x01C69400
+
 static struct resource dm365_ks_resources[] = {
 	{
 		/* registers */
diff --git a/arch/arm/mach-davinci/include/mach/dm365.h b/arch/arm/mach-davinci/include/mach/dm365.h
index 2563bf4..c3c69a6 100644
--- a/arch/arm/mach-davinci/include/mach/dm365.h
+++ b/arch/arm/mach-davinci/include/mach/dm365.h
@@ -20,18 +20,6 @@
 #include <mach/keyscan.h>
 #include <media/davinci/vpfe_capture.h>
 
-#define DM365_EMAC_BASE			(0x01D07000)
-#define DM365_EMAC_MDIO_BASE		(DM365_EMAC_BASE + 0x4000)
-#define DM365_EMAC_CNTRL_OFFSET		(0x0000)
-#define DM365_EMAC_CNTRL_MOD_OFFSET	(0x3000)
-#define DM365_EMAC_CNTRL_RAM_OFFSET	(0x1000)
-#define DM365_EMAC_CNTRL_RAM_SIZE	(0x2000)
-
-/* Base of key scan register bank */
-#define DM365_KEYSCAN_BASE		(0x01C69400)
-
-#define DM365_RTC_BASE			(0x01C69000)
-
 #define DAVINCI_DM365_VC_BASE		(0x01D0C000)
 #define DAVINCI_DMA_VC_TX		2
 #define DAVINCI_DMA_VC_RX		3
-- 
1.6.2.4
