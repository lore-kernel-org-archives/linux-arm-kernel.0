From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  2 Mar 2012 07:45:58 -0300
Subject: [PATCH 1/2] ARM: mx5: Use common function for configuring AIPS
Message-ID: <1330685159-4137-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that a common imx_set_aips() function is available, use it on mx51 and mx53.

This lets the code smaller and cleaner.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/cpu-imx5.c |   36 ------------------------------------
 arch/arm/mach-imx/mm-imx5.c  |    8 ++++++++
 2 files changed, 8 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-imx/cpu-imx5.c b/arch/arm/mach-imx/cpu-imx5.c
index 5e2e7a8..aa15c51 100644
--- a/arch/arm/mach-imx/cpu-imx5.c
+++ b/arch/arm/mach-imx/cpu-imx5.c
@@ -149,39 +149,3 @@ int mx50_revision(void)
 	return mx5_cpu_rev;
 }
 EXPORT_SYMBOL(mx50_revision);
-
-static int __init post_cpu_init(void)
-{
-	unsigned int reg;
-	void __iomem *base;
-
-	if (cpu_is_mx51() || cpu_is_mx53()) {
-		if (cpu_is_mx51())
-			base = MX51_IO_ADDRESS(MX51_AIPS1_BASE_ADDR);
-		else
-			base = MX53_IO_ADDRESS(MX53_AIPS1_BASE_ADDR);
-
-		__raw_writel(0x0, base + 0x40);
-		__raw_writel(0x0, base + 0x44);
-		__raw_writel(0x0, base + 0x48);
-		__raw_writel(0x0, base + 0x4C);
-		reg = __raw_readl(base + 0x50) & 0x00FFFFFF;
-		__raw_writel(reg, base + 0x50);
-
-		if (cpu_is_mx51())
-			base = MX51_IO_ADDRESS(MX51_AIPS2_BASE_ADDR);
-		else
-			base = MX53_IO_ADDRESS(MX53_AIPS2_BASE_ADDR);
-
-		__raw_writel(0x0, base + 0x40);
-		__raw_writel(0x0, base + 0x44);
-		__raw_writel(0x0, base + 0x48);
-		__raw_writel(0x0, base + 0x4C);
-		reg = __raw_readl(base + 0x50) & 0x00FFFFFF;
-		__raw_writel(reg, base + 0x50);
-	}
-
-	return 0;
-}
-
-postcore_initcall(post_cpu_init);
diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index 49549a7..8543ffb 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -185,6 +185,10 @@ void __init imx51_soc_init(void)
 
 	/* i.mx51 has the i.mx35 type sdma */
 	imx_add_imx_sdma("imx35-sdma", MX51_SDMA_BASE_ADDR, MX51_INT_SDMA, &imx51_sdma_pdata);
+
+	/* Setup AIPS registers */
+	imx_set_aips(MX51_IO_ADDRESS(MX51_AIPS1_BASE_ADDR));
+	imx_set_aips(MX51_IO_ADDRESS(MX51_AIPS2_BASE_ADDR));
 }
 
 void __init imx53_soc_init(void)
@@ -200,4 +204,8 @@ void __init imx53_soc_init(void)
 
 	/* i.mx53 has the i.mx35 type sdma */
 	imx_add_imx_sdma("imx35-sdma", MX53_SDMA_BASE_ADDR, MX53_INT_SDMA, &imx53_sdma_pdata);
+
+	/* Setup AIPS registers */
+	imx_set_aips(MX53_IO_ADDRESS(MX53_AIPS1_BASE_ADDR));
+	imx_set_aips(MX53_IO_ADDRESS(MX53_AIPS2_BASE_ADDR));
 }
-- 
1.7.1
