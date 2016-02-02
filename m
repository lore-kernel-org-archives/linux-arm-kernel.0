From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 2 Feb 2016 14:43:16 +0200
Subject: [PATCH 4/5] ARM: davinci: dm644x: Add dma_slave_map to edma
In-Reply-To: <1454416997-14230-1-git-send-email-peter.ujfalusi@ti.com>
References: <1454416997-14230-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1454416997-14230-5-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide the dma_slave_map to edma which will allow us to move the drivers
to the new, simpler dmaengine API and we can remove the DMA resources also
for the devices.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

FIX: dm646x
---
 arch/arm/mach-davinci/dm644x.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index b28071ae3a57..5ccd8bda96aa 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/serial_8250.h>
+#include <linux/dmaengine.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
@@ -505,9 +506,20 @@ static s8 queue_priority_mapping[][2] = {
 	{-1, -1},
 };
 
+static const struct dma_slave_map da644x_edma_map[] = {
+	{ "davinci-mcbsp", "tx", EDMA_FILTER_PARAM(0, 2) },
+	{ "davinci-mcbsp", "rx", EDMA_FILTER_PARAM(0, 3) },
+	{ "spi_davinci", "tx", EDMA_FILTER_PARAM(0, 16) },
+	{ "spi_davinci", "rx", EDMA_FILTER_PARAM(0, 17) },
+	{ "dm6441-mmc.0", "rx", EDMA_FILTER_PARAM(0, 26) },
+	{ "dm6441-mmc.0", "tx", EDMA_FILTER_PARAM(0, 27) },
+};
+
 static struct edma_soc_info dm644x_edma_pdata = {
 	.queue_priority_mapping	= queue_priority_mapping,
 	.default_queue		= EVENTQ_1,
+	.slave_map		= da644x_edma_map,
+	.slavecnt		= ARRAY_SIZE(da644x_edma_map),
 };
 
 static struct resource edma_resources[] = {
-- 
2.7.0
