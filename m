From: robherring2@gmail.com (Rob Herring)
Date: Thu,  3 Jan 2013 11:54:16 -0600
Subject: [PATCH v4 07/19] ARM: remove mach .handle_irq for GIC users
In-Reply-To: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
Message-ID: <1357235668-9450-8-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Now that the GIC initialization sets up the handle_arch_irq pointer, we
can remove it for all machines.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Anton Vorontsov <avorontsov@mvista.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Dinh Nguyen <dinguyen@altera.com>
Cc: Shiraz Hashim <shiraz.hashim@st.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/common/gic.c                      |    2 +-
 arch/arm/include/asm/hardware/gic.h        |    1 -
 arch/arm/kernel/smp_twd.c                  |    1 -
 arch/arm/mach-bcm/board_bcm.c              |    1 -
 arch/arm/mach-cns3xxx/cns3420vb.c          |    2 --
 arch/arm/mach-exynos/mach-armlex4210.c     |    2 --
 arch/arm/mach-exynos/mach-exynos4-dt.c     |    2 --
 arch/arm/mach-exynos/mach-exynos5-dt.c     |    2 --
 arch/arm/mach-exynos/mach-nuri.c           |    2 --
 arch/arm/mach-exynos/mach-origen.c         |    2 --
 arch/arm/mach-exynos/mach-smdk4x12.c       |    3 ---
 arch/arm/mach-exynos/mach-smdkv310.c       |    3 ---
 arch/arm/mach-exynos/mach-universal_c210.c |    2 --
 arch/arm/mach-exynos/mct.c                 |    1 -
 arch/arm/mach-highbank/highbank.c          |    1 -
 arch/arm/mach-imx/common.h                 |    1 -
 arch/arm/mach-imx/mach-imx6q.c             |    1 -
 arch/arm/mach-msm/board-dt-8660.c          |    1 -
 arch/arm/mach-msm/board-dt-8960.c          |    1 -
 arch/arm/mach-msm/timer.c                  |    1 -
 arch/arm/mach-omap2/board-4430sdp.c        |    1 -
 arch/arm/mach-omap2/board-generic.c        |    3 ---
 arch/arm/mach-omap2/board-omap4panda.c     |    1 -
 arch/arm/mach-realview/core.c              |    1 -
 arch/arm/mach-realview/realview_eb.c       |    1 -
 arch/arm/mach-realview/realview_pb1176.c   |    1 -
 arch/arm/mach-realview/realview_pb11mp.c   |    1 -
 arch/arm/mach-realview/realview_pba8.c     |    1 -
 arch/arm/mach-realview/realview_pbx.c      |    1 -
 arch/arm/mach-shmobile/board-ag5evm.c      |    1 -
 arch/arm/mach-shmobile/board-kota2.c       |    1 -
 arch/arm/mach-shmobile/board-kzm9d.c       |    2 --
 arch/arm/mach-shmobile/board-kzm9g.c       |    1 -
 arch/arm/mach-shmobile/board-marzen.c      |    2 --
 arch/arm/mach-shmobile/platsmp.c           |    1 -
 arch/arm/mach-shmobile/setup-emev2.c       |    1 -
 arch/arm/mach-socfpga/socfpga.c            |    1 -
 arch/arm/mach-spear13xx/spear1310.c        |    1 -
 arch/arm/mach-spear13xx/spear1340.c        |    1 -
 arch/arm/mach-tegra/board-dt-tegra20.c     |    3 ---
 arch/arm/mach-tegra/board-dt-tegra30.c     |    2 --
 arch/arm/mach-ux500/board-mop500.c         |    5 -----
 arch/arm/mach-ux500/cpu-db8500.c           |    2 --
 arch/arm/mach-vexpress/platsmp.c           |    1 -
 arch/arm/mach-vexpress/v2m.c               |    2 --
 arch/arm/mach-zynq/common.c                |    1 -
 46 files changed, 1 insertion(+), 70 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 4b4ccf3..90eebfea 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -276,7 +276,7 @@ static int gic_set_wake(struct irq_data *d, unsigned int on)
 #define gic_set_wake	NULL
 #endif
 
-asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
+static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqstat, irqnr;
 	struct gic_chip_data *gic = &gic_data[0];
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index cfd3a7e..2a16e03 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -38,7 +38,6 @@ void gic_init_bases(unsigned int, int, void __iomem *, void __iomem *,
 		    u32 offset, struct device_node *);
 int gic_of_init(struct device_node *node, struct device_node *parent);
 void gic_secondary_init(unsigned int);
-void gic_handle_irq(struct pt_regs *regs);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 
 static inline void gic_init(unsigned int nr, int start,
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 49f335d..dc9bb01 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -24,7 +24,6 @@
 
 #include <asm/smp_twd.h>
 #include <asm/localtimer.h>
-#include <asm/hardware/gic.h>
 
 /* set up by the platform code */
 static void __iomem *twd_base;
diff --git a/arch/arm/mach-bcm/board_bcm.c b/arch/arm/mach-bcm/board_bcm.c
index 3a62f1b..6ad83d7 100644
--- a/arch/arm/mach-bcm/board_bcm.c
+++ b/arch/arm/mach-bcm/board_bcm.c
@@ -53,5 +53,4 @@ DT_MACHINE_START(BCM11351_DT, "Broadcom Application Processor")
 	.timer = &timer,
 	.init_machine = board_init,
 	.dt_compat = bcm11351_dt_compat,
-	.handle_irq = gic_handle_irq,
 MACHINE_END
diff --git a/arch/arm/mach-cns3xxx/cns3420vb.c b/arch/arm/mach-cns3xxx/cns3420vb.c
index ae30539..26f36d7 100644
--- a/arch/arm/mach-cns3xxx/cns3420vb.c
+++ b/arch/arm/mach-cns3xxx/cns3420vb.c
@@ -28,7 +28,6 @@
 #include <linux/usb/ohci_pdriver.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
@@ -251,7 +250,6 @@ MACHINE_START(CNS3420VB, "Cavium Networks CNS3420 Validation Board")
 	.map_io		= cns3420_map_io,
 	.init_irq	= cns3xxx_init_irq,
 	.timer		= &cns3xxx_timer,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= cns3420_init,
 	.restart	= cns3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-armlex4210.c b/arch/arm/mach-exynos/mach-armlex4210.c
index b938f9f..a11a36f 100644
--- a/arch/arm/mach-exynos/mach-armlex4210.c
+++ b/arch/arm/mach-exynos/mach-armlex4210.c
@@ -16,7 +16,6 @@
 #include <linux/smsc911x.h>
 
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 
 #include <plat/cpu.h>
@@ -201,7 +200,6 @@ MACHINE_START(ARMLEX4210, "ARMLEX4210")
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= armlex4210_map_io,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= armlex4210_machine_init,
 	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index 92757ff..34c45b6 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -15,7 +15,6 @@
 #include <linux/serial_core.h>
 
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 #include <mach/map.h>
 
 #include <plat/cpu.h>
@@ -107,7 +106,6 @@ DT_MACHINE_START(EXYNOS4210_DT, "Samsung Exynos4 (Flattened Device Tree)")
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= exynos4_dt_map_io,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= exynos4_dt_machine_init,
 	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index e99d3d8..3a3bee4 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -16,7 +16,6 @@
 #include <linux/io.h>
 
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 #include <mach/map.h>
 #include <mach/regs-pmu.h>
 
@@ -179,7 +178,6 @@ DT_MACHINE_START(EXYNOS5_DT, "SAMSUNG EXYNOS5 (Flattened Device Tree)")
 	.init_irq	= exynos5_init_irq,
 	.smp		= smp_ops(exynos_smp_ops),
 	.map_io		= exynos5_dt_map_io,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= exynos5_dt_machine_init,
 	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index 27d4ed8..55f8183 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -39,7 +39,6 @@
 #include <media/v4l2-mediabus.h>
 
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 
 #include <plat/adc.h>
@@ -1379,7 +1378,6 @@ MACHINE_START(NURI, "NURI")
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= nuri_map_io,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= nuri_machine_init,
 	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index 5e34b9c..45cda36 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -29,7 +29,6 @@
 #include <linux/platform_data/usb-exynos.h>
 
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 
 #include <video/platform_lcd.h>
@@ -814,7 +813,6 @@ MACHINE_START(ORIGEN, "ORIGEN")
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= origen_map_io,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= origen_machine_init,
 	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
diff --git a/arch/arm/mach-exynos/mach-smdk4x12.c b/arch/arm/mach-exynos/mach-smdk4x12.c
index ae6da40..d5dbd51 100644
--- a/arch/arm/mach-exynos/mach-smdk4x12.c
+++ b/arch/arm/mach-exynos/mach-smdk4x12.c
@@ -25,7 +25,6 @@
 #include <linux/platform_data/s3c-hsotg.h>
 
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 
 #include <video/samsung_fimd.h>
@@ -376,7 +375,6 @@ MACHINE_START(SMDK4212, "SMDK4212")
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdk4x12_map_io,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdk4x12_machine_init,
 	.timer		= &exynos4_timer,
 	.restart	= exynos4_restart,
@@ -390,7 +388,6 @@ MACHINE_START(SMDK4412, "SMDK4412")
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdk4x12_map_io,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdk4x12_machine_init,
 	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
index 35548e3..b095964 100644
--- a/arch/arm/mach-exynos/mach-smdkv310.c
+++ b/arch/arm/mach-exynos/mach-smdkv310.c
@@ -26,7 +26,6 @@
 #include <linux/platform_data/usb-exynos.h>
 
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 
 #include <video/platform_lcd.h>
@@ -423,7 +422,6 @@ MACHINE_START(SMDKV310, "SMDKV310")
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdkv310_map_io,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdkv310_machine_init,
 	.timer		= &exynos4_timer,
 	.reserve	= &smdkv310_reserve,
@@ -436,7 +434,6 @@ MACHINE_START(SMDKC210, "SMDKC210")
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdkv310_map_io,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdkv310_machine_init,
 	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 9e3340f..be37775 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -29,7 +29,6 @@
 #include <drm/exynos_drm.h>
 
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 
 #include <video/samsung_fimd.h>
@@ -1151,7 +1150,6 @@ MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= universal_map_io,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= universal_machine_init,
 	.init_late	= exynos_init_late,
 	.timer		= &s5p_timer,
diff --git a/arch/arm/mach-exynos/mct.c b/arch/arm/mach-exynos/mct.c
index 57668eb..baefe9b 100644
--- a/arch/arm/mach-exynos/mct.c
+++ b/arch/arm/mach-exynos/mct.c
@@ -22,7 +22,6 @@
 #include <linux/of.h>
 
 #include <asm/arch_timer.h>
-#include <asm/hardware/gic.h>
 #include <asm/localtimer.h>
 
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index dc24816..d48331c 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -210,7 +210,6 @@ DT_MACHINE_START(HIGHBANK, "Highbank")
 	.map_io		= debug_ll_io_init,
 	.init_irq	= highbank_init_irq,
 	.timer		= &highbank_timer,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= highbank_init,
 	.dt_compat	= highbank_match,
 	.restart	= highbank_restart,
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 7191ab4..b0164da 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -112,7 +112,6 @@ void tzic_handle_irq(struct pt_regs *);
 #define imx50_handle_irq tzic_handle_irq
 #define imx51_handle_irq tzic_handle_irq
 #define imx53_handle_irq tzic_handle_irq
-#define imx6q_handle_irq gic_handle_irq
 
 extern void imx_enable_cpu(int cpu, bool enable);
 extern void imx_set_cpu_jump(int cpu, void *jump_addr);
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 4eb1b3a..1fbf9a1 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -254,7 +254,6 @@ DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad (Device Tree)")
 	.smp		= smp_ops(imx_smp_ops),
 	.map_io		= imx6q_map_io,
 	.init_irq	= imx6q_init_irq,
-	.handle_irq	= imx6q_handle_irq,
 	.timer		= &imx6q_timer,
 	.init_machine	= imx6q_init_machine,
 	.init_late      = imx6q_init_late,
diff --git a/arch/arm/mach-msm/board-dt-8660.c b/arch/arm/mach-msm/board-dt-8660.c
index b5b4de2..bd4062f9 100644
--- a/arch/arm/mach-msm/board-dt-8660.c
+++ b/arch/arm/mach-msm/board-dt-8660.c
@@ -56,7 +56,6 @@ DT_MACHINE_START(MSM_DT, "Qualcomm MSM (Flattened Device Tree)")
 	.smp = smp_ops(msm_smp_ops),
 	.map_io = msm_map_msm8x60_io,
 	.init_irq = msm8x60_init_irq,
-	.handle_irq = gic_handle_irq,
 	.init_machine = msm8x60_dt_init,
 	.init_late = msm8x60_init_late,
 	.timer = &msm_dt_timer,
diff --git a/arch/arm/mach-msm/board-dt-8960.c b/arch/arm/mach-msm/board-dt-8960.c
index 4490edb..f45e985 100644
--- a/arch/arm/mach-msm/board-dt-8960.c
+++ b/arch/arm/mach-msm/board-dt-8960.c
@@ -46,5 +46,4 @@ DT_MACHINE_START(MSM8960_DT, "Qualcomm MSM (Flattened Device Tree)")
 	.timer = &msm_dt_timer,
 	.init_machine = msm_dt_init,
 	.dt_compat = msm8960_dt_match,
-	.handle_irq = gic_handle_irq,
 MACHINE_END
diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 476549a..4330285 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -25,7 +25,6 @@
 #include <linux/of_irq.h>
 
 #include <asm/mach/time.h>
-#include <asm/hardware/gic.h>
 #include <asm/localtimer.h>
 #include <asm/sched_clock.h>
 
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 1cc6696..3de62a9 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -722,7 +722,6 @@ MACHINE_START(OMAP_4430SDP, "OMAP4430 4430SDP board")
 	.map_io		= omap4_map_io,
 	.init_early	= omap4430_init_early,
 	.init_irq	= gic_init_irq,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= omap_4430sdp_init,
 	.init_late	= omap4430_init_late,
 	.timer		= &omap4_timer,
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 53cb380b..73be868 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -16,7 +16,6 @@
 #include <linux/of_platform.h>
 #include <linux/irqdomain.h>
 
-#include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
 
 #include "common.h"
@@ -156,7 +155,6 @@ DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
 	.map_io		= omap4_map_io,
 	.init_early	= omap4430_init_early,
 	.init_irq	= omap_gic_of_init,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= omap_generic_init,
 	.init_late	= omap4430_init_late,
 	.timer		= &omap4_timer,
@@ -177,7 +175,6 @@ DT_MACHINE_START(OMAP5_DT, "Generic OMAP5 (Flattened Device Tree)")
 	.map_io		= omap5_map_io,
 	.init_early	= omap5_init_early,
 	.init_irq	= omap_gic_of_init,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= omap_generic_init,
 	.timer		= &omap5_timer,
 	.dt_compat	= omap5_boards_compat,
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 5c8e9ce..4df66c9 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -453,7 +453,6 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	.map_io		= omap4_map_io,
 	.init_early	= omap4430_init_early,
 	.init_irq	= gic_init_irq,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= omap4_panda_init,
 	.init_late	= omap4430_init_late,
 	.timer		= &omap4_timer,
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 6824674..1d5ee5c 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -42,7 +42,6 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
 
-#include <asm/hardware/gic.h>
 
 #include <mach/platform.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 28511d4..3a73758 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -473,7 +473,6 @@ MACHINE_START(REALVIEW_EB, "ARM-RealView EB")
 	.init_early	= realview_init_early,
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_eb_timer,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= realview_eb_init,
 #ifdef CONFIG_ZONE_DMA
 	.dma_zone_size	= SZ_256M,
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index 07d6672..afa967b 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -385,7 +385,6 @@ MACHINE_START(REALVIEW_PB1176, "ARM-RealView PB1176")
 	.init_early	= realview_init_early,
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_pb1176_timer,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= realview_pb1176_init,
 #ifdef CONFIG_ZONE_DMA
 	.dma_zone_size	= SZ_256M,
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 7ed53d7..d8a25b4 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -368,7 +368,6 @@ MACHINE_START(REALVIEW_PB11MP, "ARM-RealView PB11MPCore")
 	.init_early	= realview_init_early,
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_pb11mp_timer,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= realview_pb11mp_init,
 #ifdef CONFIG_ZONE_DMA
 	.dma_zone_size	= SZ_256M,
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 9992431..5391d0a 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -309,7 +309,6 @@ MACHINE_START(REALVIEW_PBA8, "ARM-RealView PB-A8")
 	.init_early	= realview_init_early,
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_pba8_timer,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= realview_pba8_init,
 #ifdef CONFIG_ZONE_DMA
 	.dma_zone_size	= SZ_256M,
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 4f486f0..bfb834b 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -405,7 +405,6 @@ MACHINE_START(REALVIEW_PBX, "ARM-RealView PBX")
 	.init_early	= realview_init_early,
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_pbx_timer,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= realview_pbx_init,
 #ifdef CONFIG_ZONE_DMA
 	.dma_zone_size	= SZ_256M,
diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 032d108..81b31f5 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -668,7 +668,6 @@ MACHINE_START(AG5EVM, "ag5evm")
 	.init_early	= sh73a0_add_early_devices,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= sh73a0_init_irq,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= ag5evm_init,
 	.init_late	= shmobile_init_late,
 	.timer		= &shmobile_timer,
diff --git a/arch/arm/mach-shmobile/board-kota2.c b/arch/arm/mach-shmobile/board-kota2.c
index bf88f9a..2df8e60 100644
--- a/arch/arm/mach-shmobile/board-kota2.c
+++ b/arch/arm/mach-shmobile/board-kota2.c
@@ -550,7 +550,6 @@ MACHINE_START(KOTA2, "kota2")
 	.init_early	= sh73a0_add_early_devices,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= sh73a0_init_irq,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= kota2_init,
 	.init_late	= shmobile_init_late,
 	.timer		= &shmobile_timer,
diff --git a/arch/arm/mach-shmobile/board-kzm9d.c b/arch/arm/mach-shmobile/board-kzm9d.c
index b52bc0d..f3f180d 100644
--- a/arch/arm/mach-shmobile/board-kzm9d.c
+++ b/arch/arm/mach-shmobile/board-kzm9d.c
@@ -28,7 +28,6 @@
 #include <mach/emev2.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 
 /* Dummy supplies, where voltage doesn't matter */
 static struct regulator_consumer_supply dummy_supplies[] = {
@@ -89,7 +88,6 @@ DT_MACHINE_START(KZM9D_DT, "kzm9d")
 	.init_early	= emev2_add_early_devices,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= emev2_init_irq,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= kzm9d_add_standard_devices,
 	.init_late	= shmobile_init_late,
 	.timer		= &shmobile_timer,
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index c02448d..d160758 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -792,7 +792,6 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g")
 	.init_early	= sh73a0_add_early_devices,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= sh73a0_init_irq,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= kzm_init,
 	.init_late	= shmobile_init_late,
 	.timer		= &shmobile_timer,
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 449f928..fad8db1 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -44,7 +44,6 @@
 #include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 #include <asm/traps.h>
 
 /* Fixed 3.3V regulator to be used by SDHI0 */
@@ -382,7 +381,6 @@ MACHINE_START(MARZEN, "marzen")
 	.init_early	= r8a7779_add_early_devices,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= r8a7779_init_irq,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= marzen_init,
 	.init_late	= marzen_init_late,
 	.timer		= &shmobile_timer,
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index d393c52..1f958d7 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -12,7 +12,6 @@
  */
 #include <linux/init.h>
 #include <linux/smp.h>
-#include <asm/hardware/gic.h>
 
 void __init shmobile_smp_init_cpus(unsigned int ncores)
 {
diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index a47beeb..4a8cb69 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -465,7 +465,6 @@ DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
 	.init_early	= emev2_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= emev2_init_irq_dt,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= emev2_add_standard_devices_dt,
 	.timer		= &shmobile_timer,
 	.dt_compat	= emev2_boards_compat_dt,
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 6732924..6a613b7 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -106,7 +106,6 @@ DT_MACHINE_START(SOCFPGA, "Altera SOCFPGA")
 	.smp		= smp_ops(socfpga_smp_ops),
 	.map_io		= socfpga_map_io,
 	.init_irq	= gic_init_irq,
-	.handle_irq     = gic_handle_irq,
 	.timer		= &dw_apb_timer,
 	.init_machine	= socfpga_cyclone5_init,
 	.restart	= socfpga_cyclone5_restart,
diff --git a/arch/arm/mach-spear13xx/spear1310.c b/arch/arm/mach-spear13xx/spear1310.c
index 02f4724..295bb04 100644
--- a/arch/arm/mach-spear13xx/spear1310.c
+++ b/arch/arm/mach-spear13xx/spear1310.c
@@ -91,7 +91,6 @@ DT_MACHINE_START(SPEAR1310_DT, "ST SPEAr1310 SoC with Flattened Device Tree")
 	.smp		=	smp_ops(spear13xx_smp_ops),
 	.map_io		=	spear1310_map_io,
 	.init_irq	=	spear13xx_dt_init_irq,
-	.handle_irq	=	gic_handle_irq,
 	.timer		=	&spear13xx_timer,
 	.init_machine	=	spear1310_dt_init,
 	.restart	=	spear_restart,
diff --git a/arch/arm/mach-spear13xx/spear1340.c b/arch/arm/mach-spear13xx/spear1340.c
index 081014f..c3a7702 100644
--- a/arch/arm/mach-spear13xx/spear1340.c
+++ b/arch/arm/mach-spear13xx/spear1340.c
@@ -185,7 +185,6 @@ DT_MACHINE_START(SPEAR1340_DT, "ST SPEAr1340 SoC with Flattened Device Tree")
 	.smp		=	smp_ops(spear13xx_smp_ops),
 	.map_io		=	spear13xx_map_io,
 	.init_irq	=	spear13xx_dt_init_irq,
-	.handle_irq	=	gic_handle_irq,
 	.timer		=	&spear13xx_timer,
 	.init_machine	=	spear1340_dt_init,
 	.restart	=	spear_restart,
diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index 734d9cc..04008c8 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -25,7 +25,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_fdt.h>
-#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/pda_power.h>
 #include <linux/platform_data/tegra_usb.h>
@@ -34,7 +33,6 @@
 #include <linux/i2c-tegra.h>
 #include <linux/usb/tegra_usb_phy.h>
 
-#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -202,7 +200,6 @@ DT_MACHINE_START(TEGRA_DT, "nVidia Tegra20 (Flattened Device Tree)")
 	.smp		= smp_ops(tegra_smp_ops),
 	.init_early	= tegra20_init_early,
 	.init_irq	= tegra_dt_init_irq,
-	.handle_irq	= gic_handle_irq,
 	.timer		= &tegra_sys_timer,
 	.init_machine	= tegra_dt_init,
 	.init_late	= tegra_dt_init_late,
diff --git a/arch/arm/mach-tegra/board-dt-tegra30.c b/arch/arm/mach-tegra/board-dt-tegra30.c
index 6497d12..672db8a 100644
--- a/arch/arm/mach-tegra/board-dt-tegra30.c
+++ b/arch/arm/mach-tegra/board-dt-tegra30.c
@@ -31,7 +31,6 @@
 #include <linux/of_platform.h>
 
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 
 #include "board.h"
 #include "clock.h"
@@ -112,7 +111,6 @@ DT_MACHINE_START(TEGRA30_DT, "NVIDIA Tegra30 (Flattened Device Tree)")
 	.map_io		= tegra_map_common_io,
 	.init_early	= tegra30_init_early,
 	.init_irq	= tegra_dt_init_irq,
-	.handle_irq	= gic_handle_irq,
 	.timer		= &tegra_sys_timer,
 	.init_machine	= tegra30_dt_init,
 	.init_late	= tegra_init_late,
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index d453522..af406c7 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -40,7 +40,6 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 
 #include <mach/hardware.h>
 #include <mach/setup.h>
@@ -752,7 +751,6 @@ MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
 	.init_irq	= ux500_init_irq,
 	/* we re-use nomadik timer here */
 	.timer		= &ux500_timer,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= mop500_init_machine,
 	.init_late	= ux500_init_late,
 MACHINE_END
@@ -762,7 +760,6 @@ MACHINE_START(U8520, "ST-Ericsson U8520 Platform HREFP520")
 	.map_io		= u8500_map_io,
 	.init_irq	= ux500_init_irq,
 	.timer		= &ux500_timer,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= mop500_init_machine,
 	.init_late	= ux500_init_late,
 MACHINE_END
@@ -773,7 +770,6 @@ MACHINE_START(HREFV60, "ST-Ericsson U8500 Platform HREFv60+")
 	.map_io		= u8500_map_io,
 	.init_irq	= ux500_init_irq,
 	.timer		= &ux500_timer,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= hrefv60_init_machine,
 	.init_late	= ux500_init_late,
 MACHINE_END
@@ -785,7 +781,6 @@ MACHINE_START(SNOWBALL, "Calao Systems Snowball platform")
 	.init_irq	= ux500_init_irq,
 	/* we re-use nomadik timer here */
 	.timer		= &ux500_timer,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= snowball_init_machine,
 	.init_late	= NULL,
 MACHINE_END
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index db0bb75..cc0fa09 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -27,7 +27,6 @@
 #include <asm/pmu.h>
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 
 #include <mach/hardware.h>
 #include <mach/setup.h>
@@ -341,7 +340,6 @@ DT_MACHINE_START(U8500_DT, "ST-Ericsson Ux5x0 platform (Device Tree Support)")
 	.init_irq	= ux500_init_irq,
 	/* we re-use nomadik timer here */
 	.timer		= &ux500_timer,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= u8500_init_machine,
 	.init_late	= NULL,
 	.dt_compat      = stericsson_dt_platform_compat,
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index 3bc0e38..dc1ace5 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -16,7 +16,6 @@
 #include <linux/vexpress.h>
 
 #include <asm/smp_scu.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
 
 #include <mach/motherboard.h>
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 011661a..557d361 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -377,7 +377,6 @@ MACHINE_START(VEXPRESS, "ARM-Versatile Express")
 	.init_early	= v2m_init_early,
 	.init_irq	= v2m_init_irq,
 	.timer		= &v2m_timer,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= v2m_init,
 	.restart	= vexpress_restart,
 MACHINE_END
@@ -500,6 +499,5 @@ DT_MACHINE_START(VEXPRESS_DT, "ARM-Versatile Express")
 	.init_irq	= v2m_dt_init_irq,
 	.timer		= &v2m_dt_timer,
 	.init_machine	= v2m_dt_init,
-	.handle_irq	= gic_handle_irq,
 	.restart	= vexpress_restart,
 MACHINE_END
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index e16d4be..40f46ae 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -118,7 +118,6 @@ static const char *xilinx_dt_match[] = {
 MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
 	.map_io		= xilinx_map_io,
 	.init_irq	= xilinx_irq_init,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= xilinx_init_machine,
 	.timer		= &xttcpss_sys_timer,
 	.dt_compat	= xilinx_dt_match,
-- 
1.7.10.4
