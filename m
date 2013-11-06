From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 07 Nov 2013 08:21:29 +0900
Subject: [PATCH 03/04] ARM: shmobile: Remove legacy KZM9D board code
In-Reply-To: <20131106232102.8081.20523.sendpatchset@w520>
References: <20131106232102.8081.20523.sendpatchset@w520>
Message-ID: <20131106232129.8081.77546.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove the C and platform device version of KZM9D.

The DT version of KZM9D board support can now instead
directly be used with SoC specific code in setup-emev2.c.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig       |    6 --
 arch/arm/mach-shmobile/Makefile      |    1 
 arch/arm/mach-shmobile/Makefile.boot |    1 
 arch/arm/mach-shmobile/board-kzm9d.c |   92 ----------------------------------
 4 files changed, 100 deletions(-)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-11-05 15:36:05.000000000 +0900
@@ -245,12 +245,6 @@ config MACH_KOELSCH_REFERENCE
 
 	   This is intended to aid developers
 
-config MACH_KZM9D
-	bool "KZM9D board"
-	depends on ARCH_EMEV2
-	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	select USE_OF
-
 config MACH_KZM9G
 	bool "KZM-A9-GT board"
 	depends on ARCH_SH73A0
--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-11-05 15:35:45.000000000 +0900
@@ -72,7 +72,6 @@ obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= bo
 obj-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE)	+= board-armadillo800eva-reference.o
 obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch.o
 obj-$(CONFIG_MACH_KOELSCH_REFERENCE)	+= board-koelsch-reference.o
-obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d.o
 obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o
 obj-$(CONFIG_MACH_KZM9G_REFERENCE)	+= board-kzm9g-reference.o
 endif
--- 0001/arch/arm/mach-shmobile/Makefile.boot
+++ work/arch/arm/mach-shmobile/Makefile.boot	2013-11-05 15:36:46.000000000 +0900
@@ -9,7 +9,6 @@ loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE)
 loadaddr-$(CONFIG_MACH_GENMAI) += 0x8008000
 loadaddr-$(CONFIG_MACH_KOELSCH) += 0x40008000
 loadaddr-$(CONFIG_MACH_KOELSCH_REFERENCE) += 0x40008000
-loadaddr-$(CONFIG_MACH_KZM9D) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
 loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
 loadaddr-$(CONFIG_MACH_LAGER) += 0x40008000
--- 0001/arch/arm/mach-shmobile/board-kzm9d.c
+++ /dev/null	2013-06-03 21:41:10.638032047 +0900
@@ -1,92 +0,0 @@
-/*
- * kzm9d board support
- *
- * Copyright (C) 2012  Renesas Solutions Corp.
- * Copyright (C) 2012  Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/regulator/fixed.h>
-#include <linux/regulator/machine.h>
-#include <linux/smsc911x.h>
-#include <mach/common.h>
-#include <mach/emev2.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-
-/* Dummy supplies, where voltage doesn't matter */
-static struct regulator_consumer_supply dummy_supplies[] = {
-	REGULATOR_SUPPLY("vddvario", "smsc911x"),
-	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
-};
-
-/* Ether */
-static struct resource smsc911x_resources[] = {
-	[0] = {
-		.start	= 0x20000000,
-		.end	= 0x2000ffff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= EMEV2_GPIO_IRQ(1),
-		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_HIGH,
-	},
-};
-
-static struct smsc911x_platform_config smsc911x_platdata = {
-	.flags		= SMSC911X_USE_32BIT,
-	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
-	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_HIGH,
-};
-
-static struct platform_device smsc91x_device = {
-	.name	= "smsc911x",
-	.id	= -1,
-	.dev	= {
-		  .platform_data = &smsc911x_platdata,
-		},
-	.num_resources	= ARRAY_SIZE(smsc911x_resources),
-	.resource	= smsc911x_resources,
-};
-
-static struct platform_device *kzm9d_devices[] __initdata = {
-	&smsc91x_device,
-};
-
-void __init kzm9d_add_standard_devices(void)
-{
-	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
-
-	emev2_add_standard_devices();
-
-	platform_add_devices(kzm9d_devices, ARRAY_SIZE(kzm9d_devices));
-}
-
-static const char *kzm9d_boards_compat_dt[] __initdata = {
-	"renesas,kzm9d",
-	NULL,
-};
-
-DT_MACHINE_START(KZM9D_DT, "kzm9d")
-	.smp		= smp_ops(emev2_smp_ops),
-	.map_io		= emev2_map_io,
-	.init_early	= emev2_init_delay,
-	.init_machine	= kzm9d_add_standard_devices,
-	.init_late	= shmobile_init_late,
-	.dt_compat	= kzm9d_boards_compat_dt,
-MACHINE_END
