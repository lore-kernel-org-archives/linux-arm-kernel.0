From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 29 Jun 2016 16:45:55 +0800
Subject: [PATCH v2 2/2] clk: hi6220: initialize UART1 clock to 150MHz
In-Reply-To: <1467189955-21694-1-git-send-email-guodong.xu@linaro.org>
References: <1467189955-21694-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1467189955-21694-2-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Early at boot, during the sys_clk initialization, make sure UART1 uses
the higher frequency clock, 150MHz.

This enables support for higher baud rates (up to 3Mbps) in UART1, which
is required by faster bluetooth transfers.

v2: use clk_set_rate() to propergate clock settings.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 drivers/clk/hisilicon/clk-hi6220.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/clk-hi6220.c
index a36ffcb..631c56f 100644
--- a/drivers/clk/hisilicon/clk-hi6220.c
+++ b/drivers/clk/hisilicon/clk-hi6220.c
@@ -12,6 +12,7 @@
 
 #include <linux/kernel.h>
 #include <linux/clk-provider.h>
+#include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -192,6 +193,9 @@ static void __init hi6220_clk_sys_init(struct device_node *np)
 
 	hi6220_clk_register_divider(hi6220_div_clks_sys,
 			ARRAY_SIZE(hi6220_div_clks_sys), clk_data);
+
+	if (clk_set_rate(clk_data->clk_data.clks[HI6220_UART1_SRC], 150000000))
+		pr_err("failed to set uart1 clock rate\n");
 }
 CLK_OF_DECLARE(hi6220_clk_sys, "hisilicon,hi6220-sysctrl", hi6220_clk_sys_init);
 
-- 
1.9.1
