From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 31 May 2017 18:00:01 +0300
Subject: [PATCHv4 4/6] ARM: omap2+: clockdomain: add clkdm_xlate_address
In-Reply-To: <1496242803-6101-1-git-send-email-t-kristo@ti.com>
References: <1496242803-6101-1-git-send-email-t-kristo@ti.com>
Message-ID: <1496242803-6101-5-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This new function can be used to get the physical address of a
clockdomain. Required for mapping the clkctrl clocks under hwmod
without modification to DT data.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c | 8 ++++++++
 arch/arm/mach-omap2/clockdomain.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index b79b1ca..5189264 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -1224,6 +1224,14 @@ int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	return 0;
 }
 
+u32 clkdm_xlate_address(struct clockdomain *clkdm)
+{
+	if (arch_clkdm->clkdm_xlate_address)
+		return arch_clkdm->clkdm_xlate_address(clkdm);
+
+	return 0;
+}
+
 /**
  * clkdm_hwmod_enable - add an enabled downstream hwmod to this clkdm
  * @clkdm: struct clockdomain *
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 24667a5..827f01e 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -175,6 +175,7 @@ struct clkdm_ops {
 	void	(*clkdm_deny_idle)(struct clockdomain *clkdm);
 	int	(*clkdm_clk_enable)(struct clockdomain *clkdm);
 	int	(*clkdm_clk_disable)(struct clockdomain *clkdm);
+	u32	(*clkdm_xlate_address)(struct clockdomain *clkdm);
 };
 
 int clkdm_register_platform_funcs(struct clkdm_ops *co);
@@ -213,6 +214,7 @@ int clkdm_for_each(int (*fn)(struct clockdomain *clkdm, void *user),
 int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk);
 int clkdm_hwmod_enable(struct clockdomain *clkdm, struct omap_hwmod *oh);
 int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh);
+u32 clkdm_xlate_address(struct clockdomain *clkdm);
 
 extern void __init omap242x_clockdomains_init(void);
 extern void __init omap243x_clockdomains_init(void);
-- 
1.9.1
