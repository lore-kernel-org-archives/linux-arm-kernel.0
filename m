From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  5 Nov 2010 10:26:03 +0100
Subject: [PATCH 1/3] ARM mx3_camera: check for DMA engine type
In-Reply-To: <1288949165-13286-1-git-send-email-s.hauer@pengutronix.de>
References: <1288949165-13286-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1288949165-13286-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have two dma engines in MX3 systems: The IPU and the SDMA
engine. We have to check if we got a channel from the correct
engine before proceeding with a channel.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/media/video/mx3_camera.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/mx3_camera.c b/drivers/media/video/mx3_camera.c
index 29c5fc3..aa871c2 100644
--- a/drivers/media/video/mx3_camera.c
+++ b/drivers/media/video/mx3_camera.c
@@ -27,6 +27,7 @@
 
 #include <mach/ipu.h>
 #include <mach/mx3_camera.h>
+#include <mach/dma.h>
 
 #define MX3_CAM_DRV_NAME "mx3-camera"
 
@@ -638,6 +639,9 @@ static bool chan_filter(struct dma_chan *chan, void *arg)
 	struct dma_chan_request *rq = arg;
 	struct mx3_camera_pdata *pdata;
 
+	if (!imx_dma_is_ipu(chan))
+		return false;
+
 	if (!rq)
 		return false;
 
-- 
1.7.2.3
