From: simon@sequanux.org (Simon Guinot)
Date: Fri, 17 Sep 2010 23:33:51 +0200
Subject: [PATCH] dmaengine: fix interrupt clearing for mv_xor
Message-ID: <1284759231-3188-1-git-send-email-simon@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Guinot <sguinot@lacie.com>

When using simultaneously the two DMA channels on a same engine, some
transfers are never completed. For example, an endless lock can occur
while writing heavily on a RAID5 array (with async-tx offload support
enabled).

Note that this issue can also be reproduced by using the DMA test
client.

On a same engine, the interrupt cause register is shared between two
DMA channels. This patch make sure that the cause bit is only cleared
for the requested channel.

Signed-off-by: Simon Guinot <sguinot@lacie.com>
Tested-by: Luc Saillard <luc@saillard.org>
---
 drivers/dma/mv_xor.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 86c5ae9..411d5bf 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -162,7 +162,7 @@ static int mv_is_err_intr(u32 intr_cause)
 
 static void mv_xor_device_clear_eoc_cause(struct mv_xor_chan *chan)
 {
-	u32 val = (1 << (1 + (chan->idx * 16)));
+	u32 val = ~(1 << (chan->idx * 16));
 	dev_dbg(chan->device->common.dev, "%s, val 0x%08x\n", __func__, val);
 	__raw_writel(val, XOR_INTR_CAUSE(chan));
 }
-- 
1.6.3.1
