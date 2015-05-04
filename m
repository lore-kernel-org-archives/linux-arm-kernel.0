From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  4 May 2015 13:46:46 +0200
Subject: [PATCH 8/8] soc/tegra: fuse: Rename core_* to soc_*
In-Reply-To: <1430740006-29539-1-git-send-email-thierry.reding@gmail.com>
References: <1430740006-29539-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1430740006-29539-9-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

There's a mixture of core_* and soc_* prefixes for variables storing
information related to the VDD_CORE rail. Choose one (soc_*) and use it
more consistently.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c      |  8 ++++----
 drivers/soc/tegra/fuse/fuse-tegra20.c    |  2 +-
 drivers/soc/tegra/fuse/fuse-tegra30.c    |  2 +-
 drivers/soc/tegra/fuse/speedo-tegra114.c | 16 ++++++++--------
 drivers/soc/tegra/fuse/speedo-tegra124.c | 12 ++++++------
 drivers/soc/tegra/fuse/speedo-tegra20.c  | 22 +++++++++++-----------
 drivers/soc/tegra/fuse/speedo-tegra30.c  | 26 +++++++++++++-------------
 include/soc/tegra/fuse.h                 |  2 +-
 8 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 45496c0d9b29..daba1894bb1a 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -304,12 +304,12 @@ static int __init tegra_init_fuse(void)
 
 	fuse->soc->init(fuse);
 
-	pr_info("Tegra Revision: %s SKU: %d CPU Process: %d Core Process: %d\n",
+	pr_info("Tegra Revision: %s SKU: %d CPU Process: %d SoC Process: %d\n",
 		tegra_revision_name[tegra_sku_info.revision],
 		tegra_sku_info.sku_id, tegra_sku_info.cpu_process_id,
-		tegra_sku_info.core_process_id);
-	pr_debug("Tegra CPU Speedo ID %d, Soc Speedo ID %d\n",
-		tegra_sku_info.cpu_speedo_id, tegra_sku_info.soc_speedo_id);
+		tegra_sku_info.soc_process_id);
+	pr_debug("Tegra CPU Speedo ID %d, SoC Speedo ID %d\n",
+		 tegra_sku_info.cpu_speedo_id, tegra_sku_info.soc_speedo_id);
 
 	return 0;
 }
diff --git a/drivers/soc/tegra/fuse/fuse-tegra20.c b/drivers/soc/tegra/fuse/fuse-tegra20.c
index f695799c69d4..70c7cecff917 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra20.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra20.c
@@ -140,7 +140,7 @@ static void __init tegra20_fuse_add_randomness(void)
 	randomness[1] = tegra_read_straps();
 	randomness[2] = tegra_read_chipid();
 	randomness[3] = tegra_sku_info.cpu_process_id << 16;
-	randomness[3] |= tegra_sku_info.core_process_id;
+	randomness[3] |= tegra_sku_info.soc_process_id;
 	randomness[4] = tegra_sku_info.cpu_speedo_id << 16;
 	randomness[4] |= tegra_sku_info.soc_speedo_id;
 	randomness[5] = tegra_fuse_read_early(FUSE_UID_LOW);
diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index a9c6c925ff19..5a6c533417fc 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -75,7 +75,7 @@ static void __init tegra30_fuse_add_randomness(void)
 	randomness[1] = tegra_read_straps();
 	randomness[2] = tegra_read_chipid();
 	randomness[3] = tegra_sku_info.cpu_process_id << 16;
-	randomness[3] |= tegra_sku_info.core_process_id;
+	randomness[3] |= tegra_sku_info.soc_process_id;
 	randomness[4] = tegra_sku_info.cpu_speedo_id << 16;
 	randomness[4] |= tegra_sku_info.soc_speedo_id;
 	randomness[5] = tegra_fuse_read_early(FUSE_VENDOR_CODE);
diff --git a/drivers/soc/tegra/fuse/speedo-tegra114.c b/drivers/soc/tegra/fuse/speedo-tegra114.c
index 554c54b98b0c..1ba41ebbb23d 100644
--- a/drivers/soc/tegra/fuse/speedo-tegra114.c
+++ b/drivers/soc/tegra/fuse/speedo-tegra114.c
@@ -22,7 +22,7 @@
 
 #include "fuse.h"
 
-#define CORE_PROCESS_CORNERS	2
+#define SOC_PROCESS_CORNERS	2
 #define CPU_PROCESS_CORNERS	2
 
 enum {
@@ -31,7 +31,7 @@ enum {
 	THRESHOLD_INDEX_COUNT,
 };
 
-static const u32 __initconst core_process_speedos[][CORE_PROCESS_CORNERS] = {
+static const u32 __initconst soc_process_speedos[][SOC_PROCESS_CORNERS] = {
 	{1123,     UINT_MAX},
 	{0,        UINT_MAX},
 };
@@ -84,27 +84,27 @@ static void __init rev_sku_to_speedo_ids(struct tegra_sku_info *sku_info,
 void __init tegra114_init_speedo_data(struct tegra_sku_info *sku_info)
 {
 	u32 cpu_speedo_val;
-	u32 core_speedo_val;
+	u32 soc_speedo_val;
 	int threshold;
 	int i;
 
 	BUILD_BUG_ON(ARRAY_SIZE(cpu_process_speedos) !=
 			THRESHOLD_INDEX_COUNT);
-	BUILD_BUG_ON(ARRAY_SIZE(core_process_speedos) !=
+	BUILD_BUG_ON(ARRAY_SIZE(soc_process_speedos) !=
 			THRESHOLD_INDEX_COUNT);
 
 	rev_sku_to_speedo_ids(sku_info, &threshold);
 
 	cpu_speedo_val = tegra_fuse_read_early(0x12c) + 1024;
-	core_speedo_val = tegra_fuse_read_early(0x134);
+	soc_speedo_val = tegra_fuse_read_early(0x134);
 
 	for (i = 0; i < CPU_PROCESS_CORNERS; i++)
 		if (cpu_speedo_val < cpu_process_speedos[threshold][i])
 			break;
 	sku_info->cpu_process_id = i;
 
-	for (i = 0; i < CORE_PROCESS_CORNERS; i++)
-		if (core_speedo_val < core_process_speedos[threshold][i])
+	for (i = 0; i < SOC_PROCESS_CORNERS; i++)
+		if (soc_speedo_val < soc_process_speedos[threshold][i])
 			break;
-	sku_info->core_process_id = i;
+	sku_info->soc_process_id = i;
 }
diff --git a/drivers/soc/tegra/fuse/speedo-tegra124.c b/drivers/soc/tegra/fuse/speedo-tegra124.c
index d1e896d8d8a2..a63a134101ab 100644
--- a/drivers/soc/tegra/fuse/speedo-tegra124.c
+++ b/drivers/soc/tegra/fuse/speedo-tegra124.c
@@ -24,7 +24,7 @@
 
 #define CPU_PROCESS_CORNERS	2
 #define GPU_PROCESS_CORNERS	2
-#define CORE_PROCESS_CORNERS	2
+#define SOC_PROCESS_CORNERS	2
 
 #define FUSE_CPU_SPEEDO_0	0x14
 #define FUSE_CPU_SPEEDO_1	0x2c
@@ -53,7 +53,7 @@ static const u32 __initconst gpu_process_speedos[][GPU_PROCESS_CORNERS] = {
 	{0,	UINT_MAX},
 };
 
-static const u32 __initconst core_process_speedos[][CORE_PROCESS_CORNERS] = {
+static const u32 __initconst soc_process_speedos[][SOC_PROCESS_CORNERS] = {
 	{2101,	UINT_MAX},
 	{0,	UINT_MAX},
 };
@@ -119,7 +119,7 @@ void __init tegra124_init_speedo_data(struct tegra_sku_info *sku_info)
 			THRESHOLD_INDEX_COUNT);
 	BUILD_BUG_ON(ARRAY_SIZE(gpu_process_speedos) !=
 			THRESHOLD_INDEX_COUNT);
-	BUILD_BUG_ON(ARRAY_SIZE(core_process_speedos) !=
+	BUILD_BUG_ON(ARRAY_SIZE(soc_process_speedos) !=
 			THRESHOLD_INDEX_COUNT);
 
 	cpu_speedo_0_value = tegra_fuse_read_early(FUSE_CPU_SPEEDO_0);
@@ -157,11 +157,11 @@ void __init tegra124_init_speedo_data(struct tegra_sku_info *sku_info)
 				break;
 	sku_info->cpu_process_id = i;
 
-	for (i = 0; i < CORE_PROCESS_CORNERS; i++)
+	for (i = 0; i < SOC_PROCESS_CORNERS; i++)
 		if (soc_speedo_0_value <
-			core_process_speedos[threshold][i])
+			soc_process_speedos[threshold][i])
 			break;
-	sku_info->core_process_id = i;
+	sku_info->soc_process_id = i;
 
 	pr_debug("Tegra GPU Speedo ID=%d, Speedo Value=%d\n",
 		 sku_info->gpu_speedo_id, sku_info->gpu_speedo_value);
diff --git a/drivers/soc/tegra/fuse/speedo-tegra20.c b/drivers/soc/tegra/fuse/speedo-tegra20.c
index ed5180b01e17..5f7818bf6072 100644
--- a/drivers/soc/tegra/fuse/speedo-tegra20.c
+++ b/drivers/soc/tegra/fuse/speedo-tegra20.c
@@ -28,11 +28,11 @@
 #define CPU_SPEEDO_REDUND_MSBIT		39
 #define CPU_SPEEDO_REDUND_OFFS	(CPU_SPEEDO_REDUND_MSBIT - CPU_SPEEDO_MSBIT)
 
-#define CORE_SPEEDO_LSBIT		40
-#define CORE_SPEEDO_MSBIT		47
-#define CORE_SPEEDO_REDUND_LSBIT	48
-#define CORE_SPEEDO_REDUND_MSBIT	55
-#define CORE_SPEEDO_REDUND_OFFS	(CORE_SPEEDO_REDUND_MSBIT - CORE_SPEEDO_MSBIT)
+#define SOC_SPEEDO_LSBIT		40
+#define SOC_SPEEDO_MSBIT		47
+#define SOC_SPEEDO_REDUND_LSBIT		48
+#define SOC_SPEEDO_REDUND_MSBIT		55
+#define SOC_SPEEDO_REDUND_OFFS	(SOC_SPEEDO_REDUND_MSBIT - SOC_SPEEDO_MSBIT)
 
 #define SPEEDO_MULT			4
 
@@ -56,7 +56,7 @@ static const u32 __initconst cpu_process_speedos[][PROCESS_CORNERS_NUM] = {
 	{316, 331, 383, UINT_MAX},
 };
 
-static const u32 __initconst core_process_speedos[][PROCESS_CORNERS_NUM] = {
+static const u32 __initconst soc_process_speedos[][PROCESS_CORNERS_NUM] = {
 	{165, 195, 224, UINT_MAX},
 	{165, 195, 224, UINT_MAX},
 	{165, 195, 224, UINT_MAX},
@@ -69,7 +69,7 @@ void __init tegra20_init_speedo_data(struct tegra_sku_info *sku_info)
 	int i;
 
 	BUILD_BUG_ON(ARRAY_SIZE(cpu_process_speedos) != SPEEDO_ID_COUNT);
-	BUILD_BUG_ON(ARRAY_SIZE(core_process_speedos) != SPEEDO_ID_COUNT);
+	BUILD_BUG_ON(ARRAY_SIZE(soc_process_speedos) != SPEEDO_ID_COUNT);
 
 	if (SPEEDO_ID_SELECT_0(sku_info->revision))
 		sku_info->soc_speedo_id = SPEEDO_ID_0;
@@ -94,17 +94,17 @@ void __init tegra20_init_speedo_data(struct tegra_sku_info *sku_info)
 	sku_info->cpu_process_id = i;
 
 	val = 0;
-	for (i = CORE_SPEEDO_MSBIT; i >= CORE_SPEEDO_LSBIT; i--) {
+	for (i = SOC_SPEEDO_MSBIT; i >= SOC_SPEEDO_LSBIT; i--) {
 		reg = tegra_fuse_read_spare(i) |
-			tegra_fuse_read_spare(i + CORE_SPEEDO_REDUND_OFFS);
+			tegra_fuse_read_spare(i + SOC_SPEEDO_REDUND_OFFS);
 		val = (val << 1) | (reg & 0x1);
 	}
 	val = val * SPEEDO_MULT;
 	pr_debug("Core speedo value %u\n", val);
 
 	for (i = 0; i < (PROCESS_CORNERS_NUM - 1); i++) {
-		if (val <= core_process_speedos[sku_info->soc_speedo_id][i])
+		if (val <= soc_process_speedos[sku_info->soc_speedo_id][i])
 			break;
 	}
-	sku_info->core_process_id = i;
+	sku_info->soc_process_id = i;
 }
diff --git a/drivers/soc/tegra/fuse/speedo-tegra30.c b/drivers/soc/tegra/fuse/speedo-tegra30.c
index fd0cefae54ef..9b010b3ef009 100644
--- a/drivers/soc/tegra/fuse/speedo-tegra30.c
+++ b/drivers/soc/tegra/fuse/speedo-tegra30.c
@@ -22,7 +22,7 @@
 
 #include "fuse.h"
 
-#define CORE_PROCESS_CORNERS	1
+#define SOC_PROCESS_CORNERS	1
 #define CPU_PROCESS_CORNERS	6
 
 #define FUSE_SPEEDO_CALIB_0	0x14
@@ -54,7 +54,7 @@ enum {
 	THRESHOLD_INDEX_COUNT,
 };
 
-static const u32 __initconst core_process_speedos[][CORE_PROCESS_CORNERS] = {
+static const u32 __initconst soc_process_speedos[][SOC_PROCESS_CORNERS] = {
 	{180},
 	{170},
 	{195},
@@ -246,19 +246,19 @@ static void __init rev_sku_to_speedo_ids(struct tegra_sku_info *sku_info)
 void __init tegra30_init_speedo_data(struct tegra_sku_info *sku_info)
 {
 	u32 cpu_speedo_val;
-	u32 core_speedo_val;
+	u32 soc_speedo_val;
 	int i;
 
 	BUILD_BUG_ON(ARRAY_SIZE(cpu_process_speedos) !=
 			THRESHOLD_INDEX_COUNT);
-	BUILD_BUG_ON(ARRAY_SIZE(core_process_speedos) !=
+	BUILD_BUG_ON(ARRAY_SIZE(soc_process_speedos) !=
 			THRESHOLD_INDEX_COUNT);
 
 
 	rev_sku_to_speedo_ids(sku_info);
-	fuse_speedo_calib(&cpu_speedo_val, &core_speedo_val);
+	fuse_speedo_calib(&cpu_speedo_val, &soc_speedo_val);
 	pr_debug("Tegra CPU speedo value %u\n", cpu_speedo_val);
-	pr_debug("Tegra Core speedo value %u\n", core_speedo_val);
+	pr_debug("Tegra Core speedo value %u\n", soc_speedo_val);
 
 	for (i = 0; i < CPU_PROCESS_CORNERS; i++) {
 		if (cpu_speedo_val < cpu_process_speedos[threshold_index][i])
@@ -273,16 +273,16 @@ void __init tegra30_init_speedo_data(struct tegra_sku_info *sku_info)
 		sku_info->cpu_speedo_id = 1;
 	}
 
-	for (i = 0; i < CORE_PROCESS_CORNERS; i++) {
-		if (core_speedo_val < core_process_speedos[threshold_index][i])
+	for (i = 0; i < SOC_PROCESS_CORNERS; i++) {
+		if (soc_speedo_val < soc_process_speedos[threshold_index][i])
 			break;
 	}
-	sku_info->core_process_id = i - 1;
+	sku_info->soc_process_id = i - 1;
 
-	if (sku_info->core_process_id == -1) {
-		pr_warn("Tegra CORE speedo value %3d out of range",
-				 core_speedo_val);
-		sku_info->core_process_id = 0;
+	if (sku_info->soc_process_id == -1) {
+		pr_warn("Tegra SoC speedo value %3d out of range",
+			soc_speedo_val);
+		sku_info->soc_process_id = 0;
 		sku_info->soc_speedo_id = 1;
 	}
 }
diff --git a/include/soc/tegra/fuse.h b/include/soc/tegra/fuse.h
index 0b4209c75b8c..de10788b518a 100644
--- a/include/soc/tegra/fuse.h
+++ b/include/soc/tegra/fuse.h
@@ -48,7 +48,7 @@ struct tegra_sku_info {
 	int cpu_speedo_id;
 	int cpu_speedo_value;
 	int cpu_iddq_value;
-	int core_process_id;
+	int soc_process_id;
 	int soc_speedo_id;
 	int soc_speedo_value;
 	int gpu_process_id;
-- 
2.3.5
