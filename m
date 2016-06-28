From: guodong.xu@linaro.org (Guodong Xu)
Date: Tue, 28 Jun 2016 18:31:42 +0800
Subject: [PATCH 2/2] clk: hi6220: initialize UART1 clock to 150MHz
In-Reply-To: <1467109902-17625-1-git-send-email-guodong.xu@linaro.org>
References: <1467109902-17625-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1467109902-17625-2-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Early at boot, during the sys_clk initialization, make sure UART1 uses
the higher frequency clock.

This enables support for higher baud rates (up to 3Mbps) required to
support faster bluetooth transfers.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 drivers/clk/hisilicon/clk-hi6220.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/clk-hi6220.c
index a36ffcb..55bd9bb 100644
--- a/drivers/clk/hisilicon/clk-hi6220.c
+++ b/drivers/clk/hisilicon/clk-hi6220.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/io.h>
@@ -70,10 +71,10 @@ static struct hisi_gate_clock hi6220_separated_gate_clks_ao[] __initdata = {
 	{ HI6220_UART0_PCLK,  "uart0_pclk",  "clk_tcxo", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 24, 0, },
 };
 
+static struct hisi_clock_data *clk_data_ao;
+
 static void __init hi6220_clk_ao_init(struct device_node *np)
 {
-	struct hisi_clock_data *clk_data_ao;
-
 	clk_data_ao = hisi_clk_init(np, HI6220_AO_NR_CLKS);
 	if (!clk_data_ao)
 		return;
@@ -192,6 +193,13 @@ static void __init hi6220_clk_sys_init(struct device_node *np)
 
 	hi6220_clk_register_divider(hi6220_div_clks_sys,
 			ARRAY_SIZE(hi6220_div_clks_sys), clk_data);
+
+	if (!clk_data_ao)
+		return;
+
+	/* enable high speed clock on UART1 mux */
+	clk_set_parent(clk_data->clk_data.clks[HI6220_UART1_SRC],
+			clk_data_ao->clk_data.clks[HI6220_150M]);
 }
 CLK_OF_DECLARE(hi6220_clk_sys, "hisilicon,hi6220-sysctrl", hi6220_clk_sys_init);
 
-- 
1.9.1
