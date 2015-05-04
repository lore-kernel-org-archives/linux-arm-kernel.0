From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  4 May 2015 13:46:40 +0200
Subject: [PATCH 2/8] soc/tegra: pmc: Add Tegra210 support
In-Reply-To: <1430740006-29539-1-git-send-email-thierry.reding@gmail.com>
References: <1430740006-29539-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1430740006-29539-3-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Tegra210 uses a power management controller that is compatible with
earlier SoC generations but adds a couple of power partitions for new
hardware blocks.

Reviewed-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/soc/tegra/pmc.h |  5 +++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 500339985dbe..ada94e16288e 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -993,7 +993,55 @@ static const struct tegra_pmc_soc tegra124_pmc_soc = {
 	.has_gpu_clamps = true,
 };
 
+static const char * const tegra210_powergates[] = {
+	[TEGRA_POWERGATE_CPU] = "crail",
+	[TEGRA_POWERGATE_3D] = "3d",
+	[TEGRA_POWERGATE_VENC] = "venc",
+	[TEGRA_POWERGATE_PCIE] = "pcie",
+	[TEGRA_POWERGATE_L2] = "l2",
+	[TEGRA_POWERGATE_MPE] = "mpe",
+	[TEGRA_POWERGATE_HEG] = "heg",
+	[TEGRA_POWERGATE_SATA] = "sata",
+	[TEGRA_POWERGATE_CPU1] = "cpu1",
+	[TEGRA_POWERGATE_CPU2] = "cpu2",
+	[TEGRA_POWERGATE_CPU3] = "cpu3",
+	[TEGRA_POWERGATE_CELP] = "celp",
+	[TEGRA_POWERGATE_CPU0] = "cpu0",
+	[TEGRA_POWERGATE_C0NC] = "c0nc",
+	[TEGRA_POWERGATE_C1NC] = "c1nc",
+	[TEGRA_POWERGATE_SOR] = "sor",
+	[TEGRA_POWERGATE_DIS] = "dis",
+	[TEGRA_POWERGATE_DISB] = "disb",
+	[TEGRA_POWERGATE_XUSBA] = "xusba",
+	[TEGRA_POWERGATE_XUSBB] = "xusbb",
+	[TEGRA_POWERGATE_XUSBC] = "xusbc",
+	[TEGRA_POWERGATE_VIC] = "vic",
+	[TEGRA_POWERGATE_IRAM] = "iram",
+	[TEGRA_POWERGATE_NVDEC] = "nvdec",
+	[TEGRA_POWERGATE_NVJPG] = "nvjpg",
+	[TEGRA_POWERGATE_AUD] = "aud",
+	[TEGRA_POWERGATE_DFD] = "dfd",
+	[TEGRA_POWERGATE_VE2] = "ve2",
+};
+
+static const u8 tegra210_cpu_powergates[] = {
+	TEGRA_POWERGATE_CPU0,
+	TEGRA_POWERGATE_CPU1,
+	TEGRA_POWERGATE_CPU2,
+	TEGRA_POWERGATE_CPU3,
+};
+
+static const struct tegra_pmc_soc tegra210_pmc_soc = {
+	.num_powergates = ARRAY_SIZE(tegra210_powergates),
+	.powergates = tegra210_powergates,
+	.num_cpu_powergates = ARRAY_SIZE(tegra210_cpu_powergates),
+	.cpu_powergates = tegra210_cpu_powergates,
+	.has_tsense_reset = true,
+	.has_gpu_clamps = true,
+};
+
 static const struct of_device_id tegra_pmc_match[] = {
+	{ .compatible = "nvidia,tegra210-pmc", .data = &tegra210_pmc_soc },
 	{ .compatible = "nvidia,tegra132-pmc", .data = &tegra124_pmc_soc },
 	{ .compatible = "nvidia,tegra124-pmc", .data = &tegra124_pmc_soc },
 	{ .compatible = "nvidia,tegra114-pmc", .data = &tegra114_pmc_soc },
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index 65a93273e72f..75878006174f 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -69,6 +69,11 @@ int tegra_pmc_cpu_remove_clamping(int cpuid);
 #define TEGRA_POWERGATE_XUSBC	22
 #define TEGRA_POWERGATE_VIC	23
 #define TEGRA_POWERGATE_IRAM	24
+#define TEGRA_POWERGATE_NVDEC	25
+#define TEGRA_POWERGATE_NVJPG	26
+#define TEGRA_POWERGATE_AUD	27
+#define TEGRA_POWERGATE_DFD	28
+#define TEGRA_POWERGATE_VE2	29
 
 #define TEGRA_POWERGATE_3D0	TEGRA_POWERGATE_3D
 
-- 
2.3.5
