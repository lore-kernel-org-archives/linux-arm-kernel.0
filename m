From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Jun 2014 15:26:04 +0200
Subject: [PATCH v3 5/5] pinctrl: sunxi: Implement multiple interrupt banks
 support
In-Reply-To: <1401974765-14417-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1401974765-14417-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1401974765-14417-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A23 and A31 support multiple interrupt banks. Support it by adding a linear
domain covering all the banks. It's trickier than it should because there's an
interrupt per bank, so we have multiple interrupts using the same domain.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 65 +++++++++++++++++++++++++++--------
 drivers/pinctrl/sunxi/pinctrl-sunxi.h | 34 +++++++++++++-----
 2 files changed, 76 insertions(+), 23 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 93e774034e51..f8446ff6aa13 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -634,17 +634,28 @@ static void sunxi_pinctrl_irq_handler(unsigned irq, struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_get_chip(irq);
 	struct sunxi_pinctrl *pctl = irq_get_handler_data(irq);
-	const unsigned long reg = readl(pctl->membase + IRQ_STATUS_REG);
+	unsigned long bank, reg, val;
+
+	for (bank = 0; bank < pctl->desc->irq_banks; bank++)
+		if (irq == pctl->irq[bank])
+			break;
+
+	if (bank == pctl->desc->irq_banks)
+		return;
+
+	reg = sunxi_irq_status_reg_from_bank(bank);
+	val = readl(pctl->membase + reg);
 
 	/* Clear all interrupts */
-	writel(reg, pctl->membase + IRQ_STATUS_REG);
+	writel(val, pctl->membase + reg);
 
-	if (reg) {
+	if (val) {
 		int irqoffset;
 
 		chained_irq_enter(chip, desc);
-		for_each_set_bit(irqoffset, &reg, SUNXI_IRQ_NUMBER) {
-			int pin_irq = irq_find_mapping(pctl->domain, irqoffset);
+		for_each_set_bit(irqoffset, &val, IRQ_PER_BANK) {
+			int pin_irq = irq_find_mapping(pctl->domain,
+						       bank * IRQ_PER_BANK + irqoffset);
 			generic_handle_irq(pin_irq);
 		}
 		chained_irq_exit(chip, desc);
@@ -712,8 +723,11 @@ static int sunxi_pinctrl_build_state(struct platform_device *pdev)
 
 		while (func->name) {
 			/* Create interrupt mapping while we're at it */
-			if (!strcmp(func->name, "irq"))
-				pctl->irq_array[func->irqnum] = pin->pin.number;
+			if (!strcmp(func->name, "irq")) {
+				int irqnum = func->irqnum + func->irqbank * IRQ_PER_BANK;
+				pctl->irq_array[irqnum] = pin->pin.number;
+			}
+
 			sunxi_pinctrl_add_function(pctl, func->name);
 			func++;
 		}
@@ -783,6 +797,13 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 	pctl->dev = &pdev->dev;
 	pctl->desc = desc;
 
+	pctl->irq_array = devm_kcalloc(&pdev->dev,
+				       IRQ_PER_BANK * pctl->desc->irq_banks,
+				       sizeof(*pctl->irq_array),
+				       GFP_KERNEL);
+	if (!pctl->irq_array)
+		return -ENOMEM;
+
 	ret = sunxi_pinctrl_build_state(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "dt probe failed: %d\n", ret);
@@ -867,21 +888,34 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 	if (ret)
 		goto gpiochip_error;
 
-	pctl->irq = irq_of_parse_and_map(node, 0);
+	pctl->irq = devm_kcalloc(&pdev->dev,
+				 pctl->desc->irq_banks,
+				 sizeof(*pctl->irq),
+				 GFP_KERNEL);
 	if (!pctl->irq) {
-		ret = -EINVAL;
+		ret = -ENOMEM;
 		goto clk_error;
 	}
 
-	pctl->domain = irq_domain_add_linear(node, SUNXI_IRQ_NUMBER,
-					     &irq_domain_simple_ops, NULL);
+	for (i = 0; i < pctl->desc->irq_banks; i++) {
+		pctl->irq[i] = platform_get_irq(pdev, i);
+		if (pctl->irq[i] < 0) {
+			ret = pctl->irq[i];
+			goto clk_error;
+		}
+	}
+
+	pctl->domain = irq_domain_add_linear(node,
+					     pctl->desc->irq_banks * IRQ_PER_BANK,
+					     &irq_domain_simple_ops,
+					     NULL);
 	if (!pctl->domain) {
 		dev_err(&pdev->dev, "Couldn't register IRQ domain\n");
 		ret = -ENOMEM;
 		goto clk_error;
 	}
 
-	for (i = 0; i < SUNXI_IRQ_NUMBER; i++) {
+	for (i = 0; i < (pctl->desc->irq_banks * IRQ_PER_BANK); i++) {
 		int irqno = irq_create_mapping(pctl->domain, i);
 
 		irq_set_chip_and_handler(irqno, &sunxi_pinctrl_irq_chip,
@@ -889,8 +923,11 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 		irq_set_chip_data(irqno, pctl);
 	};
 
-	irq_set_chained_handler(pctl->irq, sunxi_pinctrl_irq_handler);
-	irq_set_handler_data(pctl->irq, pctl);
+	for (i = 0; i < pctl->desc->irq_banks; i++) {
+		irq_set_chained_handler(pctl->irq[i],
+					sunxi_pinctrl_irq_handler);
+		irq_set_handler_data(pctl->irq[i], pctl);
+	}
 
 	dev_info(&pdev->dev, "initialized sunXi PIO driver\n");
 
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index 7ddcce0f3c27..4245b96c7996 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -53,7 +53,7 @@
 #define PULL_PINS_BITS		2
 #define PULL_PINS_MASK		0x03
 
-#define SUNXI_IRQ_NUMBER	32
+#define IRQ_PER_BANK		32
 
 #define IRQ_CFG_REG		0x200
 #define IRQ_CFG_IRQ_PER_REG		8
@@ -68,6 +68,8 @@
 #define IRQ_STATUS_IRQ_BITS		1
 #define IRQ_STATUS_IRQ_MASK		((1 << IRQ_STATUS_IRQ_BITS) - 1)
 
+#define IRQ_MEM_SIZE		0x20
+
 #define IRQ_EDGE_RISING		0x00
 #define IRQ_EDGE_FALLING	0x01
 #define IRQ_LEVEL_HIGH		0x02
@@ -115,8 +117,8 @@ struct sunxi_pinctrl {
 	unsigned			nfunctions;
 	struct sunxi_pinctrl_group	*groups;
 	unsigned			ngroups;
-	int				irq;
-	int				irq_array[SUNXI_IRQ_NUMBER];
+	int				*irq;
+	unsigned			*irq_array;
 	spinlock_t			lock;
 	struct pinctrl_dev		*pctl_dev;
 };
@@ -228,8 +230,10 @@ static inline u32 sunxi_pull_offset(u16 pin)
 
 static inline u32 sunxi_irq_cfg_reg(u16 irq)
 {
-	u8 reg = irq / IRQ_CFG_IRQ_PER_REG * 0x04;
-	return reg + IRQ_CFG_REG;
+	u8 bank = irq / IRQ_PER_BANK;
+	u8 reg = (irq % IRQ_PER_BANK) / IRQ_CFG_IRQ_PER_REG * 0x04;
+
+	return IRQ_CFG_REG + bank * IRQ_MEM_SIZE + reg;
 }
 
 static inline u32 sunxi_irq_cfg_offset(u16 irq)
@@ -238,10 +242,16 @@ static inline u32 sunxi_irq_cfg_offset(u16 irq)
 	return irq_num * IRQ_CFG_IRQ_BITS;
 }
 
+static inline u32 sunxi_irq_ctrl_reg_from_bank(u8 bank)
+{
+	return IRQ_CTRL_REG + bank * IRQ_MEM_SIZE;
+}
+
 static inline u32 sunxi_irq_ctrl_reg(u16 irq)
 {
-	u8 reg = irq / IRQ_CTRL_IRQ_PER_REG * 0x04;
-	return reg + IRQ_CTRL_REG;
+	u8 bank = irq / IRQ_PER_BANK;
+
+	return sunxi_irq_ctrl_reg_from_bank(bank);
 }
 
 static inline u32 sunxi_irq_ctrl_offset(u16 irq)
@@ -250,10 +260,16 @@ static inline u32 sunxi_irq_ctrl_offset(u16 irq)
 	return irq_num * IRQ_CTRL_IRQ_BITS;
 }
 
+static inline u32 sunxi_irq_status_reg_from_bank(u8 bank)
+{
+	return IRQ_STATUS_REG + bank * IRQ_MEM_SIZE;
+}
+
 static inline u32 sunxi_irq_status_reg(u16 irq)
 {
-	u8 reg = irq / IRQ_STATUS_IRQ_PER_REG * 0x04;
-	return reg + IRQ_STATUS_REG;
+	u8 bank = irq / IRQ_PER_BANK;
+
+	return sunxi_irq_status_reg_from_bank(bank);
 }
 
 static inline u32 sunxi_irq_status_offset(u16 irq)
-- 
2.0.0
