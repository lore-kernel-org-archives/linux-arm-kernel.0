From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Wed, 22 Mar 2017 18:53:05 +0200
Subject: [RFC 3/8] cpufreq: imx6q: Set max suspend_freq to avoid changes
 during suspend
In-Reply-To: <cover.1490199005.git.leonard.crestez@nxp.com>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
Message-ID: <f2126423e233757eb113f115e0be562ea0902a7a.1490199005.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the cpufreq driver tries to modify voltage/freq during suspend/resume
it might need to control an external PMIC via I2C or SPI but those
devices might be already suspended.

To avoid this scenario we just increase cpufreq to highest setpoint
before suspend. This issue can easily be triggered by ldo-bypass but in
theory any regulator set_voltage call can end up having to modify
external supply voltages.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index be90ee3..e2c1fbf 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -162,6 +162,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 {
 	policy->clk = arm_clk;
+	policy->suspend_freq = freq_table[soc_opp_count - 1].frequency;
 	return cpufreq_generic_init(policy, freq_table, transition_latency);
 }
 
@@ -173,6 +174,7 @@ static struct cpufreq_driver imx6q_cpufreq_driver = {
 	.init = imx6q_cpufreq_init,
 	.name = "imx6q-cpufreq",
 	.attr = cpufreq_generic_attr,
+	.suspend = cpufreq_generic_suspend,
 };
 
 static int imx6q_cpufreq_probe(struct platform_device *pdev)
-- 
2.7.4
