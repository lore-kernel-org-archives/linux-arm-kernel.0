From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 22 May 2015 23:29:51 +0800
Subject: [PATCH v2 04/12] ARM: imx: initialize gpt device type for DT boot
In-Reply-To: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
References: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1432308599-28643-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use different initialization function in CLOCKSOURCE_OF_DECLARE() to
initialize gpt device type for DT boot.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/time.c | 44 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index 307cbc7abc8e..cf88355654dd 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -376,7 +376,7 @@ void __init mxc_timer_init(unsigned long pbase, int irq, enum imx_gpt_type type)
 	_mxc_timer_init(imxtm);
 }
 
-static void __init mxc_timer_init_dt(struct device_node *np)
+static void __init mxc_timer_init_dt(struct device_node *np,  enum imx_gpt_type type)
 {
 	struct imx_timer *imxtm;
 	static int initialized;
@@ -399,15 +399,41 @@ static void __init mxc_timer_init_dt(struct device_node *np)
 	if (IS_ERR(imxtm->clk_per))
 		imxtm->clk_per = of_clk_get_by_name(np, "per");
 
+	imxtm->type = type;
+
 	_mxc_timer_init(imxtm);
 
 	initialized = 1;
 }
-CLOCKSOURCE_OF_DECLARE(mx1_timer, "fsl,imx1-gpt", mxc_timer_init_dt);
-CLOCKSOURCE_OF_DECLARE(mx25_timer, "fsl,imx25-gpt", mxc_timer_init_dt);
-CLOCKSOURCE_OF_DECLARE(mx50_timer, "fsl,imx50-gpt", mxc_timer_init_dt);
-CLOCKSOURCE_OF_DECLARE(mx51_timer, "fsl,imx51-gpt", mxc_timer_init_dt);
-CLOCKSOURCE_OF_DECLARE(mx53_timer, "fsl,imx53-gpt", mxc_timer_init_dt);
-CLOCKSOURCE_OF_DECLARE(mx6q_timer, "fsl,imx6q-gpt", mxc_timer_init_dt);
-CLOCKSOURCE_OF_DECLARE(mx6sl_timer, "fsl,imx6sl-gpt", mxc_timer_init_dt);
-CLOCKSOURCE_OF_DECLARE(mx6sx_timer, "fsl,imx6sx-gpt", mxc_timer_init_dt);
+
+static void __init imx1_timer_init_dt(struct device_node *np)
+{
+	mxc_timer_init_dt(np, GPT_TYPE_IMX1);
+}
+
+static void __init imx21_timer_init_dt(struct device_node *np)
+{
+	mxc_timer_init_dt(np, GPT_TYPE_IMX21);
+}
+
+static void __init imx31_timer_init_dt(struct device_node *np)
+{
+	mxc_timer_init_dt(np, GPT_TYPE_IMX31);
+}
+
+static void __init imx6dl_timer_init_dt(struct device_node *np)
+{
+	mxc_timer_init_dt(np, GPT_TYPE_IMX6DL);
+}
+
+CLOCKSOURCE_OF_DECLARE(imx1_timer, "fsl,imx1-gpt", imx1_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx21_timer, "fsl,imx21-gpt", imx21_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx31_timer, "fsl,imx31-gpt", imx31_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx25_timer, "fsl,imx25-gpt", imx31_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx50_timer, "fsl,imx50-gpt", imx31_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx51_timer, "fsl,imx51-gpt", imx31_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx53_timer, "fsl,imx53-gpt", imx31_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx6q_timer, "fsl,imx6q-gpt", imx31_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx6dl_timer, "fsl,imx6dl-gpt", imx6dl_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx6sl_timer, "fsl,imx6sl-gpt", imx6dl_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(imx6sx_timer, "fsl,imx6sx-gpt", imx6dl_timer_init_dt);
-- 
1.9.1
