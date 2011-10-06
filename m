From: javi.merino@arm.com (Javi Merino)
Date: Thu,  6 Oct 2011 10:10:06 +0100
Subject: [PATCH v2] ARM: pl330: Fix a race condition
In-Reply-To: <4E8C5425.80303@arm.com>
References: <4E8C5425.80303@arm.com>
Message-ID: <1317892206-3600-1-git-send-email-javi.merino@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If two requests have been submitted and one of them is running, if you
call pl330_chan_ctrl(ch_id, PL330_OP_START), there's a window of time
between the spin_lock_irqsave() and the _state() check in which the
running transaction may finish.  In that case, we don't receive the
interrupt (because they are disabled), but _start() sees that the DMA
is stopped, so it starts it.  The problem is that it sends the
transaction that has just finished again, because pl330_update()
hasn't mark it as done yet.

This patch fixes this race condition by not calling _start() if the
DMA is already executing transactions.  When interrupts are reenabled,
pl330_update() will call _start().

Signed-off-by: Javi Merino <javi.merino@arm.com>
Acked-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/common/pl330.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/pl330.c b/arch/arm/common/pl330.c
index 97912fa..7129cfb 100644
--- a/arch/arm/common/pl330.c
+++ b/arch/arm/common/pl330.c
@@ -1546,7 +1546,7 @@ int pl330_chan_ctrl(void *ch_id, enum pl330_chan_op op)
 
 		/* Start the next */
 	case PL330_OP_START:
-		if (!_start(thrd))
+		if (!_thrd_active(thrd) && !_start(thrd))
 			ret = -EIO;
 		break;
 
-- 
1.7.0.4
