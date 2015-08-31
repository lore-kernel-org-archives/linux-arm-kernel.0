From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 31 Aug 2015 21:09:08 +0530
Subject: [PATCH 1/2] usb: dwc3: support for pinctrl state change during system
 sleep
In-Reply-To: <cover.1441029572.git.nsekhar@ti.com>
References: <cover.1441029572.git.nsekhar@ti.com>
Message-ID: <9dd70870cfee40154a37186d4cf3ae0e9a452cbd.1441029572.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for USB DRVVBUS pinctrl state change during
suspend/resume. This helps is conserving power during
system sleep.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/usb/dwc3/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ff5773c66b84..a5ffa66e39fb 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1093,6 +1093,8 @@ static int dwc3_suspend(struct device *dev)
 	phy_exit(dwc->usb2_generic_phy);
 	phy_exit(dwc->usb3_generic_phy);
 
+	pinctrl_pm_select_sleep_state(dev);
+
 	return 0;
 }
 
@@ -1102,6 +1104,8 @@ static int dwc3_resume(struct device *dev)
 	unsigned long	flags;
 	int		ret;
 
+	pinctrl_pm_select_default_state(dev);
+
 	usb_phy_init(dwc->usb3_phy);
 	usb_phy_init(dwc->usb2_phy);
 	ret = phy_init(dwc->usb2_generic_phy);
-- 
2.4.4.408.g16da57c
