From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 17 Apr 2018 17:30:39 -0400
Subject: [net-next PATCH v4 10/13] Revert "net: netcp: remove dead code from
 the driver"
In-Reply-To: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
References: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1524000642-23944-11-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the probe sequence is not guaranteed contrary to the assumption
of the commit 2d8e276a9030, same has to be reverted.

commit 2d8e276a9030 ("net: netcp: remove dead code from the driver")

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/net/ethernet/ti/netcp_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index f5a7eb2..9c51b25 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -2155,6 +2155,7 @@ static int netcp_probe(struct platform_device *pdev)
 	struct device_node *child, *interfaces;
 	struct netcp_device *netcp_device;
 	struct device *dev = &pdev->dev;
+	struct netcp_module *module;
 	int ret;
 
 	if (!node) {
@@ -2203,6 +2204,14 @@ static int netcp_probe(struct platform_device *pdev)
 	/* Add the device instance to the list */
 	list_add_tail(&netcp_device->device_list, &netcp_devices);
 
+	/* Probe & attach any modules already registered */
+	mutex_lock(&netcp_modules_lock);
+	for_each_netcp_module(module) {
+		ret = netcp_module_probe(netcp_device, module);
+		if (ret < 0)
+			dev_err(dev, "module(%s) probe failed\n", module->name);
+	}
+	mutex_unlock(&netcp_modules_lock);
 	return 0;
 
 probe_quit_interface:
-- 
1.9.1
