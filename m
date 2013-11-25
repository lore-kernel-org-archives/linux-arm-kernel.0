From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 25 Nov 2013 15:31:21 +0530
Subject: [PATCH v3 01/10] usb: dwc3: invoke phy_resume after phy_init
In-Reply-To: <1385373690-12170-1-git-send-email-kishon@ti.com>
References: <1385373690-12170-1-git-send-email-kishon@ti.com>
Message-ID: <1385373690-12170-2-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

usb_phy_set_suspend(phy, 0) is called before usb_phy_init. Fix it.

Reported-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/dwc3/core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 74f9cf0..4dd1f7e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -455,9 +455,6 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-	usb_phy_set_suspend(dwc->usb2_phy, 0);
-	usb_phy_set_suspend(dwc->usb3_phy, 0);
-
 	spin_lock_init(&dwc->lock);
 	platform_set_drvdata(pdev, dwc);
 
@@ -488,6 +485,9 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
+	usb_phy_set_suspend(dwc->usb2_phy, 0);
+	usb_phy_set_suspend(dwc->usb3_phy, 0);
+
 	ret = dwc3_event_buffers_setup(dwc);
 	if (ret) {
 		dev_err(dwc->dev, "failed to setup event buffers\n");
-- 
1.7.10.4
