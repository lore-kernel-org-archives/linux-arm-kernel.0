From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 17 Oct 2016 18:56:32 -0700
Subject: [PATCH v5 19/23] usb: chipidea: msm: Add reset controller for PHY POR
 bit
In-Reply-To: <20161018015636.11701-1-stephen.boyd@linaro.org>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
Message-ID: <20161018015636.11701-20-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MSM chipidea wrapper has two bits that are used to reset the
first or second phy. Add support for these bits via the reset
controller framework, so that phy drivers can reset their
hardware at the right time during initialization.

Acked-by: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/chipidea/Kconfig       |  1 +
 drivers/usb/chipidea/ci_hdrc_msm.c | 50 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
index 19c20eaa23f2..fc96f5cdcb5c 100644
--- a/drivers/usb/chipidea/Kconfig
+++ b/drivers/usb/chipidea/Kconfig
@@ -2,6 +2,7 @@ config USB_CHIPIDEA
 	tristate "ChipIdea Highspeed Dual Role Controller"
 	depends on ((USB_EHCI_HCD && USB_GADGET) || (USB_EHCI_HCD && !USB_GADGET) || (!USB_EHCI_HCD && USB_GADGET)) && HAS_DMA
 	select EXTCON
+	select RESET_CONTROLLER
 	help
 	  Say Y here if your system has a dual role high speed USB
 	  controller based on ChipIdea silicon IP. It supports:
diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index 2489a63d3e75..fe96df7b530c 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -14,6 +14,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/io.h>
+#include <linux/reset-controller.h>
 #include <linux/extcon.h>
 #include <linux/of.h>
 
@@ -31,8 +32,10 @@
 #define HSPHY_SESS_VLD_CTRL		BIT(25)
 
 /* Vendor base starts at 0x200 beyond CI base */
+#define HS_PHY_CTRL			0x0040
 #define HS_PHY_SEC_CTRL			0x0078
 #define HS_PHY_DIG_CLAMP_N		BIT(16)
+#define HS_PHY_POR_ASSERT		BIT(0)
 
 struct ci_hdrc_msm {
 	struct platform_device *ci;
@@ -40,11 +43,43 @@ struct ci_hdrc_msm {
 	struct clk *iface_clk;
 	struct clk *fs_clk;
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
+	writel(val, addr);
+	/*
+	 * wait for minimum 10 microseconds as suggested by manual.
+	 * Use a slightly larger value since the exact value didn't
+	 * work 100% of the time.
+	 */
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
@@ -186,10 +221,18 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 	if (!ci->base)
 		return -ENOMEM;
 
-	ret = clk_prepare_enable(ci->fs_clk);
+	ci->rcdev.owner = THIS_MODULE;
+	ci->rcdev.ops = &ci_hdrc_msm_reset_ops;
+	ci->rcdev.of_node = pdev->dev.of_node;
+	ci->rcdev.nr_resets = 2;
+	ret = reset_controller_register(&ci->rcdev);
 	if (ret)
 		return ret;
 
+	ret = clk_prepare_enable(ci->fs_clk);
+	if (ret)
+		goto err_fs;
+
 	reset_control_assert(reset);
 	usleep_range(10000, 12000);
 	reset_control_deassert(reset);
@@ -198,7 +241,7 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 
 	ret = clk_prepare_enable(ci->core_clk);
 	if (ret)
-		return ret;
+		goto err_fs;
 
 	ret = clk_prepare_enable(ci->iface_clk);
 	if (ret)
@@ -236,6 +279,8 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 	clk_disable_unprepare(ci->iface_clk);
 err_iface:
 	clk_disable_unprepare(ci->core_clk);
+err_fs:
+	reset_controller_unregister(&ci->rcdev);
 	return ret;
 }
 
@@ -247,6 +292,7 @@ static int ci_hdrc_msm_remove(struct platform_device *pdev)
 	ci_hdrc_remove_device(ci->ci);
 	clk_disable_unprepare(ci->iface_clk);
 	clk_disable_unprepare(ci->core_clk);
+	reset_controller_unregister(&ci->rcdev);
 
 	return 0;
 }
-- 
2.10.0.297.gf6727b0
