From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 May 2015 17:15:22 +0200
Subject: [PATCH] ARM: stm32: fix decompressor build
Message-ID: <3033772.rbvAY6l8ZR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The stm32 defconfig uses XIP_KERNEL, but if this is turned off
by a user, we get this error when building the zImage decompressor:

arch/arm/boot/compressed/misc.c:28:35: fatal error: mach/uncompress.h: No such file or directory

To avoid the error, this adds stm32 to the list of platforms using
the default DEBUG_LL based decompressor output.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I'd like to apply this directly to next/soc

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 375a428aa733..91f0df3edbe0 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1680,7 +1680,8 @@ config UNCOMPRESS_INCLUDE
 	string
 	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
 					PLAT_SAMSUNG || ARCH_EFM32 || \
-					ARCH_SHMOBILE_LEGACY || ARCH_LPC18XX
+					ARCH_SHMOBILE_LEGACY || \
+					ARCH_LPC18XX || ARCH_STM32
 	default "mach/uncompress.h"
 
 config EARLY_PRINTK
