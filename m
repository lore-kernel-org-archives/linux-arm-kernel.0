From: roy.pledge@nxp.com (Roy Pledge)
Date: Fri, 10 Mar 2017 15:15:04 -0500
Subject: [RESEND PATCH] soc/qbman: Disable IRQs for deferred QBMan work
Message-ID: <1489176904-16297-1-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Work for Congestion State Notifications (CSCN) and Message Ring (MR)
handling is handled via the workqueue mechanism. This requires the
driver to disable those IRQs before scheduling the work and re-enabling
it once the work is completed so that the interrupt doesn't continually
fire.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index d67b8e1..f1a242a 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1382,6 +1382,7 @@ static void qm_congestion_task(struct work_struct *work)
 	if (!qm_mc_result_timeout(&p->p, &mcr)) {
 		spin_unlock(&p->cgr_lock);
 		dev_crit(p->config->dev, "QUERYCONGESTION timeout\n");
+		qman_p_irqsource_add(p, QM_PIRQ_CSCI);
 		return;
 	}
 	/* mask out the ones I'm not interested in */
@@ -1396,6 +1397,7 @@ static void qm_congestion_task(struct work_struct *work)
 		if (cgr->cb && qman_cgrs_get(&c, cgr->cgrid))
 			cgr->cb(p, cgr, qman_cgrs_get(&rr, cgr->cgrid));
 	spin_unlock(&p->cgr_lock);
+	qman_p_irqsource_add(p, QM_PIRQ_CSCI);
 }
 
 static void qm_mr_process_task(struct work_struct *work)
@@ -1455,12 +1457,14 @@ static void qm_mr_process_task(struct work_struct *work)
 	}
 
 	qm_mr_cci_consume(&p->p, num);
+	qman_p_irqsource_add(p, QM_PIRQ_MRI);
 	preempt_enable();
 }
 
 static u32 __poll_portal_slow(struct qman_portal *p, u32 is)
 {
 	if (is & QM_PIRQ_CSCI) {
+		qman_p_irqsource_remove(p, QM_PIRQ_CSCI);
 		queue_work_on(smp_processor_id(), qm_portal_wq,
 			      &p->congestion_work);
 	}
@@ -1472,6 +1476,7 @@ static u32 __poll_portal_slow(struct qman_portal *p, u32 is)
 	}
 
 	if (is & QM_PIRQ_MRI) {
+		qman_p_irqsource_remove(p, QM_PIRQ_MRI);
 		queue_work_on(smp_processor_id(), qm_portal_wq,
 			      &p->mr_work);
 	}
-- 
1.7.9.5
