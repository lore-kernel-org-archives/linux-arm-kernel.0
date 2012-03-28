From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 28 Mar 2012 16:33:46 +0200
Subject: [PATCH v5 04/16] pwm: Add table-based lookup for static mappings
In-Reply-To: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1332945238-14897-5-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to get rid of the global namespace for PWM devices, this commit
provides an alternative method, similar to that of the regulator or
clock frameworks, for registering a static mapping for PWM devices. This
works by providing a table with a provider/consumer map in the board
setup code.

With the new pwm_get() and pwm_put() functions available, usage of
pwm_request() and pwm_free() becomes deprecated.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v5:
- new patch with table-based lookup for statically registered devices
- update Documentation/pwm.txt

 Documentation/pwm.txt |   27 +++++++--
 drivers/pwm/core.c    |  152 ++++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/pwm.h   |   20 +++++++
 3 files changed, 180 insertions(+), 19 deletions(-)

diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 48f598a..bb3d2f9 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -12,14 +12,33 @@ this kind of flexibility the generic PWM API exists.
 Identifying PWMs
 ----------------
 
-Users of the legacy PWM API use unique IDs to refer to PWM devices. One
-goal of the new PWM framework is to get rid of this global namespace.
+Users of the legacy PWM API use unique IDs to refer to PWM devices.
+
+Instead of referring to a PWM device via its unique ID, board setup code
+should instead register a static mapping that can be used to match PWM
+consumers to providers, as given in the following example:
+
+	static struct pwm_lookup board_pwm_lookup[] = {
+		PWM_LOOKUP("tegra-pwm", 0, "pwm-backlight"),
+	};
+
+	static void __init board_init(void)
+	{
+		...
+		pwm_add_table(board_pwm_lookup, ARRAY_SIZE(board_pwm_lookup));
+		...
+	}
 
 Using PWMs
 ----------
 
-A PWM can be requested using pwm_request() and freed after usage with
-pwm_free(). After being requested a PWM has to be configured using
+Legacy users can request a PWM device using pwm_request() and free it
+after usage with pwm_free().
+
+New users should use the pwm_get() function and pass to it the consumer
+device or a consumer name. pwm_put() is used to free the PWM device.
+
+After being requested a PWM has to be configured using:
 
 int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns);
 
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 12a643d..77961e0 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -32,6 +32,8 @@
 
 #define MAX_PWMS 1024
 
+static DEFINE_MUTEX(pwm_lookup_lock);
+static LIST_HEAD(pwm_lookup_list);
 static DEFINE_MUTEX(pwm_lock);
 static LIST_HEAD(pwm_chips);
 static DECLARE_BITMAP(allocated_pwms, MAX_PWMS);
@@ -80,6 +82,29 @@ static void free_pwms(struct pwm_chip *chip)
 	chip->pwms = NULL;
 }
 
+static struct pwm_chip *pwmchip_find_by_name(const char *name)
+{
+	struct pwm_chip *chip;
+
+	if (!name)
+		return NULL;
+
+	mutex_lock(&pwm_lock);
+
+	list_for_each_entry(chip, &pwm_chips, list) {
+		const char *chip_name = dev_name(chip->dev);
+
+		if (chip_name && strcmp(chip_name, name) == 0) {
+			mutex_unlock(&pwm_lock);
+			return chip;
+		}
+	}
+
+	mutex_unlock(&pwm_lock);
+
+	return NULL;
+}
+
 static int pwm_device_request(struct pwm_device *pwm, const char *label)
 {
 	int err;
@@ -214,6 +239,8 @@ EXPORT_SYMBOL_GPL(pwmchip_remove);
  * pwm_request() - request a PWM device
  * @pwm: global PWM device index
  * @label: PWM device label
+ *
+ * This function is deprecated, use pwm_get() instead.
  */
 struct pwm_device *pwm_request(int pwm, const char *label)
 {
@@ -277,24 +304,12 @@ EXPORT_SYMBOL_GPL(pwm_request_from_chip);
 /**
  * pwm_free() - free a PWM device
  * @pwm: PWM device
+ *
+ * This function is deprecated, use pwm_put() instead.
  */
 void pwm_free(struct pwm_device *pwm)
 {
-	mutex_lock(&pwm_lock);
-
-	if (!test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
-		pr_warning("PWM device already freed\n");
-		goto out;
-	}
-
-	if (pwm->chip->ops->free)
-		pwm->chip->ops->free(pwm->chip, pwm);
-
-	pwm->label = NULL;
-
-	module_put(pwm->chip->ops->owner);
-out:
-	mutex_unlock(&pwm_lock);
+	pwm_put(pwm);
 }
 EXPORT_SYMBOL_GPL(pwm_free);
 
@@ -337,6 +352,113 @@ void pwm_disable(struct pwm_device *pwm)
 }
 EXPORT_SYMBOL_GPL(pwm_disable);
 
+/**
+ * pwm_add_table() - register PWM device consumers
+ * @table: array of consumers to register
+ * @num: number of consumers in table
+ */
+void __init pwm_add_table(struct pwm_lookup *table, size_t num)
+{
+	mutex_lock(&pwm_lookup_lock);
+
+	while (num--) {
+		if (table->provider && table->consumer)
+			list_add_tail(&table->list, &pwm_lookup_list);
+		else
+			pr_err("%s(): provider/consumer must be specified\n",
+			       __func__);
+
+		table++;
+	}
+
+	mutex_unlock(&pwm_lookup_lock);
+}
+
+/**
+ * pwm_get() - look up and request a PWM device
+ * @dev: device for PWM consumer
+ * @provider: name of provider PWM chip
+ * @index: per-chip index of PWM to request
+ *
+ * Look up a PWM chip and a relative index via a table supplied by board setup
+ * code (see pwm_add_table()).
+ *
+ * Once a PWM chip has been found the specified PWM device will be requested
+ * and is ready to be used.
+ */
+struct pwm_device *pwm_get(struct device *dev, const char *consumer)
+{
+	const char *device_name = dev ? dev_name(dev): NULL;
+	struct pwm_device *pwm = ERR_PTR(-EPROBE_DEFER);
+	struct pwm_chip *chip = NULL;
+	struct pwm_lookup *p;
+	unsigned int index;
+
+	/*
+	 * We look up the provider in the static table typically provided by
+	 * board setup code. We first try to lookup the consumer device by
+	 * name. If the consumer device was passed in as NULL or if no match
+	 * was found, we try to find the consumer by directly looking it up
+	 * by name.
+	 *
+	 * If a match is found, the provider PWM chip is looked up by name
+	 * and a PWM device is requested using the PWM device per-chip index.
+	 */
+	mutex_lock(&pwm_lookup_lock);
+
+	if (device_name)
+		list_for_each_entry(p, &pwm_lookup_list, list)
+			if (strcmp(p->consumer, device_name) == 0) {
+				chip = pwmchip_find_by_name(p->provider);
+				consumer = device_name;
+				index = p->index;
+				break;
+			}
+
+	if (!chip && consumer)
+		list_for_each_entry(p, &pwm_lookup_list, list)
+			if (strcmp(p->consumer, consumer) == 0) {
+				chip = pwmchip_find_by_name(p->provider);
+				index = p->index;
+				break;
+			}
+
+	if (chip)
+		pwm = pwm_request_from_chip(chip, index, consumer);
+
+	mutex_unlock(&pwm_lookup_lock);
+
+	return pwm;
+}
+EXPORT_SYMBOL_GPL(pwm_get);
+
+/**
+ * pwm_put() - release a PWM device
+ * @pwm: PWM device
+ */
+void pwm_put(struct pwm_device *pwm)
+{
+	if (!pwm)
+		return;
+
+	mutex_lock(&pwm_lock);
+
+	if (!test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
+		pr_warning("PWM device already freed\n");
+		goto out;
+	}
+
+	if (pwm->chip->ops->free)
+		pwm->chip->ops->free(pwm->chip, pwm);
+
+	pwm->label = NULL;
+
+	module_put(pwm->chip->ops->owner);
+out:
+	mutex_unlock(&pwm_lock);
+}
+EXPORT_SYMBOL_GPL(pwm_put);
+
 #ifdef CONFIG_DEBUG_FS
 static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 {
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 047cd53..a32d2b7 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -115,6 +115,26 @@ int pwmchip_remove(struct pwm_chip *chip);
 struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 					 unsigned int index,
 					 const char *label);
+
+struct pwm_device *pwm_get(struct device *dev, const char *consumer);
+void pwm_put(struct pwm_device *pwm);
+
+struct pwm_lookup {
+	struct list_head list;
+	const char *provider;
+	unsigned int index;
+	const char *consumer;
+};
+
+#define PWM_LOOKUP(_provider, _index, _consumer)	\
+	{						\
+		.provider = _provider,			\
+		.index = _index,			\
+		.consumer = _consumer,			\
+	}
+
+void pwm_add_table(struct pwm_lookup *table, size_t num);
+
 #endif
 
 #endif /* __LINUX_PWM_H */
-- 
1.7.9.4
