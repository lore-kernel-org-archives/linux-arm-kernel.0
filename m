From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri,  1 Oct 2010 17:25:25 +0530
Subject: [PATCH V2 05/69] ST SPEAr: Formalized timer support
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Message-ID: <d0e17aa16067ceb1385c0442d56fdfb48016cd4e.1285933331.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

Arch specific timer initialization code is moved into Arch specific file.

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/include/mach/generic.h |    3 +-
 arch/arm/mach-spear3xx/spear300_evb.c         |    2 +-
 arch/arm/mach-spear3xx/spear310_evb.c         |    2 +-
 arch/arm/mach-spear3xx/spear320_evb.c         |    2 +-
 arch/arm/mach-spear3xx/spear3xx.c             |   32 ++++++++++++++++++++++++-
 arch/arm/mach-spear6xx/include/mach/generic.h |    3 +-
 arch/arm/mach-spear6xx/spear600_evb.c         |    3 +-
 arch/arm/mach-spear6xx/spear6xx.c             |   31 ++++++++++++++++++++++++
 arch/arm/plat-spear/time.c                    |   21 ++++++----------
 9 files changed, 79 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index c16d2f8..e7d2de8 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -33,10 +33,11 @@
 /* Add spear3xx family device structure declarations here */
 extern struct amba_device gpio_device;
 extern struct amba_device uart_device;
-extern struct sys_timer spear_sys_timer;
+extern struct sys_timer spear3xx_timer;
 
 /* Add spear3xx family function declarations here */
 void __init clk_init(void);
+void __init spear_setup_timer(void);
 void __init spear3xx_map_io(void);
 void __init spear3xx_init_irq(void);
 void __init spear3xx_init(void);
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index 2c90663..cd23c98 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -71,6 +71,6 @@ MACHINE_START(SPEAR300, "ST-SPEAR300-EVB")
 	.boot_params	=	0x00000100,
 	.map_io		=	spear3xx_map_io,
 	.init_irq	=	spear3xx_init_irq,
-	.timer		=	&spear_sys_timer,
+	.timer		=	&spear3xx_timer,
 	.init_machine	=	spear300_evb_init,
 MACHINE_END
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index 4e55e55..3855431 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -78,6 +78,6 @@ MACHINE_START(SPEAR310, "ST-SPEAR310-EVB")
 	.boot_params	=	0x00000100,
 	.map_io		=	spear3xx_map_io,
 	.init_irq	=	spear3xx_init_irq,
-	.timer		=	&spear_sys_timer,
+	.timer		=	&spear3xx_timer,
 	.init_machine	=	spear310_evb_init,
 MACHINE_END
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 7083a06..4a7ce35 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -75,6 +75,6 @@ MACHINE_START(SPEAR320, "ST-SPEAR320-EVB")
 	.boot_params	=	0x00000100,
 	.map_io		=	spear3xx_map_io,
 	.init_irq	=	spear3xx_init_irq,
-	.timer		=	&spear_sys_timer,
+	.timer		=	&spear3xx_timer,
 	.init_machine	=	spear320_evb_init,
 MACHINE_END
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index efd2e17..34de574 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -523,5 +523,35 @@ struct pmx_dev pmx_plgpio_45_46_49_50 = {
 	.mode_count = ARRAY_SIZE(pmx_plgpio_45_46_49_50_modes),
 	.enb_on_reset = 1,
 };
+#endif /* CONFIG_MACH_SPEAR310 || CONFIG_MACH_SPEAR320 */
 
-#endif
+static void __init spear3xx_timer_init(void)
+{
+	char pclk_name[] = "pll3_48m_clk";
+	struct clk *gpt_clk, *pclk;
+
+	/* get the system timer clock */
+	gpt_clk = clk_get_sys("gpt0", NULL);
+	if (!gpt_clk) {
+		pr_err("%s:couldn't get clk for gpt\n", __func__);
+		BUG();
+	}
+
+	/* get the suitable parent clock for timer*/
+	pclk = clk_get(NULL, pclk_name);
+	if (!pclk) {
+		pr_err("%s:couldn't get %s as parent for gpt\n",
+				__func__, pclk_name);
+		BUG();
+	}
+
+	clk_set_parent(gpt_clk, pclk);
+	clk_put(gpt_clk);
+	clk_put(pclk);
+
+	spear_setup_timer();
+}
+
+struct sys_timer spear3xx_timer = {
+	.init = spear3xx_timer_init,
+};
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index 16205a5..e5967ed 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -31,9 +31,10 @@
 /* Add spear6xx family device structure declarations here */
 extern struct amba_device gpio_device[];
 extern struct amba_device uart_device[];
-extern struct sys_timer spear_sys_timer;
+extern struct sys_timer spear6xx_timer;
 
 /* Add spear6xx family function declarations here */
+void __init spear_setup_timer(void);
 void __init spear6xx_map_io(void);
 void __init spear6xx_init_irq(void);
 void __init spear6xx_init(void);
diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
index daff8d0..bdd5b76 100644
--- a/arch/arm/mach-spear6xx/spear600_evb.c
+++ b/arch/arm/mach-spear6xx/spear600_evb.c
@@ -42,10 +42,11 @@ static void __init spear600_evb_init(void)
 		amba_device_register(amba_devs[i], &iomem_resource);
 }
 
+
 MACHINE_START(SPEAR600, "ST-SPEAR600-EVB")
 	.boot_params	=	0x00000100,
 	.map_io		=	spear6xx_map_io,
 	.init_irq	=	spear6xx_init_irq,
-	.timer		=	&spear_sys_timer,
+	.timer		=	&spear6xx_timer,
 	.init_machine	=	spear600_evb_init,
 MACHINE_END
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index baf6bcc..e0bf51e 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -155,3 +155,34 @@ void __init spear6xx_map_io(void)
 	/* This will initialize clock framework */
 	clk_init();
 }
+
+static void __init spear6xx_timer_init(void)
+{
+	char pclk_name[] = "pll3_48m_clk";
+	struct clk *gpt_clk, *pclk;
+
+	/* get the system timer clock */
+	gpt_clk = clk_get_sys("gpt0", NULL);
+	if (!gpt_clk) {
+		pr_err("%s:couldn't get clk for gpt\n", __func__);
+		BUG();
+	}
+
+	/* get the suitable parent clock for timer*/
+	pclk = clk_get(NULL, pclk_name);
+	if (!pclk) {
+		pr_err("%s:couldn't get %s as parent for gpt\n",
+				__func__, pclk_name);
+		BUG();
+	}
+
+	clk_set_parent(gpt_clk, pclk);
+	clk_put(gpt_clk);
+	clk_put(pclk);
+
+	spear_setup_timer();
+}
+
+struct sys_timer spear6xx_timer = {
+	.init = spear6xx_timer_init,
+};
diff --git a/arch/arm/plat-spear/time.c b/arch/arm/plat-spear/time.c
index ab21165..7a038c9 100644
--- a/arch/arm/plat-spear/time.c
+++ b/arch/arm/plat-spear/time.c
@@ -1,7 +1,7 @@
 /*
  * arch/arm/plat-spear/time.c
  *
- * Copyright (C) 2009 ST Microelectronics
+ * Copyright (C) 2010 ST Microelectronics
  * Shiraz Hashim<shiraz.hashim@st.com>
  *
  * This file is licensed under the terms of the GNU General Public
@@ -215,7 +215,7 @@ static void __init spear_clockevent_init(void)
 
 void __init spear_setup_timer(void)
 {
-	struct clk *pll3_clk;
+	int ret;
 
 	if (!request_mem_region(SPEAR_GPT0_BASE, SZ_1K, "gpt0")) {
 		pr_err("%s:cannot get IO addr\n", __func__);
@@ -234,26 +234,21 @@ void __init spear_setup_timer(void)
 		goto err_iomap;
 	}
 
-	pll3_clk = clk_get(NULL, "pll3_48m_clk");
-	if (!pll3_clk) {
-		pr_err("%s:couldn't get PLL3 as parent for gpt\n", __func__);
-		goto err_iomap;
+	ret = clk_enable(gpt_clk);
+	if (ret < 0) {
+		pr_err("%s:couldn't enable gpt clock\n", __func__);
+		goto err_clk;
 	}
 
-	clk_set_parent(gpt_clk, pll3_clk);
-
 	spear_clockevent_init();
 	spear_clocksource_init();
 
 	return;
 
+err_clk:
+	clk_put(gpt_clk);
 err_iomap:
 	iounmap(gpt_base);
-
 err_mem:
 	release_mem_region(SPEAR_GPT0_BASE, SZ_1K);
 }
-
-struct sys_timer spear_sys_timer = {
-	.init = spear_setup_timer,
-};
-- 
1.7.2.2
