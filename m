From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 15 Jul 2014 18:24:31 +0300
Subject: [PATCH 1/6] clk: tegra: don't abort clk init on error
In-Reply-To: <1405437890-6468-1-git-send-email-pdeschrijver@nvidia.com>
References: <1405437890-6468-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1405437890-6468-2-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just continue initializing clocks if there's an error on one of them. This
is useful if there's a mistake in the inittable, because the system could
hang if clk_disable_unused() disables some of the critical clocks in this
table.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index c0a7d77..d081732 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -207,7 +207,7 @@ void __init tegra_init_from_table(struct tegra_clk_init_table *tbl,
 	for (; tbl->clk_id < clk_max; tbl++) {
 		clk = clks[tbl->clk_id];
 		if (IS_ERR_OR_NULL(clk))
-			return;
+			continue;
 
 		if (tbl->parent_id < clk_max) {
 			struct clk *parent = clks[tbl->parent_id];
-- 
1.7.7.rc0.72.g4b5ea.dirty
