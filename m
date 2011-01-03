From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:41:54 +0000
Subject: [PATCH 35/48] ARM: PL08x: make pl08x_fill_lli_for_desc() return void
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt6A-0003Rg-HZ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need pl08x_fill_lli_for_desc() to return num_llis + 1 as
we know that's what it always does.  We can just pass in num_llis
and use post-increment in the caller.

This makes the code slightly easier to read.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   30 ++++++++++++------------------
 1 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 660165d..f619404 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -521,9 +521,8 @@ static void pl08x_choose_master_bus(struct pl08x_bus_data *src_bus,
  * Fills in one LLI for a certain transfer descriptor
  * and advance the counter
  */
-static int pl08x_fill_lli_for_desc(struct pl08x_driver_data *pl08x,
-			    struct pl08x_txd *txd, int num_llis, int len,
-			    u32 cctl, u32 *remainder)
+static void pl08x_fill_lli_for_desc(struct pl08x_driver_data *pl08x,
+	struct pl08x_txd *txd, int num_llis, int len, u32 cctl, u32 *remainder)
 {
 	struct pl08x_lli *llis_va = txd->llis_va;
 	dma_addr_t llis_bus = txd->llis_bus;
@@ -545,8 +544,6 @@ static int pl08x_fill_lli_for_desc(struct pl08x_driver_data *pl08x,
 	BUG_ON(*remainder < len);
 
 	*remainder -= len;
-
-	return num_llis + 1;
 }
 
 /*
@@ -646,8 +643,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 				 "less than a bus width (remain 0x%08x)\n",
 				 __func__, remainder);
 			cctl = pl08x_cctl_bits(cctl, 1, 1, 1);
-			num_llis =
-				pl08x_fill_lli_for_desc(pl08x, txd, num_llis, 1,
+			pl08x_fill_lli_for_desc(pl08x, txd, num_llis++, 1,
 					cctl, &remainder);
 			total_bytes++;
 		}
@@ -662,8 +658,8 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 				 "(remain 0x%08x)\n",
 				 __func__, remainder);
 			cctl = pl08x_cctl_bits(cctl, 1, 1, 1);
-			num_llis = pl08x_fill_lli_for_desc
-				(pl08x, txd, num_llis, 1, cctl, &remainder);
+			pl08x_fill_lli_for_desc(pl08x, txd, num_llis++, 1,
+					cctl, &remainder);
 			total_bytes++;
 		}
 
@@ -787,9 +783,8 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 				dev_vdbg(&pl08x->adev->dev,
 					"%s fill lli with single lli chunk of size 0x%08zx (remainder 0x%08zx)\n",
 					__func__, lli_len, remainder);
-				num_llis = pl08x_fill_lli_for_desc(pl08x, txd,
-						num_llis, lli_len, cctl,
-						&remainder);
+				pl08x_fill_lli_for_desc(pl08x, txd, num_llis++,
+						lli_len, cctl, &remainder);
 				total_bytes += lli_len;
 			}
 
@@ -806,10 +801,9 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 					dev_vdbg(&pl08x->adev->dev,
 						"%s align with boundary, single byte (remain 0x%08zx)\n",
 						__func__, remainder);
-					num_llis =
-						pl08x_fill_lli_for_desc(pl08x,
-							txd, num_llis, 1,
-							cctl, &remainder);
+					pl08x_fill_lli_for_desc(pl08x, txd,
+							num_llis++, 1, cctl,
+							&remainder);
 					total_bytes++;
 				}
 			}
@@ -823,8 +817,8 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 			dev_vdbg(&pl08x->adev->dev,
 				"%s align with boundary, single odd byte (remain %zu)\n",
 				__func__, remainder);
-			num_llis = pl08x_fill_lli_for_desc(pl08x, txd, num_llis,
-					1, cctl, &remainder);
+			pl08x_fill_lli_for_desc(pl08x, txd, num_llis++, 1,
+					cctl, &remainder);
 			total_bytes++;
 		}
 	}
-- 
1.6.2.5
