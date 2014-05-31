From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 31 May 2014 16:01:35 +0200
Subject: [PATCH v2 1/5] pinctrl: sunxi: Fix sunxi_irq_cfg_reg not working for
 irqs >= 8
In-Reply-To: <1401544899-405-1-git-send-email-hdegoede@redhat.com>
References: <1401544899-405-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1401544899-405-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename SUNXI_IRQ_NUMBER to IRQ_PER_BANK as it no longer represents the total
number of irqs and use it instead of the number of irqs-per-reg when
calculating the bank to use for the various sunxi_irq_xxx_reg functions.
This fixes sunxi_irq_cfg_reg using the wrong bank for irqs >= 8.

Also sunxi_irq_cfg_reg_from_bank returns the address of pio_int_cfg0, add an
offset to the register returned for irqs living in the pio_int_cfg[1-3].

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 12 ++++++------
 drivers/pinctrl/sunxi/pinctrl-sunxi.h | 11 ++++++-----
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 8dc2cd9..d989a10 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -655,9 +655,9 @@ static void sunxi_pinctrl_irq_handler(unsigned irq, struct irq_desc *desc)
 		int irqoffset;
 
 		chained_irq_enter(chip, desc);
-		for_each_set_bit(irqoffset, &val, SUNXI_IRQ_NUMBER) {
+		for_each_set_bit(irqoffset, &val, IRQ_PER_BANK) {
 			int pin_irq = irq_find_mapping(pctl->domain,
-						       bank * SUNXI_IRQ_NUMBER + irqoffset);
+						       bank * IRQ_PER_BANK + irqoffset);
 			generic_handle_irq(pin_irq);
 		}
 		chained_irq_exit(chip, desc);
@@ -726,7 +726,7 @@ static int sunxi_pinctrl_build_state(struct platform_device *pdev)
 		while (func->name) {
 			/* Create interrupt mapping while we're at it */
 			if (!strcmp(func->name, "irq")) {
-				int irqnum = func->irqnum + func->irqbank * SUNXI_IRQ_NUMBER;
+				int irqnum = func->irqnum + func->irqbank * IRQ_PER_BANK;
 				pctl->irq_array[irqnum] = pin->pin.number;
 			}
 
@@ -800,7 +800,7 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 	pctl->desc = desc;
 
 	pctl->irq_array = devm_kcalloc(&pdev->dev,
-				       SUNXI_IRQ_NUMBER * pctl->desc->irq_banks,
+				       IRQ_PER_BANK * pctl->desc->irq_banks,
 				       sizeof(*pctl->irq_array),
 				       GFP_KERNEL);
 	if (!pctl->irq_array)
@@ -908,7 +908,7 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 	}
 
 	pctl->domain = irq_domain_add_linear(node,
-					     pctl->desc->irq_banks * SUNXI_IRQ_NUMBER,
+					     pctl->desc->irq_banks * IRQ_PER_BANK,
 					     &irq_domain_simple_ops,
 					     NULL);
 	if (!pctl->domain) {
@@ -917,7 +917,7 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 		goto clk_error;
 	}
 
-	for (i = 0; i < (pctl->desc->irq_banks * SUNXI_IRQ_NUMBER); i++) {
+	for (i = 0; i < (pctl->desc->irq_banks * IRQ_PER_BANK); i++) {
 		int irqno = irq_create_mapping(pctl->domain, i);
 
 		irq_set_chip_and_handler(irqno, &sunxi_pinctrl_irq_chip,
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index 8490a45..19b3ae8 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -53,7 +53,7 @@
 #define PULL_PINS_BITS		2
 #define PULL_PINS_MASK		0x03
 
-#define SUNXI_IRQ_NUMBER	32
+#define IRQ_PER_BANK		32
 
 #define IRQ_CFG_REG		0x200
 #define IRQ_CFG_IRQ_PER_REG		8
@@ -235,9 +235,10 @@ static inline u32 sunxi_irq_cfg_reg_from_bank(u8 bank)
 
 static inline u32 sunxi_irq_cfg_reg(u16 irq)
 {
-	u8 bank = irq / IRQ_CFG_IRQ_PER_REG;
+	u8 bank = irq / IRQ_PER_BANK;
+	u32 offset = ((irq % IRQ_PER_BANK) / IRQ_CFG_IRQ_PER_REG) * 0x04;
 
-	return sunxi_irq_cfg_reg_from_bank(bank);
+	return sunxi_irq_cfg_reg_from_bank(bank) + offset;
 }
 
 static inline u32 sunxi_irq_cfg_offset(u16 irq)
@@ -253,7 +254,7 @@ static inline u32 sunxi_irq_ctrl_reg_from_bank(u8 bank)
 
 static inline u32 sunxi_irq_ctrl_reg(u16 irq)
 {
-	u8 bank = irq / IRQ_CTRL_IRQ_PER_REG;
+	u8 bank = irq / IRQ_PER_BANK;
 
 	return sunxi_irq_ctrl_reg_from_bank(bank);
 }
@@ -271,7 +272,7 @@ static inline u32 sunxi_irq_status_reg_from_bank(u8 bank)
 
 static inline u32 sunxi_irq_status_reg(u16 irq)
 {
-	u8 bank = irq / IRQ_STATUS_IRQ_PER_REG;
+	u8 bank = irq / IRQ_PER_BANK;
 
 	return sunxi_irq_status_reg_from_bank(bank);
 }
-- 
2.0.0
