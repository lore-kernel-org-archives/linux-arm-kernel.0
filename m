From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 18 Jul 2017 10:48:12 +0100
Subject: [PATCH v4 15/18] coresigh tmc etr: Setup AXI cache encoding for read
 transfers
In-Reply-To: <1500371295-30472-1-git-send-email-suzuki.poulose@arm.com>
References: <1500371295-30472-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1500371295-30472-16-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the ETR supports split cache encoding (i.e, separate bits for
read and write transfers) unlike the older version (where read
and write transfers use the same encoding in AXICTL[2-5]).
This feature is not advertised and has to be described by the
static mask associated with the device id.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c |  6 ++++++
 drivers/hwtracing/coresight/coresight-tmc.h     | 10 +++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index bc647fa..38a0440 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -39,6 +39,12 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 	axictl &= ~TMC_AXICTL_CLEAR_MASK;
 	axictl |= (TMC_AXICTL_PROT_CTL_B1 | TMC_AXICTL_WR_BURST_16);
 	axictl |= TMC_AXICTL_AXCACHE_OS;
+
+	if (tmc_etr_has_cap(drvdata, TMC_ETR_AXI_ARCACHE)) {
+		axictl &= ~TMC_AXICTL_ARCACHE_MASK;
+		axictl |= TMC_AXICTL_ARCACHE_OS;
+	}
+
 	writel_relaxed(axictl, drvdata->base + TMC_AXICTL);
 	tmc_write_dba(drvdata, drvdata->paddr);
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index a532972..c691014 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -60,13 +60,18 @@
  *
  * TMC AXICTL format for SoC-400
  *	Bits [0-1]	: ProtCtrlBit0-1
- *	Bits [2-5]	: CacheCtrlBits 0-3 (AxCACHE)
+ *	Bits [2-5]	: CacheCtrlBits 0-3 (AXCACHE)
  *	Bit  6		: Reserved
  *	Bit  7		: ScatterGatherMode
  *	Bits [8-11]	: WrBurstLen
  *	Bits [12-31]	: Reserved.
+ * TMC AXICTL format for SoC-600, as above except:
+ *	Bits [2-5]	: AXI WCACHE
+ *	Bits [16-19]	: AXI RCACHE
+ *	Bits [20-31]	: Reserved
  */
 #define TMC_AXICTL_CLEAR_MASK 0xfbf
+#define TMC_AXICTL_ARCACHE_MASK (0xf << 16)
 
 #define TMC_AXICTL_PROT_CTL_B0	BIT(0)
 #define TMC_AXICTL_PROT_CTL_B1	BIT(1)
@@ -74,6 +79,7 @@
 #define TMC_AXICTL_WR_BURST_16	0xF00
 /* Write-back Read and Write-allocate */
 #define TMC_AXICTL_AXCACHE_OS	(0xf << 2)
+#define TMC_AXICTL_ARCACHE_OS	(0xf << 16)
 
 /* TMC_FFCR - 0x304 */
 #define TMC_FFCR_FLUSHMAN_BIT	6
@@ -112,6 +118,8 @@ enum tmc_mem_intf_width {
 
 /* TMC ETR Capability bit definitions */
 #define TMC_ETR_SG			(0x1U << 0)
+/* ETR has separate read/write cache encodings */
+#define TMC_ETR_AXI_ARCACHE		(0x1U << 1)
 
 /**
  * struct tmc_drvdata - specifics associated to an TMC component
-- 
2.7.5
