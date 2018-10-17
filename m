From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 17 Oct 2018 15:22:05 +0200
Subject: [PATCH v3 1/4] driver core: add probe_err log helper
In-Reply-To: <CAHp75Vd1JQVx96FLEtTO7a7-OBaC1nUKcoSk4S6wvO6BtjJ-3w@mail.gmail.com>
References: <CAHp75Vd1JQVx96FLEtTO7a7-OBaC1nUKcoSk4S6wvO6BtjJ-3w@mail.gmail.com>
 <CGME20181017132209eucas1p1d23615adc15663caaffb3c117dc61151@eucas1p1.samsung.com>
Message-ID: <20181017132205.5204-1-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During probe every time driver gets resource it should usually check for error
printk some message if it is not -EPROBE_DEFER and return the error. This
pattern is simple but requires adding few lines after any resource acquisition
code, as a result it is often omited or implemented only partially.
probe_err helps to replace such code sequences with simple call, so code:
	if (err != -EPROBE_DEFER)
		dev_err(dev, ...);
	return err;
becomes:
	return probe_err(dev, err, ...);

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
v3:
  - added 'extern __printf(3, 4)' decorators to probe_err,
  - changed error logging format - newline at the end,
  - added empty lines in probe_err around dev_err,
  - added R-b by Mark and Andy.
v2:
  - added error value to log message,
  - fixed code style,
  - added EXPORT_SYMBOL_GPL,
  - Added R-B by Javier (I hope the changes did not invalidate it).
---
 drivers/base/core.c    | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |  3 +++
 2 files changed, 42 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 04bbcd779e11..1f3e99c2ef03 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3067,6 +3067,45 @@ define_dev_printk_level(_dev_info, KERN_INFO);
 
 #endif
 
+/**
+ * probe_err - probe error check and log helper
+ * @dev: the pointer to the struct device
+ * @err: error value to test
+ * @fmt: printf-style format string
+ * @...: arguments as specified in the format string
+ *
+ * This helper implements common pattern present in probe functions for error
+ * checking: print message if the error is not -EPROBE_DEFER and propagate it.
+ * It replaces code sequence:
+ * 	if (err != -EPROBE_DEFER)
+ * 		dev_err(dev, ...);
+ * 	return err;
+ * with
+ * 	return probe_err(dev, err, ...);
+ *
+ * Returns @err.
+ *
+ */
+int probe_err(const struct device *dev, int err, const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	if (err == -EPROBE_DEFER)
+		return err;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	dev_err(dev, "error %d: %pV", err, &vaf);
+
+	va_end(args);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(probe_err);
+
 static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
 {
 	return fwnode && !IS_ERR(fwnode->secondary);
diff --git a/include/linux/device.h b/include/linux/device.h
index 90224e75ade4..6831677d5278 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1577,6 +1577,9 @@ do {									\
 	WARN_ONCE(condition, "%s %s: " format, \
 			dev_driver_string(dev), dev_name(dev), ## arg)
 
+extern __printf(3, 4)
+int probe_err(const struct device *dev, int err, const char *fmt, ...);
+
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
 	MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
-- 
2.18.0
