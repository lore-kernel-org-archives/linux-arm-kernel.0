From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed,  2 May 2012 19:33:33 +0800
Subject: [PATCH 08/15] ARM: omap2: use machine specific hook for late init
In-Reply-To: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
References: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1335958420-5193-9-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-omap2/board-2430sdp.c        |    1 +
 arch/arm/mach-omap2/board-3430sdp.c        |    1 +
 arch/arm/mach-omap2/board-3630sdp.c        |    1 +
 arch/arm/mach-omap2/board-4430sdp.c        |    1 +
 arch/arm/mach-omap2/board-am3517crane.c    |    1 +
 arch/arm/mach-omap2/board-am3517evm.c      |    1 +
 arch/arm/mach-omap2/board-apollon.c        |    1 +
 arch/arm/mach-omap2/board-cm-t35.c         |    2 +
 arch/arm/mach-omap2/board-cm-t3517.c       |    1 +
 arch/arm/mach-omap2/board-devkit8000.c     |    1 +
 arch/arm/mach-omap2/board-generic.c        |    1 +
 arch/arm/mach-omap2/board-h4.c             |    1 +
 arch/arm/mach-omap2/board-igep0020.c       |    2 +
 arch/arm/mach-omap2/board-ldp.c            |    1 +
 arch/arm/mach-omap2/board-n8x0.c           |    3 +
 arch/arm/mach-omap2/board-omap3beagle.c    |    1 +
 arch/arm/mach-omap2/board-omap3evm.c       |    1 +
 arch/arm/mach-omap2/board-omap3logic.c     |    2 +
 arch/arm/mach-omap2/board-omap3pandora.c   |    1 +
 arch/arm/mach-omap2/board-omap3stalker.c   |    1 +
 arch/arm/mach-omap2/board-omap3touchbook.c |    1 +
 arch/arm/mach-omap2/board-omap4panda.c     |    1 +
 arch/arm/mach-omap2/board-overo.c          |    1 +
 arch/arm/mach-omap2/board-rm680.c          |    2 +
 arch/arm/mach-omap2/board-rx51.c           |    1 +
 arch/arm/mach-omap2/board-ti8168evm.c      |    2 +
 arch/arm/mach-omap2/board-zoom.c           |    2 +
 arch/arm/mach-omap2/common.h               |   47 +++++++++++++++++++++
 arch/arm/mach-omap2/io.c                   |   63 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/mux.c                  |    3 +-
 arch/arm/mach-omap2/pm.c                   |    3 +-
 arch/arm/mach-omap2/pm24xx.c               |   17 ++-----
 arch/arm/mach-omap2/pm34xx.c               |    7 +---
 arch/arm/mach-omap2/pm44xx.c               |    6 +--
 34 files changed, 154 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index e658f83..99ca6ba 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -303,6 +303,7 @@ MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
 	.init_irq	= omap2_init_irq,
 	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= omap_2430sdp_init,
+	.init_late	= omap2430_init_late,
 	.timer		= &omap2_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index da75f23..8ceb480 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -635,6 +635,7 @@ MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_3430sdp_init,
+	.init_late	= omap3430_init_late,
 	.timer		= &omap3_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 6ef350d..2dc9ba5 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -217,6 +217,7 @@ MACHINE_START(OMAP_3630SDP, "OMAP 3630SDP board")
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_sdp_init,
+	.init_late	= omap3630_init_late,
 	.timer		= &omap3_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 130ab00..3f6cf22 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -969,6 +969,7 @@ MACHINE_START(OMAP_4430SDP, "OMAP4430 4430SDP board")
 	.init_irq	= gic_init_irq,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= omap_4430sdp_init,
+	.init_late	= omap4430_init_late,
 	.timer		= &omap4_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index c3851e8..7231020 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -100,6 +100,7 @@ MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= am3517_crane_init,
+	.init_late	= am35xx_init_late,
 	.timer		= &omap3_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 3645285..ae50e11 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -402,6 +402,7 @@ MACHINE_START(OMAP3517EVM, "OMAP3517/AM3517 EVM")
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= am3517_evm_init,
+	.init_late	= am35xx_init_late,
 	.timer		= &omap3_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 768ece2..502c31e 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -356,6 +356,7 @@ MACHINE_START(OMAP_APOLLON, "OMAP24xx Apollon")
 	.init_irq	= omap2_init_irq,
 	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= omap_apollon_init,
+	.init_late	= omap2420_init_late,
 	.timer		= &omap2_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 909a8b9..f975061 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -686,6 +686,7 @@ MACHINE_START(CM_T35, "Compulab CM-T35")
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= cm_t35_init,
+	.init_late	= omap35xx_init_late,
 	.timer		= &omap3_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
@@ -698,6 +699,7 @@ MACHINE_START(CM_T3730, "Compulab CM-T3730")
 	.init_irq       = omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine   = cm_t3730_init,
+	.init_late     = omap3630_init_late,
 	.timer          = &omap3_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 9e66e16..a33ad46 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -303,6 +303,7 @@ MACHINE_START(CM_T3517, "Compulab CM-T3517")
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= cm_t3517_init,
+	.init_late	= am35xx_init_late,
 	.timer		= &omap3_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index a2010f0..f616c8c 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -664,6 +664,7 @@ MACHINE_START(DEVKIT8000, "OMAP3 Devkit8000")
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= devkit8000_init,
+	.init_late	= omap35xx_init_late,
 	.timer		= &omap3_secure_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 098d183..56ffcc9 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -158,6 +158,7 @@ DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
 	.init_irq	= omap_init_irq,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= omap4_init,
+	.init_late	= omap4430_init_late,
 	.timer		= &omap4_timer,
 	.dt_compat	= omap4_boards_compat,
 	.restart	= omap_prcm_restart,
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 0bbbabe..876becf 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -398,6 +398,7 @@ MACHINE_START(OMAP_H4, "OMAP2420 H4 board")
 	.init_irq	= omap2_init_irq,
 	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= omap_h4_init,
+	.init_late	= omap2420_init_late,
 	.timer		= &omap2_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 930c0d3..21df74e 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -684,6 +684,7 @@ MACHINE_START(IGEP0020, "IGEP v2 board")
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= igep_init,
+	.init_late	= omap35xx_init_late,
 	.timer		= &omap3_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
@@ -696,6 +697,7 @@ MACHINE_START(IGEP0030, "IGEP OMAP3 module")
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= igep_init,
+	.init_late	= omap35xx_init_late,
 	.timer		= &omap3_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 1b60495..ef9e829 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -442,6 +442,7 @@ MACHINE_START(OMAP_LDP, "OMAP LDP board")
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_ldp_init,
+	.init_late	= omap3430_init_late,
 	.timer		= &omap3_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 518091c..8ca14e8 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -694,6 +694,7 @@ MACHINE_START(NOKIA_N800, "Nokia N800")
 	.init_irq	= omap2_init_irq,
 	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= n8x0_init_machine,
+	.init_late	= omap2420_init_late,
 	.timer		= &omap2_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
@@ -706,6 +707,7 @@ MACHINE_START(NOKIA_N810, "Nokia N810")
 	.init_irq	= omap2_init_irq,
 	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= n8x0_init_machine,
+	.init_late	= omap2420_init_late,
 	.timer		= &omap2_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
@@ -718,6 +720,7 @@ MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
 	.init_irq	= omap2_init_irq,
 	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= n8x0_init_machine,
+	.init_late	= omap2420_init_late,
 	.timer		= &omap2_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 7be8d65..b6cd804 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -565,6 +565,7 @@ MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3_beagle_init,
+	.init_late	= omap3_init_late,
 	.timer		= &omap3_secure_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 49df127..e98c230 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -692,6 +692,7 @@ MACHINE_START(OMAP3EVM, "OMAP3 EVM")
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3_evm_init,
+	.init_late	= omap35xx_init_late,
 	.timer		= &omap3_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 9b3c141..8927927 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -218,6 +218,7 @@ MACHINE_START(OMAP3_TORPEDO, "Logic OMAP3 Torpedo board")
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3logic_init,
+	.init_late	= omap35xx_init_late,
 	.timer		= &omap3_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
@@ -230,6 +231,7 @@ MACHINE_START(OMAP3530_LV_SOM, "OMAP Logic 3530 LV SOM board")
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3logic_init,
+	.init_late	= omap35xx_init_late,
 	.timer		= &omap3_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 33d995d..57aebee 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -622,6 +622,7 @@ MACHINE_START(OMAP3_PANDORA, "Pandora Handheld Console")
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3pandora_init,
+	.init_late	= omap35xx_init_late,
 	.timer		= &omap3_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 4dffc95..c05fe3a 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -457,6 +457,7 @@ MACHINE_START(SBC3530, "OMAP3 STALKER")
 	.init_irq		= omap3_init_irq,
 	.handle_irq		= omap3_intc_handle_irq,
 	.init_machine		= omap3_stalker_init,
+	.init_late		= omap35xx_init_late,
 	.timer			= &omap3_secure_timer,
 	.restart		= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index ae2251f..485d14d 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -387,6 +387,7 @@ MACHINE_START(TOUCHBOOK, "OMAP3 touchbook Board")
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3_touchbook_init,
+	.init_late	= omap3430_init_late,
 	.timer		= &omap3_secure_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 1b782ba..7ca817f 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -582,6 +582,7 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	.init_irq	= gic_init_irq,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= omap4_panda_init,
+	.init_late	= omap4430_init_late,
 	.timer		= &omap4_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 33aa391..af7ac0b 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -571,6 +571,7 @@ MACHINE_START(OVERO, "Gumstix Overo")
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= overo_init,
+	.init_late	= omap35xx_init_late,
 	.timer		= &omap3_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index ae53d71..0ad1bb3 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -151,6 +151,7 @@ MACHINE_START(NOKIA_RM680, "Nokia RM-680 board")
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= rm680_init,
+	.init_late	= omap3630_init_late,
 	.timer		= &omap3_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
@@ -163,6 +164,7 @@ MACHINE_START(NOKIA_RM696, "Nokia RM-696 board")
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= rm680_init,
+	.init_late	= omap3630_init_late,
 	.timer		= &omap3_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 27f01f0..5010f6d 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -129,6 +129,7 @@ MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= rx51_init,
+	.init_late	= omap3430_init_late,
 	.timer		= &omap3_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
index ab9a7a9..d4c8392 100644
--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@ -52,6 +52,7 @@ MACHINE_START(TI8168EVM, "ti8168evm")
 	.init_irq	= ti81xx_init_irq,
 	.timer		= &omap3_timer,
 	.init_machine	= ti81xx_evm_init,
+	.init_late	= ti81xx_init_late,
 	.restart	= omap_prcm_restart,
 MACHINE_END
 
@@ -63,5 +64,6 @@ MACHINE_START(TI8148EVM, "ti8148evm")
 	.init_irq	= ti81xx_init_irq,
 	.timer		= &omap3_timer,
 	.init_machine	= ti81xx_evm_init,
+	.init_late	= ti81xx_init_late,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index 5c20bcc..4e7e561 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -137,6 +137,7 @@ MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_zoom_init,
+	.init_late	= omap3430_init_late,
 	.timer		= &omap3_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
@@ -149,6 +150,7 @@ MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
 	.init_irq	= omap3_init_irq,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_zoom_init,
+	.init_late	= omap3630_init_late,
 	.timer		= &omap3_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 57da7f4..58ef29b 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -78,6 +78,42 @@ static inline void omap44xx_map_common_io(void)
 }
 #endif
 
+#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP2)
+int omap2_pm_init(void);
+#else
+static inline int omap2_pm_init(void)
+{
+	return 0;
+}
+#endif
+
+#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
+int omap3_pm_init(void);
+#else
+static inline int omap3_pm_init(void)
+{
+	return 0;
+}
+#endif
+
+#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP4)
+int omap4_pm_init(void);
+#else
+static inline int omap4_pm_init(void)
+{
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_OMAP_MUX
+int omap_mux_late_init(void);
+#else
+static inline int omap_mux_late_init(void)
+{
+	return 0;
+}
+#endif
+
 extern void omap2_init_common_infrastructure(void);
 
 extern struct sys_timer omap2_timer;
@@ -94,6 +130,17 @@ void omap3_init_early(void);	/* Do not use this one */
 void am35xx_init_early(void);
 void ti81xx_init_early(void);
 void omap4430_init_early(void);
+void omap3_init_late(void);	/* Do not use this one */
+void omap4430_init_late(void);
+void omap2420_init_late(void);
+void omap2430_init_late(void);
+void omap3430_init_late(void);
+void omap35xx_init_late(void);
+void omap3630_init_late(void);
+void am35xx_init_late(void);
+void ti81xx_init_late(void);
+void omap4430_init_late(void);
+int omap2_common_pm_late_init(void);
 void omap_prcm_restart(char, const char *);
 
 /*
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 065bd76..cc86e71 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -397,6 +397,13 @@ void __init omap2420_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap2420_clk_init();
 }
+
+void __init omap2420_init_late(void)
+{
+	omap_mux_late_init();
+	omap2_common_pm_late_init();
+	omap2_pm_init();
+}
 #endif
 
 #ifdef CONFIG_SOC_OMAP2430
@@ -412,6 +419,13 @@ void __init omap2430_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap2430_clk_init();
 }
+
+void __init omap2430_init_late(void)
+{
+	omap_mux_late_init();
+	omap2_common_pm_late_init();
+	omap2_pm_init();
+}
 #endif
 
 /*
@@ -466,6 +480,48 @@ void __init ti81xx_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap3xxx_clk_init();
 }
+
+void __init omap3_init_late(void)
+{
+	omap_mux_late_init();
+	omap2_common_pm_late_init();
+	omap3_pm_init();
+}
+
+void __init omap3430_init_late(void)
+{
+	omap_mux_late_init();
+	omap2_common_pm_late_init();
+	omap3_pm_init();
+}
+
+void __init omap35xx_init_late(void)
+{
+	omap_mux_late_init();
+	omap2_common_pm_late_init();
+	omap3_pm_init();
+}
+
+void __init omap3630_init_late(void)
+{
+	omap_mux_late_init();
+	omap2_common_pm_late_init();
+	omap3_pm_init();
+}
+
+void __init am35xx_init_late(void)
+{
+	omap_mux_late_init();
+	omap2_common_pm_late_init();
+	omap3_pm_init();
+}
+
+void __init ti81xx_init_late(void)
+{
+	omap_mux_late_init();
+	omap2_common_pm_late_init();
+	omap3_pm_init();
+}
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
@@ -482,6 +538,13 @@ void __init omap4430_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap4xxx_clk_init();
 }
+
+void __init omap4430_init_late(void)
+{
+	omap_mux_late_init();
+	omap2_common_pm_late_init();
+	omap4_pm_init();
+}
 #endif
 
 void __init omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 65c3391..0ede4d6 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -788,7 +788,7 @@ static void __init omap_mux_free_names(struct omap_mux *m)
 }
 
 /* Free all data except for GPIO pins unless CONFIG_DEBUG_FS is set */
-static int __init omap_mux_late_init(void)
+int __init omap_mux_late_init(void)
 {
 	struct omap_mux_partition *partition;
 	int ret;
@@ -823,7 +823,6 @@ static int __init omap_mux_late_init(void)
 
 	return 0;
 }
-late_initcall(omap_mux_late_init);
 
 static void __init omap_mux_package_fixup(struct omap_mux *p,
 					struct omap_mux *superset)
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index d0c1c96..9cb5ced 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -295,7 +295,7 @@ static int __init omap2_common_pm_init(void)
 }
 postcore_initcall(omap2_common_pm_init);
 
-static int __init omap2_common_pm_late_init(void)
+int __init omap2_common_pm_late_init(void)
 {
 	/*
 	 * In the case of DT, the PMIC and SR initialization will be done using
@@ -322,4 +322,3 @@ static int __init omap2_common_pm_late_init(void)
 
 	return 0;
 }
-late_initcall(omap2_common_pm_late_init);
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 95442b6..b2758b8 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -301,13 +301,10 @@ static void __init prcm_setup_regs(void)
 				WKUP_MOD, PM_WKEN);
 }
 
-static int __init omap2_pm_init(void)
+int __init omap2_pm_init(void)
 {
 	u32 l;
 
-	if (!cpu_is_omap24xx())
-		return -ENODEV;
-
 	printk(KERN_INFO "Power Management for OMAP2 initializing\n");
 	l = omap2_prm_read_mod_reg(OCP_MOD, OMAP2_PRCM_REVISION_OFFSET);
 	printk(KERN_INFO "PRCM revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
@@ -373,17 +370,13 @@ static int __init omap2_pm_init(void)
 	 * These routines need to be in SRAM as that's the only
 	 * memory the MPU can see when it wakes up.
 	 */
-	if (cpu_is_omap24xx()) {
-		omap2_sram_idle = omap_sram_push(omap24xx_idle_loop_suspend,
-						 omap24xx_idle_loop_suspend_sz);
+	omap2_sram_idle = omap_sram_push(omap24xx_idle_loop_suspend,
+					 omap24xx_idle_loop_suspend_sz);
 
-		omap2_sram_suspend = omap_sram_push(omap24xx_cpu_suspend,
-						    omap24xx_cpu_suspend_sz);
-	}
+	omap2_sram_suspend = omap_sram_push(omap24xx_cpu_suspend,
+					    omap24xx_cpu_suspend_sz);
 
 	arm_pm_idle = omap2_pm_idle;
 
 	return 0;
 }
-
-late_initcall(omap2_pm_init);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 703bd10..c769b88 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -699,15 +699,12 @@ static void __init pm_errata_configure(void)
 	}
 }
 
-static int __init omap3_pm_init(void)
+int __init omap3_pm_init(void)
 {
 	struct power_state *pwrst, *tmp;
 	struct clockdomain *neon_clkdm, *per_clkdm, *mpu_clkdm, *core_clkdm;
 	int ret;
 
-	if (!cpu_is_omap34xx())
-		return -ENODEV;
-
 	if (!omap3_has_io_chain_ctrl())
 		pr_warning("PM: no software I/O chain control; some wakeups may be lost\n");
 
@@ -808,5 +805,3 @@ err2:
 err1:
 	return ret;
 }
-
-late_initcall(omap3_pm_init);
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 88562535..ea24174 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -141,15 +141,12 @@ static void omap_default_idle(void)
  * Initializes all powerdomain and clockdomain target states
  * and all PRCM settings.
  */
-static int __init omap4_pm_init(void)
+int __init omap4_pm_init(void)
 {
 	int ret;
 	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm, *l4wkup;
 	struct clockdomain *ducati_clkdm, *l3_2_clkdm, *l4_per_clkdm;
 
-	if (!cpu_is_omap44xx())
-		return -ENODEV;
-
 	if (omap_rev() == OMAP4430_REV_ES1_0) {
 		WARN(1, "Power Management not supported on OMAP4430 ES1.0\n");
 		return -ENODEV;
@@ -217,4 +214,3 @@ static int __init omap4_pm_init(void)
 err2:
 	return ret;
 }
-late_initcall(omap4_pm_init);
-- 
1.7.5.4
