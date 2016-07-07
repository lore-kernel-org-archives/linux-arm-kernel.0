From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu,  7 Jul 2016 15:21:07 -0700
Subject: [PATCH v2 16/22] usb: chipidea: msm: Restore wrapper settings after
 reset
In-Reply-To: <20160707222114.1673-1-stephen.boyd@linaro.org>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
Message-ID: <20160707222114.1673-17-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the RESET bit is set in the USBCMD register it resets quite
a few of the wrapper's registers to their reset state. This
includes the GENCONFIG and GENCONFIG2 registers. Currently this
is done by the usb phy and ehci-msm drivers writing into the
controller wrapper's MMIO address space. Let's consolidate the
register writes into the wrapper driver instead so that we
clearly split the wrapper from the phys.

Cc: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/chipidea/ci_hdrc_msm.c | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index 7708bee3ff3e..81437c8cea82 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -14,11 +14,22 @@
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/io.h>
+#include <linux/extcon.h>
+#include <linux/of.h>
 
 #include "ci.h"
 
 #define HS_PHY_AHB_MODE			0x0098
 
+#define HS_PHY_GENCONFIG		0x009c
+#define HS_PHY_TXFIFO_IDLE_FORCE_DIS	BIT(4)
+
+#define HS_PHY_GENCONFIG_2		0x00a0
+#define HS_PHY_SESS_VLD_CTRL_EN		BIT(7)
+#define HS_PHY_ULPI_TX_PKT_EN_CLR_FIX	BIT(19)
+
+#define HSPHY_SESS_VLD_CTRL		BIT(25)
+
 /* Vendor base starts at 0x200 beyond CI base */
 #define HS_PHY_SEC_CTRL			0x0078
 #define HS_PHY_DIG_CLAMP_N		BIT(16)
@@ -29,6 +40,7 @@ struct ci_hdrc_msm {
 	struct clk *iface_clk;
 	struct clk *fs_clk;
 	bool secondary_phy;
+	bool hsic;
 	void __iomem *base;
 };
 
@@ -48,6 +60,24 @@ static void ci_hdrc_msm_notify_event(struct ci_hdrc *ci, unsigned event)
 
 		/* use AHB transactor, allow posted data writes */
 		hw_write_id_reg(ci, HS_PHY_AHB_MODE, 0xffffffff, 0x8);
+
+		/* workaround for rx buffer collision issue */
+		hw_write_id_reg(ci, HS_PHY_GENCONFIG,
+				HS_PHY_TXFIFO_IDLE_FORCE_DIS, 0);
+
+		if (!msm_ci->hsic)
+			hw_write_id_reg(ci, HS_PHY_GENCONFIG_2,
+					HS_PHY_ULPI_TX_PKT_EN_CLR_FIX, 0);
+
+		if (ci->platdata->vbus_extcon.edev) {
+			hw_write_id_reg(ci, HS_PHY_GENCONFIG_2,
+					HS_PHY_SESS_VLD_CTRL_EN,
+					HS_PHY_SESS_VLD_CTRL_EN);
+			hw_write(ci, OP_USBCMD, HSPHY_SESS_VLD_CTRL,
+				 HSPHY_SESS_VLD_CTRL);
+
+		}
+
 		usb_phy_init(ci->usb_phy);
 		break;
 	case CI_HDRC_CONTROLLER_STOPPED_EVENT:
@@ -116,6 +146,7 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 	struct reset_control *reset;
 	struct resource *res;
 	int ret;
+	struct device_node *ulpi_node, *phy_node;
 
 	dev_dbg(&pdev->dev, "ci_hdrc_msm_probe\n");
 
@@ -181,6 +212,14 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_mux;
 
+	ulpi_node = of_find_node_by_name(pdev->dev.of_node, "ulpi");
+	if (ulpi_node) {
+		phy_node = of_get_next_available_child(ulpi_node, NULL);
+		ci->hsic = of_device_is_compatible(phy_node, "qcom,usb-hsic-phy");
+		of_node_put(phy_node);
+	}
+	of_node_put(ulpi_node);
+
 	plat_ci = ci_hdrc_add_device(&pdev->dev, pdev->resource,
 				     pdev->num_resources, &ci_hdrc_msm_platdata);
 	if (IS_ERR(plat_ci)) {
-- 
2.9.0.rc2.8.ga28705d
