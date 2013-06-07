From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  7 Jun 2013 19:07:50 -0300
Subject: [PATCH] ARM: mach-imx6q: Enable the codec clock earlier
Message-ID: <1370642870-8051-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

In order sgtl5000 driver to probe successfully, we need to read its ID via I2C 
,which requires that MCLK is driven prior to the I2C access.

Otherwise we get the following probe error:

sgtl5000: probe of 0-000a failed with error -5
imx-sgtl5000 sound.13: ASoC: CODEC (null) not registered
imx-sgtl5000 sound.13: snd_soc_register_card failed (-517)
platform sound.13: Driver imx-sgtl5000 requests probe deferral

Turn on MCLK sooner so that the probe can succeed.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
This issue is seen on linux-next tree

 arch/arm/mach-imx/mach-imx6q.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 045e5e3..034f4d2 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -118,6 +118,7 @@ static void __init imx6q_sabrelite_cko1_setup(void)
 {
 	struct clk *cko1_sel, *ahb, *cko1;
 	unsigned long rate;
+	int ret;
 
 	cko1_sel = clk_get_sys(NULL, "cko1_sel");
 	ahb = clk_get_sys(NULL, "ahb");
@@ -129,6 +130,9 @@ static void __init imx6q_sabrelite_cko1_setup(void)
 	clk_set_parent(cko1_sel, ahb);
 	rate = clk_round_rate(cko1, 16000000);
 	clk_set_rate(cko1, rate);
+	ret = clk_prepare_enable(cko1);
+	if (ret)
+		pr_err("enabling clko1 failed: %d", ret);
 put_clk:
 	if (!IS_ERR(cko1_sel))
 		clk_put(cko1_sel);
-- 
1.8.1.2
