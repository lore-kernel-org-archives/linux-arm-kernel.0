From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 02 Jul 2012 23:40:14 +0200
Subject: [PATCH] ARM: mmp: remove mach/gpio-pxa.h
Message-ID: <1341265214.1911.151.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 157d2644cb0c1e71a18baaffca56d2b1d0ebf10f ("ARM: pxa: change gpio
to platform device") removed all includes of mach/gpio-pxa.h. It kept
this unused header in the tree. Using it can't work, as it itself
includes the non-existent header plat/gpio-pxa.h. This header can safely
be removed.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested only with various git commands on the (history of the) tree.

 arch/arm/mach-mmp/include/mach/gpio-pxa.h |   29 -----------------------------
 1 files changed, 0 insertions(+), 29 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/gpio-pxa.h

diff --git a/arch/arm/mach-mmp/include/mach/gpio-pxa.h b/arch/arm/mach-mmp/include/mach/gpio-pxa.h
deleted file mode 100644
index 0e135a5..0000000
--- a/arch/arm/mach-mmp/include/mach/gpio-pxa.h
+++ /dev/null
@@ -1,29 +0,0 @@
-#ifndef __ASM_MACH_GPIO_PXA_H
-#define __ASM_MACH_GPIO_PXA_H
-
-#include <mach/addr-map.h>
-#include <mach/cputype.h>
-#include <mach/irqs.h>
-
-#define GPIO_REGS_VIRT	(APB_VIRT_BASE + 0x19000)
-
-#define BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
-#define GPIO_REG(x)	(*(volatile u32 *)(GPIO_REGS_VIRT + (x)))
-
-#define gpio_to_bank(gpio)	((gpio) >> 5)
-
-/* NOTE: these macros are defined here to make optimization of
- * gpio_{get,set}_value() to work when 'gpio' is a constant.
- * Usage of these macros otherwise is no longer recommended,
- * use generic GPIO API whenever possible.
- */
-#define GPIO_bit(gpio)	(1 << ((gpio) & 0x1f))
-
-#define GPLR(x)		GPIO_REG(BANK_OFF(gpio_to_bank(x)) + 0x00)
-#define GPDR(x)		GPIO_REG(BANK_OFF(gpio_to_bank(x)) + 0x0c)
-#define GPSR(x)		GPIO_REG(BANK_OFF(gpio_to_bank(x)) + 0x18)
-#define GPCR(x)		GPIO_REG(BANK_OFF(gpio_to_bank(x)) + 0x24)
-
-#include <plat/gpio-pxa.h>
-
-#endif /* __ASM_MACH_GPIO_PXA_H */
-- 
1.7.7.6
