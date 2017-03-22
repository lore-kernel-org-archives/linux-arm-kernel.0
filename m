From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Wed, 22 Mar 2017 18:53:04 +0200
Subject: [RFC 2/8] cpufreq: imx6q: Fix handling EPROBE_DEFER from regulator
In-Reply-To: <cover.1490199005.git.leonard.crestez@nxp.com>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
Message-ID: <7f2618363d43b30db29f5f8ae822df413392f99d.1490199005.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Irina Tirdea <irina.tirdea@nxp.com>

If there are any errors in getting the cpu0 regulators, the driver returns
-ENOENT. In case the regulators are not yet available, the devm_regulator_get
calls will return -EPROBE_DEFER, so that the driver can be probed later.
If we return -ENOENT, the driver will fail its initialization and will
not try to probe again (when the regulators become available).

Return the actual error received from regulator_get in probe. Print a
differentiated message in case we need to probe the device later and
in case we actually failed. Also add a message to inform when the
driver has been successfully registered.

Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 7719b02..be90ee3 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -222,6 +222,13 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	arm_reg = regulator_get(cpu_dev, "arm");
 	pu_reg = regulator_get_optional(cpu_dev, "pu");
 	soc_reg = regulator_get(cpu_dev, "soc");
+	if (PTR_ERR(arm_reg) == -EPROBE_DEFER ||
+			PTR_ERR(soc_reg) == -EPROBE_DEFER ||
+			PTR_ERR(pu_reg) == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		dev_dbg(cpu_dev, "regulators not ready, defer\n");
+		goto put_reg;
+	}
 	if (IS_ERR(arm_reg) || IS_ERR(soc_reg)) {
 		dev_err(cpu_dev, "failed to get regulators\n");
 		ret = -ENOENT;
-- 
2.7.4
