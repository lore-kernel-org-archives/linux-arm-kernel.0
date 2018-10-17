From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 17 Oct 2018 10:58:24 +0200
Subject: [PATCH v2 1/3] driver core: add probe_err log helper
In-Reply-To: <CAHp75VecquoNrzOuRvWcZ-Qa1b-5P0V0MWq=sNj-SnVcd2EhRw@mail.gmail.com>
References: <CAHp75VecquoNrzOuRvWcZ-Qa1b-5P0V0MWq=sNj-SnVcd2EhRw@mail.gmail.com>
 <CGME20181017085832eucas1p23dbb86230149a13634b8a091c3b1301f@eucas1p2.samsung.com>
Message-ID: <20181017085824.30806-1-a.hajda@samsung.com>
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

---
v2:
  - added error value to log message,
  - fixed code style,
  - added EXPORT_SYMBOL_GPL,
  - Added R-B by Javier (I hope the changes did not invalidate it).
---
 drivers/base/core.c    | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/device.h |  2 ++
 2 files changed, 39 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 04bbcd779e11..aa6f3229d066 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3067,6 +3067,43 @@ define_dev_printk_level(_dev_info, KERN_INFO);
 
 #endif
 
+/**
+ * probe_err - probe error check and log helper
+ * @dev: the pointer to the struct device
+ * @err: error value to test
+ * @fmt: printf-style format string, not ended with newline
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
+	dev_err(dev, "%pV, %d\n", &vaf, err);
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
index 90224e75ade4..06c2c797d132 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1577,6 +1577,8 @@ do {									\
 	WARN_ONCE(condition, "%s %s: " format, \
 			dev_driver_string(dev), dev_name(dev), ## arg)
 
+int probe_err(const struct device *dev, int err, const char *fmt, ...);
+
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
 	MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
-- 
2.18.0
