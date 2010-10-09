From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 10 Oct 2010 00:39:19 +0200
Subject: [PATCH 01/13] ARM: pxa: Introduce pxa[23]xx_map_io
Message-ID: <1286663971-15634-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces pxa2xx_map_io() and pxa3xx_map_io() to distinguish between
PXA2xx and PXA3xx memory mapping.

Also, fixup for platforms broken after introducing pxa2xx_map_io() and
pxa3xx_map_io() is included.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/balloon3.c       |    2 +-
 arch/arm/mach-pxa/capc7117.c       |    2 +-
 arch/arm/mach-pxa/cm-x2xx.c        |    4 +-
 arch/arm/mach-pxa/cm-x300.c        |    2 +-
 arch/arm/mach-pxa/colibri-pxa270.c |    4 +-
 arch/arm/mach-pxa/colibri-pxa300.c |    2 +-
 arch/arm/mach-pxa/colibri-pxa320.c |    2 +-
 arch/arm/mach-pxa/corgi.c          |    6 ++--
 arch/arm/mach-pxa/csb726.c         |    2 +-
 arch/arm/mach-pxa/em-x270.c        |    4 +-
 arch/arm/mach-pxa/eseries.c        |   12 +++++-----
 arch/arm/mach-pxa/ezx.c            |   12 +++++-----
 arch/arm/mach-pxa/generic.c        |   37 ++++++++++++++++++++++++++++-------
 arch/arm/mach-pxa/generic.h        |    3 +-
 arch/arm/mach-pxa/gumstix.c        |    2 +-
 arch/arm/mach-pxa/h5000.c          |    2 +-
 arch/arm/mach-pxa/himalaya.c       |    2 +-
 arch/arm/mach-pxa/hx4700.c         |    2 +-
 arch/arm/mach-pxa/icontrol.c       |    2 +-
 arch/arm/mach-pxa/idp.c            |    2 +-
 arch/arm/mach-pxa/littleton.c      |    2 +-
 arch/arm/mach-pxa/lpd270.c         |    2 +-
 arch/arm/mach-pxa/lubbock.c        |    2 +-
 arch/arm/mach-pxa/magician.c       |    2 +-
 arch/arm/mach-pxa/mainstone.c      |    2 +-
 arch/arm/mach-pxa/mioa701.c        |    2 +-
 arch/arm/mach-pxa/mp900.c          |    2 +-
 arch/arm/mach-pxa/palmld.c         |    2 +-
 arch/arm/mach-pxa/palmt5.c         |    2 +-
 arch/arm/mach-pxa/palmtc.c         |    2 +-
 arch/arm/mach-pxa/palmte2.c        |    2 +-
 arch/arm/mach-pxa/palmtreo.c       |    4 +-
 arch/arm/mach-pxa/palmtx.c         |    2 +-
 arch/arm/mach-pxa/palmz72.c        |    2 +-
 arch/arm/mach-pxa/pcm027.c         |    2 +-
 arch/arm/mach-pxa/poodle.c         |    2 +-
 arch/arm/mach-pxa/raumfeld.c       |    6 ++--
 arch/arm/mach-pxa/saar.c           |    2 +-
 arch/arm/mach-pxa/spitz.c          |   12 ++++++----
 arch/arm/mach-pxa/stargate2.c      |    4 +-
 arch/arm/mach-pxa/tavorevb.c       |    2 +-
 arch/arm/mach-pxa/tavorevb3.c      |    2 +-
 arch/arm/mach-pxa/tosa.c           |    2 +-
 arch/arm/mach-pxa/trizeps4.c       |    2 +-
 arch/arm/mach-pxa/viper.c          |    2 +-
 arch/arm/mach-pxa/vpac270.c        |    2 +-
 arch/arm/mach-pxa/xcep.c           |    2 +-
 arch/arm/mach-pxa/z2.c             |    2 +-
 arch/arm/mach-pxa/zeus.c           |    2 +-
 arch/arm/mach-pxa/zylonite.c       |    2 +-
 50 files changed, 104 insertions(+), 80 deletions(-)

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 79d0f6c..309bf27 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -802,7 +802,7 @@ static struct map_desc balloon3_io_desc[] __initdata = {
 
 static void __init balloon3_map_io(void)
 {
-	pxa_map_io();
+	pxa2xx_map_io();
 	iotable_init(balloon3_io_desc, ARRAY_SIZE(balloon3_io_desc));
 }
 
diff --git a/arch/arm/mach-pxa/capc7117.c b/arch/arm/mach-pxa/capc7117.c
index aae5446..4ef5e7a 100644
--- a/arch/arm/mach-pxa/capc7117.c
+++ b/arch/arm/mach-pxa/capc7117.c
@@ -151,7 +151,7 @@ MACHINE_START(CAPC7117,
 	.phys_io = 0x40000000,
 	.boot_params = 0xa0000100,
 	.io_pg_offst = (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.map_io = pxa_map_io,
+	.map_io = pxa3xx_map_io,
 	.init_irq = pxa3xx_init_irq,
 	.timer = &pxa_timer,
 	.init_machine = capc7117_init
diff --git a/arch/arm/mach-pxa/cm-x2xx.c b/arch/arm/mach-pxa/cm-x2xx.c
index ad40e7b..c698836 100644
--- a/arch/arm/mach-pxa/cm-x2xx.c
+++ b/arch/arm/mach-pxa/cm-x2xx.c
@@ -500,7 +500,7 @@ static struct map_desc cmx2xx_io_desc[] __initdata = {
 
 static void __init cmx2xx_map_io(void)
 {
-	pxa_map_io();
+	pxa2xx_map_io();
 	iotable_init(cmx2xx_io_desc, ARRAY_SIZE(cmx2xx_io_desc));
 
 	it8152_base_address = CMX2XX_IT8152_VIRT;
@@ -508,7 +508,7 @@ static void __init cmx2xx_map_io(void)
 #else
 static void __init cmx2xx_map_io(void)
 {
-	pxa_map_io();
+	pxa2xx_map_io();
 }
 #endif
 
diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 8e0b562..9ded46c 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -859,7 +859,7 @@ MACHINE_START(CM_X300, "CM-X300 module")
 	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa3xx_map_io,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= cm_x300_init,
diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
index 98673ac..b02784d 100644
--- a/arch/arm/mach-pxa/colibri-pxa270.c
+++ b/arch/arm/mach-pxa/colibri-pxa270.c
@@ -211,7 +211,7 @@ MACHINE_START(COLIBRI, "Toradex Colibri PXA270")
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= COLIBRI_SDRAM_BASE + 0x100,
 	.init_machine	= colibri_pxa270_init,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
 MACHINE_END
@@ -221,7 +221,7 @@ MACHINE_START(INCOME, "Income s.r.o. SH-Dmaster PXA270 SBC")
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.init_machine	= colibri_pxa270_income_init,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
 MACHINE_END
diff --git a/arch/arm/mach-pxa/colibri-pxa300.c b/arch/arm/mach-pxa/colibri-pxa300.c
index 40b6ac2..2b6532b 100644
--- a/arch/arm/mach-pxa/colibri-pxa300.c
+++ b/arch/arm/mach-pxa/colibri-pxa300.c
@@ -190,7 +190,7 @@ MACHINE_START(COLIBRI300, "Toradex Colibri PXA300")
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= COLIBRI_SDRAM_BASE + 0x100,
 	.init_machine	= colibri_pxa300_init,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa3xx_map_io,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
 MACHINE_END
diff --git a/arch/arm/mach-pxa/colibri-pxa320.c b/arch/arm/mach-pxa/colibri-pxa320.c
index 99e850d..aafb49a 100644
--- a/arch/arm/mach-pxa/colibri-pxa320.c
+++ b/arch/arm/mach-pxa/colibri-pxa320.c
@@ -259,7 +259,7 @@ MACHINE_START(COLIBRI320, "Toradex Colibri PXA320")
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= COLIBRI_SDRAM_BASE + 0x100,
 	.init_machine	= colibri_pxa320_init,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa3xx_map_io,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
 MACHINE_END
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 3fb0fc0..4fad783 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -723,7 +723,7 @@ MACHINE_START(CORGI, "SHARP Corgi")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.fixup		= fixup_corgi,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.init_machine	= corgi_init,
 	.timer		= &pxa_timer,
@@ -735,7 +735,7 @@ MACHINE_START(SHEPHERD, "SHARP Shepherd")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.fixup		= fixup_corgi,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.init_machine	= corgi_init,
 	.timer		= &pxa_timer,
@@ -747,7 +747,7 @@ MACHINE_START(HUSKY, "SHARP Husky")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.fixup		= fixup_corgi,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.init_machine	= corgi_init,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/csb726.c b/arch/arm/mach-pxa/csb726.c
index 91fd4fe..dab9d92 100644
--- a/arch/arm/mach-pxa/csb726.c
+++ b/arch/arm/mach-pxa/csb726.c
@@ -275,7 +275,7 @@ MACHINE_START(CSB726, "Cogent CSB726")
 	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa2xx_map_io,
 	.init_irq       = pxa27x_init_irq,
 	.init_machine   = csb726_init,
 	.timer          = &pxa_timer,
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 51286a7..b4625b9 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -1303,7 +1303,7 @@ MACHINE_START(EM_X270, "Compulab EM-X270")
 	.boot_params	= 0xa0000100,
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= em_x270_init,
@@ -1313,7 +1313,7 @@ MACHINE_START(EXEDA, "Compulab eXeda")
 	.boot_params	= 0xa0000100,
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= em_x270_init,
diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index 4971ce1..ae15eab 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -183,7 +183,7 @@ MACHINE_START(E330, "Toshiba e330")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
@@ -234,7 +234,7 @@ MACHINE_START(E350, "Toshiba e350")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
@@ -358,7 +358,7 @@ MACHINE_START(E400, "Toshiba e400")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
@@ -548,7 +548,7 @@ MACHINE_START(E740, "Toshiba e740")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
@@ -741,7 +741,7 @@ MACHINE_START(E750, "Toshiba e750")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
@@ -938,7 +938,7 @@ MACHINE_START(E800, "Toshiba e800")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index f997e84..91310ab 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -801,7 +801,7 @@ MACHINE_START(EZX_A780, "Motorola EZX A780")
 	.phys_io        = 0x40000000,
 	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa2xx_map_io,
 	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
@@ -868,7 +868,7 @@ MACHINE_START(EZX_E680, "Motorola EZX E680")
 	.phys_io        = 0x40000000,
 	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa2xx_map_io,
 	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
@@ -935,7 +935,7 @@ MACHINE_START(EZX_A1200, "Motorola EZX A1200")
 	.phys_io        = 0x40000000,
 	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa2xx_map_io,
 	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
@@ -1128,7 +1128,7 @@ MACHINE_START(EZX_A910, "Motorola EZX A910")
 	.phys_io        = 0x40000000,
 	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa2xx_map_io,
 	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
@@ -1195,7 +1195,7 @@ MACHINE_START(EZX_E6, "Motorola EZX E6")
 	.phys_io        = 0x40000000,
 	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa2xx_map_io,
 	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
@@ -1236,7 +1236,7 @@ MACHINE_START(EZX_E2, "Motorola EZX E2")
 	.phys_io        = 0x40000000,
 	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa2xx_map_io,
 	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
diff --git a/arch/arm/mach-pxa/generic.c b/arch/arm/mach-pxa/generic.c
index 6451e9c..971f994 100644
--- a/arch/arm/mach-pxa/generic.c
+++ b/arch/arm/mach-pxa/generic.c
@@ -91,17 +91,12 @@ EXPORT_SYMBOL(get_memclk_frequency_10khz);
  * Note 2: virtual 0xfffe0000-0xffffffff is reserved for the vector table
  *         and cache flush area.
  */
-static struct map_desc standard_io_desc[] __initdata = {
+static struct map_desc common_io_desc[] __initdata = {
   	{	/* Devs */
 		.virtual	=  0xf2000000,
 		.pfn		= __phys_to_pfn(0x40000000),
 		.length		= 0x02000000,
 		.type		= MT_DEVICE
-	}, {	/* Mem Ctl */
-		.virtual	=  0xf6000000,
-		.pfn		= __phys_to_pfn(0x48000000),
-		.length		= 0x00200000,
-		.type		= MT_DEVICE
 	}, {	/* Camera */
 		.virtual	=  0xfa000000,
 		.pfn		= __phys_to_pfn(0x50000000),
@@ -120,8 +115,34 @@ static struct map_desc standard_io_desc[] __initdata = {
 	}
 };
 
-void __init pxa_map_io(void)
+static struct map_desc pxa2xx_io_desc[] __initdata = {
+	{	/* Mem Ctl */
+		.virtual	=  0xf6000000,
+		.pfn		= __phys_to_pfn(0x48000000),
+		.length		= 0x00200000,
+		.type		= MT_DEVICE
+	}
+};
+
+static struct map_desc pxa3xx_io_desc[] __initdata = {
+	{	/* Mem Ctl */
+		.virtual	=  0xf6000000,
+		.pfn		= __phys_to_pfn(0x4a000000),
+		.length		= 0x00200000,
+		.type		= MT_DEVICE
+	}
+};
+
+void __init pxa2xx_map_io(void)
+{
+	iotable_init(common_io_desc, ARRAY_SIZE(common_io_desc));
+	iotable_init(pxa2xx_io_desc, ARRAY_SIZE(pxa2xx_io_desc));
+	get_clk_frequency_khz(1);
+}
+
+void __init pxa3xx_map_io(void)
 {
-	iotable_init(standard_io_desc, ARRAY_SIZE(standard_io_desc));
+	iotable_init(common_io_desc, ARRAY_SIZE(common_io_desc));
+	iotable_init(pxa3xx_io_desc, ARRAY_SIZE(pxa3xx_io_desc));
 	get_clk_frequency_khz(1);
 }
diff --git a/arch/arm/mach-pxa/generic.h b/arch/arm/mach-pxa/generic.h
index 4b1ad27..4667232 100644
--- a/arch/arm/mach-pxa/generic.h
+++ b/arch/arm/mach-pxa/generic.h
@@ -20,7 +20,8 @@ extern void __init pxa26x_init_irq(void);
 #endif
 extern void __init pxa27x_init_irq(void);
 extern void __init pxa3xx_init_irq(void);
-extern void __init pxa_map_io(void);
+extern void __init pxa2xx_map_io(void);
+extern void __init pxa3xx_map_io(void);
 
 extern unsigned int get_clk_frequency_khz(int info);
 
diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
index 96c3451..3482351 100644
--- a/arch/arm/mach-pxa/gumstix.c
+++ b/arch/arm/mach-pxa/gumstix.c
@@ -227,7 +227,7 @@ MACHINE_START(GUMSTIX, "Gumstix")
 	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100, /* match u-boot bi_boot_params */
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= gumstix_init,
diff --git a/arch/arm/mach-pxa/h5000.c b/arch/arm/mach-pxa/h5000.c
index c1cab08..9048066 100644
--- a/arch/arm/mach-pxa/h5000.c
+++ b/arch/arm/mach-pxa/h5000.c
@@ -204,7 +204,7 @@ MACHINE_START(H5400, "HP iPAQ H5000")
 	.phys_io = 0x40000000,
 	.io_pg_offst = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params = 0xa0000100,
-	.map_io = pxa_map_io,
+	.map_io = pxa2xx_map_io,
 	.init_irq = pxa25x_init_irq,
 	.timer = &pxa_timer,
 	.init_machine = h5000_init,
diff --git a/arch/arm/mach-pxa/himalaya.c b/arch/arm/mach-pxa/himalaya.c
index f9a2e4b..6460afe 100644
--- a/arch/arm/mach-pxa/himalaya.c
+++ b/arch/arm/mach-pxa/himalaya.c
@@ -162,7 +162,7 @@ MACHINE_START(HIMALAYA, "HTC Himalaya")
 	.phys_io = 0x40000000,
 	.io_pg_offst = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params = 0xa0000100,
-	.map_io = pxa_map_io,
+	.map_io = pxa2xx_map_io,
 	.init_irq = pxa25x_init_irq,
 	.init_machine = himalaya_init,
 	.timer = &pxa_timer,
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 10104f1..0d73d77 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -873,7 +873,7 @@ MACHINE_START(H4700, "HP iPAQ HX4700")
 	.phys_io      = 0x40000000,
 	.io_pg_offst  = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params  = 0xa0000100,
-	.map_io       = pxa_map_io,
+	.map_io       = pxa2xx_map_io,
 	.nr_irqs      = HX4700_NR_IRQS,
 	.init_irq     = pxa27x_init_irq,
 	.init_machine = hx4700_init,
diff --git a/arch/arm/mach-pxa/icontrol.c b/arch/arm/mach-pxa/icontrol.c
index 5ccb0ce..9525976 100644
--- a/arch/arm/mach-pxa/icontrol.c
+++ b/arch/arm/mach-pxa/icontrol.c
@@ -194,7 +194,7 @@ MACHINE_START(ICONTROL, "iControl/SafeTcam boards using Embedian MXM-8x10 CoM")
 	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= icontrol_init
diff --git a/arch/arm/mach-pxa/idp.c b/arch/arm/mach-pxa/idp.c
index bc78c4d..80920be 100644
--- a/arch/arm/mach-pxa/idp.c
+++ b/arch/arm/mach-pxa/idp.c
@@ -187,7 +187,7 @@ static struct map_desc idp_io_desc[] __initdata = {
 
 static void __init idp_map_io(void)
 {
-	pxa_map_io();
+	pxa2xx_map_io();
 	iotable_init(idp_io_desc, ARRAY_SIZE(idp_io_desc));
 }
 
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index eb58506..9fa46fc 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -440,7 +440,7 @@ MACHINE_START(LITTLETON, "Marvell Form Factor Development Platform (aka Littleto
 	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa3xx_map_io,
 	.nr_irqs	= LITTLETON_NR_IRQS,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index fc9502e..f1685cc 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -495,7 +495,7 @@ static struct map_desc lpd270_io_desc[] __initdata = {
 
 static void __init lpd270_map_io(void)
 {
-	pxa_map_io();
+	pxa2xx_map_io();
 	iotable_init(lpd270_io_desc, ARRAY_SIZE(lpd270_io_desc));
 
 	/* for use I SRAM as framebuffer.  */
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index 1956c23..e73fc1d 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -549,7 +549,7 @@ static struct map_desc lubbock_io_desc[] __initdata = {
 
 static void __init lubbock_map_io(void)
 {
-	pxa_map_io();
+	pxa2xx_map_io();
 	iotable_init(lubbock_io_desc, ARRAY_SIZE(lubbock_io_desc));
 
 	PCFR |= PCFR_OPDE;
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 42a0c2b..3da95c1 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -767,7 +767,7 @@ MACHINE_START(MAGICIAN, "HTC Magician")
 	.phys_io = 0x40000000,
 	.io_pg_offst = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params = 0xa0000100,
-	.map_io = pxa_map_io,
+	.map_io = pxa2xx_map_io,
 	.nr_irqs = MAGICIAN_NR_IRQS,
 	.init_irq = pxa27x_init_irq,
 	.init_machine = magician_init,
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index 126dca1..12f5e9e 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -614,7 +614,7 @@ static struct map_desc mainstone_io_desc[] __initdata = {
 
 static void __init mainstone_map_io(void)
 {
-	pxa_map_io();
+	pxa2xx_map_io();
 	iotable_init(mainstone_io_desc, ARRAY_SIZE(mainstone_io_desc));
 
  	/*	for use I SRAM as framebuffer.	*/
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index ffb3f5a..29fb0fd 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -822,7 +822,7 @@ MACHINE_START(MIOA701, "MIO A701")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
-	.map_io		= &pxa_map_io,
+	.map_io		= &pxa2xx_map_io,
 	.init_irq	= &pxa27x_init_irq,
 	.init_machine	= mioa701_machine_init,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/mp900.c b/arch/arm/mach-pxa/mp900.c
index 6d45039..2a8f2fa 100644
--- a/arch/arm/mach-pxa/mp900.c
+++ b/arch/arm/mach-pxa/mp900.c
@@ -96,7 +96,7 @@ MACHINE_START(NEC_MP900, "MobilePro900/C")
 	.boot_params	= 0xa0220100,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.timer		= &pxa_timer,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.init_machine	= mp900c_init,
 MACHINE_END
diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index 3ff0c4a..2a07d65 100644
--- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -313,7 +313,7 @@ static struct map_desc palmld_io_desc[] __initdata = {
 
 static void __init palmld_map_io(void)
 {
-	pxa_map_io();
+	pxa2xx_map_io();
 	iotable_init(palmld_io_desc, ARRAY_SIZE(palmld_io_desc));
 }
 
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index 5b9f766..16e166d 100644
--- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -205,7 +205,7 @@ MACHINE_START(PALMT5, "Palm Tungsten|T5")
 	.phys_io	= PALMT5_PHYS_IO_START,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.reserve	= palmt5_reserve,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
index ce1104d..b64ed70 100644
--- a/arch/arm/mach-pxa/palmtc.c
+++ b/arch/arm/mach-pxa/palmtc.c
@@ -415,7 +415,7 @@ MACHINE_START(PALMTC, "Palm Tungsten|C")
 	.phys_io	= 0x40000000,
 	.boot_params 	= 0xa0000100,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= palmtc_init
diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
index 93c11a0..30ff350 100644
--- a/arch/arm/mach-pxa/palmte2.c
+++ b/arch/arm/mach-pxa/palmte2.c
@@ -376,7 +376,7 @@ MACHINE_START(PALMTE2, "Palm Tungsten|E2")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= palmte2_init
diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index f685a60..daa6992 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -444,7 +444,7 @@ MACHINE_START(TREO680, "Palm Treo 680")
 	.phys_io        = TREO_PHYS_IO_START,
 	.io_pg_offst    = io_p2v(0x40000000),
 	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa2xx_map_io,
 	.reserve	= treo_reserve,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
@@ -455,7 +455,7 @@ MACHINE_START(CENTRO, "Palm Centro 685")
 	.phys_io        = TREO_PHYS_IO_START,
 	.io_pg_offst    = io_p2v(0x40000000),
 	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa2xx_map_io,
 	.reserve	= treo_reserve,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index 89a3792..5beab29 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -333,7 +333,7 @@ static struct map_desc palmtx_io_desc[] __initdata = {
 
 static void __init palmtx_map_io(void)
 {
-	pxa_map_io();
+	pxa2xx_map_io();
 	iotable_init(palmtx_io_desc, ARRAY_SIZE(palmtx_io_desc));
 }
 
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index 38f4425..efab229 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -282,7 +282,7 @@ MACHINE_START(PALMZ72, "Palm Zire72")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= io_p2v(0x40000000),
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= palmz72_init
diff --git a/arch/arm/mach-pxa/pcm027.c b/arch/arm/mach-pxa/pcm027.c
index 90b08ba..992b850 100644
--- a/arch/arm/mach-pxa/pcm027.c
+++ b/arch/arm/mach-pxa/pcm027.c
@@ -244,7 +244,7 @@ static void __init pcm027_init(void)
 
 static void __init pcm027_map_io(void)
 {
-	pxa_map_io();
+	pxa2xx_map_io();
 
 	/* initialize sleep mode regs (wake-up sources, etc) */
 	PGSR0 = 0x01308000;
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index c04e025..824f529 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -468,7 +468,7 @@ MACHINE_START(POODLE, "SHARP Poodle")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.fixup		= fixup_poodle,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.nr_irqs	= POODLE_NR_IRQS,	/* 4 for LoCoMo */
 	.init_irq	= pxa25x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 67e04f4..2920144 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -1087,7 +1087,7 @@ MACHINE_START(RAUMFELD_RC, "Raumfeld Controller")
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= RAUMFELD_SDRAM_BASE + 0x100,
 	.init_machine	= raumfeld_controller_init,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa3xx_map_io,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
 MACHINE_END
@@ -1099,7 +1099,7 @@ MACHINE_START(RAUMFELD_CONNECTOR, "Raumfeld Connector")
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= RAUMFELD_SDRAM_BASE + 0x100,
 	.init_machine	= raumfeld_connector_init,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa3xx_map_io,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
 MACHINE_END
@@ -1111,7 +1111,7 @@ MACHINE_START(RAUMFELD_SPEAKER, "Raumfeld Speaker")
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= RAUMFELD_SDRAM_BASE + 0x100,
 	.init_machine	= raumfeld_speaker_init,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa3xx_map_io,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
 MACHINE_END
diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
index 115b6f2..a2c9d28 100644
--- a/arch/arm/mach-pxa/saar.c
+++ b/arch/arm/mach-pxa/saar.c
@@ -599,7 +599,7 @@ MACHINE_START(SAAR, "PXA930 Handheld Platform (aka SAAR)")
 	.phys_io        = 0x40000000,
 	.boot_params    = 0xa0000100,
 	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa3xx_map_io,
 	.init_irq       = pxa3xx_init_irq,
 	.timer          = &pxa_timer,
 	.init_machine   = saar_init,
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 1cd99cb..3fa9c02 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -27,6 +27,7 @@
 #include <linux/mtd/sharpsl.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/regulator/machine.h>
+#include <linux/io.h>
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -44,6 +45,7 @@
 #include <mach/pxa2xx_spi.h>
 #include <mach/spitz.h>
 #include <mach/sharpsl_pm.h>
+#include <mach/pxa-smemc.h>
 
 #include <plat/i2c.h>
 
@@ -930,8 +932,8 @@ static void spitz_poweroff(void)
 static void spitz_restart(char mode, const char *cmd)
 {
 	/* Bootloader magic for a reboot */
-	if ((MSC0 & 0xffff0000) == 0x7ff00000)
-		MSC0 = (MSC0 & 0xffff) | 0x7ee00000;
+	if ((__raw_readl(MSC0) & 0xffff0000) == 0x7ff00000)
+		__raw_writel((__raw_readl(MSC0) & 0xffff) | 0x7ee00000, MSC0);
 
 	spitz_poweroff();
 }
@@ -982,7 +984,7 @@ MACHINE_START(SPITZ, "SHARP Spitz")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.fixup		= spitz_fixup,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.init_machine	= spitz_init,
 	.timer		= &pxa_timer,
@@ -994,7 +996,7 @@ MACHINE_START(BORZOI, "SHARP Borzoi")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.fixup		= spitz_fixup,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.init_machine	= spitz_init,
 	.timer		= &pxa_timer,
@@ -1006,7 +1008,7 @@ MACHINE_START(AKITA, "SHARP Akita")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.fixup		= spitz_fixup,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.init_machine	= spitz_init,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index 62de073..2f45af4 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -1000,7 +1000,7 @@ static void __init stargate2_init(void)
 MACHINE_START(INTELMOTE2, "IMOTE 2")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= imote2_init,
@@ -1012,7 +1012,7 @@ MACHINE_END
 MACHINE_START(STARGATE2, "Stargate 2")
 	.phys_io = 0x40000000,
 	.io_pg_offst = (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.map_io = pxa_map_io,
+	.map_io = pxa2xx_map_io,
 	.nr_irqs = STARGATE_NR_IRQS,
 	.init_irq = pxa27x_init_irq,
 	.timer = &pxa_timer,
diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorevb.c
index 0f440c9..edade46 100644
--- a/arch/arm/mach-pxa/tavorevb.c
+++ b/arch/arm/mach-pxa/tavorevb.c
@@ -492,7 +492,7 @@ MACHINE_START(TAVOREVB, "PXA930 Evaluation Board (aka TavorEVB)")
 	.phys_io        = 0x40000000,
 	.boot_params    = 0xa0000100,
 	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa3xx_map_io,
 	.init_irq       = pxa3xx_init_irq,
 	.timer          = &pxa_timer,
 	.init_machine   = tavorevb_init,
diff --git a/arch/arm/mach-pxa/tavorevb3.c b/arch/arm/mach-pxa/tavorevb3.c
index 5eeba64..551e6a4 100644
--- a/arch/arm/mach-pxa/tavorevb3.c
+++ b/arch/arm/mach-pxa/tavorevb3.c
@@ -128,7 +128,7 @@ static void __init evb3_init(void)
 MACHINE_START(TAVOREVB3, "PXA950 Evaluation Board (aka TavorEVB3)")
 	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa3xx_map_io,
 	.nr_irqs	= TAVOREVB3_NR_IRQS,
 	.init_irq       = pxa3xx_init_irq,
 	.timer          = &pxa_timer,
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 3a06e98..86b6c7a 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -955,7 +955,7 @@ MACHINE_START(TOSA, "SHARP Tosa")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.fixup          = fixup_tosa,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa2xx_map_io,
 	.nr_irqs	= TOSA_NR_IRQS,
 	.init_irq       = pxa25x_init_irq,
 	.init_machine   = tosa_init,
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index 0acff17..d4ecc25 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -539,7 +539,7 @@ static void __init trizeps4_init(void)
 
 static void __init trizeps4_map_io(void)
 {
-	pxa_map_io();
+	pxa2xx_map_io();
 	iotable_init(trizeps4_io_desc, ARRAY_SIZE(trizeps4_io_desc));
 
 	if ((MSC0 & 0x8) && (BOOT_DEF & 0x1)) {
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index e90114a..8015405 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -983,7 +983,7 @@ static struct map_desc viper_io_desc[] __initdata = {
 
 static void __init viper_map_io(void)
 {
-	pxa_map_io();
+	pxa2xx_map_io();
 
 	iotable_init(viper_io_desc, ARRAY_SIZE(viper_io_desc));
 
diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index 37d6173..07c35eb 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -721,7 +721,7 @@ MACHINE_START(VPAC270, "Voipac PXA270")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= vpac270_init
diff --git a/arch/arm/mach-pxa/xcep.c b/arch/arm/mach-pxa/xcep.c
index d3b4e3f..649e74b 100644
--- a/arch/arm/mach-pxa/xcep.c
+++ b/arch/arm/mach-pxa/xcep.c
@@ -185,7 +185,7 @@ MACHINE_START(XCEP, "Iskratel XCEP")
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.init_machine	= xcep_init,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.timer		= &pxa_timer,
 MACHINE_END
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 8c44bc4..02bf4e5 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -706,7 +706,7 @@ MACHINE_START(ZIPIT2, "Zipit Z2")
 	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa2xx_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= z2_init,
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 9da2b62..96a064f 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -883,7 +883,7 @@ static struct map_desc zeus_io_desc[] __initdata = {
 
 static void __init zeus_map_io(void)
 {
-	pxa_map_io();
+	pxa2xx_map_io();
 
 	iotable_init(zeus_io_desc, ARRAY_SIZE(zeus_io_desc));
 
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index 69df3ed..908eed4 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -414,7 +414,7 @@ MACHINE_START(ZYLONITE, "PXA3xx Platform Development Kit (aka Zylonite)")
 	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa3xx_map_io,
 	.nr_irqs	= ZYLONITE_NR_IRQS,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
-- 
1.7.1
