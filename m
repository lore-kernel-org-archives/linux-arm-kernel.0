From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 May 2018 18:09:13 +0200
Subject: [PATCH 1/2] ARM: stm32: Don't select DMA unconditionally on
 STM32MP157C
Message-ID: <20180525160926.150713-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch that enabled these had no useful changelog that explains
why it is done, and it causes a build warning:

WARNING: unmet direct dependencies detected for STM32_DMA
  Depends on [n]: DMADEVICES [=n] && (ARCH_STM32 [=y] || COMPILE_TEST [=y])
  Selected by [y]:
  - MACH_STM32MP157 [=y] && ARCH_STM32 [=y] && ARCH_MULTI_V7 [=y]

Generally, platforms should not select arbitrary drivers, so let's
just revert that change.

Fixes: de6037fa207f ("ARM: stm32: Select DMA, DMAMUX and MDMA support on STM32MP157C")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-stm32/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 82a93b8d9ae6..713c068b953f 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -46,9 +46,6 @@ if ARCH_MULTI_V7
 
 config MACH_STM32MP157
 	bool "STMicroelectronics STM32MP157"
-	select STM32_DMA
-	select STM32_DMAMUX
-	select STM32_MDMA
 	default y
 
 endif # ARMv7-A
-- 
2.9.0
