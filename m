From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 25 Jan 2017 11:53:06 +0100
Subject: [PATCH] clk: meson8b: fix clk81 register address
Message-ID: <1485341586-2929-1-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During meson8b clock probe, clk81 register address is fixed twice.
First using the meson8b_clk_gates array, then by directly changing
meson8b_clk81 register.

As a result meson8b_clk81.reg = HHI_MPEG_CLK_CNTL + clk_base + clk_base.

Fixed by just removing the second fixup.

Fixes: e31a1900c1ff ("meson: clk: Add support for clock gates")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Patch based on khilman/linux-amlogic.git master branch.

 I don't have a meson8b HW so this patch so this patch has not been
 tested on real HW.

 drivers/clk/meson/meson8b.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 3f1be46cbb33..888494d4fb8a 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -607,7 +607,6 @@ static int meson8b_clkc_probe(struct platform_device *pdev)
 	/* Populate the base address for the MPEG clks */
 	meson8b_mpeg_clk_sel.reg = clk_base + (u32)meson8b_mpeg_clk_sel.reg;
 	meson8b_mpeg_clk_div.reg = clk_base + (u32)meson8b_mpeg_clk_div.reg;
-	meson8b_clk81.reg = clk_base + (u32)meson8b_clk81.reg;
 
 	/* Populate base address for gates */
 	for (i = 0; i < ARRAY_SIZE(meson8b_clk_gates); i++)
-- 
2.7.4
