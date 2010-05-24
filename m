From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 24 May 2010 14:35:45 +0800
Subject: [PATCH 2/6] [ARM] pxa: encode IRQ number into .nr_irqs
In-Reply-To: <1274682949-25915-1-git-send-email-eric.y.miao@gmail.com>
References: <1274682949-25915-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1274682949-25915-3-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/Kconfig                  |    5 -----
 arch/arm/mach-pxa/include/mach/irqs.h      |    7 +------
 arch/arm/mach-pxa/include/mach/lpd270.h    |    1 +
 arch/arm/mach-pxa/include/mach/lubbock.h   |    3 +++
 arch/arm/mach-pxa/include/mach/mainstone.h |    2 ++
 arch/arm/mach-pxa/include/mach/poodle.h    |    2 ++
 arch/arm/mach-pxa/include/mach/zylonite.h  |    2 ++
 arch/arm/mach-pxa/lpd270.c                 |    1 +
 arch/arm/mach-pxa/lubbock.c                |    3 ++-
 arch/arm/mach-pxa/mainstone.c              |    1 +
 arch/arm/mach-pxa/poodle.c                 |    1 +
 arch/arm/mach-pxa/zylonite.c               |    1 +
 12 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 3b51741..bf49135 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -8,19 +8,16 @@ config ARCH_LUBBOCK
 	bool "Intel DBPXA250 Development Platform (aka Lubbock)"
 	select PXA25x
 	select SA1111
-	select PXA_HAVE_BOARD_IRQS
 
 config MACH_MAINSTONE
 	bool "Intel HCDDBBVA0 Development Platform (aka Mainstone)"
 	select PXA27x
 	select HAVE_PWM
-	select PXA_HAVE_BOARD_IRQS
 
 config MACH_ZYLONITE
 	bool
 	select PXA3xx
 	select HAVE_PWM
-	select PXA_HAVE_BOARD_IRQS
 
 config MACH_ZYLONITE300
 	bool "PXA3xx Development Platform (aka Zylonite) PXA300/310"
@@ -206,7 +203,6 @@ config MACH_LOGICPD_PXA270
 	bool "LogicPD PXA270 Card Engine Development Platform"
 	select PXA27x
 	select HAVE_PWM
-	select PXA_HAVE_BOARD_IRQS
 
 config MACH_PCM027
 	bool "Phytec phyCORE-PXA270 CPU module (PCM-027)"
@@ -463,7 +459,6 @@ config MACH_POODLE
 	depends on PXA_SHARPSL
 	select PXA25x
 	select SHARP_LOCOMO
-	select PXA_HAVE_BOARD_IRQS
 
 config MACH_CORGI
 	bool "Enable Sharp SL-C700 (Corgi) Support"
diff --git a/arch/arm/mach-pxa/include/mach/irqs.h b/arch/arm/mach-pxa/include/mach/irqs.h
index ffc8314..3b3b245 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -127,8 +127,6 @@
 
 #if defined(CONFIG_MACH_H4700)
 #define IRQ_BOARD_END		(IRQ_BOARD_START + 70)
-#elif defined(CONFIG_MACH_ZYLONITE)
-#define IRQ_BOARD_END		(IRQ_BOARD_START + 32)
 #elif defined(CONFIG_PXA_EZX)
 #define IRQ_BOARD_END		(IRQ_BOARD_START + 23)
 #else
@@ -138,13 +136,10 @@
 /*
  * Figure out the MAX IRQ number.
  *
- * If we have an SA1111, the max IRQ is S1_BVD1_STSCHG+1.
  * If we have an LoCoMo, the max IRQ is IRQ_LOCOMO_SPI_TEND+1
  * Otherwise, we have the standard IRQs only.
  */
-#ifdef CONFIG_SA1111
-#define NR_IRQS			(IRQ_BOARD_END + 55)
-#elif defined(CONFIG_PXA_HAVE_BOARD_IRQS)
+#if defined(CONFIG_PXA_HAVE_BOARD_IRQS)
 #define NR_IRQS			(IRQ_BOARD_END)
 #else
 #define NR_IRQS			(IRQ_BOARD_START)
diff --git a/arch/arm/mach-pxa/include/mach/lpd270.h b/arch/arm/mach-pxa/include/mach/lpd270.h
index 0e6440c..cd07009 100644
--- a/arch/arm/mach-pxa/include/mach/lpd270.h
+++ b/arch/arm/mach-pxa/include/mach/lpd270.h
@@ -38,5 +38,6 @@
 #define LPD270_USBC_IRQ		LPD270_IRQ(2)
 #define LPD270_ETHERNET_IRQ	LPD270_IRQ(3)
 #define LPD270_AC97_IRQ		LPD270_IRQ(4)
+#define LPD270_NR_IRQS		(IRQ_BOARD_START + 5)
 
 #endif
diff --git a/arch/arm/mach-pxa/include/mach/lubbock.h b/arch/arm/mach-pxa/include/mach/lubbock.h
index a0d4247..2a086e8 100644
--- a/arch/arm/mach-pxa/include/mach/lubbock.h
+++ b/arch/arm/mach-pxa/include/mach/lubbock.h
@@ -45,6 +45,9 @@
 #define LUBBOCK_USB_DISC_IRQ	LUBBOCK_IRQ(6)  /* usb disconnect */
 #define LUBBOCK_LAST_IRQ	LUBBOCK_IRQ(6)
 
+#define LUBBOCK_SA1111_IRQ_BASE	(IRQ_BOARD_START + 16)
+#define LUBBOCK_NR_IRQS		(IRQ_BOARD_START + 16 + 55)
+
 #ifndef __ASSEMBLY__
 extern void lubbock_set_misc_wr(unsigned int mask, unsigned int set);
 #endif
diff --git a/arch/arm/mach-pxa/include/mach/mainstone.h b/arch/arm/mach-pxa/include/mach/mainstone.h
index 86e623a..4c2d11c 100644
--- a/arch/arm/mach-pxa/include/mach/mainstone.h
+++ b/arch/arm/mach-pxa/include/mach/mainstone.h
@@ -134,4 +134,6 @@
 #define MAINSTONE_S1_STSCHG_IRQ	MAINSTONE_IRQ(14)
 #define MAINSTONE_S1_IRQ	MAINSTONE_IRQ(15)
 
+#define MAINSTONE_NR_IRQS	(IRQ_BOARD_START + 16)
+
 #endif
diff --git a/arch/arm/mach-pxa/include/mach/poodle.h b/arch/arm/mach-pxa/include/mach/poodle.h
index 0b3e6d0..83d1cfd 100644
--- a/arch/arm/mach-pxa/include/mach/poodle.h
+++ b/arch/arm/mach-pxa/include/mach/poodle.h
@@ -85,6 +85,8 @@
 #define POODLE_LOCOMO_GPIO_232VCC_ON   LOCOMO_GPIO(12)
 #define POODLE_LOCOMO_GPIO_JK_B        LOCOMO_GPIO(13)
 
+#define POODLE_NR_IRQS		(IRQ_BOARD_START + 4)	/* 4 for LoCoMo */
+
 extern struct platform_device poodle_locomo_device;
 
 #endif /* __ASM_ARCH_POODLE_H  */
diff --git a/arch/arm/mach-pxa/include/mach/zylonite.h b/arch/arm/mach-pxa/include/mach/zylonite.h
index 9edf645..ea24998 100644
--- a/arch/arm/mach-pxa/include/mach/zylonite.h
+++ b/arch/arm/mach-pxa/include/mach/zylonite.h
@@ -5,6 +5,8 @@
 
 #define EXT_GPIO(x)		(128 + (x))
 
+#define ZYLONITE_NR_IRQS	(IRQ_BOARD_START + 32)
+
 /* the following variables are processor specific and initialized
  * by the corresponding zylonite_pxa3xx_init()
  */
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index d279507..fc9502e 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -509,6 +509,7 @@ MACHINE_START(LOGICPD_PXA270, "LogicPD PXA270 Card Engine")
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= lpd270_map_io,
+	.nr_irqs	= LPD270_NR_IRQS,
 	.init_irq	= lpd270_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= lpd270_init,
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index 330c328..1956c23 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -229,7 +229,7 @@ static struct resource sa1111_resources[] = {
 };
 
 static struct sa1111_platform_data sa1111_info = {
-	.irq_base	= IRQ_BOARD_END,
+	.irq_base	= LUBBOCK_SA1111_IRQ_BASE,
 };
 
 static struct platform_device sa1111_device = {
@@ -560,6 +560,7 @@ MACHINE_START(LUBBOCK, "Intel DBPXA250 Development Platform (aka Lubbock)")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= lubbock_map_io,
+	.nr_irqs	= LUBBOCK_NR_IRQS,
 	.init_irq	= lubbock_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= lubbock_init,
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index 5543c64..c2a8717 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -628,6 +628,7 @@ MACHINE_START(MAINSTONE, "Intel HCDDBBVA0 Development Platform (aka Mainstone)")
 	.boot_params	= 0xa0000100,	/* BLOB boot parameter setting */
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= mainstone_map_io,
+	.nr_irqs	= MAINSTONE_NR_IRQS,
 	.init_irq	= mainstone_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= mainstone_init,
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index f4abdaa..aef6a9e 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -472,6 +472,7 @@ MACHINE_START(POODLE, "SHARP Poodle")
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.fixup		= fixup_poodle,
 	.map_io		= pxa_map_io,
+	.nr_irqs	= POODLE_NR_IRQS,	/* 4 for LoCoMo */
 	.init_irq	= pxa25x_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= poodle_init,
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index c479cbe..2edad61 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -415,6 +415,7 @@ MACHINE_START(ZYLONITE, "PXA3xx Platform Development Kit (aka Zylonite)")
 	.boot_params	= 0xa0000100,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
+	.nr_irqs	= ZYLONITE_NR_IRQS,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= zylonite_init,
-- 
1.7.0.4
