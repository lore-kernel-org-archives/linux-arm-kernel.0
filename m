From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 2 Feb 2016 14:43:14 +0200
Subject: [PATCH 2/5] ARM: davinci: dm355: Add dma_slave_map to edma
In-Reply-To: <1454416997-14230-1-git-send-email-peter.ujfalusi@ti.com>
References: <1454416997-14230-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1454416997-14230-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide the dma_slave_map to edma which will allow us to move the drivers
to the new, simpler dmaengine API and we can remove the DMA resources also
for the devices.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

FIX: dm355
---
 arch/arm/mach-davinci/dm355.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index c7c1458df23c..092ca1e30e98 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -13,6 +13,7 @@
 #include <linux/serial_8250.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/spi/spi.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
@@ -576,9 +577,28 @@ static s8 queue_priority_mapping[][2] = {
 	{-1, -1},
 };
 
+static const struct dma_slave_map da355_edma_map[] = {
+	{ "davinci-mcbsp.0", "tx", EDMA_FILTER_PARAM(0, 2) },
+	{ "davinci-mcbsp.0", "rx", EDMA_FILTER_PARAM(0, 3) },
+	{ "davinci-mcbsp.1", "tx", EDMA_FILTER_PARAM(0, 8) },
+	{ "davinci-mcbsp.1", "rx", EDMA_FILTER_PARAM(0, 9) },
+	{ "spi_davinci.2", "tx", EDMA_FILTER_PARAM(0, 10) },
+	{ "spi_davinci.2", "rx", EDMA_FILTER_PARAM(0, 11) },
+	{ "spi_davinci.1", "tx", EDMA_FILTER_PARAM(0, 14) },
+	{ "spi_davinci.1", "rx", EDMA_FILTER_PARAM(0, 15) },
+	{ "spi_davinci.0", "tx", EDMA_FILTER_PARAM(0, 16) },
+	{ "spi_davinci.0", "rx", EDMA_FILTER_PARAM(0, 17) },
+	{ "dm6441-mmc.0", "rx", EDMA_FILTER_PARAM(0, 26) },
+	{ "dm6441-mmc.0", "tx", EDMA_FILTER_PARAM(0, 27) },
+	{ "dm6441-mmc.1", "rx", EDMA_FILTER_PARAM(0, 30) },
+	{ "dm6441-mmc.1", "tx", EDMA_FILTER_PARAM(0, 31) },
+};
+
 static struct edma_soc_info dm355_edma_pdata = {
 	.queue_priority_mapping	= queue_priority_mapping,
 	.default_queue		= EVENTQ_1,
+	.slave_map		= da355_edma_map,
+	.slavecnt		= ARRAY_SIZE(da355_edma_map),
 };
 
 static struct resource edma_resources[] = {
-- 
2.7.0
