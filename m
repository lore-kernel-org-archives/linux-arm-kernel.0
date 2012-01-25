From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:39:34 +0000
Subject: [PATCH 28/33] MFD: mcp-core: remove legacy driver suspend/resume
 methods
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq40c-0000Zd-U0@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The legacy driver suspend/resume methods are no longer used, so get rid
of them.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/mcp-core.c  |   28 ----------------------------
 include/linux/mfd/mcp.h |    2 --
 2 files changed, 0 insertions(+), 30 deletions(-)

diff --git a/drivers/mfd/mcp-core.c b/drivers/mfd/mcp-core.c
index c409d63..6acf2e0 100644
--- a/drivers/mfd/mcp-core.c
+++ b/drivers/mfd/mcp-core.c
@@ -47,39 +47,11 @@ static int mcp_bus_remove(struct device *dev)
 	return 0;
 }
 
-static int mcp_bus_suspend(struct device *dev, pm_message_t state)
-{
-	struct mcp *mcp = to_mcp(dev);
-	int ret = 0;
-
-	if (dev->driver) {
-		struct mcp_driver *drv = to_mcp_driver(dev->driver);
-
-		ret = drv->suspend(mcp, state);
-	}
-	return ret;
-}
-
-static int mcp_bus_resume(struct device *dev)
-{
-	struct mcp *mcp = to_mcp(dev);
-	int ret = 0;
-
-	if (dev->driver) {
-		struct mcp_driver *drv = to_mcp_driver(dev->driver);
-
-		ret = drv->resume(mcp);
-	}
-	return ret;
-}
-
 static struct bus_type mcp_bus_type = {
 	.name		= "mcp",
 	.match		= mcp_bus_match,
 	.probe		= mcp_bus_probe,
 	.remove		= mcp_bus_remove,
-	.suspend	= mcp_bus_suspend,
-	.resume		= mcp_bus_resume,
 };
 
 /**
diff --git a/include/linux/mfd/mcp.h b/include/linux/mfd/mcp.h
index bfcdf6d..a9e8bd1 100644
--- a/include/linux/mfd/mcp.h
+++ b/include/linux/mfd/mcp.h
@@ -48,8 +48,6 @@ struct mcp_driver {
 	struct device_driver drv;
 	int (*probe)(struct mcp *);
 	void (*remove)(struct mcp *);
-	int (*suspend)(struct mcp *, pm_message_t);
-	int (*resume)(struct mcp *);
 };
 
 int mcp_driver_register(struct mcp_driver *);
-- 
1.7.4.4
