From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 15 Apr 2016 16:05:46 +0900
Subject: [PATCH] ARM: cache-uniphier: activate ways for secondary CPUs
Message-ID: <1460703947-12539-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This outer cache allows to control active ways independently for
each CPU, but currently nothing is done for secondary CPUs.  In
other words, all the ways are locked for secondary CPUs by default.
This commit fixes it to fully bring out the performance of this
outer cache.

There would be two possible ways to achieve this:

[1] Each CPU initializes active ways for itself.  This can be done
    via the SSCLPDAWCR register.  This is a banked register, so each
    CPU sees a different instance of the register.

[2] The master CPU initializes active ways for all the CPUs.  This
    is available via SSCDAWCARMR(N) registers.  They are mapped at
    the address SSCDAWCARMR + 4 * N, where N is the CPU number.

Currently, the outer cache frame work does not support a per-CPU
init callback.  So this commit adopts [2]; the master CPU iterates
over possible CPUs setting up SSCDAWCARMR(N) registers.

Unfortunately, the register offsets of SSCDAWCARMR(N) are different
by SoC.  We can live with it by checking the version register.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mm/cache-uniphier.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/cache-uniphier.c b/arch/arm/mm/cache-uniphier.c
index a6fa7b7..c8e2f49 100644
--- a/arch/arm/mm/cache-uniphier.c
+++ b/arch/arm/mm/cache-uniphier.c
@@ -96,6 +96,7 @@ struct uniphier_cache_data {
 	void __iomem *ctrl_base;
 	void __iomem *rev_base;
 	void __iomem *op_base;
+	void __iomem *way_ctrl_base;
 	u32 way_present_mask;
 	u32 way_locked_mask;
 	u32 nsets;
@@ -256,10 +257,13 @@ static void __init __uniphier_cache_set_locked_ways(
 					struct uniphier_cache_data *data,
 					u32 way_mask)
 {
+	unsigned int cpu;
+
 	data->way_locked_mask = way_mask & data->way_present_mask;
 
-	writel_relaxed(~data->way_locked_mask & data->way_present_mask,
-		       data->ctrl_base + UNIPHIER_SSCLPDAWCR);
+	for_each_possible_cpu(cpu)
+		writel_relaxed(~data->way_locked_mask & data->way_present_mask,
+			       data->way_ctrl_base + 4 * cpu);
 }
 
 static void uniphier_cache_maint_range(unsigned long start, unsigned long end,
@@ -459,6 +463,8 @@ static int __init __uniphier_cache_init(struct device_node *np,
 		goto err;
 	}
 
+	data->way_ctrl_base = data->ctrl_base + 0xc00;
+
 	if (*cache_level == 2) {
 		u32 revision = readl(data->rev_base + UNIPHIER_SSCID);
 		/*
@@ -467,6 +473,22 @@ static int __init __uniphier_cache_init(struct device_node *np,
 		 */
 		if (revision <= 0x16)
 			data->range_op_max_size = (u32)1 << 22;
+
+		/*
+		 * Unfortunatly, the offset address of active way control base
+		 * varies from SoC to SoC.
+		 */
+		switch (revision) {
+		case 0x11:	/* sLD3 */
+			data->way_ctrl_base = data->ctrl_base + 0x870;
+			break;
+		case 0x12:	/* LD4 */
+		case 0x16:	/* sld8 */
+			data->way_ctrl_base = data->ctrl_base + 0x840;
+			break;
+		default:
+			break;
+		}
 	}
 
 	data->range_op_max_size -= data->line_size;
-- 
1.9.1
