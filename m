From: mans.rullgard@linaro.org (Mans Rullgard)
Date: Wed, 25 Jan 2012 12:11:32 +0000
Subject: [PATCH] DMA: pl330: fix null pointer dereference in pl330_chan_ctrl()
In-Reply-To: <4F11F963.4050900@ru.mvista.com>
References: <4F11F963.4050900@ru.mvista.com>
Message-ID: <1327493492-31274-1-git-send-email-mans.rullgard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the thrd->req_running field being accessed before thrd
is checked for null.  The error was introduced in abb959f
(ARM: 7237/1: PL330: Fix driver freeze).

Signed-off-by: Mans Rullgard <mans.rullgard@linaro.org>
---
 drivers/dma/pl330.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index add07e0..6278443 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1568,12 +1568,13 @@ static int pl330_chan_ctrl(void *ch_id, enum pl330_chan_op op)
 	struct pl330_thread *thrd = ch_id;
 	struct pl330_dmac *pl330;
 	unsigned long flags;
-	int ret = 0, active = thrd->req_running;
+	int ret = 0, active;
 
 	if (!thrd || thrd->free || thrd->dmac->state == DYING)
 		return -EINVAL;
 
 	pl330 = thrd->dmac;
+	active = thrd->req_running;
 
 	spin_lock_irqsave(&pl330->lock, flags);
 
-- 
1.7.8.4
