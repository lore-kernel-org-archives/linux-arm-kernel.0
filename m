From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  7 Feb 2011 16:35:20 +0100
Subject: [PATCH 2/4] ARM: mx3: use .init_early to initialize cpu type,
	reset address and iomuxer
In-Reply-To: <20110126103107.GA4232@n2100.arm.linux.org.uk>
References: <20110126103107.GA4232@n2100.arm.linux.org.uk>
Message-ID: <1297092922-12741-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This used to be done in .map_io which is supposed to only setup the
memory mapping.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/mach-armadillo5x0.c   |   11 ++++++-----
 arch/arm/mach-mx3/mach-cpuimx35.c       |   11 ++++++-----
 arch/arm/mach-mx3/mach-kzm_arm11_01.c   |   11 ++++++-----
 arch/arm/mach-mx3/mach-mx31_3ds.c       |   11 ++++++-----
 arch/arm/mach-mx3/mach-mx31ads.c        |   11 ++++++-----
 arch/arm/mach-mx3/mach-mx31lilly.c      |   12 ++++++------
 arch/arm/mach-mx3/mach-mx31lite.c       |   11 ++++++-----
 arch/arm/mach-mx3/mach-mx31moboard.c    |   12 ++++++------
 arch/arm/mach-mx3/mach-mx35_3ds.c       |   11 ++++++-----
 arch/arm/mach-mx3/mach-pcm037.c         |   11 ++++++-----
 arch/arm/mach-mx3/mach-pcm043.c         |   12 ++++++------
 arch/arm/mach-mx3/mach-qong.c           |   11 ++++++-----
 arch/arm/mach-mx3/mach-vpr200.c         |    9 +++++----
 arch/arm/mach-mx3/mm.c                  |   14 ++++++++++----
 arch/arm/plat-mxc/include/mach/common.h |    3 +++
 15 files changed, 90 insertions(+), 71 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-armadillo5x0.c b/arch/arm/mach-mx3/mach-armadillo5x0.c
index 28b6f41..835e2a0 100644
--- a/arch/arm/mach-mx3/mach-armadillo5x0.c
+++ b/arch/arm/mach-mx3/mach-armadillo5x0.c
@@ -569,9 +569,10 @@ static struct sys_timer armadillo5x0_timer = {
 
 MACHINE_START(ARMADILLO5X0, "Armadillo-500")
 	/* Maintainer: Alberto Panizzo  */
-	.boot_params	= MX3x_PHYS_OFFSET + 0x100,
-	.map_io		= mx31_map_io,
-	.init_irq	= mx31_init_irq,
-	.timer		= &armadillo5x0_timer,
-	.init_machine	= armadillo5x0_init,
+	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.map_io = mx31_map_io,
+	.init_early = imx31_init_early,
+	.init_irq = mx31_init_irq,
+	.timer = &armadillo5x0_timer,
+	.init_machine = armadillo5x0_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-mx3/mach-cpuimx35.c
index 26ae90f..3eedf0f 100644
--- a/arch/arm/mach-mx3/mach-cpuimx35.c
+++ b/arch/arm/mach-mx3/mach-cpuimx35.c
@@ -184,9 +184,10 @@ struct sys_timer eukrea_cpuimx35_timer = {
 
 MACHINE_START(EUKREA_CPUIMX35, "Eukrea CPUIMX35")
 	/* Maintainer: Eukrea Electromatique */
-	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
-	.map_io         = mx35_map_io,
-	.init_irq       = mx35_init_irq,
-	.init_machine   = mxc_board_init,
-	.timer          = &eukrea_cpuimx35_timer,
+	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.map_io = mx35_map_io,
+	.init_ext3_fs = imx35_init_early,
+	.init_irq = mx35_init_irq,
+	.timer = &eukrea_cpuimx35_timer,
+	.init_machine = mxc_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx3/mach-kzm_arm11_01.c b/arch/arm/mach-mx3/mach-kzm_arm11_01.c
index a5f3eb2..52b8dd7 100644
--- a/arch/arm/mach-mx3/mach-kzm_arm11_01.c
+++ b/arch/arm/mach-mx3/mach-kzm_arm11_01.c
@@ -274,9 +274,10 @@ static struct sys_timer kzm_timer = {
  * initialize __mach_desc_KZM_ARM11_01 data structure.
  */
 MACHINE_START(KZM_ARM11_01, "Kyoto Microcomputer Co., Ltd. KZM-ARM11-01")
-	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
-	.map_io         = kzm_map_io,
-	.init_irq       = mx31_init_irq,
-	.init_machine   = kzm_board_init,
-	.timer          = &kzm_timer,
+	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.map_io = kzm_map_io,
+	.init_early = imx31_init_early,
+	.init_irq = mx31_init_irq,
+	.timer = &kzm_timer,
+	.init_machine = kzm_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 2f41430..2646467 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -373,9 +373,10 @@ static struct sys_timer mx31_3ds_timer = {
  */
 MACHINE_START(MX31_3DS, "Freescale MX31PDK (3DS)")
 	/* Maintainer: Freescale Semiconductor, Inc. */
-	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
-	.map_io         = mx31_map_io,
-	.init_irq       = mx31_init_irq,
-	.init_machine   = mxc_board_init,
-	.timer          = &mx31_3ds_timer,
+	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.map_io = mx31_map_io,
+	.init_early = imx31_init_early,
+	.init_irq = mx31_init_irq,
+	.timer = &mx31_3ds_timer,
+	.init_machine = mxc_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx3/mach-mx31ads.c b/arch/arm/mach-mx3/mach-mx31ads.c
index e40eb6e..787bdc4 100644
--- a/arch/arm/mach-mx3/mach-mx31ads.c
+++ b/arch/arm/mach-mx3/mach-mx31ads.c
@@ -550,9 +550,10 @@ static struct sys_timer mx31ads_timer = {
  */
 MACHINE_START(MX31ADS, "Freescale MX31ADS")
 	/* Maintainer: Freescale Semiconductor, Inc. */
-	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
-	.map_io         = mx31ads_map_io,
-	.init_irq       = mx31ads_init_irq,
-	.init_machine   = mxc_board_init,
-	.timer          = &mx31ads_timer,
+	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.map_io = mx31ads_map_io,
+	.init_early = imx31_init_early,
+	.init_irq = mx31ads_init_irq,
+	.timer = &mx31ads_timer,
+	.init_machine = mxc_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx3/mach-mx31lilly.c b/arch/arm/mach-mx3/mach-mx31lilly.c
index 2c59548..25e143a 100644
--- a/arch/arm/mach-mx3/mach-mx31lilly.c
+++ b/arch/arm/mach-mx3/mach-mx31lilly.c
@@ -347,10 +347,10 @@ static struct sys_timer mx31lilly_timer = {
 };
 
 MACHINE_START(LILLY1131, "INCO startec LILLY-1131")
-	.boot_params	= MX3x_PHYS_OFFSET + 0x100,
-	.map_io		= mx31_map_io,
-	.init_irq	= mx31_init_irq,
-	.init_machine	= mx31lilly_board_init,
-	.timer		= &mx31lilly_timer,
+	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.map_io = mx31_map_io,
+	.init_early = imx31_init_early,
+	.init_irq = mx31_init_irq,
+	.timer = &mx31lilly_timer,
+	.init_machine = mx31lilly_board_init,
 MACHINE_END
-
diff --git a/arch/arm/mach-mx3/mach-mx31lite.c b/arch/arm/mach-mx3/mach-mx31lite.c
index 9e64c66..c03c77d 100644
--- a/arch/arm/mach-mx3/mach-mx31lite.c
+++ b/arch/arm/mach-mx3/mach-mx31lite.c
@@ -281,9 +281,10 @@ struct sys_timer mx31lite_timer = {
 
 MACHINE_START(MX31LITE, "LogicPD i.MX31 SOM")
 	/* Maintainer: Freescale Semiconductor, Inc. */
-	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
-	.map_io         = mx31lite_map_io,
-	.init_irq       = mx31_init_irq,
-	.init_machine   = mxc_board_init,
-	.timer          = &mx31lite_timer,
+	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.map_io = mx31lite_map_io,
+	.init_early = imx31_init_early,
+	.init_irq = mx31_init_irq,
+	.timer = &mx31lite_timer,
+	.init_machine = mxc_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index 1aa8d65..ea72480 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -564,10 +564,10 @@ struct sys_timer mx31moboard_timer = {
 
 MACHINE_START(MX31MOBOARD, "EPFL Mobots mx31moboard")
 	/* Maintainer: Valentin Longchamp, EPFL Mobots group */
-	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
-	.map_io         = mx31_map_io,
-	.init_irq       = mx31_init_irq,
-	.init_machine   = mxc_board_init,
-	.timer          = &mx31moboard_timer,
+	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.map_io = mx31_map_io,
+	.init_early = imx31_init_early,
+	.init_irq = mx31_init_irq,
+	.timer = &mx31moboard_timer,
+	.init_machine = mxc_board_init,
 MACHINE_END
-
diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index b1963f2..c5115dc 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -193,9 +193,10 @@ struct sys_timer mx35pdk_timer = {
 
 MACHINE_START(MX35_3DS, "Freescale MX35PDK")
 	/* Maintainer: Freescale Semiconductor, Inc */
-	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
-	.map_io         = mx35_map_io,
-	.init_irq       = mx35_init_irq,
-	.init_machine   = mxc_board_init,
-	.timer          = &mx35pdk_timer,
+	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.map_io = mx35_map_io,
+	.init_early = imx35_init_early,
+	.init_irq = mx35_init_irq,
+	.timer = &mx35pdk_timer,
+	.init_machine = mxc_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index b752f6b..7d444f7 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -675,9 +675,10 @@ struct sys_timer pcm037_timer = {
 
 MACHINE_START(PCM037, "Phytec Phycore pcm037")
 	/* Maintainer: Pengutronix */
-	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
-	.map_io         = mx31_map_io,
-	.init_irq       = mx31_init_irq,
-	.init_machine   = mxc_board_init,
-	.timer          = &pcm037_timer,
+	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.map_io = mx31_map_io,
+	.init_early = imx31_init_early,
+	.init_irq = mx31_init_irq,
+	.timer = &pcm037_timer,
+	.init_machine = mxc_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index a515290..b03e19d 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -403,10 +403,10 @@ struct sys_timer pcm043_timer = {
 
 MACHINE_START(PCM043, "Phytec Phycore pcm043")
 	/* Maintainer: Pengutronix */
-	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
-	.map_io         = mx35_map_io,
-	.init_irq       = mx35_init_irq,
-	.init_machine   = mxc_board_init,
-	.timer          = &pcm043_timer,
+	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.map_io = mx35_map_io,
+	.init_early = imx35_init_early,
+	.init_irq = mx35_init_irq,
+	.timer = &pcm043_timer,
+	.init_machine = mxc_board_init,
 MACHINE_END
-
diff --git a/arch/arm/mach-mx3/mach-qong.c b/arch/arm/mach-mx3/mach-qong.c
index fd1050c..064f2db 100644
--- a/arch/arm/mach-mx3/mach-qong.c
+++ b/arch/arm/mach-mx3/mach-qong.c
@@ -270,9 +270,10 @@ static struct sys_timer qong_timer = {
 
 MACHINE_START(QONG, "Dave/DENX QongEVB-LITE")
 	/* Maintainer: DENX Software Engineering GmbH */
-	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
-	.map_io         = mx31_map_io,
-	.init_irq       = mx31_init_irq,
-	.init_machine   = mxc_board_init,
-	.timer          = &qong_timer,
+	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.map_io = mx31_map_io,
+	.init_early = imx31_init_early,
+	.init_irq = mx31_init_irq,
+	.timer = &qong_timer,
+	.init_machine = mxc_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx3/mach-vpr200.c b/arch/arm/mach-mx3/mach-vpr200.c
index 22ec78a..2cf390f 100644
--- a/arch/arm/mach-mx3/mach-vpr200.c
+++ b/arch/arm/mach-mx3/mach-vpr200.c
@@ -320,8 +320,9 @@ struct sys_timer vpr200_timer = {
 
 MACHINE_START(VPR200, "VPR200")
 	/* Maintainer: Creative Product Design */
-	.map_io         = mx35_map_io,
-	.init_irq       = mx35_init_irq,
-	.init_machine   = vpr200_board_init,
-	.timer          = &vpr200_timer,
+	.map_io = mx35_map_io,
+	.init_early = imx35_init_early,
+	.init_irq = mx35_init_irq,
+	.timer = &vpr200_timer,
+	.init_machine = vpr200_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx3/mm.c b/arch/arm/mach-mx3/mm.c
index 47118f7..3387319 100644
--- a/arch/arm/mach-mx3/mm.c
+++ b/arch/arm/mach-mx3/mm.c
@@ -52,10 +52,13 @@ static struct map_desc mx31_io_desc[] __initdata = {
  */
 void __init mx31_map_io(void)
 {
+	iotable_init(mx31_io_desc, ARRAY_SIZE(mx31_io_desc));
+}
+
+void __init imx31_init_early(void)
+{
 	mxc_set_cpu_type(MXC_CPU_MX31);
 	mxc_arch_reset_init(MX31_IO_ADDRESS(MX31_WDOG_BASE_ADDR));
-
-	iotable_init(mx31_io_desc, ARRAY_SIZE(mx31_io_desc));
 }
 
 int imx31_register_gpios(void);
@@ -77,11 +80,14 @@ static struct map_desc mx35_io_desc[] __initdata = {
 
 void __init mx35_map_io(void)
 {
+	iotable_init(mx35_io_desc, ARRAY_SIZE(mx35_io_desc));
+}
+
+void __init imx35_init_early(void)
+{
 	mxc_set_cpu_type(MXC_CPU_MX35);
 	mxc_iomux_v3_init(MX35_IO_ADDRESS(MX35_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX35_IO_ADDRESS(MX35_WDOG_BASE_ADDR));
-
-	iotable_init(mx35_io_desc, ARRAY_SIZE(mx35_io_desc));
 }
 
 int imx35_register_gpios(void);
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index e4f1de0..857eebf47 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -28,6 +28,9 @@ extern void imx1_init_early(void);
 extern void imx21_init_early(void);
 extern void imx25_init_early(void);
 extern void imx27_init_early(void);
+extern void imx31_init_early(void);
+extern void imx35_init_early(void);
+extern void imx50_init_early(void);
 extern void mxc_init_irq(void __iomem *);
 extern void tzic_init_irq(void __iomem *);
 extern void mx1_init_irq(void);
-- 
1.7.2.3
