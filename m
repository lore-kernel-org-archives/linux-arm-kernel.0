From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 19 Feb 2010 01:05:52 +0100
Subject: [PATCH 5/7] ARM: U300: add MMCI DMA platform config
Message-ID: <1266537952-13099-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the platform configuration necessary to
get DMA on the U300 MMCI block.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 arch/arm/mach-u300/mmc.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-u300/mmc.c b/arch/arm/mach-u300/mmc.c
index c1cb977..8f6d8af 100644
--- a/arch/arm/mach-u300/mmc.c
+++ b/arch/arm/mach-u300/mmc.c
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
 		MMC_CAP_SD_HIGHSPEED | MMC_CAP_4_BIT_DATA;
+#ifdef CONFIG_DMA_ENGINE
+	mmci_card->mmc0_plat_data.dma_filter = coh901318_filter_id;
+	mmci_card->mmc0_plat_data.dma_rx_param =
+		(void *) U300_DMA_MMCSD_RX_TX;
+	/* Don't specify a TX channel, this RX channel is bidirectional */
+#endif
 
 	mmcsd_device->platform_data = (void *) &mmci_card->mmc0_plat_data;
 
-- 
1.6.6
