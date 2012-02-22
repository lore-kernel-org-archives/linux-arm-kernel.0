From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 22 Feb 2012 16:17:13 +0100
Subject: [PATCH v3 02/10] pwm: Allow chips to support multiple PWMs.
In-Reply-To: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1329923841-32017-3-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many PWM controllers provide access to more than a single PWM output and
may even share some resource among them. Allowing a PWM chip to provide
multiple PWM devices enables better sharing of those resources. As a
side-effect this change allows easy integration with the device tree
where a given PWM can be looked up based on the PWM chip's phandle and a
corresponding index.

This commit modifies the PWM core to support multiple PWMs per struct
pwm_chip. It achieves this in a similar way to how gpiolib works, by
allowing PWM ranges to be requested dynamically (pwm_chip.base == -1) or
starting at a given offset (pwm_chip.base >= 0). A chip specifies how
many PWMs it controls using the npwm member. Each of the functions in
the pwm_ops structure gets an additional struct pwm_device * argument
that points to the PWM device that is to be operated on. The per-chip
index of a PWM device is available in the hwpwm field.

The total maximum number of PWM devices is currently fixed to 1024 while
the data is actually stored in a radix tree, thus saving resources if
not all of them are used. The core no longer uses the global namespace,
which is only provided for backwards-compatibility until all PWM API
users are converted to use the PWM framework and request devices using
a per-chip index.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v3:
  - get rid of pwm_desc structure and keep only struct pwm_device
  - keep a list of pwm_chip structures for fast and easy lookup
  - pass struct pwm_device directly to pwm_ops
  - add debugfs file

Changes in v2:
  - add 'struct device *dev' field to pwm_chip, drop label field
  - use radix tree for PWM descriptors
  - add pwm_set_chip_data() and pwm_get_chip_data() functions to allow
    storing and retrieving chip-specific per-PWM data

TODO:
  - we can probably get rid of the chip parameter in PWM ops because it
    is already tracked in struct pwm_device
  - merge with Sascha's patch

 drivers/pwm/core.c  |  301 +++++++++++++++++++++++++++++++++++++++------------
 include/linux/pwm.h |   61 ++++++++---
 2 files changed, 279 insertions(+), 83 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 71de479..d4d2249 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -17,154 +17,247 @@
  *  along with this program; see the file COPYING.  If not, write to
  *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
 #include <linux/module.h>
+#include <linux/of_pwm.h>
 #include <linux/pwm.h>
+#include <linux/radix-tree.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/device.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
 
-struct pwm_device {
-	struct			pwm_chip *chip;
-	const char		*label;
-	unsigned long		flags;
-#define FLAG_REQUESTED	0
-#define FLAG_ENABLED	1
-	struct list_head	node;
-};
-
-static LIST_HEAD(pwm_list);
+#define MAX_PWMS 1024
 
 static DEFINE_MUTEX(pwm_lock);
+static LIST_HEAD(pwm_chips);
+static DECLARE_BITMAP(allocated_pwms, MAX_PWMS);
+static RADIX_TREE(pwm_tree, GFP_KERNEL);
 
-static struct pwm_device *_find_pwm(int pwm_id)
+static struct pwm_device *pwm_to_device(unsigned int pwm)
 {
-	struct pwm_device *pwm;
+	return radix_tree_lookup(&pwm_tree, pwm);
+}
+
+static int alloc_pwms(int pwm, unsigned int count)
+{
+	unsigned int from = 0;
+	unsigned int start;
 
-	list_for_each_entry(pwm, &pwm_list, node) {
-		if (pwm->chip->pwm_id == pwm_id)
-			return pwm;
+	if (pwm >= MAX_PWMS)
+		return -EINVAL;
+
+	if (pwm >= 0)
+		from = pwm;
+
+	start = bitmap_find_next_zero_area(allocated_pwms, MAX_PWMS, from,
+					   count, 0);
+
+	if (pwm >= 0 && start != pwm)
+		return -EEXIST;
+
+	if (start + count > MAX_PWMS)
+		return -ENOSPC;
+
+	return start;
+}
+
+static void free_pwms(struct pwm_chip *chip)
+{
+	unsigned int i;
+
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
+		radix_tree_delete(&pwm_tree, pwm->pwm);
 	}
 
-	return NULL;
+	bitmap_clear(allocated_pwms, chip->base, chip->npwm);
+
+	kfree(chip->pwms);
+	chip->pwms = NULL;
+}
+
+/**
+ * pwm_set_chip_data - set private chip data for a PWM
+ * @pwm: PWM device
+ * @data: pointer to chip-specific data
+ */
+int pwm_set_chip_data(struct pwm_device *pwm, void *data)
+{
+	if (!pwm)
+		return -EINVAL;
+
+	pwm->chip_data = data;
+
+	return 0;
 }
 
 /**
- * pwmchip_add() - register a new pwm
- * @chip: the pwm
+ * pwm_get_chip_data - get private chip data for a PWM
+ * @pwm: PWM device
+ */
+void *pwm_get_chip_data(struct pwm_device *pwm)
+{
+	return pwm ? pwm->chip_data : NULL;
+}
+
+/**
+ * pwmchip_add() - register a new PWM chip
+ * @chip: the PWM chip to add
  *
- * register a new pwm. pwm->pwm_id must be initialized. if pwm_id < 0 then
- * a dynamically assigned id will be used, otherwise the id specified,
+ * Register a new PWM chip. If chip->base < 0 then a dynamically assigned base
+ * will be used.
  */
 int pwmchip_add(struct pwm_chip *chip)
 {
 	struct pwm_device *pwm;
-	int ret = 0;
+	unsigned int i;
+	int ret;
 
-	pwm = kzalloc(sizeof(*pwm), GFP_KERNEL);
-	if (!pwm)
+	mutex_lock(&pwm_lock);
+
+	ret = alloc_pwms(chip->base, chip->npwm);
+	if (ret < 0)
+		goto out;
+
+	chip->pwms = kzalloc(chip->npwm * sizeof(*pwm), GFP_KERNEL);
+	if (!chip->pwms)
 		return -ENOMEM;
 
-	pwm->chip = chip;
+	chip->base = ret;
 
-	mutex_lock(&pwm_lock);
+	for (i = 0; i < chip->npwm; i++) {
+		pwm = &chip->pwms[i];
 
-	if (chip->pwm_id >= 0 && _find_pwm(chip->pwm_id)) {
-		ret = -EBUSY;
-		goto out;
+		pwm->chip = chip;
+		pwm->pwm = chip->base + i;
+		pwm->hwpwm = i;
+
+		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
 	}
 
-	list_add_tail(&pwm->node, &pwm_list);
-out:
-	mutex_unlock(&pwm_lock);
+	bitmap_set(allocated_pwms, chip->base, chip->npwm);
 
-	if (ret)
-		kfree(pwm);
+	INIT_LIST_HEAD(&chip->list);
+	list_add(&chip->list, &pwm_chips);
+	of_pwmchip_add(chip);
 
+out:
+	mutex_unlock(&pwm_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pwmchip_add);
 
 /**
- * pwmchip_remove() - remove a pwm
- * @chip: the pwm
+ * pwmchip_remove() - remove a PWM chip
+ * @chip: the PWM chip to remove
  *
- * remove a pwm. This function may return busy if the pwm is still requested.
+ * Removes a PWM chip. This function may return busy if the PWM chip provides
+ * a PWM device that is still requested.
  */
 int pwmchip_remove(struct pwm_chip *chip)
 {
-	struct pwm_device *pwm;
+	unsigned int i;
 	int ret = 0;
 
 	mutex_lock(&pwm_lock);
 
-	pwm = _find_pwm(chip->pwm_id);
-	if (!pwm) {
-		ret = -ENOENT;
-		goto out;
-	}
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
 
-	if (test_bit(FLAG_REQUESTED, &pwm->flags)) {
-		ret = -EBUSY;
-		goto out;
+		if (test_bit(PWMF_REQUESTED, &pwm->flags)) {
+			ret = -EBUSY;
+			goto out;
+		}
 	}
 
-	list_del(&pwm->node);
+	list_del_init(&chip->list);
+	of_pwmchip_remove(chip);
+	free_pwms(chip);
 
-	kfree(pwm);
 out:
 	mutex_unlock(&pwm_lock);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
+/**
+ * pwmchip_find() - iterator for locating a specific pwm_chip
+ * @data: data to pass to match function
+ * @match: callback function to check pwm_chip
+ */
+struct pwm_chip *pwmchip_find(void *data, int (*match)(struct pwm_chip *chip,
+						       void *data))
+{
+	struct pwm_chip *ret = NULL;
+	struct pwm_chip *chip;
+
+	mutex_lock(&pwm_lock);
+
+	list_for_each_entry(chip, &pwm_chips, list) {
+		if (match(chip, data)) {
+			ret = chip;
+			break;
+		}
+	}
+
+	mutex_unlock(&pwm_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pwmchip_find);
+
 /*
  * pwm_request - request a PWM device
  */
-struct pwm_device *pwm_request(int pwm_id, const char *label)
+struct pwm_device *pwm_request(int pwm, const char *label)
 {
-	struct pwm_device *pwm;
+	struct pwm_device *dev;
 	int ret;
 
+	if (pwm < 0 || pwm >= MAX_PWMS)
+		return ERR_PTR(-EINVAL);
+
 	mutex_lock(&pwm_lock);
 
-	pwm = _find_pwm(pwm_id);
-	if (!pwm) {
-		pwm = ERR_PTR(-ENOENT);
+	dev = pwm_to_device(pwm);
+	if (!dev) {
+		dev = ERR_PTR(-ENODEV);
 		goto out;
 	}
 
-	if (test_bit(FLAG_REQUESTED, &pwm->flags)) {
-		pwm = ERR_PTR(-EBUSY);
+	if (test_bit(PWMF_REQUESTED, &dev->flags)) {
+		dev = ERR_PTR(-EBUSY);
 		goto out;
 	}
 
-	if (!try_module_get(pwm->chip->ops->owner)) {
-		pwm = ERR_PTR(-ENODEV);
+	if (!try_module_get(dev->chip->ops->owner)) {
+		dev = ERR_PTR(-ENODEV);
 		goto out;
 	}
 
-	if (pwm->chip->ops->request) {
-		ret = pwm->chip->ops->request(pwm->chip);
+	if (dev->chip->ops->request) {
+		ret = dev->chip->ops->request(dev->chip, dev);
 		if (ret) {
-			pwm = ERR_PTR(ret);
+			dev = ERR_PTR(ret);
 			goto out_put;
 		}
 	}
 
-	pwm->label = label;
-	set_bit(FLAG_REQUESTED, &pwm->flags);
+	set_bit(PWMF_REQUESTED, &dev->flags);
+	dev->label = label;
 
 	goto out;
 
 out_put:
-	module_put(pwm->chip->ops->owner);
+	module_put(dev->chip->ops->owner);
 out:
 	mutex_unlock(&pwm_lock);
 
-	return pwm;
+	return dev;
 }
 EXPORT_SYMBOL_GPL(pwm_request);
 
@@ -175,11 +268,14 @@ void pwm_free(struct pwm_device *pwm)
 {
 	mutex_lock(&pwm_lock);
 
-	if (!test_and_clear_bit(FLAG_REQUESTED, &pwm->flags)) {
+	if (!test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
 		pr_warning("PWM device already freed\n");
 		goto out;
 	}
 
+	if (pwm->chip->ops->free)
+		pwm->chip->ops->free(pwm->chip, pwm);
+
 	pwm->label = NULL;
 
 	module_put(pwm->chip->ops->owner);
@@ -193,7 +289,7 @@ EXPORT_SYMBOL_GPL(pwm_free);
  */
 int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 {
-	return pwm->chip->ops->config(pwm->chip, duty_ns, period_ns);
+	return pwm->chip->ops->config(pwm->chip, pwm, duty_ns, period_ns);
 }
 EXPORT_SYMBOL_GPL(pwm_config);
 
@@ -202,8 +298,8 @@ EXPORT_SYMBOL_GPL(pwm_config);
  */
 int pwm_enable(struct pwm_device *pwm)
 {
-	if (!test_and_set_bit(FLAG_ENABLED, &pwm->flags))
-		return pwm->chip->ops->enable(pwm->chip);
+	if (!test_and_set_bit(PWMF_ENABLED, &pwm->flags))
+		return pwm->chip->ops->enable(pwm->chip, pwm);
 
 	return 0;
 }
@@ -214,7 +310,72 @@ EXPORT_SYMBOL_GPL(pwm_enable);
  */
 void pwm_disable(struct pwm_device *pwm)
 {
-	if (test_and_clear_bit(FLAG_ENABLED, &pwm->flags))
-		pwm->chip->ops->disable(pwm->chip);
+	if (test_and_clear_bit(PWMF_ENABLED, &pwm->flags))
+		pwm->chip->ops->disable(pwm->chip, pwm);
 }
 EXPORT_SYMBOL_GPL(pwm_disable);
+
+#ifdef CONFIG_DEBUG_FS
+static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
+{
+	unsigned int i;
+
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
+
+		seq_printf(s, " pwm-%-3d (%-20.20s):", i, pwm->label);
+
+		if (test_bit(PWMF_REQUESTED, &pwm->flags))
+			seq_printf(s, " requested");
+
+		if (test_bit(PWMF_ENABLED, &pwm->flags))
+			seq_printf(s, " enabled");
+
+		seq_printf(s, "\n");
+	}
+}
+
+static int pwm_show(struct seq_file *s, void *unused)
+{
+	const char *prefix = "";
+	struct pwm_chip *chip;
+
+	list_for_each_entry(chip, &pwm_chips, list) {
+		struct device *dev = chip->dev;
+
+		seq_printf(s, "%s%s/%s, %d PWM devices\n", prefix,
+			   dev->bus ? dev->bus->name : "no-bus",
+			   dev_name(dev), chip->npwm);
+
+		if (chip->ops->dbg_show)
+			chip->ops->dbg_show(chip, s);
+		else
+			pwm_dbg_show(chip, s);
+
+		prefix = "\n";
+	}
+
+	return 0;
+}
+
+static int pwm_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, pwm_show, NULL);
+}
+
+static const struct file_operations pwm_ops = {
+	.open = pwm_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int __init pwm_debugfs_init(void)
+{
+	debugfs_create_file("pwm", S_IFREG | S_IRUGO, NULL, NULL, &pwm_ops);
+
+	return 0;
+}
+
+subsys_initcall(pwm_debugfs_init);
+#endif /* CONFIG_DEBUG_FS */
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index df9681b..b00a91f 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -31,38 +31,73 @@ void pwm_disable(struct pwm_device *pwm);
 #ifdef CONFIG_PWM
 struct pwm_chip;
 
+enum {
+	PWMF_REQUESTED = 1 << 0,
+	PWMF_ENABLED = 1 << 1,
+};
+
+struct pwm_device {
+	const char		*label;
+	unsigned long		flags;
+	unsigned int		hwpwm;
+	unsigned int		pwm;
+	struct pwm_chip		*chip;
+	void			*chip_data;
+};
+
 /**
- * struct pwm_ops - PWM operations
+ * struct pwm_ops - PWM controller operations
  * @request: optional hook for requesting a PWM
  * @free: optional hook for freeing a PWM
  * @config: configure duty cycles and period length for this PWM
  * @enable: enable PWM output toggling
  * @disable: disable PWM output toggling
+ * @dbg_show: optional routine to show contents in debugfs
+ * @owner: helps prevent removal of modules exporting active PWMs
  */
 struct pwm_ops {
-	int			(*request)(struct pwm_chip *chip);
-	void			(*free)(struct pwm_chip *chip);
-	int			(*config)(struct pwm_chip *chip, int duty_ns,
-						int period_ns);
-	int			(*enable)(struct pwm_chip *chip);
-	void			(*disable)(struct pwm_chip *chip);
+	int			(*request)(struct pwm_chip *chip,
+					   struct pwm_device *pwm);
+	void			(*free)(struct pwm_chip *chip,
+					struct pwm_device *pwm);
+	int			(*config)(struct pwm_chip *chip,
+					  struct pwm_device *pwm,
+					  int duty_ns, int period_ns);
+	int			(*enable)(struct pwm_chip *chip,
+					  struct pwm_device *pwm);
+	void			(*disable)(struct pwm_chip *chip,
+					   struct pwm_device *pwm);
+#ifdef CONFIG_DEBUG_FS
+	void			(*dbg_show)(struct pwm_chip *chip,
+					    struct seq_file *s);
+#endif
 	struct module		*owner;
 };
 
 /**
- * struct pwm_chip - abstract a PWM
- * @label: for diagnostics
- * @owner: helps prevent removal of modules exporting active PWMs
- * @ops: The callbacks for this PWM
+ * struct pwm_chip - abstract a PWM controller
+ * @dev: device providing the PWMs
+ * @ops: callbacks for this PWM controller
+ * @base: number of first PWM controlled by this chip
+ * @npwm: number of PWMs controlled by this chip
  */
 struct pwm_chip {
-	int			pwm_id;
-	const char		*label;
+	struct device		*dev;
+	struct list_head	list;
 	struct pwm_ops		*ops;
+	int			base;
+	unsigned int		npwm;
+
+	struct pwm_device	*pwms;
 };
 
+int pwm_set_chip_data(struct pwm_device *pwm, void *data);
+void *pwm_get_chip_data(struct pwm_device *pwm);
+
 int pwmchip_add(struct pwm_chip *chip);
 int pwmchip_remove(struct pwm_chip *chip);
+struct pwm_chip *pwmchip_find(void *data, int (*match)(struct pwm_chip *chip,
+						       void *data));
 #endif
 
 #endif /* __LINUX_PWM_H */
-- 
1.7.9.1
