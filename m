From: david@lechnology.com (David Lechner)
Date: Thu, 14 Apr 2016 14:13:35 -0500
Subject: [PATCH 1/2] ARM: davinci: Move clock init after ioremap.
In-Reply-To: <1460661217-7389-1-git-send-email-david@lechnology.com>
References: <1460661217-7389-1-git-send-email-david@lechnology.com>
Message-ID: <1460661217-7389-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some clocks (such as the USB PHY clocks in DA8xx) will need to use iomem.
The davinci_common_init() function must be called before the ioremap, so
the clock init is now split out as separate function.

Signed-off-by: David Lechner <david@lechnology.com>
---

v4 changes:

* no longer wrapping davinci_clk_init() since it does not return an error.


 arch/arm/mach-davinci/clock.c  | 2 +-
 arch/arm/mach-davinci/common.c | 6 ------
 arch/arm/mach-davinci/da830.c  | 2 ++
 arch/arm/mach-davinci/da850.c  | 2 ++
 arch/arm/mach-davinci/dm355.c  | 1 +
 arch/arm/mach-davinci/dm365.c  | 1 +
 arch/arm/mach-davinci/dm644x.c | 1 +
 arch/arm/mach-davinci/dm646x.c | 1 +
 8 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index 34b4f9f..df42c93 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -577,7 +577,7 @@ EXPORT_SYMBOL(davinci_set_pllrate);
  * than that used by default in <soc>.c file. The reference clock rate
  * should be updated early in the boot process; ideally soon after the
  * clock tree has been initialized once with the default reference clock
- * rate (davinci_common_init()).
+ * rate (davinci_clk_init()).
  *
  * Returns 0 on success, error otherwise.
  */
diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index 742133b..049025f 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -108,12 +108,6 @@ void __init davinci_common_init(struct davinci_soc_info *soc_info)
 	if (ret < 0)
 		goto err;
 
-	if (davinci_soc_info.cpu_clks) {
-		ret = davinci_clk_init(davinci_soc_info.cpu_clks);
-
-		if (ret != 0)
-			goto err;
-	}
 
 	return;
 
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 7187e7f..426fd74 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -1214,4 +1214,6 @@ void __init da830_init(void)
 
 	da8xx_syscfg0_base = ioremap(DA8XX_SYSCFG0_BASE, SZ_4K);
 	WARN(!da8xx_syscfg0_base, "Unable to map syscfg0 module");
+
+	davinci_clk_init(davinci_soc_info_da830.cpu_clks);
 }
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 97d8779..1f85bbc 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1346,4 +1346,6 @@ void __init da850_init(void)
 	v = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
 	v &= ~CFGCHIP3_PLL1_MASTER_LOCK;
 	__raw_writel(v, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
+
+	davinci_clk_init(davinci_soc_info_da850.cpu_clks);
 }
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index a0ecf49..5a19cca 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -1052,6 +1052,7 @@ void __init dm355_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm355);
 	davinci_map_sysmod();
+	davinci_clk_init(davinci_soc_info_dm355.cpu_clks);
 }
 
 int __init dm355_init_video(struct vpfe_config *vpfe_cfg,
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 384d367..8aa004b 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1176,6 +1176,7 @@ void __init dm365_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm365);
 	davinci_map_sysmod();
+	davinci_clk_init(davinci_soc_info_dm365.cpu_clks);
 }
 
 static struct resource dm365_vpss_resources[] = {
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index b4b3a8b..0afa279 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -932,6 +932,7 @@ void __init dm644x_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm644x);
 	davinci_map_sysmod();
+	davinci_clk_init(davinci_soc_info_dm644x.cpu_clks);
 }
 
 int __init dm644x_init_video(struct vpfe_config *vpfe_cfg,
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index a43db0f..da21353 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -956,6 +956,7 @@ void __init dm646x_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm646x);
 	davinci_map_sysmod();
+	davinci_clk_init(davinci_soc_info_dm646x.cpu_clks);
 }
 
 static int __init dm646x_init_devices(void)
-- 
1.9.1
