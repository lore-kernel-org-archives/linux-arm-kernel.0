From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:31:45 +0000
Subject: [PATCH 05/48] ARM: PL08x: fix a leak when preparing TXDs
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZswL-0001OB-3o@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we fail to allocate the LLI, the prep_* function will return NULL.
However, the TXD we allocated will not be placed on any list, nor
will it be freed - we'll just drop all references to it.  Make sure
we free it rather than leaking TXDs.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 69cfb05..b3b3180 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1332,9 +1332,10 @@ static int pl08x_prep_channel_resources(struct pl08x_dma_chan *plchan,
 	int ret;
 
 	num_llis = pl08x_fill_llis_for_desc(pl08x, txd);
-
-	if (!num_llis)
+	if (!num_llis) {
+		kfree(txd);
 		return -EINVAL;
+	}
 
 	spin_lock_irqsave(&plchan->lock, plchan->lockflags);
 
-- 
1.6.2.5
