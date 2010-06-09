From: jason.mcmullan@netronome.com (Jason S. McMullan)
Date: Wed,  9 Jun 2010 10:35:38 -0400
Subject: [PATCH] [kirkwood-otg] Leverage the Freescale OTG driver for Kirkwood
	OTG
In-Reply-To: <1276094138-13497-1-git-send-email-jason.mcmullan@netronome.com>
References: <1276094138-13497-1-git-send-email-jason.mcmullan@netronome.com>
Message-ID: <1276094138-13497-2-git-send-email-jason.mcmullan@netronome.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Freescale USB Gadget driver is based off of the
same USB OTG core that is used in the Kirkwood.

NOTE: Your bootloader must ensure that the Kirkwood
      USB 2.0 Bridge Window registers are set correctly,
      or the driver will stall on the first DMA.

Signed-off-by: Jason S. McMullan <jason.mcmullan@netronome.com>
---
 arch/arm/mach-kirkwood/common.c |   34 +++++++++++++++++++++++++++++-----
 arch/arm/mach-kirkwood/common.h |    1 +
 drivers/usb/gadget/Kconfig      |    2 +-
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 6072eaa..a1aef59 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -18,6 +18,7 @@
 #include <linux/ata_platform.h>
 #include <linux/mtd/nand.h>
 #include <linux/spi/orion_spi.h>
+#include <linux/fsl_devices.h>
 #include <net/dsa.h>
 #include <asm/page.h>
 #include <asm/timex.h>
@@ -63,7 +64,6 @@ void __init kirkwood_map_io(void)
  */
 unsigned int kirkwood_clk_ctrl = CGC_DUNIT | CGC_RESERVED;
 	
-
 /*****************************************************************************
  * EHCI
  ****************************************************************************/
@@ -78,7 +78,7 @@ static u64 ehci_dmamask = 0xffffffffUL;
 /*****************************************************************************
  * EHCI0
  ****************************************************************************/
-static struct resource kirkwood_ehci_resources[] = {
+static struct resource kirkwood_usb_resources[] = {
 	{
 		.start	= USB_PHYS_BASE,
 		.end	= USB_PHYS_BASE + 0x0fff,
@@ -98,8 +98,8 @@ static struct platform_device kirkwood_ehci = {
 		.coherent_dma_mask	= 0xffffffff,
 		.platform_data		= &kirkwood_ehci_data,
 	},
-	.resource	= kirkwood_ehci_resources,
-	.num_resources	= ARRAY_SIZE(kirkwood_ehci_resources),
+	.resource	= kirkwood_usb_resources,
+	.num_resources	= ARRAY_SIZE(kirkwood_usb_resources),
 };
 
 void __init kirkwood_ehci_init(void)
@@ -108,6 +108,31 @@ void __init kirkwood_ehci_init(void)
 	platform_device_register(&kirkwood_ehci);
 }
 
+static struct fsl_usb2_platform_data kirkwood_otg_data = {
+	.operating_mode = FSL_USB2_DR_DEVICE,
+	.phy_mode       = FSL_USB2_PHY_UTMI,
+};
+
+static u64 otg_dmamask = DMA_BIT_MASK(32);
+
+/* OTG gadget device */
+struct platform_device kirkwood_otg = {
+	.name		= "fsl-usb2-udc",
+	.id		= -1,
+	.dev		= {
+		.dma_mask		= &otg_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &kirkwood_otg_data,
+	},
+	.resource	= kirkwood_usb_resources,
+	.num_resources	= ARRAY_SIZE(kirkwood_usb_resources),
+};
+
+void __init kirkwood_otg_init(void)
+{
+	kirkwood_clk_ctrl |= CGC_USB0;
+	platform_device_register(&kirkwood_otg);
+}
 
 /*****************************************************************************
  * GE00
@@ -568,7 +593,6 @@ void __init kirkwood_uart1_init(void)
 	platform_device_register(&kirkwood_uart1);
 }
 
-
 /*****************************************************************************
  * Cryptographic Engines and Security Accelerator (CESA)
  ****************************************************************************/
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index 05e8a8a..9bf400c 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -30,6 +30,7 @@ void kirkwood_setup_cpu_mbus(void);
 
 void kirkwood_pcie_id(u32 *dev, u32 *rev);
 
+void kirkwood_otg_init(void);
 void kirkwood_ehci_init(void);
 void kirkwood_ge00_init(struct mv643xx_eth_platform_data *eth_data);
 void kirkwood_ge01_init(struct mv643xx_eth_platform_data *eth_data);
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 591ae9f..aca3f7a 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -156,7 +156,7 @@ config USB_ATMEL_USBA
 
 config USB_GADGET_FSL_USB2
 	boolean "Freescale Highspeed USB DR Peripheral Controller"
-	depends on FSL_SOC || ARCH_MXC
+	depends on FSL_SOC || ARCH_MXC || ARCH_KIRKWOOD
 	select USB_GADGET_DUALSPEED
 	help
 	   Some of Freescale PowerPC processors have a High Speed
-- 
1.7.0.4
