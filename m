From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Dec 2016 15:07:04 +0100
Subject: [PATCH] pinctrl: stricten up generic group code
Message-ID: <20161230140704.13875-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename the symbol PINCTRL_GENERIC to PINCTRL_GENERIC_GROUPS since
it all pertains to groups. Replace everywhere.

ifdef out the radix tree and the struct when not using the
generic groups.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/Kconfig |  2 +-
 drivers/pinctrl/core.c  |  6 ++++--
 drivers/pinctrl/core.h  | 32 +++++++++++++++++---------------
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index b986998409d1..add257f80d76 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -8,7 +8,7 @@ config PINCTRL
 menu "Pin controllers"
 	depends on PINCTRL
 
-config GENERIC_PINCTRL
+config GENERIC_PINCTRL_GROUPS
 	bool
 
 config PINMUX
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 7b7d706f869c..736149d3a33d 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -540,7 +540,7 @@ void pinctrl_remove_gpio_range(struct pinctrl_dev *pctldev,
 }
 EXPORT_SYMBOL_GPL(pinctrl_remove_gpio_range);
 
-#ifdef CONFIG_GENERIC_PINCTRL
+#ifdef CONFIG_GENERIC_PINCTRL_GROUPS
 
 /**
  * pinctrl_generic_get_group_count() - returns the number of pin groups
@@ -714,7 +714,7 @@ static void pinctrl_generic_free_groups(struct pinctrl_dev *pctldev)
 static inline void pinctrl_generic_free_groups(struct pinctrl_dev *pctldev)
 {
 }
-#endif /* CONFIG_GENERIC_PINCTRL */
+#endif /* CONFIG_GENERIC_PINCTRL_GROUPS */
 
 /**
  * pinctrl_get_group_selector() - returns the group selector for a group
@@ -1993,7 +1993,9 @@ struct pinctrl_dev *pinctrl_register(struct pinctrl_desc *pctldesc,
 	pctldev->desc = pctldesc;
 	pctldev->driver_data = driver_data;
 	INIT_RADIX_TREE(&pctldev->pin_desc_tree, GFP_KERNEL);
+#ifdef CONFIG_GENERIC_PINCTRL_GROUPS
 	INIT_RADIX_TREE(&pctldev->pin_group_tree, GFP_KERNEL);
+#endif
 	INIT_LIST_HEAD(&pctldev->gpio_ranges);
 	INIT_DELAYED_WORK(&pctldev->late_init, pinctrl_late_init);
 	pctldev->dev = dev;
diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
index af98b6313902..b04c59bf9701 100644
--- a/drivers/pinctrl/core.h
+++ b/drivers/pinctrl/core.h
@@ -43,8 +43,10 @@ struct pinctrl_dev {
 	struct list_head node;
 	struct pinctrl_desc *desc;
 	struct radix_tree_root pin_desc_tree;
+#ifdef CONFIG_GENERIC_PINCTRL_GROUPS
 	struct radix_tree_root pin_group_tree;
 	unsigned int num_groups;
+#endif
 	struct list_head gpio_ranges;
 	struct device *dev;
 	struct module *owner;
@@ -166,6 +168,20 @@ struct pin_desc {
 };
 
 /**
+ * struct pinctrl_maps - a list item containing part of the mapping table
+ * @node: mapping table list node
+ * @maps: array of mapping table entries
+ * @num_maps: the number of entries in @maps
+ */
+struct pinctrl_maps {
+	struct list_head node;
+	struct pinctrl_map const *maps;
+	unsigned num_maps;
+};
+
+#ifdef CONFIG_GENERIC_PINCTRL_GROUPS
+
+/**
  * struct group_desc - generic pin group descriptor
  * @name: name of the pin group
  * @pins: array of pins that belong to the group
@@ -179,20 +195,6 @@ struct group_desc {
 	void *data;
 };
 
-/**
- * struct pinctrl_maps - a list item containing part of the mapping table
- * @node: mapping table list node
- * @maps: array of mapping table entries
- * @num_maps: the number of entries in @maps
- */
-struct pinctrl_maps {
-	struct list_head node;
-	struct pinctrl_map const *maps;
-	unsigned num_maps;
-};
-
-#ifdef CONFIG_GENERIC_PINCTRL
-
 int pinctrl_generic_get_group_count(struct pinctrl_dev *pctldev);
 
 const char *pinctrl_generic_get_group_name(struct pinctrl_dev *pctldev,
@@ -218,7 +220,7 @@ pinctrl_generic_remove_last_group(struct pinctrl_dev *pctldev)
 	return pinctrl_generic_remove_group(pctldev, pctldev->num_groups - 1);
 }
 
-#endif	/* CONFIG_GENERIC_PINCTRL */
+#endif	/* CONFIG_GENERIC_PINCTRL_GROUPS */
 
 struct pinctrl_dev *get_pinctrl_dev_from_devname(const char *dev_name);
 struct pinctrl_dev *get_pinctrl_dev_from_of_node(struct device_node *np);
-- 
2.9.3
