From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 15 Nov 2012 16:36:31 +0800
Subject: [PATCH v5 02/10] pinctrl: single: support gpio request and free
In-Reply-To: <1352968600-15345-1-git-send-email-haojian.zhuang@gmail.com>
References: <1352968600-15345-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1352968600-15345-3-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell's PXA/MMP silicon also match the behavior of pinctrl-single.
Each pin binds to one register. A lot of pins could be configured
as gpio.

GPIO range is defined as a child node of pinmux in .dtsi file. If those
pins are with the same gpio function configuration in the pinmux
register, they could be defined in the same GPIO range. For this new
child node, two properties are used.

reg = <the start of pinmux register in range, size of range>

pinctrl-single,gpio: <gpio base in range, the gpio function of the range
		in the pinmux register>

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/pinctrl/pinctrl-single.c |   80 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 726a729..2476a68 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -30,6 +30,7 @@
 #define PCS_MUX_BITS_NAME		"pinctrl-single,bits"
 #define PCS_REG_NAME_LEN		((sizeof(unsigned long) * 2) + 1)
 #define PCS_OFF_DISABLED		~0U
+#define PCS_MAX_GPIO_VALUES		2
 
 /**
  * struct pcs_pingroup - pingroups for a function
@@ -77,6 +78,16 @@ struct pcs_function {
 };
 
 /**
+ * struct pcs_gpio_range - pinctrl gpio range
+ * @range:	subrange of the GPIO number space
+ * @gpio_func:	gpio function value in the pinmux register
+ */
+struct pcs_gpio_range {
+	struct pinctrl_gpio_range range;
+	int gpio_func;
+};
+
+/**
  * struct pcs_data - wrapper for data needed by pinctrl framework
  * @pa:		pindesc array
  * @cur:	index to current element
@@ -403,9 +414,26 @@ static void pcs_disable(struct pinctrl_dev *pctldev, unsigned fselector,
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
+	end = range->pin_base + range->npins - 1;
+	if (pin < range->pin_base || pin > end) {
+		dev_err(pctldev->dev,
+			"pin %d isn't in the range of %d to %d\n",
+			pin, range->pin_base, end);
+		return -EINVAL;
+	}
+	mux_bytes = pcs->width / BITS_PER_BYTE;
+	data = pcs->read(pcs->base + pin * mux_bytes) & ~pcs->fmask;
+	data |= gpio->gpio_func;
+	pcs->write(data, pcs->base + pin * mux_bytes);
+	return 0;
 }
 
 static struct pinmux_ops pcs_pinmux_ops = {
@@ -879,6 +907,50 @@ static void pcs_free_resources(struct pcs_device *pcs)
 
 static struct of_device_id pcs_of_match[];
 
+static int __devinit pcs_add_gpio_range(struct device_node *node,
+					struct pcs_device *pcs)
+{
+	struct pcs_gpio_range *gpio;
+	struct device_node *child;
+	struct resource r;
+	const char name[] = "pinctrl-single";
+	u32 gpiores[PCS_MAX_GPIO_VALUES];
+	int ret, i = 0, mux_bytes = 0;
+
+	for_each_child_of_node(node, child) {
+		ret = of_address_to_resource(child, 0, &r);
+		if (ret < 0)
+			continue;
+		memset(gpiores, 0, sizeof(u32) * PCS_MAX_GPIO_VALUES);
+		ret = of_property_read_u32_array(child, "pinctrl-single,gpio",
+						 gpiores, PCS_MAX_GPIO_VALUES);
+		if (ret < 0)
+			continue;
+		gpio = devm_kzalloc(pcs->dev, sizeof(*gpio), GFP_KERNEL);
+		if (!gpio) {
+			dev_err(pcs->dev, "failed to allocate pcs gpio\n");
+			return -ENOMEM;
+		}
+		gpio->range.name = devm_kzalloc(pcs->dev, sizeof(name),
+						GFP_KERNEL);
+		if (!gpio->range.name) {
+			dev_err(pcs->dev, "failed to allocate range name\n");
+			return -ENOMEM;
+		}
+		memcpy((char *)gpio->range.name, name, sizeof(name));
+
+		gpio->range.id = i++;
+		gpio->range.base = gpiores[0];
+		gpio->gpio_func = gpiores[1];
+		mux_bytes = pcs->width / BITS_PER_BYTE;
+		gpio->range.pin_base = (r.start - pcs->res->start) / mux_bytes;
+		gpio->range.npins = (r.end - r.start) / mux_bytes + 1;
+
+		pinctrl_add_gpio_range(pcs->pctl, &gpio->range);
+	}
+	return 0;
+}
+
 static int __devinit pcs_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -975,6 +1047,10 @@ static int __devinit pcs_probe(struct platform_device *pdev)
 		goto free;
 	}
 
+	ret = pcs_add_gpio_range(np, pcs);
+	if (ret < 0)
+		goto free;
+
 	dev_info(pcs->dev, "%i pins at pa %p size %u\n",
 		 pcs->desc.npins, pcs->base, pcs->size);
 
-- 
1.7.10.4
