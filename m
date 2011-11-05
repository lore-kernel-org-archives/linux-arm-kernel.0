From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 05 Nov 2011 22:29:34 +0000
Subject: [PATCH 1/2] ARM: PXA: fix gpio-pxa.h build errors
In-Reply-To: <20111105222832.GH12913@n2100.arm.linux.org.uk>
References: <20111105222832.GH12913@n2100.arm.linux.org.uk>
Message-ID: <E1RMok2-0000KQ-9j@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A mismerge in 43872fa (Merge branch 'depends/rmk/gpio' into next/fixes)
causes these build errors:

In file included from arch/arm/mach-pxa/include/mach/gpio.h:30,
                 from arch/arm/include/asm/gpio.h:6,
                 from include/linux/gpio.h:31,
                 from arch/arm/mach-pxa/generic.c:20:
arch/arm/mach-pxa/include/mach/gpio-pxa.h: In function ?__gpio_is_occupied?:
arch/arm/mach-pxa/include/mach/gpio-pxa.h:121: error: invalid operands to binary >> (have ?void *? and ?unsigned int?)
arch/arm/mach-pxa/include/mach/gpio-pxa.h:122: error: invalid operands to binary & (have ?void *? and ?int?)
arch/arm/mach-pxa/include/mach/gpio-pxa.h:129: error: invalid operands to binary & (have ?void *? and ?int?)

So fix them.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-pxa/include/mach/gpio-pxa.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/gpio-pxa.h b/arch/arm/mach-pxa/include/mach/gpio-pxa.h
index 576868f..41b4c93 100644
--- a/arch/arm/mach-pxa/include/mach/gpio-pxa.h
+++ b/arch/arm/mach-pxa/include/mach/gpio-pxa.h
@@ -25,7 +25,7 @@
 #define GPIO_REGS_VIRT	io_p2v(0x40E00000)
 
 #define BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
-#define GPIO_REG(x)	(GPIO_REGS_VIRT + (x))
+#define GPIO_REG(x)	(*(volatile u32 *)(GPIO_REGS_VIRT + (x)))
 
 /* GPIO Pin Level Registers */
 #define GPLR0		GPIO_REG(BANK_OFF(0) + 0x00)
-- 
1.7.4.4
