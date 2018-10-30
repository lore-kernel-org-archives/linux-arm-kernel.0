From: roy.pledge@nxp.com (Roy Pledge)
Date: Tue, 30 Oct 2018 20:30:40 +0000
Subject: [PATCH v1 2/2] soc: fsl: dpio: Add support for memory backed QBMan
 portals
In-Reply-To: <1540931418-10697-1-git-send-email-roy.pledge@nxp.com>
References: <1540931418-10697-1-git-send-email-roy.pledge@nxp.com>
Message-ID: <1540931418-10697-3-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NXP devices with QBMan version 5 and above can enable software
portals that are memory backed. This allows the portal to be
mapped as cacheable/sharable (same as all normal memory) so
that portals can freely migrate between cores and clusters
in the SoC. The driver will enable this mode by default when
appropriate HW support is detected.

Signed-off-by: Youri Querry <youri.querry_1@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/dpio/dpio-driver.c  |  23 ++++--
 drivers/soc/fsl/dpio/qbman-portal.c | 148 ++++++++++++++++++++++++++++++------
 drivers/soc/fsl/dpio/qbman-portal.h |   5 ++
 3 files changed, 144 insertions(+), 32 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
index e58fcc9..399a8e1 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -140,13 +140,22 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 	}
 	desc.cpu = next_cpu;
 
-	/*
-	 * Set the CENA regs to be the cache inhibited area of the portal to
-	 * avoid coherency issues if a user migrates to another core.
-	 */
-	desc.regs_cena = devm_memremap(dev, dpio_dev->regions[1].start,
-				       resource_size(&dpio_dev->regions[1]),
-				       MEMREMAP_WC);
+	if (dpio_dev->obj_desc.region_count < 3) {
+		/* No support for DDR backed portals, use classic mapping */
+		/*
+		 * Set the CENA regs to be the cache inhibited area of the
+		 * portal to avoid coherency issues if a user migrates to
+		 * another core.
+		 */
+		desc.regs_cena = devm_memremap(dev, dpio_dev->regions[1].start,
+					resource_size(&dpio_dev->regions[1]),
+					MEMREMAP_WC);
+	} else {
+		desc.regs_cena = devm_memremap(dev, dpio_dev->regions[2].start,
+					resource_size(&dpio_dev->regions[2]),
+					MEMREMAP_WB);
+	}
+
 	if (IS_ERR(desc.regs_cena)) {
 		dev_err(dev, "devm_memremap failed\n");
 		err = PTR_ERR(desc.regs_cena);
diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
index cf1d448..9d7277d 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -15,6 +15,8 @@
 #define QMAN_REV_4000   0x04000000
 #define QMAN_REV_4100   0x04010000
 #define QMAN_REV_4101   0x04010001
+#define QMAN_REV_5000   0x05000000
+
 #define QMAN_REV_MASK   0xffff0000
 
 /* All QBMan command and result structures use this "valid bit" encoding */
@@ -25,10 +27,17 @@
 #define QBMAN_WQCHAN_CONFIGURE 0x46
 
 /* CINH register offsets */
+#define QBMAN_CINH_SWP_EQCR_PI      0x800
 #define QBMAN_CINH_SWP_EQAR    0x8c0
+#define QBMAN_CINH_SWP_CR_RT        0x900
+#define QBMAN_CINH_SWP_VDQCR_RT     0x940
+#define QBMAN_CINH_SWP_EQCR_AM_RT   0x980
+#define QBMAN_CINH_SWP_RCR_AM_RT    0x9c0
 #define QBMAN_CINH_SWP_DQPI    0xa00
 #define QBMAN_CINH_SWP_DCAP    0xac0
 #define QBMAN_CINH_SWP_SDQCR   0xb00
+#define QBMAN_CINH_SWP_EQCR_AM_RT2  0xb40
+#define QBMAN_CINH_SWP_RCR_PI       0xc00
 #define QBMAN_CINH_SWP_RAR     0xcc0
 #define QBMAN_CINH_SWP_ISR     0xe00
 #define QBMAN_CINH_SWP_IER     0xe40
@@ -43,6 +52,13 @@
 #define QBMAN_CENA_SWP_RR(vb)  (0x700 + ((u32)(vb) >> 1))
 #define QBMAN_CENA_SWP_VDQCR   0x780
 
+/* CENA register offsets in memory-backed mode */
+#define QBMAN_CENA_SWP_DQRR_MEM(n)  (0x800 + ((u32)(n) << 6))
+#define QBMAN_CENA_SWP_RCR_MEM(n)   (0x1400 + ((u32)(n) << 6))
+#define QBMAN_CENA_SWP_CR_MEM       0x1600
+#define QBMAN_CENA_SWP_RR_MEM       0x1680
+#define QBMAN_CENA_SWP_VDQCR_MEM    0x1780
+
 /* Reverse mapping of QBMAN_CENA_SWP_DQRR() */
 #define QBMAN_IDX_FROM_DQRR(p) (((unsigned long)(p) & 0x1ff) >> 6)
 
@@ -96,10 +112,13 @@ static inline void *qbman_get_cmd(struct qbman_swp *p, u32 offset)
 
 #define SWP_CFG_DQRR_MF_SHIFT 20
 #define SWP_CFG_EST_SHIFT     16
+#define SWP_CFG_CPBS_SHIFT    15
 #define SWP_CFG_WN_SHIFT      14
 #define SWP_CFG_RPM_SHIFT     12
 #define SWP_CFG_DCM_SHIFT     10
 #define SWP_CFG_EPM_SHIFT     8
+#define SWP_CFG_VPM_SHIFT     7
+#define SWP_CFG_CPM_SHIFT     6
 #define SWP_CFG_SD_SHIFT      5
 #define SWP_CFG_SP_SHIFT      4
 #define SWP_CFG_SE_SHIFT      3
@@ -125,6 +144,8 @@ static inline u32 qbman_set_swp_cfg(u8 max_fill, u8 wn,	u8 est, u8 rpm, u8 dcm,
 		ep << SWP_CFG_EP_SHIFT);
 }
 
+#define QMAN_RT_MODE	   0x00000100
+
 /**
  * qbman_swp_init() - Create a functional object representing the given
  *                    QBMan portal descriptor.
@@ -146,6 +167,8 @@ struct qbman_swp *qbman_swp_init(const struct qbman_swp_desc *d)
 	p->sdq |= qbman_sdqcr_dct_prio_ics << QB_SDQCR_DCT_SHIFT;
 	p->sdq |= qbman_sdqcr_fc_up_to_3 << QB_SDQCR_FC_SHIFT;
 	p->sdq |= QMAN_SDQCR_TOKEN << QB_SDQCR_TOK_SHIFT;
+	if ((p->desc->qman_version & QMAN_REV_MASK) >= QMAN_REV_5000)
+		p->mr.valid_bit = QB_VALID_BIT;
 
 	atomic_set(&p->vdq.available, 1);
 	p->vdq.valid_bit = QB_VALID_BIT;
@@ -163,6 +186,9 @@ struct qbman_swp *qbman_swp_init(const struct qbman_swp_desc *d)
 	p->addr_cena = d->cena_bar;
 	p->addr_cinh = d->cinh_bar;
 
+	if ((p->desc->qman_version & QMAN_REV_MASK) >= QMAN_REV_5000)
+		memset(p->addr_cena, 0, 64 * 1024);
+
 	reg = qbman_set_swp_cfg(p->dqrr.dqrr_size,
 				1, /* Writes Non-cacheable */
 				0, /* EQCR_CI stashing threshold */
@@ -175,6 +201,10 @@ struct qbman_swp *qbman_swp_init(const struct qbman_swp_desc *d)
 				1, /* dequeue stashing priority == TRUE */
 				0, /* dequeue stashing enable == FALSE */
 				0); /* EQCR_CI stashing priority == FALSE */
+	if ((p->desc->qman_version & QMAN_REV_MASK) >= QMAN_REV_5000)
+		reg |= 1 << SWP_CFG_CPBS_SHIFT | /* memory-backed mode */
+		       1 << SWP_CFG_VPM_SHIFT |  /* VDQCR read triggered mode */
+		       1 << SWP_CFG_CPM_SHIFT;   /* CR read triggered mode */
 
 	qbman_write_register(p, QBMAN_CINH_SWP_CFG, reg);
 	reg = qbman_read_register(p, QBMAN_CINH_SWP_CFG);
@@ -183,6 +213,10 @@ struct qbman_swp *qbman_swp_init(const struct qbman_swp_desc *d)
 		return NULL;
 	}
 
+	if ((p->desc->qman_version & QMAN_REV_MASK) >= QMAN_REV_5000) {
+		qbman_write_register(p, QBMAN_CINH_SWP_EQCR_PI, QMAN_RT_MODE);
+		qbman_write_register(p, QBMAN_CINH_SWP_RCR_PI, QMAN_RT_MODE);
+	}
 	/*
 	 * SDQCR needs to be initialized to 0 when no channels are
 	 * being dequeued from or else the QMan HW will indicate an
@@ -277,7 +311,10 @@ void qbman_swp_interrupt_set_inhibit(struct qbman_swp *p, int inhibit)
  */
 void *qbman_swp_mc_start(struct qbman_swp *p)
 {
-	return qbman_get_cmd(p, QBMAN_CENA_SWP_CR);
+	if ((p->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000)
+		return qbman_get_cmd(p, QBMAN_CENA_SWP_CR);
+	else
+		return qbman_get_cmd(p, QBMAN_CENA_SWP_CR_MEM);
 }
 
 /*
@@ -288,8 +325,14 @@ void qbman_swp_mc_submit(struct qbman_swp *p, void *cmd, u8 cmd_verb)
 {
 	u8 *v = cmd;
 
-	dma_wmb();
-	*v = cmd_verb | p->mc.valid_bit;
+	if ((p->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000) {
+		dma_wmb();
+		*v = cmd_verb | p->mc.valid_bit;
+	} else {
+		*v = cmd_verb | p->mc.valid_bit;
+		dma_wmb();
+		qbman_write_register(p, QBMAN_CINH_SWP_CR_RT, QMAN_RT_MODE);
+	}
 }
 
 /*
@@ -300,13 +343,27 @@ void *qbman_swp_mc_result(struct qbman_swp *p)
 {
 	u32 *ret, verb;
 
-	ret = qbman_get_cmd(p, QBMAN_CENA_SWP_RR(p->mc.valid_bit));
+	if ((p->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000) {
+		ret = qbman_get_cmd(p, QBMAN_CENA_SWP_RR(p->mc.valid_bit));
+		/* Remove the valid-bit - command completed if the rest
+		 * is non-zero.
+		 */
+		verb = ret[0] & ~QB_VALID_BIT;
+		if (!verb)
+			return NULL;
+		p->mc.valid_bit ^= QB_VALID_BIT;
+	} else {
+		ret = qbman_get_cmd(p, QBMAN_CENA_SWP_RR_MEM);
+		/* Command completed if the valid bit is toggled */
+		if (p->mr.valid_bit != (ret[0] & QB_VALID_BIT))
+			return NULL;
+		/* Command completed if the rest is non-zero */
+		verb = ret[0] & ~QB_VALID_BIT;
+		if (!verb)
+			return NULL;
+		p->mr.valid_bit ^= QB_VALID_BIT;
+	}
 
-	/* Remove the valid-bit - command completed if the rest is non-zero */
-	verb = ret[0] & ~QB_VALID_BIT;
-	if (!verb)
-		return NULL;
-	p->mc.valid_bit ^= QB_VALID_BIT;
 	return ret;
 }
 
@@ -383,6 +440,18 @@ void qbman_eq_desc_set_qd(struct qbman_eq_desc *d, u32 qdid,
 #define EQAR_VB(eqar)      ((eqar) & 0x80)
 #define EQAR_SUCCESS(eqar) ((eqar) & 0x100)
 
+static inline void qbman_write_eqcr_am_rt_register(struct qbman_swp *p,
+						   u8 idx)
+{
+	if (idx < 16)
+		qbman_write_register(p, QBMAN_CINH_SWP_EQCR_AM_RT + idx * 4,
+				     QMAN_RT_MODE);
+	else
+		qbman_write_register(p, QBMAN_CINH_SWP_EQCR_AM_RT2 +
+				     (idx - 16) * 4,
+				     QMAN_RT_MODE);
+}
+
 /**
  * qbman_swp_enqueue() - Issue an enqueue command
  * @s:  the software portal used for enqueue
@@ -407,9 +476,15 @@ int qbman_swp_enqueue(struct qbman_swp *s, const struct qbman_eq_desc *d,
 	memcpy(&p->dca, &d->dca, 31);
 	memcpy(&p->fd, fd, sizeof(*fd));
 
-	/* Set the verb byte, have to substitute in the valid-bit */
-	dma_wmb();
-	p->verb = d->verb | EQAR_VB(eqar);
+	if ((s->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000) {
+		/* Set the verb byte, have to substitute in the valid-bit */
+		dma_wmb();
+		p->verb = d->verb | EQAR_VB(eqar);
+	} else {
+		p->verb = d->verb | EQAR_VB(eqar);
+		dma_wmb();
+		qbman_write_eqcr_am_rt_register(s, EQAR_IDX(eqar));
+	}
 
 	return 0;
 }
@@ -586,17 +661,27 @@ int qbman_swp_pull(struct qbman_swp *s, struct qbman_pull_desc *d)
 		return -EBUSY;
 	}
 	s->vdq.storage = (void *)(uintptr_t)d->rsp_addr_virt;
-	p = qbman_get_cmd(s, QBMAN_CENA_SWP_VDQCR);
+	if ((s->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000)
+		p = qbman_get_cmd(s, QBMAN_CENA_SWP_VDQCR);
+	else
+		p = qbman_get_cmd(s, QBMAN_CENA_SWP_VDQCR_MEM);
 	p->numf = d->numf;
 	p->tok = QMAN_DQ_TOKEN_VALID;
 	p->dq_src = d->dq_src;
 	p->rsp_addr = d->rsp_addr;
 	p->rsp_addr_virt = d->rsp_addr_virt;
-	dma_wmb();
 
-	/* Set the verb byte, have to substitute in the valid-bit */
-	p->verb = d->verb | s->vdq.valid_bit;
-	s->vdq.valid_bit ^= QB_VALID_BIT;
+	if ((s->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000) {
+		dma_wmb();
+		/* Set the verb byte, have to substitute in the valid-bit */
+		p->verb = d->verb | s->vdq.valid_bit;
+		s->vdq.valid_bit ^= QB_VALID_BIT;
+	} else {
+		p->verb = d->verb | s->vdq.valid_bit;
+		s->vdq.valid_bit ^= QB_VALID_BIT;
+		dma_wmb();
+		qbman_write_register(s, QBMAN_CINH_SWP_VDQCR_RT, QMAN_RT_MODE);
+	}
 
 	return 0;
 }
@@ -654,7 +739,10 @@ const struct dpaa2_dq *qbman_swp_dqrr_next(struct qbman_swp *s)
 				       QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx)));
 	}
 
-	p = qbman_get_cmd(s, QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx));
+	if ((s->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000)
+		p = qbman_get_cmd(s, QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx));
+	else
+		p = qbman_get_cmd(s, QBMAN_CENA_SWP_DQRR_MEM(s->dqrr.next_idx));
 	verb = p->dq.verb;
 
 	/*
@@ -806,18 +894,28 @@ int qbman_swp_release(struct qbman_swp *s, const struct qbman_release_desc *d,
 		return -EBUSY;
 
 	/* Start the release command */
-	p = qbman_get_cmd(s, QBMAN_CENA_SWP_RCR(RAR_IDX(rar)));
+	if ((s->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000)
+		p = qbman_get_cmd(s, QBMAN_CENA_SWP_RCR(RAR_IDX(rar)));
+	else
+		p = qbman_get_cmd(s, QBMAN_CENA_SWP_RCR_MEM(RAR_IDX(rar)));
 	/* Copy the caller's buffer pointers to the command */
 	for (i = 0; i < num_buffers; i++)
 		p->buf[i] = cpu_to_le64(buffers[i]);
 	p->bpid = d->bpid;
 
-	/*
-	 * Set the verb byte, have to substitute in the valid-bit and the number
-	 * of buffers.
-	 */
-	dma_wmb();
-	p->verb = d->verb | RAR_VB(rar) | num_buffers;
+	if ((s->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_5000) {
+		/*
+		 * Set the verb byte, have to substitute in the valid-bit
+		 * and the number of buffers.
+		 */
+		dma_wmb();
+		p->verb = d->verb | RAR_VB(rar) | num_buffers;
+	} else {
+		p->verb = d->verb | RAR_VB(rar) | num_buffers;
+		dma_wmb();
+		qbman_write_register(s, QBMAN_CINH_SWP_RCR_AM_RT +
+				     RAR_IDX(rar)  * 4, QMAN_RT_MODE);
+	}
 
 	return 0;
 }
diff --git a/drivers/soc/fsl/dpio/qbman-portal.h b/drivers/soc/fsl/dpio/qbman-portal.h
index 89d1dd9..a975b1fc 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.h
+++ b/drivers/soc/fsl/dpio/qbman-portal.h
@@ -110,6 +110,11 @@ struct qbman_swp {
 		u32 valid_bit; /* 0x00 or 0x80 */
 	} mc;
 
+	/* Management response */
+	struct {
+		u32 valid_bit; /* 0x00 or 0x80 */
+	} mr;
+
 	/* Push dequeues */
 	u32 sdq;
 
-- 
2.7.4
