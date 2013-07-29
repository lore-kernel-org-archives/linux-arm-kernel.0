From: joelf@ti.com (Joel Fernandes)
Date: Mon, 29 Jul 2013 08:29:54 -0500
Subject: [PATCH 8/9] dma: edma: Link to dummy slot only for last SG list split
In-Reply-To: <1375104595-16018-1-git-send-email-joelf@ti.com>
References: <1375104595-16018-1-git-send-email-joelf@ti.com>
Message-ID: <1375104595-16018-9-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Consider the case where we have a scatter-list like:
SG1->SG2->SG3->SG4->SG5->SG6->Null

For ex, for a MAX_NR_SG of 2, earlier we were splitting this as:
SG1->SG2->Null
SG3->SG4->Null
SG5->SG6->Null

Now we split it as
SG1->SG2->Null
SG3->SG4->Null
SG5->SG6->Dummy

This approach results in lesser unwanted interrupts that occur
for the last list split. The Dummy slot has the property of not
raising an error condition if events are missed unlike the Null
slot. We are OK with this as we're done with processing the
whole list once we reach Dummy.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 drivers/dma/edma.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index c72e8c9..0d3ebde 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -164,6 +164,12 @@ static void edma_execute(struct edma_chan *echan)
 
 	edesc->total_processed += total_process;
 
+	/* If this is either the last set in a set of SG-list transactions
+	   then setup a link to the dummy slot, this results in all future
+	   events being absorbed and that's OK because we're done */
+	if (edesc->total_processed == edesc->pset_nr)
+		edma_link(echan->slot[total_process-1], echan->ecc->dummy_slot);
+
 	edma_resume(echan->ch_num);
 
 	if (edesc->total_processed <= MAX_NR_SG) {
-- 
1.7.9.5
