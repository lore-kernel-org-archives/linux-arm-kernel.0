From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Sep 2016 12:13:06 +0200
Subject: [PATCH] pinctrl: stm32: add IRQ_DOMAIN_HIERARCHY dependency
Message-ID: <20160914101323.3254566-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added irqchip support for the stm32 pinctrl driver uses
hierarchical IRQ domains as provided by the NVIC primary irqchip.
This works great for any configuration that may be relevant on
stm32, but when doing compile-testing (randconfig), we can
enable it without NVIC or any other primary irqchip that
enables IRQ_DOMAIN_HIERARCHY:

drivers/pinctrl/stm32/pinctrl-stm32.c:212:13: error: 'irq_chip_eoi_parent' undeclared here (not in a function)
drivers/pinctrl/stm32/pinctrl-stm32.c:213:20: error: 'irq_chip_mask_parent' undeclared here (not in a function)
drivers/pinctrl/stm32/pinctrl-stm32.c:214:20: error: 'irq_chip_unmask_parent' undeclared here (not in a function)
drivers/pinctrl/stm32/pinctrl-stm32.c:215:20: error: 'irq_chip_set_type_parent' undeclared here (not in a function)

This adds a Kconfig dependency to limit compile-testing to
configurations that have IRQ_DOMAIN_HIERARCHY already enabled.
It's not obvious whether we should use 'depends on' or 'select'
here, I think either one works, with 'depends on' being more
intuitive, while 'select' would be less likely to cause dependency
loops.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 0eb9f683336d ("pinctrl: Add IRQ support to STM32 gpios")
---
 drivers/pinctrl/stm32/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/stm32/Kconfig b/drivers/pinctrl/stm32/Kconfig
index 24bc68308af2..c03dce7a22df 100644
--- a/drivers/pinctrl/stm32/Kconfig
+++ b/drivers/pinctrl/stm32/Kconfig
@@ -10,13 +10,13 @@ config PINCTRL_STM32
 
 config PINCTRL_STM32F429
 	bool "STMicroelectronics STM32F429 pin control" if COMPILE_TEST && !MACH_STM32F429
-	depends on OF
+	depends on OF && IRQ_DOMAIN_HIERARCHY
 	default MACH_STM32F429
 	select PINCTRL_STM32
 
 config PINCTRL_STM32F746
 	bool "STMicroelectronics STM32F746 pin control" if COMPILE_TEST && !MACH_STM32F746
-	depends on OF
+	depends on OF && IRQ_DOMAIN_HIERARCHY
 	default MACH_STM32F746
 	select PINCTRL_STM32
 
-- 
2.9.0
