From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Tue, 17 Aug 2010 13:23:38 +0200
Subject: [PATCH 2/2] i.MX35: Add EPIT support
In-Reply-To: <1282044218-14809-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1282044218-14809-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1282044218-14809-3-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig               |    1 +
 arch/arm/mach-mx3/clock-imx35.c         |   13 +++++++++----
 arch/arm/plat-mxc/include/mach/common.h |    1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 85beece..486c05d 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -9,6 +9,7 @@ config ARCH_MX35
 	bool
 	select ARCH_MXC_IOMUX_V3
 	select ARCH_MXC_AUDMUX_V2
+	select HAVE_EPIT
 
 comment "MX3 platforms:"
 
diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index 9b7dbcc..c409ad3 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -368,8 +368,8 @@ DEFINE_CLOCK(cspi2_clk,  1, CCM_CGR0, 12, get_rate_ipg, NULL);
 DEFINE_CLOCK(ect_clk,    0, CCM_CGR0, 14, get_rate_ipg, NULL);
 DEFINE_CLOCK(edio_clk,   0, CCM_CGR0, 16, NULL, NULL);
 DEFINE_CLOCK(emi_clk,    0, CCM_CGR0, 18, get_rate_ipg, NULL);
-DEFINE_CLOCK(epit1_clk,  0, CCM_CGR0, 20, get_rate_ipg_per, NULL);
-DEFINE_CLOCK(epit2_clk,  1, CCM_CGR0, 22, get_rate_ipg_per, NULL);
+DEFINE_CLOCK(epit1_clk,  0, CCM_CGR0, 20, get_rate_ipg, NULL);
+DEFINE_CLOCK(epit2_clk,  1, CCM_CGR0, 22, get_rate_ipg, NULL);
 DEFINE_CLOCK(esai_clk,   0, CCM_CGR0, 24, NULL, NULL);
 DEFINE_CLOCK(esdhc1_clk, 0, CCM_CGR0, 26, get_rate_sdhc, NULL);
 DEFINE_CLOCK(esdhc2_clk, 1, CCM_CGR0, 28, get_rate_sdhc, NULL);
@@ -460,8 +460,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "ect", ect_clk)
 	_REGISTER_CLOCK(NULL, "edio", edio_clk)
 	_REGISTER_CLOCK(NULL, "emi", emi_clk)
-	_REGISTER_CLOCK(NULL, "epit", epit1_clk)
-	_REGISTER_CLOCK(NULL, "epit", epit2_clk)
+	_REGISTER_CLOCK("imx-epit.0", NULL, epit1_clk)
+	_REGISTER_CLOCK("imx-epit.1", NULL, epit2_clk)
 	_REGISTER_CLOCK(NULL, "esai", esai_clk)
 	_REGISTER_CLOCK(NULL, "sdhc", esdhc1_clk)
 	_REGISTER_CLOCK(NULL, "sdhc", esdhc2_clk)
@@ -527,8 +527,13 @@ int __init mx35_clocks_init()
 	__raw_writel((3 << 26) | ll, CCM_BASE + CCM_CGR2);
 	__raw_writel(0, CCM_BASE + CCM_CGR3);
 
+#ifdef CONFIG_MXC_USE_EPIT
+	epit_timer_init(&epit1_clk,
+			MX35_IO_ADDRESS(MX35_EPIT1_BASE_ADDR), MX35_INT_EPIT1);
+#else
 	mxc_timer_init(&gpt_clk,
 			MX35_IO_ADDRESS(MX35_GPT1_BASE_ADDR), MX35_INT_GPT);
+#endif
 
 	return 0;
 }
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 2941472..7a1e1f8 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -32,6 +32,7 @@ extern void mx31_init_irq(void);
 extern void mx35_init_irq(void);
 extern void mx51_init_irq(void);
 extern void mxc91231_init_irq(void);
+extern void epit_timer_init(struct clk *timer_clk, void __iomem *base, int irq);
 extern void mxc_timer_init(struct clk *timer_clk, void __iomem *, int);
 extern int mx1_clocks_init(unsigned long fref);
 extern int mx21_clocks_init(unsigned long lref, unsigned long fref);
-- 
1.7.1
