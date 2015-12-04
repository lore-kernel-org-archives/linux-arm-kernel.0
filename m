From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 04 Dec 2015 18:30:35 +0100
Subject: [PATCH v3 10/10] cpufreq: arm-big-little: accept operating-points-v2
 nodes
In-Reply-To: <1449250235-9613-1-git-send-email-b.zolnierkie@samsung.com>
References: <1449250235-9613-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1449250235-9613-11-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Gamari <ben@smart-cactus.org>

The arm_big_little cpufreq driver can use operating points from
operating-points-v2 nodes without any trouble.

Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Ben Gamari <ben@smart-cactus.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/cpufreq/arm_big_little_dt.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little_dt.c b/drivers/cpufreq/arm_big_little_dt.c
index 16ddeef..be7f632 100644
--- a/drivers/cpufreq/arm_big_little_dt.c
+++ b/drivers/cpufreq/arm_big_little_dt.c
@@ -35,12 +35,16 @@ static struct device_node *get_cpu_node_with_valid_op(int cpu)
 {
 	struct device_node *np = of_cpu_device_node_get(cpu);
 
-	if (!of_get_property(np, "operating-points", NULL)) {
-		of_node_put(np);
-		np = NULL;
+	if (of_get_property(np, "operating-points-v2", NULL)) {
+		return np;
 	}
 
-	return np;
+	if (of_get_property(np, "operating-points", NULL)) {
+		return np;
+	}
+
+	of_node_put(np);
+	return NULL;
 }
 
 static int dt_init_opp_table(struct device *cpu_dev)
-- 
1.9.1
