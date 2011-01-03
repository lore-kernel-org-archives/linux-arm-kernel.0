From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:42:55 +0000
Subject: [PATCH 38/48] ARM: PL08x: fix fill_bytes calculation
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt79-0003Rs-7k@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The number of bytes we want to fill into any LLI is the minimum of:
- number of bytes remaining in the transfer
- number of bytes we can transfer in a single LLI
- number of bytes we can transfer without overflowing the source boundary
- number of bytes we can transfer without overflowing the destination boundary

The minimum of the first two is already calculated (target_len).  We
limit the boundary calculations to this number of bytes, which will
then give us the number of bytes we can place into this LLI.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   26 ++++++++++----------------
 1 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 91dd6bf..be7fa17 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -685,31 +685,25 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 			target_len = min(remainder, max_bytes_per_lli);
 
 			/*
-			 * Set bus lengths for incrementing buses
-			 * to number of bytes which fill to next memory
-			 * boundary
+			 * Set bus lengths for incrementing buses to the
+			 * number of bytes which fill to next memory boundary,
+			 * limiting on the target length calculated above.
 			 */
 			if (cctl & PL080_CONTROL_SRC_INCR)
 				txd->srcbus.fill_bytes =
-					pl08x_pre_boundary(
-						txd->srcbus.addr,
-						remainder);
+					pl08x_pre_boundary(txd->srcbus.addr,
+						target_len);
 			else
-				txd->srcbus.fill_bytes =
-					max_bytes_per_lli;
+				txd->srcbus.fill_bytes = target_len;
 
 			if (cctl & PL080_CONTROL_DST_INCR)
 				txd->dstbus.fill_bytes =
-					pl08x_pre_boundary(
-						txd->dstbus.addr,
-						remainder);
+					pl08x_pre_boundary(txd->dstbus.addr,
+						target_len);
 			else
-				txd->dstbus.fill_bytes =
-						max_bytes_per_lli;
+				txd->dstbus.fill_bytes = target_len;
 
-			/*
-			 *  Find the nearest
-			 */
+			/* Find the nearest */
 			lli_len	= min(txd->srcbus.fill_bytes,
 				txd->dstbus.fill_bytes);
 
-- 
1.6.2.5
