From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 13 Jul 2015 13:39:42 +0100
Subject: [PATCH V3 04/19] memory: tegra: add flush operation for Tegra114
 memory clients
In-Reply-To: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <1436791197-32358-5-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vince Hsu <vinceh@nvidia.com>

This patch adds the hot reset register table and flush related callback
functions for Tegra114.

Signed-off-by: Vince Hsu <vinceh@nvidia.com>
[jonathanh at nvidia.com: Removed tegra_mc_ops and added
 metastable_flush_reads.]
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/memory/tegra/tegra114.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/memory/tegra/tegra114.c b/drivers/memory/tegra/tegra114.c
index 9f579589e800..ba33c402ed68 100644
--- a/drivers/memory/tegra/tegra114.c
+++ b/drivers/memory/tegra/tegra114.c
@@ -914,6 +914,24 @@ static const struct tegra_smmu_swgroup tegra114_swgroups[] = {
 	{ .name = "tsec",      .swgroup = TEGRA_SWGROUP_TSEC,      .reg = 0x294 },
 };
 
+static struct tegra_mc_flush tegra114_mc_flush[] = {
+	{TEGRA_SWGROUP_AVPC,       0x200, 0x204,  1},
+	{TEGRA_SWGROUP_DC,         0x200, 0x204,  2},
+	{TEGRA_SWGROUP_DCB,        0x200, 0x204,  3},
+	{TEGRA_SWGROUP_EPP,        0x200, 0x204,  4},
+	{TEGRA_SWGROUP_G2,         0x200, 0x204,  5},
+	{TEGRA_SWGROUP_HC,         0x200, 0x204,  6},
+	{TEGRA_SWGROUP_HDA,        0x200, 0x204,  7},
+	{TEGRA_SWGROUP_ISP,        0x200, 0x204,  8},
+	{TEGRA_SWGROUP_MPCORE,     0x200, 0x204,  9},
+	{TEGRA_SWGROUP_MPCORELP,   0x200, 0x204, 10},
+	{TEGRA_SWGROUP_MSENC,      0x200, 0x204, 11},
+	{TEGRA_SWGROUP_NV,         0x200, 0x204, 12},
+	{TEGRA_SWGROUP_PPCS,       0x200, 0x204, 14},
+	{TEGRA_SWGROUP_VDE,        0x200, 0x204, 16},
+	{TEGRA_SWGROUP_VI,         0x200, 0x204, 17},
+};
+
 static void tegra114_flush_dcache(struct page *page, unsigned long offset,
 				  size_t size)
 {
@@ -945,4 +963,7 @@ const struct tegra_mc_soc tegra114_mc_soc = {
 	.num_address_bits = 32,
 	.atom_size = 32,
 	.smmu = &tegra114_smmu_soc,
+	.flushes = tegra114_mc_flush,
+	.num_flushes = ARRAY_SIZE(tegra114_mc_flush),
+	.metastable_flush_reads = MC_FLUSH_METASTABLE_READS,
 };
-- 
2.1.4
