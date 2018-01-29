From: roy.pledge@nxp.com (Roy Pledge)
Date: Mon, 29 Jan 2018 14:47:53 -0500
Subject: [PATCH] soc/fsl/qbman: Check if CPU is offline when initializing
 portals
Message-ID: <1517255273-10178-1-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the affine portal for a specific CPU is offline at boot time
affine its interrupt to CPU 0. If the CPU is later brought online
the hotplug handler will correctly adjust the affinity.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/bman.c | 17 +++++++++++++----
 drivers/soc/fsl/qbman/qman.c | 18 +++++++++++++-----
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c
index f9485ce..2e6e682 100644
--- a/drivers/soc/fsl/qbman/bman.c
+++ b/drivers/soc/fsl/qbman/bman.c
@@ -562,10 +562,19 @@ static int bman_create_portal(struct bman_portal *portal,
 		dev_err(c->dev, "request_irq() failed\n");
 		goto fail_irq;
 	}
-	if (c->cpu != -1 && irq_can_set_affinity(c->irq) &&
-	    irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
-		dev_err(c->dev, "irq_set_affinity() failed\n");
-		goto fail_affinity;
+	if (cpu_online(c->cpu) && c->cpu != -1 &&
+	    irq_can_set_affinity(c->irq)) {
+		if (irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
+			dev_err(c->dev, "irq_set_affinity() failed %d\n",
+				c->cpu);
+			goto fail_affinity;
+		}
+	} else {
+		/* CPU is offline, direct IRQ to CPU 0 */
+		if (irq_set_affinity(c->irq, cpumask_of(0))) {
+			dev_err(c->dev, "irq_set_affinity() cpu 0 failed\n");
+			goto fail_affinity;
+		}
 	}
 
 	/* Need RCR to be empty before continuing */
diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index e4f5bb0..463e65d 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -935,7 +935,6 @@ static inline int qm_mc_result_timeout(struct qm_portal *portal,
 			break;
 		udelay(1);
 	} while (--timeout);
-
 	return timeout;
 }
 
@@ -1209,10 +1208,19 @@ static int qman_create_portal(struct qman_portal *portal,
 		dev_err(c->dev, "request_irq() failed\n");
 		goto fail_irq;
 	}
-	if (c->cpu != -1 && irq_can_set_affinity(c->irq) &&
-	    irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
-		dev_err(c->dev, "irq_set_affinity() failed\n");
-		goto fail_affinity;
+	if (cpu_online(c->cpu) && c->cpu != -1 &&
+	    irq_can_set_affinity(c->irq)) {
+		if (irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
+			dev_err(c->dev, "irq_set_affinity() failed %d\n",
+				c->cpu);
+			goto fail_affinity;
+		}
+	} else {
+		/* CPU is offline, direct IRQ to CPU 0 */
+		if (irq_set_affinity(c->irq, cpumask_of(0))) {
+			dev_err(c->dev, "irq_set_affinity() cpu 0 failed\n");
+			goto fail_affinity;
+		}
 	}
 
 	/* Need EQCR to be empty before continuing */
-- 
2.7.4
