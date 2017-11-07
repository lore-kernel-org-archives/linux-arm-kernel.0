From: ran.wang_1@nxp.com (Ran Wang)
Date: Tue, 7 Nov 2017 15:20:55 +0800
Subject: [PATCH v2 3/3] usb: dwc3: Enable USB 3.0 phy driver
In-Reply-To: <20171107072055.26945-1-ran.wang_1@nxp.com>
References: <20171107072055.26945-1-ran.wang_1@nxp.com>
Message-ID: <20171107072055.26945-3-ran.wang_1@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds entry point at dwc3 core init function to enable
USB 3.0 PHY driver.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Change in v2:
	- New file

 drivers/usb/dwc3/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 03474d3575ab..a9df03c64a7b 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -746,6 +746,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
 {
 	u32			reg;
 	int			ret;
+	int			retval;
+	struct phy *phy;
 
 	if (!dwc3_core_is_valid(dwc)) {
 		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
@@ -770,6 +772,19 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (ret)
 		goto err0;
 
+	phy = phy_get(dwc->dev, "usb-phy");
+	if (IS_ERR(phy)) {
+		retval = PTR_ERR(phy);
+		if (retval == -EPROBE_DEFER)
+			dev_dbg(dwc->dev, "usb-phy no found\n");
+	} else {
+		retval = phy_init(phy);
+		if (retval) {
+			phy_put(phy);
+		    dev_dbg(dwc->dev, "phy_init() error!\n");
+		}
+	}
+
 	ret = dwc3_core_soft_reset(dwc);
 	if (ret)
 		goto err0;
-- 
2.14.1
