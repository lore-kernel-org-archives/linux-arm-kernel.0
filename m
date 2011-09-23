From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 23 Sep 2011 17:51:31 +0100
Subject: [RFC PATCH 13/14] ARM: omap2plus: convert to CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <1316796692-15964-1-git-send-email-marc.zyngier@arm.com>
References: <1316796692-15964-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1316796692-15964-14-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the omap2plus platforms to be using CONFIG_MULTI_IRQ_HANDLER.
Each machine is modified to provide either omap2_intc_handle_irq(),
omap3_intc_handle_irq() or gic_handle_irq().

This allows for a major cleanup, removing the MULTI_OMAP setup
from the interrupt path.

Tested on both Panda and IGEPv2 (single kernel image)

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-omap2/Kconfig                    |    1 +
 arch/arm/mach-omap2/board-2430sdp.c            |    1 +
 arch/arm/mach-omap2/board-3430sdp.c            |    1 +
 arch/arm/mach-omap2/board-3630sdp.c            |    1 +
 arch/arm/mach-omap2/board-4430sdp.c            |    2 +
 arch/arm/mach-omap2/board-am3517crane.c        |    1 +
 arch/arm/mach-omap2/board-am3517evm.c          |    1 +
 arch/arm/mach-omap2/board-apollon.c            |    1 +
 arch/arm/mach-omap2/board-cm-t35.c             |    2 +
 arch/arm/mach-omap2/board-cm-t3517.c           |    1 +
 arch/arm/mach-omap2/board-devkit8000.c         |    1 +
 arch/arm/mach-omap2/board-generic.c            |    1 +
 arch/arm/mach-omap2/board-h4.c                 |    1 +
 arch/arm/mach-omap2/board-igep0020.c           |    2 +
 arch/arm/mach-omap2/board-ldp.c                |    1 +
 arch/arm/mach-omap2/board-n8x0.c               |    3 +
 arch/arm/mach-omap2/board-omap3beagle.c        |    1 +
 arch/arm/mach-omap2/board-omap3evm.c           |    1 +
 arch/arm/mach-omap2/board-omap3logic.c         |    2 +
 arch/arm/mach-omap2/board-omap3pandora.c       |    1 +
 arch/arm/mach-omap2/board-omap3stalker.c       |    1 +
 arch/arm/mach-omap2/board-omap3touchbook.c     |    1 +
 arch/arm/mach-omap2/board-omap4panda.c         |    2 +
 arch/arm/mach-omap2/board-overo.c              |    1 +
 arch/arm/mach-omap2/board-rm680.c              |    1 +
 arch/arm/mach-omap2/board-rx51.c               |    1 +
 arch/arm/mach-omap2/board-zoom.c               |    2 +
 arch/arm/mach-omap2/include/mach/entry-macro.S |  137 ------------------------
 arch/arm/plat-omap/Kconfig                     |    1 +
 29 files changed, 36 insertions(+), 137 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 1aee224..4c5b01d 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -25,6 +25,7 @@ config ARCH_OMAP2
 	depends on ARCH_OMAP2PLUS
 	default y
 	select CPU_V6
+	select MULTI_IRQ_HANDLER
 
 config ARCH_OMAP3
 	bool "TI OMAP3"
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 4191743..56785c6 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -256,6 +256,7 @@ MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
 	.map_io		= omap_2430sdp_map_io,
 	.init_early	= omap2430_init_early,
 	.init_irq	= omap2_init_irq,
+	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= omap_2430sdp_init,
 	.timer		= &omap2_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 77142c1..1c17bd8 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -728,6 +728,7 @@ MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
 	.map_io		= omap3_map_io,
 	.init_early	= omap3430_init_early,
 	.init_irq	= omap3_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_3430sdp_init,
 	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index f552305..b27aa85 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -215,6 +215,7 @@ MACHINE_START(OMAP_3630SDP, "OMAP 3630SDP board")
 	.map_io		= omap3_map_io,
 	.init_early	= omap3630_init_early,
 	.init_irq	= omap3_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_sdp_init,
 	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index c404c5b..1b9e372 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -28,6 +28,7 @@
 
 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
+#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -991,6 +992,7 @@ MACHINE_START(OMAP_4430SDP, "OMAP4430 4430SDP board")
 	.map_io		= omap_4430sdp_map_io,
 	.init_early	= omap4430_init_early,
 	.init_irq	= gic_init_irq,
+	.handle_irq	= gic_handle_irq,
 	.init_machine	= omap_4430sdp_init,
 	.timer		= &omap4_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index 7834536..0166f4e 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -98,6 +98,7 @@ MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")
 	.map_io		= omap3_map_io,
 	.init_early	= am35xx_init_early,
 	.init_irq	= omap3_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= am3517_crane_init,
 	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index d314f03..18cf2ce 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -491,6 +491,7 @@ MACHINE_START(OMAP3517EVM, "OMAP3517/AM3517 EVM")
 	.map_io		= omap3_map_io,
 	.init_early	= am35xx_init_early,
 	.init_irq	= omap3_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= am3517_evm_init,
 	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 868d5f0..ab6704f 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -350,6 +350,7 @@ MACHINE_START(OMAP_APOLLON, "OMAP24xx Apollon")
 	.map_io		= omap_apollon_map_io,
 	.init_early	= omap2420_init_early,
 	.init_irq	= omap2_init_irq,
+	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= omap_apollon_init,
 	.timer		= &omap2_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index bd1bcac..21a2436 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -634,6 +634,7 @@ MACHINE_START(CM_T35, "Compulab CM-T35")
 	.map_io		= omap3_map_io,
 	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= cm_t35_init,
 	.timer		= &omap3_timer,
 MACHINE_END
@@ -644,6 +645,7 @@ MACHINE_START(CM_T3730, "Compulab CM-T3730")
 	.map_io         = omap3_map_io,
 	.init_early     = omap3630_init_early,
 	.init_irq       = omap3_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine   = cm_t3730_init,
 	.timer          = &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 3f4dc66..1e2c52b 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -299,6 +299,7 @@ MACHINE_START(CM_T3517, "Compulab CM-T3517")
 	.map_io		= omap3_map_io,
 	.init_early	= am35xx_init_early,
 	.init_irq	= omap3_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= cm_t3517_init,
 	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 8d362dd..d8a02be 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -666,6 +666,7 @@ MACHINE_START(DEVKIT8000, "OMAP3 Devkit8000")
 	.map_io		= omap3_map_io,
 	.init_early	= omap35xx_init_early,
 	.init_irq	= devkit8000_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= devkit8000_init,
 	.timer		= &omap3_secure_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 7ac5462..dd2a5c2 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -70,6 +70,7 @@ MACHINE_START(OMAP_GENERIC, "Generic OMAP24xx")
 	.map_io		= omap_generic_map_io,
 	.init_early	= omap_generic_init_early,
 	.init_irq	= omap2_init_irq,
+	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= omap_generic_init,
 	.timer		= &omap2_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index f0ddc27..e75f09f 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -381,6 +381,7 @@ MACHINE_START(OMAP_H4, "OMAP2420 H4 board")
 	.map_io		= omap_h4_map_io,
 	.init_early	= omap2420_init_early,
 	.init_irq	= omap_h4_init_irq,
+	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= omap_h4_init,
 	.timer		= &omap2_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index d0a3f78..b45d48d 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -672,6 +672,7 @@ MACHINE_START(IGEP0020, "IGEP v2 board")
 	.map_io		= omap3_map_io,
 	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= igep_init,
 	.timer		= &omap3_timer,
 MACHINE_END
@@ -682,6 +683,7 @@ MACHINE_START(IGEP0030, "IGEP OMAP3 module")
 	.map_io		= omap3_map_io,
 	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= igep_init,
 	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 5797917..4a53582 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -332,6 +332,7 @@ MACHINE_START(OMAP_LDP, "OMAP LDP board")
 	.map_io		= omap3_map_io,
 	.init_early	= omap3430_init_early,
 	.init_irq	= omap3_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_ldp_init,
 	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 4373a6a..49d9cc3 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -695,6 +695,7 @@ MACHINE_START(NOKIA_N800, "Nokia N800")
 	.map_io		= n8x0_map_io,
 	.init_early	= omap2420_init_early,
 	.init_irq	= omap2_init_irq,
+	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= n8x0_init_machine,
 	.timer		= &omap2_timer,
 MACHINE_END
@@ -705,6 +706,7 @@ MACHINE_START(NOKIA_N810, "Nokia N810")
 	.map_io		= n8x0_map_io,
 	.init_early	= omap2420_init_early,
 	.init_irq	= omap2_init_irq,
+	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= n8x0_init_machine,
 	.timer		= &omap2_timer,
 MACHINE_END
@@ -715,6 +717,7 @@ MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
 	.map_io		= n8x0_map_io,
 	.init_early	= omap2420_init_early,
 	.init_irq	= omap2_init_irq,
+	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= n8x0_init_machine,
 	.timer		= &omap2_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 0c49ee7..03af775 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -569,6 +569,7 @@ MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	.map_io		= omap3_map_io,
 	.init_early	= omap3_beagle_init_early,
 	.init_irq	= omap3_beagle_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3_beagle_init,
 	.timer		= &omap3_secure_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index ec00b2e..f86c1e8 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -681,6 +681,7 @@ MACHINE_START(OMAP3EVM, "OMAP3 EVM")
 	.map_io		= omap3_map_io,
 	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3_evm_init,
 	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 7c0f193..bd65196 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -208,6 +208,7 @@ MACHINE_START(OMAP3_TORPEDO, "Logic OMAP3 Torpedo board")
 	.map_io		= omap3_map_io,
 	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3logic_init,
 	.timer		= &omap3_timer,
 MACHINE_END
@@ -217,6 +218,7 @@ MACHINE_START(OMAP3530_LV_SOM, "OMAP Logic 3530 LV SOM board")
 	.map_io		= omap3_map_io,
 	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3logic_init,
 	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index f7811f4..caf607c 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -606,6 +606,7 @@ MACHINE_START(OMAP3_PANDORA, "Pandora Handheld Console")
 	.map_io		= omap3_map_io,
 	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3pandora_init,
 	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 8ab73af..ca02d2f 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -459,6 +459,7 @@ MACHINE_START(SBC3530, "OMAP3 STALKER")
 	.map_io			= omap3_map_io,
 	.init_early		= omap35xx_init_early,
 	.init_irq		= omap3_stalker_init_irq,
+	.handle_irq		= omap3_intc_handle_irq,
 	.init_machine		= omap3_stalker_init,
 	.timer			= &omap3_secure_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 5e3e22f..7586e2c 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -404,6 +404,7 @@ MACHINE_START(TOUCHBOOK, "OMAP3 touchbook Board")
 	.map_io		= omap3_map_io,
 	.init_early	= omap3430_init_early,
 	.init_irq	= omap3_touchbook_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3_touchbook_init,
 	.timer		= &omap3_secure_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 42d6168..41b2032 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -31,6 +31,7 @@
 
 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
+#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -584,6 +585,7 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	.map_io		= omap4_panda_map_io,
 	.init_early	= omap4430_init_early,
 	.init_irq	= gic_init_irq,
+	.handle_irq	= gic_handle_irq,
 	.init_machine	= omap4_panda_init,
 	.timer		= &omap4_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 4cf7aea..9865d8d 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -562,6 +562,7 @@ MACHINE_START(OVERO, "Gumstix Overo")
 	.map_io		= omap3_map_io,
 	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= overo_init,
 	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index d7c8f60..cf9e2db 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -155,6 +155,7 @@ MACHINE_START(NOKIA_RM680, "Nokia RM-680 board")
 	.map_io		= rm680_map_io,
 	.init_early	= omap3630_init_early,
 	.init_irq	= omap3_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= rm680_init,
 	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index e2e958a..f777d11 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -158,6 +158,7 @@ MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
 	.map_io		= rx51_map_io,
 	.init_early	= omap3430_init_early,
 	.init_irq	= omap3_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= rx51_init,
 	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index be6684d..011b2e3 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -135,6 +135,7 @@ MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
 	.map_io		= omap3_map_io,
 	.init_early	= omap3430_init_early,
 	.init_irq	= omap3_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_zoom_init,
 	.timer		= &omap3_timer,
 MACHINE_END
@@ -145,6 +146,7 @@ MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
 	.map_io		= omap3_map_io,
 	.init_early	= omap3630_init_early,
 	.init_irq	= omap3_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_zoom_init,
 	.timer		= &omap3_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index feb90a1..56964a0 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -10,146 +10,9 @@
  * License version 2. This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-#include <mach/hardware.h>
-#include <mach/io.h>
-#include <mach/irqs.h>
-#include <asm/hardware/gic.h>
-
-#include <plat/omap24xx.h>
-#include <plat/omap34xx.h>
-#include <plat/omap44xx.h>
-
-#include <plat/multi.h>
-
-#define OMAP2_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE)
-#define OMAP3_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE)
-#define OMAP4_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE)
-#define INTCPS_SIR_IRQ_OFFSET	0x0040	/* omap2/3 active interrupt offset */
-#define	ACTIVEIRQ_MASK		0x7f	/* omap2/3 active interrupt bits */
 
 		.macro	disable_fiq
 		.endm
 
 		.macro  arch_ret_to_user, tmp1, tmp2
 		.endm
-
-/*
- * Unoptimized irq functions for multi-omap2, 3 and 4
- */
-
-#ifdef MULTI_OMAP2
-		/*
-		 * Configure the interrupt base on the first interrupt.
-		 * See also omap_irq_base_init for setting omap_irq_base.
-		 */
-		.macro  get_irqnr_preamble, base, tmp
-		ldr	\base, =omap_irq_base	@ irq base address
-		ldr	\base, [\base, #0]	@ irq base value
-		.endm
-
-		/* Check the pending interrupts. Note that base already set */
-		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		tst	\base, #0x100		@ gic address?
-		bne	4401f			@ found gic
-
-		/* Handle omap2 and omap3 */
-		ldr	\irqnr, [\base, #0x98] /* IRQ pending reg 1 */
-		cmp	\irqnr, #0x0
-		bne	9998f
-		ldr	\irqnr, [\base, #0xb8] /* IRQ pending reg 2 */
-		cmp	\irqnr, #0x0
-		bne	9998f
-		ldr	\irqnr, [\base, #0xd8] /* IRQ pending reg 3 */
-		cmp	\irqnr, #0x0
-		bne	9998f
-
-		/*
-		 * ti816x has additional IRQ pending register. Checking this
-		 * register on omap2 & omap3 has no effect (read as 0).
-		 */
-		ldr	\irqnr, [\base, #0xf8] /* IRQ pending reg 4 */
-		cmp	\irqnr, #0x0
-9998:
-		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
-		and	\irqnr, \irqnr, #ACTIVEIRQ_MASK /* Clear spurious bits */
-		b	9999f
-
-		/* Handle omap4 */
-4401:		ldr     \irqstat, [\base, #GIC_CPU_INTACK]
-		ldr     \tmp, =1021
-		bic     \irqnr, \irqstat, #0x1c00
-		cmp     \irqnr, #15
-		cmpcc   \irqnr, \irqnr
-		cmpne   \irqnr, \tmp
-		cmpcs   \irqnr, \irqnr
-9999:
-		.endm
-
-#ifdef CONFIG_SMP
-		/* We assume that irqstat (the raw value of the IRQ acknowledge
-		 * register) is preserved from the macro above.
-		 * If there is an IPI, we immediately signal end of interrupt
-		 * on the controller, since this requires the original irqstat
-		 * value which we won't easily be able to recreate later.
-		 */
-
-		.macro test_for_ipi, irqnr, irqstat, base, tmp
-		bic	\irqnr, \irqstat, #0x1c00
-		cmp	\irqnr, #16
-		it	cc
-		strcc	\irqstat, [\base, #GIC_CPU_EOI]
-		it	cs
-		cmpcs	\irqnr, \irqnr
-		.endm
-#endif	/* CONFIG_SMP */
-
-#else	/* MULTI_OMAP2 */
-
-
-/*
- * Optimized irq functions for omap2, 3 and 4
- */
-
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-		.macro  get_irqnr_preamble, base, tmp
-#ifdef CONFIG_ARCH_OMAP2
-		ldr	\base, =OMAP2_IRQ_BASE
-#else
-		ldr	\base, =OMAP3_IRQ_BASE
-#endif
-		.endm
-
-		/* Check the pending interrupts. Note that base already set */
-		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldr	\irqnr, [\base, #0x98] /* IRQ pending reg 1 */
-		cmp	\irqnr, #0x0
-		bne	9999f
-		ldr	\irqnr, [\base, #0xb8] /* IRQ pending reg 2 */
-		cmp	\irqnr, #0x0
-		bne	9999f
-		ldr	\irqnr, [\base, #0xd8] /* IRQ pending reg 3 */
-		cmp	\irqnr, #0x0
-#ifdef CONFIG_SOC_OMAPTI816X
-		bne	9999f
-		ldr	\irqnr, [\base, #0xf8] /* IRQ pending reg 4 */
-		cmp	\irqnr, #0x0
-#endif
-9999:
-		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
-		and	\irqnr, \irqnr, #ACTIVEIRQ_MASK /* Clear spurious bits */
-
-		.endm
-#endif
-
-
-#ifdef CONFIG_ARCH_OMAP4
-#define HAVE_GET_IRQNR_PREAMBLE
-#include <asm/hardware/entry-macro-gic.S>
-
-		.macro  get_irqnr_preamble, base, tmp
-		ldr     \base, =OMAP4_IRQ_BASE
-		.endm
-
-#endif
-
-#endif	/* MULTI_OMAP2 */
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index fa62037..c39cbca 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -22,6 +22,7 @@ config ARCH_OMAP2PLUS
 	select CLKDEV_LOOKUP
 	select GENERIC_IRQ_CHIP
 	select OMAP_DM_TIMER
+	select MULTI_IRQ_HANDLER
 	help
 	  "Systems based on OMAP2, OMAP3 or OMAP4"
 
-- 
1.7.0.4
