From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed,  9 Nov 2011 10:47:21 +0800
Subject: [PATCH v7 01/11] ARM: mmp: fix build error on gpio
In-Reply-To: <1320806851-13928-1-git-send-email-haojian.zhuang@marvell.com>
References: <1320806851-13928-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1320806851-13928-2-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Parameters of GPIO_REG() should be assigned as volatile.

arch/arm/plat-pxa/include/plat/gpio.h: In function ?gpio_get_value?:
arch/arm/plat-pxa/include/plat/gpio.h:12:21: error: invalid operands to
binary & (have ?void *? and ?int?)
arch/arm/plat-pxa/include/plat/gpio.h: In function ?gpio_set_value?:
arch/arm/plat-pxa/include/plat/gpio.h:21:4: error: lvalue required as
left operand of assignment
arch/arm/plat-pxa/include/plat/gpio.h:23:4: error: lvalue required as
left operand of assignment

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
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
1.7.4.1
