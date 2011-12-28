From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Wed, 28 Dec 2011 16:03:27 +0900
Subject: [PATCH 6/6] USB: s3c-hsotg: Add regulator support
In-Reply-To: <1325055807-29347-1-git-send-email-jy0922.shim@samsung.com>
References: <1325055807-29347-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <1325055807-29347-6-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HSOTG hardware block needs two power sources and they can be
controlled using regulator.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/usb/gadget/s3c-hsotg.c |   64 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index 2665bf5..51b3ea2 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -155,6 +156,11 @@ struct s3c_hsotg {
 	int			irq;
 	struct clk		*clk;
 
+	struct regulator	*reg_vusb_a;
+	struct regulator	*reg_vusb_d;
+	struct mutex		mutex_lock;
+	bool			enabled;
+
 	unsigned int		dedicated_fifos:1;
 
 	struct dentry		*debug_root;
@@ -184,6 +190,36 @@ struct s3c_hsotg_req {
 	unsigned char		mapped;
 };
 
+static void s3c_hsotg_regulator_enable(struct s3c_hsotg *hsotg)
+{
+	mutex_lock(&hsotg->mutex_lock);
+	if (!hsotg->enabled) {
+		if (hsotg->reg_vusb_d)
+			regulator_enable(hsotg->reg_vusb_d);
+
+		if (hsotg->reg_vusb_a)
+			regulator_enable(hsotg->reg_vusb_a);
+
+			hsotg->enabled = true;
+	}
+	mutex_unlock(&hsotg->mutex_lock);
+}
+
+static void s3c_hsotg_regulator_disable(struct s3c_hsotg *hsotg)
+{
+	mutex_lock(&hsotg->mutex_lock);
+	if (hsotg->enabled) {
+		if (hsotg->reg_vusb_a)
+			regulator_disable(hsotg->reg_vusb_a);
+
+		if (hsotg->reg_vusb_d)
+			regulator_disable(hsotg->reg_vusb_d);
+
+		hsotg->enabled = false;
+	}
+	mutex_unlock(&hsotg->mutex_lock);
+}
+
 /* conversion functions */
 static inline struct s3c_hsotg_req *our_req(struct usb_request *req)
 {
@@ -3317,6 +3353,26 @@ static int __devinit s3c_hsotg_probe(struct platform_device *pdev)
 
 	clk_enable(hsotg->clk);
 
+	mutex_init(&hsotg->mutex_lock);
+
+	hsotg->reg_vusb_d = regulator_get(dev, "vusb_d");
+	if (IS_ERR(hsotg->reg_vusb_d)) {
+		ret = PTR_ERR(hsotg->reg_vusb_d);
+		dev_err(dev, "failed to get %s regulator (%d)\n",
+				"vusb_d", ret);
+		hsotg->reg_vusb_d = NULL;
+	}
+
+	hsotg->reg_vusb_a = regulator_get(dev, "vusb_a");
+	if (IS_ERR(hsotg->reg_vusb_a)) {
+		ret = PTR_ERR(hsotg->reg_vusb_a);
+		dev_err(dev, "failed to get %s regulator (%d)\n",
+				"vusb_a", ret);
+		hsotg->reg_vusb_a = NULL;
+	}
+
+	s3c_hsotg_regulator_enable(hsotg);
+
 	if (plat->phy_init)
 		plat->phy_init(pdev, S5P_USB_PHY_DEVICE);
 
@@ -3341,6 +3397,9 @@ static int __devinit s3c_hsotg_probe(struct platform_device *pdev)
 err_add_udc:
 	if (plat->phy_exit)
 		plat->phy_exit(pdev, S5P_USB_PHY_DEVICE);
+	s3c_hsotg_regulator_disable(hsotg);
+	regulator_put(hsotg->reg_vusb_a);
+	regulator_put(hsotg->reg_vusb_d);
 
 	clk_disable(hsotg->clk);
 	clk_put(hsotg->clk);
@@ -3378,6 +3437,11 @@ static int __devexit s3c_hsotg_remove(struct platform_device *pdev)
 	if (plat->phy_exit)
 		plat->phy_exit(pdev, S5P_USB_PHY_DEVICE);
 
+	s3c_hsotg_regulator_disable(hsotg);
+
+	regulator_put(hsotg->reg_vusb_a);
+	regulator_put(hsotg->reg_vusb_d);
+
 	clk_disable(hsotg->clk);
 	clk_put(hsotg->clk);
 
-- 
1.7.5.4
