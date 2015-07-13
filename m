From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 13 Jul 2015 13:39:43 +0100
Subject: [PATCH V3 05/19] memory: tegra: add flush operation for Tegra124
 memory clients
In-Reply-To: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <1436791197-32358-6-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vince Hsu <vinceh@nvidia.com>

This patch adds the hot reset register table and flush related callback
functions for Tegra124.

Signed-off-by: Vince Hsu <vinceh@nvidia.com>
[jonathanh at nvidia.com: Removed tegra_mc_ops and added
 metastable_flush_reads.]
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/memory/tegra/tegra124.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index 966e1557e6f4..a24993db14ed 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -1002,6 +1002,34 @@ static const struct tegra_smmu_swgroup tegra124_swgroups[] = {
 };
 
 #ifdef CONFIG_ARCH_TEGRA_124_SOC
+
+static struct tegra_mc_flush tegra124_mc_flush[] = {
+	{TEGRA_SWGROUP_AFI,        0x200, 0x204,  0},
+	{TEGRA_SWGROUP_AVPC,       0x200, 0x204,  1},
+	{TEGRA_SWGROUP_DC,         0x200, 0x204,  2},
+	{TEGRA_SWGROUP_DCB,        0x200, 0x204,  3},
+	{TEGRA_SWGROUP_HC,         0x200, 0x204,  6},
+	{TEGRA_SWGROUP_HDA,        0x200, 0x204,  7},
+	{TEGRA_SWGROUP_ISP2,       0x200, 0x204,  8},
+	{TEGRA_SWGROUP_MPCORE,     0x200, 0x204,  9},
+	{TEGRA_SWGROUP_MPCORELP,   0x200, 0x204, 10},
+	{TEGRA_SWGROUP_MSENC,      0x200, 0x204, 11},
+	{TEGRA_SWGROUP_PPCS,       0x200, 0x204, 14},
+	{TEGRA_SWGROUP_SATA,       0x200, 0x204, 15},
+	{TEGRA_SWGROUP_VDE,        0x200, 0x204, 16},
+	{TEGRA_SWGROUP_VI,         0x200, 0x204, 17},
+	{TEGRA_SWGROUP_VIC,        0x200, 0x204, 18},
+	{TEGRA_SWGROUP_XUSB_HOST,  0x200, 0x204, 19},
+	{TEGRA_SWGROUP_XUSB_DEV,   0x200, 0x204, 20},
+	{TEGRA_SWGROUP_TSEC,       0x200, 0x204, 22},
+	{TEGRA_SWGROUP_SDMMC1A,    0x200, 0x204, 29},
+	{TEGRA_SWGROUP_SDMMC2A,    0x200, 0x204, 30},
+	{TEGRA_SWGROUP_SDMMC3A,    0x200, 0x204, 31},
+	{TEGRA_SWGROUP_SDMMC4A,    0x970, 0x974,  0},
+	{TEGRA_SWGROUP_ISP2B,      0x970, 0x974,  1},
+	{TEGRA_SWGROUP_GPU,        0x970, 0x974,  2},
+};
+
 static void tegra124_flush_dcache(struct page *page, unsigned long offset,
 				  size_t size)
 {
@@ -1035,6 +1063,9 @@ const struct tegra_mc_soc tegra124_mc_soc = {
 	.smmu = &tegra124_smmu_soc,
 	.emem_regs = tegra124_mc_emem_regs,
 	.num_emem_regs = ARRAY_SIZE(tegra124_mc_emem_regs),
+	.flushes = tegra124_mc_flush,
+	.num_flushes = ARRAY_SIZE(tegra124_mc_flush),
+	.metastable_flush_reads = MC_FLUSH_METASTABLE_READS,
 };
 #endif /* CONFIG_ARCH_TEGRA_124_SOC */
 
-- 
2.1.4
