From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 5 Nov 2013 09:55:20 +0800
Subject: [PATCH v3 05/10] usb: chipidea: usbmisc_imx: add set_wakup API
In-Reply-To: <1383616525-10769-1-git-send-email-peter.chen@freescale.com>
References: <1383616525-10769-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1383616525-10769-6-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is used to enable USB wakeup, currently only imx6 SoC serial
usb's wakeup is enabled.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.h |    1 +
 drivers/usb/chipidea/usbmisc_imx.c |   41 ++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.h b/drivers/usb/chipidea/ci_hdrc_imx.h
index c727159..92f4c30 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.h
+++ b/drivers/usb/chipidea/ci_hdrc_imx.h
@@ -18,3 +18,4 @@ struct imx_usbmisc_data {
 
 int imx_usbmisc_init(struct imx_usbmisc_data *);
 int imx_usbmisc_init_post(struct imx_usbmisc_data *);
+int imx_usbmisc_set_wakeup(struct imx_usbmisc_data *, bool);
diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 1fd9a12..55b59e0 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -28,12 +28,18 @@
 #define MX53_BM_OVER_CUR_DIS_UHx	BIT(30)
 
 #define MX6_BM_OVER_CUR_DIS		BIT(7)
+#define MX6_BM_WAKEUP_ENABLE		BIT(10)
+#define MX6_BM_ID_WAKEUP		BIT(16)
+#define MX6_BM_VBUS_WAKEUP		BIT(17)
+#define MX6_BM_WAKEUP_INTR		BIT(31)
 
 struct usbmisc_ops {
 	/* It's called once when probe a usb device */
 	int (*init)(struct imx_usbmisc_data *data);
 	/* It's called once after adding a usb device */
 	int (*post)(struct imx_usbmisc_data *data);
+	/* It's called when we need to enable usb wakeup */
+	int (*set_wakeup)(struct imx_usbmisc_data *data, bool enabled);
 };
 
 struct imx_usbmisc {
@@ -122,6 +128,30 @@ static int usbmisc_imx6q_init(struct imx_usbmisc_data *data)
 	return 0;
 }
 
+static int usbmisc_imx6q_set_wakeup
+	(struct imx_usbmisc_data *data, bool enabled)
+{
+	unsigned long flags;
+	u32 reg, val = (MX6_BM_WAKEUP_ENABLE | MX6_BM_VBUS_WAKEUP
+		| MX6_BM_ID_WAKEUP);
+
+	if (data->index > 3)
+		return -EINVAL;
+
+	spin_lock_irqsave(&usbmisc->lock, flags);
+	reg = readl(usbmisc->base + data->index * 4);
+	if (enabled) {
+		writel(reg | val, usbmisc->base + data->index * 4);
+	} else {
+		if (reg & MX6_BM_WAKEUP_INTR)
+			pr_debug("wakeup int at ci_hdrc.%d\n", data->index);
+		writel(reg & ~val, usbmisc->base + data->index * 4);
+	}
+	spin_unlock_irqrestore(&usbmisc->lock, flags);
+
+	return 0;
+}
+
 static const struct usbmisc_ops imx25_usbmisc_ops = {
 	.post = usbmisc_imx25_post,
 };
@@ -132,6 +162,7 @@ static const struct usbmisc_ops imx53_usbmisc_ops = {
 
 static const struct usbmisc_ops imx6q_usbmisc_ops = {
 	.init = usbmisc_imx6q_init,
+	.set_wakeup = usbmisc_imx6q_set_wakeup,
 };
 
 int imx_usbmisc_init(struct imx_usbmisc_data *data)
@@ -154,6 +185,16 @@ int imx_usbmisc_init_post(struct imx_usbmisc_data *data)
 }
 EXPORT_SYMBOL_GPL(imx_usbmisc_init_post);
 
+int imx_usbmisc_set_wakeup(struct imx_usbmisc_data *data, bool enabled)
+{
+	if (!usbmisc)
+		return -ENODEV;
+	if (!usbmisc->ops->set_wakeup)
+		return 0;
+	return usbmisc->ops->set_wakeup(data, enabled);
+}
+EXPORT_SYMBOL_GPL(imx_usbmisc_set_wakeup);
+
 static const struct of_device_id usbmisc_imx_dt_ids[] = {
 	{
 		.compatible = "fsl,imx25-usbmisc",
-- 
1.7.1
