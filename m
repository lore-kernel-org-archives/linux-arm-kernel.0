From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 19 Mar 2015 09:19:20 +0800
Subject: [PATCH 09/12] usb: chipidea: usbmisc_imx: add unburst setting for imx6
In-Reply-To: <1426727963-32280-1-git-send-email-peter.chen@freescale.com>
References: <1426727963-32280-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1426727963-32280-10-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this setting and AHBBRST at SBUSCFG as "Incremental burst of
unspecified length", each unburst size can be taken as one single transfer.
It is benefit for unburst size transfer.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/usbmisc_imx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 8af070f..6a6e73c 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -54,6 +54,7 @@
 #define MX53_USB_PHYCTRL1_PLLDIV_MASK	0x3
 #define MX53_USB_PLL_DIV_24_MHZ		0x01
 
+#define MX6_BM_UNBURST_SETTING		BIT(1)
 #define MX6_BM_OVER_CUR_DIS		BIT(7)
 #define MX6_BM_WAKEUP_ENABLE		BIT(10)
 #define MX6_BM_ID_WAKEUP		BIT(16)
@@ -255,14 +256,21 @@ static int usbmisc_imx6q_init(struct imx_usbmisc_data *data)
 	if (data->index > 3)
 		return -EINVAL;
 
+	spin_lock_irqsave(&usbmisc->lock, flags);
+
 	if (data->disable_oc) {
-		spin_lock_irqsave(&usbmisc->lock, flags);
 		reg = readl(usbmisc->base + data->index * 4);
 		writel(reg | MX6_BM_OVER_CUR_DIS,
 			usbmisc->base + data->index * 4);
-		spin_unlock_irqrestore(&usbmisc->lock, flags);
 	}
 
+	/* SoC unburst setting */
+	reg = readl(usbmisc->base + data->index * 4);
+	writel(reg | MX6_BM_UNBURST_SETTING,
+			usbmisc->base + data->index * 4);
+
+	spin_unlock_irqrestore(&usbmisc->lock, flags);
+
 	usbmisc_imx6q_set_wakeup(data, false);
 
 	return 0;
-- 
1.9.1
