From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:07 -0700
Subject: [PATCH 03/46] Davinci: DM365: Add platform device for McBSP
In-Reply-To: <1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Miguel Aguilar <miguel.aguilar@ridgerun.com>

1) Registers the platform device for McBSP on dm365.
2) Add platform data to DM365 EVM board file.
3) Set i2c address for audio codec at DM365 EVM board file.

Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c    |    7 ++++
 arch/arm/mach-davinci/dm365.c              |   45 +++++++++++++++++++++++++++-
 arch/arm/mach-davinci/include/mach/asp.h   |    3 ++
 arch/arm/mach-davinci/include/mach/dm365.h |    2 +
 4 files changed, 56 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 52dd804..a5ed178 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -176,11 +176,16 @@ static struct at24_platform_data eeprom_info = {
 	.context	= (void *)0x7f00,
 };
 
+static struct snd_platform_data dm365_evm_snd_data;
+
 static struct i2c_board_info i2c_info[] = {
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
 		.platform_data	= &eeprom_info,
 	},
+	{
+		I2C_BOARD_INFO("tlv320aic3x", 0x18),
+	},
 };
 
 static struct davinci_i2c_platform_data i2c_pdata = {
@@ -472,6 +477,8 @@ static __init void dm365_evm_init(void)
 
 	/* maybe setup mmc1/etc ... _after_ mmc0 */
 	evm_init_cpld();
+
+	dm365_init_asp(&dm365_evm_snd_data);
 }
 
 static __init void dm365_evm_irq_init(void)
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 6c948b1..2674438 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -32,6 +32,7 @@
 #include <mach/time.h>
 #include <mach/serial.h>
 #include <mach/common.h>
+#include <mach/asp.h>
 
 #include "clock.h"
 #include "mux.h"
@@ -456,7 +457,7 @@ static struct davinci_clk dm365_clks[] = {
 	CLK(NULL, "usb", &usb_clk),
 	CLK("davinci_emac.1", NULL, &emac_clk),
 	CLK("voice_codec", NULL, &voicecodec_clk),
-	CLK("soc-audio.0", NULL, &asp0_clk),
+	CLK("davinci-asp.0", NULL, &asp0_clk),
 	CLK(NULL, "rto", &rto_clk),
 	CLK(NULL, "mjcp", &mjcp_clk),
 	CLK(NULL, NULL, NULL),
@@ -603,6 +604,9 @@ INT_CFG(DM365,  INT_IMX1_ENABLE,     24,    1,    1,     false)
 INT_CFG(DM365,  INT_IMX1_DISABLE,    24,    1,    0,     false)
 INT_CFG(DM365,  INT_NSF_ENABLE,      25,    1,    1,     false)
 INT_CFG(DM365,  INT_NSF_DISABLE,     25,    1,    0,     false)
+
+EVT_CFG(DM365,	EVT2_ASP_TX,         0,     1,    0,     false)
+EVT_CFG(DM365,	EVT3_ASP_RX,         1,     1,    0,     false)
 #endif
 };
 
@@ -806,6 +810,31 @@ static struct platform_device dm365_edma_device = {
 	.resource		= edma_resources,
 };
 
+static struct resource dm365_asp_resources[] = {
+	{
+		.start	= DAVINCI_DM365_ASP0_BASE,
+		.end	= DAVINCI_DM365_ASP0_BASE + SZ_8K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= DAVINCI_DMA_ASP0_TX,
+		.end	= DAVINCI_DMA_ASP0_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	{
+		.start	= DAVINCI_DMA_ASP0_RX,
+		.end	= DAVINCI_DMA_ASP0_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device dm365_asp_device = {
+	.name		= "davinci-asp",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(dm365_asp_resources),
+	.resource	= dm365_asp_resources,
+};
+
 static struct map_desc dm365_io_desc[] = {
 	{
 		.virtual	= IO_VIRT,
@@ -907,6 +936,20 @@ static struct davinci_soc_info davinci_soc_info_dm365 = {
 	.sram_len		= SZ_32K,
 };
 
+void __init dm365_init_asp(struct snd_platform_data *pdata)
+{
+	davinci_cfg_reg(DM365_MCBSP0_BDX);
+	davinci_cfg_reg(DM365_MCBSP0_X);
+	davinci_cfg_reg(DM365_MCBSP0_BFSX);
+	davinci_cfg_reg(DM365_MCBSP0_BDR);
+	davinci_cfg_reg(DM365_MCBSP0_R);
+	davinci_cfg_reg(DM365_MCBSP0_BFSR);
+	davinci_cfg_reg(DM365_EVT2_ASP_TX);
+	davinci_cfg_reg(DM365_EVT3_ASP_RX);
+	dm365_asp_device.dev.platform_data = pdata;
+	platform_device_register(&dm365_asp_device);
+}
+
 void __init dm365_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm365);
diff --git a/arch/arm/mach-davinci/include/mach/asp.h b/arch/arm/mach-davinci/include/mach/asp.h
index 18e4ce3..fef12b9 100644
--- a/arch/arm/mach-davinci/include/mach/asp.h
+++ b/arch/arm/mach-davinci/include/mach/asp.h
@@ -11,6 +11,9 @@
 #define DAVINCI_ASP0_BASE	0x01E02000
 #define DAVINCI_ASP1_BASE	0x01E04000
 
+/* Bases of dm365 register banks */
+#define DAVINCI_DM365_ASP0_BASE	0x01D02000
+
 /* Bases of dm646x register banks */
 #define	DAVINCI_DM646X_MCASP0_REG_BASE		0x01D01000
 #define DAVINCI_DM646X_MCASP1_REG_BASE		0x01D01800
diff --git a/arch/arm/mach-davinci/include/mach/dm365.h b/arch/arm/mach-davinci/include/mach/dm365.h
index 09db434..2291c0d 100644
--- a/arch/arm/mach-davinci/include/mach/dm365.h
+++ b/arch/arm/mach-davinci/include/mach/dm365.h
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <mach/hardware.h>
 #include <mach/emac.h>
+#include <mach/asp.h>
 
 #define DM365_EMAC_BASE			(0x01D07000)
 #define DM365_EMAC_CNTRL_OFFSET		(0x0000)
@@ -25,5 +26,6 @@
 #define DM365_EMAC_CNTRL_RAM_SIZE	(0x2000)
 
 void __init dm365_init(void);
+void __init dm365_init_asp(struct snd_platform_data *pdata);
 
 #endif /* __ASM_ARCH_DM365_H */
-- 
1.6.4.3
