From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 18 Feb 2014 16:51:58 -0700
Subject: [PATCH] ARM: tegra: only run PL310 init on systems with one
Message-ID: <1392767518-27821-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Fix tegra_init_cache() to check whether the system has a PL310 cache
before touching the PL310 registers. This prevents access to non-existent
registers on Tegra114 and later.

Note for stable kernels:
In <= v3.12, the file to patch is arch/arm/mach-tegra/common.c.

Cc: <stable@vger.kernel.org> # v3.9+
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Another fix for 3.14

 arch/arm/mach-tegra/tegra.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 303a285d80fd..6191603379e1 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -73,10 +73,20 @@ u32 tegra_uart_config[3] = {
 static void __init tegra_init_cache(void)
 {
 #ifdef CONFIG_CACHE_L2X0
+	static const struct of_device_id pl310_ids[] __initconst = {
+		{ .compatible = "arm,pl310-cache",  },
+		{}
+	};
+
+	struct device_node *np;
 	int ret;
 	void __iomem *p = IO_ADDRESS(TEGRA_ARM_PERIF_BASE) + 0x3000;
 	u32 aux_ctrl, cache_type;
 
+	np = of_find_matching_node(NULL, pl310_ids);
+	if (!np)
+		return;
+
 	cache_type = readl(p + L2X0_CACHE_TYPE);
 	aux_ctrl = (cache_type & 0x700) << (17-8);
 	aux_ctrl |= 0x7C400001;
-- 
1.8.1.5
