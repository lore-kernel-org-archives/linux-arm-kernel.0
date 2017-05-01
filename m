From: roy.pledge@nxp.com (Roy Pledge)
Date: Mon, 1 May 2017 17:30:06 -0400
Subject: [PATCH v3 04/11] soc/fsl/qbman: Drop set/clear_bits usage
In-Reply-To: <1493674213-963-1-git-send-email-roy.pledge@nxp.com>
References: <1493674213-963-1-git-send-email-roy.pledge@nxp.com>
Message-ID: <1493674213-963-5-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Madalin Bucur <madalin.bucur@nxp.com>

Replace PPC specific set/clear_bits API with standard
bit twiddling so driver is portalable outside PPC.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/bman.c | 2 +-
 drivers/soc/fsl/qbman/qman.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c
index a3d6d7c..3acded1 100644
--- a/drivers/soc/fsl/qbman/bman.c
+++ b/drivers/soc/fsl/qbman/bman.c
@@ -607,7 +607,7 @@ int bman_p_irqsource_add(struct bman_portal *p, u32 bits)
 	unsigned long irqflags;
 
 	local_irq_save(irqflags);
-	set_bits(bits & BM_PIRQ_VISIBLE, &p->irq_sources);
+	p->irq_sources |= bits & BM_PIRQ_VISIBLE;
 	bm_out(&p->p, BM_REG_IER, p->irq_sources);
 	local_irq_restore(irqflags);
 	return 0;
diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 3d891db..3f60289 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -909,12 +909,12 @@ static inline int qm_mc_result_timeout(struct qm_portal *portal,
 
 static inline void fq_set(struct qman_fq *fq, u32 mask)
 {
-	set_bits(mask, &fq->flags);
+	fq->flags |= mask;
 }
 
 static inline void fq_clear(struct qman_fq *fq, u32 mask)
 {
-	clear_bits(mask, &fq->flags);
+	fq->flags &= ~mask;
 }
 
 static inline int fq_isset(struct qman_fq *fq, u32 mask)
@@ -1561,7 +1561,7 @@ void qman_p_irqsource_add(struct qman_portal *p, u32 bits)
 	unsigned long irqflags;
 
 	local_irq_save(irqflags);
-	set_bits(bits & QM_PIRQ_VISIBLE, &p->irq_sources);
+	p->irq_sources |= bits & QM_PIRQ_VISIBLE;
 	qm_out(&p->p, QM_REG_IER, p->irq_sources);
 	local_irq_restore(irqflags);
 }
@@ -1584,7 +1584,7 @@ void qman_p_irqsource_remove(struct qman_portal *p, u32 bits)
 	 */
 	local_irq_save(irqflags);
 	bits &= QM_PIRQ_VISIBLE;
-	clear_bits(bits, &p->irq_sources);
+	p->irq_sources &= ~bits;
 	qm_out(&p->p, QM_REG_IER, p->irq_sources);
 	ier = qm_in(&p->p, QM_REG_IER);
 	/*
-- 
2.7.4
