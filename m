From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 15 Jun 2012 11:12:16 +0200
Subject: [PATCH v2 5/7] ARM: at91: sparse irq support
In-Reply-To: <1339751352-24296-1-git-send-email-ludovic.desroches@atmel.com>
References: <1339751352-24296-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1339751536-24388-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable sparse irq support for multisoc image.
Move NR_AIC_IRQS macro to a more appropiate place with the purpose to
remove mach/irqs.h later.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/mach-at91/Kconfig                 |    1 +
 arch/arm/mach-at91/at91rm9200.c            |    1 +
 arch/arm/mach-at91/at91sam9260.c           |    1 +
 arch/arm/mach-at91/at91sam9261.c           |    1 +
 arch/arm/mach-at91/at91sam9263.c           |    1 +
 arch/arm/mach-at91/at91sam9g45.c           |    1 +
 arch/arm/mach-at91/at91sam9rl.c            |    1 +
 arch/arm/mach-at91/at91x40.c               |    1 +
 arch/arm/mach-at91/board-1arm.c            |    1 +
 arch/arm/mach-at91/board-afeb-9260v1.c     |    1 +
 arch/arm/mach-at91/board-cam60.c           |    1 +
 arch/arm/mach-at91/board-carmeva.c         |    1 +
 arch/arm/mach-at91/board-cpu9krea.c        |    1 +
 arch/arm/mach-at91/board-cpuat91.c         |    1 +
 arch/arm/mach-at91/board-csb337.c          |    1 +
 arch/arm/mach-at91/board-csb637.c          |    1 +
 arch/arm/mach-at91/board-eb01.c            |    1 +
 arch/arm/mach-at91/board-eb9200.c          |    1 +
 arch/arm/mach-at91/board-ecbat91.c         |    1 +
 arch/arm/mach-at91/board-eco920.c          |    1 +
 arch/arm/mach-at91/board-flexibity.c       |    1 +
 arch/arm/mach-at91/board-foxg20.c          |    1 +
 arch/arm/mach-at91/board-gsia18s.c         |    1 +
 arch/arm/mach-at91/board-kafa.c            |    1 +
 arch/arm/mach-at91/board-kb9202.c          |    1 +
 arch/arm/mach-at91/board-neocore926.c      |    1 +
 arch/arm/mach-at91/board-pcontrol-g20.c    |    1 +
 arch/arm/mach-at91/board-picotux200.c      |    1 +
 arch/arm/mach-at91/board-qil-a9260.c       |    1 +
 arch/arm/mach-at91/board-rm9200dk.c        |    1 +
 arch/arm/mach-at91/board-rm9200ek.c        |    1 +
 arch/arm/mach-at91/board-rsi-ews.c         |    1 +
 arch/arm/mach-at91/board-sam9-l9260.c      |    1 +
 arch/arm/mach-at91/board-sam9260ek.c       |    1 +
 arch/arm/mach-at91/board-sam9261ek.c       |    1 +
 arch/arm/mach-at91/board-sam9263ek.c       |    1 +
 arch/arm/mach-at91/board-sam9g20ek.c       |    2 ++
 arch/arm/mach-at91/board-sam9m10g45ek.c    |    1 +
 arch/arm/mach-at91/board-sam9rlek.c        |    1 +
 arch/arm/mach-at91/board-snapper9260.c     |    1 +
 arch/arm/mach-at91/board-stamp9g20.c       |    2 ++
 arch/arm/mach-at91/board-usb-a926x.c       |    3 +++
 arch/arm/mach-at91/board-yl-9200.c         |    1 +
 arch/arm/mach-at91/gpio.c                  |    1 +
 arch/arm/mach-at91/include/mach/at91_aic.h |    3 +++
 arch/arm/mach-at91/include/mach/irqs.h     |   10 ----------
 arch/arm/mach-at91/pm.c                    |    1 +
 47 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index e401dea..7d0c40a 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -30,6 +30,7 @@ config SOC_AT91SAM9
 	bool
 	select CPU_ARM926T
 	select MULTI_IRQ_HANDLER
+	select SPARSE_IRQ
 	select AT91_SAM9_TIME
 	select AT91_SAM9_SMC
 
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 2691768..6f50c67 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -17,6 +17,7 @@
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
 #include <mach/at91rm9200.h>
+#include <mach/at91_aic.h>
 #include <mach/at91_pmc.h>
 #include <mach/at91_st.h>
 #include <mach/cpu.h>
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 2b1e438..30c7f26 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -20,6 +20,7 @@
 #include <mach/cpu.h>
 #include <mach/at91_dbgu.h>
 #include <mach/at91sam9260.h>
+#include <mach/at91_aic.h>
 #include <mach/at91_pmc.h>
 #include <mach/at91_rstc.h>
 
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index c77d503..f40762c 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -19,6 +19,7 @@
 #include <asm/system_misc.h>
 #include <mach/cpu.h>
 #include <mach/at91sam9261.h>
+#include <mach/at91_aic.h>
 #include <mach/at91_pmc.h>
 #include <mach/at91_rstc.h>
 
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index ed91c7e..84b3810 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -18,6 +18,7 @@
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
 #include <mach/at91sam9263.h>
+#include <mach/at91_aic.h>
 #include <mach/at91_pmc.h>
 #include <mach/at91_rstc.h>
 
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 4792682..9771273 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -18,6 +18,7 @@
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
 #include <mach/at91sam9g45.h>
+#include <mach/at91_aic.h>
 #include <mach/at91_pmc.h>
 #include <mach/cpu.h>
 
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index e420085..e7d9e1e 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -17,6 +17,7 @@
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
 #include <mach/cpu.h>
+#include <mach/at91_aic.h>
 #include <mach/at91_dbgu.h>
 #include <mach/at91sam9rl.h>
 #include <mach/at91_pmc.h>
diff --git a/arch/arm/mach-at91/at91x40.c b/arch/arm/mach-at91/at91x40.c
index d62fe09..4c0f5fd 100644
--- a/arch/arm/mach-at91/at91x40.c
+++ b/arch/arm/mach-at91/at91x40.c
@@ -17,6 +17,7 @@
 #include <asm/system_misc.h>
 #include <asm/mach/arch.h>
 #include <mach/at91x40.h>
+#include <mach/at91_aic.h>
 #include <mach/at91_st.h>
 #include <mach/timex.h>
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
index 22d8856..7a54904 100644
--- a/arch/arm/mach-at91/board-1arm.c
+++ b/arch/arm/mach-at91/board-1arm.c
@@ -92,6 +92,7 @@ MACHINE_START(ONEARM, "Ajeco 1ARM single board computer")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= onearm_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
index de7be19..24e45e1 100644
--- a/arch/arm/mach-at91/board-afeb-9260v1.c
+++ b/arch/arm/mach-at91/board-afeb-9260v1.c
@@ -213,6 +213,7 @@ MACHINE_START(AFEB9260, "Custom afeb9260 board")
 	/* Maintainer: Sergey Lapin <slapin@ossfans.org> */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= afeb9260_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
index 477e708..3d239b4 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -189,6 +189,7 @@ MACHINE_START(CAM60, "KwikByte CAM60")
 	/* Maintainer: KwikByte */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= cam60_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-carmeva.c b/arch/arm/mach-at91/board-carmeva.c
index a5b002f..7d5585b 100644
--- a/arch/arm/mach-at91/board-carmeva.c
+++ b/arch/arm/mach-at91/board-carmeva.c
@@ -159,6 +159,7 @@ MACHINE_START(CARMEVA, "Carmeva")
 	/* Maintainer: Conitec Datasystems */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= carmeva_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index ecbc13b..78a8cd7 100644
--- a/arch/arm/mach-at91/board-cpu9krea.c
+++ b/arch/arm/mach-at91/board-cpu9krea.c
@@ -377,6 +377,7 @@ MACHINE_START(CPUAT9G20, "Eukrea CPU9G20")
 	/* Maintainer: Eric Benard - EUKREA Electromatique */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= cpu9krea_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-cpuat91.c b/arch/arm/mach-at91/board-cpuat91.c
index 2e6d043..7334f9b 100644
--- a/arch/arm/mach-at91/board-cpuat91.c
+++ b/arch/arm/mach-at91/board-cpuat91.c
@@ -179,6 +179,7 @@ MACHINE_START(CPUAT91, "Eukrea")
 	/* Maintainer: Eric Benard - EUKREA Electromatique */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= cpuat91_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-csb337.c b/arch/arm/mach-at91/board-csb337.c
index 462bc31..ba4c577 100644
--- a/arch/arm/mach-at91/board-csb337.c
+++ b/arch/arm/mach-at91/board-csb337.c
@@ -253,6 +253,7 @@ MACHINE_START(CSB337, "Cogent CSB337")
 	/* Maintainer: Bill Gatliff */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= csb337_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-csb637.c b/arch/arm/mach-at91/board-csb637.c
index 872871a..bbca258 100644
--- a/arch/arm/mach-at91/board-csb637.c
+++ b/arch/arm/mach-at91/board-csb637.c
@@ -134,6 +134,7 @@ MACHINE_START(CSB637, "Cogent CSB637")
 	/* Maintainer: Bill Gatliff */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= csb637_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-eb01.c b/arch/arm/mach-at91/board-eb01.c
index 01f66e9..ab6b11c 100644
--- a/arch/arm/mach-at91/board-eb01.c
+++ b/arch/arm/mach-at91/board-eb01.c
@@ -44,6 +44,7 @@ static void __init at91eb01_init_early(void)
 MACHINE_START(AT91EB01, "Atmel AT91 EB01")
 	/* Maintainer: Greg Ungerer <gerg@snapgear.com> */
 	.timer		= &at91x40_timer,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= at91eb01_init_early,
 	.init_irq	= at91eb01_init_irq,
diff --git a/arch/arm/mach-at91/board-eb9200.c b/arch/arm/mach-at91/board-eb9200.c
index d1e1f3f..2ab2b10 100644
--- a/arch/arm/mach-at91/board-eb9200.c
+++ b/arch/arm/mach-at91/board-eb9200.c
@@ -119,6 +119,7 @@ static void __init eb9200_board_init(void)
 MACHINE_START(ATEB9200, "Embest ATEB9200")
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= eb9200_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
index 9c24cb2..dae983c 100644
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ b/arch/arm/mach-at91/board-ecbat91.c
@@ -171,6 +171,7 @@ MACHINE_START(ECBAT91, "emQbit's ECB_AT91")
 	/* Maintainer: emQbit.com */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ecb_at91init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-eco920.c b/arch/arm/mach-at91/board-eco920.c
index 82bdfde..3216d68 100644
--- a/arch/arm/mach-at91/board-eco920.c
+++ b/arch/arm/mach-at91/board-eco920.c
@@ -133,6 +133,7 @@ MACHINE_START(ECO920, "eco920")
 	/* Maintainer: Sascha Hauer */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= eco920_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-flexibity.c b/arch/arm/mach-at91/board-flexibity.c
index 6cc83a8..9095fdb 100644
--- a/arch/arm/mach-at91/board-flexibity.c
+++ b/arch/arm/mach-at91/board-flexibity.c
@@ -160,6 +160,7 @@ static void __init flexibity_board_init(void)
 MACHINE_START(FLEXIBITY, "Flexibity Connect")
 	/* Maintainer: Maxim Osipov */
 	.timer		= &at91sam926x_timer,
+	.nr_irqs	= NR_AIC_IRQS,
 	.map_io		= at91_map_io,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= flexibity_init_early,
diff --git a/arch/arm/mach-at91/board-foxg20.c b/arch/arm/mach-at91/board-foxg20.c
index 69ab124..1b5fa55 100644
--- a/arch/arm/mach-at91/board-foxg20.c
+++ b/arch/arm/mach-at91/board-foxg20.c
@@ -263,6 +263,7 @@ MACHINE_START(ACMENETUSFOXG20, "Acme Systems srl FOX Board G20")
 	/* Maintainer: Sergio Tanzilli */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= foxg20_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-gsia18s.c b/arch/arm/mach-at91/board-gsia18s.c
index a9d5e78..ee18183 100644
--- a/arch/arm/mach-at91/board-gsia18s.c
+++ b/arch/arm/mach-at91/board-gsia18s.c
@@ -576,6 +576,7 @@ static void __init gsia18s_board_init(void)
 MACHINE_START(GSIA18S, "GS_IA18_S")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= gsia18s_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
index 64c1dbf..23eb5bd 100644
--- a/arch/arm/mach-at91/board-kafa.c
+++ b/arch/arm/mach-at91/board-kafa.c
@@ -94,6 +94,7 @@ MACHINE_START(KAFA, "Sperry-Sun KAFA")
 	/* Maintainer: Sergei Sharonov */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= kafa_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index 5d96cb8..dab34ef 100644
--- a/arch/arm/mach-at91/board-kb9202.c
+++ b/arch/arm/mach-at91/board-kb9202.c
@@ -134,6 +134,7 @@ MACHINE_START(KB9200, "KB920x")
 	/* Maintainer: KwikByte, Inc. */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= kb9202_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
index 18103c5d..e11ced0 100644
--- a/arch/arm/mach-at91/board-neocore926.c
+++ b/arch/arm/mach-at91/board-neocore926.c
@@ -379,6 +379,7 @@ MACHINE_START(NEOCORE926, "ADENEO NEOCORE 926")
 	/* Maintainer: ADENEO */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= neocore926_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
index 9ca3e32..cf35e39 100644
--- a/arch/arm/mach-at91/board-pcontrol-g20.c
+++ b/arch/arm/mach-at91/board-pcontrol-g20.c
@@ -219,6 +219,7 @@ MACHINE_START(PCONTROL_G20, "PControl G20")
 	/* Maintainer: pgsellmann at portner-elektronik.at */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= pcontrol_g20_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index 1270655..1328d0f 100644
--- a/arch/arm/mach-at91/board-picotux200.c
+++ b/arch/arm/mach-at91/board-picotux200.c
@@ -121,6 +121,7 @@ MACHINE_START(PICOTUX2XX, "picotux 200")
 	/* Maintainer: Kleinhenz Elektronik GmbH */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= picotux200_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
index bf351e2..3100157 100644
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ b/arch/arm/mach-at91/board-qil-a9260.c
@@ -259,6 +259,7 @@ MACHINE_START(QIL_A9260, "CALAO QIL_A9260")
 	/* Maintainer: calao-systems */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
index cc2bf97..f9dba77 100644
--- a/arch/arm/mach-at91/board-rm9200dk.c
+++ b/arch/arm/mach-at91/board-rm9200dk.c
@@ -224,6 +224,7 @@ MACHINE_START(AT91RM9200DK, "Atmel AT91RM9200-DK")
 	/* Maintainer: SAN People/Atmel */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= dk_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
index 62e19e6..29768f7 100644
--- a/arch/arm/mach-at91/board-rm9200ek.c
+++ b/arch/arm/mach-at91/board-rm9200ek.c
@@ -191,6 +191,7 @@ MACHINE_START(AT91RM9200EK, "Atmel AT91RM9200-EK")
 	/* Maintainer: SAN People/Atmel */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-rsi-ews.c b/arch/arm/mach-at91/board-rsi-ews.c
index c3b43ae..d68e39f 100644
--- a/arch/arm/mach-at91/board-rsi-ews.c
+++ b/arch/arm/mach-at91/board-rsi-ews.c
@@ -226,6 +226,7 @@ MACHINE_START(RSI_EWS, "RSI EWS")
 	/* Maintainer: Josef Holzmayr <holzmayr@rsi-elektrotechnik.de> */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= rsi_ews_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
index 7bf6da7..711a257 100644
--- a/arch/arm/mach-at91/board-sam9-l9260.c
+++ b/arch/arm/mach-at91/board-sam9-l9260.c
@@ -203,6 +203,7 @@ MACHINE_START(SAM9_L9260, "Olimex SAM9-L9260")
 	/* Maintainer: Olimex */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index 889c1bf..028540b 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -345,6 +345,7 @@ MACHINE_START(AT91SAM9260EK, "Atmel AT91SAM9260-EK")
 	/* Maintainer: Atmel */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index 2269be5..e09f759 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -616,6 +616,7 @@ MACHINE_START(AT91SAM9G10EK, "Atmel AT91SAM9G10-EK")
 	/* Maintainer: Atmel */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index 82adf58..ae3a266 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -444,6 +444,7 @@ MACHINE_START(AT91SAM9263EK, "Atmel AT91SAM9263-EK")
 	/* Maintainer: Atmel */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 4ea4ee0..7a16f81 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -414,6 +414,7 @@ MACHINE_START(AT91SAM9G20EK, "Atmel AT91SAM9G20-EK")
 	/* Maintainer: Atmel */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
@@ -424,6 +425,7 @@ MACHINE_START(AT91SAM9G20EK_2MMC, "Atmel AT91SAM9G20-EK 2 MMC Slot Mod")
 	/* Maintainer: Atmel */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index 3d48ec1..874d971 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -504,6 +504,7 @@ MACHINE_START(AT91SAM9M10G45EK, "Atmel AT91SAM9M10G45-EK")
 	/* Maintainer: Atmel */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index e7dc3ea..4b561b4 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -320,6 +320,7 @@ MACHINE_START(AT91SAM9RLEK, "Atmel AT91SAM9RL-EK")
 	/* Maintainer: Atmel */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-snapper9260.c b/arch/arm/mach-at91/board-snapper9260.c
index a4e031a..21f4dac 100644
--- a/arch/arm/mach-at91/board-snapper9260.c
+++ b/arch/arm/mach-at91/board-snapper9260.c
@@ -179,6 +179,7 @@ static void __init snapper9260_board_init(void)
 MACHINE_START(SNAPPER_9260, "Bluewater Systems Snapper 9260/9G20 module")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= snapper9260_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index 29eae16..dbc3488 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -288,6 +288,7 @@ MACHINE_START(PORTUXG20, "taskit PortuxG20")
 	/* Maintainer: taskit GmbH */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= stamp9g20_init_early,
 	.init_irq	= at91_init_irq_default,
@@ -298,6 +299,7 @@ MACHINE_START(STAMP9G20, "taskit Stamp9G20")
 	/* Maintainer: taskit GmbH */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= stamp9g20_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-usb-a926x.c b/arch/arm/mach-at91/board-usb-a926x.c
index c1476b9..791c953 100644
--- a/arch/arm/mach-at91/board-usb-a926x.c
+++ b/arch/arm/mach-at91/board-usb-a926x.c
@@ -359,6 +359,7 @@ MACHINE_START(USB_A9263, "CALAO USB_A9263")
 	/* Maintainer: calao-systems */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
@@ -369,6 +370,7 @@ MACHINE_START(USB_A9260, "CALAO USB_A9260")
 	/* Maintainer: calao-systems */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
@@ -379,6 +381,7 @@ MACHINE_START(USB_A9G20, "CALAO USB_A92G0")
 	/* Maintainer: Jean-Christophe PLAGNIOL-VILLARD */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index 516d340..1e94d76 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -591,6 +591,7 @@ MACHINE_START(YL9200, "uCdragon YL-9200")
 	/* Maintainer: S.Birtles */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= yl9200_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index be42cf0..650bf9a 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -29,6 +29,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/at91_aic.h>
 #include <mach/at91_pio.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-at91/include/mach/at91_aic.h b/arch/arm/mach-at91/include/mach/at91_aic.h
index 3510e35..2678e75 100644
--- a/arch/arm/mach-at91/include/mach/at91_aic.h
+++ b/arch/arm/mach-at91/include/mach/at91_aic.h
@@ -28,6 +28,9 @@ extern void __iomem *at91_aic_base;
 .extern at91_aic_base
 #endif
 
+/* Number of irq lines managed by AIC */
+#define NR_AIC_IRQS	32
+
 #define AT91_AIC_SMR(n)		((n) * 4)		/* Source Mode Registers 0-31 */
 #define		AT91_AIC_PRIOR		(7 << 0)		/* Priority Level */
 #define		AT91_AIC_SRCTYPE	(3 << 5)		/* Interrupt Source Type */
diff --git a/arch/arm/mach-at91/include/mach/irqs.h b/arch/arm/mach-at91/include/mach/irqs.h
index 2d510ee..9223a1e 100644
--- a/arch/arm/mach-at91/include/mach/irqs.h
+++ b/arch/arm/mach-at91/include/mach/irqs.h
@@ -24,16 +24,6 @@
 #include <linux/io.h>
 #include <mach/at91_aic.h>
 
-#define NR_AIC_IRQS 32
-
-
-/*
- * IRQ interrupt symbols are the AT91xxx_ID_* symbols
- * for IRQs handled directly through the AIC, or else the AT91_PIN_*
- * symbols in gpio.h for ones handled indirectly as GPIOs.
- * We make provision for 5 banks of GPIO.
- */
-#define	NR_IRQS		(NR_AIC_IRQS + (5 * 32))
 
 /* FIQ is AIC source 0. */
 #define FIQ_START AT91_ID_FIQ
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 1bfaad6..2c2d865 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -25,6 +25,7 @@
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
 
+#include <mach/at91_aic.h>
 #include <mach/at91_pmc.h>
 #include <mach/cpu.h>
 
-- 
1.7.5.4
