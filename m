From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Sun, 26 Jun 2016 00:28:35 -0700
Subject: [PATCH 18/21] usb: chipidea: msm: Add reset controller for PHY POR bit
In-Reply-To: <20160626072838.28082-1-stephen.boyd@linaro.org>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
Message-ID: <20160626072838.28082-19-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MSM chipidea wrapper has two bits that are used to reset the
first or second phy. Add support for these bits via the reset
controller framework, so that phy drivers can reset their
hardware at the right time during initialization.

Cc: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/chipidea/ci_hdrc_msm.c | 43 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index fb4340f02c16..7d191928e55b 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -14,14 +14,17 @@
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/io.h>
+#include <linux/reset-controller.h>
 #include <linux/extcon.h>
 #include <linux/of.h>
 
 #include "ci.h"
 
 #define HS_PHY_AHB_MODE			0x0098
+#define HS_PHY_CTRL			0x0240
 #define HS_PHY_SEC_CTRL			0x0278
 # define HS_PHY_DIG_CLAMP_N		BIT(16)
+# define HS_PHY_POR_ASSERT		BIT(0)
 
 #define HS_PHY_GENCONFIG		0x009c
 # define HS_PHY_TXFIFO_IDLE_FORCE_DIS	BIT(4)
@@ -38,11 +41,38 @@ struct ci_hdrc_msm {
 	struct clk *iface_clk;
 	struct extcon_dev *vbus_edev;
 	struct ci_hdrc_platform_data pdata;
+	struct reset_controller_dev rcdev;
 	bool secondary_phy;
 	bool hsic;
 	void __iomem *base;
 };
 
+static int
+ci_hdrc_msm_por_reset(struct reset_controller_dev *r, unsigned long id)
+{
+	struct ci_hdrc_msm *ci_msm = container_of(r, struct ci_hdrc_msm, rcdev);
+	void __iomem *addr = ci_msm->base;
+	u32 val;
+
+	if (id)
+		addr += HS_PHY_SEC_CTRL;
+	else
+		addr += HS_PHY_CTRL;
+
+	val = readl_relaxed(addr);
+	val |= HS_PHY_POR_ASSERT;
+	writel_relaxed(val, addr);
+	udelay(12);
+	val &= ~HS_PHY_POR_ASSERT;
+	writel(val, addr);
+
+	return 0;
+}
+
+static const struct reset_control_ops ci_hdrc_msm_reset_ops = {
+	.reset = ci_hdrc_msm_por_reset,
+};
+
 static void ci_hdrc_msm_notify_event(struct ci_hdrc *ci, unsigned event)
 {
 	struct device *dev = ci->dev->parent;
@@ -176,13 +206,21 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 		ci->vbus_edev = NULL;
 	}
 
+	ci->rcdev.owner = THIS_MODULE;
+	ci->rcdev.ops = &ci_hdrc_msm_reset_ops;
+	ci->rcdev.of_node = pdev->dev.of_node;
+	ci->rcdev.nr_resets = 2;
+	ret = reset_controller_register(&ci->rcdev);
+	if (ret)
+		return ret;
+
 	reset_control_assert(reset);
 	usleep_range(10000, 12000);
 	reset_control_deassert(reset);
 
 	ret = clk_prepare_enable(ci->core_clk);
 	if (ret)
-		return ret;
+		goto err_core;
 
 	ret = clk_prepare_enable(ci->iface_clk);
 	if (ret)
@@ -220,6 +258,8 @@ err_mux:
 	clk_disable_unprepare(ci->iface_clk);
 err_iface:
 	clk_disable_unprepare(ci->core_clk);
+err_core:
+	reset_controller_unregister(&ci->rcdev);
 	return ret;
 }
 
@@ -232,6 +272,7 @@ static int ci_hdrc_msm_remove(struct platform_device *pdev)
 	ci_hdrc_remove_device(ci->ci);
 	clk_disable_unprepare(ci->iface_clk);
 	clk_disable_unprepare(ci->core_clk);
+	reset_controller_unregister(&ci->rcdev);
 
 	return 0;
 }
-- 
2.9.0.rc2.8.ga28705d
