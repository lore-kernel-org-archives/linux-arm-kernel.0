From: agross@codeaurora.org (Andy Gross)
Date: Wed,  7 Oct 2015 00:42:28 -0500
Subject: [Patch v2] firmware: qcom: scm: Convert to platform driver
Message-ID: <1444196548-1360-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch creates a platform driver for the SCM so that we can adequately
manage resources.  This removes clients having to carry the necessary
clocks to use the SCM resources.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 .../devicetree/bindings/firmware/qcom,scm.txt      |   25 ++++
 drivers/firmware/qcom_scm.c                        |  135 ++++++++++++++++++--
 2 files changed, 152 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.txt

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
new file mode 100644
index 0000000..debcd32
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
@@ -0,0 +1,25 @@
+QCOM Secure Channel Manager (SCM)
+
+Qualcomm processors include an interface to communicate to the secure firmware.
+This interface allows for clients to request different types of actions.  These
+can include CPU power up/down, HDCP requests, loading of firmware, and other
+assorted actions.
+
+Required properties:
+- compatible: must contain "qcom,scm"
+- clocks: Should contain the core, iface, and bus clocks.
+- clock-names: Must contain "core" for the core clock, "iface" for the interface
+  clock and "bus" for the bus clock.
+
+Example:
+
+	firmware {
+		compatible = "simple-bus";
+
+		scm {
+			compatible = "qcom,scm";
+			clocks = <&gcc GCC_CE1_CLK> , <&gcc GCC_CE1_AXI_CLK>, <&gcc GCC_CE1_AHB_CLK>;
+			clock-names = "core", "bus", "iface";
+		};
+	};
+
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 45c008d..7c4ec48 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -10,19 +10,57 @@
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
+	ret = clk_prepare_enable(__scm->iface_clk);
+	if (ret)
+		goto disable_core;
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
@@ -72,11 +110,17 @@ EXPORT_SYMBOL(qcom_scm_cpu_power_down);
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
 
+	qcom_scm_clk_disable();
+
+clk_err:
 	return (ret > 0) ? true : false;
 }
 EXPORT_SYMBOL(qcom_scm_hdcp_available);
@@ -91,6 +135,81 @@ EXPORT_SYMBOL(qcom_scm_hdcp_available);
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
+	scm->iface_clk = devm_clk_get(&pdev->dev, "iface");
+	if (IS_ERR(scm->iface_clk)) {
+		if (PTR_ERR(scm->iface_clk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to acquire iface clk\n");
+		return PTR_ERR(scm->iface_clk);
+	}
+
+	scm->bus_clk = devm_clk_get(&pdev->dev, "bus");
+	if (IS_ERR(scm->bus_clk)) {
+		if (PTR_ERR(scm->bus_clk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to acquire bus clk\n");
+		return PTR_ERR(scm->bus_clk);
+	}
+
+	/* vote for max clk rate for highest performance */
+	rate = clk_round_rate(scm->core_clk, INT_MAX);
+	ret = clk_set_rate(scm->core_clk, rate);
+	if (ret)
+		return ret;
+
+	__scm = scm;
+
+	return 0;
+}
+
+static const struct of_device_id qcom_scm_dt_match[] = {
+	{ .compatible = "qcom,scm",},
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
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
