From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  2 Aug 2017 10:22:07 -0600
Subject: [PATCH 13/26] coresight tmc: Add helpers for accessing 64bit registers
In-Reply-To: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
References: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1501690940-4137-14-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Coresight TMC splits 64bit registers into a pair of 32bit registers
(e.g DBA, RRP, RWP). Provide helpers to read/write to these registers.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-priv.h    |  8 ++++++++
 drivers/hwtracing/coresight/coresight-tmc-etf.c |  8 ++++----
 drivers/hwtracing/coresight/coresight-tmc-etr.c |  8 ++++----
 drivers/hwtracing/coresight/coresight-tmc.h     | 18 ++++++++++++++++++
 4 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 9fdebb773e71..f1d0e21d8cab 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -127,6 +127,14 @@ coresight_read_reg_pair(void __iomem *addr, s32 lo_offset, s32 hi_offset)
 	return val;
 }
 
+static inline void coresight_write_reg_pair(void __iomem *addr, u64 val,
+						 s32 lo_offset, s32 hi_offset)
+{
+	writel_relaxed((u32)val, addr + lo_offset);
+	if (hi_offset >= 0)
+		writel_relaxed((u32)(val >> 32), addr + hi_offset);
+}
+
 void coresight_disable_path(struct list_head *path);
 int coresight_enable_path(struct list_head *path, u32 mode);
 struct coresight_device *coresight_get_sink(struct list_head *path);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index d189b28bd5c4..e2513b786242 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -390,7 +390,7 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 	int i, cur;
 	const u32 *barrier;
 	u32 *buf_ptr;
-	u32 read_ptr, write_ptr;
+	u64 read_ptr, write_ptr;
 	u32 status, to_read;
 	unsigned long offset;
 	struct cs_buffers *buf = sink_config;
@@ -407,8 +407,8 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 
 	tmc_flush_and_stop(drvdata);
 
-	read_ptr = readl_relaxed(drvdata->base + TMC_RRP);
-	write_ptr = readl_relaxed(drvdata->base + TMC_RWP);
+	read_ptr = tmc_read_rrp(drvdata);
+	write_ptr = tmc_read_rwp(drvdata);
 
 	/*
 	 * Get a hold of the status register and see if a wrap around
@@ -460,7 +460,7 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 		if (read_ptr > (drvdata->size - 1))
 			read_ptr -= drvdata->size;
 		/* Tell the HW */
-		writel_relaxed(read_ptr, drvdata->base + TMC_RRP);
+		tmc_write_rrp(drvdata, read_ptr);
 		lost = true;
 	}
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index b8fb981de7b6..9c39c899ebd5 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -44,9 +44,8 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 		  ~(TMC_AXICTL_PROT_CTL_B0 | TMC_AXICTL_PROT_CTL_B1)) |
 		  TMC_AXICTL_PROT_CTL_B1;
 	writel_relaxed(axictl, drvdata->base + TMC_AXICTL);
+	tmc_write_dba(drvdata, drvdata->paddr);
 
-	writel_relaxed(drvdata->paddr, drvdata->base + TMC_DBALO);
-	writel_relaxed(0x0, drvdata->base + TMC_DBAHI);
 	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
 		       TMC_FFCR_FON_FLIN | TMC_FFCR_FON_TRIG_EVT |
 		       TMC_FFCR_TRIGON_TRIGIN,
@@ -60,10 +59,11 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 static void tmc_etr_dump_hw(struct tmc_drvdata *drvdata)
 {
 	const u32 *barrier;
+	u32 val;
 	u32 *temp;
-	u32 rwp, val;
+	u64 rwp;
 
-	rwp = readl_relaxed(drvdata->base + TMC_RWP);
+	rwp = tmc_read_rwp(drvdata);
 	val = readl_relaxed(drvdata->base + TMC_STS);
 
 	/*
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 51c01851533e..c4ff23336e76 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -139,4 +139,22 @@ extern const struct coresight_ops tmc_etf_cs_ops;
 int tmc_read_prepare_etr(struct tmc_drvdata *drvdata);
 int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata);
 extern const struct coresight_ops tmc_etr_cs_ops;
+
+
+#define TMC_REG_PAIR(name, lo_off, hi_off)				\
+static inline u64							\
+tmc_read_##name(struct tmc_drvdata *drvdata)				\
+{									\
+	return coresight_read_reg_pair(drvdata->base, lo_off, hi_off);	\
+}									\
+static inline void							\
+tmc_write_##name(struct tmc_drvdata *drvdata, u64 val)			\
+{									\
+	coresight_write_reg_pair(drvdata->base, val, lo_off, hi_off);	\
+}
+
+TMC_REG_PAIR(rrp, TMC_RRP, TMC_RRPHI)
+TMC_REG_PAIR(rwp, TMC_RWP, TMC_RWPHI)
+TMC_REG_PAIR(dba, TMC_DBALO, TMC_DBAHI)
+
 #endif
-- 
2.7.4
