From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 3 Feb 2011 17:55:02 +0100
Subject: [PATCH 2/2] mach-ux500: config Ux500 PL011 PL022 PL180 for DMA
Message-ID: <1296752102-16665-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will configure the platform data for the PL011, PL022
and PL180 (derivate) PrimeCells found in the Ux500 to use DMA
with the generic DMA engine for DMA40.

Signed-off-by: Per Forlin <per.forlin@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500-sdi.c |   77 ++++++++++++++++++
 arch/arm/mach-ux500/board-mop500.c     |  135 ++++++++++++++++++++++++++++---
 arch/arm/mach-ux500/board-u5500-sdi.c  |   25 ++++++
 arch/arm/mach-ux500/board-u5500.c      |    6 +-
 arch/arm/mach-ux500/devices-common.h   |    7 +-
 arch/arm/mach-ux500/devices-db5500.h   |   16 ++--
 arch/arm/mach-ux500/devices-db8500.c   |   43 ++++++++++-
 arch/arm/mach-ux500/devices-db8500.h   |   12 ++--
 8 files changed, 288 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index 4ba3d93..d1ae6a0 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -13,12 +13,14 @@
 #include <linux/platform_device.h>
 
 #include <plat/pincfg.h>
+#include <plat/ste_dma40.h>
 #include <mach/devices.h>
 #include <mach/hardware.h>
 
 #include "devices-db8500.h"
 #include "pins-db8500.h"
 #include "board-mop500.h"
+#include "ste-dma40-db8500.h"
 
 static pin_cfg_t mop500_sdi_pins[] = {
 	/* SDI0 (MicroSD slot) */
@@ -86,6 +88,26 @@ static u32 mop500_sdi0_vdd_handler(struct device *dev, unsigned int vdd,
 	       MCI_DATA2DIREN | MCI_DATA31DIREN;
 }
 
+#ifdef CONFIG_STE_DMA40
+struct stedma40_chan_cfg mop500_sdi0_dma_cfg_rx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_PERIPH_TO_MEM,
+	.src_dev_type = DB8500_DMA_DEV29_SD_MM0_RX,
+	.dst_dev_type = STEDMA40_DEV_DST_MEMORY,
+	.src_info.data_width = STEDMA40_WORD_WIDTH,
+	.dst_info.data_width = STEDMA40_WORD_WIDTH,
+};
+
+static struct stedma40_chan_cfg mop500_sdi0_dma_cfg_tx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_MEM_TO_PERIPH,
+	.src_dev_type = STEDMA40_DEV_SRC_MEMORY,
+	.dst_dev_type = DB8500_DMA_DEV29_SD_MM0_TX,
+	.src_info.data_width = STEDMA40_WORD_WIDTH,
+	.dst_info.data_width = STEDMA40_WORD_WIDTH,
+};
+#endif
+
 static struct mmci_platform_data mop500_sdi0_data = {
 	.vdd_handler	= mop500_sdi0_vdd_handler,
 	.ocr_mask	= MMC_VDD_29_30,
@@ -93,6 +115,11 @@ static struct mmci_platform_data mop500_sdi0_data = {
 	.capabilities	= MMC_CAP_4_BIT_DATA,
 	.gpio_cd	= GPIO_SDMMC_CD,
 	.gpio_wp	= -1,
+#ifdef CONFIG_STE_DMA40
+	.dma_filter	= stedma40_filter,
+	.dma_rx_param	= &mop500_sdi0_dma_cfg_rx,
+	.dma_tx_param	= &mop500_sdi0_dma_cfg_tx,
+#endif
 };
 
 void mop500_sdi_tc35892_init(void)
@@ -116,18 +143,63 @@ void mop500_sdi_tc35892_init(void)
  * SDI 2 (POP eMMC, not on DB8500ed)
  */
 
+#ifdef CONFIG_STE_DMA40
+struct stedma40_chan_cfg mop500_sdi2_dma_cfg_rx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_PERIPH_TO_MEM,
+	.src_dev_type =  DB8500_DMA_DEV28_SD_MM2_RX,
+	.dst_dev_type = STEDMA40_DEV_DST_MEMORY,
+	.src_info.data_width = STEDMA40_WORD_WIDTH,
+	.dst_info.data_width = STEDMA40_WORD_WIDTH,
+};
+
+static struct stedma40_chan_cfg mop500_sdi2_dma_cfg_tx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_MEM_TO_PERIPH,
+	.src_dev_type = STEDMA40_DEV_SRC_MEMORY,
+	.dst_dev_type = DB8500_DMA_DEV28_SD_MM2_TX,
+	.src_info.data_width = STEDMA40_WORD_WIDTH,
+	.dst_info.data_width = STEDMA40_WORD_WIDTH,
+};
+#endif
+
 static struct mmci_platform_data mop500_sdi2_data = {
 	.ocr_mask	= MMC_VDD_165_195,
 	.f_max		= 100000000,
 	.capabilities	= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 	.gpio_cd	= -1,
 	.gpio_wp	= -1,
+#ifdef CONFIG_STE_DMA40
+	.dma_filter	= stedma40_filter,
+	.dma_rx_param	= &mop500_sdi2_dma_cfg_rx,
+	.dma_tx_param	= &mop500_sdi2_dma_cfg_tx,
+#endif
 };
 
 /*
  * SDI 4 (on-board eMMC)
  */
 
+#ifdef CONFIG_STE_DMA40
+struct stedma40_chan_cfg mop500_sdi4_dma_cfg_rx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_PERIPH_TO_MEM,
+	.src_dev_type =  DB8500_DMA_DEV42_SD_MM4_RX,
+	.dst_dev_type = STEDMA40_DEV_DST_MEMORY,
+	.src_info.data_width = STEDMA40_WORD_WIDTH,
+	.dst_info.data_width = STEDMA40_WORD_WIDTH,
+};
+
+static struct stedma40_chan_cfg mop500_sdi4_dma_cfg_tx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_MEM_TO_PERIPH,
+	.src_dev_type = STEDMA40_DEV_SRC_MEMORY,
+	.dst_dev_type = DB8500_DMA_DEV42_SD_MM4_TX,
+	.src_info.data_width = STEDMA40_WORD_WIDTH,
+	.dst_info.data_width = STEDMA40_WORD_WIDTH,
+};
+#endif
+
 static struct mmci_platform_data mop500_sdi4_data = {
 	.ocr_mask	= MMC_VDD_29_30,
 	.f_max		= 100000000,
@@ -135,6 +207,11 @@ static struct mmci_platform_data mop500_sdi4_data = {
 			  MMC_CAP_MMC_HIGHSPEED,
 	.gpio_cd	= -1,
 	.gpio_wp	= -1,
+#ifdef CONFIG_STE_DMA40
+	.dma_filter	= stedma40_filter,
+	.dma_rx_param	= &mop500_sdi4_dma_cfg_rx,
+	.dma_tx_param	= &mop500_sdi4_dma_cfg_tx,
+#endif
 };
 
 void __init mop500_sdi_init(void)
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 5babce4..67d9c63 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -17,6 +17,7 @@
 #include <linux/gpio.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/pl022.h>
+#include <linux/amba/serial.h>
 #include <linux/spi/spi.h>
 #include <linux/mfd/ab8500.h>
 #include <linux/mfd/tc3589x.h>
@@ -29,12 +30,14 @@
 
 #include <plat/pincfg.h>
 #include <plat/i2c.h>
+#include <plat/ste_dma40.h>
 
 #include <mach/hardware.h>
 #include <mach/setup.h>
 #include <mach/devices.h>
 #include <mach/irqs.h>
 
+#include "ste-dma40-db8500.h"
 #include "devices-db8500.h"
 #include "pins-db8500.h"
 #include "board-mop500.h"
@@ -123,16 +126,6 @@ struct platform_device ab8500_device = {
 	.resource = ab8500_resources,
 };
 
-static struct pl022_ssp_controller ssp0_platform_data = {
-	.bus_id = 0,
-	/* pl022 not yet supports dma */
-	.enable_dma = 0,
-	/* on this platform, gpio 31,142,144,214 &
-	 * 224 are connected as chip selects
-	 */
-	.num_chipselect = 5,
-};
-
 /*
  * TC35892
  */
@@ -319,16 +312,132 @@ static struct platform_device *platform_devs[] __initdata = {
 	&mop500_gpio_keys_device,
 };
 
+#ifdef CONFIG_STE_DMA40
+static struct stedma40_chan_cfg ssp0_dma_cfg_rx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_PERIPH_TO_MEM,
+	.src_dev_type =  DB8500_DMA_DEV8_SSP0_RX,
+	.dst_dev_type = STEDMA40_DEV_DST_MEMORY,
+	.src_info.data_width = STEDMA40_BYTE_WIDTH,
+	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
+};
+
+static struct stedma40_chan_cfg ssp0_dma_cfg_tx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_MEM_TO_PERIPH,
+	.src_dev_type = STEDMA40_DEV_SRC_MEMORY,
+	.dst_dev_type = DB8500_DMA_DEV8_SSP0_TX,
+	.src_info.data_width = STEDMA40_BYTE_WIDTH,
+	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
+};
+#endif
+
+static struct pl022_ssp_controller ssp0_platform_data = {
+	.bus_id = 0,
+#ifdef CONFIG_STE_DMA40
+	.enable_dma = 1,
+	.dma_filter = stedma40_filter,
+	.dma_rx_param = &ssp0_dma_cfg_rx,
+	.dma_tx_param = &ssp0_dma_cfg_tx,
+#else
+	.enable_dma = 0,
+#endif
+	/* on this platform, gpio 31,142,144,214 &
+	 * 224 are connected as chip selects
+	 */
+	.num_chipselect = 5,
+};
+
 static void __init mop500_spi_init(void)
 {
 	db8500_add_ssp0(&ssp0_platform_data);
 }
 
+#ifdef CONFIG_STE_DMA40
+static struct stedma40_chan_cfg uart0_dma_cfg_rx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_PERIPH_TO_MEM,
+	.src_dev_type =  DB8500_DMA_DEV13_UART0_RX,
+	.dst_dev_type = STEDMA40_DEV_DST_MEMORY,
+	.src_info.data_width = STEDMA40_BYTE_WIDTH,
+	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
+};
+
+static struct stedma40_chan_cfg uart0_dma_cfg_tx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_MEM_TO_PERIPH,
+	.src_dev_type = STEDMA40_DEV_SRC_MEMORY,
+	.dst_dev_type = DB8500_DMA_DEV13_UART0_TX,
+	.src_info.data_width = STEDMA40_BYTE_WIDTH,
+	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
+};
+
+static struct stedma40_chan_cfg uart1_dma_cfg_rx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_PERIPH_TO_MEM,
+	.src_dev_type =  DB8500_DMA_DEV12_UART1_RX,
+	.dst_dev_type = STEDMA40_DEV_DST_MEMORY,
+	.src_info.data_width = STEDMA40_BYTE_WIDTH,
+	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
+};
+
+static struct stedma40_chan_cfg uart1_dma_cfg_tx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_MEM_TO_PERIPH,
+	.src_dev_type = STEDMA40_DEV_SRC_MEMORY,
+	.dst_dev_type = DB8500_DMA_DEV12_UART1_TX,
+	.src_info.data_width = STEDMA40_BYTE_WIDTH,
+	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
+};
+
+static struct stedma40_chan_cfg uart2_dma_cfg_rx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_PERIPH_TO_MEM,
+	.src_dev_type =  DB8500_DMA_DEV11_UART2_RX,
+	.dst_dev_type = STEDMA40_DEV_DST_MEMORY,
+	.src_info.data_width = STEDMA40_BYTE_WIDTH,
+	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
+};
+
+static struct stedma40_chan_cfg uart2_dma_cfg_tx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_MEM_TO_PERIPH,
+	.src_dev_type = STEDMA40_DEV_SRC_MEMORY,
+	.dst_dev_type = DB8500_DMA_DEV11_UART2_TX,
+	.src_info.data_width = STEDMA40_BYTE_WIDTH,
+	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
+};
+#endif
+
+static struct amba_pl011_data uart0_plat = {
+#ifdef CONFIG_STE_DMA40
+	.dma_filter = stedma40_filter,
+	.dma_rx_param = &uart0_dma_cfg_rx,
+	.dma_tx_param = &uart0_dma_cfg_tx,
+#endif
+};
+
+static struct amba_pl011_data uart1_plat = {
+#ifdef CONFIG_STE_DMA40
+	.dma_filter = stedma40_filter,
+	.dma_rx_param = &uart1_dma_cfg_rx,
+	.dma_tx_param = &uart1_dma_cfg_tx,
+#endif
+};
+
+static struct amba_pl011_data uart2_plat = {
+#ifdef CONFIG_STE_DMA40
+	.dma_filter = stedma40_filter,
+	.dma_rx_param = &uart2_dma_cfg_rx,
+	.dma_tx_param = &uart2_dma_cfg_tx,
+#endif
+};
+
 static void __init mop500_uart_init(void)
 {
-	db8500_add_uart0();
-	db8500_add_uart1();
-	db8500_add_uart2();
+	db8500_add_uart0(&uart0_plat);
+	db8500_add_uart1(&uart1_plat);
+	db8500_add_uart2(&uart2_plat);
 }
 
 static void __init u8500_init_machine(void)
diff --git a/arch/arm/mach-ux500/board-u5500-sdi.c b/arch/arm/mach-ux500/board-u5500-sdi.c
index 54712ac..739fb4c 100644
--- a/arch/arm/mach-ux500/board-u5500-sdi.c
+++ b/arch/arm/mach-ux500/board-u5500-sdi.c
@@ -31,6 +31,26 @@ static pin_cfg_t u5500_sdi_pins[] = {
 	GPIO14_MC0_CLK		| PIN_DIR_OUTPUT | PIN_VAL_LOW,
 };
 
+#ifdef CONFIG_STE_DMA40
+struct stedma40_chan_cfg u5500_sdi0_dma_cfg_rx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_PERIPH_TO_MEM,
+	.src_dev_type = DB5500_DMA_DEV24_SDMMC0_RX,
+	.dst_dev_type = STEDMA40_DEV_DST_MEMORY,
+	.src_info.data_width = STEDMA40_WORD_WIDTH,
+	.dst_info.data_width = STEDMA40_WORD_WIDTH,
+};
+
+static struct stedma40_chan_cfg u5500_sdi0_dma_cfg_tx = {
+	.mode = STEDMA40_MODE_LOGICAL,
+	.dir = STEDMA40_MEM_TO_PERIPH,
+	.src_dev_type = STEDMA40_DEV_SRC_MEMORY,
+	.dst_dev_type = DB5500_DMA_DEV24_SDMMC0_TX,
+	.src_info.data_width = STEDMA40_WORD_WIDTH,
+	.dst_info.data_width = STEDMA40_WORD_WIDTH,
+};
+#endif
+
 static struct mmci_platform_data u5500_sdi0_data = {
 	.ocr_mask	= MMC_VDD_165_195,
 	.f_max		= 50000000,
@@ -39,6 +59,11 @@ static struct mmci_platform_data u5500_sdi0_data = {
 				MMC_CAP_MMC_HIGHSPEED,
 	.gpio_cd	= -1,
 	.gpio_wp	= -1,
+#ifdef CONFIG_STE_DMA40
+	.dma_filter	= stedma40_filter,
+	.dma_rx_param	= &u5500_sdi0_dma_cfg_rx,
+	.dma_tx_param	= &u5500_sdi0_dma_cfg_tx,
+#endif
 };
 
 void __init u5500_sdi_init(void)
diff --git a/arch/arm/mach-ux500/board-u5500.c b/arch/arm/mach-ux500/board-u5500.c
index 39d370c..44fd3b5 100644
--- a/arch/arm/mach-ux500/board-u5500.c
+++ b/arch/arm/mach-ux500/board-u5500.c
@@ -22,9 +22,9 @@
 
 static void __init u5500_uart_init(void)
 {
-	db5500_add_uart0();
-	db5500_add_uart1();
-	db5500_add_uart2();
+	db5500_add_uart0(NULL);
+	db5500_add_uart1(NULL);
+	db5500_add_uart2(NULL);
 }
 
 static void __init u5500_init_machine(void)
diff --git a/arch/arm/mach-ux500/devices-common.h b/arch/arm/mach-ux500/devices-common.h
index cbadc11..c719b5a1 100644
--- a/arch/arm/mach-ux500/devices-common.h
+++ b/arch/arm/mach-ux500/devices-common.h
@@ -42,10 +42,13 @@ dbx500_add_sdi(const char *name, resource_size_t base, int irq,
 	return dbx500_add_amba_device(name, base, irq, pdata, 0);
 }
 
+struct amba_pl011_data;
+
 static inline struct amba_device *
-dbx500_add_uart(const char *name, resource_size_t base, int irq)
+dbx500_add_uart(const char *name, resource_size_t base, int irq,
+		struct amba_pl011_data *pdata)
 {
-	return dbx500_add_amba_device(name, base, irq, NULL, 0);
+	return dbx500_add_amba_device(name, base, irq, pdata, 0);
 }
 
 struct nmk_i2c_controller;
diff --git a/arch/arm/mach-ux500/devices-db5500.h b/arch/arm/mach-ux500/devices-db5500.h
index 481ae5c..94627f7 100644
--- a/arch/arm/mach-ux500/devices-db5500.h
+++ b/arch/arm/mach-ux500/devices-db5500.h
@@ -57,13 +57,13 @@
 #define db5500_add_spi3(pdata) \
 	dbx500_add_spi("spi3", U5500_SPI3_BASE, IRQ_DB5500_SPI3, pdata)
 
-#define db5500_add_uart0() \
-	dbx500_add_uart("uart0", U5500_UART0_BASE, IRQ_DB5500_UART0)
-#define db5500_add_uart1() \
-	dbx500_add_uart("uart1", U5500_UART1_BASE, IRQ_DB5500_UART1)
-#define db5500_add_uart2() \
-	dbx500_add_uart("uart2", U5500_UART2_BASE, IRQ_DB5500_UART2)
-#define db5500_add_uart3() \
-	dbx500_add_uart("uart3", U5500_UART3_BASE, IRQ_DB5500_UART3)
+#define db5500_add_uart0(plat) \
+	dbx500_add_uart("uart0", U5500_UART0_BASE, IRQ_DB5500_UART0, plat)
+#define db5500_add_uart1(plat) \
+	dbx500_add_uart("uart1", U5500_UART1_BASE, IRQ_DB5500_UART1, plat)
+#define db5500_add_uart2(plat) \
+	dbx500_add_uart("uart2", U5500_UART2_BASE, IRQ_DB5500_UART2, plat)
+#define db5500_add_uart3(plat) \
+	dbx500_add_uart("uart3", U5500_UART3_BASE, IRQ_DB5500_UART3, plat)
 
 #endif
diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
index f122d4e..73b1740 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/amba/bus.h>
+#include <linux/amba/pl022.h>
 
 #include <plat/ste_dma40.h>
 
@@ -67,7 +68,9 @@ struct stedma40_chan_cfg dma40_memcpy_conf_log = {
 
 /*
  * Mapping between destination event lines and physical device address.
- * The event line is tied to a device and therefor the address is constant.
+ * The event line is tied to a device and therefore the address is constant.
+ * When the address comes from a primecell it will be configured in runtime
+ * and we set the address to -1 as a placeholder.
  */
 static const dma_addr_t dma40_tx_map[DB8500_DMA_NR_DEV] = {
 	/* MUSB - these will be runtime-reconfigured */
@@ -79,6 +82,25 @@ static const dma_addr_t dma40_tx_map[DB8500_DMA_NR_DEV] = {
 	[DB8500_DMA_DEV36_USB_OTG_OEP_3_11] = -1,
 	[DB8500_DMA_DEV37_USB_OTG_OEP_2_10] = -1,
 	[DB8500_DMA_DEV38_USB_OTG_OEP_1_9] = -1,
+	/* PrimeCells - run-time configured */
+	[DB8500_DMA_DEV0_SPI0_TX] = -1,
+	[DB8500_DMA_DEV1_SD_MMC0_TX] = -1,
+	[DB8500_DMA_DEV2_SD_MMC1_TX] = -1,
+	[DB8500_DMA_DEV3_SD_MMC2_TX] = -1,
+	[DB8500_DMA_DEV8_SSP0_TX] = -1,
+	[DB8500_DMA_DEV9_SSP1_TX] = -1,
+	[DB8500_DMA_DEV11_UART2_TX] = -1,
+	[DB8500_DMA_DEV12_UART1_TX] = -1,
+	[DB8500_DMA_DEV13_UART0_TX] = -1,
+	[DB8500_DMA_DEV28_SD_MM2_TX] = -1,
+	[DB8500_DMA_DEV29_SD_MM0_TX] = -1,
+	[DB8500_DMA_DEV32_SD_MM1_TX] = -1,
+	[DB8500_DMA_DEV33_SPI2_TX] = -1,
+	[DB8500_DMA_DEV35_SPI1_TX] = -1,
+	[DB8500_DMA_DEV40_SPI3_TX] = -1,
+	[DB8500_DMA_DEV41_SD_MM3_TX] = -1,
+	[DB8500_DMA_DEV42_SD_MM4_TX] = -1,
+	[DB8500_DMA_DEV43_SD_MM5_TX] = -1,
 };
 
 /* Mapping between source event lines and physical device address */
@@ -92,6 +114,25 @@ static const dma_addr_t dma40_rx_map[DB8500_DMA_NR_DEV] = {
 	[DB8500_DMA_DEV36_USB_OTG_IEP_3_11] = -1,
 	[DB8500_DMA_DEV37_USB_OTG_IEP_2_10] = -1,
 	[DB8500_DMA_DEV38_USB_OTG_IEP_1_9] = -1,
+	/* PrimeCells */
+	[DB8500_DMA_DEV0_SPI0_RX] = -1,
+	[DB8500_DMA_DEV1_SD_MMC0_RX] = -1,
+	[DB8500_DMA_DEV2_SD_MMC1_RX] = -1,
+	[DB8500_DMA_DEV3_SD_MMC2_RX] = -1,
+	[DB8500_DMA_DEV8_SSP0_RX] = -1,
+	[DB8500_DMA_DEV9_SSP1_RX] = -1,
+	[DB8500_DMA_DEV11_UART2_RX] = -1,
+	[DB8500_DMA_DEV12_UART1_RX] = -1,
+	[DB8500_DMA_DEV13_UART0_RX] = -1,
+	[DB8500_DMA_DEV28_SD_MM2_RX] = -1,
+	[DB8500_DMA_DEV29_SD_MM0_RX] = -1,
+	[DB8500_DMA_DEV32_SD_MM1_RX] = -1,
+	[DB8500_DMA_DEV33_SPI2_RX] = -1,
+	[DB8500_DMA_DEV35_SPI1_RX] = -1,
+	[DB8500_DMA_DEV40_SPI3_RX] = -1,
+	[DB8500_DMA_DEV41_SD_MM3_RX] = -1,
+	[DB8500_DMA_DEV42_SD_MM4_RX] = -1,
+	[DB8500_DMA_DEV43_SD_MM5_RX] = -1,
 };
 
 /* Reserved event lines for memcpy only */
diff --git a/arch/arm/mach-ux500/devices-db8500.h b/arch/arm/mach-ux500/devices-db8500.h
index d1ea4bd..9cc6f8f 100644
--- a/arch/arm/mach-ux500/devices-db8500.h
+++ b/arch/arm/mach-ux500/devices-db8500.h
@@ -91,11 +91,11 @@ db8500_add_ssp(const char *name, resource_size_t base, int irq,
 #define db8500_add_spi3(pdata) \
 	dbx500_add_spi("spi3", U8500_SPI3_BASE, IRQ_DB8500_SPI3, pdata)
 
-#define db8500_add_uart0() \
-	dbx500_add_uart("uart0", U8500_UART0_BASE, IRQ_DB8500_UART0)
-#define db8500_add_uart1() \
-	dbx500_add_uart("uart1", U8500_UART1_BASE, IRQ_DB8500_UART1)
-#define db8500_add_uart2() \
-	dbx500_add_uart("uart2", U8500_UART2_BASE, IRQ_DB8500_UART2)
+#define db8500_add_uart0(pdata) \
+	dbx500_add_uart("uart0", U8500_UART0_BASE, IRQ_DB8500_UART0, pdata)
+#define db8500_add_uart1(pdata) \
+	dbx500_add_uart("uart1", U8500_UART1_BASE, IRQ_DB8500_UART1, pdata)
+#define db8500_add_uart2(pdata) \
+	dbx500_add_uart("uart2", U8500_UART2_BASE, IRQ_DB8500_UART2, pdata)
 
 #endif
-- 
1.7.3.2
