From: robherring2@gmail.com (Rob Herring)
Date: Thu,  3 Jan 2013 11:54:22 -0600
Subject: [PATCH v4 13/19] ARM: remove mach .handle_irq for VIC users
In-Reply-To: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
Message-ID: <1357235668-9450-14-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Now that the VIC initialization sets up the handle_arch_irq pointer, we
can remove it for all machines and make it static.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Hubert Feurstein <hubert.feurstein@contec.at>
Cc: Alessandro Rubini <rubini@unipv.it>
Cc: STEricsson <STEricsson_nomadik_linux@list.st.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Shiraz Hashim <shiraz.hashim@st.com>
Cc: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Acked-by: Jamie Iles <jamie@jamieiles.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>
Acked-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/common/vic.c                  |    4 +++-
 arch/arm/include/asm/hardware/vic.h    |    1 -
 arch/arm/mach-ep93xx/adssphere.c       |    1 -
 arch/arm/mach-ep93xx/edb93xx.c         |    8 --------
 arch/arm/mach-ep93xx/gesbc9312.c       |    1 -
 arch/arm/mach-ep93xx/micro9.c          |    4 ----
 arch/arm/mach-ep93xx/simone.c          |    1 -
 arch/arm/mach-ep93xx/snappercl15.c     |    1 -
 arch/arm/mach-ep93xx/ts72xx.c          |    1 -
 arch/arm/mach-ep93xx/vision_ep9307.c   |    1 -
 arch/arm/mach-netx/nxdb500.c           |    1 -
 arch/arm/mach-netx/nxdkn.c             |    1 -
 arch/arm/mach-netx/nxeb500hmi.c        |    1 -
 arch/arm/mach-nomadik/board-nhk8815.c  |    1 -
 arch/arm/mach-picoxcell/common.c       |    1 -
 arch/arm/mach-s3c64xx/mach-anw6410.c   |    1 -
 arch/arm/mach-s3c64xx/mach-crag6410.c  |    1 -
 arch/arm/mach-s3c64xx/mach-hmt.c       |    1 -
 arch/arm/mach-s3c64xx/mach-mini6410.c  |    1 -
 arch/arm/mach-s3c64xx/mach-ncp.c       |    1 -
 arch/arm/mach-s3c64xx/mach-real6410.c  |    1 -
 arch/arm/mach-s3c64xx/mach-smartq5.c   |    1 -
 arch/arm/mach-s3c64xx/mach-smartq7.c   |    1 -
 arch/arm/mach-s3c64xx/mach-smdk6400.c  |    1 -
 arch/arm/mach-s3c64xx/mach-smdk6410.c  |    1 -
 arch/arm/mach-s5p64x0/mach-smdk6440.c  |    1 -
 arch/arm/mach-s5p64x0/mach-smdk6450.c  |    1 -
 arch/arm/mach-s5pc100/mach-smdkc100.c  |    1 -
 arch/arm/mach-s5pv210/mach-aquila.c    |    1 -
 arch/arm/mach-s5pv210/mach-goni.c      |    1 -
 arch/arm/mach-s5pv210/mach-smdkc110.c  |    1 -
 arch/arm/mach-s5pv210/mach-smdkv210.c  |    1 -
 arch/arm/mach-s5pv210/mach-torbreck.c  |    1 -
 arch/arm/mach-spear3xx/spear300.c      |    2 --
 arch/arm/mach-spear3xx/spear310.c      |    2 --
 arch/arm/mach-spear3xx/spear320.c      |    2 --
 arch/arm/mach-spear6xx/spear6xx.c      |    1 -
 arch/arm/mach-u300/core.c              |    1 -
 arch/arm/mach-versatile/versatile_ab.c |    1 -
 arch/arm/mach-versatile/versatile_dt.c |    1 -
 arch/arm/mach-versatile/versatile_pb.c |    1 -
 41 files changed, 3 insertions(+), 54 deletions(-)

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index 6894df1..d5ee437 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -83,6 +83,8 @@ static struct vic_device vic_devices[CONFIG_ARM_VIC_NR];
 
 static int vic_id;
 
+static void vic_handle_irq(struct pt_regs *regs);
+
 /**
  * vic_init2 - common initialisation code
  * @base: Base of the VIC.
@@ -466,7 +468,7 @@ static int handle_one_vic(struct vic_device *vic, struct pt_regs *regs)
  * Keep iterating over all registered VIC's until there are no pending
  * interrupts.
  */
-asmlinkage void __exception_irq_entry vic_handle_irq(struct pt_regs *regs)
+static asmlinkage void __exception_irq_entry vic_handle_irq(struct pt_regs *regs)
 {
 	int i, handled;
 
diff --git a/arch/arm/include/asm/hardware/vic.h b/arch/arm/include/asm/hardware/vic.h
index a44ef71..de7aad1 100644
--- a/arch/arm/include/asm/hardware/vic.h
+++ b/arch/arm/include/asm/hardware/vic.h
@@ -33,6 +33,5 @@ void __vic_init(void __iomem *base, int irq_start, u32 vic_sources,
 		u32 resume_sources, struct device_node *node);
 void vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources, u32 resume_sources);
 int vic_of_init(struct device_node *node, struct device_node *parent);
-void vic_handle_irq(struct pt_regs *regs);
 
 #endif
diff --git a/arch/arm/mach-ep93xx/adssphere.c b/arch/arm/mach-ep93xx/adssphere.c
index 41383bf..03f793e 100644
--- a/arch/arm/mach-ep93xx/adssphere.c
+++ b/arch/arm/mach-ep93xx/adssphere.c
@@ -39,7 +39,6 @@ MACHINE_START(ADSSPHERE, "ADS Sphere board")
 	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= adssphere_init_machine,
 	.init_late	= ep93xx_init_late,
diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index b8f53d5..4423a1e 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -276,7 +276,6 @@ MACHINE_START(EDB9301, "Cirrus Logic EDB9301 Evaluation Board")
 	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
 	.init_late	= ep93xx_init_late,
@@ -290,7 +289,6 @@ MACHINE_START(EDB9302, "Cirrus Logic EDB9302 Evaluation Board")
 	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
 	.init_late	= ep93xx_init_late,
@@ -304,7 +302,6 @@ MACHINE_START(EDB9302A, "Cirrus Logic EDB9302A Evaluation Board")
 	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
 	.init_late	= ep93xx_init_late,
@@ -318,7 +315,6 @@ MACHINE_START(EDB9307, "Cirrus Logic EDB9307 Evaluation Board")
 	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
 	.init_late	= ep93xx_init_late,
@@ -332,7 +328,6 @@ MACHINE_START(EDB9307A, "Cirrus Logic EDB9307A Evaluation Board")
 	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
 	.init_late	= ep93xx_init_late,
@@ -346,7 +341,6 @@ MACHINE_START(EDB9312, "Cirrus Logic EDB9312 Evaluation Board")
 	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
 	.init_late	= ep93xx_init_late,
@@ -360,7 +354,6 @@ MACHINE_START(EDB9315, "Cirrus Logic EDB9315 Evaluation Board")
 	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
 	.init_late	= ep93xx_init_late,
@@ -374,7 +367,6 @@ MACHINE_START(EDB9315A, "Cirrus Logic EDB9315A Evaluation Board")
 	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
 	.init_late	= ep93xx_init_late,
diff --git a/arch/arm/mach-ep93xx/gesbc9312.c b/arch/arm/mach-ep93xx/gesbc9312.c
index 7fd705b..6df752f 100644
--- a/arch/arm/mach-ep93xx/gesbc9312.c
+++ b/arch/arm/mach-ep93xx/gesbc9312.c
@@ -39,7 +39,6 @@ MACHINE_START(GESBC9312, "Glomation GESBC-9312-sx")
 	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= gesbc9312_init_machine,
 	.init_late	= ep93xx_init_late,
diff --git a/arch/arm/mach-ep93xx/micro9.c b/arch/arm/mach-ep93xx/micro9.c
index 3d7cdab..6a66cda 100644
--- a/arch/arm/mach-ep93xx/micro9.c
+++ b/arch/arm/mach-ep93xx/micro9.c
@@ -82,7 +82,6 @@ MACHINE_START(MICRO9, "Contec Micro9-High")
 	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= micro9_init_machine,
 	.init_late	= ep93xx_init_late,
@@ -96,7 +95,6 @@ MACHINE_START(MICRO9M, "Contec Micro9-Mid")
 	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= micro9_init_machine,
 	.init_late	= ep93xx_init_late,
@@ -110,7 +108,6 @@ MACHINE_START(MICRO9L, "Contec Micro9-Lite")
 	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= micro9_init_machine,
 	.init_late	= ep93xx_init_late,
@@ -124,7 +121,6 @@ MACHINE_START(MICRO9S, "Contec Micro9-Slim")
 	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= micro9_init_machine,
 	.init_late	= ep93xx_init_late,
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index 0eb3f17..a5dba8f 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -83,7 +83,6 @@ MACHINE_START(SIM_ONE, "Simplemachines Sim.One Board")
 	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= simone_init_machine,
 	.init_late	= ep93xx_init_late,
diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index 50043ee..6be24c0 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -176,7 +176,6 @@ MACHINE_START(SNAPPER_CL15, "Bluewater Systems Snapper CL15")
 	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer 		= &ep93xx_timer,
 	.init_machine	= snappercl15_init_machine,
 	.init_late	= ep93xx_init_late,
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 3c4c233..66703f7 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -246,7 +246,6 @@ MACHINE_START(TS72XX, "Technologic Systems TS-72xx SBC")
 	.atag_offset	= 0x100,
 	.map_io		= ts72xx_map_io,
 	.init_irq	= ep93xx_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= ts72xx_init_machine,
 	.init_late	= ep93xx_init_late,
diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
index ba92e25..88303a2 100644
--- a/arch/arm/mach-ep93xx/vision_ep9307.c
+++ b/arch/arm/mach-ep93xx/vision_ep9307.c
@@ -364,7 +364,6 @@ MACHINE_START(VISION_EP9307, "Vision Engraving Systems EP9307")
 	.atag_offset	= 0x100,
 	.map_io		= vision_map_io,
 	.init_irq	= ep93xx_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= vision_init_machine,
 	.init_late	= ep93xx_init_late,
diff --git a/arch/arm/mach-netx/nxdb500.c b/arch/arm/mach-netx/nxdb500.c
index 8b781ff..fe40c52 100644
--- a/arch/arm/mach-netx/nxdb500.c
+++ b/arch/arm/mach-netx/nxdb500.c
@@ -204,7 +204,6 @@ MACHINE_START(NXDB500, "Hilscher nxdb500")
 	.atag_offset	= 0x100,
 	.map_io		= netx_map_io,
 	.init_irq	= netx_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &netx_timer,
 	.init_machine	= nxdb500_init,
 	.restart	= netx_restart,
diff --git a/arch/arm/mach-netx/nxdkn.c b/arch/arm/mach-netx/nxdkn.c
index b26dbce..e09d0d4 100644
--- a/arch/arm/mach-netx/nxdkn.c
+++ b/arch/arm/mach-netx/nxdkn.c
@@ -97,7 +97,6 @@ MACHINE_START(NXDKN, "Hilscher nxdkn")
 	.atag_offset	= 0x100,
 	.map_io		= netx_map_io,
 	.init_irq	= netx_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &netx_timer,
 	.init_machine	= nxdkn_init,
 	.restart	= netx_restart,
diff --git a/arch/arm/mach-netx/nxeb500hmi.c b/arch/arm/mach-netx/nxeb500hmi.c
index 257382e..169172b 100644
--- a/arch/arm/mach-netx/nxeb500hmi.c
+++ b/arch/arm/mach-netx/nxeb500hmi.c
@@ -181,7 +181,6 @@ MACHINE_START(NXEB500HMI, "Hilscher nxeb500hmi")
 	.atag_offset	= 0x100,
 	.map_io		= netx_map_io,
 	.init_irq	= netx_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &netx_timer,
 	.init_machine	= nxeb500hmi_init,
 	.restart	= netx_restart,
diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index 98167a4..9c15879 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -353,7 +353,6 @@ MACHINE_START(NOMADIK, "NHK8815")
 	.atag_offset	= 0x100,
 	.map_io		= cpu8815_map_io,
 	.init_irq	= cpu8815_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &nomadik_timer,
 	.init_machine	= nhk8815_platform_init,
 	.restart	= cpu8815_restart,
diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
index f6c0849..b17401ac 100644
--- a/arch/arm/mach-picoxcell/common.c
+++ b/arch/arm/mach-picoxcell/common.c
@@ -98,7 +98,6 @@ DT_MACHINE_START(PICOXCELL, "Picochip picoXcell")
 	.map_io		= picoxcell_map_io,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= picoxcell_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &dw_apb_timer,
 	.init_machine	= picoxcell_init_machine,
 	.dt_compat	= picoxcell_dt_match,
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index 99e82ac..94c9e8a 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -230,7 +230,6 @@ MACHINE_START(ANW6410, "A&W6410")
 	.atag_offset	= 0x100,
 
 	.init_irq	= s3c6410_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.map_io		= anw6410_map_io,
 	.init_machine	= anw6410_machine_init,
 	.init_late	= s3c64xx_init_late,
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index cdde249..29bfec2 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -867,7 +867,6 @@ MACHINE_START(WLF_CRAGG_6410, "Wolfson Cragganmore 6410")
 	/* Maintainer: Mark Brown <broonie@opensource.wolfsonmicro.com> */
 	.atag_offset	= 0x100,
 	.init_irq	= s3c6410_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.map_io		= crag6410_map_io,
 	.init_machine	= crag6410_machine_init,
 	.init_late	= s3c64xx_init_late,
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index 2b14489..052c459 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -273,7 +273,6 @@ MACHINE_START(HMT, "Airgoo-HMT")
 	/* Maintainer: Peter Korsgaard <jacmet@sunsite.dk> */
 	.atag_offset	= 0x100,
 	.init_irq	= s3c6410_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.map_io		= hmt_map_io,
 	.init_machine	= hmt_machine_init,
 	.init_late	= s3c64xx_init_late,
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index 07c349c..b5635fe 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -352,7 +352,6 @@ MACHINE_START(MINI6410, "MINI6410")
 	/* Maintainer: Darius Augulis <augulis.darius@gmail.com> */
 	.atag_offset	= 0x100,
 	.init_irq	= s3c6410_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.map_io		= mini6410_map_io,
 	.init_machine	= mini6410_machine_init,
 	.init_late	= s3c64xx_init_late,
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
index e5f9a79..08a445c 100644
--- a/arch/arm/mach-s3c64xx/mach-ncp.c
+++ b/arch/arm/mach-s3c64xx/mach-ncp.c
@@ -101,7 +101,6 @@ MACHINE_START(NCP, "NCP")
 	/* Maintainer: Samsung Electronics */
 	.atag_offset	= 0x100,
 	.init_irq	= s3c6410_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.map_io		= ncp_map_io,
 	.init_machine	= ncp_machine_init,
 	.init_late	= s3c64xx_init_late,
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index 7476f7c..5980c18 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -331,7 +331,6 @@ MACHINE_START(REAL6410, "REAL6410")
 	.atag_offset	= 0x100,
 
 	.init_irq	= s3c6410_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.map_io		= real6410_map_io,
 	.init_machine	= real6410_machine_init,
 	.init_late	= s3c64xx_init_late,
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index 96d6da2..28f3303 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -153,7 +153,6 @@ MACHINE_START(SMARTQ5, "SmartQ 5")
 	/* Maintainer: Maurus Cuelenaere <mcuelenaere AT gmail DOT com> */
 	.atag_offset	= 0x100,
 	.init_irq	= s3c6410_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.map_io		= smartq_map_io,
 	.init_machine	= smartq5_machine_init,
 	.init_late	= s3c64xx_init_late,
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index 7d1167b..2d8a5d5 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -169,7 +169,6 @@ MACHINE_START(SMARTQ7, "SmartQ 7")
 	/* Maintainer: Maurus Cuelenaere <mcuelenaere AT gmail DOT com> */
 	.atag_offset	= 0x100,
 	.init_irq	= s3c6410_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.map_io		= smartq_map_io,
 	.init_machine	= smartq7_machine_init,
 	.init_late	= s3c64xx_init_late,
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index a928fae..9de7c26 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -90,7 +90,6 @@ MACHINE_START(SMDK6400, "SMDK6400")
 	.atag_offset	= 0x100,
 
 	.init_irq	= s3c6400_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.map_io		= smdk6400_map_io,
 	.init_machine	= smdk6400_machine_init,
 	.init_late	= s3c64xx_init_late,
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 574a9ee..65fea58 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -700,7 +700,6 @@ MACHINE_START(SMDK6410, "SMDK6410")
 	.atag_offset	= 0x100,
 
 	.init_irq	= s3c6410_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.map_io		= smdk6410_map_io,
 	.init_machine	= smdk6410_machine_init,
 	.init_late	= s3c64xx_init_late,
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index 1af8235..7b752ac 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -272,7 +272,6 @@ MACHINE_START(SMDK6440, "SMDK6440")
 	.atag_offset	= 0x100,
 
 	.init_irq	= s5p6440_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.map_io		= smdk6440_map_io,
 	.init_machine	= smdk6440_machine_init,
 	.timer		= &s5p_timer,
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index 62526cc..97585f3 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
@@ -291,7 +291,6 @@ MACHINE_START(SMDK6450, "SMDK6450")
 	.atag_offset	= 0x100,
 
 	.init_irq	= s5p6450_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.map_io		= smdk6450_map_io,
 	.init_machine	= smdk6450_machine_init,
 	.timer		= &s5p_timer,
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index 9abe95e..99686de 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -254,7 +254,6 @@ MACHINE_START(SMDKC100, "SMDKC100")
 	/* Maintainer: Byungho Min <bhmin@samsung.com> */
 	.atag_offset	= 0x100,
 	.init_irq	= s5pc100_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.map_io		= smdkc100_map_io,
 	.init_machine	= smdkc100_machine_init,
 	.timer		= &s3c24xx_timer,
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index ee9fa5c..1cba073 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -685,7 +685,6 @@ MACHINE_START(AQUILA, "Aquila")
 	   Kyungmin Park <kyungmin.park@samsung.com> */
 	.atag_offset	= 0x100,
 	.init_irq	= s5pv210_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.map_io		= aquila_map_io,
 	.init_machine	= aquila_machine_init,
 	.timer		= &s5p_timer,
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index c72b310..8f26d53 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -972,7 +972,6 @@ MACHINE_START(GONI, "GONI")
 	/* Maintainers: Kyungmin Park <kyungmin.park@samsung.com> */
 	.atag_offset	= 0x100,
 	.init_irq	= s5pv210_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.map_io		= goni_map_io,
 	.init_machine	= goni_machine_init,
 	.timer		= &s5p_timer,
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index f1f3bd3..7fa0221 100644
--- a/arch/arm/mach-s5pv210/mach-smdkc110.c
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -152,7 +152,6 @@ MACHINE_START(SMDKC110, "SMDKC110")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	.atag_offset	= 0x100,
 	.init_irq	= s5pv210_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.map_io		= smdkc110_map_io,
 	.init_machine	= smdkc110_machine_init,
 	.timer		= &s5p_timer,
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index 6bc8404..ebf31ee 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -328,7 +328,6 @@ MACHINE_START(SMDKV210, "SMDKV210")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	.atag_offset	= 0x100,
 	.init_irq	= s5pv210_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.map_io		= smdkv210_map_io,
 	.init_machine	= smdkv210_machine_init,
 	.timer		= &s5p_timer,
diff --git a/arch/arm/mach-s5pv210/mach-torbreck.c b/arch/arm/mach-s5pv210/mach-torbreck.c
index 18785cb..8936018 100644
--- a/arch/arm/mach-s5pv210/mach-torbreck.c
+++ b/arch/arm/mach-s5pv210/mach-torbreck.c
@@ -129,7 +129,6 @@ MACHINE_START(TORBRECK, "TORBRECK")
 	/* Maintainer: Hyunchul Ko <ghcstop@gmail.com> */
 	.atag_offset	= 0x100,
 	.init_irq	= s5pv210_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.map_io		= torbreck_map_io,
 	.init_machine	= torbreck_machine_init,
 	.timer		= &s5p_timer,
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index a69cbfd..7a11d85 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -15,7 +15,6 @@
 
 #include <linux/amba/pl08x.h>
 #include <linux/of_platform.h>
-#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
@@ -213,7 +212,6 @@ static void __init spear300_map_io(void)
 DT_MACHINE_START(SPEAR300_DT, "ST SPEAr300 SoC with Flattened Device Tree")
 	.map_io		=	spear300_map_io,
 	.init_irq	=	spear3xx_dt_init_irq,
-	.handle_irq	=	vic_handle_irq,
 	.timer		=	&spear3xx_timer,
 	.init_machine	=	spear300_dt_init,
 	.restart	=	spear_restart,
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index b963ebb..9719f83 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -16,7 +16,6 @@
 #include <linux/amba/pl08x.h>
 #include <linux/amba/serial.h>
 #include <linux/of_platform.h>
-#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
@@ -255,7 +254,6 @@ static void __init spear310_map_io(void)
 DT_MACHINE_START(SPEAR310_DT, "ST SPEAr310 SoC with Flattened Device Tree")
 	.map_io		=	spear310_map_io,
 	.init_irq	=	spear3xx_dt_init_irq,
-	.handle_irq	=	vic_handle_irq,
 	.timer		=	&spear3xx_timer,
 	.init_machine	=	spear310_dt_init,
 	.restart	=	spear_restart,
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 66e3a0c..3a22d842 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -17,7 +17,6 @@
 #include <linux/amba/pl08x.h>
 #include <linux/amba/serial.h>
 #include <linux/of_platform.h>
-#include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
@@ -269,7 +268,6 @@ static void __init spear320_map_io(void)
 DT_MACHINE_START(SPEAR320_DT, "ST SPEAr320 SoC with Flattened Device Tree")
 	.map_io		=	spear320_map_io,
 	.init_irq	=	spear3xx_dt_init_irq,
-	.handle_irq	=	vic_handle_irq,
 	.timer		=	&spear3xx_timer,
 	.init_machine	=	spear320_dt_init,
 	.restart	=	spear_restart,
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index 5a5a52d..9d81068 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -438,7 +438,6 @@ static void __init spear6xx_dt_init_irq(void)
 DT_MACHINE_START(SPEAR600_DT, "ST SPEAr600 (Flattened Device Tree)")
 	.map_io		=	spear6xx_map_io,
 	.init_irq	=	spear6xx_dt_init_irq,
-	.handle_irq	=	vic_handle_irq,
 	.timer		=	&spear6xx_timer,
 	.init_machine	=	spear600_dt_init,
 	.restart	=	spear_restart,
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 4ce77cd..a9d3bcf 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -1779,7 +1779,6 @@ MACHINE_START(U300, "Ericsson AB U335 S335/B335 Prototype Board")
 	.map_io		= u300_map_io,
 	.nr_irqs	= 0,
 	.init_irq	= u300_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &u300_timer,
 	.init_machine	= u300_init_machine,
 	.restart	= u300_restart,
diff --git a/arch/arm/mach-versatile/versatile_ab.c b/arch/arm/mach-versatile/versatile_ab.c
index 98f6549..886d976 100644
--- a/arch/arm/mach-versatile/versatile_ab.c
+++ b/arch/arm/mach-versatile/versatile_ab.c
@@ -39,7 +39,6 @@ MACHINE_START(VERSATILE_AB, "ARM-Versatile AB")
 	.map_io		= versatile_map_io,
 	.init_early	= versatile_init_early,
 	.init_irq	= versatile_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &versatile_timer,
 	.init_machine	= versatile_init,
 	.restart	= versatile_restart,
diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile_dt.c
index ae5ad3c..17782cd 100644
--- a/arch/arm/mach-versatile/versatile_dt.c
+++ b/arch/arm/mach-versatile/versatile_dt.c
@@ -46,7 +46,6 @@ DT_MACHINE_START(VERSATILE_PB, "ARM-Versatile (Device Tree Support)")
 	.map_io		= versatile_map_io,
 	.init_early	= versatile_init_early,
 	.init_irq	= versatile_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &versatile_timer,
 	.init_machine	= versatile_dt_init,
 	.dt_compat	= versatile_dt_match,
diff --git a/arch/arm/mach-versatile/versatile_pb.c b/arch/arm/mach-versatile/versatile_pb.c
index 1973833..4119320 100644
--- a/arch/arm/mach-versatile/versatile_pb.c
+++ b/arch/arm/mach-versatile/versatile_pb.c
@@ -107,7 +107,6 @@ MACHINE_START(VERSATILE_PB, "ARM-Versatile PB")
 	.map_io		= versatile_map_io,
 	.init_early	= versatile_init_early,
 	.init_irq	= versatile_init_irq,
-	.handle_irq	= vic_handle_irq,
 	.timer		= &versatile_timer,
 	.init_machine	= versatile_pb_init,
 	.restart	= versatile_restart,
-- 
1.7.10.4
