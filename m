From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon,  8 Mar 2010 14:53:02 +0100
Subject: [PATCH 5/5] ARM: config U300 PL180 and PL011 for DMA
Message-ID: <1268056382-17697-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will configure the platform data for the PL180 and PL011
PrimeCells found in the U300 to use DMA with the generic PrimeCell
DMA engine.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-u300/core.c |  105 +++++++++++++++++++++++++++++++++++++++++++--
 arch/arm/mach-u300/mmc.c  |   13 +++++-
 2 files changed, 112 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 5f34eb6..6cd9c1a 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -3,7 +3,7 @@
  * arch/arm/mach-u300/core.c
  *
  *
- * Copyright (C) 2007-2010 ST-Ericsson AB
+ * Copyright (C) 2007-2010 ST-Ericsson SA
  * License terms: GNU General Public License (GPL) version 2
  * Core platform support, IRQ handling and device definitions.
  * Author: Linus Walleij <linus.walleij@stericsson.com>
@@ -16,7 +16,9 @@
 #include <linux/device.h>
 #include <linux/mm.h>
 #include <linux/termios.h>
+#include <linux/dmaengine.h>
 #include <linux/amba/bus.h>
+#include <linux/amba/serial.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <mach/coh901318.h>
@@ -92,10 +94,20 @@ void __init u300_map_io(void)
  * Declaration of devices found on the U300 board and
  * their respective memory locations.
  */
+
+static struct amba_pl011_data uart0_plat_data = {
+#ifdef CONFIG_COH901318
+	.dma_filter = coh901318_filter_id,
+	.dma_rx_param = (void *) U300_DMA_UART0_RX,
+	.dma_tx_param = (void *) U300_DMA_UART0_TX,
+#endif
+};
+
 static struct amba_device uart0_device = {
 	.dev = {
+		.coherent_dma_mask = ~0,
 		.init_name = "uart0", /* Slow device at 0x3000 offset */
-		.platform_data = NULL,
+		.platform_data = &uart0_plat_data,
 	},
 	.res = {
 		.start = U300_UART0_BASE,
@@ -107,10 +119,19 @@ static struct amba_device uart0_device = {
 
 /* The U335 have an additional UART1 on the APP CPU */
 #ifdef CONFIG_MACH_U300_BS335
+static struct amba_pl011_data uart1_plat_data = {
+#ifdef CONFIG_COH901318
+	.dma_filter = coh901318_filter_id,
+	.dma_rx_param = (void *) U300_DMA_UART1_RX,
+	.dma_tx_param = (void *) U300_DMA_UART1_TX,
+#endif
+};
+
 static struct amba_device uart1_device = {
 	.dev = {
+		.coherent_dma_mask = ~0,
 		.init_name = "uart1", /* Fast device at 0x7000 offset */
-		.platform_data = NULL,
+		.platform_data = &uart1_plat_data,
 	},
 	.res = {
 		.start = U300_UART1_BASE,
@@ -1007,11 +1028,87 @@ const struct coh_dma_channel chan_config[U300_DMA_CHANNELS] = {
 		.number = U300_DMA_UART0_TX,
 		.name = "UART0 TX",
 		.priority_high = 0,
+		.dev_addr =  U300_UART0_BASE + 0x00,
+		.param.config = COH901318_CX_CFG_CH_DISABLE |
+				COH901318_CX_CFG_LCR_DISABLE |
+				COH901318_CX_CFG_TC_IRQ_ENABLE |
+				COH901318_CX_CFG_BE_IRQ_ENABLE,
+		.param.ctrl_lli_chained = 0 |
+				COH901318_CX_CTRL_TC_ENABLE |
+				COH901318_CX_CTRL_BURST_COUNT_8_BYTES |
+				COH901318_CX_CTRL_SRC_BUS_SIZE_32_BITS |
+				COH901318_CX_CTRL_DST_BUS_SIZE_8_BITS |
+				COH901318_CX_CTRL_MASTER_MODE_M1RW |
+				COH901318_CX_CTRL_TCP_ENABLE |
+				COH901318_CX_CTRL_TC_IRQ_DISABLE |
+				COH901318_CX_CTRL_HSP_ENABLE |
+				COH901318_CX_CTRL_HSS_DISABLE |
+				COH901318_CX_CTRL_DDMA_LEGACY,
+		.param.ctrl_lli = 0 |
+				COH901318_CX_CTRL_TC_ENABLE |
+				COH901318_CX_CTRL_BURST_COUNT_8_BYTES |
+				COH901318_CX_CTRL_SRC_BUS_SIZE_32_BITS |
+				COH901318_CX_CTRL_DST_BUS_SIZE_8_BITS |
+				COH901318_CX_CTRL_MASTER_MODE_M1RW |
+				COH901318_CX_CTRL_TCP_ENABLE |
+				COH901318_CX_CTRL_TC_IRQ_ENABLE |
+				COH901318_CX_CTRL_HSP_ENABLE |
+				COH901318_CX_CTRL_HSS_DISABLE |
+				COH901318_CX_CTRL_DDMA_LEGACY,
+		.param.ctrl_lli_last = 0 |
+				COH901318_CX_CTRL_TC_ENABLE |
+				COH901318_CX_CTRL_BURST_COUNT_8_BYTES |
+				COH901318_CX_CTRL_SRC_BUS_SIZE_32_BITS |
+				COH901318_CX_CTRL_DST_BUS_SIZE_8_BITS |
+				COH901318_CX_CTRL_MASTER_MODE_M1RW |
+				COH901318_CX_CTRL_TCP_ENABLE |
+				COH901318_CX_CTRL_TC_IRQ_ENABLE |
+				COH901318_CX_CTRL_HSP_ENABLE |
+				COH901318_CX_CTRL_HSS_DISABLE |
+				COH901318_CX_CTRL_DDMA_LEGACY,
 	},
 	{
 		.number = U300_DMA_UART0_RX,
 		.name = "UART0 RX",
 		.priority_high = 0,
+		.dev_addr =  U300_UART0_BASE + 0x00,
+		.param.config = COH901318_CX_CFG_CH_DISABLE |
+				COH901318_CX_CFG_LCR_DISABLE |
+				COH901318_CX_CFG_TC_IRQ_ENABLE |
+				COH901318_CX_CFG_BE_IRQ_ENABLE,
+		.param.ctrl_lli_chained = 0 |
+				COH901318_CX_CTRL_TC_ENABLE |
+				COH901318_CX_CTRL_BURST_COUNT_8_BYTES |
+				COH901318_CX_CTRL_SRC_BUS_SIZE_8_BITS |
+				COH901318_CX_CTRL_DST_BUS_SIZE_32_BITS |
+				COH901318_CX_CTRL_MASTER_MODE_M1RW |
+				COH901318_CX_CTRL_TCP_ENABLE |
+				COH901318_CX_CTRL_TC_IRQ_DISABLE |
+				COH901318_CX_CTRL_HSP_ENABLE |
+				COH901318_CX_CTRL_HSS_DISABLE |
+				COH901318_CX_CTRL_DDMA_LEGACY,
+		.param.ctrl_lli = 0 |
+				COH901318_CX_CTRL_TC_ENABLE |
+				COH901318_CX_CTRL_BURST_COUNT_8_BYTES |
+				COH901318_CX_CTRL_SRC_BUS_SIZE_8_BITS |
+				COH901318_CX_CTRL_DST_BUS_SIZE_32_BITS |
+				COH901318_CX_CTRL_MASTER_MODE_M1RW |
+				COH901318_CX_CTRL_TCP_ENABLE |
+				COH901318_CX_CTRL_TC_IRQ_ENABLE |
+				COH901318_CX_CTRL_HSP_ENABLE |
+				COH901318_CX_CTRL_HSS_DISABLE |
+				COH901318_CX_CTRL_DDMA_LEGACY,
+		.param.ctrl_lli_last = 0 |
+				COH901318_CX_CTRL_TC_ENABLE |
+				COH901318_CX_CTRL_BURST_COUNT_8_BYTES |
+				COH901318_CX_CTRL_SRC_BUS_SIZE_8_BITS |
+				COH901318_CX_CTRL_DST_BUS_SIZE_32_BITS |
+				COH901318_CX_CTRL_MASTER_MODE_M1RW |
+				COH901318_CX_CTRL_TCP_ENABLE |
+				COH901318_CX_CTRL_TC_IRQ_ENABLE |
+				COH901318_CX_CTRL_HSP_ENABLE |
+				COH901318_CX_CTRL_HSS_DISABLE |
+				COH901318_CX_CTRL_DDMA_LEGACY,
 	},
 	{
 		.number = U300_DMA_APEX_TX,
@@ -1577,7 +1674,7 @@ static void __init u300_init_check_chip(void)
 #endif
 #ifdef CONFIG_MACH_U300_BS335
 	if ((val & 0xFF00U) != 0xf000 && (val & 0xFF00U) != 0xf100) {
-		printk(KERN_ERR "Platform configured for BS365 " \
+		printk(KERN_ERR "Platform configured for BS335 " \
 		       " with DB3350 but %s detected, expect problems!",
 		       chipname);
 	}
diff --git a/arch/arm/mach-u300/mmc.c b/arch/arm/mach-u300/mmc.c
index 783f123..931b394 100644
--- a/arch/arm/mach-u300/mmc.c
+++ b/arch/arm/mach-u300/mmc.c
@@ -3,11 +3,11 @@
  * arch/arm/mach-u300/mmc.c
  *
  *
- * Copyright (C) 2009 ST-Ericsson AB
+ * Copyright (C) 2009 ST-Ericsson SA
  * License terms: GNU General Public License (GPL) version 2
  *
  * Author: Linus Walleij <linus.walleij@stericsson.com>
- * Author: Johan Lundin <johan.lundin@stericsson.com>
+ * Author: Johan Lundin
  * Author: Jonas Aaberg <jonas.aberg@stericsson.com>
  */
 #include <linux/device.h>
@@ -19,7 +19,10 @@
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/machine.h>
 #include <linux/gpio.h>
+#include <linux/dmaengine.h>
 #include <linux/amba/mmci.h>
+#include <mach/coh901318.h>
+#include <mach/dma_channels.h>
 
 #include "mmc.h"
 #include "padmux.h"
@@ -107,6 +110,12 @@ int __devinit mmc_init(struct amba_device *adev)
 	mmci_card->mmc0_plat_data.gpio_cd = -1;
 	mmci_card->mmc0_plat_data.capabilities = MMC_CAP_MMC_HIGHSPEED |
 		MMC_CAP_SD_HIGHSPEED | MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
+#ifdef CONFIG_COH901318
+	mmci_card->mmc0_plat_data.dma_filter = coh901318_filter_id;
+	mmci_card->mmc0_plat_data.dma_rx_param =
+		(void *) U300_DMA_MMCSD_RX_TX;
+	/* Don't specify a TX channel, this RX channel is bidirectional */
+#endif
 
 	mmcsd_device->platform_data = (void *) &mmci_card->mmc0_plat_data;
 
-- 
1.6.2.5
