From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 20 Jul 2017 11:17:28 +0100
Subject: [PATCH v5 18/19] coresight tmc: Add support for Coresight SoC 600 TMC
In-Reply-To: <1500545849-23724-1-git-send-email-suzuki.poulose@arm.com>
References: <1500545849-23724-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1500545849-23724-19-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The coresight SoC 600 supports ETR save-restore which allows us
to restore a trace session by retaining the RRP/RWP/STS.Full values
when the TMC leaves the Disabled state. However, the TMC doesn't
have a scatter-gather unit in built.

Also, TMCs have different PIDs in different configurations (ETF,
ETB & ETR), unlike the previous generation.

While the DEVID exposes some of the features/changes in the TMC,
it doesn't explicitly advertises the new save-restore feature
as described above.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 16 ++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index c4a5dea..e754a3e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -442,6 +442,22 @@ static struct amba_id tmc_ids[] = {
 		.id     = 0x000bb961,
 		.mask   = 0x000fffff,
 	},
+	{
+		/* Coresight SoC 600 TMC-ETR/ETS */
+		.id	= 0x000bb9e8,
+		.mask	= 0x000fffff,
+		.data	= (void *)(unsigned long)CORESIGHT_SOC_600_ETR_CAPS,
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
 	{ 0, 0},
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 08f1aea..f24e89a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -130,6 +130,10 @@ enum tmc_mem_intf_width {
  */
 #define TMC_ETR_SAVE_RESTORE		(0x1U << 2)
 
+/* Coresight SoC-600 TMC-ETR unadvertised capabilities */
+#define CORESIGHT_SOC_600_ETR_CAPS	\
+	(TMC_ETR_SAVE_RESTORE | TMC_ETR_AXI_ARCACHE)
+
 /**
  * struct tmc_drvdata - specifics associated to an TMC component
  * @base:	memory mapped base address for this component.
-- 
2.7.5
