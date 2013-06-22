From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 22 Jun 2013 22:42:37 +0200
Subject: [RFC PATCH v2 05/12] dmaengine: PL08x: Add support for different
 maximum transfer size
In-Reply-To: <1371933764-24875-1-git-send-email-tomasz.figa@gmail.com>
References: <1371933764-24875-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1371933764-24875-6-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PL080S has separate register to store transfer size in, allowing single
transfer to be much larger than in standard PL080.

This patch makes the amba-pl08x driver aware of this and removes writing
transfer size to reserved bits of CH_CONTROL register on PL080S, which
was not a problem witn transfer sizes fitting the original bitfield
of PL080, but now would overwrite other fields.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/dma/amba-pl08x.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 103bc1a..89b8120 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -122,6 +122,7 @@ struct vendor_data {
 	bool dualmaster;
 	bool nomadik;
 	bool pl080s;
+	u32 max_transfer_size;
 };
 
 	u32 cctl1;
@@ -772,6 +773,7 @@ static inline u32 pl08x_cctl_bits(u32 cctl, u8 srcwidth, u8 dstwidth,
 		break;
 	}
 
+	tsize &= PL080_CONTROL_TRANSFER_SIZE_MASK;
 	retbits |= tsize << PL080_CONTROL_TRANSFER_SIZE_SHIFT;
 	return retbits;
 }
@@ -1001,7 +1003,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 			 * MIN(buswidths)
 			 */
 			max_bytes_per_lli = bd.srcbus.buswidth *
-				PL080_CONTROL_TRANSFER_SIZE_MASK;
+						pl08x->vd->max_transfer_size;
 			dev_vdbg(&pl08x->adev->dev,
 				"%s max bytes per lli = %zu\n",
 				__func__, max_bytes_per_lli);
@@ -2111,6 +2113,7 @@ static struct vendor_data vendor_pl080 = {
 	.config_offset = PL080_CH_CONFIG,
 	.channels = 8,
 	.dualmaster = true,
+	.max_transfer_size = PL080_CONTROL_TRANSFER_SIZE_MASK,
 };
 
 static struct vendor_data vendor_nomadik = {
@@ -2118,18 +2121,21 @@ static struct vendor_data vendor_nomadik = {
 	.channels = 8,
 	.dualmaster = true,
 	.nomadik = true,
+	.max_transfer_size = PL080_CONTROL_TRANSFER_SIZE_MASK,
 };
 
 static struct vendor_data vendor_pl080s = {
 	.config_offset = PL080S_CH_CONFIG,
 	.channels = 8,
 	.pl080s = true,
+	.max_transfer_size = PL080S_CONTROL_TRANSFER_SIZE_MASK,
 };
 
 static struct vendor_data vendor_pl081 = {
 	.config_offset = PL080_CH_CONFIG,
 	.channels = 2,
 	.dualmaster = false,
+	.max_transfer_size = PL080_CONTROL_TRANSFER_SIZE_MASK,
 };
 
 static struct amba_id pl08x_ids[] = {
-- 
1.8.2.1
