From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Fri, 31 Aug 2018 16:11:09 +0800
Subject: [PATCH net-next v2 3/3] net: mvneta: reduce smp_processor_id()
 calling in mvneta_tx_done_gbe
In-Reply-To: <20180831160810.2539ef4c@xhacker.debian>
References: <20180831160810.2539ef4c@xhacker.debian>
Message-ID: <20180831161109.23db0901@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the loop of mvneta_tx_done_gbe(), we call the smp_processor_id()
each time, move the call out of the loop to optimize the code a bit.

Before the patch, the loop looks like(under arm64):

        ldr     x1, [x29,#120]
        ...
        ldr     w24, [x1,#36]
        ...
        bl      0 <_raw_spin_lock>
        str     w24, [x27,#132]
        ...

After the patch, the loop looks like(under arm64):

        ...
        bl      0 <_raw_spin_lock>
        str     w23, [x28,#132]
        ...
where w23 is loaded so be ready before the loop.

>From another side, mvneta_tx_done_gbe() is called from mvneta_poll()
which is in non-preemptible context, so it's safe to call the
smp_processor_id() function once.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index bcd20ebb2ebd..fe3edb3c2bf4 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2507,12 +2507,13 @@ static void mvneta_tx_done_gbe(struct mvneta_port *pp, u32 cause_tx_done)
 {
 	struct mvneta_tx_queue *txq;
 	struct netdev_queue *nq;
+	int cpu = smp_processor_id();
 
 	while (cause_tx_done) {
 		txq = mvneta_tx_done_policy(pp, cause_tx_done);
 
 		nq = netdev_get_tx_queue(pp->dev, txq->id);
-		__netif_tx_lock(nq, smp_processor_id());
+		__netif_tx_lock(nq, cpu);
 
 		if (txq->count)
 			mvneta_txq_done(pp, txq);
-- 
2.18.0
