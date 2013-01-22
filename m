From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Tue, 22 Jan 2013 13:09:22 +0530
Subject: [PATCH v5 23/45] [SCSI] fcoe: Use get/put_online_cpus_atomic() to
 prevent CPU offline
In-Reply-To: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20130122073919.13822.73176.stgit@srivatsabhat.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once stop_machine() is gone from the CPU offline path, we won't be able to
depend on preempt_disable() or local_irq_disable() to prevent CPUs from
going offline from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
while invoking from atomic context.

Cc: Robert Love <robert.w.love@intel.com>
Cc: "James E.J. Bottomley" <JBottomley@parallels.com>
Cc: devel at open-fcoe.org
Cc: linux-scsi at vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/scsi/fcoe/fcoe.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index 666b7ac..c971a17 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -1475,6 +1475,7 @@ static int fcoe_rcv(struct sk_buff *skb, struct net_device *netdev,
 	 * was originated, otherwise select cpu using rx exchange id
 	 * or fcoe_select_cpu().
 	 */
+	get_online_cpus_atomic();
 	if (ntoh24(fh->fh_f_ctl) & FC_FC_EX_CTX)
 		cpu = ntohs(fh->fh_ox_id) & fc_cpu_mask;
 	else {
@@ -1484,8 +1485,10 @@ static int fcoe_rcv(struct sk_buff *skb, struct net_device *netdev,
 			cpu = ntohs(fh->fh_rx_id) & fc_cpu_mask;
 	}
 
-	if (cpu >= nr_cpu_ids)
+	if (cpu >= nr_cpu_ids) {
+		put_online_cpus_atomic();
 		goto err;
+	}
 
 	fps = &per_cpu(fcoe_percpu, cpu);
 	spin_lock(&fps->fcoe_rx_list.lock);
@@ -1505,6 +1508,7 @@ static int fcoe_rcv(struct sk_buff *skb, struct net_device *netdev,
 		spin_lock(&fps->fcoe_rx_list.lock);
 		if (!fps->thread) {
 			spin_unlock(&fps->fcoe_rx_list.lock);
+			put_online_cpus_atomic();
 			goto err;
 		}
 	}
@@ -1526,6 +1530,7 @@ static int fcoe_rcv(struct sk_buff *skb, struct net_device *netdev,
 	if (fps->thread->state == TASK_INTERRUPTIBLE)
 		wake_up_process(fps->thread);
 	spin_unlock(&fps->fcoe_rx_list.lock);
+	put_online_cpus_atomic();
 
 	return 0;
 err:
