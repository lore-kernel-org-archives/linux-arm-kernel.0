From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 26 Jun 2017 16:22:55 +0100
Subject: [PATCH v2 11/12] coresight tmc: Add support for Coresight SoC 600 TMC
In-Reply-To: <1498490576-1350-1-git-send-email-suzuki.poulose@arm.com>
References: <1498490576-1350-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1498490576-1350-12-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The coresight SoC 600 supports ETR save-restore which allows us
to restore a trace session by retaining the RRP/RWP/STS.Full values
when the TMC leaves the Disabled state. However, the TMC doesn't
have a scatter-gather unit in built.

Also, TMCs have different PIDs in different configurations (ETF,
ETB & ETR), unlike the previous generation.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 20 ++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index b2f9466..32d32fa 100644
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
index d5ef51e..91e5deb 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -108,6 +108,7 @@ struct tmc_caps {
 };
 
 #define CORESIGHT_SOC_400_TMC_CAPS	(TMC_CAP_ETR_SG_UNIT)
+#define CORESIGHT_SOC_600_ETR_CAPS	(TMC_CAP_ETR_SAVE_RESTORE)
 
 /**
  * struct tmc_drvdata - specifics associated to an TMC component
-- 
2.7.5
