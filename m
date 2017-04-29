From: karim.eshapa@gmail.com (Karim Eshapa)
Date: Sat, 29 Apr 2017 21:46:04 +0200
Subject: [PATCH] drivers:soc:fsl:qbman:qman.c: Sleep instead of stuck hacking
 jiffies.
Message-ID: <1493495164-8658-1-git-send-email-karim.eshapa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the jiffies into usecs then use it with usleep_range
such that instead of stuck doing nothing until action happens,
sleep with range improves responsiveness and power usage
and avoid hacking jiffies. it's used for approximate time.
You can check /kernel/time/timer.c.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/soc/fsl/qbman/qman.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 6f509f6..e0df4d1 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1084,11 +1084,9 @@ static int drain_mr_fqrni(struct qm_portal *p)
 		 * entries well before the ring has been fully consumed, so
 		 * we're being *really* paranoid here.
 		 */
-		u64 now, then = jiffies;
+		unsigned int udel_time = jiffies_to_usecs(10000);
 
-		do {
-			now = jiffies;
-		} while ((then + 10000) > now);
+		usleep_range(udel_time/2, udel_time);
 		msg = qm_mr_current(p);
 		if (!msg)
 			return 0;
-- 
2.7.4
