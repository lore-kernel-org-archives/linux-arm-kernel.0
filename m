From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Thu, 23 Aug 2018 23:35:59 +0200
Subject: [PATCH 1/2] soc: fsl: qbman: qman_portal: defer probing when qman is
 not available
Message-ID: <20180823213600.23426-1-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the qman driver (qman_ccsr) doesn't probe or fail to probe before
qman_portal, qm_ccsr_start will be either NULL or a stale pointer to an
unmapped page.

This leads to a crash when probing  qman_portal as the init_pcfg function
calls qman_liodn_fixup that tries to read qman registers.

Assume that qman didn't probe when the pool mask is 0.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/soc/fsl/qbman/qman_portal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index a120002b630e..4fc80d2c8feb 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -277,6 +277,8 @@ static int qman_portal_probe(struct platform_device *pdev)
 	}
 
 	pcfg->pools = qm_get_pools_sdqcr();
+	if (pcfg->pools == 0)
+		return -EPROBE_DEFER;
 
 	spin_lock(&qman_lock);
 	cpu = cpumask_next_zero(-1, &portal_cpus);
-- 
2.18.0
