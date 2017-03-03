From: horia.geanta@nxp.com (=?UTF-8?q?Horia=20Geant=C4=83?=)
Date: Fri, 3 Mar 2017 16:52:10 +0200
Subject: [RFC 4/7] soc/qman: add helper functions needed by caam/qi driver
In-Reply-To: <1488552733-20806-1-git-send-email-horia.geanta@nxp.com>
References: <1488552733-20806-1-git-send-email-horia.geanta@nxp.com>
Message-ID: <1488552733-20806-5-git-send-email-horia.geanta@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add helper functions, macros, #defines for accessing / enabling
qman functionality from caam/qi driver, such that this driver
is not aware of the need for data conversion to big endian.
qman is updated to use these helpers internally.

Signed-off-by: Horia Geant? <horia.geanta@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c            | 16 +++++------
 drivers/soc/fsl/qbman/qman_test_stash.c |  5 ++--
 include/soc/fsl/qman.h                  | 47 +++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 3d891db57ee6..7668ff53cd90 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1764,16 +1764,15 @@ int qman_init_fq(struct qman_fq *fq, u32 flags, struct qm_mcc_initfq *opts)
 	if (fq_isclear(fq, QMAN_FQ_FLAG_TO_DCPORTAL)) {
 		dma_addr_t phys_fq;
 
-		mcc->initfq.we_mask |= cpu_to_be16(QM_INITFQ_WE_CONTEXTB);
-		mcc->initfq.fqd.context_b = cpu_to_be32(fq_to_tag(fq));
+		qm_initfq_setbits(&mcc->initfq, QM_INITFQ_WE_CONTEXTB);
+		qm_fqd_set_contextb(&mcc->initfq.fqd, fq_to_tag(fq));
 		/*
 		 *  and the physical address - NB, if the user wasn't trying to
 		 * set CONTEXTA, clear the stashing settings.
 		 */
 		if (!(be16_to_cpu(mcc->initfq.we_mask) &
 				  QM_INITFQ_WE_CONTEXTA)) {
-			mcc->initfq.we_mask |=
-				cpu_to_be16(QM_INITFQ_WE_CONTEXTA);
+			qm_initfq_setbits(&mcc->initfq, QM_INITFQ_WE_CONTEXTA);
 			memset(&mcc->initfq.fqd.context_a, 0,
 				sizeof(mcc->initfq.fqd.context_a));
 		} else {
@@ -1795,8 +1794,7 @@ int qman_init_fq(struct qman_fq *fq, u32 flags, struct qm_mcc_initfq *opts)
 
 		if (!(be16_to_cpu(mcc->initfq.we_mask) &
 				  QM_INITFQ_WE_DESTWQ)) {
-			mcc->initfq.we_mask |=
-				cpu_to_be16(QM_INITFQ_WE_DESTWQ);
+			qm_initfq_setbits(&mcc->initfq, QM_INITFQ_WE_DESTWQ);
 			wq = 4;
 		}
 		qm_fqd_set_destwq(&mcc->initfq.fqd, p->config->channel, wq);
@@ -1816,7 +1814,7 @@ int qman_init_fq(struct qman_fq *fq, u32 flags, struct qm_mcc_initfq *opts)
 	}
 	if (opts) {
 		if (be16_to_cpu(opts->we_mask) & QM_INITFQ_WE_FQCTRL) {
-			if (be16_to_cpu(opts->fqd.fq_ctrl) & QM_FQCTRL_CGE)
+			if (qm_fqd_isset_fqctrl(&opts->fqd, QM_FQCTRL_CGE))
 				fq_set(fq, QMAN_FQ_STATE_CGR_EN);
 			else
 				fq_clear(fq, QMAN_FQ_STATE_CGR_EN);
@@ -2321,7 +2319,7 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
 
 		qm_cgr_cscn_targ_set(&local_opts.cgr, PORTAL_IDX(p),
 				     be32_to_cpu(cgr_state.cgr.cscn_targ));
-		local_opts.we_mask |= cpu_to_be16(QM_CGR_WE_CSCN_TARG);
+		qm_initcgr_setbits(&local_opts, QM_CGR_WE_CSCN_TARG);
 
 		/* send init if flags indicate so */
 		if (flags & QMAN_CGR_FLAG_USE_INIT)
@@ -2840,7 +2838,7 @@ static int cgr_cleanup(u32 cgrid)
 			err = qman_query_fq(&fq, &fqd);
 			if (WARN_ON(err))
 				return err;
-			if (be16_to_cpu(fqd.fq_ctrl) & QM_FQCTRL_CGE &&
+			if (qm_fqd_isset_fqctrl(&fqd, QM_FQCTRL_CGE) &&
 			    fqd.cgid == cgrid) {
 				pr_err("CRGID 0x%x is being used by FQID 0x%x, CGR will be leaked\n",
 				       cgrid, fq.fqid);
diff --git a/drivers/soc/fsl/qbman/qman_test_stash.c b/drivers/soc/fsl/qbman/qman_test_stash.c
index e87b65403b67..d2bf453092d7 100644
--- a/drivers/soc/fsl/qbman/qman_test_stash.c
+++ b/drivers/soc/fsl/qbman/qman_test_stash.c
@@ -406,9 +406,8 @@ static int init_handler(void *h)
 		goto failed;
 	}
 	memset(&opts, 0, sizeof(opts));
-	opts.we_mask = cpu_to_be16(QM_INITFQ_WE_FQCTRL |
-				   QM_INITFQ_WE_CONTEXTA);
-	opts.fqd.fq_ctrl = cpu_to_be16(QM_FQCTRL_CTXASTASHING);
+	qm_initfq_setbits(&opts, QM_INITFQ_WE_FQCTRL | QM_INITFQ_WE_CONTEXTA);
+	qm_fqd_set_fqctrl(&opts.fqd, QM_FQCTRL_CTXASTASHING);
 	qm_fqd_set_stashing(&opts.fqd, 0, STASH_DATA_CL, STASH_CTX_CL);
 	err = qman_init_fq(&handler->rx, QMAN_INITFQ_FLAG_SCHED |
 			   QMAN_INITFQ_FLAG_LOCAL, &opts);
diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
index 0252c32f7421..fc133c658385 100644
--- a/include/soc/fsl/qman.h
+++ b/include/soc/fsl/qman.h
@@ -168,6 +168,12 @@ static inline void qm_fd_set_param(struct qm_fd *fd, enum qm_fd_format fmt,
 #define qm_fd_set_contig_big(fd, len) \
 	qm_fd_set_param(fd, qm_fd_contig_big, 0, len)
 #define qm_fd_set_sg_big(fd, len) qm_fd_set_param(fd, qm_fd_sg_big, 0, len)
+#define qm_fd_set_compound(fd, len) qm_fd_set_param(fd, qm_fd_compound, 0, len)
+
+static inline int qm_fd_get_status(const struct qm_fd *fd)
+{
+	return be32_to_cpu(fd->status);
+}
 
 static inline void qm_fd_clear_fd(struct qm_fd *fd)
 {
@@ -233,16 +239,31 @@ static inline void qm_sg_entry_set_len(struct qm_sg_entry *sg, int len)
 	sg->cfg = cpu_to_be32(len & QM_SG_LEN_MASK);
 }
 
+static inline void qm_sg_entry_set_e(struct qm_sg_entry *sg, int len)
+{
+	sg->cfg = cpu_to_be32(QM_SG_EXT | (len & QM_SG_LEN_MASK));
+}
+
 static inline void qm_sg_entry_set_f(struct qm_sg_entry *sg, int len)
 {
 	sg->cfg = cpu_to_be32(QM_SG_FIN | (len & QM_SG_LEN_MASK));
 }
 
+static inline void qm_sg_entry_set_ef(struct qm_sg_entry *sg, int len)
+{
+	sg->cfg = cpu_to_be32(QM_SG_EXT | QM_SG_FIN | (len & QM_SG_LEN_MASK));
+}
+
 static inline int qm_sg_entry_get_off(const struct qm_sg_entry *sg)
 {
 	return be32_to_cpu(sg->offset) & QM_SG_OFF_MASK;
 }
 
+static inline void qm_sg_entry_set_off(struct qm_sg_entry *sg, int off)
+{
+	sg->offset = cpu_to_be16(off & QM_SG_OFF_MASK);
+}
+
 /* "Frame Dequeue Response" */
 struct qm_dqrr_entry {
 	u8 verb;
@@ -494,6 +515,21 @@ static inline int qm_fqd_get_wq(const struct qm_fqd *fqd)
 	return be16_to_cpu(fqd->dest_wq) & QM_FQD_WQ_MASK;
 }
 
+static inline bool qm_fqd_isset_fqctrl(const struct qm_fqd *fqd, u16 mask)
+{
+	return be16_to_cpu(fqd->fq_ctrl) & mask;
+}
+
+static inline void qm_fqd_set_fqctrl(struct qm_fqd *fqd, int val)
+{
+	fqd->fq_ctrl = cpu_to_be16(val);
+}
+
+static inline void qm_fqd_set_contextb(struct qm_fqd *fqd, int val)
+{
+	fqd->context_b = cpu_to_be32(val);
+}
+
 /* See "Frame Queue Descriptor (FQD)" */
 /* Frame Queue Descriptor (FQD) field 'fq_ctrl' uses these constants */
 #define QM_FQCTRL_MASK		0x07ff	/* 'fq_ctrl' flags; */
@@ -616,6 +652,16 @@ struct qm_mcc_initcgr {
 	u8 __reserved3[32];
 } __packed;
 
+static inline void qm_initfq_setbits(struct qm_mcc_initfq *p, u16 we_mask)
+{
+	p->we_mask |= cpu_to_be16(we_mask);
+}
+
+static inline void qm_initcgr_setbits(struct qm_mcc_initcgr *p, u16 we_mask)
+{
+	p->we_mask |= cpu_to_be16(we_mask);
+}
+
 /* INITFQ-specific flags */
 #define QM_INITFQ_WE_MASK		0x01ff	/* 'Write Enable' flags; */
 #define QM_INITFQ_WE_OAC		0x0100
@@ -642,6 +688,7 @@ struct qm_mcc_initcgr {
 #define QM_CGR_WE_MODE			0x0001
 
 #define QMAN_CGR_FLAG_USE_INIT	     0x00000001
+#define QMAN_CGR_MODE_FRAME          0x00000001
 
 	/* Portal and Frame Queues */
 /* Represents a managed portal */
-- 
2.4.4
