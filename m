From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 11 Nov 2011 20:20:25 +0800
Subject: [PATCH] ARM: mmp: fix gpio-pxa.h build errors
Message-ID: <1321014025-6481-1-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the build errors as below:

In file included from arch/arm/mach-mmp/include/mach/gpio.h:12:0,
                 from arch/arm/include/asm/gpio.h:5,
                 from include/linux/gpio.h:30,
                 from arch/arm/mach-mmp/aspenite.c:11:
arch/arm/plat-pxa/include/plat/gpio.h: In function ?gpio_get_value?:
arch/arm/plat-pxa/include/plat/gpio.h:12:21: error: invalid operands to binary & (have ?void *? and ?int?)
arch/arm/plat-pxa/include/plat/gpio.h: In function ?gpio_set_value?:
arch/arm/plat-pxa/include/plat/gpio.h:21:15: error: lvalue required as left operand of assignment
arch/arm/plat-pxa/include/plat/gpio.h:23:15: error: lvalue required as left operand of assignment

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-mmp/include/mach/gpio-pxa.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/gpio-pxa.h b/arch/arm/mach-mmp/include/mach/gpio-pxa.h
index d14eeaf..99b4ce1 100644
--- a/arch/arm/mach-mmp/include/mach/gpio-pxa.h
+++ b/arch/arm/mach-mmp/include/mach/gpio-pxa.h
@@ -7,7 +7,7 @@
 #define GPIO_REGS_VIRT	(APB_VIRT_BASE + 0x19000)
 
 #define BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
-#define GPIO_REG(x)	(GPIO_REGS_VIRT + (x))
+#define GPIO_REG(x)	(*(volatile u32 *)(GPIO_REGS_VIRT + (x)))
 
 #define NR_BUILTIN_GPIO		IRQ_GPIO_NUM
 
-- 
1.7.5.4
