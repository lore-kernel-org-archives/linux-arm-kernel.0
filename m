From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 05 Jun 2013 16:34:50 +0900
Subject: [PATCH 05/06] ARM: shmobile: Kota2 memory size fixup
In-Reply-To: <20130605073410.15758.37563.sendpatchset@w520>
References: <20130605073410.15758.37563.sendpatchset@w520>
Message-ID: <20130605073450.15758.62483.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Specify the Kota2 memory configuration via
a board specific fixup callback, and also
select ATAGS to make sure the callback is
executed as expected.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig       |    1 +
 arch/arm/mach-shmobile/board-kota2.c |    4 ++++
 2 files changed, 5 insertions(+)

--- 0007/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-06-04 15:24:49.000000000 +0900
@@ -114,6 +114,7 @@ config MACH_MACKEREL
 config MACH_KOTA2
 	bool "KOTA2 board"
 	depends on ARCH_SH73A0
+	select ATAGS
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
--- 0001/arch/arm/mach-shmobile/board-kota2.c
+++ work/arch/arm/mach-shmobile/board-kota2.c	2013-06-04 15:23:00.000000000 +0900
@@ -51,6 +51,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/hardware/cache-l2x0.h>
+#include <asm/setup.h>
 #include <asm/traps.h>
 
 /* Dummy supplies, where voltage doesn't matter */
@@ -541,7 +542,10 @@ static void __init kota2_init(void)
 	platform_add_devices(kota2_devices, ARRAY_SIZE(kota2_devices));
 }
 
+SHMOBILE_FIXUP(kota2, 0x41000000, 0x1e000000)
+
 MACHINE_START(KOTA2, "kota2")
+	.fixup		= kota2_fixup,
 	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_add_early_devices,
