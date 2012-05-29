From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 29 May 2012 10:37:38 +0100
Subject: [RFC 07/34] dmaengine: PL08x: remove circular_buffer boolean from
 channel data
In-Reply-To: <20120529093015.GF12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
Message-ID: <E1SZIry-0006zA-K2@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Circular buffers are not handled in this way; we have a separate API
call now to setup circular buffers.  So lets not mislead people with
this bool.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |    7 -------
 include/linux/amba/pl08x.h |    4 ----
 2 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 219769f..d8d5d27 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1694,13 +1694,6 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 				return -ENOMEM;
 			}
 		}
-		if (chan->cd->circular_buffer) {
-			dev_err(&pl08x->adev->dev,
-				"channel %s: circular buffers not supported\n",
-				chan->name);
-			kfree(chan);
-			continue;
-		}
 		dev_dbg(&pl08x->adev->dev,
 			 "initialize virtual channel \"%s\"\n",
 			 chan->name);
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index e64ce2c..22590cc 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -51,9 +51,6 @@ enum {
  * can be the address of a FIFO register for burst requests for example.
  * This can be left undefined if the PrimeCell API is used for configuring
  * this.
- * @circular_buffer: whether the buffer passed in is circular and
- * shall simply be looped round round (like a record baby round
- * round round round)
  * @single: the device connected to this channel will request single DMA
  * transfers, not bursts. (Bursts are default.)
  * @periph_buses: the device connected to this channel is accessible via
@@ -66,7 +63,6 @@ struct pl08x_channel_data {
 	u32 muxval;
 	u32 cctl;
 	dma_addr_t addr;
-	bool circular_buffer;
 	bool single;
 	u8 periph_buses;
 };
-- 
1.7.4.4
