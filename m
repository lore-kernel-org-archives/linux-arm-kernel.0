From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:35:22 +0100
Subject: [PATCH 052/222] ARM: l2c: tegra: remove associativity and way size
 from aux_ctrl
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdePa-0007Gd-Kt@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-tegra/tegra.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index ecbb5411a104..fb802e24b647 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -73,25 +73,9 @@ u32 tegra_uart_config[3] = {
 static void __init tegra_init_cache(void)
 {
 #ifdef CONFIG_CACHE_L2X0
-	static const struct of_device_id pl310_ids[] __initconst = {
-		{ .compatible = "arm,pl310-cache",  },
-		{}
-	};
-
-	struct device_node *np;
 	int ret;
-	void __iomem *p = IO_ADDRESS(TEGRA_ARM_PERIF_BASE) + 0x3000;
-	u32 aux_ctrl, cache_type;
-
-	np = of_find_matching_node(NULL, pl310_ids);
-	if (!np)
-		return;
-
-	cache_type = readl(p + L2X0_CACHE_TYPE);
-	aux_ctrl = (cache_type & 0x700) << (17-8);
-	aux_ctrl |= 0x3c400001;
 
-	ret = l2x0_of_init(aux_ctrl, 0xc200c3fe);
+	ret = l2x0_of_init(0x3c400001, 0xc20fc3fe);
 	if (!ret)
 		l2x0_saved_regs_addr = virt_to_phys(&l2x0_saved_regs);
 #endif
-- 
1.8.3.1
