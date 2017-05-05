From: karim.eshapa@gmail.com (Karim Eshapa)
Date: Fri,  5 May 2017 07:45:18 +0200
Subject: [PATCH v3] drivers:soc:fsl:qbman:qman.c: Sleep instead of stuck
 hacking jiffies.
In-Reply-To: <1493873917-7484-1-git-send-email-karim.eshapa@gmail.com>
References: <1493873917-7484-1-git-send-email-karim.eshapa@gmail.com>
Message-ID: <1493963118-11064-1-git-send-email-karim.eshapa@gmail.com>
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
