From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Dec 2015 16:34:28 +0100
Subject: [PATCH] dmaengine: at_hdmac: fix dma_addr_t printing
Message-ID: <24590899.3e2244jrdI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent patch tried to improve the printk output of the atc_dump_lli()
function but introduced a bug, in which we end up dereferencing a
dma address as a pointer, and we even get a warning for it:

drivers/dma/at_hdmac_regs.h: In function 'atc_dump_lli':
drivers/dma/at_hdmac_regs.h:388:4: warning: format '%p' expects argument of type 'void *', but argument 3 has type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]

This changes the code to pass the DMA address by reference, as expected
by printk.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 096117032a36 ("dmaengine: do not use 0x in front of %pad")
---
 drivers/dma/at_hdmac_regs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
index 610907dbc11a..0474e4a0f02a 100644
--- a/drivers/dma/at_hdmac_regs.h
+++ b/drivers/dma/at_hdmac_regs.h
@@ -386,8 +386,8 @@ static void atc_dump_lli(struct at_dma_chan *atchan, struct at_lli *lli)
 {
 	dev_crit(chan2dev(&atchan->chan_common),
 		 "  desc: s%pad d%pad ctrl0x%x:0x%x l%pad\n",
-		 lli->saddr, lli->daddr,
-		 lli->ctrla, lli->ctrlb, lli->dscr);
+		 &lli->saddr, &lli->daddr,
+		 lli->ctrla, lli->ctrlb, &lli->dscr);
 }
 
 
-- 
2.1.0.rc2
