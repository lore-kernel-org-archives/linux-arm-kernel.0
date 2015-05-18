From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 May 2015 17:55:16 +0200
Subject: [PATCH] ARM: uniphier: only select TWD for SMP
Message-ID: <2227073.rylFc5jIqu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes uniphier behave like all the other platforms that
support TWD, and only select this driver when SMP is enabled.
Without this, we get a compile error on UP builds:

arch/arm/kernel/smp_twd.c: In function 'twd_local_timer_of_register':
arch/arm/kernel/smp_twd.c:391:20: error: 'setup_max_cpus' undeclared (first use in this function)

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I'd like to apply this directly to the next/soc branch

diff --git a/arch/arm/mach-uniphier/Kconfig b/arch/arm/mach-uniphier/Kconfig
index a017b1dd9c78..b640458fd757 100644
--- a/arch/arm/mach-uniphier/Kconfig
+++ b/arch/arm/mach-uniphier/Kconfig
@@ -5,7 +5,7 @@ config ARCH_UNIPHIER
 	select ARM_GLOBAL_TIMER
 	select ARM_GIC
 	select HAVE_ARM_SCU
-	select HAVE_ARM_TWD
+	select HAVE_ARM_TWD if SMP
 	help
 	  Support for UniPhier SoC family developed by Socionext Inc.
 	  (formerly, System LSI Business Division of Panasonic Corporation)
