From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 23 Dec 2009 12:07:13 -0500
Subject: [PATCH] ep93xx: add missing SDRAM options for EDB93xx
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200F353@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ep93xx: add missing SDRAM options for EDB93xx

The EDB93xx series dev boards have various means of selecting the first
SDRAM bank chip-select and boot mode (sync/async).  This adds the non-
standard options.  The config choice already defaults to the standard.

This config option ends up defining PHYS_OFFSET for all ep93xx platforms.
The machine boot_params are located at this address + 0x100.  Modify the
MACHINE_START for all ep39xx platforms to reflect this.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index 9167c3d..db848a4 100644
--- a/arch/arm/mach-ep93xx/Kconfig
+++ b/arch/arm/mach-ep93xx/Kconfig
@@ -57,19 +57,23 @@ config MACH_EDB93XX
 
 config MACH_EDB9301
 	bool "Support Cirrus Logic EDB9301"
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
+	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET || EP93XX_SDCE0_PHYS_OFFSET || \
+		   EP93XX_SDCE3_ASYNC_PHYS_OFFSET
 	select MACH_EDB93XX
 	help
 	  Say 'Y' here if you want your kernel to support the Cirrus
-	  Logic EDB9301 Evaluation Board.
+	  Logic EDB9301 Evaluation Board.  The default setup for the
+	  board has the first SDRAM bank at 0x00000000 - SDCE3/SyncBoot.
 
 config MACH_EDB9302
 	bool "Support Cirrus Logic EDB9302"
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
+	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET || EP93XX_SDCE0_PHYS_OFFSET || \
+		   EP93XX_SDCE3_ASYNC_PHYS_OFFSET
 	select MACH_EDB93XX
 	help
 	  Say 'Y' here if you want your kernel to support the Cirrus
-	  Logic EDB9302 Evaluation Board.
+	  Logic EDB9302 Evaluation Board.  The default setup for the
+	  board has the first SDRAM bank at 0x00000000 - SDCE3/SyncBoot.
 
 config MACH_EDB9302A
 	bool "Support Cirrus Logic EDB9302A"
@@ -81,11 +85,13 @@ config MACH_EDB9302A
 
 config MACH_EDB9307
 	bool "Support Cirrus Logic EDB9307"
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
+	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET || EP93XX_SDCE0_PHYS_OFFSET || \
+		   EP93XX_SDCE3_ASYNC_PHYS_OFFSET
 	select MACH_EDB93XX
 	help
 	  Say 'Y' here if you want your kernel to support the Cirrus
-	  Logic EDB9307 Evaluation Board.
+	  Logic EDB9307 Evaluation Board.  The default setup for the
+	  board has the first SDRAM bank at 0x00000000 - SDCE3/SyncBoot.
 
 config MACH_EDB9307A
 	bool "Support Cirrus Logic EDB9307A"
@@ -97,19 +103,24 @@ config MACH_EDB9307A
 
 config MACH_EDB9312
 	bool "Support Cirrus Logic EDB9312"
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
+	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET || EP93XX_SDCE0_PHYS_OFFSET || \
+		   EP93XX_SDCE1_PHYS_OFFSET || EP93XX_SDCE2_PHYS_OFFSET || \
+		   EP93XX_SDCE3_ASYNC_PHYS_OFFSET
 	select MACH_EDB93XX
 	help
 	  Say 'Y' here if you want your kernel to support the Cirrus
-	  Logic EDB9312 Evaluation Board.
+	  Logic EDB9312 Evaluation Board.  The default setup for the
+	  board has the first SDRAM bank at 0x00000000 - SDCE3/SyncBoot.
 
 config MACH_EDB9315
 	bool "Support Cirrus Logic EDB9315"
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
+	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET || EP93XX_SDCE0_PHYS_OFFSET || \
+		   EP93XX_SDCE3_ASYNC_PHYS_OFFSET
 	select MACH_EDB93XX
 	help
 	  Say 'Y' here if you want your kernel to support the Cirrus
-	  Logic EDB9315 Evaluation Board.
+	  Logic EDB9315 Evaluation Board.  The default setup for the
+	  board has the first SDRAM bank at 0x00000000 - SDCE3/SyncBoot.
 
 config MACH_EDB9315A
 	bool "Support Cirrus Logic EDB9315A"
@@ -120,8 +131,8 @@ config MACH_EDB9315A
 	  Logic EDB9315A Evaluation Board.
 
 config MACH_GESBC9312
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
 	bool "Support Glomation GESBC-9312-sx"
+	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
 	help
 	  Say 'Y' here if you want your kernel to support the Glomation
 	  GESBC-9312-sx board.
diff --git a/arch/arm/mach-ep93xx/adssphere.c b/arch/arm/mach-ep93xx/adssphere.c
index caf6d51..5834ce8 100644
--- a/arch/arm/mach-ep93xx/adssphere.c
+++ b/arch/arm/mach-ep93xx/adssphere.c
@@ -57,7 +57,7 @@ MACHINE_START(ADSSPHERE, "ADS Sphere board")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.phys_io	= EP93XX_APB_PHYS_BASE,
 	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
+	.boot_params	= PHYS_OFFSET + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index a4a7be3..c3edf92 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -132,7 +132,7 @@ MACHINE_START(EDB9301, "Cirrus Logic EDB9301 Evaluation Board")
 	/* Maintainer: H Hartley Sweeten <hsweeten@visionengravers.com> */
 	.phys_io	= EP93XX_APB_PHYS_BASE,
 	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
+	.boot_params	= PHYS_OFFSET + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
@@ -145,7 +145,7 @@ MACHINE_START(EDB9302, "Cirrus Logic EDB9302 Evaluation Board")
 	/* Maintainer: George Kashperko <george@chas.com.ua> */
 	.phys_io	= EP93XX_APB_PHYS_BASE,
 	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
+	.boot_params	= PHYS_OFFSET + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
@@ -158,7 +158,7 @@ MACHINE_START(EDB9302A, "Cirrus Logic EDB9302A Evaluation Board")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.phys_io	= EP93XX_APB_PHYS_BASE,
 	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
-	.boot_params	= EP93XX_SDCE0_PHYS_BASE + 0x100,
+	.boot_params	= PHYS_OFFSET + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
@@ -171,7 +171,7 @@ MACHINE_START(EDB9307, "Cirrus Logic EDB9307 Evaluation Board")
 	/* Maintainer: Herbert Valerio Riedel <hvr@gnu.org> */
 	.phys_io	= EP93XX_APB_PHYS_BASE,
 	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
+	.boot_params	= PHYS_OFFSET + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
@@ -184,7 +184,7 @@ MACHINE_START(EDB9307A, "Cirrus Logic EDB9307A Evaluation Board")
 	/* Maintainer: H Hartley Sweeten <hsweeten@visionengravers.com> */
 	.phys_io	= EP93XX_APB_PHYS_BASE,
 	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
-	.boot_params	= EP93XX_SDCE0_PHYS_BASE + 0x100,
+	.boot_params	= PHYS_OFFSET + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
@@ -197,7 +197,7 @@ MACHINE_START(EDB9312, "Cirrus Logic EDB9312 Evaluation Board")
 	/* Maintainer: Toufeeq Hussain <toufeeq_hussain@infosys.com> */
 	.phys_io	= EP93XX_APB_PHYS_BASE,
 	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
+	.boot_params	= PHYS_OFFSET + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
@@ -210,7 +210,7 @@ MACHINE_START(EDB9315, "Cirrus Logic EDB9315 Evaluation Board")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.phys_io	= EP93XX_APB_PHYS_BASE,
 	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
+	.boot_params	= PHYS_OFFSET + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
@@ -223,7 +223,7 @@ MACHINE_START(EDB9315A, "Cirrus Logic EDB9315A Evaluation Board")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.phys_io	= EP93XX_APB_PHYS_BASE,
 	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
-	.boot_params	= EP93XX_SDCE0_PHYS_BASE + 0x100,
+	.boot_params	= PHYS_OFFSET + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
diff --git a/arch/arm/mach-ep93xx/gesbc9312.c b/arch/arm/mach-ep93xx/gesbc9312.c
index 3da7ca8..234a902 100644
--- a/arch/arm/mach-ep93xx/gesbc9312.c
+++ b/arch/arm/mach-ep93xx/gesbc9312.c
@@ -57,7 +57,7 @@ MACHINE_START(GESBC9312, "Glomation GESBC-9312-sx")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.phys_io	= EP93XX_APB_PHYS_BASE,
 	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
+	.boot_params	= PHYS_OFFSET + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
diff --git a/arch/arm/mach-ep93xx/micro9.c b/arch/arm/mach-ep93xx/micro9.c
index f3757a1..9c9fe91 100644
--- a/arch/arm/mach-ep93xx/micro9.c
+++ b/arch/arm/mach-ep93xx/micro9.c
@@ -98,7 +98,7 @@ MACHINE_START(MICRO9, "Contec Micro9-High")
 	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
 	.phys_io	= EP93XX_APB_PHYS_BASE,
 	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
+	.boot_params	= PHYS_OFFSET + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
@@ -111,7 +111,7 @@ MACHINE_START(MICRO9M, "Contec Micro9-Mid")
 	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
 	.phys_io	= EP93XX_APB_PHYS_BASE,
 	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_ASYNC + 0x100,
+	.boot_params	= PHYS_OFFSET + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
@@ -124,7 +124,7 @@ MACHINE_START(MICRO9L, "Contec Micro9-Lite")
 	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
 	.phys_io	= EP93XX_APB_PHYS_BASE,
 	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
+	.boot_params	= PHYS_OFFSET + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
@@ -137,7 +137,7 @@ MACHINE_START(MICRO9S, "Contec Micro9-Slim")
 	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
 	.phys_io	= EP93XX_APB_PHYS_BASE,
 	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_ASYNC + 0x100,
+	.boot_params	= PHYS_OFFSET + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 259f782..a539105 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -183,7 +183,7 @@ MACHINE_START(TS72XX, "Technologic Systems TS-72xx SBC")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.phys_io	= EP93XX_APB_PHYS_BASE,
 	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
+	.boot_params	= PHYS_OFFSET + 0x100,
 	.map_io		= ts72xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer, 
