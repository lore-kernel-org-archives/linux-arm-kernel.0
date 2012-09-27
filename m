From: Barry.Song@csr.com (Barry Song)
Date: Thu, 27 Sep 2012 17:55:17 +0800
Subject: [PATCH 3/6] pinctrl: sirf: fix spinlock deadlock in
 sirfsoc_gpio_set_input
Message-ID: <1348739717-21148-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

sirfsoc_gpio_set_input() is called in those functions which have
held the spinlock, so delete the duplicated locking.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/pinctrl-sirf.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sirf.c b/drivers/pinctrl/pinctrl-sirf.c
index 6634944..6eae934 100644
--- a/drivers/pinctrl/pinctrl-sirf.c
+++ b/drivers/pinctrl/pinctrl-sirf.c
@@ -1514,15 +1514,10 @@ static void sirfsoc_gpio_handle_irq(unsigned int irq, struct irq_desc *desc)
 static inline void sirfsoc_gpio_set_input(struct sirfsoc_gpio_bank *bank, unsigned ctrl_offset)
 {
 	u32 val;
-	unsigned long flags;
-
-	spin_lock_irqsave(&bank->lock, flags);
 
 	val = readl(bank->chip.regs + ctrl_offset);
 	val &= ~SIRFSOC_GPIO_CTL_OUT_EN_MASK;
 	writel(val, bank->chip.regs + ctrl_offset);
-
-	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
 static int sirfsoc_gpio_request(struct gpio_chip *chip, unsigned offset)
-- 
1.7.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
