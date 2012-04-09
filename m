From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 9 Apr 2012 18:30:09 +0800
Subject: [PATCH 1/1] pinctrl: add some error checking for user interfaces
Message-ID: <1333967409-8168-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

This patch can avoid kernel oops in case the mux or config
function is not supported by driver.

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 drivers/pinctrl/pinconf.c |    4 ++++
 drivers/pinctrl/pinmux.c  |   15 +++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinconf.c b/drivers/pinctrl/pinconf.c
index eb3a14f..384dcc1 100644
--- a/drivers/pinctrl/pinconf.c
+++ b/drivers/pinctrl/pinconf.c
@@ -448,8 +448,12 @@ static void pinconf_dump_pin(struct pinctrl_dev *pctldev,
 static int pinconf_pins_show(struct seq_file *s, void *what)
 {
 	struct pinctrl_dev *pctldev = s->private;
+	const struct pinconf_ops *ops = pctldev->desc->confops;
 	unsigned i, pin;
 
+	if (!ops || !ops->pin_config_get)
+		return 0;
+
 	seq_puts(s, "Pin config settings per pin\n");
 	seq_puts(s, "Format: pin (name): pinmux setting array\n");
 
diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 8849830..ade661d 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -323,6 +323,11 @@ int pinmux_map_to_setting(struct pinctrl_map const *map,
 	const unsigned *pins;
 	unsigned num_pins;
 
+	if (!pmxops) {
+		dev_err(pctldev->dev, "dose not support mux functron\n");
+		return -EINVAL;
+	}
+
 	setting->data.mux.func =
 		pinmux_func_name_to_selector(pctldev, map->data.mux.function);
 	if (setting->data.mux.func < 0)
@@ -481,11 +486,14 @@ static int pinmux_functions_show(struct seq_file *s, void *what)
 {
 	struct pinctrl_dev *pctldev = s->private;
 	const struct pinmux_ops *pmxops = pctldev->desc->pmxops;
-	unsigned nfuncs = pmxops->get_functions_count(pctldev);
+	unsigned nfuncs;
 	unsigned func_selector = 0;
 
-	mutex_lock(&pinctrl_mutex);
+	if (!pmxops)
+		return 0;
 
+	mutex_lock(&pinctrl_mutex);
+	nfuncs = pmxops->get_functions_count(pctldev);
 	while (func_selector < nfuncs) {
 		const char *func = pmxops->get_function_name(pctldev,
 							  func_selector);
@@ -520,6 +528,9 @@ static int pinmux_pins_show(struct seq_file *s, void *what)
 	const struct pinmux_ops *pmxops = pctldev->desc->pmxops;
 	unsigned i, pin;
 
+	if (!pmxops)
+		return 0;
+
 	seq_puts(s, "Pinmux settings per pin\n");
 	seq_puts(s, "Format: pin (name): mux_owner gpio_owner hog?\n");
 
-- 
1.7.0.4
