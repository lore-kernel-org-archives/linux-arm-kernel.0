From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 10 Jan 2013 16:35:52 +0800
Subject: [PATCH 2/4] usb: mxs-phy: Change mxs phy clock usage
In-Reply-To: <1357806954-27960-1-git-send-email-peter.chen@freescale.com>
References: <1357806954-27960-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1357806954-27960-2-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we mark mxs-phy as dummy clock for i.mx6q, we only need to
enable it at probe, this clock doesn't need to be managed
by clock framework.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/otg/mxs-phy.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/otg/mxs-phy.c b/drivers/usb/otg/mxs-phy.c
index 7630272..7dca384 100644
--- a/drivers/usb/otg/mxs-phy.c
+++ b/drivers/usb/otg/mxs-phy.c
@@ -20,6 +20,9 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #define DRIVER_NAME "mxs_phy"
 
@@ -108,6 +111,7 @@ static int mxs_phy_probe(struct platform_device *pdev)
 	void __iomem *base;
 	struct clk *clk;
 	struct mxs_phy *mxs_phy;
+	struct regmap *anatop;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -146,6 +150,46 @@ static int mxs_phy_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, &mxs_phy->phy);
 
+	/*
+	 * At mx6x, USB PHY PLL and its output gate is controlled by hardware.
+	 * It just needs to open at init, if the usb device is
+	 * in suspend, it will close related PLL automatically.
+	 */
+
+	anatop = syscon_regmap_lookup_by_compatible("fsl,imx6q-anatop");
+
+#define CTRL_SET				0x4
+#define CTRL_CLR				0x8
+
+#define BM_ANADIG_USB_PLL_480_CTRL_BYPASS		(1 << 16)
+#define BM_ANADIG_USB_PLL_480_CTRL_ENABLE		(1 << 13)
+#define BM_ANADIG_USB_PLL_480_CTRL_POWER		(1 << 12)
+#define BM_ANADIG_USB_PLL_480_CTRL_EN_USB_CLKS		(1 << 6)
+
+	if (!IS_ERR(anatop)) {
+		struct device *dev = &pdev->dev;
+		struct device_node *np = dev->of_node;
+		u32 phy_reg_offset;
+		int ret;
+
+		ret = of_property_read_u32(np, "anatop-phy-reg-offset",
+					   &phy_reg_offset);
+		if (ret) {
+			dev_err(dev, "no anatop-phy-reg-offset property set\n");
+			return -EINVAL;
+		}
+
+		regmap_write(anatop, phy_reg_offset + 0x8,
+				BM_ANADIG_USB_PLL_480_CTRL_BYPASS);
+		regmap_write(anatop, phy_reg_offset + 0x4,
+				BM_ANADIG_USB_PLL_480_CTRL_ENABLE
+				| BM_ANADIG_USB_PLL_480_CTRL_POWER
+				| BM_ANADIG_USB_PLL_480_CTRL_EN_USB_CLKS);
+
+	} else {
+		pr_warn("failed to find fsl,imx6q-anatop regmap\n");
+	}
+
 	return 0;
 }
 
-- 
1.7.0.4
