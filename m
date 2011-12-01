From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  1 Dec 2011 14:58:51 +0100
Subject: [PATCH 1/2] i.MX IPU DMA: Fix wrong burstsize settings
In-Reply-To: <1322747932-24943-1-git-send-email-s.hauer@pengutronix.de>
References: <1322747932-24943-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1322747932-24943-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The burstsize (npb in struct chan_param_mem) is set in
ipu_ch_param_set_size() once. The number of allowed
pixels in a burst depend on the pixel format and the
rotation mode. For 16bit formats 16 pixels are allowed
whereas for 32bit formats only 8 pixels are allowed.
Set these values correctly in ipu_ch_param_set_size()
and do not overwrite them afterwards.
We do not support rotation right now, so ignore this
case.
This patch fixes the wrong burstsize setting of 16 pixels
for 32bpp.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/ipu/ipu_idmac.c |   25 +------------------------
 1 files changed, 1 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/ipu/ipu_idmac.c b/drivers/dma/ipu/ipu_idmac.c
index 0e5ef33..ccdc806 100644
--- a/drivers/dma/ipu/ipu_idmac.c
+++ b/drivers/dma/ipu/ipu_idmac.c
@@ -312,7 +312,7 @@ static void ipu_ch_param_set_size(union chan_param_mem *params,
 	case IPU_PIX_FMT_RGB565:
 		params->ip.bpp	= 2;
 		params->ip.pfs	= 4;
-		params->ip.npb	= 7;
+		params->ip.npb	= 15;
 		params->ip.sat	= 2;		/* SAT = 32-bit access */
 		params->ip.ofs0	= 0;		/* Red bit offset */
 		params->ip.ofs1	= 5;		/* Green bit offset */
@@ -422,12 +422,6 @@ static void ipu_ch_param_set_size(union chan_param_mem *params,
 	params->pp.nsb = 1;
 }
 
-static void ipu_ch_param_set_burst_size(union chan_param_mem *params,
-					uint16_t burst_pixels)
-{
-	params->pp.npb = burst_pixels - 1;
-}
-
 static void ipu_ch_param_set_buffer(union chan_param_mem *params,
 				    dma_addr_t buf0, dma_addr_t buf1)
 {
@@ -690,23 +684,6 @@ static int ipu_init_channel_buffer(struct idmac_channel *ichan,
 	ipu_ch_param_set_size(&params, pixel_fmt, width, height, stride_bytes);
 	ipu_ch_param_set_buffer(&params, phyaddr_0, phyaddr_1);
 	ipu_ch_param_set_rotation(&params, rot_mode);
-	/* Some channels (rotation) have restriction on burst length */
-	switch (channel) {
-	case IDMAC_IC_7:	/* Hangs with burst 8, 16, other values
-				   invalid - Table 44-30 */
-/*
-		ipu_ch_param_set_burst_size(&params, 8);
- */
-		break;
-	case IDMAC_SDC_0:
-	case IDMAC_SDC_1:
-		/* In original code only IPU_PIX_FMT_RGB565 was setting burst */
-		ipu_ch_param_set_burst_size(&params, 16);
-		break;
-	case IDMAC_IC_0:
-	default:
-		break;
-	}
 
 	spin_lock_irqsave(&ipu->lock, flags);
 
-- 
1.7.7.1
