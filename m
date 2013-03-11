From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon, 11 Mar 2013 22:23:45 +0800
Subject: [PATCH -next] pinctrl: sirf: using for_each_set_bit to simplify the
 code
Message-ID: <CAPgLHd9n7nmyhUcRgPwEyjweZKA+fgi409yEJgK6LmF2Wu6n-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Using for_each_set_bit() to simplify the code.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/pinctrl/pinctrl-sirf.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sirf.c b/drivers/pinctrl/pinctrl-sirf.c
index 498b2ba..d6cf500 100644
--- a/drivers/pinctrl/pinctrl-sirf.c
+++ b/drivers/pinctrl/pinctrl-sirf.c
@@ -1669,15 +1669,12 @@ static void sirfsoc_gpio_set_pullup(const u32 *pullups)
 	const unsigned long *p = (const unsigned long *)pullups;
 
 	for (i = 0; i < SIRFSOC_GPIO_NO_OF_BANKS; i++) {
-		n = find_first_bit(p + i, BITS_PER_LONG);
-		while (n < BITS_PER_LONG) {
+		for_each_set_bit(n, p + i, BITS_PER_LONG) {
 			u32 offset = SIRFSOC_GPIO_CTRL(i, n);
 			u32 val = readl(sgpio_bank[i].chip.regs + offset);
 			val |= SIRFSOC_GPIO_CTL_PULL_MASK;
 			val |= SIRFSOC_GPIO_CTL_PULL_HIGH;
 			writel(val, sgpio_bank[i].chip.regs + offset);
-
-			n = find_next_bit(p + i, BITS_PER_LONG, n + 1);
 		}
 	}
 }
@@ -1688,15 +1685,12 @@ static void sirfsoc_gpio_set_pulldown(const u32 *pulldowns)
 	const unsigned long *p = (const unsigned long *)pulldowns;
 
 	for (i = 0; i < SIRFSOC_GPIO_NO_OF_BANKS; i++) {
-		n = find_first_bit(p + i, BITS_PER_LONG);
-		while (n < BITS_PER_LONG) {
+		for_each_set_bit(n, p + i, BITS_PER_LONG) {
 			u32 offset = SIRFSOC_GPIO_CTRL(i, n);
 			u32 val = readl(sgpio_bank[i].chip.regs + offset);
 			val |= SIRFSOC_GPIO_CTL_PULL_MASK;
 			val &= ~SIRFSOC_GPIO_CTL_PULL_HIGH;
 			writel(val, sgpio_bank[i].chip.regs + offset);
-
-			n = find_next_bit(p + i, BITS_PER_LONG, n + 1);
 		}
 	}
 }
