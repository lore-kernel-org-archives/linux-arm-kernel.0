From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 23 Oct 2012 00:08:52 +0800
Subject: [PATCH v2 2/9] pinctrl: single: support gpio request and free
In-Reply-To: <1350922139-3693-1-git-send-email-haojian.zhuang@gmail.com>
References: <1350922139-3693-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1350922139-3693-3-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell's PXA/MMP silicon also match the behavior of pinctrl-single.
Each pin binds to one register. A lot of pins could be configured
as gpio.

Now add three properties in below.
pinctrl-single,gpio-ranges: gpio range array
pinctrl-single,gpio: <gpio base, npins in range, pin base in range>
pinctrl-single,gpio-func: <gpio function value in mux>

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/pinctrl/pinctrl-single.c |   94 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 726a729..6a0b24b 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -28,8 +28,10 @@
 #define DRIVER_NAME			"pinctrl-single"
 #define PCS_MUX_PINS_NAME		"pinctrl-single,pins"
 #define PCS_MUX_BITS_NAME		"pinctrl-single,bits"
+#define PCS_GPIO_FUNC_NAME		"pinctrl-single,gpio-func"
 #define PCS_REG_NAME_LEN		((sizeof(unsigned long) * 2) + 1)
 #define PCS_OFF_DISABLED		~0U
+#define PCS_MAX_GPIO_VALUES		3
 
 /**
  * struct pcs_pingroup - pingroups for a function
@@ -77,6 +79,18 @@ struct pcs_function {
 };
 
 /**
+ * struct pcs_gpio_range - pinctrl gpio range
+ * @range:	subrange of the GPIO number space
+ * @gpio_func:	gpio function value in the pinmux register
+ * @func_en:	need to handle gpio function in the pinmux register
+ */
+struct pcs_gpio_range {
+	struct pinctrl_gpio_range range;
+	int gpio_func;
+	unsigned func_en:1;
+};
+
+/**
  * struct pcs_data - wrapper for data needed by pinctrl framework
  * @pa:		pindesc array
  * @cur:	index to current element
@@ -123,8 +137,10 @@ struct pcs_name {
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
@@ -148,8 +164,10 @@ struct pcs_device {
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
@@ -403,9 +421,27 @@ static void pcs_disable(struct pinctrl_dev *pctldev, unsigned fselector,
 }
 
 static int pcs_request_gpio(struct pinctrl_dev *pctldev,
-			struct pinctrl_gpio_range *range, unsigned offset)
+			    struct pinctrl_gpio_range *range, unsigned pin)
 {
-	return -ENOTSUPP;
+	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
+	struct pcs_gpio_range *gpio = NULL;
+	int end, mux_bytes;
+	unsigned data;
+
+	gpio = container_of(range, struct pcs_gpio_range, range);
+	if (!gpio->func_en)
+		return 0;
+	end = range->pin_base + range->npins - 1;
+	if (pin < range->pin_base || pin > end) {
+		dev_err(pctldev->dev, "pin %d isn't in the range of "
+			"%d to %d\n", pin, range->pin_base, end);
+		return -EINVAL;
+	}
+	mux_bytes = pcs->width / BITS_PER_BYTE;
+	data = pcs_readl(pcs->base + pin * mux_bytes) & ~pcs->fmask;
+	data |= gpio->gpio_func;
+	pcs_writel(data, pcs->base + pin * mux_bytes);
+	return 0;
 }
 
 static struct pinmux_ops pcs_pinmux_ops = {
@@ -879,6 +915,55 @@ static void pcs_free_resources(struct pcs_device *pcs)
 
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
+		ret = of_property_read_u32(np, PCS_GPIO_FUNC_NAME,
+					   &gpio->gpio_func);
+		if (!ret)
+			gpio->func_en = 1;
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
@@ -900,6 +985,7 @@ static int __devinit pcs_probe(struct platform_device *pdev)
 	mutex_init(&pcs->mutex);
 	INIT_LIST_HEAD(&pcs->pingroups);
 	INIT_LIST_HEAD(&pcs->functions);
+	INIT_LIST_HEAD(&pcs->ranges);
 
 	PCS_GET_PROP_U32("pinctrl-single,register-width", &pcs->width,
 			 "register width not specified\n");
@@ -975,6 +1061,10 @@ static int __devinit pcs_probe(struct platform_device *pdev)
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
