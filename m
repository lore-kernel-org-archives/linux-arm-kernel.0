From: andre.przywara@linaro.org (Andre Przywara)
Date: Wed, 14 Aug 2013 14:52:08 +0200
Subject: [PATCH 1/2] DMA: fix AMBA PL08x driver issue with 64bit DMA address
 type
In-Reply-To: <1376484729-11826-1-git-send-email-andre.przywara@linaro.org>
References: <1376484729-11826-1-git-send-email-andre.przywara@linaro.org>
Message-ID: <1376484729-11826-2-git-send-email-andre.przywara@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Rob's recent pull request the patch
	ARM: highbank: select ARCH_DMA_ADDR_T_64BIT for LPAE
promotes dma_addr_t to 64bit, which breaks compilation of the
AMBA PL08x DMA driver.
GCC has no function for the 64bit/8bit modulo operation.
Looking more closely the divisor can only be 1, 2 or 4, so the full
featured '%' modulo operation is overkill and can be replaced by
simple bit masking.

Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
---
 drivers/dma/amba-pl08x.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 06fe45c..29e1cf9 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -286,6 +286,11 @@ static inline struct pl08x_txd *to_pl08x_txd(struct dma_async_tx_descriptor *tx)
 	return container_of(tx, struct pl08x_txd, vd.tx);
 }
 
+static int bus_addr_offset(struct pl08x_bus_data *bus)
+{
+	return bus->addr & (bus->buswidth - 1);
+}
+
 /*
  * Mux handling.
  *
@@ -886,8 +891,8 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 				return 0;
 			}
 
-			if ((bd.srcbus.addr % bd.srcbus.buswidth) ||
-					(bd.dstbus.addr % bd.dstbus.buswidth)) {
+			if (bus_addr_offset(&bd.srcbus) ||
+					bus_addr_offset(&bd.dstbus)) {
 				dev_err(&pl08x->adev->dev,
 					"%s src & dst address must be aligned to src"
 					" & dst width if peripheral is flow controller",
@@ -908,9 +913,8 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 		 */
 		if (bd.remainder < mbus->buswidth)
 			early_bytes = bd.remainder;
-		else if ((mbus->addr) % (mbus->buswidth)) {
-			early_bytes = mbus->buswidth - (mbus->addr) %
-				(mbus->buswidth);
+		else if (bus_addr_offset(mbus)) {
+			early_bytes = mbus->buswidth - bus_addr_offset(mbus);
 			if ((bd.remainder - early_bytes) < mbus->buswidth)
 				early_bytes = bd.remainder;
 		}
@@ -928,7 +932,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 			 * Master now aligned
 			 * - if slave is not then we must set its width down
 			 */
-			if (sbus->addr % sbus->buswidth) {
+			if (bus_addr_offset(sbus)) {
 				dev_dbg(&pl08x->adev->dev,
 					"%s set down bus width to one byte\n",
 					__func__);
-- 
1.7.12.1
