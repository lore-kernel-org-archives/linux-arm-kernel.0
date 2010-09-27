From: wirtl@H-27099-0. (Tobias Wirtl (none))
Date: Mon, 27 Sep 2010 15:59:19 +0200
Subject: [PATCH 3/3] added support for "run twice" mem2mem transfers
Message-ID: <mailman.2.1285945728.1947.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-it's possible to run a prepared mem2mem channel more than 1 time
---
 drivers/dma/imx-sdma.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 325827e..03d94b5 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -945,7 +945,7 @@ static dma_cookie_t sdma_tx_submit(struct
dma_async_tx_descriptor *tx)
 	spin_lock_irq(&sdma->lock);
=20
 	cookie =3D sdma_assign_cookie(sdma);
-
+=09
 	sdma_enable_channel(tx->chan->chan_id);
=20
 	spin_unlock_irq(&sdma->lock);
@@ -1038,7 +1038,8 @@ static struct dma_async_tx_descriptor
*sdma_prep_dma_memcpy(
 	if (sdma->busy)
 		return NULL;
 	sdma->busy =3D 1;
-	sdma->flags =3D 0;
+=09
+	sdma->flags =3D IMX_DMA_SG_LOOP; //if the prepared transfer is
used again
 =09
 	sdma->direction =3D DMA_FROM_DEVICE; //doesn't matter
 =09
@@ -1054,7 +1055,7 @@ static struct dma_async_tx_descriptor
*sdma_prep_dma_memcpy(
 	bd->ext_buffer_addr =3D dest;
 	bd->mode.count =3D len;
 	bd->mode.command =3D 0;
-        bd->mode.status =3D BD_DONE | BD_EXTD | BD_CONT | BD_INTR;
+        bd->mode.status =3D BD_DONE | BD_EXTD | BD_INTR | BD_WRAP;
//BD_DONE | BD_EXTD | BD_CONT | BD_INTR | BD_WRAP;
=20
 	sdma->num_bd =3D 1;
=20
--=20
1.7.0.4


=20
