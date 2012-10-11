From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 11 Oct 2012 10:11:13 +0200
Subject: [PATCH 07/15] pinctrl: samsung: Match pin banks with their device
 nodes
In-Reply-To: <1349943081-27939-1-git-send-email-t.figa@samsung.com>
References: <1349943081-27939-1-git-send-email-t.figa@samsung.com>
Message-ID: <1349943081-27939-8-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is a preparation for converting the pinctrl-samsung driver to
one GPIO chip and IRQ domain per bank. It binds banks defined by
internal driver data with bank nodes in device tree.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/pinctrl/pinctrl-samsung.c | 13 +++++++++++++
 drivers/pinctrl/pinctrl-samsung.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
index 94e1378..f266710 100644
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@ -794,6 +794,7 @@ static struct samsung_pin_ctrl *samsung_pinctrl_get_soc_data(
 	int id;
 	const struct of_device_id *match;
 	const struct device_node *node = pdev->dev.of_node;
+	struct device_node *np;
 	struct samsung_pin_ctrl *ctrl;
 	struct samsung_pin_bank *bank;
 	int i;
@@ -816,6 +817,18 @@ static struct samsung_pin_ctrl *samsung_pinctrl_get_soc_data(
 		}
 	}
 
+	for_each_child_of_node(node, np) {
+		if (!of_find_property(np, "gpio-controller", NULL))
+			continue;
+		bank = ctrl->pin_banks;
+		for (i = 0; i < ctrl->nr_banks; ++i, ++bank) {
+			if (!strcmp(bank->name, np->name)) {
+				bank->of_node = np;
+				break;
+			}
+		}
+	}
+
 	ctrl->base = pin_base;
 	pin_base += ctrl->nr_pins;
 
diff --git a/drivers/pinctrl/pinctrl-samsung.h b/drivers/pinctrl/pinctrl-samsung.h
index b895693..5c53f32 100644
--- a/drivers/pinctrl/pinctrl-samsung.h
+++ b/drivers/pinctrl/pinctrl-samsung.h
@@ -111,6 +111,7 @@ struct samsung_pinctrl_drv_data;
  * @eint_type: type of the external interrupt supported by the bank.
  * @irq_base: starting controller local irq number of the bank.
  * @name: name to be prefixed for each pin in this pin bank.
+ * @of_node: OF node of the bank.
  */
 struct samsung_pin_bank {
 	u32		pctl_offset;
@@ -124,6 +125,7 @@ struct samsung_pin_bank {
 	enum eint_type	eint_type;
 	u32		irq_base;
 	char		*name;
+	struct device_node *of_node;
 };
 
 /**
-- 
1.7.12
