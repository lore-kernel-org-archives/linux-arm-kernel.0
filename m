From: karim.eshapa@gmail.com (Karim Eshapa)
Date: Sun, 25 Jun 2017 17:13:42 +0200
Subject: [PATCH] soc/qman: Sleep instead of stuck hacking jiffies.
Message-ID: <1498403622-2878-1-git-send-email-karim.eshapa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use msleep() instead of stucking with
long delay will be more efficient.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/soc/fsl/qbman/qman.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 3d891db..18d391e 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1084,11 +1084,7 @@ static int drain_mr_fqrni(struct qm_portal *p)
 		 * entries well before the ring has been fully consumed, so
 		 * we're being *really* paranoid here.
 		 */
-		u64 now, then = jiffies;
-
-		do {
-			now = jiffies;
-		} while ((then + 10000) > now);
+		msleep(1);
 		msg = qm_mr_current(p);
 		if (!msg)
 			return 0;
-- 
2.7.4
