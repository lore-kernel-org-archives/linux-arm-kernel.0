From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 25 Jan 2011 16:26:04 +0100
Subject: [PATCH 4/4] mach-ux500: add MUSB to db5500 devices
Message-ID: <1295969164-12149-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mian Yousaf Kaukab <mian.yousaf.kaukab@stericsson.com>

- DMA tx and rx maps for usb channels are set to be configured at
  runtime
- MUSB is enabled with soc specific base address, irq and dma
  configurations

Signed-off-by: Mian Yousaf Kaukab <mian.yousaf.kaukab@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/cpu-db5500.c     |   25 +++++++++++++++++++++++++
 arch/arm/mach-ux500/devices-db5500.h |    3 +++
 arch/arm/mach-ux500/dma-db5500.c     |   16 ++++++++++++++++
 3 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db5500.c b/arch/arm/mach-ux500/cpu-db5500.c
index 38a01c3..c9dc2ef 100644
--- a/arch/arm/mach-ux500/cpu-db5500.c
+++ b/arch/arm/mach-ux500/cpu-db5500.c
@@ -19,8 +19,10 @@
 #include <mach/devices.h>
 #include <mach/setup.h>
 #include <mach/irqs.h>
+#include <mach/usb.h>
 
 #include "devices-db5500.h"
+#include "ste-dma40-db5500.h"
 
 static struct map_desc u5500_uart_io_desc[] __initdata = {
 	__IO_DEV_DESC(U5500_UART0_BASE, SZ_4K),
@@ -188,11 +190,34 @@ void __init u5500_map_io(void)
 	iotable_init(u5500_io_desc, ARRAY_SIZE(u5500_io_desc));
 }
 
+static int usb_db5500_rx_dma_cfg[] = {
+	DB5500_DMA_DEV4_USB_OTG_IEP_1_9,
+	DB5500_DMA_DEV5_USB_OTG_IEP_2_10,
+	DB5500_DMA_DEV6_USB_OTG_IEP_3_11,
+	DB5500_DMA_DEV20_USB_OTG_IEP_4_12,
+	DB5500_DMA_DEV21_USB_OTG_IEP_5_13,
+	DB5500_DMA_DEV22_USB_OTG_IEP_6_14,
+	DB5500_DMA_DEV23_USB_OTG_IEP_7_15,
+	DB5500_DMA_DEV38_USB_OTG_IEP_8
+};
+
+static int usb_db5500_tx_dma_cfg[] = {
+	DB5500_DMA_DEV4_USB_OTG_OEP_1_9,
+	DB5500_DMA_DEV5_USB_OTG_OEP_2_10,
+	DB5500_DMA_DEV6_USB_OTG_OEP_3_11,
+	DB5500_DMA_DEV20_USB_OTG_OEP_4_12,
+	DB5500_DMA_DEV21_USB_OTG_OEP_5_13,
+	DB5500_DMA_DEV22_USB_OTG_OEP_6_14,
+	DB5500_DMA_DEV23_USB_OTG_OEP_7_15,
+	DB5500_DMA_DEV38_USB_OTG_OEP_8
+};
+
 void __init u5500_init_devices(void)
 {
 	db5500_add_gpios();
 	db5500_dma_init();
 	db5500_add_rtc();
+	db5500_add_usb(usb_db5500_rx_dma_cfg, usb_db5500_tx_dma_cfg);
 
 	platform_add_devices(db5500_platform_devs,
 			     ARRAY_SIZE(db5500_platform_devs));
diff --git a/arch/arm/mach-ux500/devices-db5500.h b/arch/arm/mach-ux500/devices-db5500.h
index c8d7901..481ae5c 100644
--- a/arch/arm/mach-ux500/devices-db5500.h
+++ b/arch/arm/mach-ux500/devices-db5500.h
@@ -34,6 +34,9 @@
 #define db5500_add_rtc() \
 	dbx500_add_rtc(U5500_RTC_BASE, IRQ_DB5500_RTC);
 
+#define db5500_add_usb(rx_cfg, tx_cfg) \
+	ux500_add_usb(U5500_USBOTG_BASE, IRQ_DB5500_USBOTG, rx_cfg, tx_cfg)
+
 #define db5500_add_sdi0(pdata) \
 	dbx500_add_sdi("sdi0", U5500_SDI0_BASE, IRQ_DB5500_SDMMC0, pdata)
 #define db5500_add_sdi1(pdata) \
diff --git a/arch/arm/mach-ux500/dma-db5500.c b/arch/arm/mach-ux500/dma-db5500.c
index 32a061f..1cfab68 100644
--- a/arch/arm/mach-ux500/dma-db5500.c
+++ b/arch/arm/mach-ux500/dma-db5500.c
@@ -73,11 +73,27 @@ static struct stedma40_chan_cfg dma40_memcpy_conf_log = {
  */
 static const dma_addr_t dma40_rx_map[DB5500_DMA_NR_DEV] = {
 	[DB5500_DMA_DEV24_SDMMC0_RX] = -1,
+	[DB5500_DMA_DEV38_USB_OTG_IEP_8] = -1,
+	[DB5500_DMA_DEV23_USB_OTG_IEP_7_15] = -1,
+	[DB5500_DMA_DEV22_USB_OTG_IEP_6_14] = -1,
+	[DB5500_DMA_DEV21_USB_OTG_IEP_5_13] = -1,
+	[DB5500_DMA_DEV20_USB_OTG_IEP_4_12] = -1,
+	[DB5500_DMA_DEV6_USB_OTG_IEP_3_11] = -1,
+	[DB5500_DMA_DEV5_USB_OTG_IEP_2_10] = -1,
+	[DB5500_DMA_DEV4_USB_OTG_IEP_1_9] = -1,
 };
 
 /* Mapping between destination event lines and physical device address */
 static const dma_addr_t dma40_tx_map[DB5500_DMA_NR_DEV] = {
 	[DB5500_DMA_DEV24_SDMMC0_TX] = -1,
+	[DB5500_DMA_DEV38_USB_OTG_OEP_8] = -1,
+	[DB5500_DMA_DEV23_USB_OTG_OEP_7_15] = -1,
+	[DB5500_DMA_DEV22_USB_OTG_OEP_6_14] = -1,
+	[DB5500_DMA_DEV21_USB_OTG_OEP_5_13] = -1,
+	[DB5500_DMA_DEV20_USB_OTG_OEP_4_12] = -1,
+	[DB5500_DMA_DEV6_USB_OTG_OEP_3_11] = -1,
+	[DB5500_DMA_DEV5_USB_OTG_OEP_2_10] = -1,
+	[DB5500_DMA_DEV4_USB_OTG_OEP_1_9] = -1,
 };
 
 static int dma40_memcpy_event[] = {
-- 
1.7.3.2
