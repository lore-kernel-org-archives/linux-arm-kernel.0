From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 18 Nov 2011 07:59:32 +0100
Subject: [PATCH 4/4] [orion] Remove address map info from all platform data
 strucutures.
In-Reply-To: <1321599572-705-1-git-send-email-andrew@lunn.ch>
References: <1321599572-705-1-git-send-email-andrew@lunn.ch>
Message-ID: <1321599572-705-5-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-dove/common.c                   |   15 +++------
 arch/arm/mach-kirkwood/common.c               |   16 +++------
 arch/arm/mach-mv78xx0/common.c                |   21 +++++-------
 arch/arm/mach-orion5x/common.c                |   15 +++------
 arch/arm/plat-orion/common.c                  |   43 +++++-------------------
 arch/arm/plat-orion/include/plat/audio.h      |    3 --
 arch/arm/plat-orion/include/plat/common.h     |   17 ++-------
 arch/arm/plat-orion/include/plat/ehci-orion.h |    1 -
 arch/arm/plat-orion/include/plat/mv_xor.h     |    6 ---
 arch/arm/plat-orion/include/plat/mvsdio.h     |    1 -
 include/linux/ata_platform.h                  |    3 --
 11 files changed, 36 insertions(+), 105 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 29c1881..29ff0d0 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -14,7 +14,6 @@
 #include <linux/platform_device.h>
 #include <linux/pci.h>
 #include <linux/clk.h>
-#include <linux/mbus.h>
 #include <linux/ata_platform.h>
 #include <linux/gpio.h>
 #include <asm/page.h>
@@ -72,8 +71,7 @@ void __init dove_map_io(void)
  ****************************************************************************/
 void __init dove_ehci0_init(void)
 {
-	orion_ehci_init(&orion_mbus_dram_info,
-			DOVE_USB0_PHYS_BASE, IRQ_DOVE_USB0);
+	orion_ehci_init(DOVE_USB0_PHYS_BASE, IRQ_DOVE_USB0);
 }
 
 /*****************************************************************************
@@ -81,8 +79,7 @@ void __init dove_ehci0_init(void)
  ****************************************************************************/
 void __init dove_ehci1_init(void)
 {
-	orion_ehci_1_init(&orion_mbus_dram_info,
-			  DOVE_USB1_PHYS_BASE, IRQ_DOVE_USB1);
+	orion_ehci_1_init(DOVE_USB1_PHYS_BASE, IRQ_DOVE_USB1);
 }
 
 /*****************************************************************************
@@ -90,7 +87,7 @@ void __init dove_ehci1_init(void)
  ****************************************************************************/
 void __init dove_ge00_init(struct mv643xx_eth_platform_data *eth_data)
 {
-	orion_ge00_init(eth_data, &orion_mbus_dram_info,
+	orion_ge00_init(eth_data,
 			DOVE_GE00_PHYS_BASE, IRQ_DOVE_GE00_SUM,
 			0, get_tclk());
 }
@@ -108,8 +105,7 @@ void __init dove_rtc_init(void)
  ****************************************************************************/
 void __init dove_sata_init(struct mv_sata_platform_data *sata_data)
 {
-	orion_sata_init(sata_data, &orion_mbus_dram_info,
-			DOVE_SATA_PHYS_BASE, IRQ_DOVE_SATA);
+	orion_sata_init(sata_data, DOVE_SATA_PHYS_BASE, IRQ_DOVE_SATA);
 
 }
 
@@ -199,8 +195,7 @@ struct sys_timer dove_timer = {
  ****************************************************************************/
 void __init dove_xor0_init(void)
 {
-	orion_xor0_init(&orion_mbus_dram_info,
-			DOVE_XOR0_PHYS_BASE, DOVE_XOR0_HIGH_PHYS_BASE,
+	orion_xor0_init(DOVE_XOR0_PHYS_BASE, DOVE_XOR0_HIGH_PHYS_BASE,
 			IRQ_DOVE_XOR_00, IRQ_DOVE_XOR_01);
 }
 
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index d8b4ed2..6badde5 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -12,7 +12,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
-#include <linux/mbus.h>
 #include <linux/ata_platform.h>
 #include <linux/mtd/nand.h>
 #include <linux/dma-mapping.h>
@@ -74,8 +73,7 @@ unsigned int kirkwood_clk_ctrl = CGC_DUNIT | CGC_RESERVED;
 void __init kirkwood_ehci_init(void)
 {
 	kirkwood_clk_ctrl |= CGC_USB0;
-	orion_ehci_init(&orion_mbus_dram_info,
-			USB_PHYS_BASE, IRQ_KIRKWOOD_USB);
+	orion_ehci_init(USB_PHYS_BASE, IRQ_KIRKWOOD_USB);
 }
 
 
@@ -86,7 +84,7 @@ void __init kirkwood_ge00_init(struct mv643xx_eth_platform_data *eth_data)
 {
 	kirkwood_clk_ctrl |= CGC_GE0;
 
-	orion_ge00_init(eth_data, &orion_mbus_dram_info,
+	orion_ge00_init(eth_data,
 			GE00_PHYS_BASE, IRQ_KIRKWOOD_GE00_SUM,
 			IRQ_KIRKWOOD_GE00_ERR, kirkwood_tclk);
 }
@@ -100,7 +98,7 @@ void __init kirkwood_ge01_init(struct mv643xx_eth_platform_data *eth_data)
 
 	kirkwood_clk_ctrl |= CGC_GE1;
 
-	orion_ge01_init(eth_data, &orion_mbus_dram_info,
+	orion_ge01_init(eth_data,
 			GE01_PHYS_BASE, IRQ_KIRKWOOD_GE01_SUM,
 			IRQ_KIRKWOOD_GE01_ERR, kirkwood_tclk);
 }
@@ -179,8 +177,7 @@ void __init kirkwood_sata_init(struct mv_sata_platform_data *sata_data)
 	if (sata_data->n_ports > 1)
 		kirkwood_clk_ctrl |= CGC_SATA1;
 
-	orion_sata_init(sata_data, &orion_mbus_dram_info,
-			SATA_PHYS_BASE, IRQ_KIRKWOOD_SATA);
+	orion_sata_init(sata_data, SATA_PHYS_BASE, IRQ_KIRKWOOD_SATA);
 }
 
 
@@ -222,7 +219,6 @@ void __init kirkwood_sdio_init(struct mvsdio_platform_data *mvsdio_data)
 		mvsdio_data->clock = 100000000;
 	else
 		mvsdio_data->clock = 200000000;
-	mvsdio_data->dram = &orion_mbus_dram_info;
 	kirkwood_clk_ctrl |= CGC_SDIO;
 	kirkwood_sdio.dev.platform_data = mvsdio_data;
 	platform_device_register(&kirkwood_sdio);
@@ -286,8 +282,7 @@ static void __init kirkwood_xor0_init(void)
 {
 	kirkwood_clk_ctrl |= CGC_XOR0;
 
-	orion_xor0_init(&orion_mbus_dram_info,
-			XOR0_PHYS_BASE, XOR0_HIGH_PHYS_BASE,
+	orion_xor0_init(XOR0_PHYS_BASE, XOR0_HIGH_PHYS_BASE,
 			IRQ_KIRKWOOD_XOR_00, IRQ_KIRKWOOD_XOR_01);
 }
 
@@ -365,7 +360,6 @@ static struct resource kirkwood_i2s_resources[] = {
 };
 
 static struct kirkwood_asoc_platform_data kirkwood_i2s_data = {
-	.dram        = &orion_mbus_dram_info,
 	.burst       = 128,
 };
 
diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index be0c232..534ce20 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -12,7 +12,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
-#include <linux/mbus.h>
 #include <linux/ata_platform.h>
 #include <linux/ethtool.h>
 #include <asm/mach/map.h>
@@ -170,8 +169,7 @@ void __init mv78xx0_map_io(void)
  ****************************************************************************/
 void __init mv78xx0_ehci0_init(void)
 {
-	orion_ehci_init(&orion_mbus_dram_info,
-			USB0_PHYS_BASE, IRQ_MV78XX0_USB_0);
+	orion_ehci_init(USB0_PHYS_BASE, IRQ_MV78XX0_USB_0);
 }
 
 
@@ -180,8 +178,7 @@ void __init mv78xx0_ehci0_init(void)
  ****************************************************************************/
 void __init mv78xx0_ehci1_init(void)
 {
-	orion_ehci_1_init(&orion_mbus_dram_info,
-			  USB1_PHYS_BASE, IRQ_MV78XX0_USB_1);
+	orion_ehci_1_init(USB1_PHYS_BASE, IRQ_MV78XX0_USB_1);
 }
 
 
@@ -190,8 +187,7 @@ void __init mv78xx0_ehci1_init(void)
  ****************************************************************************/
 void __init mv78xx0_ehci2_init(void)
 {
-	orion_ehci_2_init(&orion_mbus_dram_info,
-			  USB2_PHYS_BASE, IRQ_MV78XX0_USB_2);
+	orion_ehci_2_init(USB2_PHYS_BASE, IRQ_MV78XX0_USB_2);
 }
 
 
@@ -200,7 +196,7 @@ void __init mv78xx0_ehci2_init(void)
  ****************************************************************************/
 void __init mv78xx0_ge00_init(struct mv643xx_eth_platform_data *eth_data)
 {
-	orion_ge00_init(eth_data, &orion_mbus_dram_info,
+	orion_ge00_init(eth_data,
 			GE00_PHYS_BASE, IRQ_MV78XX0_GE00_SUM,
 			IRQ_MV78XX0_GE_ERR, get_tclk());
 }
@@ -211,7 +207,7 @@ void __init mv78xx0_ge00_init(struct mv643xx_eth_platform_data *eth_data)
  ****************************************************************************/
 void __init mv78xx0_ge01_init(struct mv643xx_eth_platform_data *eth_data)
 {
-	orion_ge01_init(eth_data, &orion_mbus_dram_info,
+	orion_ge01_init(eth_data,
 			GE01_PHYS_BASE, IRQ_MV78XX0_GE01_SUM,
 			NO_IRQ, get_tclk());
 }
@@ -235,7 +231,7 @@ void __init mv78xx0_ge10_init(struct mv643xx_eth_platform_data *eth_data)
 		eth_data->duplex = DUPLEX_FULL;
 	}
 
-	orion_ge10_init(eth_data, &orion_mbus_dram_info,
+	orion_ge10_init(eth_data,
 			GE10_PHYS_BASE, IRQ_MV78XX0_GE10_SUM,
 			NO_IRQ, get_tclk());
 }
@@ -259,7 +255,7 @@ void __init mv78xx0_ge11_init(struct mv643xx_eth_platform_data *eth_data)
 		eth_data->duplex = DUPLEX_FULL;
 	}
 
-	orion_ge11_init(eth_data, &orion_mbus_dram_info,
+	orion_ge11_init(eth_data,
 			GE11_PHYS_BASE, IRQ_MV78XX0_GE11_SUM,
 			NO_IRQ, get_tclk());
 }
@@ -278,8 +274,7 @@ void __init mv78xx0_i2c_init(void)
  ****************************************************************************/
 void __init mv78xx0_sata_init(struct mv_sata_platform_data *sata_data)
 {
-	orion_sata_init(sata_data, &orion_mbus_dram_info,
-			SATA_PHYS_BASE, IRQ_MV78XX0_SATA);
+	orion_sata_init(sata_data, SATA_PHYS_BASE, IRQ_MV78XX0_SATA);
 }
 
 
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 27addd5..c0dea6e 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -15,7 +15,6 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/serial_8250.h>
-#include <linux/mbus.h>
 #include <linux/mv643xx_i2c.h>
 #include <linux/ata_platform.h>
 #include <net/dsa.h>
@@ -72,8 +71,7 @@ void __init orion5x_map_io(void)
  ****************************************************************************/
 void __init orion5x_ehci0_init(void)
 {
-	orion_ehci_init(&orion_mbus_dram_info,
-			ORION5X_USB0_PHYS_BASE, IRQ_ORION5X_USB0_CTRL);
+	orion_ehci_init(ORION5X_USB0_PHYS_BASE, IRQ_ORION5X_USB0_CTRL);
 }
 
 
@@ -82,8 +80,7 @@ void __init orion5x_ehci0_init(void)
  ****************************************************************************/
 void __init orion5x_ehci1_init(void)
 {
-	orion_ehci_1_init(&orion_mbus_dram_info,
-			  ORION5X_USB1_PHYS_BASE, IRQ_ORION5X_USB1_CTRL);
+	orion_ehci_1_init(ORION5X_USB1_PHYS_BASE, IRQ_ORION5X_USB1_CTRL);
 }
 
 
@@ -92,7 +89,7 @@ void __init orion5x_ehci1_init(void)
  ****************************************************************************/
 void __init orion5x_eth_init(struct mv643xx_eth_platform_data *eth_data)
 {
-	orion_ge00_init(eth_data, &orion_mbus_dram_info,
+	orion_ge00_init(eth_data,
 			ORION5X_ETH_PHYS_BASE, IRQ_ORION5X_ETH_SUM,
 			IRQ_ORION5X_ETH_ERR, orion5x_tclk);
 }
@@ -122,8 +119,7 @@ void __init orion5x_i2c_init(void)
  ****************************************************************************/
 void __init orion5x_sata_init(struct mv_sata_platform_data *sata_data)
 {
-	orion_sata_init(sata_data, &orion_mbus_dram_info,
-			ORION5X_SATA_PHYS_BASE, IRQ_ORION5X_SATA);
+	orion_sata_init(sata_data, ORION5X_SATA_PHYS_BASE, IRQ_ORION5X_SATA);
 }
 
 
@@ -159,8 +155,7 @@ void __init orion5x_uart1_init(void)
  ****************************************************************************/
 void __init orion5x_xor_init(void)
 {
-	orion_xor0_init(&orion_mbus_dram_info,
-			ORION5X_XOR_PHYS_BASE,
+	orion_xor0_init(ORION5X_XOR_PHYS_BASE,
 			ORION5X_XOR_PHYS_BASE + 0x200,
 			IRQ_ORION5X_XOR0, IRQ_ORION5X_XOR1);
 }
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index 9e5451b..e5a2fde 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -13,7 +13,6 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/serial_8250.h>
-#include <linux/mbus.h>
 #include <linux/ata_platform.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/mv643xx_i2c.h>
@@ -203,13 +202,12 @@ void __init orion_rtc_init(unsigned long mapbase,
  ****************************************************************************/
 static __init void ge_complete(
 	struct mv643xx_eth_shared_platform_data *orion_ge_shared_data,
-	struct mbus_dram_target_info *mbus_dram_info, int tclk,
+	int tclk,
 	struct resource *orion_ge_resource, unsigned long irq,
 	struct platform_device *orion_ge_shared,
 	struct mv643xx_eth_platform_data *eth_data,
 	struct platform_device *orion_ge)
 {
-	orion_ge_shared_data->dram = mbus_dram_info;
 	orion_ge_shared_data->t_clk = tclk;
 	orion_ge_resource->start = irq;
 	orion_ge_resource->end = irq;
@@ -259,7 +257,6 @@ static struct platform_device orion_ge00 = {
 };
 
 void __init orion_ge00_init(struct mv643xx_eth_platform_data *eth_data,
-			    struct mbus_dram_target_info *mbus_dram_info,
 			    unsigned long mapbase,
 			    unsigned long irq,
 			    unsigned long irq_err,
@@ -267,7 +264,7 @@ void __init orion_ge00_init(struct mv643xx_eth_platform_data *eth_data,
 {
 	fill_resources(&orion_ge00_shared, orion_ge00_shared_resources,
 		       mapbase + 0x2000, SZ_16K - 1, irq_err);
-	ge_complete(&orion_ge00_shared_data, mbus_dram_info, tclk,
+	ge_complete(&orion_ge00_shared_data, tclk,
 		    orion_ge00_resources, irq, &orion_ge00_shared,
 		    eth_data, &orion_ge00);
 }
@@ -313,7 +310,6 @@ static struct platform_device orion_ge01 = {
 };
 
 void __init orion_ge01_init(struct mv643xx_eth_platform_data *eth_data,
-			    struct mbus_dram_target_info *mbus_dram_info,
 			    unsigned long mapbase,
 			    unsigned long irq,
 			    unsigned long irq_err,
@@ -321,7 +317,7 @@ void __init orion_ge01_init(struct mv643xx_eth_platform_data *eth_data,
 {
 	fill_resources(&orion_ge01_shared, orion_ge01_shared_resources,
 		       mapbase + 0x2000, SZ_16K - 1, irq_err);
-	ge_complete(&orion_ge01_shared_data, mbus_dram_info, tclk,
+	ge_complete(&orion_ge01_shared_data, tclk,
 		    orion_ge01_resources, irq, &orion_ge01_shared,
 		    eth_data, &orion_ge01);
 }
@@ -367,7 +363,6 @@ static struct platform_device orion_ge10 = {
 };
 
 void __init orion_ge10_init(struct mv643xx_eth_platform_data *eth_data,
-			    struct mbus_dram_target_info *mbus_dram_info,
 			    unsigned long mapbase,
 			    unsigned long irq,
 			    unsigned long irq_err,
@@ -375,7 +370,7 @@ void __init orion_ge10_init(struct mv643xx_eth_platform_data *eth_data,
 {
 	fill_resources(&orion_ge10_shared, orion_ge10_shared_resources,
 		       mapbase + 0x2000, SZ_16K - 1, irq_err);
-	ge_complete(&orion_ge10_shared_data, mbus_dram_info, tclk,
+	ge_complete(&orion_ge10_shared_data, tclk,
 		    orion_ge10_resources, irq, &orion_ge10_shared,
 		    eth_data, &orion_ge10);
 }
@@ -421,7 +416,6 @@ static struct platform_device orion_ge11 = {
 };
 
 void __init orion_ge11_init(struct mv643xx_eth_platform_data *eth_data,
-			    struct mbus_dram_target_info *mbus_dram_info,
 			    unsigned long mapbase,
 			    unsigned long irq,
 			    unsigned long irq_err,
@@ -429,7 +423,7 @@ void __init orion_ge11_init(struct mv643xx_eth_platform_data *eth_data,
 {
 	fill_resources(&orion_ge11_shared, orion_ge11_shared_resources,
 		       mapbase + 0x2000, SZ_16K - 1, irq_err);
-	ge_complete(&orion_ge11_shared_data, mbus_dram_info, tclk,
+	ge_complete(&orion_ge11_shared_data, tclk,
 		    orion_ge11_resources, irq, &orion_ge11_shared,
 		    eth_data, &orion_ge11);
 }
@@ -592,8 +586,6 @@ void __init orion_wdt_init(unsigned long tclk)
 /*****************************************************************************
  * XOR
  ****************************************************************************/
-static struct mv_xor_platform_shared_data orion_xor_shared_data;
-
 static u64 orion_xor_dmamask = DMA_BIT_MASK(32);
 
 void __init orion_xor_init_channels(
@@ -632,9 +624,6 @@ static struct resource orion_xor0_shared_resources[] = {
 static struct platform_device orion_xor0_shared = {
 	.name		= MV_XOR_SHARED_NAME,
 	.id		= 0,
-	.dev		= {
-		.platform_data = &orion_xor_shared_data,
-	},
 	.num_resources	= ARRAY_SIZE(orion_xor0_shared_resources),
 	.resource	= orion_xor0_shared_resources,
 };
@@ -687,14 +676,11 @@ static struct platform_device orion_xor01_channel = {
 	},
 };
 
-void __init orion_xor0_init(struct mbus_dram_target_info *mbus_dram_info,
-			    unsigned long mapbase_low,
+void __init orion_xor0_init(unsigned long mapbase_low,
 			    unsigned long mapbase_high,
 			    unsigned long irq_0,
 			    unsigned long irq_1)
 {
-	orion_xor_shared_data.dram = mbus_dram_info;
-
 	orion_xor0_shared_resources[0].start = mapbase_low;
 	orion_xor0_shared_resources[0].end = mapbase_low + 0xff;
 	orion_xor0_shared_resources[1].start = mapbase_high;
@@ -727,9 +713,6 @@ static struct resource orion_xor1_shared_resources[] = {
 static struct platform_device orion_xor1_shared = {
 	.name		= MV_XOR_SHARED_NAME,
 	.id		= 1,
-	.dev		= {
-		.platform_data = &orion_xor_shared_data,
-	},
 	.num_resources	= ARRAY_SIZE(orion_xor1_shared_resources),
 	.resource	= orion_xor1_shared_resources,
 };
@@ -828,11 +811,9 @@ static struct platform_device orion_ehci = {
 	},
 };
 
-void __init orion_ehci_init(struct mbus_dram_target_info *mbus_dram_info,
-			    unsigned long mapbase,
+void __init orion_ehci_init(unsigned long mapbase,
 			    unsigned long irq)
 {
-	orion_ehci_data.dram = mbus_dram_info;
 	fill_resources(&orion_ehci, orion_ehci_resources, mapbase, SZ_4K - 1,
 		       irq);
 
@@ -854,11 +835,9 @@ static struct platform_device orion_ehci_1 = {
 	},
 };
 
-void __init orion_ehci_1_init(struct mbus_dram_target_info *mbus_dram_info,
-			      unsigned long mapbase,
+void __init orion_ehci_1_init(unsigned long mapbase,
 			      unsigned long irq)
 {
-	orion_ehci_data.dram = mbus_dram_info;
 	fill_resources(&orion_ehci_1, orion_ehci_1_resources,
 		       mapbase, SZ_4K - 1, irq);
 
@@ -880,11 +859,9 @@ static struct platform_device orion_ehci_2 = {
 	},
 };
 
-void __init orion_ehci_2_init(struct mbus_dram_target_info *mbus_dram_info,
-			      unsigned long mapbase,
+void __init orion_ehci_2_init(unsigned long mapbase,
 			      unsigned long irq)
 {
-	orion_ehci_data.dram = mbus_dram_info;
 	fill_resources(&orion_ehci_2, orion_ehci_2_resources,
 		       mapbase, SZ_4K - 1, irq);
 
@@ -911,11 +888,9 @@ static struct platform_device orion_sata = {
 };
 
 void __init orion_sata_init(struct mv_sata_platform_data *sata_data,
-			    struct mbus_dram_target_info *mbus_dram_info,
 			    unsigned long mapbase,
 			    unsigned long irq)
 {
-	sata_data->dram = mbus_dram_info;
 	orion_sata.dev.platform_data = sata_data;
 	fill_resources(&orion_sata, orion_sata_resources,
 		       mapbase, 0x5000 - 1, irq);
diff --git a/arch/arm/plat-orion/include/plat/audio.h b/arch/arm/plat-orion/include/plat/audio.h
index 9cf1f78..885f8ab 100644
--- a/arch/arm/plat-orion/include/plat/audio.h
+++ b/arch/arm/plat-orion/include/plat/audio.h
@@ -1,11 +1,8 @@
 #ifndef __PLAT_AUDIO_H
 #define __PLAT_AUDIO_H
 
-#include <linux/mbus.h>
-
 struct kirkwood_asoc_platform_data {
 	u32 tclk;
-	struct mbus_dram_target_info *dram;
 	int burst;
 };
 #endif
diff --git a/arch/arm/plat-orion/include/plat/common.h b/arch/arm/plat-orion/include/plat/common.h
index a63c357..0fe08d7 100644
--- a/arch/arm/plat-orion/include/plat/common.h
+++ b/arch/arm/plat-orion/include/plat/common.h
@@ -37,28 +37,24 @@ void __init orion_rtc_init(unsigned long mapbase,
 			   unsigned long irq);
 
 void __init orion_ge00_init(struct mv643xx_eth_platform_data *eth_data,
-			    struct mbus_dram_target_info *mbus_dram_info,
 			    unsigned long mapbase,
 			    unsigned long irq,
 			    unsigned long irq_err,
 			    int tclk);
 
 void __init orion_ge01_init(struct mv643xx_eth_platform_data *eth_data,
-			    struct mbus_dram_target_info *mbus_dram_info,
 			    unsigned long mapbase,
 			    unsigned long irq,
 			    unsigned long irq_err,
 			    int tclk);
 
 void __init orion_ge10_init(struct mv643xx_eth_platform_data *eth_data,
-			    struct mbus_dram_target_info *mbus_dram_info,
 			    unsigned long mapbase,
 			    unsigned long irq,
 			    unsigned long irq_err,
 			    int tclk);
 
 void __init orion_ge11_init(struct mv643xx_eth_platform_data *eth_data,
-			    struct mbus_dram_target_info *mbus_dram_info,
 			    unsigned long mapbase,
 			    unsigned long irq,
 			    unsigned long irq_err,
@@ -82,8 +78,7 @@ void __init orion_spi_1_init(unsigned long mapbase,
 
 void __init orion_wdt_init(unsigned long tclk);
 
-void __init orion_xor0_init(struct mbus_dram_target_info *mbus_dram_info,
-			    unsigned long mapbase_low,
+void __init orion_xor0_init(unsigned long mapbase_low,
 			    unsigned long mapbase_high,
 			    unsigned long irq_0,
 			    unsigned long irq_1);
@@ -93,20 +88,16 @@ void __init orion_xor1_init(unsigned long mapbase_low,
 			    unsigned long irq_0,
 			    unsigned long irq_1);
 
-void __init orion_ehci_init(struct mbus_dram_target_info *mbus_dram_info,
-			    unsigned long mapbase,
+void __init orion_ehci_init(unsigned long mapbase,
 			    unsigned long irq);
 
-void __init orion_ehci_1_init(struct mbus_dram_target_info *mbus_dram_info,
-			      unsigned long mapbase,
+void __init orion_ehci_1_init(unsigned long mapbase,
 			      unsigned long irq);
 
-void __init orion_ehci_2_init(struct mbus_dram_target_info *mbus_dram_info,
-			      unsigned long mapbase,
+void __init orion_ehci_2_init(unsigned long mapbase,
 			      unsigned long irq);
 
 void __init orion_sata_init(struct mv_sata_platform_data *sata_data,
-			    struct mbus_dram_target_info *mbus_dram_info,
 			    unsigned long mapbase,
 			    unsigned long irq);
 
diff --git a/arch/arm/plat-orion/include/plat/ehci-orion.h b/arch/arm/plat-orion/include/plat/ehci-orion.h
index 4ec668e..6fc78e4 100644
--- a/arch/arm/plat-orion/include/plat/ehci-orion.h
+++ b/arch/arm/plat-orion/include/plat/ehci-orion.h
@@ -19,7 +19,6 @@ enum orion_ehci_phy_ver {
 };
 
 struct orion_ehci_data {
-	struct mbus_dram_target_info	*dram;
 	enum orion_ehci_phy_ver phy_version;
 };
 
diff --git a/arch/arm/plat-orion/include/plat/mv_xor.h b/arch/arm/plat-orion/include/plat/mv_xor.h
index bd5f3bd..2ba1f7d 100644
--- a/arch/arm/plat-orion/include/plat/mv_xor.h
+++ b/arch/arm/plat-orion/include/plat/mv_xor.h
@@ -13,12 +13,6 @@
 #define MV_XOR_SHARED_NAME	"mv_xor_shared"
 #define MV_XOR_NAME		"mv_xor"
 
-struct mbus_dram_target_info;
-
-struct mv_xor_platform_shared_data {
-	struct mbus_dram_target_info	*dram;
-};
-
 struct mv_xor_platform_data {
 	struct platform_device		*shared;
 	int				hw_id;
diff --git a/arch/arm/plat-orion/include/plat/mvsdio.h b/arch/arm/plat-orion/include/plat/mvsdio.h
index 14ca886..1190efe 100644
--- a/arch/arm/plat-orion/include/plat/mvsdio.h
+++ b/arch/arm/plat-orion/include/plat/mvsdio.h
@@ -12,7 +12,6 @@
 #include <linux/mbus.h>
 
 struct mvsdio_platform_data {
-	struct mbus_dram_target_info *dram;
 	unsigned int clock;
 	int gpio_card_detect;
 	int gpio_write_protect;
diff --git a/include/linux/ata_platform.h b/include/linux/ata_platform.h
index 9a26c83..b856a2a 100644
--- a/include/linux/ata_platform.h
+++ b/include/linux/ata_platform.h
@@ -27,10 +27,7 @@ extern int __devexit __pata_platform_remove(struct device *dev);
 /*
  * Marvell SATA private data
  */
-struct mbus_dram_target_info;
-
 struct mv_sata_platform_data {
-	struct mbus_dram_target_info	*dram;
 	int	n_ports; /* number of sata ports */
 };
 
-- 
1.7.2.5
