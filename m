From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: Make Integrator/Versatile/Reaview VCO code similar
References: <git-1267729916-2297f112a4e3ab4a5241c68977bf2e1b96438c54@rmk-PC>
Message-ID: <git-1267729916-7f33674fea37cfdc2c024a267d2d2758cc64085c@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-integrator/impd1.c               |   16 ++++------------
 arch/arm/mach-integrator/include/mach/clkdev.h |    3 ++-
 arch/arm/mach-integrator/integrator_cp.c       |    9 +++++----
 arch/arm/mach-realview/core.c                  |   16 ++++++++--------
 arch/arm/mach-realview/include/mach/clkdev.h   |    2 +-
 arch/arm/mach-versatile/core.c                 |   10 +++++-----
 arch/arm/mach-versatile/include/mach/clkdev.h  |    2 +-
 7 files changed, 26 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index 3e21102..2f9de62 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -55,20 +55,10 @@ static const struct icst_params impd1_vco_params = {
 static void impd1_setvco(struct clk *clk, struct icst_vco vco)
 {
 	struct impd1_module *impd1 = clk->data;
-	int vconr = clk - impd1->vcos;
-	u32 val;
-
-	val = vco.v | (vco.r << 9) | (vco.s << 16);
+	u32 val = vco.v | (vco.r << 9) | (vco.s << 16);
 
 	writel(0xa05f, impd1->base + IMPD1_LOCK);
-	switch (vconr) {
-	case 0:
-		writel(val, impd1->base + IMPD1_OSC1);
-		break;
-	case 1:
-		writel(val, impd1->base + IMPD1_OSC2);
-		break;
-	}
+	writel(val, clk->vcoreg);
 	writel(0, impd1->base + IMPD1_LOCK);
 
 #ifdef DEBUG
@@ -381,6 +371,8 @@ static int impd1_probe(struct lm_device *dev)
 		impd1->vcos[i].data = impd1,
 		impd1->vcos[i].setvco = impd1_setvco;
 	}
+	impd1->vcos[0].vcoreg = impd1->base + IMPD1_OSC1;
+	impd1->vcos[1].vcoreg = impd1->base + IMPD1_OSC2;
 
 	impd1->clks[0] = clkdev_alloc(&impd1->vcos[0], NULL, "lm%x:01000",
 					dev->id);
diff --git a/arch/arm/mach-integrator/include/mach/clkdev.h b/arch/arm/mach-integrator/include/mach/clkdev.h
index 89ea938..ed67e8e 100644
--- a/arch/arm/mach-integrator/include/mach/clkdev.h
+++ b/arch/arm/mach-integrator/include/mach/clkdev.h
@@ -8,8 +8,9 @@ struct clk {
 	unsigned long		rate;
 	struct module		*owner;
 	const struct icst_params *params;
-	void			*data;
+	void __iomem		*vcoreg;
 	void			(*setvco)(struct clk *, struct icst_vco vco);
+	void			*data;
 };
 
 static inline int __clk_get(struct clk *clk)
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 5a5a8c1..5908580 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -266,8 +266,8 @@ static void __init intcp_init_irq(void)
 /*
  * Clock handling
  */
-#define CM_LOCK IO_ADDRESS(INTEGRATOR_HDR_LOCK)
-#define CM_AUXOSC IO_ADDRESS(INTEGRATOR_HDR_BASE + 0x1c)
+#define CM_LOCK		(__io_address(INTEGRATOR_HDR_BASE)+INTEGRATOR_HDR_LOCK_OFFSET)
+#define CM_AUXOSC	(__io_address(INTEGRATOR_HDR_BASE)+0x1c)
 
 static const struct icst_params cp_auxvco_params = {
 	.ref		= 24000000,
@@ -285,16 +285,17 @@ static void cp_auxvco_set(struct clk *clk, struct icst_vco vco)
 {
 	u32 val;
 
-	val = readl(CM_AUXOSC) & ~0x7ffff;
+	val = readl(clk->vcoreg) & ~0x7ffff;
 	val |= vco.v | (vco.r << 9) | (vco.s << 16);
 
 	writel(0xa05f, CM_LOCK);
-	writel(val, CM_AUXOSC);
+	writel(val, clk->vcoreg);
 	writel(0, CM_LOCK);
 }
 
 static struct clk cp_auxclk = {
 	.params	= &cp_auxvco_params,
+	.vcoreg	= CM_AUXOSC,
 	.setvco = cp_auxvco_set,
 };
 
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index f97f001..043b93b 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -271,19 +271,13 @@ static const struct icst_params realview_oscvco_params = {
 static void realview_oscvco_set(struct clk *clk, struct icst_vco vco)
 {
 	void __iomem *sys_lock = __io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_LOCK_OFFSET;
-	void __iomem *sys_osc;
 	u32 val;
 
-	if (machine_is_realview_pb1176())
-		sys_osc = __io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_OSC0_OFFSET;
-	else
-		sys_osc = __io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_OSC4_OFFSET;
-
-	val = readl(sys_osc) & ~0x7ffff;
+	val = readl(clk->vcoreg) & ~0x7ffff;
 	val |= vco.v | (vco.r << 9) | (vco.s << 16);
 
 	writel(0xa05f, sys_lock);
-	writel(val, sys_osc);
+	writel(val, clk->vcoreg);
 	writel(0, sys_lock);
 }
 
@@ -332,7 +326,13 @@ static struct clk_lookup lookups[] = {
 
 static int __init clk_init(void)
 {
+	if (machine_is_realview_pb1176())
+		oscvco_clk.vcoreg = __io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_OSC0_OFFSET;
+	else
+		oscvco_clk.vcoreg = __io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_OSC4_OFFSET;
+
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
 	return 0;
 }
 arch_initcall(clk_init);
diff --git a/arch/arm/mach-realview/include/mach/clkdev.h b/arch/arm/mach-realview/include/mach/clkdev.h
index fefe467..baea03c 100644
--- a/arch/arm/mach-realview/include/mach/clkdev.h
+++ b/arch/arm/mach-realview/include/mach/clkdev.h
@@ -6,7 +6,7 @@
 struct clk {
 	unsigned long		rate;
 	const struct icst_params *params;
-	u32			oscoff;
+	void __iomem		*vcoreg;
 	void			(*setvco)(struct clk *, struct icst_vco vco);
 };
 
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 490fc75..957bbde 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -370,21 +370,19 @@ static const struct icst_params versatile_oscvco_params = {
 
 static void versatile_oscvco_set(struct clk *clk, struct icst_vco vco)
 {
-	void __iomem *sys = __io_address(VERSATILE_SYS_BASE);
-	void __iomem *sys_lock = sys + VERSATILE_SYS_LOCK_OFFSET;
+	void __iomem *sys_lock = __io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_LOCK_OFFSET;
 	u32 val;
 
-	val = readl(sys + clk->oscoff) & ~0x7ffff;
+	val = readl(clk->vcoreg) & ~0x7ffff;
 	val |= vco.v | (vco.r << 9) | (vco.s << 16);
 
 	writel(0xa05f, sys_lock);
-	writel(val, sys + clk->oscoff);
+	writel(val, clk->vcoreg);
 	writel(0, sys_lock);
 }
 
 static struct clk osc4_clk = {
 	.params	= &versatile_oscvco_params,
-	.oscoff	= VERSATILE_SYS_OSCCLCD_OFFSET,
 	.setvco	= versatile_oscvco_set,
 };
 
@@ -831,6 +829,8 @@ void __init versatile_init(void)
 {
 	int i;
 
+	osc4_clk.vcoreg	= __io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_OSCCLCD_OFFSET;
+
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
 	platform_device_register(&versatile_flash_device);
diff --git a/arch/arm/mach-versatile/include/mach/clkdev.h b/arch/arm/mach-versatile/include/mach/clkdev.h
index fefe467..baea03c 100644
--- a/arch/arm/mach-versatile/include/mach/clkdev.h
+++ b/arch/arm/mach-versatile/include/mach/clkdev.h
@@ -6,7 +6,7 @@
 struct clk {
 	unsigned long		rate;
 	const struct icst_params *params;
-	u32			oscoff;
+	void __iomem		*vcoreg;
 	void			(*setvco)(struct clk *, struct icst_vco vco);
 };
 
