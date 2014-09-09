From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  9 Sep 2014 13:22:05 +0900
Subject: [PATCH 5/6] ARM: shmobile: armadillo800eva reference: Remove C board
 code
In-Reply-To: <cover.1410235700.git.horms+renesas@verge.net.au>
References: <cover.1410235700.git.horms+renesas@verge.net.au>
Message-ID: <52031d41be060e9a7f6d113728109aed4758f7ae.1410235700.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Now when the r8a7740 generic multiplatform case has the same
features as the DT reference board code then get rid of the
Armadillo800EVA DT reference C board code. DT Reference code
in the future shall make use of the r8a7740 Multiplatform
support code with the generic SoC machine vector.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig                     |  15 --
 arch/arm/mach-shmobile/Makefile                    |   1 -
 arch/arm/mach-shmobile/Makefile.boot               |   1 -
 .../board-armadillo800eva-reference.c              | 199 ---------------------
 4 files changed, 216 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/board-armadillo800eva-reference.c

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 498162f..723bcc5 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -200,21 +200,6 @@ config MACH_ARMADILLO800EVA
 	select SND_SOC_WM8978 if SND_SIMPLE_CARD
 	select USE_OF
 
-config MACH_ARMADILLO800EVA_REFERENCE
-	bool "Armadillo-800 EVA board - Reference Device Tree Implementation"
-	depends on ARCH_R8A7740
-	select ARCH_REQUIRE_GPIOLIB
-	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	select SMSC_PHY if SH_ETH
-	select SND_SOC_WM8978 if SND_SIMPLE_CARD
-	select USE_OF
-	---help---
-	   Use reference implementation of Armadillo800 EVA board support
-	   which makes greater use of device tree at the expense
-	   of not supporting a number of devices.
-
-	   This is intended to aid developers
-
 config MACH_BOCKW
 	bool "BOCK-W platform"
 	depends on ARCH_R8A7778
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index fe3878a..7a9d03a 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -77,7 +77,6 @@ obj-$(CONFIG_MACH_GENMAI)	+= board-genmai.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
 obj-$(CONFIG_MACH_LAGER)	+= board-lager.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
-obj-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE)	+= board-armadillo800eva-reference.o
 obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch.o
 obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o
 obj-$(CONFIG_MACH_KZM9G_REFERENCE)	+= board-kzm9g-reference.o
diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index ebf97d4..ec8caff 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -3,7 +3,6 @@ loadaddr-y	:=
 loadaddr-$(CONFIG_MACH_APE6EVM) += 0x40008000
 loadaddr-$(CONFIG_MACH_APE6EVM_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_ARMADILLO800EVA) += 0x40008000
-loadaddr-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
 loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
 loadaddr-$(CONFIG_MACH_GENMAI) += 0x08008000
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
deleted file mode 100644
index f06e1f3..0000000
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ /dev/null
@@ -1,199 +0,0 @@
-/*
- * armadillo 800 eva board support
- *
- * Copyright (C) 2012 Renesas Solutions Corp.
- * Copyright (C) 2012 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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
- *
- */
-
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/kernel.h>
-#include <linux/gpio.h>
-#include <linux/io.h>
-#include <linux/of_platform.h>
-
-#include <asm/mach/arch.h>
-#include <asm/hardware/cache-l2x0.h>
-
-#include "common.h"
-#include "r8a7740.h"
-
-/*
- * CON1		Camera Module
- * CON2		Extension Bus
- * CON3		HDMI Output
- * CON4		Composite Video Output
- * CON5		H-UDI JTAG
- * CON6		ARM JTAG
- * CON7		SD1
- * CON8		SD2
- * CON9		RTC BackUp
- * CON10	Monaural Mic Input
- * CON11	Stereo Headphone Output
- * CON12	Audio Line Output(L)
- * CON13	Audio Line Output(R)
- * CON14	AWL13 Module
- * CON15	Extension
- * CON16	LCD1
- * CON17	LCD2
- * CON19	Power Input
- * CON20	USB1
- * CON21	USB2
- * CON22	Serial
- * CON23	LAN
- * CON24	USB3
- * LED1		Camera LED (Yellow)
- * LED2		Power LED (Green)
- * LED3-LED6	User LED (Yellow)
- * LED7		LAN link LED (Green)
- * LED8		LAN activity LED (Yellow)
- */
-
-/*
- * DipSwitch
- *
- *                    SW1
- *
- * -12345678-+---------------+----------------------------
- *  1        | boot          | hermit
- *  0        | boot          | OS auto boot
- * -12345678-+---------------+----------------------------
- *   00      | boot device   | eMMC
- *   10      | boot device   | SDHI0 (CON7)
- *   01      | boot device   | -
- *   11      | boot device   | Extension Buss (CS0)
- * -12345678-+---------------+----------------------------
- *     0     | Extension Bus | D8-D15 disable, eMMC enable
- *     1     | Extension Bus | D8-D15 enable,  eMMC disable
- * -12345678-+---------------+----------------------------
- *      0    | SDHI1         | COM8 disable, COM14 enable
- *      1    | SDHI1         | COM8 enable,  COM14 disable
- * -12345678-+---------------+----------------------------
- *       0   | USB0          | COM20 enable,  COM24 disable
- *       1   | USB0          | COM20 disable, COM24 enable
- * -12345678-+---------------+----------------------------
- *        00 | JTAG          | SH-X2
- *        10 | JTAG          | ARM
- *        01 | JTAG          | -
- *        11 | JTAG          | Boundary Scan
- *-----------+---------------+----------------------------
- */
-
-/*
- * FSI-WM8978
- *
- * this command is required when playback.
- *
- * # amixer set "Headphone" 50
- *
- * this command is required when capture.
- *
- * # amixer set "Input PGA" 15
- * # amixer set "Left Input Mixer MicP" on
- * # amixer set "Left Input Mixer MicN" on
- * # amixer set "Right Input Mixer MicN" on
- * # amixer set "Right Input Mixer MicP" on
- */
-
-/*
- * USB function
- *
- * When you use USB Function,
- * set SW1.6 ON, and connect cable to CN24.
- *
- * USBF needs workaround on R8A7740 chip.
- * These are a little bit complex.
- * see
- *	usbhsf_power_ctrl()
- */
-
-static void __init eva_clock_init(void)
-{
-	struct clk *system	= clk_get(NULL, "system_clk");
-	struct clk *xtal1	= clk_get(NULL, "extal1");
-	struct clk *usb24s	= clk_get(NULL, "usb24s");
-	struct clk *fsibck	= clk_get(NULL, "fsibck");
-
-	if (IS_ERR(system)	||
-	    IS_ERR(xtal1)	||
-	    IS_ERR(usb24s)	||
-	    IS_ERR(fsibck)) {
-		pr_err("armadillo800eva board clock init failed\n");
-		goto clock_error;
-	}
-
-	/* armadillo 800 eva extal1 is 24MHz */
-	clk_set_rate(xtal1, 24000000);
-
-	/* usb24s use extal1 (= system) clock (= 24MHz) */
-	clk_set_parent(usb24s, system);
-
-	/* FSIBCK is 12.288MHz, and it is parent of FSI-B */
-	clk_set_rate(fsibck, 12288000);
-
-clock_error:
-	if (!IS_ERR(system))
-		clk_put(system);
-	if (!IS_ERR(xtal1))
-		clk_put(xtal1);
-	if (!IS_ERR(usb24s))
-		clk_put(usb24s);
-	if (!IS_ERR(fsibck))
-		clk_put(fsibck);
-}
-
-/*
- * board init
- */
-static void __init eva_init(void)
-{
-	r8a7740_clock_init(MD_CK0 | MD_CK2);
-	eva_clock_init();
-
-	r8a7740_meram_workaround();
-
-#ifdef CONFIG_CACHE_L2X0
-	/* Shared attribute override enable, 32K*8way */
-	l2x0_init(IOMEM(0xf0002000), 0x00400000, 0xc20f0fff);
-#endif
-
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-
-	r8a7740_pm_init();
-}
-
-#define RESCNT2 IOMEM(0xe6188020)
-static void eva_restart(enum reboot_mode mode, const char *cmd)
-{
-	/* Do soft power on reset */
-	writel(1 << 31, RESCNT2);
-}
-
-static const char *eva_boards_compat_dt[] __initdata = {
-	"renesas,armadillo800eva-reference",
-	NULL,
-};
-
-DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva-reference")
-	.map_io		= r8a7740_map_io,
-	.init_early	= shmobile_init_delay,
-	.init_irq	= r8a7740_init_irq_of,
-	.init_machine	= eva_init,
-	.init_late	= shmobile_init_late,
-	.dt_compat	= eva_boards_compat_dt,
-	.restart	= eva_restart,
-MACHINE_END
-- 
2.0.1
