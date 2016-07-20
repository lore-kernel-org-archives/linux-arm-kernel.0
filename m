From: peter.chen@nxp.com (Peter Chen)
Date: Wed, 20 Jul 2016 17:40:28 +0800
Subject: [PATCH v3 5/6] usb: chipidea: let chipidea core device of_node
 equal's glue layer device of_node
In-Reply-To: <1469007629-31757-1-git-send-email-peter.chen@nxp.com>
References: <1469007629-31757-1-git-send-email-peter.chen@nxp.com>
Message-ID: <1469007629-31757-6-git-send-email-peter.chen@nxp.com>
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
---
 drivers/usb/chipidea/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 69426e6..0d05812 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -914,6 +914,16 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	if (!ci)
 		return -ENOMEM;
 
+	/*
+	 * At device tree, we have no device node for chipidea core,
+	 * the glue layer's node is the parent node for host and udc
+	 * device. But in related driver, the parent device is chipidea
+	 * core. So, in order to let the common driver get parent's node,
+	 * we let the core's device node equals glue layer's node.
+	 */
+	if (dev->parent && dev->parent->of_node)
+		dev->of_node = dev->parent->of_node;
+
 	ci->dev = dev;
 	ci->platdata = dev_get_platdata(dev);
 	ci->imx28_write_fix = !!(ci->platdata->flags &
-- 
1.9.1
