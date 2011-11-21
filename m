From: zhangwm@marvell.com (Neil Zhang)
Date: Mon, 21 Nov 2011 11:32:43 +0800
Subject: [PATCH V1] ARM: mmp: fix gpio operation error
Message-ID: <1321846364-30466-1-git-send-email-zhangwm@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following build error on Marvell mmp platform.

In file included from arch/arm/mach-mmp/include/mach/gpio.h:12,
                 from /home/zhangwm/Public/linux-3.0/arch/arm/include/asm/gpio.h:5,
		 from include/linux/gpio.h:30,
		 from arch/arm/mach-mmp/tavorevb.c:10:
arch/arm/plat-pxa/include/plat/gpio.h: In function 'gpio_get_value':
arch/arm/plat-pxa/include/plat/gpio.h:12: error: invalid operands to
binary & (have 'void *' and 'int')
arch/arm/plat-pxa/include/plat/gpio.h: In function 'gpio_set_value':
arch/arm/plat-pxa/include/plat/gpio.h:21: error: lvalue required as left
operand of assignment
arch/arm/plat-pxa/include/plat/gpio.h:23: error: lvalue required as left
operand of assignment
make[1]: *** [arch/arm/mach-mmp/tavorevb.o] Error 1
make: *** [arch/arm/mach-mmp] Error 2

Signed-off-by: Neil Zhang <zhangwm@marvell.com>
---
 arch/arm/mach-mmp/include/mach/gpio-pxa.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/gpio-pxa.h b/arch/arm/mach-mmp/include/mach/gpio-pxa.h
index d14eeaf..c017a98 100644
--- a/arch/arm/mach-mmp/include/mach/gpio-pxa.h
+++ b/arch/arm/mach-mmp/include/mach/gpio-pxa.h
@@ -7,7 +7,7 @@
 #define GPIO_REGS_VIRT	(APB_VIRT_BASE + 0x19000)
 
 #define BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
-#define GPIO_REG(x)	(GPIO_REGS_VIRT + (x))
+#define GPIO_REG(x)	(*((volatile u32 *)(GPIO_REGS_VIRT + (x))))
 
 #define NR_BUILTIN_GPIO		IRQ_GPIO_NUM
 
-- 
1.7.4.1
