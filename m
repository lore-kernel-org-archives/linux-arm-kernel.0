From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 05 Jun 2013 16:34:59 +0900
Subject: [PATCH 06/06] ARM: shmobile: Marzen memory size fixup
In-Reply-To: <20130605073410.15758.37563.sendpatchset@w520>
References: <20130605073410.15758.37563.sendpatchset@w520>
Message-ID: <20130605073459.15758.14086.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Specify the Marzen memory configuration via
a board specific fixup callback, and also
select ATAGS to make sure the callback is
executed as expected.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig        |    1 +
 arch/arm/mach-shmobile/board-marzen.c |    4 ++++
 2 files changed, 5 insertions(+)

--- 0008/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-06-04 15:30:05.000000000 +0900
@@ -143,6 +143,7 @@ config MACH_BOCKW
 config MACH_MARZEN
 	bool "MARZEN board"
 	depends on ARCH_R8A7779
+	select ATAGS
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
--- 0001/arch/arm/mach-shmobile/board-marzen.c
+++ work/arch/arm/mach-shmobile/board-marzen.c	2013-06-04 15:34:21.000000000 +0900
@@ -46,6 +46,7 @@
 #include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <asm/setup.h>
 #include <asm/traps.h>
 
 /* Fixed 3.3V regulator to be used by SDHI0 */
@@ -409,7 +410,10 @@ static void __init marzen_init(void)
 	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
 }
 
+SHMOBILE_FIXUP(marzen, 0x60000000, 0x10000000)
+
 MACHINE_START(MARZEN, "marzen")
+	.fixup		= marzen_fixup,
 	.smp		= smp_ops(r8a7779_smp_ops),
 	.map_io		= r8a7779_map_io,
 	.init_early	= r8a7779_add_early_devices,
