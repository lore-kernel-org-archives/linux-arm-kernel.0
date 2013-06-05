From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 05 Jun 2013 16:34:26 +0900
Subject: [PATCH 02/06] ARM: shmobile: AG5EVM memory size fixup
In-Reply-To: <20130605073410.15758.37563.sendpatchset@w520>
References: <20130605073410.15758.37563.sendpatchset@w520>
Message-ID: <20130605073426.15758.89184.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Specify the AG5EVM memory configuration via
a board specific fixup callback, and also
select ATAGS to make sure the callback is
executed as expected.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig        |    1 +
 arch/arm/mach-shmobile/board-ag5evm.c |    4 ++++
 2 files changed, 5 insertions(+)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-06-04 13:18:56.000000000 +0900
@@ -92,6 +92,7 @@ endchoice
 config MACH_AG5EVM
 	bool "AG5EVM board"
 	depends on ARCH_SH73A0
+	select ATAGS
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select SH_LCD_MIPI_DSI
--- 0001/arch/arm/mach-shmobile/board-ag5evm.c
+++ work/arch/arm/mach-shmobile/board-ag5evm.c	2013-06-04 13:16:52.000000000 +0900
@@ -53,6 +53,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>
+#include <asm/setup.h>
 #include <asm/traps.h>
 
 /* Dummy supplies, where voltage doesn't matter */
@@ -660,7 +661,10 @@ static void __init ag5evm_init(void)
 	platform_add_devices(ag5evm_devices, ARRAY_SIZE(ag5evm_devices));
 }
 
+SHMOBILE_FIXUP(ag5evm, 0x40000000, 0x20000000)
+
 MACHINE_START(AG5EVM, "ag5evm")
+	.fixup		= ag5evm_fixup,
 	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_add_early_devices,
