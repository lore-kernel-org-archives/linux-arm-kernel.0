From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  4 Feb 2014 13:30:05 +0100
Subject: [PATCH] ARM: pxa: fix compilation problem on AM300EPD board
Message-ID: <1391517005-12004-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board fails compilation like this:
arch/arm/mach-pxa/am300epd.c: In function ?am300_cleanup?:
arch/arm/mach-pxa/am300epd.c:179:2: error: implicit declaration
of function ?PXA_GPIO_TO_IRQ? [-Werror=implicit-function-declaration]
  free_irq(PXA_GPIO_TO_IRQ(RDY_GPIO_PIN), par);

This was caused by commit 88f718e3fa4d67f3a8dbe79a2f97d722323e4051
"ARM: pxa: delete the custom GPIO header"

This is because it was previously getting the macro PXA_GPIO_TO_IRQ
implicitly from <linux/gpio.h> which in turn implicitly included
<mach/gpio.h> which in turn included <mach/irqs.h>.

Add the missing include so that the board compiles again.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi ARM SoC folks: please apply this patch directly to the ARM
SoC tree fixes branch if you are happy with it.
---
 arch/arm/mach-pxa/am300epd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-pxa/am300epd.c b/arch/arm/mach-pxa/am300epd.c
index c9f309ae88c5..8b90c4f2d430 100644
--- a/arch/arm/mach-pxa/am300epd.c
+++ b/arch/arm/mach-pxa/am300epd.c
@@ -30,6 +30,7 @@
 
 #include <mach/gumstix.h>
 #include <mach/mfp-pxa25x.h>
+#include <mach/irqs.h>
 #include <linux/platform_data/video-pxafb.h>
 
 #include "generic.h"
-- 
1.8.5.3
