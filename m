From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Thu, 10 Apr 2014 15:07:50 +0200
Subject: [PATCH RESEND 1/5] pinctrl: allows not to define the get_group_pins
 operation
In-Reply-To: <1397135274-10764-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1397135274-10764-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1397135274-10764-2-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using a group only pinctrl driver, which does not have any
information on the pins it is useless to define a get_group_pins
always returning an empty list of pins.

When not using get_group_pin[1], a driver must implement it so
pins = NULL and num_pins = 0. This patch makes it the default
behaviour if not defined in the pinctrl driver when used in
pinmux enable and disable funtions and in pinctrl_groups_show.

It also adds a check in pinctrl_get_group_pins and return -EINVAL if
not defined. This function is called in the gpiolib when adding when
pingroup range. It cannot be used if no group is defined, so this seams
reasonable.

[1] get_group_pin(struct pinctrl_dev *pctldev,
		  unsigned selector,
		  const unsigned **pins,
		  unsigned *num_pins);

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 drivers/pinctrl/core.c   | 17 ++++++++++-------
 drivers/pinctrl/pinmux.c | 23 +++++++++++++----------
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index c0fe6091566a..e09474ecde23 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -468,6 +468,9 @@ int pinctrl_get_group_pins(struct pinctrl_dev *pctldev, const char *pin_group,
 	const struct pinctrl_ops *pctlops = pctldev->desc->pctlops;
 	int gs;
 
+	if (!pctlops->get_group_pins)
+		return -EINVAL;
+
 	gs = pinctrl_get_group_selector(pctldev, pin_group);
 	if (gs < 0)
 		return gs;
@@ -1362,15 +1365,16 @@ static int pinctrl_groups_show(struct seq_file *s, void *what)
 
 	seq_puts(s, "registered pin groups:\n");
 	while (selector < ngroups) {
-		const unsigned *pins;
-		unsigned num_pins;
+		const unsigned *pins = NULL;
+		unsigned num_pins = 0;
 		const char *gname = ops->get_group_name(pctldev, selector);
 		const char *pname;
-		int ret;
+		int ret = 0;
 		int i;
 
-		ret = ops->get_group_pins(pctldev, selector,
-					  &pins, &num_pins);
+		if (ops->get_group_pins)
+			ret = ops->get_group_pins(pctldev, selector,
+						  &pins, &num_pins);
 		if (ret)
 			seq_printf(s, "%s [ERROR GETTING PINS]\n",
 				   gname);
@@ -1694,8 +1698,7 @@ static int pinctrl_check_ops(struct pinctrl_dev *pctldev)
 
 	if (!ops ||
 	    !ops->get_groups_count ||
-	    !ops->get_group_name ||
-	    !ops->get_group_pins)
+	    !ops->get_group_name)
 		return -EINVAL;
 
 	if (ops->dt_node_to_map && !ops->dt_free_map)
diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 9248ce4efed4..051e8592990e 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -391,14 +391,16 @@ int pinmux_enable_setting(struct pinctrl_setting const *setting)
 	struct pinctrl_dev *pctldev = setting->pctldev;
 	const struct pinctrl_ops *pctlops = pctldev->desc->pctlops;
 	const struct pinmux_ops *ops = pctldev->desc->pmxops;
-	int ret;
-	const unsigned *pins;
-	unsigned num_pins;
+	int ret = 0;
+	const unsigned *pins = NULL;
+	unsigned num_pins = 0;
 	int i;
 	struct pin_desc *desc;
 
-	ret = pctlops->get_group_pins(pctldev, setting->data.mux.group,
-				      &pins, &num_pins);
+	if (pctlops->get_group_pins)
+		ret = pctlops->get_group_pins(pctldev, setting->data.mux.group,
+					      &pins, &num_pins);
+
 	if (ret) {
 		const char *gname;
 
@@ -470,14 +472,15 @@ void pinmux_disable_setting(struct pinctrl_setting const *setting)
 	struct pinctrl_dev *pctldev = setting->pctldev;
 	const struct pinctrl_ops *pctlops = pctldev->desc->pctlops;
 	const struct pinmux_ops *ops = pctldev->desc->pmxops;
-	int ret;
-	const unsigned *pins;
-	unsigned num_pins;
+	int ret = 0;
+	const unsigned *pins = NULL;
+	unsigned num_pins = 0;
 	int i;
 	struct pin_desc *desc;
 
-	ret = pctlops->get_group_pins(pctldev, setting->data.mux.group,
-				      &pins, &num_pins);
+	if (pctlops->get_group_pins)
+		ret = pctlops->get_group_pins(pctldev, setting->data.mux.group,
+					      &pins, &num_pins);
 	if (ret) {
 		const char *gname;
 
-- 
1.8.3.2
