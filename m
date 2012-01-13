From: mans.rullgard@linaro.org (Mans Rullgard)
Date: Fri, 13 Jan 2012 12:36:31 +0000
Subject: [PATCH] ARM: pl330: fix null pointer dereference in pl330_chan_ctrl()
Message-ID: <1326458191-23492-1-git-send-email-mans.rullgard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the thrd->req_running field being accessed before thrd
is checked for null.  The error was introduced in abb959f.

Signed-off-by: Mans Rullgard <mans.rullgard@linaro.org>
---
 arch/arm/common/pl330.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/pl330.c b/arch/arm/common/pl330.c
index 8d8df74..67abef5 100644
--- a/arch/arm/common/pl330.c
+++ b/arch/arm/common/pl330.c
@@ -1496,12 +1496,13 @@ int pl330_chan_ctrl(void *ch_id, enum pl330_chan_op op)
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
1.7.8.3
