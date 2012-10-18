From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 18 Oct 2012 17:07:00 +0800
Subject: [PATCH 06/10] pinctrl: single: support gpio request and free
In-Reply-To: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1350551224-12857-6-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell's PXA/MMP silicon also match the behavior of pinctrl-single.
Each pin binds to one register. A lot of pins could be configured
as gpio.

Now add three properties in below.
pinctrl-single,gpio-mask: mask of enable/disable value of gpio
pinctrl-single,gpio-ranges: gpio range array
pinctrl-single,gpio: <gpio base, npins in range, pin base>
pinctrl-single,gpio-enable: <gpio enable register offset, enable
value>
pinctrl-single,gpio-disable: <gpio disable register offset, disable
value>

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/pinctrl/pinctrl-single.c |  140 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 138 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 64d109a..02cd412 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -29,6 +29,7 @@
 #define PCS_MUX_NAME			"pinctrl-single,pins"
 #define PCS_REG_NAME_LEN		((sizeof(unsigned long) * 2) + 1)
 #define PCS_OFF_DISABLED		~0U
+#define PCS_MAX_GPIO_VALUES		3
 
 /**
  * struct pcs_pingroup - pingroups for a function
@@ -75,6 +76,26 @@ struct pcs_function {
 };
 
 /**
+ * struct pcs_gpio_range - pinctrl gpio range
+ * @range:	subrange of the GPIO number space
+ * @reg_en:	register of enabling gpio function
+ * @reg_dis:	register of disabling gpio function
+ * @val_en:	enable value on gpio function
+ * @val_dis:	disable value on gpio function
+ * @need_en:	need to handle enable value on gpio function
+ * @need_dis:	need to handle disable value on gpio function
+ */
+struct pcs_gpio_range {
+	struct pinctrl_gpio_range range;
+	u32 reg_en;
+	u32 reg_dis;
+	int val_en;
+	int val_dis;
+	unsigned need_en:1;
+	unsigned need_dis:1;
+};
+
+/**
  * struct pcs_data - wrapper for data needed by pinctrl framework
  * @pa:		pindesc array
  * @cur:	index to current element
@@ -115,14 +136,17 @@ struct pcs_name {
  * @fshift:	function register shift
  * @foff:	value to turn mux off
  * @fmax:	max number of functions in fmask
+ * @gmask:	gpio control mask
  * @names:	array of register names for pins
  * @pins:	physical pins on the SoC
  * @pgtree:	pingroup index radix tree
  * @ftree:	function index radix tree
  * @pingroups:	list of pingroups
  * @functions:	list of functions
+ * @ranges:	list of gpio ranges
  * @ngroups:	number of pingroups
  * @nfuncs:	number of functions
+ * @nranges:	number of gpio ranges
  * @desc:	pin controller descriptor
  * @read:	register read function to use
  * @write:	register write function to use
@@ -139,14 +163,17 @@ struct pcs_device {
 	unsigned fshift;
 	unsigned foff;
 	unsigned fmax;
+	unsigned gmask;
 	struct pcs_name *names;
 	struct pcs_data pins;
 	struct radix_tree_root pgtree;
 	struct radix_tree_root ftree;
 	struct list_head pingroups;
 	struct list_head functions;
+	struct list_head ranges;
 	unsigned ngroups;
 	unsigned nfuncs;
+	unsigned nranges;
 	struct pinctrl_desc desc;
 	unsigned (*read)(void __iomem *reg);
 	void (*write)(unsigned val, void __iomem *reg);
@@ -387,9 +414,48 @@ static void pcs_disable(struct pinctrl_dev *pctldev, unsigned fselector,
 }
 
 static int pcs_request_gpio(struct pinctrl_dev *pctldev,
-			struct pinctrl_gpio_range *range, unsigned offset)
+			    struct pinctrl_gpio_range *range, unsigned offset)
 {
-	return -ENOTSUPP;
+	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
+	struct pcs_gpio_range *gpio = NULL;
+	int end;
+	unsigned data;
+
+	gpio = container_of(range, struct pcs_gpio_range, range);
+	if (!gpio->need_en)
+		return 0;
+	end = range->pin_base + range->npins - 1;
+	if (offset < range->pin_base || offset > end) {
+		dev_err(pctldev->dev, "offset %d isn't in the range of "
+			"%d to %d\n", offset, range->pin_base, end);
+		return -EINVAL;
+	}
+	data = pcs_readl((void __iomem *)gpio->reg_en) & ~pcs->gmask;
+	data |= gpio->val_en;
+	pcs_writel(data, (void __iomem *)gpio->reg_en);
+	return 0;
+}
+
+static void pcs_disable_gpio(struct pinctrl_dev *pctldev,
+			     struct pinctrl_gpio_range *range, unsigned offset)
+{
+	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
+	struct pcs_gpio_range *gpio = NULL;
+	int end;
+	unsigned data;
+
+	gpio = container_of(range, struct pcs_gpio_range, range);
+	if (!gpio->need_dis)
+		return;
+	end = range->pin_base + range->npins - 1;
+	if (offset < range->pin_base || offset > end) {
+		dev_err(pctldev->dev, "offset %d isn't in the range of "
+			"%d to %d\n", offset, range->pin_base, end);
+		return;
+	}
+	data = pcs_readl((void __iomem *)gpio->reg_dis) & ~pcs->gmask;
+	data |= gpio->val_dis;
+	pcs_writel(data, (void __iomem *)gpio->reg_dis);
 }
 
 static struct pinmux_ops pcs_pinmux_ops = {
@@ -399,6 +465,7 @@ static struct pinmux_ops pcs_pinmux_ops = {
 	.enable = pcs_enable,
 	.disable = pcs_disable,
 	.gpio_request_enable = pcs_request_gpio,
+	.gpio_disable_free = pcs_disable_gpio,
 };
 
 static int pcs_pinconf_get(struct pinctrl_dev *pctldev,
@@ -848,6 +915,70 @@ static void pcs_free_resources(struct pcs_device *pcs)
 
 static struct of_device_id pcs_of_match[];
 
+static int __devinit pcs_add_gpio_range(struct device_node *node,
+					struct pcs_device *pcs)
+{
+	struct pcs_gpio_range *gpio;
+	struct device_node *np;
+	const __be32 *list;
+	const char list_name[] = "pinctrl-single,gpio-ranges";
+	const char name[] = "pinctrl-single";
+	u32 gpiores[PCS_MAX_GPIO_VALUES];
+	int ret, size, i, mux_bytes = 0;
+
+	ret = of_property_read_u32(node, "pinctrl-single,gpio-mask",
+				&pcs->gmask);
+	if (ret < 0)
+		return 0;
+	list = of_get_property(node, list_name, &size);
+	if (!list)
+		return -ENOENT;
+	size = size / sizeof(*list);
+	for (i = 0; i < size; i++) {
+		np = of_parse_phandle(node, list_name, i);
+		memset(gpiores, 0, sizeof(u32) * PCS_MAX_GPIO_VALUES);
+		ret = of_property_read_u32_array(np, "pinctrl-single,gpio",
+						 gpiores, PCS_MAX_GPIO_VALUES);
+		if (ret < 0)
+			return -ENOENT;
+		gpio = devm_kzalloc(pcs->dev, sizeof(*gpio), GFP_KERNEL);
+		if (!gpio) {
+			dev_err(pcs->dev, "failed to allocate pcs gpio\n");
+			return -ENOMEM;
+		}
+		gpio->range.id = i;
+		gpio->range.base = gpiores[0];
+		gpio->range.npins = gpiores[1];
+		gpio->range.name = kmemdup(name, sizeof(name), GFP_KERNEL);
+		mux_bytes = pcs->width / BITS_PER_BYTE;
+		gpio->range.pin_base = gpiores[2] / mux_bytes;
+		memset(gpiores, 0, sizeof(u32) * PCS_MAX_GPIO_VALUES);
+		ret = of_property_read_u32_array(np,
+				"pinctrl-single,gpio-enable", gpiores, 2);
+		if (!ret) {
+			gpio->reg_en = (u32)pcs->base + gpiores[0];
+			gpio->val_en = gpiores[1];
+			gpio->need_en = 1;
+		}
+		memset(gpiores, 0, sizeof(u32) * PCS_MAX_GPIO_VALUES);
+		ret = of_property_read_u32_array(np,
+				"pinctrl-single,gpio-disable", gpiores, 2);
+		if (!ret) {
+			gpio->reg_dis = (u32)pcs->base + gpiores[0];
+			gpio->val_dis = gpiores[1];
+			gpio->need_dis = 1;
+		}
+
+		mutex_lock(&pcs->mutex);
+		list_add_tail(&gpio->range.node, &pcs->ranges);
+		pcs->nranges++;
+		mutex_unlock(&pcs->mutex);
+
+		pinctrl_add_gpio_range(pcs->pctl, &gpio->range);
+	}
+	return 0;
+}
+
 static int __devinit pcs_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -869,6 +1000,7 @@ static int __devinit pcs_probe(struct platform_device *pdev)
 	mutex_init(&pcs->mutex);
 	INIT_LIST_HEAD(&pcs->pingroups);
 	INIT_LIST_HEAD(&pcs->functions);
+	INIT_LIST_HEAD(&pcs->ranges);
 
 	PCS_GET_PROP_U32("pinctrl-single,register-width", &pcs->width,
 			 "register width not specified\n");
@@ -941,6 +1073,10 @@ static int __devinit pcs_probe(struct platform_device *pdev)
 		goto free;
 	}
 
+	ret = pcs_add_gpio_range(np, pcs);
+	if (ret < 0)
+		return ret;
+
 	dev_info(pcs->dev, "%i pins at pa %p size %u\n",
 		 pcs->desc.npins, pcs->base, pcs->size);
 
-- 
1.7.0.4
