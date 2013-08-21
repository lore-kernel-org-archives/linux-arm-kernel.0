From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 21 Aug 2013 12:47:03 +0100
Subject: [PATCH] usb: musb: ux500: Add check for NULL board data
Message-ID: <1377085623-8773-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dan Carpenter's automatic Smatch checker found an anomaly in the ux500
MUSB driver, whereby board data was checked before use in all but one
occasion. It is believed that it needs to be checked every time.

Smatch complaint:
  drivers/usb/musb/ux500_dma.c:335 ux500_dma_controller_start()
         error: we previously assumed 'data' could be null (see line 313)

Cc: Felipe Balbi <balbi@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb at vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/musb/ux500_dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/ux500_dma.c b/drivers/usb/musb/ux500_dma.c
index bfb7a65..679f511 100644
--- a/drivers/usb/musb/ux500_dma.c
+++ b/drivers/usb/musb/ux500_dma.c
@@ -339,7 +339,9 @@ static int ux500_dma_controller_start(struct dma_controller *c)
 			if (!ux500_channel->dma_chan)
 				ux500_channel->dma_chan =
 					dma_request_channel(mask,
-							    data->dma_filter,
+							    data ?
+							    data->dma_filter :
+							    NULL,
 							    param_array[ch_num]);
 
 			if (!ux500_channel->dma_chan) {
-- 
1.8.1.2
