From: addy.ke@rock-chips.com (Addy Ke)
Date: Mon,  8 Dec 2014 19:28:20 +0800
Subject: [PATCH] dmaengine: pl330: fix bug that cause start the same descs in
 cyclic
Message-ID: <1418038100-4316-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This bug will cause NULL pointer after commit dfac17, and cause
wrong package in I2S DMA transfer before commit dfac17.

Tested on RK3288-pinky2 board.

Detail:
I2S DMA transfer(sound/core/pcm_dmaengine.c):
dmaengine_pcm_prepare_and_submit -->
dmaengine_prep_dma_cyclic -->
pl330_prep_dma_cyclic -->
the case:
1. pl330_submit_req(desc0): thrd->req[0].desc = desc0, thrd->lstenq = 0
2. pl330_submit_req(desc1): thrd->req[1].desc = desc1, thrd->lstenq = 1
3. _start(desc0) by submit_req: thrd->req_running = 0
   because: idx = 1 - thrd->lstenq = 0
4. pl330_update(desc0 OK): thrd->req[0].desc = NULL, desc0 to req_done list
   because: idx = active = thrd->req_running = 0
5. _start(desc1) by pl330_update: thrd->req_running = 1
   because:
   idx = 1 - thrd->lstenq = 0, but thrd->req[0].desc == NULL,
   so:
   idx = thrd->lstenq = 1
6. pl330_submit_req(desc2): thrd->req[0].desc = desc2, thrd->lstenq = 0
7. _start(desc1) by submit_req: thrd->req_running = 1
   because: idx = 1 - thrd->lstenq = 1
   Note: _start started the same descs
         _start should start desc2 here, NOT desc1

8. pl330_update(desc1 OK): thrd->req[1].desc = NULL, desc1 to req_done list
   because: idx = active = thrd->req_running = 1
9. _start(desc2) by pl330_update : thrd->req_running = 0
   because: idx = 1 - thrd->lstenq = 0
10.pl330_update(desc1 OK, NOT desc2): thrd->req[0].desc = NULL,
   desc2 to req_done list
   because: idx = active = thrd->req_running = 0

11.pl330_submit_req(desc3): thrd->req[0].desc = desc3, thrd->lstenq = 0
12.pl330_submit_req(desc4): thrd->req[1].desc = desc4, thrd->lstenq = 1
13._start(desc3) by submit_req: thrd->req_running = 0
   because: idx = 1 - thrd->lstenq = 0
14.pl330_update(desc2 OK NOT desc3): thrd->req[0].desc = NULL
   desc3 to req_done list
   because: idx = active = thrd->req_running = 0
15._start(desc4) by pl330_update: thrd->req_running = 1
   because:
   idx = 1 - thrd->lstenq = 0, but thrd->req[0].desc == NULL,
   so:
   idx = thrd->lstenq = 1
16.pl330_submit_req(desc5): thrd->req[0].desc = desc5, thrd->lstenq = 0
17._start(desc4) by submit_req: thrd->req_running = 1
   because: idx = 1 - thrd->lstenq = 1
18.pl330_update(desc3 OK NOT desc4): thrd->req[1].desc = NULL
   desc4 to req_done list
   because: idx = active = thrd->req_running = 1
19._start(desc4) by pl330_update: thrd->req_running = 0
   because:
   idx = 1 - thrd->lstenq = 1, but thrd->req[1].desc == NULL,
   so:
   idx = thrd->lstenq = 0
20.pl330_update(desc4 OK): thrd->req[0].desc = NULL, desc5 to req_done list
   because: idx = active = thrd->req_running = 0
21.pl330_update(desc4 OK):
   1) before commit dfac17(set req_running -1 in pl330_update/mark_free()):
      because: active = -1, abort
      result: desc0-desc5's callback are all called,
	      but step 10 and step 18 go wrong.
   2) before commit dfac17:
      idx = active = thrd->req_runnig = 0 -->
      descdone = thrd->req[0] = NULL -->
      list_add_tail(&descdone->rqd, &pl330->req_done); -->
      got NULL pointer!!!

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
 drivers/dma/pl330.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 025b905..0773832 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1044,6 +1044,10 @@ static bool _trigger(struct pl330_thread *thrd)
 	if (!req)
 		return true;
 
+	/* Return if req is running */
+	if (idx == thrd->req_running)
+		return true;
+
 	desc = req->desc;
 
 	ns = desc->rqcfg.nonsecure ? 1 : 0;
@@ -1583,6 +1587,8 @@ static int pl330_update(struct pl330_dmac *pl330)
 			descdone = thrd->req[active].desc;
 			thrd->req[active].desc = NULL;
 
+			thrd->req_running = -1;
+
 			/* Get going again ASAP */
 			_start(thrd);
 
-- 
1.8.3.2
