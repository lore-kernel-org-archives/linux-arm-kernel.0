From: peter.chen@freescale.com (Peter Chen)
Date: Sat, 12 Oct 2013 17:35:03 +0800
Subject: [PATCH 01/11] usb: chipidea: Add power management support
In-Reply-To: <1381570513-24927-1-git-send-email-peter.chen@freescale.com>
References: <1381570513-24927-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1381570513-24927-2-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds runtime and system power management support for
chipidea core. The runtime pm support is controlled by glue
layer, it can be enabled by flag CI_HDRC_SUPPORTS_RUNTIME_PM.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci.h    |    2 +
 drivers/usb/chipidea/core.c  |  119 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/usb/chipidea.h |    1 +
 3 files changed, 122 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index 1c94fc5..6c16d11 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -173,6 +173,8 @@ struct ci_hdrc {
 	struct dentry			*debugfs;
 	bool				id_event;
 	bool				b_sess_valid_event;
+	bool				supports_runtime_pm;
+	atomic_t			in_lpm;
 };
 
 static inline struct ci_role_driver *ci_role(struct ci_hdrc *ci)
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 87546a0..7ffb8cb 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -578,6 +578,10 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	hw_phymode_configure(ci);
 
 	dr_mode = ci->platdata->dr_mode;
+
+	ci->supports_runtime_pm = !!(ci->platdata->flags &
+		CI_HDRC_SUPPORTS_RUNTIME_PM);
+
 	/* initialize role(s) before the interrupt is requested */
 	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
 		ret = ci_hdrc_host_init(ci);
@@ -651,6 +655,13 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	if (ret)
 		goto stop;
 
+	device_set_wakeup_capable(&pdev->dev, true);
+
+	if (ci->supports_runtime_pm) {
+		pm_runtime_set_active(&pdev->dev);
+		pm_runtime_enable(&pdev->dev);
+	}
+
 	ret = dbg_create_files(ci);
 	if (!ret)
 		return 0;
@@ -668,6 +679,11 @@ static int ci_hdrc_remove(struct platform_device *pdev)
 {
 	struct ci_hdrc *ci = platform_get_drvdata(pdev);
 
+	if (ci->supports_runtime_pm) {
+		pm_runtime_get_sync(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+		pm_runtime_put_noidle(&pdev->dev);
+	}
 	dbg_remove_files(ci);
 	free_irq(ci->irq, ci);
 	ci_role_destroy(ci);
@@ -678,11 +694,114 @@ static int ci_hdrc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int ci_controller_suspend(struct device *dev)
+{
+	struct ci_hdrc *ci = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "at %s\n", __func__);
+
+	if (atomic_read(&ci->in_lpm))
+		return 0;
+
+	disable_irq(ci->irq);
+
+	if (ci->transceiver)
+		usb_phy_set_wakeup(ci->transceiver, true);
+
+	ci_hdrc_enter_lpm(ci, true);
+
+	if (ci->transceiver)
+		usb_phy_set_suspend(ci->transceiver, 1);
+
+	atomic_set(&ci->in_lpm, 1);
+
+	enable_irq(ci->irq);
+
+	return 0;
+}
+
+static int ci_controller_resume(struct device *dev)
+{
+	struct ci_hdrc *ci = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "at %s\n", __func__);
+
+	if (!atomic_read(&ci->in_lpm))
+		return 0;
+
+	ci_hdrc_enter_lpm(ci, false);
+
+	if (ci->transceiver) {
+		usb_phy_set_suspend(ci->transceiver, 0);
+		usb_phy_set_wakeup(ci->transceiver, false);
+	}
+
+	atomic_set(&ci->in_lpm, 0);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int ci_suspend(struct device *dev)
+{
+	struct ci_hdrc *ci = dev_get_drvdata(dev);
+	int ret;
+
+	ret = ci_controller_suspend(dev);
+	if (ret)
+		return ret;
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(ci->irq);
+
+	return ret;
+}
+
+static int ci_resume(struct device *dev)
+{
+	struct ci_hdrc *ci = dev_get_drvdata(dev);
+	int ret;
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(ci->irq);
+
+	ret = ci_controller_resume(dev);
+	if (!ret && ci->supports_runtime_pm) {
+		pm_runtime_disable(dev);
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
+	}
+
+	return ret;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+#ifdef CONFIG_PM_RUNTIME
+static int ci_runtime_suspend(struct device *dev)
+{
+	return ci_controller_suspend(dev);
+}
+
+static int ci_runtime_resume(struct device *dev)
+{
+	return ci_controller_resume(dev);
+}
+#endif /* CONFIG_PM_RUNTIME */
+
+#endif /* CONFIG_PM */
+static const struct dev_pm_ops ci_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(ci_suspend, ci_resume)
+	SET_RUNTIME_PM_OPS(ci_runtime_suspend,
+			ci_runtime_resume, NULL)
+};
+
 static struct platform_driver ci_hdrc_driver = {
 	.probe	= ci_hdrc_probe,
 	.remove	= ci_hdrc_remove,
 	.driver	= {
 		.name	= "ci_hdrc",
+		.pm	= &ci_pm_ops,
 	},
 };
 
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index 7d39967..667b46c 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -18,6 +18,7 @@ struct ci_hdrc_platform_data {
 	unsigned long	 flags;
 #define CI_HDRC_REGS_SHARED		BIT(0)
 #define CI_HDRC_REQUIRE_TRANSCEIVER	BIT(1)
+#define CI_HDRC_SUPPORTS_RUNTIME_PM	BIT(2)
 #define CI_HDRC_DISABLE_STREAMING	BIT(3)
 	/*
 	 * Only set it when DCCPARAMS.DC==1 and DCCPARAMS.HC==1,
-- 
1.7.1
