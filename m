From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 12 May 2016 22:46:55 -0500
Subject: [Patch v5 2/8] firmware: qcom: scm: Convert SCM to platform driver
In-Reply-To: <1463111221-6963-1-git-send-email-andy.gross@linaro.org>
References: <1463111221-6963-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1463111221-6963-3-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch converts the Qualcomm SCM firmware driver into a platform
driver.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 drivers/firmware/qcom_scm.c | 165 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 156 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 45c008d..4d6ae32 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -10,19 +10,61 @@
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
+#include <linux/of_platform.h>
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
+	ret = clk_prepare_enable(__scm->iface_clk);
+	if (ret)
+		goto disable_core;
+
+	ret = clk_prepare_enable(__scm->bus_clk);
+	if (ret)
+		goto disable_iface;
+
+	return 0;
+
+disable_iface:
+	clk_disable_unprepare(__scm->iface_clk);
+disable_core:
+	clk_disable_unprepare(__scm->core_clk);
+bail:
+	return ret;
+}
+
+static void qcom_scm_clk_disable(void)
+{
+	clk_disable_unprepare(__scm->core_clk);
+	clk_disable_unprepare(__scm->iface_clk);
+	clk_disable_unprepare(__scm->bus_clk);
+}
+
 /**
  * qcom_scm_set_cold_boot_addr() - Set the cold boot address for cpus
  * @entry: Entry point function for the cpus
@@ -72,12 +114,17 @@ EXPORT_SYMBOL(qcom_scm_cpu_power_down);
  */
 bool qcom_scm_hdcp_available(void)
 {
-	int ret;
+	int ret = qcom_scm_clk_enable();
+
+	if (ret)
+		return ret;
 
 	ret = __qcom_scm_is_call_available(QCOM_SCM_SVC_HDCP,
-		QCOM_SCM_CMD_HDCP);
+						QCOM_SCM_CMD_HDCP);
+
+	qcom_scm_clk_disable();
 
-	return (ret > 0) ? true : false;
+	return ret > 0 ? true : false;
 }
 EXPORT_SYMBOL(qcom_scm_hdcp_available);
 
@@ -91,6 +138,106 @@ EXPORT_SYMBOL(qcom_scm_hdcp_available);
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
+static int qcom_scm_probe(struct platform_device *pdev)
+{
+	struct qcom_scm *scm;
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
+	if (of_device_is_compatible(pdev->dev.of_node, "qcom,scm")) {
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
+	ret = clk_set_rate(scm->core_clk, INT_MAX);
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
+	{ .compatible = "qcom,scm-msm8660",},
+	{ .compatible = "qcom,scm-msm8960",},
+	{ .compatible = "qcom,scm",},
+	{}
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
+static int __init qcom_scm_init(void)
+{
+	struct device_node *np, *parent;
+	int ret;
+
+	np = of_find_matching_node_and_match(NULL, qcom_scm_dt_match, NULL);
+
+	if (!np)
+		return -ENODEV;
+
+	parent = of_get_next_parent(np);
+	ret = of_platform_populate(parent, qcom_scm_dt_match, NULL, NULL);
+
+	of_node_put(parent);
+
+	if (ret)
+		return ret;
+
+	return platform_driver_register(&qcom_scm_driver);
+}
+
+arch_initcall(qcom_scm_init);
+
+static void __exit qcom_scm_exit(void)
+{
+	platform_driver_unregister(&qcom_scm_driver);
+}
+module_exit(qcom_scm_exit);
+
+MODULE_DESCRIPTION("Qualcomm SCM driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
