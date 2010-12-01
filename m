From: vm.rod25@gmail.com (vm.rod25 at gmail.com)
Date: Wed,  1 Dec 2010 13:32:25 -0600
Subject: [PATCH v9 2/6] davinci: EDMA support for Omapl138-Hawkboard
In-Reply-To: <1291231949-23835-1-git-send-email-vm.rod25@gmail.com>
References: <1291231949-23835-1-git-send-email-vm.rod25@gmail.com>
Message-ID: <1291231949-23835-3-git-send-email-vm.rod25@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Rodriguez <victor.rodriguez@sasken.com>

This patch adds EDMA support for the Hawkboard-L138 system

Signed-off-by: Victor Rodriguez <victor.rodriguez@sasken.com>
Tested-by: Rene Gonzalez <renegs.2378@gmail.com>
---
 arch/arm/mach-davinci/board-omapl138-hawk.c |   54 +++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 75b3fe2..cefff9b 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -60,6 +60,55 @@ static __init void omapl138_hawk_config_emac(void)
 			__func__, ret);
 }
 
+/*
+ * The following EDMA channels/slots are not being used by drivers (for
+ * example: Timer, GPIO, UART events etc) on da850/omap-l138 EVM/Hawkboard,
+ * hence they are being reserved for codecs on the DSP side.
+ */
+static const s16 da850_dma0_rsv_chans[][2] = {
+	/* (offset, number) */
+	{ 8,  6},
+	{24,  4},
+	{30,  2},
+	{-1, -1}
+};
+
+static const s16 da850_dma0_rsv_slots[][2] = {
+	/* (offset, number) */
+	{ 8,  6},
+	{24,  4},
+	{30, 50},
+	{-1, -1}
+};
+
+static const s16 da850_dma1_rsv_chans[][2] = {
+	/* (offset, number) */
+	{ 0, 28},
+	{30,  2},
+	{-1, -1}
+};
+
+static const s16 da850_dma1_rsv_slots[][2] = {
+	/* (offset, number) */
+	{ 0, 28},
+	{30, 90},
+	{-1, -1}
+};
+
+static struct edma_rsv_info da850_edma_cc0_rsv = {
+	.rsv_chans	= da850_dma0_rsv_chans,
+	.rsv_slots	= da850_dma0_rsv_slots,
+};
+
+static struct edma_rsv_info da850_edma_cc1_rsv = {
+	.rsv_chans	= da850_dma1_rsv_chans,
+	.rsv_slots	= da850_dma1_rsv_slots,
+};
+
+static struct edma_rsv_info *da850_edma_rsv[2] = {
+	&da850_edma_cc0_rsv,
+	&da850_edma_cc1_rsv,
+};
 
 static struct davinci_uart_config omapl138_hawk_uart_config __initdata = {
 	.enabled_uarts = 0x7,
@@ -73,6 +122,11 @@ static __init void omapl138_hawk_init(void)
 
 	omapl138_hawk_config_emac();
 
+	ret = da850_register_edma(da850_edma_rsv);
+	if (ret)
+		pr_warning("%s: EDMA registration failed: %d\n",
+			__func__, ret);
+
 	ret = da8xx_register_watchdog();
 	if (ret)
 		pr_warning("omapl138_hawk_init: "
-- 
1.7.0.4
