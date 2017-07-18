From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 18 Jul 2017 10:48:09 +0100
Subject: [PATCH v4 12/18] coresight tmc: Detect support for scatter gather
In-Reply-To: <1500371295-30472-1-git-send-email-suzuki.poulose@arm.com>
References: <1500371295-30472-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1500371295-30472-13-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SG unit in the TMC has been removed in Coresight SoC-600.
This is however advertised by DEVID:Bit 24 = 0b1. On the
previous generation, the bit is RES0, hence we can rely on the
DEVID to detect the support.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 2 ++
 drivers/hwtracing/coresight/coresight-tmc.h | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index ebf81bc..a1de265 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -304,6 +304,8 @@ static int tmc_etr_setup_caps(struct tmc_drvdata *drvdata,
 	/* Set the unadvertised capabilities */
 	tmc_etr_init_caps(drvdata, (u32)(unsigned long)dev_caps);
 
+	if (!(devid & TMC_DEVID_NOSCAT))
+		tmc_etr_set_cap(drvdata, TMC_ETR_SG);
 	/*
 	 * ETR configuration uses a 40-bit AXI master in place of
 	 * the embedded SRAM of ETB/ETF.
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 7b20863..23dfbf3 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -70,6 +70,8 @@
 #define TMC_FFCR_STOP_ON_FLUSH	BIT(12)
 
 
+#define TMC_DEVID_NOSCAT	BIT(24)
+
 enum tmc_config_type {
 	TMC_CONFIG_TYPE_ETB,
 	TMC_CONFIG_TYPE_ETR,
@@ -89,6 +91,9 @@ enum tmc_mem_intf_width {
 	TMC_MEM_INTF_WIDTH_256BITS	= 8,
 };
 
+/* TMC ETR Capability bit definitions */
+#define TMC_ETR_SG			(0x1U << 0)
+
 /**
  * struct tmc_drvdata - specifics associated to an TMC component
  * @base:	memory mapped base address for this component.
-- 
2.7.5
