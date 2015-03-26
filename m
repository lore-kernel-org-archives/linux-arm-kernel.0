From: sbranden@broadcom.com (Scott Branden)
Date: Thu, 26 Mar 2015 16:55:05 -0700
Subject: [PATCH] dmaengine: pl330: fix the race condition in pl330 driver.
Message-ID: <1427414105-3480-1-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: ismail <ismail@broadcom.com>

Update the thread running index before issuing the
GO command to the DMAC.

Tested-by: Mohamed Ismail Abdul Packir Mohamed <ismail@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Arun Parameswaran <aparames@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Mohamed Ismail Abdul Packir Mohamed <ismail@broadcom.com>
---
 drivers/dma/pl330.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 0e1f567..631642d 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1072,11 +1072,11 @@ static bool _trigger(struct pl330_thread *thrd)
 	/* Set to generate interrupts for SEV */
 	writel(readl(regs + INTEN) | (1 << thrd->ev), regs + INTEN);
 
+	thrd->req_running = idx;
+
 	/* Only manager can execute GO */
 	_execute_DBGINSN(thrd, insn, true);
 
-	thrd->req_running = idx;
-
 	return true;
 }
 
-- 
2.3.3
