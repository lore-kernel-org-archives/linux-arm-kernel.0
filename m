From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  3 May 2013 15:32:34 +0100
Subject: [PATCH 48/63] usb: musb: ux500: attempt to find channels by name
 before using pdata
In-Reply-To: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1367591569-32197-49-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we can ever get to a state where we can solely search for DMA channels
by name, this will almost completely alleviate the requirement to pass
copious amounts of information though platform data. Here we take the
first step towards this. The next step will be to enable Device Tree
complete with name<->event_line mapping.

Cc: Felipe Balbi <balbi@ti.com>
Cc: linux-usb at vger.kernel.org
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Fabio Baltieri <fabio.baltieri@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/musb/ux500_dma.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/ux500_dma.c b/drivers/usb/musb/ux500_dma.c
index 8d5128d..99ad1fe 100644
--- a/drivers/usb/musb/ux500_dma.c
+++ b/drivers/usb/musb/ux500_dma.c
@@ -33,6 +33,11 @@
 #include <linux/platform_data/usb-musb-ux500.h>
 #include "musb_core.h"
 
+static const char *iep_chan_names[] = { "iep_1_9", "iep_2_10", "iep_3_11", "iep_4_12",
+					"iep_5_13", "iep_6_14", "iep_7_15", "iep_8" };
+static const char *oep_chan_names[] = { "oep_1_9", "oep_2_10", "oep_3_11", "oep_4_12",
+					"oep_5_13", "oep_6_14", "oep_7_15", "oep_8" };
+
 struct ux500_dma_channel {
 	struct dma_channel channel;
 	struct ux500_dma_controller *controller;
@@ -289,6 +294,7 @@ static int ux500_dma_controller_start(struct dma_controller *c)
 	struct musb_hdrc_platform_data *plat = dev->platform_data;
 	struct ux500_musb_board_data *data;
 	struct dma_channel *dma_channel = NULL;
+	char **chan_names;
 	u32 ch_num;
 	u8 dir;
 	u8 is_tx = 0;
@@ -310,6 +316,7 @@ static int ux500_dma_controller_start(struct dma_controller *c)
 	/* Prepare the loop for RX channels */
 	channel_array = controller->rx_channel;
 	param_array = data ? data->dma_rx_param_array : NULL;
+	chan_names = (char **)iep_chan_names;
 
 	for (dir = 0; dir < 2; dir++) {
 		for (ch_num = 0;
@@ -325,9 +332,15 @@ static int ux500_dma_controller_start(struct dma_controller *c)
 			dma_channel->status = MUSB_DMA_STATUS_FREE;
 			dma_channel->max_len = SZ_16M;
 
-			ux500_channel->dma_chan = dma_request_channel(mask,
-							data->dma_filter,
-							param_array[ch_num]);
+			ux500_channel->dma_chan =
+				dma_request_slave_channel(dev, chan_names[ch_num]);
+
+			if (!ux500_channel->dma_chan)
+				ux500_channel->dma_chan =
+					dma_request_channel(mask,
+							    data->dma_filter,
+							    param_array[ch_num]);
+
 			if (!ux500_channel->dma_chan) {
 				ERR("Dma pipe allocation error dir=%d ch=%d\n",
 					dir, ch_num);
@@ -343,6 +356,7 @@ static int ux500_dma_controller_start(struct dma_controller *c)
 		/* Prepare the loop for TX channels */
 		channel_array = controller->tx_channel;
 		param_array = data ? data->dma_tx_param_array : NULL;
+		chan_names = (char **)oep_chan_names;
 		is_tx = 1;
 	}
 
-- 
1.7.10.4
