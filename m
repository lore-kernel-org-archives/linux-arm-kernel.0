From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  2 Aug 2017 10:22:17 -0600
Subject: [PATCH 23/26] coresight tmc: Add support for Coresight SoC 600 TMC
In-Reply-To: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
References: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1501690940-4137-24-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

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
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 16 ++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 5bfc1b3ab80c..4fd112f11096 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -442,6 +442,22 @@ static struct amba_id tmc_ids[] = {
 		.id     = 0x0003b961,
 		.mask   = 0x0003ffff,
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
index d0da43a14246..8df7a813f537 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -129,6 +129,10 @@ enum tmc_mem_intf_width {
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
2.7.4
