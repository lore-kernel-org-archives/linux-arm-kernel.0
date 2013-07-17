From: cb@sgoc.de (Christoph G. Baumann)
Date: Wed, 17 Jul 2013 18:27:39 +0200
Subject: [PATCH v2 2/3] mxs: register clkdev "hbus" as it is required by OCOTP
In-Reply-To: <1374078460-4126-1-git-send-email-cb@sgoc.de>
References: <1372855154-8422-1-git-send-email-cb@sgoc.de>
 <1374078460-4126-1-git-send-email-cb@sgoc.de>
Message-ID: <1374078460-4126-3-git-send-email-cb@sgoc.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Christoph G. Baumann" <cb@sgoc.de>

The OCOTP driver needs to switch the HBUS clock when burning OTP bits.
For this purpose it uses the CLK-API and requests a handler for "hbus".
Trying to burn bits without registered "hbus" CLK results in a blocked user
process.

Signed-off-by: "Christoph G. Baumann" <cb@sgoc.de>
---
 drivers/clk/mxs/clk-imx23.c |    2 ++
 drivers/clk/mxs/clk-imx28.c |    1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/clk/mxs/clk-imx23.c b/drivers/clk/mxs/clk-imx23.c
index f6a7487..ec76d00 100644
--- a/drivers/clk/mxs/clk-imx23.c
+++ b/drivers/clk/mxs/clk-imx23.c
@@ -168,6 +168,8 @@ int __init mx23_clocks_init(void)
 	clk_data.clk_num = ARRAY_SIZE(clks);
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
+	clk_register_clkdev(clks[hbus], NULL, "hbus");
+
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
 		clk_prepare_enable(clks[clks_init_on[i]]);
 
diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
index 4faf0af..792fcaf 100644
--- a/drivers/clk/mxs/clk-imx28.c
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -247,6 +247,7 @@ int __init mx28_clocks_init(void)
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
 	clk_register_clkdev(clks[enet_out], NULL, "enet_out");
+	clk_register_clkdev(clks[hbus], NULL, "hbus");
 
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
 		clk_prepare_enable(clks[clks_init_on[i]]);
-- 
1.7.9.5
