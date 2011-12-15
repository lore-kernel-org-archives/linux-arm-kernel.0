From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 15 Dec 2011 10:22:20 +0900
Subject: [PATCH] DMA: PL330: Support MEMTOMEM transmit w/o RMB, WMB
Message-ID: <028f01ccbac7$fdb83d70$f928b850$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boojin Kim <boojin.kim@samsung.com>

The DMAC PL330 r1p0 version fixed the lockup error being on r0p0.
This patch supports the DMA transmission without memory barrier
operation when the revision of DMAC PL330 is the next of r0p0.

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
NOTE:
- I'm not sure the position of pl330.h header is proper...

 arch/arm/include/asm/hardware/pl330.h |    5 +++++
 drivers/dma/pl330.c                   |   26 +++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/hardware/pl330.h b/arch/arm/include/asm/hardware/pl330.h
index ed38e32..1f4d7cb 100644
--- a/arch/arm/include/asm/hardware/pl330.h
+++ b/arch/arm/include/asm/hardware/pl330.h
@@ -144,6 +144,11 @@ enum pl330_reqtype {
 #define CRD		0xe14
 
 #define PERIPH_ID	0xfe0
+#define PERIPH_REV_SHIFT	20
+#define PERIPH_REV_MASK		0xf
+#define PERIPH_REV_R0P0		0
+#define PERIPH_REV_R1P0		1
+#define PERIPH_REV_R1P1		2
 #define PCELL_ID	0xff0
 
 #define CR0_PERIPH_REQ_SET	(1 << 0)
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 3214ced..d87d884 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -129,6 +129,7 @@ struct pl330_reqcfg {
 	enum pl330_dstcachectrl dcctl;
 	enum pl330_srccachectrl scctl;
 	enum pl330_byteswap swap;
+	struct pl330_config *pcfg;
 };
 
 /*
@@ -438,6 +439,11 @@ static inline u32 get_id(struct pl330_info *pi, u32 off)
 	return id;
 }
 
+static inline u32 get_revision(u32 periph_id)
+{
+	return (periph_id >> PERIPH_REV_SHIFT) & PERIPH_REV_MASK;
+}
+
 static inline u32 _emit_ADDH(unsigned dry_run, u8 buf[],
 		enum pl330_dst da, u16 val)
 {
@@ -1026,12 +1032,21 @@ static inline int _ldst_memtomem(unsigned dry_run, u8 buf[],
 		const struct _xfer_spec *pxs, int cyc)
 {
 	int off = 0;
+	struct pl330_config *pcfg = pxs->r->cfg->pcfg;
 
-	while (cyc--) {
-		off += _emit_LD(dry_run, &buf[off], ALWAYS);
-		off += _emit_RMB(dry_run, &buf[off]);
-		off += _emit_ST(dry_run, &buf[off], ALWAYS);
-		off += _emit_WMB(dry_run, &buf[off]);
+	/* check lock-up free version */
+	if (get_revision(pcfg->periph_id) >= PERIPH_REV_R1P0) {
+		while (cyc--) {
+			off += _emit_LD(dry_run, &buf[off], ALWAYS);
+			off += _emit_ST(dry_run, &buf[off], ALWAYS);
+		}
+	} else {
+		while (cyc--) {
+			off += _emit_LD(dry_run, &buf[off], ALWAYS);
+			off += _emit_RMB(dry_run, &buf[off]);
+			off += _emit_ST(dry_run, &buf[off], ALWAYS);
+			off += _emit_WMB(dry_run, &buf[off]);
+		}
 	}
 
 	return off;
@@ -2398,6 +2413,7 @@ static struct dma_pl330_desc *pl330_get_desc(struct dma_pl330_chan *pch)
 	async_tx_ack(&desc->txd);
 
 	desc->req.peri = peri_id ? pch->chan.chan_id : 0;
+	desc->rqcfg.pcfg = &pch->dmac->pif.pcfg;
 
 	dma_async_tx_descriptor_init(&desc->txd, &pch->chan);
 
-- 
1.7.1
