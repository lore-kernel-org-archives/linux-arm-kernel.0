From: matti.vaittinen@fi.rohmeurope.com (Matti Vaittinen)
Date: Thu, 1 Nov 2018 09:19:53 +0200
Subject: [PATCH v2 4/8] clk: clk-st: avoid clkdev lookup leak at remove
In-Reply-To: <cover.1541054985.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1541054985.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <37078c99cc7d7de6847a3bbdf0cc67fbd7281efd.1541054985.git.matti.vaittinen@fi.rohmeurope.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm based clkdev lookup registration to avoid leaking lookup
structures.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/x86/clk-st.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c
index fb62f3938008..32d8df9bd853 100644
--- a/drivers/clk/x86/clk-st.c
+++ b/drivers/clk/x86/clk-st.c
@@ -52,7 +52,8 @@ static int st_clk_probe(struct platform_device *pdev)
 		0, st_data->base + MISCCLKCNTL1, OSCCLKENB,
 		CLK_GATE_SET_TO_DISABLE, NULL);
 
-	clk_hw_register_clkdev(hws[ST_CLK_GATE], "oscout1", NULL);
+	devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE], "oscout1",
+				    NULL);
 
 	return 0;
 }
-- 
2.14.3
