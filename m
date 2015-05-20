From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 May 2015 14:21:02 -0700
Subject: [PATCH 1/2] memory: omap-gpmc: Fix parsing of devices
In-Reply-To: <1432156863-19695-1-git-send-email-tony@atomide.com>
References: <1432156863-19695-1-git-send-email-tony@atomide.com>
Message-ID: <1432156863-19695-2-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently artificially limit the parsing of GPMC connected
devices based on the device name. Let's stop doing that, it's
confusing as adding devices to .dts files with using normal
names like fpga and usb will currently cause them to not probe.

Cc: Roger Quadros <rogerq@ti.com>
Reported-by: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/memory/omap-gpmc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index c94ea0d..0e524a1 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2074,14 +2074,8 @@ static int gpmc_probe_dt(struct platform_device *pdev)
 			ret = gpmc_probe_nand_child(pdev, child);
 		else if (of_node_cmp(child->name, "onenand") == 0)
 			ret = gpmc_probe_onenand_child(pdev, child);
-		else if (of_node_cmp(child->name, "ethernet") == 0 ||
-			 of_node_cmp(child->name, "nor") == 0 ||
-			 of_node_cmp(child->name, "uart") == 0)
+		else
 			ret = gpmc_probe_generic_child(pdev, child);
-
-		if (WARN(ret < 0, "%s: probing gpmc child %s failed\n",
-			 __func__, child->full_name))
-			of_node_put(child);
 	}
 
 	return 0;
-- 
2.1.4
