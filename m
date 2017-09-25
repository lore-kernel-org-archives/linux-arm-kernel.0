From: awallis@codeaurora.org (Adam Wallis)
Date: Mon, 25 Sep 2017 08:26:05 -0400
Subject: [PATCH v3][for 4.14] xhci: allow TRACE to work with EVENT ring dequeue
Message-ID: <1506342365-11268-1-git-send-email-awallis@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

inc_deq() currently bails earlier for EVENT rings than the common return
point of the function, due to the fact that EVENT rings do not have
link TRBs. The unfortunate side effect of this is that the very useful
trace_xhci_inc_deq() function is not called/usable for EVENT ring
debug.

This patch provides a refactor by removing the multiple return exit
points into a single return which additionally allows for all rings to
use the trace function.

Signed-off-by: Adam Wallis <awallis@codeaurora.org>
---
Changes in v2: undo accidental line removal at end of patch
Changes in v3: reduced complexity by using goto as recommended by Mathias

 drivers/usb/host/xhci-ring.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index a944365..8d3df2f 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -171,13 +171,13 @@ static void inc_deq(struct xhci_hcd *xhci, struct xhci_ring *ring)
 	if (ring->type == TYPE_EVENT) {
 		if (!last_trb_on_seg(ring->deq_seg, ring->dequeue)) {
 			ring->dequeue++;
-			return;
+			goto out;
 		}
 		if (last_trb_on_ring(ring, ring->deq_seg, ring->dequeue))
 			ring->cycle_state ^= 1;
 		ring->deq_seg = ring->deq_seg->next;
 		ring->dequeue = ring->deq_seg->trbs;
-		return;
+		goto out;
 	}
 
 	/* All other rings have link trbs */
@@ -190,6 +190,7 @@ static void inc_deq(struct xhci_hcd *xhci, struct xhci_ring *ring)
 		ring->dequeue = ring->deq_seg->trbs;
 	}
 
+out:
 	trace_xhci_inc_deq(ring);
 
 	return;
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
