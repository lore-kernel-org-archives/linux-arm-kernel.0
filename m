From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 9 May 2012 19:33:06 +0800
Subject: [PATCH V2 07/11] ARM: imx6q_sabrelite: clk_register_clkdev cko1 for
 sgtl5000
In-Reply-To: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1336563190-19974-8-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/mach-imx/clk-imx6q.c  |    3 +++
 arch/arm/mach-imx/mach-imx6q.c |   28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 92550c5..096fcfb 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -420,6 +420,9 @@ int __init mx6q_clocks_init(void)
 	clk_register_clkdev(clk[dummy], NULL, "20bc000.wdog");
 	clk_register_clkdev(clk[dummy], NULL, "20c0000.wdog");
 	clk_register_clkdev(clk[ssi1_ipg], NULL, "2028000.ssi");
+	clk_register_clkdev(clk[cko1_sel], "cko1_sel", NULL);
+	clk_register_clkdev(clk[ahb], "ahb", NULL);
+	clk_register_clkdev(clk[cko1], "cko1", NULL);
 
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++) {
 		c = clk_get_sys(clks_init_on[i], NULL);
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 74e44d3..494c365 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -10,6 +10,8 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <linux/clk.h>
+#include <linux/clkdev.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -76,10 +78,36 @@ static int ksz9021rn_phy_fixup(struct phy_device *phydev)
 	return 0;
 }
 
+static void __init imx6q_sabrelite_cko1_setup(void)
+{
+	struct clk *cko1_sel, *ahb, *cko1;
+	unsigned long rate;
+
+	cko1_sel = clk_get_sys(NULL, "cko1_sel");
+	ahb = clk_get_sys(NULL, "ahb");
+	cko1 = clk_get_sys(NULL, "cko1");
+	if (IS_ERR(cko1_sel) || IS_ERR(ahb) || IS_ERR(cko1)) {
+		pr_err("cko1 setup failed!\n");
+		goto put_clk;
+	}
+	clk_set_parent(cko1_sel, ahb);
+	rate = clk_round_rate(cko1, 16000000);
+	clk_set_rate(cko1, rate);
+	clk_register_clkdev(cko1, NULL, "0-000a");
+put_clk:
+	if (!IS_ERR(cko1_sel))
+		clk_put(cko1_sel);
+	if (!IS_ERR(ahb))
+		clk_put(ahb);
+	if (!IS_ERR(cko1))
+		clk_put(cko1);
+}
+
 static void __init imx6q_sabrelite_init(void)
 {
 	phy_register_fixup_for_uid(PHY_ID_KSZ9021, MICREL_PHY_ID_MASK,
 				ksz9021rn_phy_fixup);
+	imx6q_sabrelite_cko1_setup();
 }
 
 static void __init imx6q_init_machine(void)
-- 
1.7.5.4
