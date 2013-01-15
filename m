From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 15 Jan 2013 08:14:00 -0000
Subject: [v3 2/9] HACK: ARM: tegra: Use CLK_IGNORE_UNUSED for Tegra 114 SoC
In-Reply-To: <1358237598-32413-1-git-send-email-hdoyu@nvidia.com>
References: <1358237598-32413-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1358237598-32413-3-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use CLK_IGNORE_UNUSED for the Tegra 114 SoC to ensure
clk_disable_unused() is not called. Otherwise the system will die,
because the usecount of the clocks is incorrect. This patch will be
reverted once the Tegra 114 clocks are implemented.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
NOTE: Will be updated once the latest ccf is merged.
---
 arch/arm/mach-tegra/tegra30_clocks_data.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra30_clocks_data.c b/arch/arm/mach-tegra/tegra30_clocks_data.c
index 741d264..dba507c 100644
--- a/arch/arm/mach-tegra/tegra30_clocks_data.c
+++ b/arch/arm/mach-tegra/tegra30_clocks_data.c
@@ -1384,6 +1384,8 @@ static void tegra30_init_one_clock(struct clk *c)
 	if (!clk->lookup.dev_id && !clk->lookup.con_id)
 		clk->lookup.con_id = c->name;
 	clk->lookup.clk = c;
+	if (tegra_chip_id == TEGRA114) /* FIXME: Implement T114 clocks */
+		c->flags |= CLK_IGNORE_UNUSED;
 	clkdev_add(&clk->lookup);
 	tegra_clk_add(c);
 }
-- 
1.7.9.5
