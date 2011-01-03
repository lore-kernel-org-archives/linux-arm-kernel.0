From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:35:28 +0000
Subject: [PATCH 16/48] ARM: PL08x: avoid 'void *' struct fields when we can
	type them properly
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZszw-0001Ox-Tu@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid using 'void *' struct fields when the structs are not defined
in linux/amba/pl08x.h - instead, forward declare the struct names, and
use these instead.  This ensures we have proper typechecking.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |   16 ++++++++--------
 include/linux/amba/pl08x.h |    5 ++++-
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 707fa08..fada978 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -107,7 +107,7 @@ struct vendor_data {
  * An LLI struct - see PL08x TRM.  Note that next uses bit[0] as a bus bit,
  * start & end do not - their bus bit info is in cctl.
  */
-struct lli {
+struct pl08x_lli {
 	dma_addr_t src;
 	dma_addr_t dst;
 	dma_addr_t next;
@@ -160,7 +160,7 @@ struct pl08x_driver_data {
 
 /* Maximum times we call dma_pool_alloc on this pool without freeing */
 #define PL08X_MAX_ALLOCS	0x40
-#define MAX_NUM_TSFR_LLIS	(PL08X_LLI_TSFR_SIZE/sizeof(struct lli))
+#define MAX_NUM_TSFR_LLIS	(PL08X_LLI_TSFR_SIZE/sizeof(struct pl08x_lli))
 #define PL08X_ALIGN		8
 
 static inline struct pl08x_dma_chan *to_pl08x_chan(struct dma_chan *chan)
@@ -354,8 +354,8 @@ static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
 	 * currently active transaction.
 	 */
 	if (ch && txd) {
-		struct lli *llis_va = txd->llis_va;
-		struct lli *llis_bus = (struct lli *) txd->llis_bus;
+		struct pl08x_lli *llis_va = txd->llis_va;
+		struct pl08x_lli *llis_bus = (struct pl08x_lli *) txd->llis_bus;
 		u32 clli = readl(ch->base + PL080_CH_LLI);
 
 		/* First get the bytes in the current active LLI */
@@ -558,8 +558,8 @@ static int pl08x_fill_lli_for_desc(struct pl08x_driver_data *pl08x,
 			    struct pl08x_txd *txd, int num_llis, int len,
 			    u32 cctl, u32 *remainder)
 {
-	struct lli *llis_va = txd->llis_va;
-	struct lli *llis_bus = (struct lli *) txd->llis_bus;
+	struct pl08x_lli *llis_va = txd->llis_va;
+	struct pl08x_lli *llis_bus = (struct pl08x_lli *) txd->llis_bus;
 
 	BUG_ON(num_llis >= MAX_NUM_TSFR_LLIS);
 
@@ -620,8 +620,8 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	u32 cctl;
 	int max_bytes_per_lli;
 	int total_bytes = 0;
-	struct lli *llis_va;
-	struct lli *llis_bus;
+	struct pl08x_lli *llis_va;
+	struct pl08x_lli *llis_bus;
 
 	txd->llis_va = dma_pool_alloc(pl08x->pool, GFP_NOWAIT,
 				      &txd->llis_bus);
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 4ae62b4..3ecc20f 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -22,6 +22,9 @@
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
 
+struct pl08x_lli;
+struct pl08x_driver_data;
+
 /**
  * struct pl08x_channel_data - data structure to pass info between
  * platform and PL08x driver regarding channel configuration
@@ -179,7 +182,7 @@ struct pl08x_dma_chan {
 	struct pl08x_txd *at;
 	unsigned long lockflags;
 	spinlock_t lock;
-	void *host;
+	struct pl08x_driver_data *host;
 	enum pl08x_dma_chan_state state;
 	bool slave;
 	struct pl08x_txd *waiting;
-- 
1.6.2.5
