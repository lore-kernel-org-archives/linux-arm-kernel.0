From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun,  3 Feb 2013 01:25:48 +0800
Subject: [PATCH v8 07/12] pinctrl: single: create new gpio function range
In-Reply-To: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
References: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1359825953-15663-8-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since gpio driver could create gpio range in DTS, it could invokes
pinctrl_request_gpio(). In the pinctrl-single driver, it needs to
configure pins with gpio function mode.

A new gpio function range should be created in DTS file in below.

pinctrl-single,gpio-range = <phandle pin_offset nr_pins gpio_func>;

range: gpio-range {
	#pinctrl-single,gpio-range-cells = <3>;
};

The difference between gpio-ranges property in gpio driver and
pinctrl-single,gpio-range property in pinctrl-single driver.

1. gpio-ranges = <phandle gpio_offset_in_chip pin_offset nr_pins>
	gpio-ranges = < &pmx0 0 89 1 &pmx0 1 89 1 &pmx0 2 90 1
			&pmx0 3 90 1 &pmx0 4 91 1 &pmx0 5 92 1>;

2. gpio driver could get pin offset from gpio-ranges property.
   pinctrl-single driver could get gpio function mode from gpio_func
   that is stored in @gpiofuncs list in struct pcs_device.
   This new pinctrl-single,gpio-range is used as complement for
   gpio-ranges property in gpio driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/pinctrl/pinctrl-single.c |   73 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 5c32e88..8b9dd95 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -77,6 +77,20 @@ struct pcs_function {
 };
 
 /**
+ * struct pcs_gpiofunc_range - pin ranges with same mux value of gpio function
+ * @offset:	offset base of pins
+ * @npins:	number pins with the same mux value of gpio function
+ * @gpiofunc:	mux value of gpio function
+ * @node:	list node
+ */
+struct pcs_gpiofunc_range {
+	unsigned offset;
+	unsigned npins;
+	unsigned gpiofunc;
+	struct list_head node;
+};
+
+/**
  * struct pcs_data - wrapper for data needed by pinctrl framework
  * @pa:		pindesc array
  * @cur:	index to current element
@@ -123,6 +137,7 @@ struct pcs_name {
  * @ftree:	function index radix tree
  * @pingroups:	list of pingroups
  * @functions:	list of functions
+ * @gpiofuncs:	list of gpio functions
  * @ngroups:	number of pingroups
  * @nfuncs:	number of functions
  * @desc:	pin controller descriptor
@@ -148,6 +163,7 @@ struct pcs_device {
 	struct radix_tree_root ftree;
 	struct list_head pingroups;
 	struct list_head functions;
+	struct list_head gpiofuncs;
 	unsigned ngroups;
 	unsigned nfuncs;
 	struct pinctrl_desc desc;
@@ -403,9 +419,26 @@ static void pcs_disable(struct pinctrl_dev *pctldev, unsigned fselector,
 }
 
 static int pcs_request_gpio(struct pinctrl_dev *pctldev,
-			struct pinctrl_gpio_range *range, unsigned offset)
+			    struct pinctrl_gpio_range *range, unsigned pin)
 {
-	return -ENOTSUPP;
+	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
+	struct pcs_gpiofunc_range *frange = NULL;
+	struct list_head *pos, *tmp;
+	int mux_bytes = 0;
+	unsigned data;
+
+	list_for_each_safe(pos, tmp, &pcs->gpiofuncs) {
+		frange = list_entry(pos, struct pcs_gpiofunc_range, node);
+		if (pin >= frange->offset + frange->npins
+			|| pin < frange->offset)
+			continue;
+		mux_bytes = pcs->width / BITS_PER_BYTE;
+		data = pcs->read(pcs->base + pin * mux_bytes) & ~pcs->fmask;
+		data |= frange->gpiofunc;
+		pcs->write(data, pcs->base + pin * mux_bytes);
+		break;
+	}
+	return 0;
 }
 
 static struct pinmux_ops pcs_pinmux_ops = {
@@ -879,6 +912,37 @@ static void pcs_free_resources(struct pcs_device *pcs)
 
 static struct of_device_id pcs_of_match[];
 
+static int pcs_add_gpio_func(struct device_node *node, struct pcs_device *pcs)
+{
+	const char *propname = "pinctrl-single,gpio-range";
+	const char *cellname = "#pinctrl-single,gpio-range-cells";
+	struct of_phandle_args gpiospec;
+	struct pcs_gpiofunc_range *range;
+	int ret, i;
+
+	for (i = 0; ; i++) {
+		ret = of_parse_phandle_with_args(node, propname, cellname,
+						 i, &gpiospec);
+		/* Do not treat it as error. Only treat it as end condition. */
+		if (ret) {
+			ret = 0;
+			break;
+		}
+		range = devm_kzalloc(pcs->dev, sizeof(*range), GFP_KERNEL);
+		if (!range) {
+			ret = -ENOMEM;
+			break;
+		}
+		range->offset = gpiospec.args[0];
+		range->npins = gpiospec.args[1];
+		range->gpiofunc = gpiospec.args[2];
+		mutex_lock(&pcs->mutex);
+		list_add_tail(&range->node, &pcs->gpiofuncs);
+		mutex_unlock(&pcs->mutex);
+	}
+	return ret;
+}
+
 static int pcs_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -900,6 +964,7 @@ static int pcs_probe(struct platform_device *pdev)
 	mutex_init(&pcs->mutex);
 	INIT_LIST_HEAD(&pcs->pingroups);
 	INIT_LIST_HEAD(&pcs->functions);
+	INIT_LIST_HEAD(&pcs->gpiofuncs);
 
 	PCS_GET_PROP_U32("pinctrl-single,register-width", &pcs->width,
 			 "register width not specified\n");
@@ -975,6 +1040,10 @@ static int pcs_probe(struct platform_device *pdev)
 		goto free;
 	}
 
+	ret = pcs_add_gpio_func(np, pcs);
+	if (ret < 0)
+		goto free;
+
 	dev_info(pcs->dev, "%i pins at pa %p size %u\n",
 		 pcs->desc.npins, pcs->base, pcs->size);
 
-- 
1.7.10.4
