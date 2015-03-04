From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  4 Mar 2015 12:29:23 +0100
Subject: [PATCH] ARM: at91: sama5d4: Properly configure L2CC
Message-ID: <1425468563-14300-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the bootloader may not properly configure the L2CC, enforce its configuration
in the kernel.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 4 ++++
 arch/arm/mach-at91/sama5.c     | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 07953f279a56..8998f14dda04 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -270,6 +270,10 @@
 			interrupts = <67 IRQ_TYPE_LEVEL_HIGH 4>;
 			cache-unified;
 			cache-level = <2>;
+			arm,double-linefill = <1>;
+			arm,double-linefill-incr = <1>;
+			arm,prefetch-drop = <1>;
+			arm,prefetch-offset = <1>;
 		};
 
 		nand0: nand at 80000000 {
diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
index 03dcb441f3d2..a3df9328daa9 100644
--- a/arch/arm/mach-at91/sama5.c
+++ b/arch/arm/mach-at91/sama5.c
@@ -22,6 +22,7 @@
 #include <mach/hardware.h>
 
 #include <asm/setup.h>
+#include <asm/hardware/cache-l2x0.h>
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -107,5 +108,7 @@ DT_MACHINE_START(sama5_alt_dt, "Atmel SAMA5")
 	.map_io		= sama5_alt_map_io,
 	.init_machine	= sama5_dt_device_init,
 	.dt_compat	= sama5_alt_dt_board_compat,
+	.l2c_aux_val	= L310_AUX_CTRL_DATA_PREFETCH |
+		L310_AUX_CTRL_INSTR_PREFETCH,
 	.l2c_aux_mask	= ~0UL,
 MACHINE_END
-- 
2.1.0
