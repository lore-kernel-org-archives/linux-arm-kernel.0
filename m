From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Jun 2013 12:07:46 +0100
Subject: [PATCH 18/33 v2] clk: ux500: Add a 2-cell Device Tree parser for
 obtaining PRCC clocks
In-Reply-To: <1370521041-32318-19-git-send-email-lee.jones@linaro.org>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
 <1370521041-32318-19-git-send-email-lee.jones@linaro.org>
Message-ID: <20130611110745.GA3330@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PRCC (peripheral and kernel) clocks are specified using a property tuple
<&phandle base bit>, where 'base' is the peripheral (1, 2, 3, 5 or 6),
and bit is read-in value into that peripheral stipulated by the hardware
specification.
    
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>

diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
index ef948ff..c2d9a1c 100644
--- a/drivers/clk/ux500/u8500_clk.c
+++ b/drivers/clk/ux500/u8500_clk.c
@@ -15,6 +15,28 @@
 #include <linux/platform_data/clk-ux500.h>
 #include "clk.h"
 
+#define PRCC_SHOW(clk, base, bit) \
+	clk[(base * PRCC_PERIPHS_PER_CLUSTER) + bit]
+
+struct clk *ux500_twocell_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct clk **clk_data = data;
+	unsigned int base, bit;
+
+	if (clkspec->args_count != 2)
+		return  ERR_PTR(-EINVAL);
+
+	base = clkspec->args[0];
+	bit = clkspec->args[1];
+
+	if (base != 1 && base != 2 && base != 3 && base != 5 && base != 6) {
+		pr_err("%s: invalid PRCC base %d\n", __func__, base);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return PRCC_SHOW(clk_data, base, bit);
+}
+
 const static struct of_device_id u8500_clk_of_match[] = {
        { .compatible = "stericsson,u8500-clks", },
        { },
