From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 16 Mar 2018 22:02:08 +0800
Subject: [PATCH v4 2/9] pinctrl: sunxi: introduce IRQ bank conversion function
In-Reply-To: <20180316140215.28663-1-icenowy@aosc.io>
References: <20180316140215.28663-1-icenowy@aosc.io>
Message-ID: <20180316140215.28663-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner H6 SoC have its pin controllers with the first IRQ-capable
GPIO bank at IRQ bank 1 and the second bank at IRQ bank 5. Some
refactors in the sunxi pinctrl framework are needed.

This commit introduces a IRQ bank conversion function, which replaces
the "(bank_base + bank)" code in IRQ register access.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Extracted in v4.

 drivers/pinctrl/sunxi/pinctrl-sunxi.h | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index a13bd57d880d..466840d886f6 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -263,14 +263,19 @@ static inline u32 sunxi_pull_offset(u16 pin)
 	return pin_num * PULL_PINS_BITS;
 }
 
+static inline u32 sunxi_irq_hw_bank_num(const struct sunxi_pinctrl_desc *desc, u8 bank)
+{
+	return desc->irq_bank_base + bank;
+}
+
 static inline u32 sunxi_irq_cfg_reg(const struct sunxi_pinctrl_desc *desc,
 				    u16 irq)
 {
-	unsigned bank_base = desc->irq_bank_base;
 	u8 bank = irq / IRQ_PER_BANK;
 	u8 reg = (irq % IRQ_PER_BANK) / IRQ_CFG_IRQ_PER_REG * 0x04;
 
-	return IRQ_CFG_REG + (bank_base + bank) * IRQ_MEM_SIZE + reg;
+	return IRQ_CFG_REG +
+	       sunxi_irq_hw_bank_num(desc, bank) * IRQ_MEM_SIZE + reg;
 }
 
 static inline u32 sunxi_irq_cfg_offset(u16 irq)
@@ -281,9 +286,7 @@ static inline u32 sunxi_irq_cfg_offset(u16 irq)
 
 static inline u32 sunxi_irq_ctrl_reg_from_bank(const struct sunxi_pinctrl_desc *desc, u8 bank)
 {
-	unsigned bank_base = desc->irq_bank_base;
-
-	return IRQ_CTRL_REG + (bank_base + bank) * IRQ_MEM_SIZE;
+	return IRQ_CTRL_REG + sunxi_irq_hw_bank_num(desc, bank) * IRQ_MEM_SIZE;
 }
 
 static inline u32 sunxi_irq_ctrl_reg(const struct sunxi_pinctrl_desc *desc,
@@ -302,16 +305,14 @@ static inline u32 sunxi_irq_ctrl_offset(u16 irq)
 
 static inline u32 sunxi_irq_debounce_reg_from_bank(const struct sunxi_pinctrl_desc *desc, u8 bank)
 {
-	unsigned bank_base = desc->irq_bank_base;
-
-	return IRQ_DEBOUNCE_REG + (bank_base + bank) * IRQ_MEM_SIZE;
+	return IRQ_DEBOUNCE_REG +
+	       sunxi_irq_hw_bank_num(desc, bank) * IRQ_MEM_SIZE;
 }
 
 static inline u32 sunxi_irq_status_reg_from_bank(const struct sunxi_pinctrl_desc *desc, u8 bank)
 {
-	unsigned bank_base = desc->irq_bank_base;
-
-	return IRQ_STATUS_REG + (bank_base + bank) * IRQ_MEM_SIZE;
+	return IRQ_STATUS_REG +
+	       sunxi_irq_hw_bank_num(desc, bank) * IRQ_MEM_SIZE;
 }
 
 static inline u32 sunxi_irq_status_reg(const struct sunxi_pinctrl_desc *desc,
-- 
2.15.1
