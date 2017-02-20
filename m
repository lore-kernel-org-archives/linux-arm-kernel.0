From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Mon, 20 Feb 2017 14:10:07 +0100
Subject: [PATCH v2] mtd: nand: tango: Enforce DMA direction type
In-Reply-To: <20170220133547.06c17a12@bbrezillon>
References: <1486979107-15362-1-git-send-email-boris.brezillon@free-electrons.com>
 <aebe65d0-19c9-e1a7-b98a-c25ff616dad0@sigmadesigns.com>
 <20170220133547.06c17a12@bbrezillon>
Message-ID: <72b68483-8a02-f6b8-f6b7-da492585c802@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>

do_dma() uses an int to pass the DMA data direction information and
pass the same value to dmaengine_prep_slave_sg().

Currently, DMA_{FROM,TO}_DEVICE match DMA_{DEV_TO_MEM,MEM_TO_DEV}
definitions so it works fine, but assuming this will always be the case
is not safe.

Enforce enum dma_data_direction type in the function prototype and make
the enum dma_data_direction -> enum dma_transfer_direction conversion
explicit.

Reported-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 drivers/mtd/nand/tango_nand.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/tango_nand.c b/drivers/mtd/nand/tango_nand.c
index 4a5e948c62df..05b6e1065203 100644
--- a/drivers/mtd/nand/tango_nand.c
+++ b/drivers/mtd/nand/tango_nand.c
@@ -223,12 +223,13 @@ static void tango_dma_callback(void *arg)
 	complete(arg);
 }
 
-static int do_dma(struct tango_nfc *nfc, int dir, int cmd, const void *buf,
-		  int len, int page)
+static int do_dma(struct tango_nfc *nfc, enum dma_data_direction dir, int cmd,
+		  const void *buf, int len, int page)
 {
 	void __iomem *addr = nfc->reg_base + NFC_STATUS;
 	struct dma_chan *chan = nfc->chan;
 	struct dma_async_tx_descriptor *desc;
+	enum dma_transfer_direction tdir;
 	struct scatterlist sg;
 	struct completion tx_done;
 	int err = -EIO;
@@ -238,7 +239,8 @@ static int do_dma(struct tango_nfc *nfc, int dir, int cmd, const void *buf,
 	if (dma_map_sg(chan->device->dev, &sg, 1, dir) != 1)
 		return -EIO;
 
-	desc = dmaengine_prep_slave_sg(chan, &sg, 1, dir, DMA_PREP_INTERRUPT);
+	tdir = dir == DMA_TO_DEVICE ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
+	desc = dmaengine_prep_slave_sg(chan, &sg, 1, tdir, DMA_PREP_INTERRUPT);
 	if (!desc)
 		goto dma_unmap;
 
-- 
3.14159265358979
