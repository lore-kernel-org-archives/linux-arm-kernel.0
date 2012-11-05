From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon,  5 Nov 2012 08:34:52 +0100
Subject: [PATCH 2/2 v2] net: at91_ether: add pinctrl support
In-Reply-To: <1352100892-19936-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121105073015.GM19021@game.jcrosoft.org>
 <1352100892-19936-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1352100892-19936-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If no pinctrl available just report a warning as some architecture may not
need to do anything.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Tested-by: Joachim Eastwood <manabian@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: netdev at vger.kernel.org
---
 drivers/net/ethernet/cadence/at91_ether.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/cadence/at91_ether.c b/drivers/net/ethernet/cadence/at91_ether.c
index 039e7ef..6eb928e 100644
--- a/drivers/net/ethernet/cadence/at91_ether.c
+++ b/drivers/net/ethernet/cadence/at91_ether.c
@@ -34,6 +34,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_net.h>
+#include <linux/pinctrl/consumer.h>
 
 #include "macb.h"
 
@@ -501,11 +502,21 @@ static int __init at91ether_probe(struct platform_device *pdev)
 	struct phy_device *phydev;
 	struct macb *lp;
 	int res;
+	struct pinctrl *pinctrl;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs)
 		return -ENOENT;
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		res = PTR_ERR(pinctrl);
+		if (res == -EPROBE_DEFER)
+			return res;
+
+		dev_warn(&pdev->dev, "No pinctrl provided\n");
+	}
+
 	dev = alloc_etherdev(sizeof(struct macb));
 	if (!dev)
 		return -ENOMEM;
-- 
1.7.10.4
