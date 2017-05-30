From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 30 May 2017 18:57:18 +0300
Subject: [PATCH] cpufreq: imx6q: imx6ull should use the same flow as imx6ul
Message-ID: <30688f5aa17763362275c199b2d61841497c26a4.1496159470.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Octavian Purdila <octavian.purdila@nxp.com>

This fixes an issue with imx6ull where setting the frequency to 528Mhz
would actually set the ARM clock to 324Mhz.

Signed-off-by: Octavian Purdila <octavian.purdila@nxp.com>
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 9c13f09..b6edd3c 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -101,7 +101,8 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 	 *  - Reprogram pll1_sys_clk and reparent pll1_sw_clk back to it
 	 *  - Disable pll2_pfd2_396m_clk
 	 */
-	if (of_machine_is_compatible("fsl,imx6ul")) {
+	if (of_machine_is_compatible("fsl,imx6ul") ||
+	    of_machine_is_compatible("fsl,imx6ull")) {
 		/*
 		 * When changing pll1_sw_clk's parent to pll1_sys_clk,
 		 * CPU may run at higher than 528MHz, this will lead to
@@ -215,7 +216,8 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 		goto put_clk;
 	}
 
-	if (of_machine_is_compatible("fsl,imx6ul")) {
+	if (of_machine_is_compatible("fsl,imx6ul") ||
+	    of_machine_is_compatible("fsl,imx6ull")) {
 		pll2_bus_clk = clk_get(cpu_dev, "pll2_bus");
 		secondary_sel_clk = clk_get(cpu_dev, "secondary_sel");
 		if (IS_ERR(pll2_bus_clk) || IS_ERR(secondary_sel_clk)) {
-- 
2.7.4
