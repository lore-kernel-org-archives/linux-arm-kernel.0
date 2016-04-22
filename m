From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 22 Apr 2016 17:17:06 -0500
Subject: [PATCH 2/8] firmware: qcom: scm: Convert SCM to platform driver
In-Reply-To: <1461363432-5730-1-git-send-email-andy.gross@linaro.org>
References: <1461363432-5730-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1461363432-5730-3-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch converts the Qualcomm SCM firmware driver into a platform
driver.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm64/Kconfig.platforms |   1 +
 drivers/firmware/qcom_scm.c  | 154 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 147 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index efa77c1..6f0876f 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -76,6 +76,7 @@ config ARCH_MVEBU
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select PINCTRL
+	select QCOM_SCM
 	help
 	  This enables support for the ARMv8 based Qualcomm chipsets.
 
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 45c008d..8e1eeb8 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -10,19 +10,68 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
  */
-
+#include <linux/platform_device.h>
+#include <linux/module.h>
 #include <linux/cpumask.h>
 #include <linux/export.h>
 #include <linux/types.h>
 #include <linux/qcom_scm.h>
+#include <linux/of.h>
+#include <linux/clk.h>
 
 #include "qcom_scm.h"
 
+struct qcom_scm {
+	struct device *dev;
+	struct clk *core_clk;
+	struct clk *iface_clk;
+	struct clk *bus_clk;
+};
+
+static struct qcom_scm *__scm;
+
+static int qcom_scm_clk_enable(void)
+{
+	int ret;
+
+	ret = clk_prepare_enable(__scm->core_clk);
+	if (ret)
+		goto bail;
+
+	if (__scm->iface_clk) {
+		ret = clk_prepare_enable(__scm->iface_clk);
+		if (ret)
+			goto disable_core;
+	}
+
+	if (__scm->bus_clk) {
+		ret = clk_prepare_enable(__scm->bus_clk);
+		if (ret)
+			goto disable_iface;
+	}
+
+	return 0;
+
+disable_iface:
+	if (__scm->iface_clk)
+		clk_disable_unprepare(__scm->iface_clk);
+disable_core:
+	if (__scm->bus_clk)
+		clk_disable_unprepare(__scm->core_clk);
+bail:
+	return ret;
+}
+
+static void qcom_scm_clk_disable(void)
+{
+	clk_disable_unprepare(__scm->core_clk);
+	if (__scm->iface_clk)
+		clk_disable_unprepare(__scm->iface_clk);
+	if (__scm->bus_clk)
+		clk_disable_unprepare(__scm->bus_clk);
+}
+
 /**
  * qcom_scm_set_cold_boot_addr() - Set the cold boot address for cpus
  * @entry: Entry point function for the cpus
@@ -72,11 +121,17 @@ EXPORT_SYMBOL(qcom_scm_cpu_power_down);
  */
 bool qcom_scm_hdcp_available(void)
 {
-	int ret;
+	int ret = qcom_scm_clk_enable();
+
+	if (ret)
+		goto clk_err;
 
 	ret = __qcom_scm_is_call_available(QCOM_SCM_SVC_HDCP,
-		QCOM_SCM_CMD_HDCP);
+						QCOM_SCM_CMD_HDCP);
+
+	qcom_scm_clk_disable();
 
+clk_err:
 	return (ret > 0) ? true : false;
 }
 EXPORT_SYMBOL(qcom_scm_hdcp_available);
@@ -91,6 +146,89 @@ EXPORT_SYMBOL(qcom_scm_hdcp_available);
  */
 int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp)
 {
-	return __qcom_scm_hdcp_req(req, req_cnt, resp);
+	int ret = qcom_scm_clk_enable();
+
+	if (ret)
+		return ret;
+
+	ret = __qcom_scm_hdcp_req(req, req_cnt, resp);
+	qcom_scm_clk_disable();
+	return ret;
 }
 EXPORT_SYMBOL(qcom_scm_hdcp_req);
+
+/**
+ * qcom_scm_is_available() - Checks if SCM is available
+ */
+bool qcom_scm_is_available(void)
+{
+	return !!__scm;
+}
+EXPORT_SYMBOL(qcom_scm_is_available);
+
+static int qcom_scm_probe(struct platform_device *pdev)
+{
+	struct qcom_scm *scm;
+	long rate;
+	int ret;
+
+	scm = devm_kzalloc(&pdev->dev, sizeof(*scm), GFP_KERNEL);
+	if (!scm)
+		return -ENOMEM;
+
+	scm->core_clk = devm_clk_get(&pdev->dev, "core");
+	if (IS_ERR(scm->core_clk)) {
+		if (PTR_ERR(scm->core_clk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to acquire core clk\n");
+		return PTR_ERR(scm->core_clk);
+	}
+
+	if (of_device_is_compatible(pdev->dev.of_node, "qcom,scm-apq8064")) {
+		scm->iface_clk = devm_clk_get(&pdev->dev, "iface");
+		if (IS_ERR(scm->iface_clk)) {
+			if (PTR_ERR(scm->iface_clk) != -EPROBE_DEFER)
+				dev_err(&pdev->dev, "failed to acquire iface clk\n");
+			return PTR_ERR(scm->iface_clk);
+		}
+
+		scm->bus_clk = devm_clk_get(&pdev->dev, "bus");
+		if (IS_ERR(scm->bus_clk)) {
+			if (PTR_ERR(scm->bus_clk) != -EPROBE_DEFER)
+				dev_err(&pdev->dev, "failed to acquire bus clk\n");
+			return PTR_ERR(scm->bus_clk);
+		}
+	}
+
+	/* vote for max clk rate for highest performance */
+	rate = clk_round_rate(scm->core_clk, INT_MAX);
+	ret = clk_set_rate(scm->core_clk, rate);
+	if (ret)
+		return ret;
+
+	__scm = scm;
+	__scm->dev = &pdev->dev;
+
+	return 0;
+}
+
+static const struct of_device_id qcom_scm_dt_match[] = {
+	{ .compatible = "qcom,scm-apq8064",},
+	{ .compatible = "qcom,scm-apq8084",},
+	{ .compatible = "qcom,scm-msm8916",},
+	{ .compatible = "qcom,scm-msm8974",},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, qcom_scm_dt_match);
+
+static struct platform_driver qcom_scm_driver = {
+	.driver = {
+		.name	= "qcom_scm",
+		.of_match_table = qcom_scm_dt_match,
+	},
+	.probe = qcom_scm_probe,
+};
+
+builtin_platform_driver(qcom_scm_driver);
+MODULE_DESCRIPTION("Qualcomm SCM driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
