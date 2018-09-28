From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Fri, 28 Sep 2018 11:43:20 +0300
Subject: [PATCH v2 1/5] soc/fsl/qbman: Check if CPU is offline when
 initializing portals
In-Reply-To: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
References: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
Message-ID: <1538124204-31406-2-git-send-email-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roy Pledge <roy.pledge@nxp.com>

If the CPU to affine the portal interrupt is offline at boot time
affine the portal interrupt to another online CPU. If the CPU is later
brought online the hotplug handler will correctly adjust the affinity.
Moved common code in a function.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/soc/fsl/qbman/bman.c     |  6 ++----
 drivers/soc/fsl/qbman/dpaa_sys.h | 20 ++++++++++++++++++++
 drivers/soc/fsl/qbman/qman.c     |  6 ++----
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c
index f9485cedc648..f84ab596bde8 100644
--- a/drivers/soc/fsl/qbman/bman.c
+++ b/drivers/soc/fsl/qbman/bman.c
@@ -562,11 +562,9 @@ static int bman_create_portal(struct bman_portal *portal,
 		dev_err(c->dev, "request_irq() failed\n");
 		goto fail_irq;
 	}
-	if (c->cpu != -1 && irq_can_set_affinity(c->irq) &&
-	    irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
-		dev_err(c->dev, "irq_set_affinity() failed\n");
+
+	if (dpaa_set_portal_irq_affinity(c->dev, c->irq, c->cpu))
 		goto fail_affinity;
-	}
 
 	/* Need RCR to be empty before continuing */
 	ret = bm_rcr_get_fill(p);
diff --git a/drivers/soc/fsl/qbman/dpaa_sys.h b/drivers/soc/fsl/qbman/dpaa_sys.h
index 9f379000da85..ae8afa552b1e 100644
--- a/drivers/soc/fsl/qbman/dpaa_sys.h
+++ b/drivers/soc/fsl/qbman/dpaa_sys.h
@@ -111,4 +111,24 @@ int qbman_init_private_mem(struct device *dev, int idx, dma_addr_t *addr,
 #define QBMAN_MEMREMAP_ATTR	MEMREMAP_WC
 #endif
 
+static inline int dpaa_set_portal_irq_affinity(struct device *dev,
+					       int irq, int cpu)
+{
+	int ret = 0;
+
+	if (!irq_can_set_affinity(irq)) {
+		dev_err(dev, "unable to set IRQ affinity\n");
+		return -EINVAL;
+	}
+
+	if (cpu == -1 || !cpu_online(cpu))
+		cpu = cpumask_any(cpu_online_mask);
+
+	ret = irq_set_affinity(irq, cpumask_of(cpu));
+	if (ret)
+		dev_err(dev, "irq_set_affinity() on CPU %d failed\n", cpu);
+
+	return ret;
+}
+
 #endif	/* __DPAA_SYS_H */
diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index ecb22749df0b..0ffe7a1d0eae 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1210,11 +1210,9 @@ static int qman_create_portal(struct qman_portal *portal,
 		dev_err(c->dev, "request_irq() failed\n");
 		goto fail_irq;
 	}
-	if (c->cpu != -1 && irq_can_set_affinity(c->irq) &&
-	    irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
-		dev_err(c->dev, "irq_set_affinity() failed\n");
+
+	if (dpaa_set_portal_irq_affinity(c->dev, c->irq, c->cpu))
 		goto fail_affinity;
-	}
 
 	/* Need EQCR to be empty before continuing */
 	isdr &= ~QM_PIRQ_EQCI;
-- 
2.1.0
