From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Fri, 28 Sep 2018 11:43:23 +0300
Subject: [PATCH v2 4/5] soc/fsl/qbman: Use last response to determine valid bit
In-Reply-To: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
References: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
Message-ID: <1538124204-31406-5-git-send-email-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roy Pledge <roy.pledge@nxp.com>

Use the last valid response when determining what valid bit
to use next for management commands. This is needed in the
case that the portal was previously used by other software
like a bootloader or if the kernel is restarted without a
hardware reset.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 0ffe7a1d0eae..99d0f87889b8 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -850,12 +850,24 @@ static inline void qm_mr_set_ithresh(struct qm_portal *portal, u8 ithresh)
 
 static inline int qm_mc_init(struct qm_portal *portal)
 {
+	u8 rr0, rr1;
 	struct qm_mc *mc = &portal->mc;
 
 	mc->cr = portal->addr.ce + QM_CL_CR;
 	mc->rr = portal->addr.ce + QM_CL_RR0;
-	mc->rridx = (mc->cr->_ncw_verb & QM_MCC_VERB_VBIT)
-		    ? 0 : 1;
+	/*
+	 * The expected valid bit polarity for the next CR command is 0
+	 * if RR1 contains a valid response, and is 1 if RR0 contains a
+	 * valid response. If both RR contain all 0, this indicates either
+	 * that no command has been executed since reset (in which case the
+	 * expected valid bit polarity is 1)
+	 */
+	rr0 = mc->rr->verb;
+	rr1 = (mc->rr+1)->verb;
+	if ((rr0 == 0 && rr1 == 0) || rr0 != 0)
+		mc->rridx = 1;
+	else
+		mc->rridx = 0;
 	mc->vbit = mc->rridx ? QM_MCC_VERB_VBIT : 0;
 #ifdef CONFIG_FSL_DPAA_CHECKING
 	mc->state = qman_mc_idle;
-- 
2.1.0
