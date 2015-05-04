From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  4 May 2015 13:46:45 +0200
Subject: [PATCH 7/8] soc/tegra: fuse: Add Tegra210 support
In-Reply-To: <1430740006-29539-1-git-send-email-thierry.reding@gmail.com>
References: <1430740006-29539-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1430740006-29539-8-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Add Tegra210 support to the fuses driver and add Tegra210-specific
speedo definitions.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/fuse/Makefile          |   1 +
 drivers/soc/tegra/fuse/fuse-tegra.c      |   4 +
 drivers/soc/tegra/fuse/fuse-tegra30.c    |  16 ++-
 drivers/soc/tegra/fuse/fuse.h            |   8 ++
 drivers/soc/tegra/fuse/speedo-tegra210.c | 184 +++++++++++++++++++++++++++++++
 include/soc/tegra/fuse.h                 |   4 +-
 6 files changed, 215 insertions(+), 2 deletions(-)
 create mode 100644 drivers/soc/tegra/fuse/speedo-tegra210.c

diff --git a/drivers/soc/tegra/fuse/Makefile b/drivers/soc/tegra/fuse/Makefile
index 4adfce09d3a9..21bc27580178 100644
--- a/drivers/soc/tegra/fuse/Makefile
+++ b/drivers/soc/tegra/fuse/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= speedo-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= speedo-tegra114.o
 obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= speedo-tegra124.o
 obj-$(CONFIG_ARCH_TEGRA_132_SOC)	+= speedo-tegra124.o
+obj-$(CONFIG_ARCH_TEGRA_210_SOC)	+= speedo-tegra210.o
diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index de81eb6b4e92..45496c0d9b29 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -91,6 +91,7 @@ static const struct of_device_id car_match[] __initconst = {
 	{ .compatible = "nvidia,tegra114-car", },
 	{ .compatible = "nvidia,tegra124-car", },
 	{ .compatible = "nvidia,tegra132-car", },
+	{ .compatible = "nvidia,tegra210-car", },
 	{},
 };
 
@@ -100,6 +101,9 @@ static struct tegra_fuse *fuse = &(struct tegra_fuse) {
 };
 
 static const struct of_device_id tegra_fuse_match[] = {
+#ifdef CONFIG_ARCH_TEGRA_210_SOC
+	{ .compatible = "nvidia,tegra210-efuse", .data = &tegra210_fuse_soc },
+#endif
 #ifdef CONFIG_ARCH_TEGRA_132_SOC
 	{ .compatible = "nvidia,tegra132-efuse", .data = &tegra124_fuse_soc },
 #endif
diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index 4a7f207171ad..a9c6c925ff19 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -45,7 +45,8 @@
 #if defined(CONFIG_ARCH_TEGRA_3x_SOC) || \
     defined(CONFIG_ARCH_TEGRA_114_SOC) || \
     defined(CONFIG_ARCH_TEGRA_124_SOC) || \
-    defined(CONFIG_ARCH_TEGRA_132_SOC)
+    defined(CONFIG_ARCH_TEGRA_132_SOC) || \
+    defined(CONFIG_ARCH_TEGRA_210_SOC)
 static u32 tegra30_fuse_read(struct tegra_fuse *fuse, unsigned int offset)
 {
 	u32 val;
@@ -137,3 +138,16 @@ const struct tegra_fuse_soc tegra124_fuse_soc = {
 	.info = &tegra124_fuse_info,
 };
 #endif
+
+#if defined(CONFIG_ARCH_TEGRA_210_SOC)
+static const struct tegra_fuse_info tegra210_fuse_info = {
+	.read = tegra30_fuse_read,
+	.size = 0x300,
+};
+
+const struct tegra_fuse_soc tegra210_fuse_soc = {
+	.init = tegra30_fuse_init,
+	.speedo_init = tegra210_init_speedo_data,
+	.info = &tegra210_fuse_info,
+};
+#endif
diff --git a/drivers/soc/tegra/fuse/fuse.h b/drivers/soc/tegra/fuse/fuse.h
index 2a32bf9381ce..10c2076d5089 100644
--- a/drivers/soc/tegra/fuse/fuse.h
+++ b/drivers/soc/tegra/fuse/fuse.h
@@ -81,6 +81,10 @@ void tegra114_init_speedo_data(struct tegra_sku_info *sku_info);
 void tegra124_init_speedo_data(struct tegra_sku_info *sku_info);
 #endif
 
+#ifdef CONFIG_ARCH_TEGRA_210_SOC
+void tegra210_init_speedo_data(struct tegra_sku_info *sku_info);
+#endif
+
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 extern const struct tegra_fuse_soc tegra20_fuse_soc;
 #endif
@@ -97,4 +101,8 @@ extern const struct tegra_fuse_soc tegra114_fuse_soc;
 extern const struct tegra_fuse_soc tegra124_fuse_soc;
 #endif
 
+#ifdef CONFIG_ARCH_TEGRA_210_SOC
+extern const struct tegra_fuse_soc tegra210_fuse_soc;
+#endif
+
 #endif
diff --git a/drivers/soc/tegra/fuse/speedo-tegra210.c b/drivers/soc/tegra/fuse/speedo-tegra210.c
new file mode 100644
index 000000000000..303f5a7dc614
--- /dev/null
+++ b/drivers/soc/tegra/fuse/speedo-tegra210.c
@@ -0,0 +1,184 @@
+/*
+ * Copyright (c) 2013-2015, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/bug.h>
+
+#include <soc/tegra/fuse.h>
+
+#include "fuse.h"
+
+#define CPU_PROCESS_CORNERS	2
+#define GPU_PROCESS_CORNERS	2
+#define SOC_PROCESS_CORNERS	3
+
+#define FUSE_CPU_SPEEDO_0	0x014
+#define FUSE_CPU_SPEEDO_1	0x02c
+#define FUSE_CPU_SPEEDO_2	0x030
+#define FUSE_SOC_SPEEDO_0	0x034
+#define FUSE_SOC_SPEEDO_1	0x038
+#define FUSE_SOC_SPEEDO_2	0x03c
+#define FUSE_CPU_IDDQ		0x018
+#define FUSE_SOC_IDDQ		0x040
+#define FUSE_GPU_IDDQ		0x128
+#define FUSE_FT_REV		0x028
+
+enum {
+	THRESHOLD_INDEX_0,
+	THRESHOLD_INDEX_1,
+	THRESHOLD_INDEX_COUNT,
+};
+
+static const u32 __initconst cpu_process_speedos[][CPU_PROCESS_CORNERS] = {
+	{ 2119, UINT_MAX },
+	{ 2119, UINT_MAX },
+};
+
+static const u32 __initconst gpu_process_speedos[][GPU_PROCESS_CORNERS] = {
+	{ UINT_MAX, UINT_MAX },
+	{ UINT_MAX, UINT_MAX },
+};
+
+static const u32 __initconst soc_process_speedos[][SOC_PROCESS_CORNERS] = {
+	{ 1950, 2100, UINT_MAX },
+	{ 1950, 2100, UINT_MAX },
+};
+
+static u8 __init get_speedo_revision(void)
+{
+	return tegra30_spare_fuse(4) << 2 |
+	       tegra30_spare_fuse(3) << 1 |
+	       tegra30_spare_fuse(2) << 0;
+}
+
+static void __init rev_sku_to_speedo_ids(struct tegra_sku_info *sku_info,
+					 u8 speedo_rev, int *threshold)
+{
+	int sku = sku_info->sku_id;
+
+	/* Assign to default */
+	sku_info->cpu_speedo_id = 0;
+	sku_info->soc_speedo_id = 0;
+	sku_info->gpu_speedo_id = 0;
+	*threshold = THRESHOLD_INDEX_0;
+
+	switch (sku) {
+	case 0x00: /* Engineering SKU */
+	case 0x01: /* Engineering SKU */
+	case 0x07:
+	case 0x17:
+	case 0x27:
+		if (speedo_rev >= 2)
+			sku_info->gpu_speedo_id = 1;
+		break;
+
+	case 0x13:
+		if (speedo_rev >= 2)
+			sku_info->gpu_speedo_id = 1;
+
+		sku_info->cpu_speedo_id = 1;
+		break;
+
+	default:
+		pr_err("Tegra210: unknown SKU %#04x\n", sku);
+		/* Using the default for the error case */
+		break;
+	}
+}
+
+static int get_process_id(int value, const u32 *speedos, unsigned int num)
+{
+	unsigned int i;
+
+	for (i = 0; i < num; i++)
+		if (value < speedos[num])
+			return i;
+
+	return -EINVAL;
+}
+
+void __init tegra210_init_speedo_data(struct tegra_sku_info *sku_info)
+{
+	int cpu_speedo[3], soc_speedo[3], cpu_iddq, gpu_iddq, soc_iddq;
+	unsigned int index;
+	u8 speedo_revision;
+
+	BUILD_BUG_ON(ARRAY_SIZE(cpu_process_speedos) !=
+			THRESHOLD_INDEX_COUNT);
+	BUILD_BUG_ON(ARRAY_SIZE(gpu_process_speedos) !=
+			THRESHOLD_INDEX_COUNT);
+	BUILD_BUG_ON(ARRAY_SIZE(soc_process_speedos) !=
+			THRESHOLD_INDEX_COUNT);
+
+	/* Read speedo/IDDQ fuses */
+	cpu_speedo[0] = tegra30_fuse_readl(FUSE_CPU_SPEEDO_0);
+	cpu_speedo[1] = tegra30_fuse_readl(FUSE_CPU_SPEEDO_1);
+	cpu_speedo[2] = tegra30_fuse_readl(FUSE_CPU_SPEEDO_2);
+
+	soc_speedo[0] = tegra30_fuse_readl(FUSE_SOC_SPEEDO_0);
+	soc_speedo[1] = tegra30_fuse_readl(FUSE_SOC_SPEEDO_1);
+	soc_speedo[2] = tegra30_fuse_readl(FUSE_CPU_SPEEDO_2);
+
+	cpu_iddq = tegra30_fuse_readl(FUSE_CPU_IDDQ) * 4;
+	soc_iddq = tegra30_fuse_readl(FUSE_SOC_IDDQ) * 4;
+	gpu_iddq = tegra30_fuse_readl(FUSE_GPU_IDDQ) * 5;
+
+	/*
+	 * Determine CPU, GPU and SoC speedo values depending on speedo fusing
+	 * revision. Note that GPU speedo value is fused in CPU_SPEEDO_2.
+	 */
+	speedo_revision = get_speedo_revision();
+	pr_info("Speedo Revision %u\n", speedo_revision);
+
+	if (speedo_revision >= 3) {
+		sku_info->cpu_speedo_value = cpu_speedo[0];
+		sku_info->gpu_speedo_value = cpu_speedo[2];
+		sku_info->soc_speedo_value = soc_speedo[0];
+	} else if (speedo_revision == 2) {
+		sku_info->cpu_speedo_value = (-1938 + (1095 * cpu_speedo[0] / 100)) / 10;
+		sku_info->gpu_speedo_value = (-1662 + (1082 * cpu_speedo[2] / 100)) / 10;
+		sku_info->soc_speedo_value = ( -705 + (1037 * soc_speedo[0] / 100)) / 10;
+	} else {
+		sku_info->cpu_speedo_value = 2100;
+		sku_info->gpu_speedo_value = cpu_speedo[2] - 75;
+		sku_info->soc_speedo_value = 1900;
+	}
+
+	if ((sku_info->cpu_speedo_value <= 0) ||
+	    (sku_info->gpu_speedo_value <= 0) ||
+	    (sku_info->soc_speedo_value <= 0)) {
+		WARN(1, "speedo value not fused\n");
+		return;
+	}
+
+	rev_sku_to_speedo_ids(sku_info, speedo_revision, &index);
+
+	sku_info->gpu_process_id = get_process_id(sku_info->gpu_speedo_value,
+						  gpu_process_speedos[index],
+						  GPU_PROCESS_CORNERS);
+
+	sku_info->cpu_process_id = get_process_id(sku_info->cpu_speedo_value,
+						  cpu_process_speedos[index],
+						  CPU_PROCESS_CORNERS);
+
+	sku_info->soc_process_id = get_process_id(sku_info->soc_speedo_value,
+						  soc_process_speedos[index],
+						  SOC_PROCESS_CORNERS);
+
+	pr_debug("Tegra GPU Speedo ID=%d, Speedo Value=%d\n",
+		 sku_info->gpu_speedo_id, sku_info->gpu_speedo_value);
+}
diff --git a/include/soc/tegra/fuse.h b/include/soc/tegra/fuse.h
index b5f7b5f8d008..0b4209c75b8c 100644
--- a/include/soc/tegra/fuse.h
+++ b/include/soc/tegra/fuse.h
@@ -22,6 +22,7 @@
 #define TEGRA114	0x35
 #define TEGRA124	0x40
 #define TEGRA132	0x13
+#define TEGRA210	0x21
 
 #define TEGRA_FUSE_SKU_CALIB_0	0xf0
 #define TEGRA30_FUSE_SATA_CALIB	0x124
@@ -49,8 +50,9 @@ struct tegra_sku_info {
 	int cpu_iddq_value;
 	int core_process_id;
 	int soc_speedo_id;
-	int gpu_speedo_id;
+	int soc_speedo_value;
 	int gpu_process_id;
+	int gpu_speedo_id;
 	int gpu_speedo_value;
 	enum tegra_revision revision;
 };
-- 
2.3.5
