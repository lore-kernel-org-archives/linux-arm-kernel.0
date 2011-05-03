From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue,  3 May 2011 02:23:26 +0200
Subject: [V2 PATCH 2/2] at91: drop boot_params and PLAT_PHYS_OFFSET
In-Reply-To: <1304374403-28513-1-git-send-email-plagnioj@jcrosoft.com>
References: <1304374403-28513-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1304382206-9517-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

select ARM_PATCH_PHYS_VIRT
as with ARM_PATCH_PHYS_VIRT you can patch boot_params at runtime or any recent
bootloader will provide a valid atags pointer in r2

as point out by Russell on AT91 we never use XIP
so se do not need PLAT_PHYS_OFFSET

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Andrew Victor <linux@maxim.org.za>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
V2:
	replace
	[PATCH 2/3] at91: drop boot_params
	[PATCH 3/3] at91: make PLAT_PHYS_OFFSET depending on !ARM_PATCH_PHYS_VIRT or XIP_KERNEL

Best Regards,
J.
 arch/arm/Kconfig                              |    1 +
 arch/arm/mach-at91/board-1arm.c               |    1 -
 arch/arm/mach-at91/board-afeb-9260v1.c        |    1 -
 arch/arm/mach-at91/board-at572d940hf_ek.c     |    1 -
 arch/arm/mach-at91/board-cam60.c              |    1 -
 arch/arm/mach-at91/board-cap9adk.c            |    1 -
 arch/arm/mach-at91/board-carmeva.c            |    1 -
 arch/arm/mach-at91/board-cpu9krea.c           |    1 -
 arch/arm/mach-at91/board-cpuat91.c            |    1 -
 arch/arm/mach-at91/board-csb337.c             |    1 -
 arch/arm/mach-at91/board-csb637.c             |    1 -
 arch/arm/mach-at91/board-eb9200.c             |    1 -
 arch/arm/mach-at91/board-ecbat91.c            |    1 -
 arch/arm/mach-at91/board-eco920.c             |    1 -
 arch/arm/mach-at91/board-flexibity.c          |    1 -
 arch/arm/mach-at91/board-foxg20.c             |    1 -
 arch/arm/mach-at91/board-gsia18s.c            |    1 -
 arch/arm/mach-at91/board-kafa.c               |    1 -
 arch/arm/mach-at91/board-kb9202.c             |    1 -
 arch/arm/mach-at91/board-neocore926.c         |    1 -
 arch/arm/mach-at91/board-pcontrol-g20.c       |    1 -
 arch/arm/mach-at91/board-picotux200.c         |    1 -
 arch/arm/mach-at91/board-qil-a9260.c          |    1 -
 arch/arm/mach-at91/board-rm9200dk.c           |    1 -
 arch/arm/mach-at91/board-rm9200ek.c           |    1 -
 arch/arm/mach-at91/board-sam9-l9260.c         |    1 -
 arch/arm/mach-at91/board-sam9260ek.c          |    1 -
 arch/arm/mach-at91/board-sam9261ek.c          |    1 -
 arch/arm/mach-at91/board-sam9263ek.c          |    1 -
 arch/arm/mach-at91/board-sam9g20ek.c          |    2 --
 arch/arm/mach-at91/board-sam9m10g45ek.c       |    1 -
 arch/arm/mach-at91/board-sam9rlek.c           |    1 -
 arch/arm/mach-at91/board-snapper9260.c        |    1 -
 arch/arm/mach-at91/board-stamp9g20.c          |    2 --
 arch/arm/mach-at91/board-usb-a9260.c          |    1 -
 arch/arm/mach-at91/board-usb-a9263.c          |    1 -
 arch/arm/mach-at91/board-yl-9200.c            |    1 -
 arch/arm/mach-at91/include/mach/at91cap9.h    |    2 --
 arch/arm/mach-at91/include/mach/at91sam9g45.h |    2 --
 arch/arm/mach-at91/include/mach/hardware.h    |    7 -------
 arch/arm/mach-at91/include/mach/memory.h      |    2 --
 41 files changed, 1 insertions(+), 51 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 920273d..2336363 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -289,6 +289,7 @@ config ARCH_AT91
 	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_CLK
 	select CLKDEV_LOOKUP
+	select ARM_PATCH_PHYS_VIRT
 	help
 	  This enables support for systems based on the Atmel AT91RM9200,
 	  AT91SAM9 and AT91CAP9 processors.
diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
index 672bbd8..73372ca 100644
--- a/arch/arm/mach-at91/board-1arm.c
+++ b/arch/arm/mach-at91/board-1arm.c
@@ -92,7 +92,6 @@ static void __init onearm_board_init(void)
 
 MACHINE_START(ONEARM, "Ajeco 1ARM single board computer")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= onearm_init_early,
diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
index 00a92a5..a4924de 100644
--- a/arch/arm/mach-at91/board-afeb-9260v1.c
+++ b/arch/arm/mach-at91/board-afeb-9260v1.c
@@ -218,7 +218,6 @@ static void __init afeb9260_board_init(void)
 
 MACHINE_START(AFEB9260, "Custom afeb9260 board")
 	/* Maintainer: Sergey Lapin <slapin@ossfans.org> */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= afeb9260_init_early,
diff --git a/arch/arm/mach-at91/board-at572d940hf_ek.c b/arch/arm/mach-at91/board-at572d940hf_ek.c
index 256df40..60a89f8 100644
--- a/arch/arm/mach-at91/board-at572d940hf_ek.c
+++ b/arch/arm/mach-at91/board-at572d940hf_ek.c
@@ -315,7 +315,6 @@ static void __init eb_board_init(void)
 
 MACHINE_START(AT572D940HFEB, "Atmel AT91D940HF-EB")
 	/* Maintainer: Atmel <costa.antonior@gmail.com> */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at572d940hf_map_io,
 	.init_early	= eb_init_early,
diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
index 3025b90..148fccb 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -198,7 +198,6 @@ static void __init cam60_board_init(void)
 
 MACHINE_START(CAM60, "KwikByte CAM60")
 	/* Maintainer: KwikByte */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= cam60_init_early,
diff --git a/arch/arm/mach-at91/board-cap9adk.c b/arch/arm/mach-at91/board-cap9adk.c
index ada1eaf..cdb65d4 100644
--- a/arch/arm/mach-at91/board-cap9adk.c
+++ b/arch/arm/mach-at91/board-cap9adk.c
@@ -396,7 +396,6 @@ static void __init cap9adk_board_init(void)
 
 MACHINE_START(AT91CAP9ADK, "Atmel AT91CAP9A-DK")
 	/* Maintainer: Stelian Pop <stelian.pop@leadtechdesign.com> */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91cap9_map_io,
 	.init_early	= cap9adk_init_early,
diff --git a/arch/arm/mach-at91/board-carmeva.c b/arch/arm/mach-at91/board-carmeva.c
index dfa98f3..3929b11 100644
--- a/arch/arm/mach-at91/board-carmeva.c
+++ b/arch/arm/mach-at91/board-carmeva.c
@@ -162,7 +162,6 @@ static void __init carmeva_board_init(void)
 
 MACHINE_START(CARMEVA, "Carmeva")
 	/* Maintainer: Conitec Datasystems */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= carmeva_init_early,
diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index 34fd892..9805110 100644
--- a/arch/arm/mach-at91/board-cpu9krea.c
+++ b/arch/arm/mach-at91/board-cpu9krea.c
@@ -375,7 +375,6 @@ MACHINE_START(CPUAT9260, "Eukrea CPU9260")
 MACHINE_START(CPUAT9G20, "Eukrea CPU9G20")
 #endif
 	/* Maintainer: Eric Benard - EUKREA Electromatique */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= cpu9krea_init_early,
diff --git a/arch/arm/mach-at91/board-cpuat91.c b/arch/arm/mach-at91/board-cpuat91.c
index 34c9d0c..620a36a 100644
--- a/arch/arm/mach-at91/board-cpuat91.c
+++ b/arch/arm/mach-at91/board-cpuat91.c
@@ -175,7 +175,6 @@ static void __init cpuat91_board_init(void)
 
 MACHINE_START(CPUAT91, "Eukrea")
 	/* Maintainer: Eric Benard - EUKREA Electromatique */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= cpuat91_init_early,
diff --git a/arch/arm/mach-at91/board-csb337.c b/arch/arm/mach-at91/board-csb337.c
index a48a32d..a7be81e 100644
--- a/arch/arm/mach-at91/board-csb337.c
+++ b/arch/arm/mach-at91/board-csb337.c
@@ -257,7 +257,6 @@ static void __init csb337_board_init(void)
 
 MACHINE_START(CSB337, "Cogent CSB337")
 	/* Maintainer: Bill Gatliff */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= csb337_init_early,
diff --git a/arch/arm/mach-at91/board-csb637.c b/arch/arm/mach-at91/board-csb637.c
index 7f0ee1c..58a80c3 100644
--- a/arch/arm/mach-at91/board-csb637.c
+++ b/arch/arm/mach-at91/board-csb637.c
@@ -138,7 +138,6 @@ static void __init csb637_board_init(void)
 
 MACHINE_START(CSB637, "Cogent CSB637")
 	/* Maintainer: Bill Gatliff */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= csb637_init_early,
diff --git a/arch/arm/mach-at91/board-eb9200.c b/arch/arm/mach-at91/board-eb9200.c
index 0de1ba4..e9fff80 100644
--- a/arch/arm/mach-at91/board-eb9200.c
+++ b/arch/arm/mach-at91/board-eb9200.c
@@ -120,7 +120,6 @@ static void __init eb9200_board_init(void)
 }
 
 MACHINE_START(ATEB9200, "Embest ATEB9200")
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= eb9200_init_early,
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
index bd46395..eea65ea 100644
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ b/arch/arm/mach-at91/board-ecbat91.c
@@ -168,7 +168,6 @@ static void __init ecb_at91board_init(void)
 
 MACHINE_START(ECBAT91, "emQbit's ECB_AT91")
 	/* Maintainer: emQbit.com */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= ecb_at91init_early,
diff --git a/arch/arm/mach-at91/board-eco920.c b/arch/arm/mach-at91/board-eco920.c
index 6fff26d..90a44e5 100644
--- a/arch/arm/mach-at91/board-eco920.c
+++ b/arch/arm/mach-at91/board-eco920.c
@@ -129,7 +129,6 @@ static void __init eco920_board_init(void)
 
 MACHINE_START(ECO920, "eco920")
 	/* Maintainer: Sascha Hauer */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= eco920_init_early,
diff --git a/arch/arm/mach-at91/board-flexibity.c b/arch/arm/mach-at91/board-flexibity.c
index 934542f..466c063 100644
--- a/arch/arm/mach-at91/board-flexibity.c
+++ b/arch/arm/mach-at91/board-flexibity.c
@@ -154,7 +154,6 @@ static void __init flexibity_board_init(void)
 
 MACHINE_START(FLEXIBITY, "Flexibity Connect")
 	/* Maintainer: Maxim Osipov */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= flexibity_init_early,
diff --git a/arch/arm/mach-at91/board-foxg20.c b/arch/arm/mach-at91/board-foxg20.c
index 470a66b..e2d1dc9 100644
--- a/arch/arm/mach-at91/board-foxg20.c
+++ b/arch/arm/mach-at91/board-foxg20.c
@@ -266,7 +266,6 @@ static void __init foxg20_board_init(void)
 
 MACHINE_START(ACMENETUSFOXG20, "Acme Systems srl FOX Board G20")
 	/* Maintainer: Sergio Tanzilli */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= foxg20_init_early,
diff --git a/arch/arm/mach-at91/board-gsia18s.c b/arch/arm/mach-at91/board-gsia18s.c
index 2b409de..1d4f36b 100644
--- a/arch/arm/mach-at91/board-gsia18s.c
+++ b/arch/arm/mach-at91/board-gsia18s.c
@@ -576,7 +576,6 @@ static void __init gsia18s_board_init(void)
 }
 
 MACHINE_START(GSIA18S, "GS_IA18_S")
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= gsia18s_init_early,
diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
index 49557d3..4f17a1c 100644
--- a/arch/arm/mach-at91/board-kafa.c
+++ b/arch/arm/mach-at91/board-kafa.c
@@ -94,7 +94,6 @@ static void __init kafa_board_init(void)
 
 MACHINE_START(KAFA, "Sperry-Sun KAFA")
 	/* Maintainer: Sergei Sharonov */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= kafa_init_early,
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index fca061a..39247fa 100644
--- a/arch/arm/mach-at91/board-kb9202.c
+++ b/arch/arm/mach-at91/board-kb9202.c
@@ -136,7 +136,6 @@ static void __init kb9202_board_init(void)
 
 MACHINE_START(KB9200, "KB920x")
 	/* Maintainer: KwikByte, Inc. */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= kb9202_init_early,
diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
index 004b76d..961e805 100644
--- a/arch/arm/mach-at91/board-neocore926.c
+++ b/arch/arm/mach-at91/board-neocore926.c
@@ -387,7 +387,6 @@ static void __init neocore926_board_init(void)
 
 MACHINE_START(NEOCORE926, "ADENEO NEOCORE 926")
 	/* Maintainer: ADENEO */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9263_map_io,
 	.init_early	= neocore926_init_early,
diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
index df1ed7e..21a21af 100644
--- a/arch/arm/mach-at91/board-pcontrol-g20.c
+++ b/arch/arm/mach-at91/board-pcontrol-g20.c
@@ -222,7 +222,6 @@ static void __init pcontrol_g20_board_init(void)
 
 MACHINE_START(PCONTROL_G20, "PControl G20")
 	/* Maintainer: pgsellmann at portner-elektronik.at */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= pcontrol_g20_init_early,
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index 97372f6..8294eae 100644
--- a/arch/arm/mach-at91/board-picotux200.c
+++ b/arch/arm/mach-at91/board-picotux200.c
@@ -123,7 +123,6 @@ static void __init picotux200_board_init(void)
 
 MACHINE_START(PICOTUX2XX, "picotux 200")
 	/* Maintainer: Kleinhenz Elektronik GmbH */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= picotux200_init_early,
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
index 5822d8e..d1a6001 100644
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ b/arch/arm/mach-at91/board-qil-a9260.c
@@ -268,7 +268,6 @@ static void __init ek_board_init(void)
 
 MACHINE_START(QIL_A9260, "CALAO QIL_A9260")
 	/* Maintainer: calao-systems */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= ek_init_early,
diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
index 4f04f28..b90d0f9 100644
--- a/arch/arm/mach-at91/board-rm9200dk.c
+++ b/arch/arm/mach-at91/board-rm9200dk.c
@@ -227,7 +227,6 @@ static void __init dk_board_init(void)
 
 MACHINE_START(AT91RM9200DK, "Atmel AT91RM9200-DK")
 	/* Maintainer: SAN People/Atmel */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= dk_init_early,
diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
index cf161c5..51c2668 100644
--- a/arch/arm/mach-at91/board-rm9200ek.c
+++ b/arch/arm/mach-at91/board-rm9200ek.c
@@ -193,7 +193,6 @@ static void __init ek_board_init(void)
 
 MACHINE_START(AT91RM9200EK, "Atmel AT91RM9200-EK")
 	/* Maintainer: SAN People/Atmel */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= ek_init_early,
diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
index b925ba9..aaf1bf0 100644
--- a/arch/arm/mach-at91/board-sam9-l9260.c
+++ b/arch/arm/mach-at91/board-sam9-l9260.c
@@ -212,7 +212,6 @@ static void __init ek_board_init(void)
 
 MACHINE_START(SAM9_L9260, "Olimex SAM9-L9260")
 	/* Maintainer: Olimex */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= ek_init_early,
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index d9f1f68..5c24074 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -353,7 +353,6 @@ static void __init ek_board_init(void)
 
 MACHINE_START(AT91SAM9260EK, "Atmel AT91SAM9260-EK")
 	/* Maintainer: Atmel */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= ek_init_early,
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index cb8d033..b60c22b 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -620,7 +620,6 @@ MACHINE_START(AT91SAM9261EK, "Atmel AT91SAM9261-EK")
 MACHINE_START(AT91SAM9G10EK, "Atmel AT91SAM9G10-EK")
 #endif
 	/* Maintainer: Atmel */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9261_map_io,
 	.init_early	= ek_init_early,
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index acc3ab3..9bbdc92 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -451,7 +451,6 @@ static void __init ek_board_init(void)
 
 MACHINE_START(AT91SAM9263EK, "Atmel AT91SAM9263-EK")
 	/* Maintainer: Atmel */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9263_map_io,
 	.init_early	= ek_init_early,
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 79c8eaa..1325a50 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -403,7 +403,6 @@ static void __init ek_board_init(void)
 
 MACHINE_START(AT91SAM9G20EK, "Atmel AT91SAM9G20-EK")
 	/* Maintainer: Atmel */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= ek_init_early,
@@ -413,7 +412,6 @@ MACHINE_END
 
 MACHINE_START(AT91SAM9G20EK_2MMC, "Atmel AT91SAM9G20-EK 2 MMC Slot Mod")
 	/* Maintainer: Atmel */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= ek_init_early,
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index a847ea2..33eaa13 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -421,7 +421,6 @@ static void __init ek_board_init(void)
 
 MACHINE_START(AT91SAM9M10G45EK, "Atmel AT91SAM9M10G45-EK")
 	/* Maintainer: Atmel */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9g45_map_io,
 	.init_early	= ek_init_early,
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index 102f862..effb399 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -329,7 +329,6 @@ static void __init ek_board_init(void)
 
 MACHINE_START(AT91SAM9RLEK, "Atmel AT91SAM9RL-EK")
 	/* Maintainer: Atmel */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9rl_map_io,
 	.init_early	= ek_init_early,
diff --git a/arch/arm/mach-at91/board-snapper9260.c b/arch/arm/mach-at91/board-snapper9260.c
index ad95628..3eb0a11 100644
--- a/arch/arm/mach-at91/board-snapper9260.c
+++ b/arch/arm/mach-at91/board-snapper9260.c
@@ -178,7 +178,6 @@ static void __init snapper9260_board_init(void)
 }
 
 MACHINE_START(SNAPPER_9260, "Bluewater Systems Snapper 9260/9G20 module")
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= snapper9260_init_early,
diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index 38515e4..5e5c856 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -298,7 +298,6 @@ static void __init stamp9g20evb_board_init(void)
 
 MACHINE_START(PORTUXG20, "taskit PortuxG20")
 	/* Maintainer: taskit GmbH */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= portuxg20_init_early,
@@ -308,7 +307,6 @@ MACHINE_END
 
 MACHINE_START(STAMP9G20, "taskit Stamp9G20")
 	/* Maintainer: taskit GmbH */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= stamp9g20evb_init_early,
diff --git a/arch/arm/mach-at91/board-usb-a9260.c b/arch/arm/mach-at91/board-usb-a9260.c
index a0c17d5..0e784e6 100644
--- a/arch/arm/mach-at91/board-usb-a9260.c
+++ b/arch/arm/mach-at91/board-usb-a9260.c
@@ -228,7 +228,6 @@ static void __init ek_board_init(void)
 
 MACHINE_START(USB_A9260, "CALAO USB_A9260")
 	/* Maintainer: calao-systems */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9260_map_io,
 	.init_early	= ek_init_early,
diff --git a/arch/arm/mach-at91/board-usb-a9263.c b/arch/arm/mach-at91/board-usb-a9263.c
index 5356af7..cf626dd 100644
--- a/arch/arm/mach-at91/board-usb-a9263.c
+++ b/arch/arm/mach-at91/board-usb-a9263.c
@@ -244,7 +244,6 @@ static void __init ek_board_init(void)
 
 MACHINE_START(USB_A9263, "CALAO USB_A9263")
 	/* Maintainer: calao-systems */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91sam926x_timer,
 	.map_io		= at91sam9263_map_io,
 	.init_early	= ek_init_early,
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index 8f9ea5a..167337f 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -594,7 +594,6 @@ static void __init yl9200_board_init(void)
 
 MACHINE_START(YL9200, "uCdragon YL-9200")
 	/* Maintainer: S.Birtles */
-	.boot_params	= AT91_SDRAM_BASE + 0x100,
 	.timer		= &at91rm9200_timer,
 	.map_io		= at91rm9200_map_io,
 	.init_early	= yl9200_init_early,
diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
index a043bce..6659938 100644
--- a/arch/arm/mach-at91/include/mach/at91cap9.h
+++ b/arch/arm/mach-at91/include/mach/at91cap9.h
@@ -121,6 +121,4 @@
 #define AT91CAP9_UDPHS_FIFO	0x00600000	/* USB High Speed Device Port */
 #define AT91CAP9_UHP_BASE	0x00700000	/* USB Host controller */
 
-#define CONFIG_DRAM_BASE	AT91_CHIPSELECT_6
-
 #endif
diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
index 520b14b..659304a 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
@@ -129,8 +129,6 @@
 #define AT91SAM9G45_EHCI_BASE	0x00800000	/* USB Host controller (EHCI) */
 #define AT91SAM9G45_VDEC_BASE	0x00900000	/* Video Decoder Controller */
 
-#define CONFIG_DRAM_BASE	AT91_CHIPSELECT_6
-
 #define CONSISTENT_DMA_SIZE	SZ_4M
 
 /*
diff --git a/arch/arm/mach-at91/include/mach/hardware.h b/arch/arm/mach-at91/include/mach/hardware.h
index 3522464..469d3af 100644
--- a/arch/arm/mach-at91/include/mach/hardware.h
+++ b/arch/arm/mach-at91/include/mach/hardware.h
@@ -88,13 +88,6 @@
 #define AT91_CHIPSELECT_6	0x70000000
 #define AT91_CHIPSELECT_7	0x80000000
 
-/* SDRAM */
-#ifdef CONFIG_DRAM_BASE
-#define AT91_SDRAM_BASE		CONFIG_DRAM_BASE
-#else
-#define AT91_SDRAM_BASE		AT91_CHIPSELECT_1
-#endif
-
 /* Clocks */
 #define AT91_SLOW_CLOCK		32768		/* slow clock */
 
diff --git a/arch/arm/mach-at91/include/mach/memory.h b/arch/arm/mach-at91/include/mach/memory.h
index c2cfe50..401c207 100644
--- a/arch/arm/mach-at91/include/mach/memory.h
+++ b/arch/arm/mach-at91/include/mach/memory.h
@@ -23,6 +23,4 @@
 
 #include <mach/hardware.h>
 
-#define PLAT_PHYS_OFFSET	(AT91_SDRAM_BASE)
-
 #endif
-- 
1.7.4.1
