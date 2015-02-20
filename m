From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 20 Feb 2015 18:19:33 +0100
Subject: [RFC] Redesign drivers/dma/mmp_pdma
Message-ID: <8761aw8pqy.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel and Vinod,

This is what I have in mind for the next evolution of mmp_pdma. Aside from the
first parts of this document, I have questions in the second part I wish I had
comments for.

This is a pretty thick piece to injest, so take your time, I won't begin
submitting anything around mmp_pdma anymore until we have a good discussion
about it, at least with Daniel.

The root of this goes back to 2013 (references in [1]), where we had a
discussion between Daniel, Vinod and me, and where the conclusion was "DmaEngine
slave API permits pxa_camera to work as before", it's just I didn't take the
time to write down what was needed in the pxa dma driver to shift pxa_camera to
dmaengine, given my knowledge of pxa_camera dma handling.

Any comments are welcome, before I begin the actual work.

Cheers.

--
Robert

---8>---
>From 1c0b943a0f58fb7eb1aac9c58a61abe21cb13b95 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Fri, 20 Feb 2015 17:50:32 +0100
Subject: [PATCH] Documentation: dmaengine: mmp_pdma design

Document the new design of the mmp_pdma dma driver.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 Documentation/dmaengine/mmp_pdma.txt | 147 +++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)
 create mode 100644 Documentation/dmaengine/mmp_pdma.txt

diff --git a/Documentation/dmaengine/mmp_pdma.txt b/Documentation/dmaengine/mmp_pdma.txt
new file mode 100644
index 0000000..78ce486
--- /dev/null
+++ b/Documentation/dmaengine/mmp_pdma.txt
@@ -0,0 +1,147 @@
+PXA/MMP - DMA Slave controller
+==============================
+
+Constraints
+-----------
+  a) Transfers hot queuing
+     A driver submitting a transfer and issuing it should be granted the transfer
+     is queued even on a running DMA channel.
+     This implies that the queuing doesn't wait for the previous transfer end,
+     and that the descriptor chaining is not only done in the irq/tasklet code
+     triggered by the end of the transfer.
+
+  b) All transfers having asked for confirmation should be signaled
+     Any issued transfer with DMA_PREP_INTERRUPT should trigger a callback call.
+     This implies that even if an irq/tasklet is triggered by end of tx1, but
+     at the time of irq/dma tx2 is already finished, tx1->complete() and
+     tx2->complete() should be called.
+
+  c) Channel residue calculation
+     A channel should be able to report how much advanced is a transfer. The
+     granularity is still [TBD].
+
+  d) Channel running state
+     A driver should be able to query if a channel is running or not. For the
+     multimedia case, such as video capture, if a transfer is submitted and then
+     a check of the DMA channel reports a "stopped channel", the transfer should
+     not be issued until the next "start of frame interrupt", hence the need to
+     know if a channel is in running or stopped state.
+
+  e) Bandwidth guarantee
+     The PXA architecture has 3 levels of DMAs priorities : high, normal, low.
+     The high prorities get twice as much bandwith as the normal, which get twice
+     as much as the low priorities.
+     A driver should be able to request a priority, especially the real-time
+     ones such as pxa_camera with (big) throughputs.
+
+  f) Transfer reusability
+     An issued and finished transfer should be "reusable". The choice of
+     "DMA_CTRL_ACK" should be left to the client, not the dma driver.
+
+Design
+------
+  a) Virtual channels
+     Same concept as in sa11x0 driver, ie. a driver was assigned a "virtual
+     channel" linked to the requestor line, and the physical DMA channel is
+     assigned on the fly when the transfer is issued.
+
+  b) Transfer anatomy for a scatter-gather transfer
+     +------------+-----+---------------+----------------+-----------------+
+     | desc-sg[0] | ... | desc-sg[last] | status updater | finisher/linker |
+     +------------+-----+---------------+----------------+-----------------+
+
+     This structure is pointed by dma->sg_cpu.
+     The descriptors are used as follows :
+      - desc-sg[i]: i-th descriptor, transferring the i-th sg
+        element to the video buffer scatter gather
+      - status updater
+        Transfers a single u32 to a well known dma coherent memory to leave
+        a trace that this transfer is done. The "well known" is unique per
+        physical channel, meaning that a read of this value will tell which
+        is the last finished transfer at that point in time.
+      - finisher: has ddadr=DADDR_STOP, dcmd=ENDIRQEN
+      - linker: has ddadr= desc-sg[0] of next transfer, dcmd=0
+
+  b) Transfers hot-chaining
+     Suppose the running chain is :
+         Buffer 1         Buffer 2
+     +---------+----+---+  +----+----+----+---+
+     | d0 | .. | dN | l |  | d0 | .. | dN | f |
+     +---------+----+-|-+  ^----+----+----+---+
+                      |    |
+                      +----+
+    
+     After a call to dma_async_issue_pending(), the chain will look like :
+          Buffer 1              Buffer 2             Buffer 3
+     +---------+----+---+  +----+----+----+---+  +----+----+----+---+
+     | d0 | .. | dN | l |  | d0 | .. | dN | l |  | d0 | .. | dN | f |
+     +---------+----+-|-+  ^----+----+----+-|-+  ^----+----+----+---+
+                      |    |                |    |
+                      +----+                +----+
+                                           new_link
+
+     If while new_link was created the DMA channel stopped, it is reactivated
+     with DDADR = Buffer3.d0. To know if it stopped because Buffer3 was already
+     taken care of, see below "transfers completion updater".
+
+  c) Transfers completion updater
+     Each time a transfer is completed on a channel, an interrupt might be
+     generated or not, up to the client's request. But in each case, the last
+     descriptor of a transfer, the "status updater", will write the latest
+     transfer being completed into the physical channel's completion mark.
+
+     This will speed up residue calculation, for large transfers such as video
+     buffers which hold around 6k descriptors or more. This also allows without
+     any lock to find out what is the latest completed transfer in a running
+     DMA chain.
+
+  d) Transfers completion, irq and tasklet
+     When a transfer flagged as "DMA_PREP_INTERRUPT" is finished, the dma irq
+     is raised. Upon this interrupt, a tasklet is scheduled for the physical
+     channel.
+     The tasklet is responsible for :
+      - reading the physical channel last updater mark
+      - calling all the transfer callbacks of finished transfers, based on
+        that mark, and each transfer flags.
+     If a transfer is completed while this handling is done, a dma irq will
+     be raised, and the tasklet will be scheduled once again, having a new
+     updater mark.
+
+  e) Residue
+     Residue granularity will be descriptor based. The issued but not completed
+     transfers will be scanned for all of their descriptors against the
+     currently running descriptor.
+
+---
+This below will be dropped from the submission when the RFC will become a true patch.
+
+Remaining questions:
+-------------------
+  1) Given the number of things to be changed, is it still worth patching
+     existing mmp_pdma or develop a new driver : the main changes will come
+     from virt-dma usage, and the irq/tasklet/hot chaining revamp ?
+     I'm expecting around 50% of code reuse, future will tell ...
+
+  2) Cyclic transfers and residue calculation
+     For this iteration, I'll leave cyclic transfers as they are. But I was
+     wondering if it wouldn't make sense to allocate dma descriptors for
+     the _unique_ running cyclic transfer in a page, so that all the descriptors
+     are contiguous.
+     Of course, this would limit the span of a cyclic transfer to :
+     4096 / (32 * 4) * 4096 = 2097152 bytes
+     On the other hand, the residue calculation changes from a chained list
+     traversal to a simple (DDADR - desc0) / (32 * 4) * 4096, assuming all
+     scatter gather elements have the same 4k length ...
+
+     Now the question is, will it be worth it ?
+
+  3) DmaEngine and DMA_CTRL_ACK : this one is for Dan/Vinod
+     In Documentation/dmaengine/provider.txt, it is written that "DMA_CTRL_ACK":
+     "No one really has an idea of what it's about".
+     Actually that fits exactly one of my requirements : being able to reuse a
+     transfer without having to recalculate all the descriptors for it. The
+     rationale behind is that for video buffers, of 6k descriptors, the chain
+     is reused when the transfer is submitted/issued again, without having to
+     re-allocate and compose the whole descirptor links.
+
+     Is my understanding of what DMA_CTRL_ACK should mean correct ?
+ 
+  4) DmaEngine providing channels with properties
+     I need that the provided channel matches bandwidth criteria. It's not
+     doable to assign the most bandwidth capable channel to the first
+     requestor, but rather have the requestor ask for a "minimum" level of
+     priority (between low/medium/high).
+ 
+     How is this supposed to be done ?
-- 
2.1.0

-- 
Robert

[1] References
  http://lists.infradead.org/pipermail/linux-mtd/2013-August/047881.html
  http://lists.infradead.org/pipermail/linux-mtd/2013-August/048086.html
