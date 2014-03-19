From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 19 Mar 2014 12:42:13 -0700
Subject: [PATCH 1/4] clk: sunxi: fix A20 PLL4 calculation
In-Reply-To: <1395253173-30437-2-git-send-email-emilio@elopez.com.ar>
References: <1395253173-30437-1-git-send-email-emilio@elopez.com.ar>
 <1395253173-30437-2-git-send-email-emilio@elopez.com.ar>
Message-ID: <20140319194213.30995.52897@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Emilio L?pez (2014-03-19 11:19:30)
> Allwinner actually reworked the PLL4 on A20; now it's compatible with
> the sun4i PLL5/6 design previous to any divisions, as well as to the new
> PLL8 in sun7i.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

Trivial merge conflict after applying this patch on top of your 3.15
pull request. My resolution is below. Let me know if I've made a
mistake.

Regards,
Mike



>From 5a8ddf26822dcf601a44d35efa8fe162cbc84e62 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>
Date: Wed, 19 Mar 2014 15:19:30 -0300
Subject: [PATCH] clk: sunxi: fix A20 PLL4 calculation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Allwinner actually reworked the PLL4 on A20; now it's compatible with
the sun4i PLL5/6 design previous to any divisions, as well as to the new
PLL8 in sun7i.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 23baad9..ef6ad52b 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -589,6 +589,12 @@ static const struct factors_data sun6i_a31_pll1_data __initconst = {
 	.getter = sun6i_a31_get_pll1_factors,
 };
 
+static const struct factors_data sun7i_a20_pll4_data __initconst = {
+	.enable = 31,
+	.table = &sun4i_pll5_config,
+	.getter = sun4i_get_pll5_factors,
+};
+
 static const struct factors_data sun4i_pll5_data __initconst = {
 	.enable = 31,
 	.table = &sun4i_pll5_config,
@@ -1209,6 +1215,7 @@ free_clkdata:
 static const struct of_device_id clk_factors_match[] __initconst = {
 	{.compatible = "allwinner,sun4i-a10-pll1-clk", .data = &sun4i_pll1_data,},
 	{.compatible = "allwinner,sun6i-a31-pll1-clk", .data = &sun6i_a31_pll1_data,},
+	{.compatible = "allwinner,sun7i-a20-pll4-clk", .data = &sun7i_a20_pll4_data,},
 	{.compatible = "allwinner,sun6i-a31-pll6-clk", .data = &sun6i_a31_pll6_data,},
 	{.compatible = "allwinner,sun4i-a10-apb1-clk", .data = &sun4i_apb1_data,},
 	{.compatible = "allwinner,sun4i-a10-mod0-clk", .data = &sun4i_mod0_data,},
-- 
1.8.3.2
