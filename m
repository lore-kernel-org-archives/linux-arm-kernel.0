From: peter.chen@freescale.com (Peter Chen)
Date: Sat, 12 Oct 2013 17:35:11 +0800
Subject: [PATCH 09/11] usb: chipidea: imx: Enable CI_HDRC_IMX_EHCI_QUIRK if
 the phy has notify APIs
In-Reply-To: <1381570513-24927-1-git-send-email-peter.chen@freescale.com>
References: <1381570513-24927-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1381570513-24927-10-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the PHY has .notify_suspend and .notify_resume, it means this
imx usb controller needs to add quirks for standard ehci routine.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 0424cbf..c2e0d73 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -118,6 +118,11 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 
 	pdata.phy = data->phy;
 
+	/* notify APIs are used for adding quirks at standard EHCI routine */
+	if (pdata.phy && pdata.phy->notify_suspend
+			&& pdata.phy->notify_resume)
+		pdata.flags |= CI_HDRC_IMX_EHCI_QUIRK;
+
 	if (of_find_property(np, "supports_runtime_pm", NULL)) {
 		pdata.flags |= CI_HDRC_SUPPORTS_RUNTIME_PM;
 		data->supports_runtime_pm = true;
-- 
1.7.1
