From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jul 2016 17:19:26 +0100
Subject: [PATCH 1/2] driver-core: Add externally callable function to trigger
 deferred probes
In-Reply-To: <20160712161927.7521-1-lee.jones@linaro.org>
References: <20160712161927.7521-1-lee.jones@linaro.org>
Message-ID: <20160712161927.7521-2-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Deferred probes are currently only re-executed if new drivers are successfully
registered and probed.  Drivers which defer their probes based on things like
missing firmware located on rootfs will sometimes only be re-probed if kernel
modules are found.  Unfortunately, this is fragile and can not be guaranteed
or relied upon.  This call allows us to trigger probe re-execution at any
point during boot.  For instance after rootfs is mounted in order to collect
firmwares in rootfs.

Tested-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/base/dd.c      | 8 ++++++++
 include/linux/device.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 16688f5..ab20851 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -203,6 +203,14 @@ void device_unblock_probing(void)
 }
 
 /**
+ * deferred_probe_tigger() - Trigger a deferred probe
+ */
+void deferred_probe_trigger(void)
+{
+	driver_deferred_probe_trigger();
+}
+
+/**
  * deferred_probe_initcall() - Enable probing of deferred devices
  *
  * We don't want to get in the way when the bulk of drivers are getting probed.
diff --git a/include/linux/device.h b/include/linux/device.h
index 38f0281..d441471 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -293,6 +293,7 @@ extern struct device_driver *driver_find(const char *name,
 					 struct bus_type *bus);
 extern int driver_probe_done(void);
 extern void wait_for_device_probe(void);
+extern void deferred_probe_trigger(void);
 
 
 /* sysfs interface for exporting driver attributes */
-- 
2.9.0
