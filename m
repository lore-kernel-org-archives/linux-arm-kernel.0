From: wirtl@H-27099-0. (Tobias Wirtl (none))
Date: Thu, 23 Sep 2010 08:33:19 +0200
Subject: [PATCH 2/3] Added the M3IF base address
Message-ID: <mailman.1.1285945727.1947.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 drivers/dma/imx-sdma.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 1091047..325827e 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -755,7 +755,7 @@ static int sdma_config_channel(int channel)
 		/* Address */
 		sdma->shp_addr =3D sdma->per_address;
 	} else {
-		sdma->watermark_level =3D 0; /* FIXME: M3_BASE_ADDRESS */
+		sdma->watermark_level =3D MX35_M3IF_BASE_ADDR;
 	}
=20
 	ret =3D sdma_load_context(channel);
@@ -1075,8 +1075,10 @@ static struct dma_async_tx_descriptor
*sdma_prep_slave_sg(
 {
 	struct sdma_channel *sdma =3D to_sdma_chan(chan);
 	int ret, i, count;
+	unsigned int slave_offset =3D 0;
 	int channel =3D chan->chan_id;
 	struct scatterlist *sg;
+=09
=20
 	if (sdma->busy)
 		return NULL;
@@ -1102,8 +1104,20 @@ static struct dma_async_tx_descriptor
*sdma_prep_slave_sg(
 	for_each_sg(sgl, sg, sg_len, i) {
 		struct sdma_buffer_descriptor *bd =3D &sdma->bd[i];
 		int param;
-		bd->buffer_addr =3D sgl->dma_address;
+		if (sdma->peripheral_type =3D=3D IMX_DMATYPE_MEMORY) {
+			if (direction =3D=3D DMA_FROM_DEVICE){
+				bd->buffer_addr =3D sdma->per_address +
slave_offset;
+				bd->ext_buffer_addr =3D sg->dma_address;
+			} else {
+                                bd->buffer_addr =3D sg->dma_address;
+				bd->ext_buffer_addr =3D sdma->per_address
+ slave_offset;
+			}
+			pr_debug("SDMA prepare mem sg src=3D%08x
dst=3D%08x\n",bd->buffer_addr,bd->ext_buffer_addr);
+		} else {
+			bd->buffer_addr =3D sgl->dma_address;
+		}
 		count =3D sg->length;
+		slave_offset +=3D count;
=20
 		if (count > 0xffff) {
 			pr_err("SDMA channel %d: maximum bytes for sg
entry exceeded: %d > %d\n",
--=20
1.7.0.4
