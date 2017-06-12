From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 12 Jun 2017 15:36:50 +0100
Subject: [PATCH 11/12] coresight tmc: Add support for Coresight SoC 600 TMC
In-Reply-To: <1497278211-5001-1-git-send-email-suzuki.poulose@arm.com>
References: <1497278211-5001-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1497278211-5001-12-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The coresight SoC 600 supports ETR save-restore and also supports
a new mode, SWFIFO2, which helps to streaming the trace data through
a functional I/O (e.g, USB).

Also, TMCs have different PIDs in different configurations (ETF,
ETB & ETR), unlike the previous generation.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 20 ++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.h |  8 ++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index e88f2f3..03cafa7 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -409,6 +409,10 @@ static struct tmc_caps coresight_soc_400_tmc_caps = {
 	.caps = CORESIGHT_SOC_400_TMC_CAPS,
 };
 
+static struct tmc_caps coresight_soc_600_etr_caps = {
+	.caps = CORESIGHT_SOC_600_ETR_CAPS,
+};
+
 static struct amba_id tmc_ids[] = {
 	{
 		/* Coresight SoC 400 TMC */
@@ -416,6 +420,22 @@ static struct amba_id tmc_ids[] = {
 		.mask   = 0x000fffff,
 		.data	= &coresight_soc_400_tmc_caps,
 	},
+	{
+		/* Coresight SoC 600 TMC-ETR/ETS */
+		.id	= 0x000bb9e8,
+		.mask	= 0x000fffff,
+		.data	= &coresight_soc_600_etr_caps,
+	},
+	{
+		/* Coresight SoC 600 TMC-ETB */
+		.id	= 0x000bb9e9,
+		.mask	= 0x000fffff,
+	},
+	{
+		/* Coresight SoC 600 TMC-ETF */
+		.id	= 0x000bb9ea,
+		.mask	= 0x000fffff,
+	},
 	{},
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index d5ef51e..8c74e1e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -98,6 +98,12 @@ enum tmc_mem_intf_width {
  * value.
  */
 #define TMC_CAP_ETR_SAVE_RESTORE	(1U << 1)
+/*
+ * TMC_CAP_ETR_SWFIFO2_MODE - ETR supports a new mode, SWFIFO2, which
+ * allows streaming the trace data with optionally raising an interrupt
+ * when the buffer fill level reaches a programmed watermark.
+ */
+#define TMC_CAP_ETR_SWFIFO2_MODE	(1U << 2)
 
 /**
  * struct tmc_cap - Describes the capabilities of the TMC.
@@ -108,6 +114,8 @@ struct tmc_caps {
 };
 
 #define CORESIGHT_SOC_400_TMC_CAPS	(TMC_CAP_ETR_SG_UNIT)
+#define CORESIGHT_SOC_600_ETR_CAPS	(TMC_CAP_ETR_SAVE_RESTORE | \
+					 TMC_CAP_ETR_SWFIFO2_MODE)
 
 /**
  * struct tmc_drvdata - specifics associated to an TMC component
-- 
2.7.4
