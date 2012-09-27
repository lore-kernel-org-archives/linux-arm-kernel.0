From: Barry.Song@csr.com (Barry Song)
Date: Thu, 27 Sep 2012 17:56:10 +0800
Subject: [PATCH 5/6] pinctrl: sirf: add lost chained_irq_enter and exit in
 sirfsoc_gpio_handle_irq
Message-ID: <1348739770-21218-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

This patch fixes the chained irq hang issue, tested by DM9000 driver using
GPIO0-3(irqnr=131) as the external IRQ on SiRFmarco:
   $ cat /proc/interrupts
               CPU0       CPU1
     32:       1608          0       GIC  sirfsoc_timer0
     33:          0       3197       GIC  sirfsoc_timer1
     50:      10207          0       GIC  sirfsoc-uart
     56:          2          0       GIC  cc0e0000.i2c
     70:         44          0       GIC  mmc0
    131:        333          0  sirf-gpio-irq  eth0
    ...

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/pinctrl-sirf.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sirf.c b/drivers/pinctrl/pinctrl-sirf.c
index 9a984e8..675497c 100644
--- a/drivers/pinctrl/pinctrl-sirf.c
+++ b/drivers/pinctrl/pinctrl-sirf.c
@@ -25,6 +25,7 @@
 #include <linux/bitops.h>
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
+#include <asm/mach/irq.h>
 
 #define DRIVER_NAME "pinmux-sirf"
 
@@ -1483,6 +1484,9 @@ static void sirfsoc_gpio_handle_irq(unsigned int irq, struct irq_desc *desc)
 	u32 status, ctrl;
 	int idx = 0;
 	unsigned int first_irq;
+	struct irq_chip *chip = irq_get_chip(irq);
+
+	chained_irq_enter(chip, desc);
 
 	status = readl(bank->chip.regs + SIRFSOC_GPIO_INT_STATUS(bank->id));
 	if (!status) {
@@ -1511,6 +1515,8 @@ static void sirfsoc_gpio_handle_irq(unsigned int irq, struct irq_desc *desc)
 		idx++;
 		status = status >> 1;
 	}
+
+	chained_irq_exit(chip, desc);
 }
 
 static inline void sirfsoc_gpio_set_input(struct sirfsoc_gpio_bank *bank, unsigned ctrl_offset)
-- 
1.7.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
