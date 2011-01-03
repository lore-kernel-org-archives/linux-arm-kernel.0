From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:32:26 +0000
Subject: [PATCH 07/48] ARM: PL08x: fix deadlock in terminate_all
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZsx0-0001OK-0N@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trying to disable a tasklet while holding a spinlock which the tasklet
will take is a recipe for deadlock - tasklet_disable() will wait for the
tasklet to finish running, which it will never do.  In any case, there
is not a corresponding tasklet_enable(), so once the tasklet is disabled,
it will never run again until reboot.

It's safe to just remove the tasklet_disable() as we remove all current
and pending descriptors before releasing this spinlock.  This means that
the tasklet will find no remaining work if it subsequently runs.

The only remaining issue is that the callback for an already submitted
txd may be in progress, or even called after terminate_all() returns.
There's not much that can be done about that as waiting for the callback
to complete before returning will also lead to deadlocks.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 9a8d445..4ca1eb1 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1560,8 +1560,6 @@ static int pl08x_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 			pl08x_put_phy_channel(pl08x, plchan->phychan);
 			plchan->phychan = NULL;
 		}
-		/* Stop any pending tasklet */
-		tasklet_disable(&plchan->tasklet);
 		/* Dequeue jobs and free LLIs */
 		if (plchan->at) {
 			pl08x_free_txd(pl08x, plchan->at);
-- 
1.6.2.5
