From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 27 Oct 2012 15:21:35 +0530
Subject: [PATCH V2 1/5] Revert "pinctrl: remove pinctrl_remove_gpio_range"
In-Reply-To: <cover.1351330569.git.viresh.kumar@linaro.org>
References: <cover.1351330569.git.viresh.kumar@linaro.org>
Message-ID: <d08146fb6ea692330a2b0c6a4fe2df75edc0f20e.1351330569.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts earlier commit which removed pinctrl_remove_gpio_range(), because
at that time there aren't any more users of that routine. It was removed as the
removal of ranges was done in unregister of pinctrl.

But because we are registering stuff from gpiolib now, we may remove and insert
a gpio module multiple times. So, we need that again.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---

This is V1 actually. Because it is part of this series, it is marked V2.

 drivers/pinctrl/core.c          | 14 ++++++++++++++
 include/linux/pinctrl/pinctrl.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index cec6072..b1086dc 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -346,6 +346,20 @@ void pinctrl_add_gpio_ranges(struct pinctrl_dev *pctldev,
 EXPORT_SYMBOL_GPL(pinctrl_add_gpio_ranges);
 
 /**
+ * pinctrl_remove_gpio_range() - remove a range of GPIOs fro a pin controller
+ * @pctldev: pin controller device to remove the range from
+ * @range: the GPIO range to remove
+ */
+void pinctrl_remove_gpio_range(struct pinctrl_dev *pctldev,
+			       struct pinctrl_gpio_range *range)
+{
+	mutex_lock(&pinctrl_mutex);
+	list_del(&range->node);
+	mutex_unlock(&pinctrl_mutex);
+}
+EXPORT_SYMBOL_GPL(pinctrl_remove_gpio_range);
+
+/**
  * pinctrl_get_group_selector() - returns the group selector for a group
  * @pctldev: the pin controller handling the group
  * @pin_group: the pin group to look up
diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h
index 7d087f0..eda0467 100644
--- a/include/linux/pinctrl/pinctrl.h
+++ b/include/linux/pinctrl/pinctrl.h
@@ -134,6 +134,8 @@ extern void pinctrl_add_gpio_range(struct pinctrl_dev *pctldev,
 extern void pinctrl_add_gpio_ranges(struct pinctrl_dev *pctldev,
 				struct pinctrl_gpio_range *ranges,
 				unsigned nranges);
+extern void pinctrl_remove_gpio_range(struct pinctrl_dev *pctldev,
+				struct pinctrl_gpio_range *range);
 extern const char *pinctrl_dev_get_name(struct pinctrl_dev *pctldev);
 extern void *pinctrl_dev_get_drvdata(struct pinctrl_dev *pctldev);
 #else
-- 
1.7.12.rc2.18.g61b472e
