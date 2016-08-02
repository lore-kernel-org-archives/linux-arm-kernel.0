From: peter.chen@nxp.com (Peter Chen)
Date: Tue, 2 Aug 2016 11:30:51 +0800
Subject: [PATCH v4 5/6] usb: chipidea: let chipidea core device of_node
 equal's glue layer device of_node
In-Reply-To: <1470108652-16812-1-git-send-email-peter.chen@nxp.com>
References: <1470108652-16812-1-git-send-email-peter.chen@nxp.com>
Message-ID: <1470108652-16812-6-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Chen <peter.chen@freescale.com>

At device tree, we have no device node for chipidea core,
the glue layer's node is the parent node for host and udc
device. But in related driver, the parent device is chipidea
core. So, in order to let the common driver get parent's node,
we let the core's device node equals glue layer device node.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Tested-by Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/usb/chipidea/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 69426e6..b189dc7 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -954,6 +954,15 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		dev_err(dev, "unable to init phy: %d\n", ret);
 		return ret;
 	}
+	/*
+	 * At device tree, we have no device node for chipidea core,
+	 * the glue layer's node is the parent node for host and udc
+	 * device. But in related driver, the parent device is chipidea
+	 * core. So, in order to let the common driver get parent's node,
+	 * we let the core's device node equals glue layer's node.
+	 */
+	if (dev->parent && dev->parent->of_node)
+		dev->of_node = dev->parent->of_node;
 
 	ci->hw_bank.phys = res->start;
 
@@ -1057,6 +1066,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 stop:
 	ci_role_destroy(ci);
 deinit_phy:
+	dev->of_node = NULL;
 	ci_usb_phy_exit(ci);
 
 	return ret;
@@ -1076,6 +1086,7 @@ static int ci_hdrc_remove(struct platform_device *pdev)
 	ci_extcon_unregister(ci);
 	ci_role_destroy(ci);
 	ci_hdrc_enter_lpm(ci, true);
+	ci->dev->of_node = NULL;
 	ci_usb_phy_exit(ci);
 
 	return 0;
-- 
1.9.1
