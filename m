From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jul 2011 17:11:46 +0100
Subject: [PATCH 2/9] DMA: PL08x: select LLI bus only once per LLI setup
In-Reply-To: <20110721160800.GR26574@n2100.arm.linux.org.uk>
References: <20110721160800.GR26574@n2100.arm.linux.org.uk>
Message-ID: <E1Qjvqk-0003ME-EX@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid re-selecting the LLI bus each time we create an LLI.  Move it out
of the LLI setup loops.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 90db51f..6808f7d 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -491,10 +491,10 @@ static inline u32 pl08x_cctl_bits(u32 cctl, u8 srcwidth, u8 dstwidth,
 
 struct pl08x_lli_build_data {
 	struct pl08x_txd *txd;
-	struct pl08x_driver_data *pl08x;
 	struct pl08x_bus_data srcbus;
 	struct pl08x_bus_data dstbus;
 	size_t remainder;
+	u32 lli_bus;
 };
 
 /*
@@ -547,8 +547,7 @@ static void pl08x_fill_lli_for_desc(struct pl08x_lli_build_data *bd,
 	llis_va[num_llis].src = bd->srcbus.addr;
 	llis_va[num_llis].dst = bd->dstbus.addr;
 	llis_va[num_llis].lli = llis_bus + (num_llis + 1) * sizeof(struct pl08x_lli);
-	if (bd->pl08x->lli_buses & PL08X_AHB2)
-		llis_va[num_llis].lli |= PL080_LLI_LM_AHB2;
+	llis_va[num_llis].lli |= bd->lli_bus;
 
 	if (cctl & PL080_CONTROL_SRC_INCR)
 		bd->srcbus.addr += len;
@@ -601,9 +600,9 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	cctl = txd->cctl;
 
 	bd.txd = txd;
-	bd.pl08x = pl08x;
 	bd.srcbus.addr = txd->src_addr;
 	bd.dstbus.addr = txd->dst_addr;
+	bd.lli_bus = (pl08x->lli_buses & PL08X_AHB2) ? PL080_LLI_LM_AHB2 : 0;
 
 	/* Find maximum width of the source bus */
 	bd.srcbus.maxwidth =
-- 
1.7.4.4
