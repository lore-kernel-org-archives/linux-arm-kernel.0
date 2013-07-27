From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 27 Jul 2013 13:31:50 +0200
Subject: [PATCH v10 1/7] ASoC: core: Generic ac97 link reset functions
In-Reply-To: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
References: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1374924716-23475-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds generic ac97 reset functions using pincontrol and gpio
parsed from devicetree.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 .../devicetree/bindings/sound/soc-ac97link.txt     |  28 ++++
 include/sound/soc.h                                |   2 +
 sound/soc/soc-core.c                               | 153 +++++++++++++++++++++
 3 files changed, 183 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/soc-ac97link.txt

diff --git a/Documentation/devicetree/bindings/sound/soc-ac97link.txt b/Documentation/devicetree/bindings/sound/soc-ac97link.txt
new file mode 100644
index 0000000..80152a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/soc-ac97link.txt
@@ -0,0 +1,28 @@
+AC97 link bindings
+
+These bindings can be included within any other device node.
+
+Required properties:
+ - pinctrl-names: Has to contain following states to setup the correct
+   pinmuxing for the used gpios:
+	"ac97-running": AC97-link is active
+	"ac97-reset": AC97-link reset state
+	"ac97-warm-reset": AC97-link warm reset state
+ - ac97-gpios: List of gpio phandles with args in the order ac97-sync,
+   ac97-sdata, ac97-reset
+
+
+Example:
+
+ssi {
+	...
+
+	pinctrl-names = "default", "ac97-running", "ac97-reset", "ac97-warm-reset";
+	pinctrl-0 = <&ac97link_running>;
+	pinctrl-1 = <&ac97link_running>;
+	pinctrl-2 = <&ac97link_reset>;
+	pinctrl-3 = <&ac97link_warm_reset>;
+	ac97-gpios = <&gpio3 20 0 &gpio3 22 0 &gpio3 28 0>;
+
+	...
+};
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 6eabee7..c0ac3bc 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -468,6 +468,8 @@ int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
 void snd_soc_free_ac97_codec(struct snd_soc_codec *codec);
 
 int snd_soc_set_ac97_ops(struct snd_ac97_bus_ops *ops);
+int snd_soc_set_ac97_ops_of_reset(struct snd_ac97_bus_ops *ops,
+		struct platform_device *pdev);
 
 /*
  *Controls
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0ec070c..6010932 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -30,9 +30,12 @@
 #include <linux/bitops.h>
 #include <linux/debugfs.h>
 #include <linux/platform_device.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/ctype.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
 #include <sound/ac97_codec.h>
 #include <sound/core.h>
 #include <sound/jack.h>
@@ -69,6 +72,16 @@ static int pmdown_time = 5000;
 module_param(pmdown_time, int, 0);
 MODULE_PARM_DESC(pmdown_time, "DAPM stream powerdown time (msecs)");
 
+struct snd_ac97_reset_cfg {
+	struct pinctrl *pctl;
+	struct pinctrl_state *pstate_reset;
+	struct pinctrl_state *pstate_warm_reset;
+	struct pinctrl_state *pstate_run;
+	int gpio_sdata;
+	int gpio_sync;
+	int gpio_reset;
+};
+
 /* returns the minimum number of bytes needed to represent
  * a particular given value */
 static int min_bytes_needed(unsigned long val)
@@ -2080,6 +2093,117 @@ int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_soc_new_ac97_codec);
 
+static struct snd_ac97_reset_cfg snd_ac97_rst_cfg;
+
+static void snd_soc_ac97_warm_reset(struct snd_ac97 *ac97)
+{
+	struct pinctrl *pctl = snd_ac97_rst_cfg.pctl;
+
+	pinctrl_select_state(pctl, snd_ac97_rst_cfg.pstate_warm_reset);
+
+	gpio_direction_output(snd_ac97_rst_cfg.gpio_sync, 1);
+
+	udelay(10);
+
+	gpio_direction_output(snd_ac97_rst_cfg.gpio_sync, 0);
+
+	pinctrl_select_state(pctl, snd_ac97_rst_cfg.pstate_run);
+	msleep(2);
+}
+
+static void snd_soc_ac97_reset(struct snd_ac97 *ac97)
+{
+	struct pinctrl *pctl = snd_ac97_rst_cfg.pctl;
+
+	pinctrl_select_state(pctl, snd_ac97_rst_cfg.pstate_reset);
+
+	gpio_direction_output(snd_ac97_rst_cfg.gpio_sync, 0);
+	gpio_direction_output(snd_ac97_rst_cfg.gpio_sdata, 0);
+	gpio_direction_output(snd_ac97_rst_cfg.gpio_reset, 0);
+
+	udelay(10);
+
+	gpio_direction_output(snd_ac97_rst_cfg.gpio_reset, 1);
+
+	pinctrl_select_state(pctl, snd_ac97_rst_cfg.pstate_run);
+	msleep(2);
+}
+
+static int snd_soc_ac97_parse_pinctl(struct device *dev,
+		struct snd_ac97_reset_cfg *cfg)
+{
+	struct pinctrl *p;
+	struct pinctrl_state *state;
+	int gpio;
+	int ret;
+
+	p = devm_pinctrl_get(dev);
+	if (IS_ERR(p)) {
+		dev_err(dev, "Failed to get pinctrl\n");
+		return PTR_RET(p);
+	}
+	cfg->pctl = p;
+
+	state = pinctrl_lookup_state(p, "ac97-reset");
+	if (IS_ERR(state)) {
+		dev_err(dev, "Can't find pinctrl state ac97-reset\n");
+		return PTR_RET(state);
+	}
+	cfg->pstate_reset = state;
+
+	state = pinctrl_lookup_state(p, "ac97-warm-reset");
+	if (IS_ERR(state)) {
+		dev_err(dev, "Can't find pinctrl state ac97-warm-reset\n");
+		return PTR_RET(state);
+	}
+	cfg->pstate_warm_reset = state;
+
+	state = pinctrl_lookup_state(p, "ac97-running");
+	if (IS_ERR(state)) {
+		dev_err(dev, "Can't find pinctrl state ac97-running\n");
+		return PTR_RET(state);
+	}
+	cfg->pstate_run = state;
+
+	gpio = of_get_named_gpio(dev->of_node, "ac97-gpios", 0);
+	if (gpio < 0) {
+		dev_err(dev, "Can't find ac97-sync gpio\n");
+		return gpio;
+	}
+	ret = devm_gpio_request(dev, gpio, "AC97 link sync");
+	if (ret) {
+		dev_err(dev, "Failed requesting ac97-sync gpio\n");
+		return ret;
+	}
+	cfg->gpio_sync = gpio;
+
+	gpio = of_get_named_gpio(dev->of_node, "ac97-gpios", 1);
+	if (gpio < 0) {
+		dev_err(dev, "Can't find ac97-sdata gpio %d\n", gpio);
+		return gpio;
+	}
+	ret = devm_gpio_request(dev, gpio, "AC97 link sdata");
+	if (ret) {
+		dev_err(dev, "Failed requesting ac97-sdata gpio\n");
+		return ret;
+	}
+	cfg->gpio_sdata = gpio;
+
+	gpio = of_get_named_gpio(dev->of_node, "ac97-gpios", 2);
+	if (gpio < 0) {
+		dev_err(dev, "Can't find ac97-reset gpio\n");
+		return gpio;
+	}
+	ret = devm_gpio_request(dev, gpio, "AC97 link reset");
+	if (ret) {
+		dev_err(dev, "Failed requesting ac97-reset gpio\n");
+		return ret;
+	}
+	cfg->gpio_reset = gpio;
+
+	return 0;
+}
+
 struct snd_ac97_bus_ops *soc_ac97_ops;
 EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
@@ -2098,6 +2222,35 @@ int snd_soc_set_ac97_ops(struct snd_ac97_bus_ops *ops)
 EXPORT_SYMBOL_GPL(snd_soc_set_ac97_ops);
 
 /**
+ * snd_soc_set_ac97_ops_of_reset - Set ac97 ops with generic ac97 reset functions
+ *
+ * This function sets the reset and warm_reset properties of ops and parses
+ * the device node of pdev to get pinctrl states and gpio numbers to use.
+ */
+int snd_soc_set_ac97_ops_of_reset(struct snd_ac97_bus_ops *ops,
+		struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct snd_ac97_reset_cfg cfg;
+	int ret;
+
+	ret = snd_soc_ac97_parse_pinctl(dev, &cfg);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_set_ac97_ops(ops);
+	if (ret)
+		return ret;
+
+	ops->warm_reset = snd_soc_ac97_warm_reset;
+	ops->reset = snd_soc_ac97_reset;
+
+	snd_ac97_rst_cfg = cfg;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_set_ac97_ops_of_reset);
+
+/**
  * snd_soc_free_ac97_codec - free AC97 codec device
  * @codec: audio codec
  *
-- 
1.8.3.2
