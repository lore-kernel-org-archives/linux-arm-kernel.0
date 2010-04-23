From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Apr 2010 16:11:42 -0700
Subject: [PATCH 16/28] omap: fix a gpmc nand problem
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Message-ID: <20100423231141.31953.6690.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: stanley.miao <stanley.miao@windriver.com>

If gpmc_t isn't given, we don't need to set timing for gpmc, or it will cause
a Oops.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/gpmc-nand.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 64d74f0..e57fb29 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -39,6 +39,9 @@ static int omap2_nand_gpmc_retime(void)
 	struct gpmc_timings t;
 	int err;
 
+	if (!gpmc_nand_data->gpmc_t)
+		return 0;
+
 	memset(&t, 0, sizeof(t));
 	t.sync_clk = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->sync_clk);
 	t.cs_on = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->cs_on);
