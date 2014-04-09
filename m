From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed,  9 Apr 2014 15:51:16 +0200
Subject: [PATCH 13/15] pinctrl: sunxi: retrieve and enable PL reset line for
 A31 SoC
In-Reply-To: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1397051478-4113-14-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Retrieve and deassert the reset line related to PL pins.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 drivers/pinctrl/pinctrl-sunxi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
index da76ceb..09eea79 100644
--- a/drivers/pinctrl/pinctrl-sunxi.c
+++ b/drivers/pinctrl/pinctrl-sunxi.c
@@ -26,6 +26,7 @@
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 
 #include "core.h"
@@ -878,6 +879,7 @@ static int sunxi_pinctrl_probe(struct platform_device *pdev)
 	const struct of_device_id *device;
 	struct pinctrl_pin_desc *pins;
 	struct sunxi_pinctrl *pctl;
+	struct reset_control *rstc;
 	int i, ret, last_pin;
 	struct clk *clk;
 
@@ -905,6 +907,14 @@ static int sunxi_pinctrl_probe(struct platform_device *pdev)
 		ret = clk_prepare_enable(clk);
 		if (ret)
 			return ret;
+
+		rstc = devm_reset_control_get(&pdev->dev, NULL);
+		if (IS_ERR(rstc))
+			return PTR_ERR(rstc);
+
+		ret = reset_control_deassert(rstc);
+		if (ret)
+			return ret;
 	} else {
 		pctl->get_membase = sunxi_pinctrl_get_membase;
 	}
-- 
1.8.3.2
