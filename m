From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Tue, 5 Jun 2012 16:47:43 +0200
Subject: [PATCH 3/4] ARM: at91: enable use of sparse irq
In-Reply-To: <1338907664-24646-1-git-send-email-ludovic.desroches@atmel.com>
References: <1338907664-24646-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1338907664-24646-4-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

If we want to have one kernel for all atmel SOCs, nr_irqs has to be set at
runtime since the number of irqs managed by AIC depends on its version.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/mach-at91/Kconfig              |    1 +
 arch/arm/mach-at91/at91rm9200.c         |    1 +
 arch/arm/mach-at91/at91sam9260.c        |    1 +
 arch/arm/mach-at91/at91sam9261.c        |    1 +
 arch/arm/mach-at91/at91sam9263.c        |    1 +
 arch/arm/mach-at91/at91sam9g45.c        |    1 +
 arch/arm/mach-at91/at91sam9rl.c         |    1 +
 arch/arm/mach-at91/at91x40.c            |    1 +
 arch/arm/mach-at91/board-1arm.c         |    2 ++
 arch/arm/mach-at91/board-afeb-9260v1.c  |    2 ++
 arch/arm/mach-at91/board-cam60.c        |    2 ++
 arch/arm/mach-at91/board-carmeva.c      |    2 ++
 arch/arm/mach-at91/board-cpu9krea.c     |    2 ++
 arch/arm/mach-at91/board-cpuat91.c      |    2 ++
 arch/arm/mach-at91/board-csb337.c       |    2 ++
 arch/arm/mach-at91/board-csb637.c       |    2 ++
 arch/arm/mach-at91/board-dt.c           |    1 +
 arch/arm/mach-at91/board-eb01.c         |    2 ++
 arch/arm/mach-at91/board-eb9200.c       |    2 ++
 arch/arm/mach-at91/board-ecbat91.c      |    2 ++
 arch/arm/mach-at91/board-eco920.c       |    2 ++
 arch/arm/mach-at91/board-flexibity.c    |    2 ++
 arch/arm/mach-at91/board-foxg20.c       |    2 ++
 arch/arm/mach-at91/board-gsia18s.c      |    2 ++
 arch/arm/mach-at91/board-kafa.c         |    2 ++
 arch/arm/mach-at91/board-kb9202.c       |    2 ++
 arch/arm/mach-at91/board-neocore926.c   |    2 ++
 arch/arm/mach-at91/board-pcontrol-g20.c |    2 ++
 arch/arm/mach-at91/board-picotux200.c   |    2 ++
 arch/arm/mach-at91/board-qil-a9260.c    |    2 ++
 arch/arm/mach-at91/board-rm9200dk.c     |    2 ++
 arch/arm/mach-at91/board-rm9200ek.c     |    2 ++
 arch/arm/mach-at91/board-rsi-ews.c      |    2 ++
 arch/arm/mach-at91/board-sam9-l9260.c   |    2 ++
 arch/arm/mach-at91/board-sam9260ek.c    |    2 ++
 arch/arm/mach-at91/board-sam9261ek.c    |    2 ++
 arch/arm/mach-at91/board-sam9263ek.c    |    2 ++
 arch/arm/mach-at91/board-sam9g20ek.c    |    2 ++
 arch/arm/mach-at91/board-sam9m10g45ek.c |    2 ++
 arch/arm/mach-at91/board-sam9rlek.c     |    2 ++
 arch/arm/mach-at91/board-snapper9260.c  |    2 ++
 arch/arm/mach-at91/board-stamp9g20.c    |    2 ++
 arch/arm/mach-at91/board-usb-a926x.c    |    2 ++
 arch/arm/mach-at91/board-yl-9200.c      |    2 ++
 arch/arm/mach-at91/gpio.c               |    1 +
 arch/arm/mach-at91/include/mach/irqs.h  |    8 +++++---
 arch/arm/mach-at91/irq.c                |    1 +
 arch/arm/mach-at91/pm.c                 |    1 +
 48 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index e401dea..e1382de 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -30,6 +30,7 @@ config SOC_AT91SAM9
 	bool
 	select CPU_ARM926T
 	select MULTI_IRQ_HANDLER
+	select MAY_HAVE_SPARSE_IRQ
 	select AT91_SAM9_TIME
 	select AT91_SAM9_SMC
 
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 2691768..52e1613 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -20,6 +20,7 @@
 #include <mach/at91_pmc.h>
 #include <mach/at91_st.h>
 #include <mach/cpu.h>
+#include <mach/irqs.h>
 
 #include "soc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index ddba004..85bb7fa 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -18,6 +18,7 @@
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
 #include <mach/cpu.h>
+#include <mach/irqs.h>
 #include <mach/at91_dbgu.h>
 #include <mach/at91sam9260.h>
 #include <mach/at91_pmc.h>
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index c77d503..a8bd397 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -18,6 +18,7 @@
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
 #include <mach/cpu.h>
+#include <mach/irqs.h>
 #include <mach/at91sam9261.h>
 #include <mach/at91_pmc.h>
 #include <mach/at91_rstc.h>
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index d7ba530..6d2a0c1 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -17,6 +17,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
+#include <mach/irqs.h>
 #include <mach/at91sam9263.h>
 #include <mach/at91_pmc.h>
 #include <mach/at91_rstc.h>
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index aa24e82..68365c5 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -20,6 +20,7 @@
 #include <mach/at91sam9g45.h>
 #include <mach/at91_pmc.h>
 #include <mach/cpu.h>
+#include <mach/irqs.h>
 
 #include "soc.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index e420085..ddd7602 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -17,6 +17,7 @@
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
 #include <mach/cpu.h>
+#include <mach/irqs.h>
 #include <mach/at91_dbgu.h>
 #include <mach/at91sam9rl.h>
 #include <mach/at91_pmc.h>
diff --git a/arch/arm/mach-at91/at91x40.c b/arch/arm/mach-at91/at91x40.c
index d62fe09..323cfd2 100644
--- a/arch/arm/mach-at91/at91x40.c
+++ b/arch/arm/mach-at91/at91x40.c
@@ -18,6 +18,7 @@
 #include <asm/mach/arch.h>
 #include <mach/at91x40.h>
 #include <mach/at91_st.h>
+#include <mach/irqs.h>
 #include <mach/timex.h>
 #include "generic.h"
 
diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
index 8f1a255..d79f250 100644
--- a/arch/arm/mach-at91/board-1arm.c
+++ b/arch/arm/mach-at91/board-1arm.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/irq.h>
@@ -91,6 +92,7 @@ MACHINE_START(ONEARM, "Ajeco 1ARM single board computer")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= onearm_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
index 9ad5ff7..8029508 100644
--- a/arch/arm/mach-at91/board-afeb-9260v1.c
+++ b/arch/arm/mach-at91/board-afeb-9260v1.c
@@ -35,6 +35,7 @@
 #include <linux/dma-mapping.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/irq.h>
@@ -212,6 +213,7 @@ MACHINE_START(AFEB9260, "Custom afeb9260 board")
 	/* Maintainer: Sergey Lapin <slapin@ossfans.org> */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= afeb9260_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
index eebd83b..fd94ca1 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -30,6 +30,7 @@
 #include <linux/spi/flash.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/irq.h>
@@ -188,6 +189,7 @@ MACHINE_START(CAM60, "KwikByte CAM60")
 	/* Maintainer: KwikByte */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= cam60_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-carmeva.c b/arch/arm/mach-at91/board-carmeva.c
index 3f15674..61a358d 100644
--- a/arch/arm/mach-at91/board-carmeva.c
+++ b/arch/arm/mach-at91/board-carmeva.c
@@ -35,6 +35,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/board.h>
 
 #include "generic.h"
@@ -158,6 +159,7 @@ MACHINE_START(CARMEVA, "Carmeva")
 	/* Maintainer: Conitec Datasystems */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= carmeva_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index 00bbce0..7a00795 100644
--- a/arch/arm/mach-at91/board-cpu9krea.c
+++ b/arch/arm/mach-at91/board-cpu9krea.c
@@ -40,6 +40,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/board.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91sam9260_matrix.h>
@@ -376,6 +377,7 @@ MACHINE_START(CPUAT9G20, "Eukrea CPU9G20")
 	/* Maintainer: Eric Benard - EUKREA Electromatique */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= cpu9krea_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-cpuat91.c b/arch/arm/mach-at91/board-cpuat91.c
index 97afeeb..6c3ee98 100644
--- a/arch/arm/mach-at91/board-cpuat91.c
+++ b/arch/arm/mach-at91/board-cpuat91.c
@@ -28,6 +28,7 @@
 #include <linux/mtd/plat-ram.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/irq.h>
@@ -178,6 +179,7 @@ MACHINE_START(CPUAT91, "Eukrea")
 	/* Maintainer: Eric Benard - EUKREA Electromatique */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= cpuat91_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-csb337.c b/arch/arm/mach-at91/board-csb337.c
index a39f326..d361bd8 100644
--- a/arch/arm/mach-at91/board-csb337.c
+++ b/arch/arm/mach-at91/board-csb337.c
@@ -38,6 +38,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/board.h>
 
 #include "generic.h"
@@ -252,6 +253,7 @@ MACHINE_START(CSB337, "Cogent CSB337")
 	/* Maintainer: Bill Gatliff */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= csb337_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-csb637.c b/arch/arm/mach-at91/board-csb637.c
index 31956b5..9e60e57 100644
--- a/arch/arm/mach-at91/board-csb637.c
+++ b/arch/arm/mach-at91/board-csb637.c
@@ -35,6 +35,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/board.h>
 
 #include "generic.h"
@@ -133,6 +134,7 @@ MACHINE_START(CSB637, "Cogent CSB637")
 	/* Maintainer: Bill Gatliff */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= csb637_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-dt.c b/arch/arm/mach-at91/board-dt.c
index 4ed045b..8a70bfd 100644
--- a/arch/arm/mach-at91/board-dt.c
+++ b/arch/arm/mach-at91/board-dt.c
@@ -16,6 +16,7 @@
 #include <linux/of_platform.h>
 
 #include <mach/board.h>
+#include <mach/irqs.h>
 
 #include <asm/setup.h>
 #include <asm/irq.h>
diff --git a/arch/arm/mach-at91/board-eb01.c b/arch/arm/mach-at91/board-eb01.c
index d2a6d0b..3155460 100644
--- a/arch/arm/mach-at91/board-eb01.c
+++ b/arch/arm/mach-at91/board-eb01.c
@@ -25,6 +25,7 @@
 #include <linux/irq.h>
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/board.h>
@@ -43,6 +44,7 @@ static void __init at91eb01_init_early(void)
 MACHINE_START(AT91EB01, "Atmel AT91 EB01")
 	/* Maintainer: Greg Ungerer <gerg@snapgear.com> */
 	.timer		= &at91x40_timer,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= at91eb01_init_early,
 	.init_irq	= at91eb01_init_irq,
diff --git a/arch/arm/mach-at91/board-eb9200.c b/arch/arm/mach-at91/board-eb9200.c
index ef4370e..5f087a1 100644
--- a/arch/arm/mach-at91/board-eb9200.c
+++ b/arch/arm/mach-at91/board-eb9200.c
@@ -27,6 +27,7 @@
 #include <linux/device.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/irq.h>
@@ -118,6 +119,7 @@ static void __init eb9200_board_init(void)
 MACHINE_START(ATEB9200, "Embest ATEB9200")
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= eb9200_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
index a6a863c..1d749ad 100644
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ b/arch/arm/mach-at91/board-ecbat91.c
@@ -29,6 +29,7 @@
 #include <linux/spi/flash.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/irq.h>
@@ -170,6 +171,7 @@ MACHINE_START(ECBAT91, "emQbit's ECB_AT91")
 	/* Maintainer: emQbit.com */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ecb_at91init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-eco920.c b/arch/arm/mach-at91/board-eco920.c
index 6faa64d..58d7a3b 100644
--- a/arch/arm/mach-at91/board-eco920.c
+++ b/arch/arm/mach-at91/board-eco920.c
@@ -28,6 +28,7 @@
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
 #include <mach/cpu.h>
+#include <mach/irqs.h>
 
 #include "generic.h"
 
@@ -132,6 +133,7 @@ MACHINE_START(ECO920, "eco920")
 	/* Maintainer: Sascha Hauer */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= eco920_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-flexibity.c b/arch/arm/mach-at91/board-flexibity.c
index e4ed03a..444a142 100644
--- a/arch/arm/mach-at91/board-flexibity.c
+++ b/arch/arm/mach-at91/board-flexibity.c
@@ -34,6 +34,7 @@
 
 #include <mach/hardware.h>
 #include <mach/board.h>
+#include <mach/irqs.h>
 
 #include "generic.h"
 
@@ -159,6 +160,7 @@ static void __init flexibity_board_init(void)
 MACHINE_START(FLEXIBITY, "Flexibity Connect")
 	/* Maintainer: Maxim Osipov */
 	.timer		= &at91sam926x_timer,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.map_io		= at91_map_io,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= flexibity_init_early,
diff --git a/arch/arm/mach-at91/board-foxg20.c b/arch/arm/mach-at91/board-foxg20.c
index 1494e42..2c4b87a 100644
--- a/arch/arm/mach-at91/board-foxg20.c
+++ b/arch/arm/mach-at91/board-foxg20.c
@@ -33,6 +33,7 @@
 #include <linux/w1-gpio.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/irq.h>
@@ -262,6 +263,7 @@ MACHINE_START(ACMENETUSFOXG20, "Acme Systems srl FOX Board G20")
 	/* Maintainer: Sergio Tanzilli */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= foxg20_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-gsia18s.c b/arch/arm/mach-at91/board-gsia18s.c
index 4eec88b..b80d884 100644
--- a/arch/arm/mach-at91/board-gsia18s.c
+++ b/arch/arm/mach-at91/board-gsia18s.c
@@ -34,6 +34,7 @@
 #include <mach/at91sam9_smc.h>
 #include <mach/gsia18s.h>
 #include <mach/stamp9g20.h>
+#include <mach/irqs.h>
 
 #include "sam9_smc.h"
 #include "generic.h"
@@ -575,6 +576,7 @@ static void __init gsia18s_board_init(void)
 MACHINE_START(GSIA18S, "GS_IA18_S")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= gsia18s_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
index 8215a28..e7b430f 100644
--- a/arch/arm/mach-at91/board-kafa.c
+++ b/arch/arm/mach-at91/board-kafa.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/irq.h>
@@ -93,6 +94,7 @@ MACHINE_START(KAFA, "Sperry-Sun KAFA")
 	/* Maintainer: Sergei Sharonov */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= kafa_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index 3431fd3..09af9bc 100644
--- a/arch/arm/mach-at91/board-kb9202.c
+++ b/arch/arm/mach-at91/board-kb9202.c
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/irq.h>
@@ -133,6 +134,7 @@ MACHINE_START(KB9200, "KB920x")
 	/* Maintainer: KwikByte, Inc. */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= kb9202_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
index 125480b..c475ea8 100644
--- a/arch/arm/mach-at91/board-neocore926.c
+++ b/arch/arm/mach-at91/board-neocore926.c
@@ -44,6 +44,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/board.h>
 #include <mach/at91sam9_smc.h>
 
@@ -378,6 +379,7 @@ MACHINE_START(NEOCORE926, "ADENEO NEOCORE 926")
 	/* Maintainer: ADENEO */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= neocore926_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
index 62330ee..804b6ec 100644
--- a/arch/arm/mach-at91/board-pcontrol-g20.c
+++ b/arch/arm/mach-at91/board-pcontrol-g20.c
@@ -32,6 +32,7 @@
 #include <mach/board.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/stamp9g20.h>
+#include <mach/irqs.h>
 
 #include "sam9_smc.h"
 #include "generic.h"
@@ -218,6 +219,7 @@ MACHINE_START(PCONTROL_G20, "PControl G20")
 	/* Maintainer: pgsellmann at portner-elektronik.at */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= pcontrol_g20_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index 918c28b..e447ac0 100644
--- a/arch/arm/mach-at91/board-picotux200.c
+++ b/arch/arm/mach-at91/board-picotux200.c
@@ -29,6 +29,7 @@
 #include <linux/mtd/physmap.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/irq.h>
@@ -120,6 +121,7 @@ MACHINE_START(PICOTUX2XX, "picotux 200")
 	/* Maintainer: Kleinhenz Elektronik GmbH */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= picotux200_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
index 92e25b9..7fdd6ff 100644
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ b/arch/arm/mach-at91/board-qil-a9260.c
@@ -40,6 +40,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/board.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
@@ -258,6 +259,7 @@ MACHINE_START(QIL_A9260, "CALAO QIL_A9260")
 	/* Maintainer: calao-systems */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
index 7742ff7..dbee95a 100644
--- a/arch/arm/mach-at91/board-rm9200dk.c
+++ b/arch/arm/mach-at91/board-rm9200dk.c
@@ -39,6 +39,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/board.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
@@ -223,6 +224,7 @@ MACHINE_START(AT91RM9200DK, "Atmel AT91RM9200-DK")
 	/* Maintainer: SAN People/Atmel */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= dk_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
index ed48538..f07b3e1 100644
--- a/arch/arm/mach-at91/board-rm9200ek.c
+++ b/arch/arm/mach-at91/board-rm9200ek.c
@@ -39,6 +39,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/board.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
@@ -190,6 +191,7 @@ MACHINE_START(AT91RM9200EK, "Atmel AT91RM9200-EK")
 	/* Maintainer: SAN People/Atmel */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-rsi-ews.c b/arch/arm/mach-at91/board-rsi-ews.c
index 4489b23..cdc47e8 100644
--- a/arch/arm/mach-at91/board-rsi-ews.c
+++ b/arch/arm/mach-at91/board-rsi-ews.c
@@ -25,6 +25,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/board.h>
 
 #include <linux/gpio.h>
@@ -225,6 +226,7 @@ MACHINE_START(RSI_EWS, "RSI EWS")
 	/* Maintainer: Josef Holzmayr <holzmayr@rsi-elektrotechnik.de> */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= rsi_ews_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
index 4abb3f0..89847194 100644
--- a/arch/arm/mach-at91/board-sam9-l9260.c
+++ b/arch/arm/mach-at91/board-sam9-l9260.c
@@ -29,6 +29,7 @@
 #include <linux/spi/spi.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/irq.h>
@@ -202,6 +203,7 @@ MACHINE_START(SAM9_L9260, "Olimex SAM9-L9260")
 	/* Maintainer: Olimex */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index a9f14c4..2033e75 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -41,6 +41,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/board.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
@@ -344,6 +345,7 @@ MACHINE_START(AT91SAM9260EK, "Atmel AT91SAM9260-EK")
 	/* Maintainer: Atmel */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index ba7fd83..5f7a472 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -45,6 +45,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/board.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
@@ -615,6 +616,7 @@ MACHINE_START(AT91SAM9G10EK, "Atmel AT91SAM9G10-EK")
 	/* Maintainer: Atmel */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index ee6e067..b0a73fc 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -44,6 +44,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/board.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
@@ -443,6 +444,7 @@ MACHINE_START(AT91SAM9263EK, "Atmel AT91SAM9263-EK")
 	/* Maintainer: Atmel */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 002411f..25517b0 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -35,6 +35,7 @@
 #include <linux/platform_data/at91_adc.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/irq.h>
@@ -422,6 +423,7 @@ MACHINE_START(AT91SAM9G20EK_2MMC, "Atmel AT91SAM9G20-EK 2 MMC Slot Mod")
 	/* Maintainer: Atmel */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index c1d6cbf..37a2804 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -30,6 +30,7 @@
 #include <linux/platform_data/at91_adc.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <video/atmel_lcdc.h>
 #include <media/soc_camera.h>
 #include <media/atmel-isi.h>
@@ -503,6 +504,7 @@ MACHINE_START(AT91SAM9M10G45EK, "Atmel AT91SAM9M10G45-EK")
 	/* Maintainer: Atmel */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index 87cc912..feb0850 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -30,6 +30,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/board.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
@@ -319,6 +320,7 @@ MACHINE_START(AT91SAM9RLEK, "Atmel AT91SAM9RL-EK")
 	/* Maintainer: Atmel */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-snapper9260.c b/arch/arm/mach-at91/board-snapper9260.c
index 43de463..96c49f1 100644
--- a/arch/arm/mach-at91/board-snapper9260.c
+++ b/arch/arm/mach-at91/board-snapper9260.c
@@ -32,6 +32,7 @@
 #include <asm/mach/arch.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/board.h>
 #include <mach/at91sam9_smc.h>
 
@@ -178,6 +179,7 @@ static void __init snapper9260_board_init(void)
 MACHINE_START(SNAPPER_9260, "Bluewater Systems Snapper 9260/9G20 module")
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= snapper9260_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index 996339f..586ed8a 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -25,6 +25,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#include <mach/irqs.h>
 #include <mach/board.h>
 #include <mach/at91sam9_smc.h>
 
@@ -296,6 +297,7 @@ MACHINE_START(STAMP9G20, "taskit Stamp9G20")
 	/* Maintainer: taskit GmbH */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= stamp9g20_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-usb-a926x.c b/arch/arm/mach-at91/board-usb-a926x.c
index ff7a56d..12f0f1a 100644
--- a/arch/arm/mach-at91/board-usb-a926x.c
+++ b/arch/arm/mach-at91/board-usb-a926x.c
@@ -41,6 +41,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/board.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
@@ -376,6 +377,7 @@ MACHINE_START(USB_A9G20, "CALAO USB_A92G0")
 	/* Maintainer: Jean-Christophe PLAGNIOL-VILLARD */
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index 3fc55ae..da3b380 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -43,6 +43,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <mach/board.h>
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
@@ -590,6 +591,7 @@ MACHINE_START(YL9200, "uCdragon YL-9200")
 	/* Maintainer: S.Birtles */
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91_map_io,
+	.nr_irqs	= NR_AIC_IRQS + NR_GPIO_IRQS,
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
diff --git a/arch/arm/mach-at91/include/mach/irqs.h b/arch/arm/mach-at91/include/mach/irqs.h
index 4605039..5164dc1 100644
--- a/arch/arm/mach-at91/include/mach/irqs.h
+++ b/arch/arm/mach-at91/include/mach/irqs.h
@@ -24,8 +24,8 @@
 #include <linux/io.h>
 #include <mach/at91_aic.h>
 
-#define NR_AIC_IRQS 32
-
+#define NR_AIC_IRQS 	32
+#define NR_GPIO_IRQS	(5 * 32)
 
 /*
  * IRQ interrupt symbols are the AT91xxx_ID_* symbols
@@ -33,7 +33,9 @@
  * symbols in gpio.h for ones handled indirectly as GPIOs.
  * We make provision for 5 banks of GPIO.
  */
-#define	NR_IRQS		(NR_AIC_IRQS + (5 * 32))
+#ifndef NR_IRQS
+#define NR_IRQS		(NR_AIC_IRQS + NR_GPIO_IRQS)
+#endif
 
 /* FIQ is AIC source 0. */
 #define FIQ_START AT91_ID_FIQ
diff --git a/arch/arm/mach-at91/irq.c b/arch/arm/mach-at91/irq.c
index e5adee4..b0f83e2 100644
--- a/arch/arm/mach-at91/irq.c
+++ b/arch/arm/mach-at91/irq.c
@@ -32,6 +32,7 @@
 #include <linux/err.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <asm/irq.h>
 #include <asm/setup.h>
 
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
