From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 25 Jan 2011 16:25:56 +0100
Subject: [PATCH 3/4] mach-ux500: add MUSB to db8500 devices
Message-ID: <1295969156-12109-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mian Yousaf Kaukab <mian.yousaf.kaukab@stericsson.com>

- DMA tx and rx maps for usb channels are set to be configured at
  runtime
- GPIO configurations for usb are added
- MUSB is enabled with soc specific base address, irq and dma
  configurations

Signed-off-by: Mian Yousaf Kaukab <mian.yousaf.kaukab@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500.c   |   14 ++++++++++++++
 arch/arm/mach-ux500/cpu-db8500.c     |   25 +++++++++++++++++++++++++
 arch/arm/mach-ux500/devices-db8500.c |   24 ++++++++++++++++++++++--
 arch/arm/mach-ux500/devices-db8500.h |    3 +++
 4 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index ffe3cf1..5babce4 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -83,6 +83,20 @@ static pin_cfg_t mop500_pins[] = {
 
 	/* touch screen */
 	GPIO84_GPIO	| PIN_INPUT_PULLUP,
+
+	/* USB OTG */
+	GPIO256_USB_NXT		| PIN_PULL_DOWN,
+	GPIO257_USB_STP		| PIN_PULL_UP,
+	GPIO258_USB_XCLK	| PIN_PULL_DOWN,
+	GPIO259_USB_DIR		| PIN_PULL_DOWN,
+	GPIO260_USB_DAT7	| PIN_PULL_DOWN,
+	GPIO261_USB_DAT6	| PIN_PULL_DOWN,
+	GPIO262_USB_DAT5	| PIN_PULL_DOWN,
+	GPIO263_USB_DAT4	| PIN_PULL_DOWN,
+	GPIO264_USB_DAT3	| PIN_PULL_DOWN,
+	GPIO265_USB_DAT2	| PIN_PULL_DOWN,
+	GPIO266_USB_DAT1	| PIN_PULL_DOWN,
+	GPIO267_USB_DAT0	| PIN_PULL_DOWN,
 };
 
 static struct ab8500_platform_data ab8500_platdata = {
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 1748fbc..706bc95 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -21,8 +21,10 @@
 #include <mach/hardware.h>
 #include <mach/setup.h>
 #include <mach/devices.h>
+#include <mach/usb.h>
 
 #include "devices-db8500.h"
+#include "ste-dma40-db8500.h"
 
 static struct platform_device *platform_devs[] __initdata = {
 	&u8500_dma40_device,
@@ -111,6 +113,28 @@ static void __init db8500_add_gpios(void)
 			 IRQ_DB8500_GPIO0, &pdata);
 }
 
+static int usb_db8500_rx_dma_cfg[] = {
+	DB8500_DMA_DEV38_USB_OTG_IEP_1_9,
+	DB8500_DMA_DEV37_USB_OTG_IEP_2_10,
+	DB8500_DMA_DEV36_USB_OTG_IEP_3_11,
+	DB8500_DMA_DEV19_USB_OTG_IEP_4_12,
+	DB8500_DMA_DEV18_USB_OTG_IEP_5_13,
+	DB8500_DMA_DEV17_USB_OTG_IEP_6_14,
+	DB8500_DMA_DEV16_USB_OTG_IEP_7_15,
+	DB8500_DMA_DEV39_USB_OTG_IEP_8
+};
+
+static int usb_db8500_tx_dma_cfg[] = {
+	DB8500_DMA_DEV38_USB_OTG_OEP_1_9,
+	DB8500_DMA_DEV37_USB_OTG_OEP_2_10,
+	DB8500_DMA_DEV36_USB_OTG_OEP_3_11,
+	DB8500_DMA_DEV19_USB_OTG_OEP_4_12,
+	DB8500_DMA_DEV18_USB_OTG_OEP_5_13,
+	DB8500_DMA_DEV17_USB_OTG_OEP_6_14,
+	DB8500_DMA_DEV16_USB_OTG_OEP_7_15,
+	DB8500_DMA_DEV39_USB_OTG_OEP_8
+};
+
 /*
  * This function is called from the board init
  */
@@ -121,6 +145,7 @@ void __init u8500_init_devices(void)
 
 	db8500_add_rtc();
 	db8500_add_gpios();
+	db8500_add_usb(usb_db8500_rx_dma_cfg, usb_db8500_tx_dma_cfg);
 
 	platform_device_register_simple("cpufreq-u8500", -1, NULL, 0);
 	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
index 23c695d5..f122d4e 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -69,10 +69,30 @@ struct stedma40_chan_cfg dma40_memcpy_conf_log = {
  * Mapping between destination event lines and physical device address.
  * The event line is tied to a device and therefor the address is constant.
  */
-static const dma_addr_t dma40_tx_map[DB8500_DMA_NR_DEV];
+static const dma_addr_t dma40_tx_map[DB8500_DMA_NR_DEV] = {
+	/* MUSB - these will be runtime-reconfigured */
+	[DB8500_DMA_DEV39_USB_OTG_OEP_8] = -1,
+	[DB8500_DMA_DEV16_USB_OTG_OEP_7_15] = -1,
+	[DB8500_DMA_DEV17_USB_OTG_OEP_6_14] = -1,
+	[DB8500_DMA_DEV18_USB_OTG_OEP_5_13] = -1,
+	[DB8500_DMA_DEV19_USB_OTG_OEP_4_12] = -1,
+	[DB8500_DMA_DEV36_USB_OTG_OEP_3_11] = -1,
+	[DB8500_DMA_DEV37_USB_OTG_OEP_2_10] = -1,
+	[DB8500_DMA_DEV38_USB_OTG_OEP_1_9] = -1,
+};
 
 /* Mapping between source event lines and physical device address */
-static const dma_addr_t dma40_rx_map[DB8500_DMA_NR_DEV];
+static const dma_addr_t dma40_rx_map[DB8500_DMA_NR_DEV] = {
+	/* MUSB - these will be runtime-reconfigured */
+	[DB8500_DMA_DEV39_USB_OTG_IEP_8] = -1,
+	[DB8500_DMA_DEV16_USB_OTG_IEP_7_15] = -1,
+	[DB8500_DMA_DEV17_USB_OTG_IEP_6_14] = -1,
+	[DB8500_DMA_DEV18_USB_OTG_IEP_5_13] = -1,
+	[DB8500_DMA_DEV19_USB_OTG_IEP_4_12] = -1,
+	[DB8500_DMA_DEV36_USB_OTG_IEP_3_11] = -1,
+	[DB8500_DMA_DEV37_USB_OTG_IEP_2_10] = -1,
+	[DB8500_DMA_DEV38_USB_OTG_IEP_1_9] = -1,
+};
 
 /* Reserved event lines for memcpy only */
 static int dma40_memcpy_event[] = {
diff --git a/arch/arm/mach-ux500/devices-db8500.h b/arch/arm/mach-ux500/devices-db8500.h
index 3a770c7..d1ea4bd 100644
--- a/arch/arm/mach-ux500/devices-db8500.h
+++ b/arch/arm/mach-ux500/devices-db8500.h
@@ -61,6 +61,9 @@ db8500_add_ssp(const char *name, resource_size_t base, int irq,
 #define db8500_add_rtc() \
 	dbx500_add_rtc(U8500_RTC_BASE, IRQ_DB8500_RTC);
 
+#define db8500_add_usb(rx_cfg, tx_cfg) \
+	ux500_add_usb(U8500_USBOTG_BASE, IRQ_DB8500_USBOTG, rx_cfg, tx_cfg)
+
 #define db8500_add_sdi0(pdata) \
 	dbx500_add_sdi("sdi0", U8500_SDI0_BASE, IRQ_DB8500_SDMMC0, pdata)
 #define db8500_add_sdi1(pdata) \
-- 
1.7.3.2
