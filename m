From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:32:47 +0000
Subject: [PATCH 08/33] MFD: mcp-core: sanitize host creation/removal
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3u3-0000YA-Uc@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

host_unregister() gives us no chance between removing the device
and the mcp data structure being freed to access the data inbetween,
which drivers may need to do if they need to iounmap() pointers in
their private data structures.

Therefore, re-jig the interfaces, which are now, on creation:

	mcp = mcp_host_alloc()
	if (mcp) {
		ret = mcp_host_add(mcp, data);

		if (!ret)
			mcp_host_free(mcp);
	}

and on removal:

	mcp_host_del(mcp);
	... access mcp ...
	mcp_host_free(mcp);

The free does the final put_device() on the struct device as one would
expect.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/mcp-core.c   |   19 +++++++++++++------
 drivers/mfd/mcp-sa11x0.c |    6 ++++--
 include/linux/mfd/mcp.h  |    5 +++--
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/mcp-core.c b/drivers/mfd/mcp-core.c
index 86cc3f7..cc76431 100644
--- a/drivers/mfd/mcp-core.c
+++ b/drivers/mfd/mcp-core.c
@@ -208,6 +208,7 @@ struct mcp *mcp_host_alloc(struct device *parent, size_t size)
 	mcp = kzalloc(sizeof(struct mcp) + size, GFP_KERNEL);
 	if (mcp) {
 		spin_lock_init(&mcp->lock);
+		device_initialize(&mcp->attached_device);
 		mcp->attached_device.parent = parent;
 		mcp->attached_device.bus = &mcp_bus_type;
 		mcp->attached_device.dma_mask = parent->dma_mask;
@@ -217,18 +218,24 @@ struct mcp *mcp_host_alloc(struct device *parent, size_t size)
 }
 EXPORT_SYMBOL(mcp_host_alloc);
 
-int mcp_host_register(struct mcp *mcp)
+int mcp_host_add(struct mcp *mcp)
 {
 	dev_set_name(&mcp->attached_device, "mcp0");
-	return device_register(&mcp->attached_device);
+	return device_add(&mcp->attached_device);
 }
-EXPORT_SYMBOL(mcp_host_register);
+EXPORT_SYMBOL(mcp_host_add);
 
-void mcp_host_unregister(struct mcp *mcp)
+void mcp_host_del(struct mcp *mcp)
 {
-	device_unregister(&mcp->attached_device);
+	device_del(&mcp->attached_device);
 }
-EXPORT_SYMBOL(mcp_host_unregister);
+EXPORT_SYMBOL(mcp_host_del);
+
+void mcp_host_free(struct mcp *mcp)
+{
+	put_device(&mcp->attached_device);
+}
+EXPORT_SYMBOL(mcp_host_free);
 
 int mcp_driver_register(struct mcp_driver *mcpdrv)
 {
diff --git a/drivers/mfd/mcp-sa11x0.c b/drivers/mfd/mcp-sa11x0.c
index 02c53a0..33cadc0 100644
--- a/drivers/mfd/mcp-sa11x0.c
+++ b/drivers/mfd/mcp-sa11x0.c
@@ -195,10 +195,11 @@ static int mcp_sa11x0_probe(struct platform_device *pdev)
 	mcp->rw_timeout = (64 * 3 * 1000000 + mcp->sclk_rate - 1) /
 			  mcp->sclk_rate;
 
-	ret = mcp_host_register(mcp);
+	ret = mcp_host_add(mcp);
 	if (ret == 0)
 		goto out;
 
+	mcp_host_free(mcp);
  release:
 	release_mem_region(0x80060000, 0x60);
 	platform_set_drvdata(pdev, NULL);
@@ -212,7 +213,8 @@ static int mcp_sa11x0_remove(struct platform_device *dev)
 	struct mcp *mcp = platform_get_drvdata(dev);
 
 	platform_set_drvdata(dev, NULL);
-	mcp_host_unregister(mcp);
+	mcp_host_del(mcp);
+	mcp_host_free(mcp);
 	release_mem_region(0x80060000, 0x60);
 
 	return 0;
diff --git a/include/linux/mfd/mcp.h b/include/linux/mfd/mcp.h
index f88c1cc..79a6b13 100644
--- a/include/linux/mfd/mcp.h
+++ b/include/linux/mfd/mcp.h
@@ -47,8 +47,9 @@ void mcp_disable(struct mcp *);
 #define mcp_get_sclk_rate(mcp)	((mcp)->sclk_rate)
 
 struct mcp *mcp_host_alloc(struct device *, size_t);
-int mcp_host_register(struct mcp *);
-void mcp_host_unregister(struct mcp *);
+int mcp_host_add(struct mcp *);
+void mcp_host_del(struct mcp *);
+void mcp_host_free(struct mcp *);
 
 struct mcp_driver {
 	struct device_driver drv;
-- 
1.7.4.4
