From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 30 Mar 2010 16:11:56 -0700
Subject: [PATCH 3/4] arm: msm: trout: add trout specific gpio interrupts
In-Reply-To: <1269990717-2969-2-git-send-email-dwalker@codeaurora.org>
References: <> <1269990717-2969-1-git-send-email-dwalker@codeaurora.org>
	<1269990717-2969-2-git-send-email-dwalker@codeaurora.org>
Message-ID: <1269990717-2969-3-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Walker <c_dwalke@quicinc.com>

This adds the interrupt layer onto the initial trout gpio
changes.

There changes were adapted from the Google driver which lists
Arve Hj?nnev?g <arve@android.com> as the author.

Signed-off-by: Daniel Walker <c_dwalke@quicinc.com>
---
 arch/arm/mach-msm/board-trout-gpio.c |  114 ++++++++++++++++++++++++++++++++++
 1 files changed, 114 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/board-trout-gpio.c b/arch/arm/mach-msm/board-trout-gpio.c
index 6e6bc76..99965b2 100644
--- a/arch/arm/mach-msm/board-trout-gpio.c
+++ b/arch/arm/mach-msm/board-trout-gpio.c
@@ -19,6 +19,15 @@
 
 #include "board-trout.h"
 
+static uint8_t trout_int_mask[2] = {
+	[0] = 0xff, /* mask all interrupts */
+	[1] = 0xff,
+};
+static uint8_t trout_sleep_int_mask[] = {
+	[0] = 0xff,
+	[1] = 0xff,
+};
+
 struct msm_gpio_chip {
 	struct gpio_chip	chip;
 	void __iomem		*reg;	/* Base of register bank */
@@ -95,16 +104,121 @@ static struct msm_gpio_chip msm_gpio_banks[] = {
         TROUT_GPIO_BANK("VIRTUAL", 0x12, TROUT_GPIO_VIRTUAL_BASE, 0),
 };
 
+static void trout_gpio_irq_ack(unsigned int irq)
+{
+	int bank = TROUT_INT_TO_BANK(irq);
+	uint8_t mask = TROUT_INT_TO_MASK(irq);
+	int reg = TROUT_BANK_TO_STAT_REG(bank);
+	/*printk(KERN_INFO "trout_gpio_irq_ack irq %d\n", irq);*/
+	writeb(mask, TROUT_CPLD_BASE + reg);
+}
+
+static void trout_gpio_irq_mask(unsigned int irq)
+{
+	unsigned long flags;
+	uint8_t reg_val;
+	int bank = TROUT_INT_TO_BANK(irq);
+	uint8_t mask = TROUT_INT_TO_MASK(irq);
+	int reg = TROUT_BANK_TO_MASK_REG(bank);
+
+	local_irq_save(flags);
+	reg_val = trout_int_mask[bank] |= mask;
+	/*printk(KERN_INFO "trout_gpio_irq_mask irq %d => %d:%02x\n",
+	       irq, bank, reg_val);*/
+	writeb(reg_val, TROUT_CPLD_BASE + reg);
+	local_irq_restore(flags);
+}
+
+static void trout_gpio_irq_unmask(unsigned int irq)
+{
+	unsigned long flags;
+	uint8_t reg_val;
+	int bank = TROUT_INT_TO_BANK(irq);
+	uint8_t mask = TROUT_INT_TO_MASK(irq);
+	int reg = TROUT_BANK_TO_MASK_REG(bank);
+
+	local_irq_save(flags);
+	reg_val = trout_int_mask[bank] &= ~mask;
+	/*printk(KERN_INFO "trout_gpio_irq_unmask irq %d => %d:%02x\n",
+	       irq, bank, reg_val);*/
+	writeb(reg_val, TROUT_CPLD_BASE + reg);
+	local_irq_restore(flags);
+}
+
+int trout_gpio_irq_set_wake(unsigned int irq, unsigned int on)
+{
+	unsigned long flags;
+	int bank = TROUT_INT_TO_BANK(irq);
+	uint8_t mask = TROUT_INT_TO_MASK(irq);
+
+	local_irq_save(flags);
+	if(on)
+		trout_sleep_int_mask[bank] &= ~mask;
+	else
+		trout_sleep_int_mask[bank] |= mask;
+	local_irq_restore(flags);
+	return 0;
+}
+
+static void trout_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	int j, m;
+	unsigned v;
+	int bank;
+	int stat_reg;
+	int int_base = TROUT_INT_START;
+	uint8_t int_mask;
+
+	for (bank = 0; bank < 2; bank++) {
+		stat_reg = TROUT_BANK_TO_STAT_REG(bank);
+		v = readb(TROUT_CPLD_BASE + stat_reg);
+		int_mask = trout_int_mask[bank];
+		if (v & int_mask) {
+			writeb(v & int_mask, TROUT_CPLD_BASE + stat_reg);
+			printk(KERN_ERR "trout_gpio_irq_handler: got masked "
+			       "interrupt: %d:%02x\n", bank, v & int_mask);
+		}
+		v &= ~int_mask;
+		while (v) {
+			m = v & -v;
+			j = fls(m) - 1;
+			/*printk(KERN_INFO "msm_gpio_irq_handler %d:%02x %02x b"
+			       "it %d irq %d\n", bank, v, m, j, int_base + j);*/
+			v &= ~m;
+			generic_handle_irq(int_base + j);
+		}
+		int_base += TROUT_INT_BANK0_COUNT;
+	}
+	desc->chip->ack(irq);
+}
+
+static struct irq_chip trout_gpio_irq_chip = {
+	.name      = "troutgpio",
+	.ack       = trout_gpio_irq_ack,
+	.mask      = trout_gpio_irq_mask,
+	.unmask    = trout_gpio_irq_unmask,
+	.set_wake  = trout_gpio_irq_set_wake,
+};
+
 /*
  * Called from the processor-specific init to enable GPIO pin support.
  */
 int __init trout_init_gpio(void)
 {
         int i;
+	for(i = TROUT_INT_START; i <= TROUT_INT_END; i++) {
+		set_irq_chip(i, &trout_gpio_irq_chip);
+		set_irq_handler(i, handle_edge_irq);
+		set_irq_flags(i, IRQF_VALID);
+	}
 
         for (i = 0; i < ARRAY_SIZE(msm_gpio_banks); i++)
                 gpiochip_add(&msm_gpio_banks[i].chip);
 
+	set_irq_type(MSM_GPIO_TO_INT(17), IRQF_TRIGGER_HIGH);
+	set_irq_chained_handler(MSM_GPIO_TO_INT(17), trout_gpio_irq_handler);
+	set_irq_wake(MSM_GPIO_TO_INT(17), 1);
+
 	return 0;
 }
 
-- 
1.6.2.3
