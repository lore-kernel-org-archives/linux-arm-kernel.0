From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu,  6 Aug 2015 16:11:38 +0200
Subject: [PATCH v3 01/18] platform: delay OF device-driver matches until
 late_initcall
In-Reply-To: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1438870315-18689-2-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Delay matches of platform devices with OF nodes until late_initcall,
when we are sure that all built-in drivers have been registered already.
This is needed to prevent deferred probes because of some drivers not
having registered yet.

The reason why only platform devices are delayed is that some other
devices are expected to be probed earlier than late_initcall, for
example, the system PNP driver needs to probe its devices in
fs_initcall.

Additionally, only platform devices with OF nodes are delayed because
some machines may depend on oter platform devices being registered at
specific times.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v3:
- Only delay platform devices with OF nodes

Changes in v2:
- Move delay to platform.c

 drivers/base/platform.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 063f0ab15259..0848ece2bf9d 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -33,6 +33,8 @@
 /* For automatically allocated device IDs */
 static DEFINE_IDA(platform_devid_ida);
 
+static bool enable_matches;
+
 struct device platform_bus = {
 	.init_name	= "platform",
 };
@@ -839,6 +841,15 @@ static int platform_match(struct device *dev, struct device_driver *drv)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct platform_driver *pdrv = to_platform_driver(drv);
 
+	/*
+	 * Delay matches of OF platform devices until late_initcall, when we
+	 * are sure that all built-in drivers have been registered already.
+	 * This is needed to prevent deferred probes because of some drivers
+	 * not having registered yet.
+	 */
+	if (dev->of_node && !enable_matches)
+		return 0;
+
 	/* When driver_override is set, only bind to the matching driver */
 	if (pdev->driver_override)
 		return !strcmp(pdev->driver_override, drv->name);
@@ -859,6 +870,24 @@ static int platform_match(struct device *dev, struct device_driver *drv)
 	return (strcmp(pdev->name, drv->name) == 0);
 }
 
+static int __probe_device(struct device *dev, void *data)
+{
+	if (dev->of_node)
+		device_initial_probe(dev);
+
+	return 0;
+}
+
+static int probe_delayed_matches_initcall(void)
+{
+	enable_matches = true;
+
+	bus_for_each_dev(&platform_bus_type, NULL, NULL, __probe_device);
+
+	return 0;
+}
+late_initcall(probe_delayed_matches_initcall);
+
 #ifdef CONFIG_PM_SLEEP
 
 static int platform_legacy_suspend(struct device *dev, pm_message_t mesg)
-- 
2.4.3
