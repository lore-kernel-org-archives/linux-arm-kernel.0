From: Tobias.Wirtl@hbm.com (Wirtl, Tobias)
Date: Fri, 1 Oct 2010 16:08:12 +0200
Subject: [PATCH] support for SDMA memory to memory transfers
Message-ID: <C7E2EBC63FB38847ADEAA1E2CEB3C6D070DC40@HBMNTX3.hbm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch adds support for SDMA memory to memory transfers. It
implements the prep_dma_memcpy function for the dmaengine. I'm sorry for
the format.

Any comments on this?


>From bogus@does.not.exist.com  Fri Oct  1 10:42:22 2010
From: bogus@does.not.exist.com ()
Date: Fri, 01 Oct 2010 14:42:22 -0000
Subject: No subject
Message-ID: <mailman.0.1285945727.1947.linux-arm-kernel@lists.infradead.org>

Hottinger Baldwin Messtechnik GmbH, Im Tiefen See 45, 64293 Darmstadt, =
Germany | www.hbm.com=20

Registered as GmbH (German limited liability corporation) in the =
commercial register at the local court of Darmstadt, HRB 1147 =20
Company domiciled in Darmstadt | CEO: Andreas Huellhorst | Chairman of =
the board: James Charles Webster

Als Gesellschaft mit beschraenkter Haftung eingetragen im =
Handelsregister des Amtsgerichts Darmstadt unter HRB 1147=20
Sitz der Gesellschaft: Darmstadt | Geschaeftsfuehrung: Andreas =
Huellhorst | Aufsichtsratsvorsitzender: James Charles Webster

The information in this email is confidential. It is intended solely for =
the addressee. If you are not the intended recipient, please let me know =
and delete this email.

Die in dieser E-Mail enthaltene Information ist vertraulich und =
lediglich fur den Empfaenger bestimmt. Sollten Sie nicht der eigentliche =
Empfaenger sein, informieren Sie mich bitte kurz und loeschen diese =
E-Mail.

From: Tobias Wirtl <wirtl@H-27099-0.(none)>
Date: Thu, 16 Sep 2010 16:04:23 +0200
Subject: [PATCH 1/3] added support for memory to memory transfers using
the async-tx-api
 see sdma_prep_dma_memcpy function

---
 drivers/dma/imx-sdma.c |   61
++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index be61803..1091047 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -4,7 +4,8 @@
  * This file contains a driver for the Freescale Smart DMA engine
  *
  * Copyright 2010 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
- *
+ * Copyright 2010 Tobias Wirtl, HBM <tobias.wirtl@hbm.com>
+ *=20
  * Based on code from Freescale:
  *
  * Copyright 2004-2009 Freescale Semiconductor, Inc. All Rights
Reserved.
@@ -643,8 +644,13 @@ static void sdma_get_pc(struct sdma_channel *sdma,
 		break;
 	}
=20
-	sdma->pc_from_device =3D per_2_emi;
-	sdma->pc_to_device =3D emi_2_per;
+	if (peripheral_type =3D=3D IMX_DMATYPE_MEMORY){
+		sdma->pc_from_device =3D emi_2_emi;
+		sdma->pc_to_device =3D emi_2_emi;
+	} else {
+                sdma->pc_from_device =3D per_2_emi;
+                sdma->pc_to_device =3D emi_2_per;
+	}
 }
=20
 static int sdma_load_context(int channel)
@@ -1015,6 +1021,51 @@ static void sdma_free_chan_resources(struct
dma_chan *chan)
 	clk_disable(sdma_clk);
 }
=20
+static struct dma_async_tx_descriptor *sdma_prep_dma_memcpy(
+		struct dma_chan *chan,=20
+		dma_addr_t dest, dma_addr_t src,
+		size_t len, unsigned long flags)
+{
+	struct sdma_channel *sdma =3D to_sdma_chan(chan);
+	struct sdma_buffer_descriptor *bd;
+	int ret;
+	int chan_id =3D chan->chan_id;
+=09
+	pr_debug("SDMA: preparing memcpy src: 0x%08x dst: 0x%08x len: %i
on channel %i\n",src,dest,len,chan->chan_id);
+
+	sdma_config_channel(chan_id);
+=09
+	if (sdma->busy)
+		return NULL;
+	sdma->busy =3D 1;
+	sdma->flags =3D 0;
+=09
+	sdma->direction =3D DMA_FROM_DEVICE; //doesn't matter
+=09
+	ret =3D sdma_load_context(chan_id);
+	if (ret)
+	{
+		pr_debug("SDMA: can't load channel context for channel
%i\n",chan_id);
+		goto err_out;
+	}
+	bd =3D &sdma->bd[0];
+=09
+	bd->buffer_addr =3D src;
+	bd->ext_buffer_addr =3D dest;
+	bd->mode.count =3D len;
+	bd->mode.command =3D 0;
+        bd->mode.status =3D BD_DONE | BD_EXTD | BD_CONT | BD_INTR;
+
+	sdma->num_bd =3D 1;
+
+	channel_control[chan_id].current_bd_ptr =3D sdma->bd_phys;
+
+	return &sdma->desc;
+err_out:
+	return NULL;
+=09
+}
+
 #define NUM_BD (int)(PAGE_SIZE / sizeof(struct sdma_buffer_descriptor))
=20
 static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
@@ -1051,9 +1102,7 @@ static struct dma_async_tx_descriptor
*sdma_prep_slave_sg(
 	for_each_sg(sgl, sg, sg_len, i) {
 		struct sdma_buffer_descriptor *bd =3D &sdma->bd[i];
 		int param;
-
 		bd->buffer_addr =3D sgl->dma_address;
-
 		count =3D sg->length;
=20
 		if (count > 0xffff) {
@@ -1312,6 +1361,7 @@ static int __devinit sdma_probe(struct
platform_device *pdev)
=20
 		dma_cap_set(DMA_SLAVE, sdma_dma_device->cap_mask);
 		dma_cap_set(DMA_CYCLIC, sdma_dma_device->cap_mask);
+		dma_cap_set(DMA_MEMCPY, sdma_dma_device->cap_mask);

=20
 		sdma->chan.device =3D sdma_dma_device;
 		sdma->chan.chan_id =3D i;
@@ -1325,6 +1375,7 @@ static int __devinit sdma_probe(struct
platform_device *pdev)
 	sdma_dma_device->device_alloc_chan_resources =3D
sdma_alloc_chan_resources;
 	sdma_dma_device->device_free_chan_resources =3D
sdma_free_chan_resources;
 	sdma_dma_device->device_tx_status =3D sdma_tx_status;
+	sdma_dma_device->device_prep_dma_memcpy =3D sdma_prep_dma_memcpy;
 	sdma_dma_device->device_prep_slave_sg =3D sdma_prep_slave_sg;
 	sdma_dma_device->device_prep_dma_cyclic =3D sdma_prep_dma_cyclic;
 	sdma_dma_device->device_control =3D sdma_control;
--=20
1.7.0.4
