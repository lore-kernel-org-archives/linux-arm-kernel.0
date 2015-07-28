From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 28 Jul 2015 15:19:32 +0200
Subject: [PATCH v2 01/22] platform: delay device-driver matches until
 late_initcall
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1438089593-7696-2-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Delay matches of platform devices until late_initcall, when we are sure
that all built-in drivers have been registered already.  This is needed
to prevent deferred probes because of some drivers not having registered
yet.

The reason why only platform devices are delayed is that some other
devices are expected to be probed earlier than late_initcall, for
example, the system PNP driver needs to probe its devices in
fs_initcall.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2:
- Move delay to platform.c

 drivers/base/platform.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 063f0ab15259..fcf654678e27 100644
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
+	 * Delay matches of platform devices until late_initcall, when we are
+	 * sure that all built-in drivers have been registered already. This
+	 * is needed to prevent deferred probes because of some drivers
+	 * not having registered yet.
+	 */
+	if (!enable_matches)
+		return false;
+
 	/* When driver_override is set, only bind to the matching driver */
 	if (pdev->driver_override)
 		return !strcmp(pdev->driver_override, drv->name);
@@ -859,6 +870,23 @@ static int platform_match(struct device *dev, struct device_driver *drv)
 	return (strcmp(pdev->name, drv->name) == 0);
 }
 
+static int __probe_device(struct device *dev, void *data)
+{
+	device_initial_probe(dev);
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
