From: shawnguo@kernel.org (shawnguo at kernel.org)
Date: Fri, 15 May 2015 16:11:41 +0800
Subject: [PATCH 3/9] ARM: imx: initialize gpt device type for DT boot
In-Reply-To: <1431677507-27420-1-git-send-email-shawnguo@kernel.org>
References: <1431677507-27420-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1431677507-27420-4-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

Use different initialization function in CLOCKSOURCE_OF_DECLARE() to
initialize gpt device type for DT boot.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/time.c | 44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index 5241a173fd60..ed01813cfc76 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -385,11 +385,39 @@ static void __init mxc_timer_init_dt(struct device_node *np)
 
 	_mxc_timer_init();
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
+	imxtm.type = GPT_TYPE_IMX1;
+	mxc_timer_init_dt(np);
+}
+
+static void __init imx21_timer_init_dt(struct device_node *np)
+{
+	imxtm.type = GPT_TYPE_IMX21;
+	mxc_timer_init_dt(np);
+}
+
+static void __init imx31_timer_init_dt(struct device_node *np)
+{
+	imxtm.type = GPT_TYPE_IMX31;
+	mxc_timer_init_dt(np);
+}
+
+static void __init imx6dl_timer_init_dt(struct device_node *np)
+{
+	imxtm.type = GPT_TYPE_IMX6DL;
+	mxc_timer_init_dt(np);
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
