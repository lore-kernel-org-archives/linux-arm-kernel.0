From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Fri,  5 Aug 2016 10:53:22 +0800
Subject: [PATCH 3/3] dmaengine: pl330: support transfer unaligned with (burst
 len * burst size)
In-Reply-To: <1470365602-32586-1-git-send-email-shawn.lin@rock-chips.com>
References: <1470365602-32586-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1470365602-32586-4-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently pl330 doesn't support transfer which doesn't
align with burst len * burst size. This should be only
for single mode. Let's allow it for busrt mode if available.

e.g. transfers 0x10002 bytes:
First loop 256*16*16=0x10000, burst size is 1, burst length is 16.
Then the second loop 2 bytes, burst size is 1, burst length is 1.

f0041000:        DMAMOV CCR 0xbc02f1
f0041006:        DMAMOV SAR 0xdd6c0000
f004100c:        DMAMOV DAR 0xff1d0400
f0041012:        DMALP_0 15
f0041014:        DMALP_1 255
f0041016:        DMAWFPB 12
f0041018:        DMALDA
f0041019:        DMASTPB 12
f004101b:        DMAFLUSHP 12
f004101d:        DMALPENDA_1 bjmpto_7
f004101f:        DMALPENDA_0 bjmpto_b
f0041021:        DMAMOV CCR 0x800201
f0041027:        DMALP_1 1
f0041029:        DMAWFPB 12
f004102b:        DMALDA
f004102c:        DMASTPB 12
f004102e:        DMAFLUSHP 12
f0041030:        DMALPENDA_1 bjmpto_7
f0041032:        DMASEV 0
f0041034:        DMAEND

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/dma/pl330.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index a09bf22..cdb4afc 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -240,6 +240,7 @@ enum pl330_byteswap {
 
 #define BYTE_TO_BURST(b, ccr)	((b) / BRST_SIZE(ccr) / BRST_LEN(ccr))
 #define BURST_TO_BYTE(c, ccr)	((c) * BRST_SIZE(ccr) * BRST_LEN(ccr))
+#define BYTE_MOD_BURST_LEN(b, ccr)	(((b) / BRST_SIZE(ccr)) % BRST_LEN(ccr))
 
 /*
  * With 256 bytes, we can do more than 2.5MB and 5MB xfers per req
@@ -1331,6 +1332,19 @@ static inline int _setup_xfer(struct pl330_dmac *pl330,
 	/* Setup Loop(s) */
 	off += _setup_loops(pl330, dry_run, &buf[off], pxs);
 
+	if (pl330->peripherals_req_type == BURST) {
+		unsigned int ccr = pxs->ccr;
+		unsigned long c = 0;
+
+		c = BYTE_MOD_BURST_LEN(x->bytes, pxs->ccr);
+		if (c) {
+			ccr &= ~(0xf << CC_SRCBRSTLEN_SHFT);
+			ccr &= ~(0xf << CC_DSTBRSTLEN_SHFT);
+			off += _emit_MOV(dry_run, &buf[off], CCR, ccr);
+			off += _loop(pl330, dry_run, &buf[off], &c, pxs);
+		}
+	}
+
 	return off;
 }
 
@@ -1353,9 +1367,12 @@ static int _setup_req(struct pl330_dmac *pl330, unsigned dry_run,
 	off += _emit_MOV(dry_run, &buf[off], CCR, pxs->ccr);
 
 	x = &pxs->desc->px;
-	/* Error if xfer length is not aligned at burst size */
-	if (x->bytes % (BRST_SIZE(pxs->ccr) * BRST_LEN(pxs->ccr)))
-		return -EINVAL;
+
+	if (pl330->peripherals_req_type != BURST) {
+		/* Error if xfer length is not aligned at burst size */
+		if (x->bytes % (BRST_SIZE(pxs->ccr) * BRST_LEN(pxs->ccr)))
+			return -EINVAL;
+	}
 
 	off += _setup_xfer(pl330, dry_run, &buf[off], pxs);
 
-- 
2.3.7
