From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Fri, 28 Sep 2018 11:43:21 +0300
Subject: [PATCH v2 2/5] soc/fsl/qbman: replace CPU 0 with any online CPU in
 hotplug handlers
In-Reply-To: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
References: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
Message-ID: <1538124204-31406-3-git-send-email-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The existing code sets portal IRQ affinity to CPU 0 in the
offline hotplug handler. If CPU 0 is offline this is invalid.
Use a different online CPU instead.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/soc/fsl/qbman/bman_portal.c | 4 +++-
 drivers/soc/fsl/qbman/qman_portal.c | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
index 2f71f7df3465..088cdfa7c034 100644
--- a/drivers/soc/fsl/qbman/bman_portal.c
+++ b/drivers/soc/fsl/qbman/bman_portal.c
@@ -65,7 +65,9 @@ static int bman_offline_cpu(unsigned int cpu)
 	if (!pcfg)
 		return 0;
 
-	irq_set_affinity(pcfg->irq, cpumask_of(0));
+	/* use any other online CPU */
+	cpu = cpumask_any_but(cpu_online_mask, cpu);
+	irq_set_affinity(pcfg->irq, cpumask_of(cpu));
 	return 0;
 }
 
diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index a120002b630e..4efd6ea598b1 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -195,8 +195,10 @@ static int qman_offline_cpu(unsigned int cpu)
 	if (p) {
 		pcfg = qman_get_qm_portal_config(p);
 		if (pcfg) {
-			irq_set_affinity(pcfg->irq, cpumask_of(0));
-			qman_portal_update_sdest(pcfg, 0);
+			/* select any other online CPU */
+			cpu = cpumask_any_but(cpu_online_mask, cpu);
+			irq_set_affinity(pcfg->irq, cpumask_of(cpu));
+			qman_portal_update_sdest(pcfg, cpu);
 		}
 	}
 	return 0;
-- 
2.1.0
