From: karim.eshapa@gmail.com (Karim Eshapa)
Date: Fri,  5 May 2017 10:05:56 +0200
Subject: [PATCH] drivers:soc:fsl:qbman:qman.c: Change a comment for an entry
 check inside drain_mr_fqrni function
Message-ID: <1493971556-14918-1-git-send-email-karim.eshapa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the comment for an entry check inside function
drain_mr_fqrni() with sleep for sufficient period
of time instead of long time proccessor cycles.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/soc/fsl/qbman/qman.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 18d391e..636a7d7 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1071,18 +1071,19 @@ static int drain_mr_fqrni(struct qm_portal *p)
 	msg = qm_mr_current(p);
 	if (!msg) {
 		/*
-		 * if MR was full and h/w had other FQRNI entries to produce, we
-		 * need to allow it time to produce those entries once the
-		 * existing entries are consumed. A worst-case situation
-		 * (fully-loaded system) means h/w sequencers may have to do 3-4
-		 * other things before servicing the portal's MR pump, each of
-		 * which (if slow) may take ~50 qman cycles (which is ~200
-		 * processor cycles). So rounding up and then multiplying this
-		 * worst-case estimate by a factor of 10, just to be
-		 * ultra-paranoid, goes as high as 10,000 cycles. NB, we consume
-		 * one entry at a time, so h/w has an opportunity to produce new
-		 * entries well before the ring has been fully consumed, so
-		 * we're being *really* paranoid here.
+		 * if MR was full and h/w had other FQRNI entries to
+		 * produce, we need to allow it time to produce those
+		 * entries once the existing entries are consumed.
+		 * A worst-case situation (fully-loaded system) means
+		 * h/w sequencers may have to do 3-4 other things
+		 * before servicing the portal's MR pump, each of
+		 * which (if slow) may take ~50 qman cycles
+		 * (which is ~200 processor cycles). So sleep with
+		 * 1 ms would be very efficient, after this period
+		 * we can check if there is something produced.
+		 * NB, we consume one entry at a time, so h/w has
+		 * an opportunity to produce new entries well before
+		 * the ring has been fully consumed.
 		 */
 		msleep(1);
 		msg = qm_mr_current(p);
-- 
2.7.4
