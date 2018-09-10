From: horia.geanta@nxp.com (=?UTF-8?q?Horia=20Geant=C4=83?=)
Date: Mon, 10 Sep 2018 20:15:43 +0300
Subject: [PATCH 04/11] soc: fsl: dpio: add congestion notification support
In-Reply-To: <20180910171550.5659-1-horia.geanta@nxp.com>
References: <20180910171550.5659-1-horia.geanta@nxp.com>
Message-ID: <20180910171550.5659-5-horia.geanta@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Congestion State Change Notifications (CSCN), which
allow DPIO users to be notified when a congestion group changes its
state (due to hitting the entrance / exit threshold).

Signed-off-by: Horia Geant? <horia.geanta@nxp.com>
---
 include/soc/fsl/dpaa2-global.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/soc/fsl/dpaa2-global.h b/include/soc/fsl/dpaa2-global.h
index 9bc0713346a8..2bfc379d3dc9 100644
--- a/include/soc/fsl/dpaa2-global.h
+++ b/include/soc/fsl/dpaa2-global.h
@@ -174,4 +174,19 @@ static inline const struct dpaa2_fd *dpaa2_dq_fd(const struct dpaa2_dq *dq)
 	return (const struct dpaa2_fd *)&dq->dq.fd[0];
 }
 
+#define DPAA2_CSCN_SIZE		sizeof(struct dpaa2_dq)
+#define DPAA2_CSCN_ALIGN	16
+#define DPAA2_CSCN_STATE_CG	BIT(0)
+
+/**
+ * dpaa2_cscn_state_congested() - Check congestion state
+ * @cscn: congestion SCN (delivered to WQ or memory)
+ *
+i * Return true is congested.
+ */
+static inline bool dpaa2_cscn_state_congested(struct dpaa2_dq *cscn)
+{
+	return !!(cscn->scn.state & DPAA2_CSCN_STATE_CG);
+}
+
 #endif /* __FSL_DPAA2_GLOBAL_H */
-- 
2.16.2
