From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 22 Oct 2013 14:23:39 +0800
Subject: [Patch v2 10/10] usb: chipidea: imx: Enable CI_HDRC_IMX_EHCI_QUIRK if
 the phy has notify APIs
In-Reply-To: <1382423019-26184-1-git-send-email-peter.chen@freescale.com>
References: <1382423019-26184-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1382423019-26184-11-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the PHY has .notify_suspend and .notify_resume, it means this
imx usb controller needs to add quirks for standard ehci routine.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index d4775b3..4045c76 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -118,6 +118,11 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 
 	pdata.phy = data->phy;
 
+	/* notify APIs are used for adding quirks at standard EHCI routine */
+	if (pdata.phy && pdata.phy->notify_suspend
+			&& pdata.phy->notify_resume)
+		pdata.flags |= CI_HDRC_IMX_EHCI_QUIRK;
+
 	if (of_device_is_compatible(np, "fsl,imx6q-usb")) {
 		pdata.flags |= CI_HDRC_SUPPORTS_RUNTIME_PM;
 		data->supports_runtime_pm = true;
-- 
1.7.1
