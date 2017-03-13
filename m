From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 13 Mar 2017 14:26:41 +0100
Subject: [PATCH 2/5] clk: meson-gxbb: Add GP0 PLL init parameters
In-Reply-To: <1489411604-18700-1-git-send-email-narmstrong@baylibre.com>
References: <1489411604-18700-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1489411604-18700-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tha Amlogic GXBB SoC GP0 PLL needs some vendor provided parameters to be
initializated in the the GP0 control registers before configuring the rate
with the rate table provided parameters.

GXBB GP0 PLL tweaks are also selected to respect the vendor init procedure.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/gxbb.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 1c1ec13..5e1a7dc4 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -352,6 +352,13 @@
 	},
 };
 
+struct pll_params_table gxbb_gp0_params_table[] = {
+	PLL_PARAM(HHI_GP0_PLL_CNTL, 0x6a000228),
+	PLL_PARAM(HHI_GP0_PLL_CNTL2, 0x69c80000),
+	PLL_PARAM(HHI_GP0_PLL_CNTL3, 0x0a5590c4),
+	PLL_PARAM(HHI_GP0_PLL_CNTL4, 0x0000500d),
+};
+
 static struct meson_clk_pll gxbb_gp0_pll = {
 	.m = {
 		.reg_off = HHI_GP0_PLL_CNTL,
@@ -368,6 +375,12 @@
 		.shift   = 16,
 		.width   = 2,
 	},
+	.params = {
+		.params_table = gxbb_gp0_params_table,
+		.params_count =	ARRAY_SIZE(gxbb_gp0_params_table),
+		.no_init_reset = true,
+		.unreset_for_lock = true,
+	},
 	.rate_table = gp0_pll_rate_table,
 	.rate_count = ARRAY_SIZE(gp0_pll_rate_table),
 	.lock = &clk_lock,
-- 
1.9.1
