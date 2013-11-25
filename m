From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 25 Nov 2013 15:31:22 +0530
Subject: [PATCH v3 02/10] usb: dwc3: power off usb phy in error path
In-Reply-To: <1385373690-12170-1-git-send-email-kishon@ti.com>
References: <1385373690-12170-1-git-send-email-kishon@ti.com>
Message-ID: <1385373690-12170-3-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

usb phy was power'ed on but was never power'ed off in the error path.
Fix it.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/dwc3/core.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 4dd1f7e..a49217a 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -569,6 +569,8 @@ err2:
 	dwc3_event_buffers_cleanup(dwc);
 
 err1:
+	usb_phy_set_suspend(dwc->usb2_phy, 1);
+	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	dwc3_core_exit(dwc);
 
 err0:
-- 
1.7.10.4
