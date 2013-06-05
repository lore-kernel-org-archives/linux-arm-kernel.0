From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 05 Jun 2013 16:34:42 +0900
Subject: [PATCH 04/06] ARM: shmobile: Bonito memory size fixup
In-Reply-To: <20130605073410.15758.37563.sendpatchset@w520>
References: <20130605073410.15758.37563.sendpatchset@w520>
Message-ID: <20130605073442.15758.91842.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Specify the Bonito memory configuration via
a board specific fixup callback, and also
select ATAGS to make sure the callback is
executed as expected.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig        |    1 +
 arch/arm/mach-shmobile/board-bonito.c |    4 ++++
 2 files changed, 5 insertions(+)

--- 0006/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-06-04 15:11:54.000000000 +0900
@@ -120,6 +120,7 @@ config MACH_KOTA2
 config MACH_BONITO
 	bool "bonito board"
 	depends on ARCH_R8A7740
+	select ATAGS
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
--- 0001/arch/arm/mach-shmobile/board-bonito.c
+++ work/arch/arm/mach-shmobile/board-bonito.c	2013-06-04 15:19:19.000000000 +0900
@@ -37,6 +37,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/hardware/cache-l2x0.h>
+#include <asm/setup.h>
 #include <mach/r8a7740.h>
 #include <mach/irqs.h>
 #include <video/sh_mobile_lcdc.h>
@@ -484,7 +485,10 @@ static void __init bonito_add_early_devi
 	r8a7740_add_early_devices();
 }
 
+SHMOBILE_FIXUP(bonito, 0x40000000, 0x20000000)
+
 MACHINE_START(BONITO, "bonito")
+	.fixup		= bonito_fixup,
 	.map_io		= bonito_map_io,
 	.init_early	= bonito_add_early_devices,
 	.init_irq	= r8a7740_init_irq,
