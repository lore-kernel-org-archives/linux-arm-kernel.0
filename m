From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 17 Feb 2011 09:54:47 +0100
Subject: [PATCH 2/2] plat-nomadik: fix compilation warning
Message-ID: <1297932887-5407-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The compiler warns that [rf]wimsc may be used uninitialized in
this function - the warning is actually false since the uses are
in identical if()-clauses, but it can't hurt very much to read
out the values to be modified early anyway and rid the warning.

Cc: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/plat-nomadik/gpio.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 5e6653f..45b1cf9 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -134,15 +134,12 @@ static void __nmk_gpio_set_mode_safe(struct nmk_gpio_chip *nmk_chip,
 				     unsigned offset, int gpio_mode,
 				     bool glitch)
 {
-	u32 rwimsc;
-	u32 fwimsc;
+	u32 rwimsc = readl(nmk_chip->addr + NMK_GPIO_RWIMSC);
+	u32 fwimsc = readl(nmk_chip->addr + NMK_GPIO_FWIMSC);
 
 	if (glitch && nmk_chip->set_ioforce) {
 		u32 bit = BIT(offset);
 
-		rwimsc = readl(nmk_chip->addr + NMK_GPIO_RWIMSC);
-		fwimsc = readl(nmk_chip->addr + NMK_GPIO_FWIMSC);
-
 		/* Prevent spurious wakeups */
 		writel(rwimsc & ~bit, nmk_chip->addr + NMK_GPIO_RWIMSC);
 		writel(fwimsc & ~bit, nmk_chip->addr + NMK_GPIO_FWIMSC);
-- 
1.7.3.2
