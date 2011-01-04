From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 04 Jan 2011 20:22:37 +0000
Subject: [RFC 2/5] ARM: P2V: avoid initializers and assembly using PHYS_OFFSET
In-Reply-To: <20110104202052.GE24935@n2100.arm.linux.org.uk>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
Message-ID: <E1PaDOv-00023d-Gi@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As PHYS_OFFSET will be becoming a variable, we can't have it used in
initializers nor assembly code.  Replace those in generic code with
a run-time initialization.  Replace those in platform code using the
individual platform specific PLAT_PHYS_OFFSET.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/setup.c                  |    4 +++-
 arch/arm/mach-msm/board-msm7x27.c        |    8 ++++----
 arch/arm/mach-msm/board-msm7x30.c        |    6 +++---
 arch/arm/mach-msm/board-qsd8x50.c        |    4 ++--
 arch/arm/mach-msm/board-sapphire.c       |    2 +-
 arch/arm/mach-mx5/board-cpuimx51.c       |    2 +-
 arch/arm/mach-mx5/board-cpuimx51sd.c     |    2 +-
 arch/arm/mach-mx5/board-mx51_3ds.c       |    2 +-
 arch/arm/mach-pxa/balloon3.c             |    2 +-
 arch/arm/mach-realview/realview_eb.c     |    2 +-
 arch/arm/mach-realview/realview_pb1176.c |    2 +-
 arch/arm/mach-realview/realview_pb11mp.c |    2 +-
 arch/arm/mach-realview/realview_pba8.c   |    2 +-
 arch/arm/mach-realview/realview_pbx.c    |    2 +-
 arch/arm/mach-s5pv210/sleep.S            |    2 +-
 arch/arm/mach-tcc8k/board-tcc8000-sdk.c  |    2 +-
 arch/arm/mach-vexpress/ct-ca9x4.c        |    2 +-
 17 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 3455ad3..f67e682 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -705,7 +705,7 @@ static struct init_tags {
 	{ tag_size(tag_core), ATAG_CORE },
 	{ 1, PAGE_SIZE, 0xff },
 	{ tag_size(tag_mem32), ATAG_MEM },
-	{ MEM_SIZE, PHYS_OFFSET },
+	{ MEM_SIZE },
 	{ 0, ATAG_NONE }
 };
 
@@ -804,6 +804,8 @@ void __init setup_arch(char **cmdline_p)
 	struct machine_desc *mdesc;
 	char *from = default_command_line;
 
+	tags->mem.start = PHYS_OFFSET;
+
 	unwind_init();
 
 	setup_processor();
diff --git a/arch/arm/mach-msm/board-msm7x27.c b/arch/arm/mach-msm/board-msm7x27.c
index e7a76ef..08fcd40 100644
--- a/arch/arm/mach-msm/board-msm7x27.c
+++ b/arch/arm/mach-msm/board-msm7x27.c
@@ -132,7 +132,7 @@ static void __init msm7x2x_map_io(void)
 MACHINE_START(MSM7X27_SURF, "QCT MSM7x27 SURF")
 #ifdef CONFIG_MSM_DEBUG_UART
 #endif
-	.boot_params	= PHYS_OFFSET + 0x100,
+	.boot_params	= PLAT_PHYS_OFFSET + 0x100,
 	.map_io		= msm7x2x_map_io,
 	.init_irq	= msm7x2x_init_irq,
 	.init_machine	= msm7x2x_init,
@@ -142,7 +142,7 @@ MACHINE_END
 MACHINE_START(MSM7X27_FFA, "QCT MSM7x27 FFA")
 #ifdef CONFIG_MSM_DEBUG_UART
 #endif
-	.boot_params	= PHYS_OFFSET + 0x100,
+	.boot_params	= PLAT_PHYS_OFFSET + 0x100,
 	.map_io		= msm7x2x_map_io,
 	.init_irq	= msm7x2x_init_irq,
 	.init_machine	= msm7x2x_init,
@@ -152,7 +152,7 @@ MACHINE_END
 MACHINE_START(MSM7X25_SURF, "QCT MSM7x25 SURF")
 #ifdef CONFIG_MSM_DEBUG_UART
 #endif
-	.boot_params	= PHYS_OFFSET + 0x100,
+	.boot_params	= PLAT_PHYS_OFFSET + 0x100,
 	.map_io		= msm7x2x_map_io,
 	.init_irq	= msm7x2x_init_irq,
 	.init_machine	= msm7x2x_init,
@@ -162,7 +162,7 @@ MACHINE_END
 MACHINE_START(MSM7X25_FFA, "QCT MSM7x25 FFA")
 #ifdef CONFIG_MSM_DEBUG_UART
 #endif
-	.boot_params	= PHYS_OFFSET + 0x100,
+	.boot_params	= PLAT_PHYS_OFFSET + 0x100,
 	.map_io		= msm7x2x_map_io,
 	.init_irq	= msm7x2x_init_irq,
 	.init_machine	= msm7x2x_init,
diff --git a/arch/arm/mach-msm/board-msm7x30.c b/arch/arm/mach-msm/board-msm7x30.c
index 1931e07..eb1d1b1 100644
--- a/arch/arm/mach-msm/board-msm7x30.c
+++ b/arch/arm/mach-msm/board-msm7x30.c
@@ -65,7 +65,7 @@ static void __init msm7x30_map_io(void)
 MACHINE_START(MSM7X30_SURF, "QCT MSM7X30 SURF")
 #ifdef CONFIG_MSM_DEBUG_UART
 #endif
-	.boot_params = PHYS_OFFSET + 0x100,
+	.boot_params = PLAT_PHYS_OFFSET + 0x100,
 	.map_io = msm7x30_map_io,
 	.init_irq = msm7x30_init_irq,
 	.init_machine = msm7x30_init,
@@ -75,7 +75,7 @@ MACHINE_END
 MACHINE_START(MSM7X30_FFA, "QCT MSM7X30 FFA")
 #ifdef CONFIG_MSM_DEBUG_UART
 #endif
-	.boot_params = PHYS_OFFSET + 0x100,
+	.boot_params = PLAT_PHYS_OFFSET + 0x100,
 	.map_io = msm7x30_map_io,
 	.init_irq = msm7x30_init_irq,
 	.init_machine = msm7x30_init,
@@ -85,7 +85,7 @@ MACHINE_END
 MACHINE_START(MSM7X30_FLUID, "QCT MSM7X30 FLUID")
 #ifdef CONFIG_MSM_DEBUG_UART
 #endif
-	.boot_params = PHYS_OFFSET + 0x100,
+	.boot_params = PLAT_PHYS_OFFSET + 0x100,
 	.map_io = msm7x30_map_io,
 	.init_irq = msm7x30_init_irq,
 	.init_machine = msm7x30_init,
diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index ed2af4a..41892ed 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -99,7 +99,7 @@ static void __init qsd8x50_init(void)
 MACHINE_START(QSD8X50_SURF, "QCT QSD8X50 SURF")
 #ifdef CONFIG_MSM_DEBUG_UART
 #endif
-	.boot_params = PHYS_OFFSET + 0x100,
+	.boot_params = PLAT_PHYS_OFFSET + 0x100,
 	.map_io = qsd8x50_map_io,
 	.init_irq = qsd8x50_init_irq,
 	.init_machine = qsd8x50_init,
@@ -109,7 +109,7 @@ MACHINE_END
 MACHINE_START(QSD8X50A_ST1_5, "QCT QSD8X50A ST1.5")
 #ifdef CONFIG_MSM_DEBUG_UART
 #endif
-	.boot_params = PHYS_OFFSET + 0x100,
+	.boot_params = PLAT_PHYS_OFFSET + 0x100,
 	.map_io = qsd8x50_map_io,
 	.init_irq = qsd8x50_init_irq,
 	.init_machine = qsd8x50_init,
diff --git a/arch/arm/mach-msm/board-sapphire.c b/arch/arm/mach-msm/board-sapphire.c
index 8919ffb..83604f5 100644
--- a/arch/arm/mach-msm/board-sapphire.c
+++ b/arch/arm/mach-msm/board-sapphire.c
@@ -107,7 +107,7 @@ MACHINE_START(SAPPHIRE, "sapphire")
 /* Maintainer: Brian Swetland <swetland@google.com> */
 #ifdef CONFIG_MSM_DEBUG_UART
 #endif
-	.boot_params    = PHYS_OFFSET + 0x100,
+	.boot_params    = PLAT_PHYS_OFFSET + 0x100,
 	.fixup          = sapphire_fixup,
 	.map_io         = sapphire_map_io,
 	.init_irq       = sapphire_init_irq,
diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
index 6a9792f..c4c3a9c 100644
--- a/arch/arm/mach-mx5/board-cpuimx51.c
+++ b/arch/arm/mach-mx5/board-cpuimx51.c
@@ -292,7 +292,7 @@ static struct sys_timer mxc_timer = {
 
 MACHINE_START(EUKREA_CPUIMX51, "Eukrea CPUIMX51 Module")
 	/* Maintainer: Eric B??nard <eric@eukrea.com> */
-	.boot_params = PHYS_OFFSET + 0x100,
+	.boot_params = PLAT_PHYS_OFFSET + 0x100,
 	.map_io = mx51_map_io,
 	.init_irq = mx51_init_irq,
 	.init_machine = eukrea_cpuimx51_init,
diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
index 4b3a611..b887381 100644
--- a/arch/arm/mach-mx5/board-cpuimx51sd.c
+++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
@@ -323,7 +323,7 @@ static struct sys_timer mxc_timer = {
 
 MACHINE_START(EUKREA_CPUIMX51SD, "Eukrea CPUIMX51SD")
 	/* Maintainer: Eric B??nard <eric@eukrea.com> */
-	.boot_params = PHYS_OFFSET + 0x100,
+	.boot_params = PLAT_PHYS_OFFSET + 0x100,
 	.map_io = mx51_map_io,
 	.init_irq = mx51_init_irq,
 	.init_machine = eukrea_cpuimx51sd_init,
diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index 79ce8dc..10e6ce3 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -186,7 +186,7 @@ static struct sys_timer mxc_timer = {
 
 MACHINE_START(MX51_3DS, "Freescale MX51 3-Stack Board")
 	/* Maintainer: Freescale Semiconductor, Inc. */
-	.boot_params = PHYS_OFFSET + 0x100,
+	.boot_params = PLAT_PHYS_OFFSET + 0x100,
 	.map_io = mx51_map_io,
 	.init_irq = mx51_init_irq,
 	.init_machine = mxc_board_init,
diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index ccb2d0c..abcc646 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -824,5 +824,5 @@ MACHINE_START(BALLOON3, "Balloon3")
 	.init_irq	= balloon3_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= balloon3_init,
-	.boot_params	= PHYS_OFFSET + 0x100,
+	.boot_params	= PLAT_PHYS_OFFSET + 0x100,
 MACHINE_END
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 6ef5c5e..8ede983 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -484,7 +484,7 @@ static void __init realview_eb_init(void)
 
 MACHINE_START(REALVIEW_EB, "ARM-RealView EB")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.boot_params	= PHYS_OFFSET + 0x00000100,
+	.boot_params	= PLAT_PHYS_OFFSET + 0x00000100,
 	.fixup		= realview_fixup,
 	.map_io		= realview_eb_map_io,
 	.init_irq	= gic_init_irq,
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index cbdc97a..9f26369 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -379,7 +379,7 @@ static void __init realview_pb1176_init(void)
 
 MACHINE_START(REALVIEW_PB1176, "ARM-RealView PB1176")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.boot_params	= PHYS_OFFSET + 0x00000100,
+	.boot_params	= PLAT_PHYS_OFFSET + 0x00000100,
 	.fixup		= realview_pb1176_fixup,
 	.map_io		= realview_pb1176_map_io,
 	.init_irq	= gic_init_irq,
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 8e8ab7d..dea06b2 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -381,7 +381,7 @@ static void __init realview_pb11mp_init(void)
 
 MACHINE_START(REALVIEW_PB11MP, "ARM-RealView PB11MPCore")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.boot_params	= PHYS_OFFSET + 0x00000100,
+	.boot_params	= PLAT_PHYS_OFFSET + 0x00000100,
 	.fixup		= realview_fixup,
 	.map_io		= realview_pb11mp_map_io,
 	.init_irq	= gic_init_irq,
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 841118e..7d0f173 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -331,7 +331,7 @@ static void __init realview_pba8_init(void)
 
 MACHINE_START(REALVIEW_PBA8, "ARM-RealView PB-A8")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.boot_params	= PHYS_OFFSET + 0x00000100,
+	.boot_params	= PLAT_PHYS_OFFSET + 0x00000100,
 	.fixup		= realview_fixup,
 	.map_io		= realview_pba8_map_io,
 	.init_irq	= gic_init_irq,
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 02b755b..b89e28f 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -414,7 +414,7 @@ static void __init realview_pbx_init(void)
 
 MACHINE_START(REALVIEW_PBX, "ARM-RealView PBX")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.boot_params	= PHYS_OFFSET + 0x00000100,
+	.boot_params	= PLAT_PHYS_OFFSET + 0x00000100,
 	.fixup		= realview_pbx_fixup,
 	.map_io		= realview_pbx_map_io,
 	.init_irq	= gic_init_irq,
diff --git a/arch/arm/mach-s5pv210/sleep.S b/arch/arm/mach-s5pv210/sleep.S
index d4d222b..2737622 100644
--- a/arch/arm/mach-s5pv210/sleep.S
+++ b/arch/arm/mach-s5pv210/sleep.S
@@ -65,7 +65,7 @@ resume_with_mmu:
 	/*
 	 * After MMU is turned on, restore the previous MMU table.
 	 */
-	ldr	r9 , =(PAGE_OFFSET - PHYS_OFFSET)
+	ldr	r9 , =(PAGE_OFFSET - PLAT_PHYS_OFFSET)
 	add	r4, r4, r9
 	str	r12, [r4]
 
diff --git a/arch/arm/mach-tcc8k/board-tcc8000-sdk.c b/arch/arm/mach-tcc8k/board-tcc8000-sdk.c
index 7991415..fb6426d 100644
--- a/arch/arm/mach-tcc8k/board-tcc8000-sdk.c
+++ b/arch/arm/mach-tcc8k/board-tcc8000-sdk.c
@@ -54,7 +54,7 @@ static void __init tcc8k_map_io(void)
 }
 
 MACHINE_START(TCC8000_SDK, "Telechips TCC8000-SDK Demo Board")
-	.boot_params	= PHYS_OFFSET + 0x00000100,
+	.boot_params	= PLAT_PHYS_OFFSET + 0x00000100,
 	.map_io		= tcc8k_map_io,
 	.init_irq	= tcc8k_init_irq,
 	.init_machine	= tcc8k_init,
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index e628402..e9bccc5 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -243,7 +243,7 @@ static void __init ct_ca9x4_init(void)
 }
 
 MACHINE_START(VEXPRESS, "ARM-Versatile Express CA9x4")
-	.boot_params	= PHYS_OFFSET + 0x00000100,
+	.boot_params	= PLAT_PHYS_OFFSET + 0x00000100,
 	.map_io		= ct_ca9x4_map_io,
 	.init_irq	= ct_ca9x4_init_irq,
 #if 0
-- 
1.6.2.5
