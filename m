From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:13 -0700
Subject: [PATCH 22/34] DaVinci: move IDE platform device to its proper place
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-23-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

The IDE platform device is registered in three different places (2 board files
for DM644x and in dm646x.c for DM646x) while both the IDE base address and the
IDE IRQ are the same for both SoCs -- therefore,  the proper place for the IDE
platform seems to be in devices.c. Merge the IDE platform data and registration
code and create davinci_init_ide() in place of dm646x_init_ide()...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-dm644x-evm.c    |   33 +-------------------
 arch/arm/mach-davinci/board-dm646x-evm.c    |    2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c   |   34 +-------------------
 arch/arm/mach-davinci/devices.c             |   44 +++++++++++++++++++++++++++
 arch/arm/mach-davinci/dm646x.c              |   32 -------------------
 arch/arm/mach-davinci/include/mach/common.h |    1 +
 arch/arm/mach-davinci/include/mach/dm646x.h |    3 --
 7 files changed, 49 insertions(+), 100 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index d028bab..73c0b04 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -41,8 +41,6 @@
 #define DM644X_EVM_PHY_MASK		(0x2)
 #define DM644X_EVM_MDIO_FREQUENCY	(2200000) /* PHY bus frequency */
 
-#define DAVINCI_CFC_ATA_BASE		  0x01C66000
-
 #define LXT971_PHY_ID	(0x001378e2)
 #define LXT971_PHY_MASK	(0xfffffff0)
 
@@ -252,32 +250,6 @@ static struct platform_device rtc_dev = {
 	.id             = -1,
 };
 
-static struct resource ide_resources[] = {
-	{
-		.start          = DAVINCI_CFC_ATA_BASE,
-		.end            = DAVINCI_CFC_ATA_BASE + 0x7ff,
-		.flags          = IORESOURCE_MEM,
-	},
-	{
-		.start          = IRQ_IDE,
-		.end            = IRQ_IDE,
-		.flags          = IORESOURCE_IRQ,
-	},
-};
-
-static u64 ide_dma_mask = DMA_BIT_MASK(32);
-
-static struct platform_device ide_dev = {
-	.name           = "palm_bk3710",
-	.id             = -1,
-	.resource       = ide_resources,
-	.num_resources  = ARRAY_SIZE(ide_resources),
-	.dev = {
-		.dma_mask		= &ide_dma_mask,
-		.coherent_dma_mask      = DMA_BIT_MASK(32),
-	},
-};
-
 static struct snd_platform_data dm644x_evm_snd_data;
 
 /*----------------------------------------------------------------------*/
@@ -698,10 +670,7 @@ static __init void davinci_evm_init(void)
 			pr_warning("WARNING: both IDE and Flash are "
 				"enabled, but they share AEMIF pins.\n"
 				"\tDisable IDE for NAND/NOR support.\n");
-		davinci_cfg_reg(DM644X_HPIEN_DISABLE);
-		davinci_cfg_reg(DM644X_ATAEN);
-		davinci_cfg_reg(DM644X_HDIREN);
-		platform_device_register(&ide_dev);
+		davinci_init_ide();
 	} else if (HAS_NAND || HAS_NOR) {
 		davinci_cfg_reg(DM644X_HPIEN_DISABLE);
 		davinci_cfg_reg(DM644X_ATAEN_DISABLE);
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index b22e22c..e2ac06f 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -733,7 +733,7 @@ static __init void evm_init(void)
 	platform_device_register(&davinci_nand_device);
 
 	if (HAS_ATA)
-		dm646x_init_ide();
+		davinci_init_ide();
 
 	soc_info->emac_pdata->phy_mask = DM646X_EVM_PHY_MASK;
 	soc_info->emac_pdata->mdio_max_freq = DM646X_EVM_MDIO_FREQUENCY;
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 5afe37e..875770c 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -31,6 +31,7 @@
 #include <asm/mach/arch.h>
 
 #include <mach/dm644x.h>
+#include <mach/common.h>
 #include <mach/i2c.h>
 #include <mach/serial.h>
 #include <mach/mux.h>
@@ -41,8 +42,6 @@
 #define NEUROS_OSD2_PHY_MASK		0x2
 #define NEUROS_OSD2_MDIO_FREQUENCY	2200000 /* PHY bus frequency */
 
-#define DAVINCI_CFC_ATA_BASE		 0x01C66000
-
 #define LXT971_PHY_ID			0x001378e2
 #define LXT971_PHY_MASK			0xfffffff0
 
@@ -127,32 +126,6 @@ static struct platform_device davinci_fb_device = {
 	.num_resources = 0,
 };
 
-static struct resource ide_resources[] = {
-	{
-		.start		= DAVINCI_CFC_ATA_BASE,
-		.end		= DAVINCI_CFC_ATA_BASE + 0x7ff,
-		.flags		= IORESOURCE_MEM,
-	},
-	{
-		.start		= IRQ_IDE,
-		.end		= IRQ_IDE,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static u64 ide_dma_mask = DMA_BIT_MASK(32);
-
-static struct platform_device ide_dev = {
-	.name		= "palm_bk3710",
-	.id		= -1,
-	.resource	= ide_resources,
-	.num_resources	= ARRAY_SIZE(ide_resources),
-	.dev = {
-		.dma_mask		= &ide_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
-
 static struct snd_platform_data dm644x_ntosd2_snd_data;
 
 static struct gpio_led ntosd2_leds[] = {
@@ -256,10 +229,7 @@ static __init void davinci_ntosd2_init(void)
 			pr_warning("WARNING: both IDE and Flash are "
 				"enabled, but they share AEMIF pins.\n"
 				"\tDisable IDE for NAND/NOR support.\n");
-		davinci_cfg_reg(DM644X_HPIEN_DISABLE);
-		davinci_cfg_reg(DM644X_ATAEN);
-		davinci_cfg_reg(DM644X_HDIREN);
-		platform_device_register(&ide_dev);
+		davinci_init_ide();
 	} else if (HAS_NAND) {
 		davinci_cfg_reg(DM644X_HPIEN_DISABLE);
 		davinci_cfg_reg(DM644X_ATAEN_DISABLE);
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index ef28080..d9c82ee 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -26,6 +26,7 @@
 #include "clock.h"
 
 #define DAVINCI_I2C_BASE	     0x01C21000
+#define DAVINCI_ATA_BASE	     0x01C66000
 #define DAVINCI_MMCSD0_BASE	     0x01E10000
 #define DM355_MMCSD0_BASE	     0x01E11000
 #define DM355_MMCSD1_BASE	     0x01E00000
@@ -60,6 +61,49 @@ void __init davinci_init_i2c(struct davinci_i2c_platform_data *pdata)
 	(void) platform_device_register(&davinci_i2c_device);
 }
 
+static struct resource ide_resources[] = {
+	{
+		.start		= DAVINCI_ATA_BASE,
+		.end		= DAVINCI_ATA_BASE + 0x7ff,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= IRQ_IDE,
+		.end		= IRQ_IDE,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static u64 ide_dma_mask = DMA_BIT_MASK(32);
+
+static struct platform_device ide_device = {
+	.name           = "palm_bk3710",
+	.id             = -1,
+	.resource       = ide_resources,
+	.num_resources  = ARRAY_SIZE(ide_resources),
+	.dev = {
+		.dma_mask		= &ide_dma_mask,
+		.coherent_dma_mask      = DMA_BIT_MASK(32),
+	},
+};
+
+void __init davinci_init_ide(void)
+{
+	if (cpu_is_davinci_dm644x()) {
+		davinci_cfg_reg(DM644X_HPIEN_DISABLE);
+		davinci_cfg_reg(DM644X_ATAEN);
+		davinci_cfg_reg(DM644X_HDIREN);
+	} else if (cpu_is_davinci_dm646x()) {
+		/* IRQ_DM646X_IDE is the same as IRQ_IDE */
+		davinci_cfg_reg(DM646X_ATAEN);
+	} else {
+		WARN_ON(1);
+		return;
+	}
+
+	platform_device_register(&ide_device);
+}
+
 #if	defined(CONFIG_MMC_DAVINCI) || defined(CONFIG_MMC_DAVINCI_MODULE)
 
 static u64 mmcsd0_dma_mask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index b67b997..a0b3739 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -596,32 +596,6 @@ static struct platform_device dm646x_edma_device = {
 	.resource		= edma_resources,
 };
 
-static struct resource ide_resources[] = {
-	{
-		.start          = DM646X_ATA_REG_BASE,
-		.end            = DM646X_ATA_REG_BASE + 0x7ff,
-		.flags          = IORESOURCE_MEM,
-	},
-	{
-		.start          = IRQ_DM646X_IDE,
-		.end            = IRQ_DM646X_IDE,
-		.flags          = IORESOURCE_IRQ,
-	},
-};
-
-static u64 ide_dma_mask = DMA_BIT_MASK(32);
-
-static struct platform_device ide_dev = {
-	.name           = "palm_bk3710",
-	.id             = -1,
-	.resource       = ide_resources,
-	.num_resources  = ARRAY_SIZE(ide_resources),
-	.dev = {
-		.dma_mask		= &ide_dma_mask,
-		.coherent_dma_mask      = DMA_BIT_MASK(32),
-	},
-};
-
 static struct resource dm646x_mcasp0_resources[] = {
 	{
 		.name	= "mcasp0",
@@ -867,12 +841,6 @@ static struct davinci_soc_info davinci_soc_info_dm646x = {
 	.sram_len		= SZ_32K,
 };
 
-void __init dm646x_init_ide(void)
-{
-	davinci_cfg_reg(DM646X_ATAEN);
-	platform_device_register(&ide_dev);
-}
-
 void __init dm646x_init_mcasp0(struct snd_platform_data *pdata)
 {
 	dm646x_mcasp0_device.dev.platform_data = pdata;
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index d88104e..884dc72 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -70,6 +70,7 @@ struct davinci_soc_info {
 extern struct davinci_soc_info davinci_soc_info;
 
 extern void davinci_common_init(struct davinci_soc_info *soc_info);
+extern void davinci_init_ide(void);
 
 /* standard place to map on-chip SRAMs; they *may* support DMA */
 #define SRAM_VIRT	0xfffe0000
diff --git a/arch/arm/mach-davinci/include/mach/dm646x.h b/arch/arm/mach-davinci/include/mach/dm646x.h
index 4d62db7..add6f79 100644
--- a/arch/arm/mach-davinci/include/mach/dm646x.h
+++ b/arch/arm/mach-davinci/include/mach/dm646x.h
@@ -25,13 +25,10 @@
 #define DM646X_EMAC_MDIO_OFFSET		(0x4000)
 #define DM646X_EMAC_CNTRL_RAM_SIZE	(0x2000)
 
-#define DM646X_ATA_REG_BASE		(0x01C66000)
-
 #define DM646X_ASYNC_EMIF_CONTROL_BASE	0x20008000
 #define DM646X_ASYNC_EMIF_CS2_SPACE_BASE 0x42000000
 
 void __init dm646x_init(void);
-void __init dm646x_init_ide(void);
 void __init dm646x_init_mcasp0(struct snd_platform_data *pdata);
 void __init dm646x_init_mcasp1(struct snd_platform_data *pdata);
 void __init dm646x_board_setup_refclk(struct clk *clk);
-- 
1.7.0.2
