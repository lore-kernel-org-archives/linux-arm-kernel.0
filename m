From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 13 Dec 2013 10:47:28 +0000
Subject: [PATCH 1/1] usb: musb: ux500_dma: fix potential NULL dereference error
Message-ID: <1386931648-1540-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

static checker warning: "drivers/usb/musb/ux500_dma.c:335
ux500_dma_controller_start()
         error: potential NULL dereference 'param_array'."

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/musb/ux500_dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/ux500_dma.c b/drivers/usb/musb/ux500_dma.c
index 3700e97..9aad00f 100644
--- a/drivers/usb/musb/ux500_dma.c
+++ b/drivers/usb/musb/ux500_dma.c
@@ -336,7 +336,9 @@ static int ux500_dma_controller_start(struct ux500_dma_controller *controller)
 							    data ?
 							    data->dma_filter :
 							    NULL,
-							    param_array[ch_num]);
+							    param_array ?
+							    param_array[ch_num] :
+							    NULL);
 
 			if (!ux500_channel->dma_chan) {
 				ERR("Dma pipe allocation error dir=%d ch=%d\n",
-- 
1.8.3.2
