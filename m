From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 11 May 2014 11:35:57 +0400
Subject: [PATCH] ARM: i.MX: Setup IRQ handler from IRQ driver
Message-ID: <1399793757-14453-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves IRQ handler setup to the its corresponded IRQ
driver (AVIC, TZIC).

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/avic.c                    |  4 +++-
 arch/arm/mach-imx/common.h                  | 13 -------------
 arch/arm/mach-imx/imx25-dt.c                |  1 -
 arch/arm/mach-imx/imx27-dt.c                |  1 -
 arch/arm/mach-imx/imx31-dt.c                |  1 -
 arch/arm/mach-imx/imx35-dt.c                |  1 -
 arch/arm/mach-imx/imx51-dt.c                |  1 -
 arch/arm/mach-imx/mach-apf9328.c            |  1 -
 arch/arm/mach-imx/mach-armadillo5x0.c       |  1 -
 arch/arm/mach-imx/mach-bug.c                |  1 -
 arch/arm/mach-imx/mach-cpuimx27.c           |  1 -
 arch/arm/mach-imx/mach-cpuimx35.c           |  1 -
 arch/arm/mach-imx/mach-cpuimx51sd.c         |  1 -
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c    |  1 -
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |  1 -
 arch/arm/mach-imx/mach-imx27ipcam.c         |  1 -
 arch/arm/mach-imx/mach-imx27lite.c          |  1 -
 arch/arm/mach-imx/mach-imx50.c              |  1 -
 arch/arm/mach-imx/mach-imx53.c              |  1 -
 arch/arm/mach-imx/mach-kzm_arm11_01.c       |  1 -
 arch/arm/mach-imx/mach-mx1ads.c             |  2 --
 arch/arm/mach-imx/mach-mx21ads.c            |  1 -
 arch/arm/mach-imx/mach-mx25_3ds.c           |  1 -
 arch/arm/mach-imx/mach-mx27_3ds.c           |  1 -
 arch/arm/mach-imx/mach-mx27ads.c            |  1 -
 arch/arm/mach-imx/mach-mx31_3ds.c           |  1 -
 arch/arm/mach-imx/mach-mx31ads.c            |  1 -
 arch/arm/mach-imx/mach-mx31lilly.c          |  1 -
 arch/arm/mach-imx/mach-mx31lite.c           |  1 -
 arch/arm/mach-imx/mach-mx31moboard.c        |  1 -
 arch/arm/mach-imx/mach-mx35_3ds.c           |  1 -
 arch/arm/mach-imx/mach-mxt_td60.c           |  1 -
 arch/arm/mach-imx/mach-pca100.c             |  1 -
 arch/arm/mach-imx/mach-pcm037.c             |  1 -
 arch/arm/mach-imx/mach-pcm038.c             |  1 -
 arch/arm/mach-imx/mach-pcm043.c             |  1 -
 arch/arm/mach-imx/mach-qong.c               |  1 -
 arch/arm/mach-imx/mach-scb9328.c            |  1 -
 arch/arm/mach-imx/mach-vpr200.c             |  1 -
 arch/arm/mach-imx/tzic.c                    |  4 +++-
 40 files changed, 6 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-imx/avic.c b/arch/arm/mach-imx/avic.c
index 8d1df2e..24b103c 100644
--- a/arch/arm/mach-imx/avic.c
+++ b/arch/arm/mach-imx/avic.c
@@ -135,7 +135,7 @@ static __init void avic_init_gc(int idx, unsigned int irq_start)
 	irq_setup_generic_chip(gc, IRQ_MSK(32), 0, IRQ_NOREQUEST, 0);
 }
 
-asmlinkage void __exception_irq_entry avic_handle_irq(struct pt_regs *regs)
+static void __exception_irq_entry avic_handle_irq(struct pt_regs *regs)
 {
 	u32 nivector;
 
@@ -190,6 +190,8 @@ void __init mxc_init_irq(void __iomem *irqbase)
 	for (i = 0; i < 8; i++)
 		__raw_writel(0, avic_base + AVIC_NIPRIORITY(i));
 
+	set_handle_irq(avic_handle_irq);
+
 #ifdef CONFIG_FIQ
 	/* Initialize FIQ */
 	init_FIQ(FIQ_START);
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 4facd01..9ab785c 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -101,19 +101,6 @@ enum mx3_cpu_pwr_mode {
 void mx3_cpu_lp_set(enum mx3_cpu_pwr_mode mode);
 void imx_print_silicon_rev(const char *cpu, int srev);
 
-void avic_handle_irq(struct pt_regs *);
-void tzic_handle_irq(struct pt_regs *);
-
-#define imx1_handle_irq avic_handle_irq
-#define imx21_handle_irq avic_handle_irq
-#define imx25_handle_irq avic_handle_irq
-#define imx27_handle_irq avic_handle_irq
-#define imx31_handle_irq avic_handle_irq
-#define imx35_handle_irq avic_handle_irq
-#define imx50_handle_irq tzic_handle_irq
-#define imx51_handle_irq tzic_handle_irq
-#define imx53_handle_irq tzic_handle_irq
-
 void imx_enable_cpu(int cpu, bool enable);
 void imx_set_cpu_jump(int cpu, void *jump_addr);
 u32 imx_get_cpu_arg(int cpu);
diff --git a/arch/arm/mach-imx/imx25-dt.c b/arch/arm/mach-imx/imx25-dt.c
index 3e1ec5f..42a65e0 100644
--- a/arch/arm/mach-imx/imx25-dt.c
+++ b/arch/arm/mach-imx/imx25-dt.c
@@ -38,7 +38,6 @@ DT_MACHINE_START(IMX25_DT, "Freescale i.MX25 (Device Tree Support)")
 	.map_io		= mx25_map_io,
 	.init_early	= imx25_init_early,
 	.init_irq	= mx25_init_irq,
-	.handle_irq	= imx25_handle_irq,
 	.init_time	= imx25_timer_init,
 	.init_machine	= imx25_dt_init,
 	.dt_compat	= imx25_dt_board_compat,
diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
index 4e235ec..17bd405 100644
--- a/arch/arm/mach-imx/imx27-dt.c
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -43,7 +43,6 @@ DT_MACHINE_START(IMX27_DT, "Freescale i.MX27 (Device Tree Support)")
 	.map_io		= mx27_map_io,
 	.init_early	= imx27_init_early,
 	.init_irq	= mx27_init_irq,
-	.handle_irq	= imx27_handle_irq,
 	.init_time	= imx27_timer_init,
 	.init_machine	= imx27_dt_init,
 	.dt_compat	= imx27_dt_board_compat,
diff --git a/arch/arm/mach-imx/imx31-dt.c b/arch/arm/mach-imx/imx31-dt.c
index e1e70ef..581f4d6 100644
--- a/arch/arm/mach-imx/imx31-dt.c
+++ b/arch/arm/mach-imx/imx31-dt.c
@@ -39,7 +39,6 @@ DT_MACHINE_START(IMX31_DT, "Freescale i.MX31 (Device Tree Support)")
 	.map_io		= mx31_map_io,
 	.init_early	= imx31_init_early,
 	.init_irq	= mx31_init_irq,
-	.handle_irq	= imx31_handle_irq,
 	.init_time	= imx31_dt_timer_init,
 	.init_machine	= imx31_dt_init,
 	.dt_compat	= imx31_dt_board_compat,
diff --git a/arch/arm/mach-imx/imx35-dt.c b/arch/arm/mach-imx/imx35-dt.c
index 9d48e00..a62854c 100644
--- a/arch/arm/mach-imx/imx35-dt.c
+++ b/arch/arm/mach-imx/imx35-dt.c
@@ -43,7 +43,6 @@ DT_MACHINE_START(IMX35_DT, "Freescale i.MX35 (Device Tree Support)")
 	.map_io		= mx35_map_io,
 	.init_early	= imx35_init_early,
 	.init_irq	= imx35_irq_init,
-	.handle_irq	= imx35_handle_irq,
 	.init_machine	= imx35_dt_init,
 	.dt_compat	= imx35_dt_board_compat,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
index 0230d78..b8cd968 100644
--- a/arch/arm/mach-imx/imx51-dt.c
+++ b/arch/arm/mach-imx/imx51-dt.c
@@ -38,7 +38,6 @@ DT_MACHINE_START(IMX51_DT, "Freescale i.MX51 (Device Tree Support)")
 	.map_io		= mx51_map_io,
 	.init_early	= imx51_init_early,
 	.init_irq	= mx51_init_irq,
-	.handle_irq	= imx51_handle_irq,
 	.init_machine	= imx51_dt_init,
 	.init_late	= imx51_init_late,
 	.dt_compat	= imx51_dt_board_compat,
diff --git a/arch/arm/mach-imx/mach-apf9328.c b/arch/arm/mach-imx/mach-apf9328.c
index 067580b..ebbb5ab 100644
--- a/arch/arm/mach-imx/mach-apf9328.c
+++ b/arch/arm/mach-imx/mach-apf9328.c
@@ -142,7 +142,6 @@ MACHINE_START(APF9328, "Armadeus APF9328")
 	.map_io       = mx1_map_io,
 	.init_early   = imx1_init_early,
 	.init_irq     = mx1_init_irq,
-	.handle_irq   = imx1_handle_irq,
 	.init_time	= apf9328_timer_init,
 	.init_machine = apf9328_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-armadillo5x0.c b/arch/arm/mach-imx/mach-armadillo5x0.c
index 58b864a..39406b7 100644
--- a/arch/arm/mach-imx/mach-armadillo5x0.c
+++ b/arch/arm/mach-imx/mach-armadillo5x0.c
@@ -562,7 +562,6 @@ MACHINE_START(ARMADILLO5X0, "Armadillo-500")
 	.map_io = mx31_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
-	.handle_irq = imx31_handle_irq,
 	.init_time	= armadillo5x0_timer_init,
 	.init_machine = armadillo5x0_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-bug.c b/arch/arm/mach-imx/mach-bug.c
index 2d00476..c97d7cb 100644
--- a/arch/arm/mach-imx/mach-bug.c
+++ b/arch/arm/mach-imx/mach-bug.c
@@ -57,7 +57,6 @@ MACHINE_START(BUG, "BugLabs BUGBase")
 	.map_io = mx31_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
-	.handle_irq = imx31_handle_irq,
 	.init_time	= bug_timer_init,
 	.init_machine = bug_board_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index ea50870..75b7b6a 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -314,7 +314,6 @@ MACHINE_START(EUKREA_CPUIMX27, "EUKREA CPUIMX27")
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
-	.handle_irq = imx27_handle_irq,
 	.init_time	= eukrea_cpuimx27_timer_init,
 	.init_machine = eukrea_cpuimx27_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-cpuimx35.c b/arch/arm/mach-imx/mach-cpuimx35.c
index 65e4c53..1ffa271 100644
--- a/arch/arm/mach-imx/mach-cpuimx35.c
+++ b/arch/arm/mach-imx/mach-cpuimx35.c
@@ -199,7 +199,6 @@ MACHINE_START(EUKREA_CPUIMX35SD, "Eukrea CPUIMX35")
 	.map_io = mx35_map_io,
 	.init_early = imx35_init_early,
 	.init_irq = mx35_init_irq,
-	.handle_irq = imx35_handle_irq,
 	.init_time	= eukrea_cpuimx35_timer_init,
 	.init_machine = eukrea_cpuimx35_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-cpuimx51sd.c b/arch/arm/mach-imx/mach-cpuimx51sd.c
index 1fba2b8..ef9d8d3 100644
--- a/arch/arm/mach-imx/mach-cpuimx51sd.c
+++ b/arch/arm/mach-imx/mach-cpuimx51sd.c
@@ -356,7 +356,6 @@ MACHINE_START(EUKREA_CPUIMX51SD, "Eukrea CPUIMX51SD")
 	.map_io = mx51_map_io,
 	.init_early = imx51_init_early,
 	.init_irq = mx51_init_irq,
-	.handle_irq = imx51_handle_irq,
 	.init_time	= eukrea_cpuimx51sd_timer_init,
 	.init_machine = eukrea_cpuimx51sd_init,
 	.init_late	= imx51_init_late,
diff --git a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
index 4bf4544..e978dda 100644
--- a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
+++ b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
@@ -165,7 +165,6 @@ MACHINE_START(EUKREA_CPUIMX25SD, "Eukrea CPUIMX25")
 	.map_io = mx25_map_io,
 	.init_early = imx25_init_early,
 	.init_irq = mx25_init_irq,
-	.handle_irq = imx25_handle_irq,
 	.init_time = eukrea_cpuimx25_timer_init,
 	.init_machine = eukrea_cpuimx25_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 97f9c62..b61bd8e 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -604,7 +604,6 @@ MACHINE_START(IMX27_VISSTRIM_M10, "Vista Silicon Visstrim_M10")
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
-	.handle_irq = imx27_handle_irq,
 	.init_time	= visstrim_m10_timer_init,
 	.init_machine = visstrim_m10_board_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-imx27ipcam.c b/arch/arm/mach-imx/mach-imx27ipcam.c
index 1a851ae..bb3ca04 100644
--- a/arch/arm/mach-imx/mach-imx27ipcam.c
+++ b/arch/arm/mach-imx/mach-imx27ipcam.c
@@ -71,7 +71,6 @@ MACHINE_START(IMX27IPCAM, "Freescale IMX27IPCAM")
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
-	.handle_irq = imx27_handle_irq,
 	.init_time	= mx27ipcam_timer_init,
 	.init_machine = mx27ipcam_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-imx27lite.c b/arch/arm/mach-imx/mach-imx27lite.c
index 3da2e3e..9992089 100644
--- a/arch/arm/mach-imx/mach-imx27lite.c
+++ b/arch/arm/mach-imx/mach-imx27lite.c
@@ -77,7 +77,6 @@ MACHINE_START(IMX27LITE, "LogicPD i.MX27LITE")
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
-	.handle_irq = imx27_handle_irq,
 	.init_time	= mx27lite_timer_init,
 	.init_machine = mx27lite_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-imx50.c b/arch/arm/mach-imx/mach-imx50.c
index 77b77a9..b899c0b 100644
--- a/arch/arm/mach-imx/mach-imx50.c
+++ b/arch/arm/mach-imx/mach-imx50.c
@@ -31,7 +31,6 @@ static const char *imx50_dt_board_compat[] __initconst = {
 DT_MACHINE_START(IMX50_DT, "Freescale i.MX50 (Device Tree Support)")
 	.map_io		= mx53_map_io,
 	.init_irq	= mx53_init_irq,
-	.handle_irq	= imx50_handle_irq,
 	.init_machine	= imx50_dt_init,
 	.dt_compat	= imx50_dt_board_compat,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 6585090..2bad387 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -40,7 +40,6 @@ DT_MACHINE_START(IMX53_DT, "Freescale i.MX53 (Device Tree Support)")
 	.map_io		= mx53_map_io,
 	.init_early	= imx53_init_early,
 	.init_irq	= mx53_init_irq,
-	.handle_irq	= imx53_handle_irq,
 	.init_machine	= imx53_dt_init,
 	.init_late	= imx53_init_late,
 	.dt_compat	= imx53_dt_board_compat,
diff --git a/arch/arm/mach-imx/mach-kzm_arm11_01.c b/arch/arm/mach-imx/mach-kzm_arm11_01.c
index c7bc41d..31df436 100644
--- a/arch/arm/mach-imx/mach-kzm_arm11_01.c
+++ b/arch/arm/mach-imx/mach-kzm_arm11_01.c
@@ -289,7 +289,6 @@ MACHINE_START(KZM_ARM11_01, "Kyoto Microcomputer Co., Ltd. KZM-ARM11-01")
 	.map_io = kzm_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
-	.handle_irq = imx31_handle_irq,
 	.init_time	= kzm_timer_init,
 	.init_machine = kzm_board_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-mx1ads.c b/arch/arm/mach-imx/mach-mx1ads.c
index 9f883e4..77fda3d 100644
--- a/arch/arm/mach-imx/mach-mx1ads.c
+++ b/arch/arm/mach-imx/mach-mx1ads.c
@@ -138,7 +138,6 @@ MACHINE_START(MX1ADS, "Freescale MX1ADS")
 	.map_io = mx1_map_io,
 	.init_early = imx1_init_early,
 	.init_irq = mx1_init_irq,
-	.handle_irq = imx1_handle_irq,
 	.init_time	= mx1ads_timer_init,
 	.init_machine = mx1ads_init,
 	.restart	= mxc_restart,
@@ -149,7 +148,6 @@ MACHINE_START(MXLADS, "Freescale MXLADS")
 	.map_io = mx1_map_io,
 	.init_early = imx1_init_early,
 	.init_irq = mx1_init_irq,
-	.handle_irq = imx1_handle_irq,
 	.init_time	= mx1ads_timer_init,
 	.init_machine = mx1ads_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index 30c30fd..703ce31 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -327,7 +327,6 @@ MACHINE_START(MX21ADS, "Freescale i.MX21ADS")
 	.map_io		= mx21_map_io,
 	.init_early = imx21_init_early,
 	.init_irq = mx21_init_irq,
-	.handle_irq = imx21_handle_irq,
 	.init_time	= mx21ads_timer_init,
 	.init_machine = mx21ads_board_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
index 13490c2..ea1fa19 100644
--- a/arch/arm/mach-imx/mach-mx25_3ds.c
+++ b/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -263,7 +263,6 @@ MACHINE_START(MX25_3DS, "Freescale MX25PDK (3DS)")
 	.map_io = mx25_map_io,
 	.init_early = imx25_init_early,
 	.init_irq = mx25_init_irq,
-	.handle_irq = imx25_handle_irq,
 	.init_time	= mx25pdk_timer_init,
 	.init_machine = mx25pdk_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 25b3e4c..435a542 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -544,7 +544,6 @@ MACHINE_START(MX27_3DS, "Freescale MX27PDK")
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
-	.handle_irq = imx27_handle_irq,
 	.init_time	= mx27pdk_timer_init,
 	.init_machine = mx27pdk_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index a7a4a9c..2f834ce 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -391,7 +391,6 @@ MACHINE_START(MX27ADS, "Freescale i.MX27ADS")
 	.map_io = mx27ads_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
-	.handle_irq = imx27_handle_irq,
 	.init_time	= mx27ads_timer_init,
 	.init_machine = mx27ads_board_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index 50044a2..4217871 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -775,7 +775,6 @@ MACHINE_START(MX31_3DS, "Freescale MX31PDK (3DS)")
 	.map_io = mx31_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
-	.handle_irq = imx31_handle_irq,
 	.init_time	= mx31_3ds_timer_init,
 	.init_machine = mx31_3ds_init,
 	.reserve = mx31_3ds_reserve,
diff --git a/arch/arm/mach-imx/mach-mx31ads.c b/arch/arm/mach-imx/mach-mx31ads.c
index daf8889..d08c37c 100644
--- a/arch/arm/mach-imx/mach-mx31ads.c
+++ b/arch/arm/mach-imx/mach-mx31ads.c
@@ -582,7 +582,6 @@ MACHINE_START(MX31ADS, "Freescale MX31ADS")
 	.map_io = mx31ads_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31ads_init_irq,
-	.handle_irq = imx31_handle_irq,
 	.init_time	= mx31ads_timer_init,
 	.init_machine = mx31ads_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-mx31lilly.c b/arch/arm/mach-imx/mach-mx31lilly.c
index 832b1e2..eee042f 100644
--- a/arch/arm/mach-imx/mach-mx31lilly.c
+++ b/arch/arm/mach-imx/mach-mx31lilly.c
@@ -308,7 +308,6 @@ MACHINE_START(LILLY1131, "INCO startec LILLY-1131")
 	.map_io = mx31_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
-	.handle_irq = imx31_handle_irq,
 	.init_time	= mx31lilly_timer_init,
 	.init_machine = mx31lilly_board_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
index bea0729..fa15d0b 100644
--- a/arch/arm/mach-imx/mach-mx31lite.c
+++ b/arch/arm/mach-imx/mach-mx31lite.c
@@ -291,7 +291,6 @@ MACHINE_START(MX31LITE, "LogicPD i.MX31 SOM")
 	.map_io = mx31lite_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
-	.handle_irq = imx31_handle_irq,
 	.init_time	= mx31lite_timer_init,
 	.init_machine = mx31lite_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 8f45afe..08730f2 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -600,7 +600,6 @@ MACHINE_START(MX31MOBOARD, "EPFL Mobots mx31moboard")
 	.map_io = mx31_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
-	.handle_irq = imx31_handle_irq,
 	.init_time	= mx31moboard_timer_init,
 	.init_machine = mx31moboard_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index a42f4f0..4e8b184 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -615,7 +615,6 @@ MACHINE_START(MX35_3DS, "Freescale MX35PDK")
 	.map_io = mx35_map_io,
 	.init_early = imx35_init_early,
 	.init_irq = mx35_init_irq,
-	.handle_irq = imx35_handle_irq,
 	.init_time	= mx35pdk_timer_init,
 	.init_machine = mx35_3ds_init,
 	.reserve = mx35_3ds_reserve,
diff --git a/arch/arm/mach-imx/mach-mxt_td60.c b/arch/arm/mach-imx/mach-mxt_td60.c
index c918940..0b5d1ca 100644
--- a/arch/arm/mach-imx/mach-mxt_td60.c
+++ b/arch/arm/mach-imx/mach-mxt_td60.c
@@ -267,7 +267,6 @@ MACHINE_START(MXT_TD60, "Maxtrack i-MXT TD60")
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
-	.handle_irq = imx27_handle_irq,
 	.init_time	= mxt_td60_timer_init,
 	.init_machine = mxt_td60_board_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index bf3ac51..58b8666 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -421,7 +421,6 @@ MACHINE_START(PCA100, "phyCARD-i.MX27")
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
-	.handle_irq = imx27_handle_irq,
 	.init_machine = pca100_init,
 	.init_time	= pca100_timer_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
index 639a3df..81b8aff 100644
--- a/arch/arm/mach-imx/mach-pcm037.c
+++ b/arch/arm/mach-imx/mach-pcm037.c
@@ -703,7 +703,6 @@ MACHINE_START(PCM037, "Phytec Phycore pcm037")
 	.map_io = mx31_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
-	.handle_irq = imx31_handle_irq,
 	.init_time	= pcm037_timer_init,
 	.init_machine = pcm037_init,
 	.init_late = pcm037_init_late,
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index 592ddbe..6c56fb5 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -351,7 +351,6 @@ MACHINE_START(PCM038, "phyCORE-i.MX27")
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
-	.handle_irq = imx27_handle_irq,
 	.init_time	= pcm038_timer_init,
 	.init_machine = pcm038_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-pcm043.c b/arch/arm/mach-imx/mach-pcm043.c
index ac504b6..c62b5d2 100644
--- a/arch/arm/mach-imx/mach-pcm043.c
+++ b/arch/arm/mach-imx/mach-pcm043.c
@@ -400,7 +400,6 @@ MACHINE_START(PCM043, "Phytec Phycore pcm043")
 	.map_io = mx35_map_io,
 	.init_early = imx35_init_early,
 	.init_irq = mx35_init_irq,
-	.handle_irq = imx35_handle_irq,
 	.init_time = pcm043_timer_init,
 	.init_machine = pcm043_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-qong.c b/arch/arm/mach-imx/mach-qong.c
index 22af27e..a213e7b 100644
--- a/arch/arm/mach-imx/mach-qong.c
+++ b/arch/arm/mach-imx/mach-qong.c
@@ -266,7 +266,6 @@ MACHINE_START(QONG, "Dave/DENX QongEVB-LITE")
 	.map_io = mx31_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
-	.handle_irq = imx31_handle_irq,
 	.init_time	= qong_timer_init,
 	.init_machine = qong_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-scb9328.c b/arch/arm/mach-imx/mach-scb9328.c
index b0fa10d..1f6bc3f 100644
--- a/arch/arm/mach-imx/mach-scb9328.c
+++ b/arch/arm/mach-imx/mach-scb9328.c
@@ -137,7 +137,6 @@ MACHINE_START(SCB9328, "Synertronixx scb9328")
 	.map_io = mx1_map_io,
 	.init_early = imx1_init_early,
 	.init_irq = mx1_init_irq,
-	.handle_irq = imx1_handle_irq,
 	.init_time	= scb9328_timer_init,
 	.init_machine = scb9328_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/mach-vpr200.c b/arch/arm/mach-imx/mach-vpr200.c
index 8825d12..872b3c6 100644
--- a/arch/arm/mach-imx/mach-vpr200.c
+++ b/arch/arm/mach-imx/mach-vpr200.c
@@ -310,7 +310,6 @@ MACHINE_START(VPR200, "VPR200")
 	.map_io = mx35_map_io,
 	.init_early = imx35_init_early,
 	.init_irq = mx35_init_irq,
-	.handle_irq = imx35_handle_irq,
 	.init_time = vpr200_timer_init,
 	.init_machine = vpr200_board_init,
 	.restart	= mxc_restart,
diff --git a/arch/arm/mach-imx/tzic.c b/arch/arm/mach-imx/tzic.c
index 8183178..7828af4 100644
--- a/arch/arm/mach-imx/tzic.c
+++ b/arch/arm/mach-imx/tzic.c
@@ -125,7 +125,7 @@ static __init void tzic_init_gc(int idx, unsigned int irq_start)
 	irq_setup_generic_chip(gc, IRQ_MSK(32), 0, IRQ_NOREQUEST, 0);
 }
 
-asmlinkage void __exception_irq_entry tzic_handle_irq(struct pt_regs *regs)
+static void __exception_irq_entry tzic_handle_irq(struct pt_regs *regs)
 {
 	u32 stat;
 	int i, irqofs, handled;
@@ -189,6 +189,8 @@ void __init tzic_init_irq(void __iomem *irqbase)
 	for (i = 0; i < 4; i++, irq_base += 32)
 		tzic_init_gc(i, irq_base);
 
+	set_handle_irq(tzic_handle_irq);
+
 #ifdef CONFIG_FIQ
 	/* Initialize FIQ */
 	init_FIQ(FIQ_START);
-- 
1.8.3.2
