From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Sep 2014 17:46:15 +0200
Subject: [PATCH] ARM: hisi: depend on ARCH_MULTI_V7
Message-ID: <7470114.dOWIKLTLOQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hisi has a general dependency on ARCH_MULTIPLATFORM, which is
problematic when building a kernel for non-V7 platforms but selecting
drivers that might conflict with other architecture levels.

In this case, it broke my (still out of tree) patch set that
enables V7M multiplatform support, since that does not enable
MULTI_IRQ support:

arch/arm/kernel/built-in.o: In function `set_handle_irq':
arch/arm/kernel/irq.c:125: undefined reference to `handle_arch_irq'
arch/arm/kernel/built-in.o: In function `setup_arch':
arch/arm/kernel/setup.c:965: undefined reference to `handle_arch_irq'

Since all hisilicon platforms are ARMv7 based, we can avoid this
problem by just making the dependency more specific.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I'd like to apply this patch directly to the arm-soc tree

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 075772b34e80..cd19433f76d3 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -1,6 +1,6 @@
 config ARCH_HISI
 	bool "Hisilicon SoC Support"
-	depends on ARCH_MULTIPLATFORM
+	depends on ARCH_MULTI_V7
 	select ARM_AMBA
 	select ARM_GIC
 	select ARM_TIMER_SP804
