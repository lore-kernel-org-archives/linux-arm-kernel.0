From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Fri, 14 Sep 2012 10:30:35 +0800
Subject: [PATCH] ARM: at91/gpio: using for_each_set_bit to simplify the code
Message-ID: <CAPgLHd_AmmE0K597Q7uLrPFOFDYZ_WP7zKmGuEaMWN6KCknFVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Using for_each_set_bit() to simplify the code.

spatch with a semantic match is used to found this.
(http://coccinelle.lip6.fr/)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-at91/gpio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index be42cf0..ed6ed8c 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -609,10 +609,8 @@ static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 			continue;
 		}
 
-		n = find_first_bit(&isr, BITS_PER_LONG);
-		while (n < BITS_PER_LONG) {
+		for_each_set_bit(n, &isr, BITS_PER_LONG) {
 			generic_handle_irq(irq_find_mapping(at91_gpio->domain, n));
-			n = find_next_bit(&isr, BITS_PER_LONG, n + 1);
 		}
 	}
 	chained_irq_exit(chip, desc);
