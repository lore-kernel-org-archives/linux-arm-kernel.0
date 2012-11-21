From: robherring2@gmail.com (Rob Herring)
Date: Tue, 20 Nov 2012 20:58:30 -0600
Subject: [PATCH 6/9] ARM: remove mach .handle_irq for GIC users
In-Reply-To: <1353466713-18967-1-git-send-email-robherring2@gmail.com>
References: <1353466713-18967-1-git-send-email-robherring2@gmail.com>
Message-ID: <1353466713-18967-7-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Now that the GIC initialization sets up the handle_arch_irq pointer, we
can remove it for all machines.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Anton Vorontsov <avorontsov@mvista.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Dinh Nguyen <dinguyen@altera.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Shiraz Hashim <shiraz.hashim@st.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/common/gic.c                      |    2 +-
 arch/arm/include/asm/hardware/gic.h        |    1 -
 arch/arm/kernel/smp_twd.c                  |    1 -
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
 arch/arm/mach-vexpress/platsmp.c           |    1 -
 arch/arm/mach-vexpress/v2m.c               |    2 --
 arch/arm/mach-zynq/common.c                |    1 -
 arch/arm/plat-mxc/include/mach/common.h    |    1 -
 44 files changed, 1 insertion(+), 67 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 5abc750..5b2145c 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -268,7 +268,7 @@ static int gic_set_wake(struct irq_data *d, unsigned int on)
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
index b22d700..fd847d5 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -24,7 +24,6 @@
 
 #include <asm/smp_twd.h>
 #include <asm/localtimer.h>
-#include <asm/hardware/gic.h>
 
 /* set up by the platform code */
 static void __iomem *twd_base;
diff --git a/arch/arm/mach-cns3xxx/cns3420vb.c b/arch/arm/mach-cns3xxx/cns3420vb.c
index 2c5fb4c..9b8c3d5 100644
--- a/arch/arm/mach-cns3xxx/cns3420vb.c
+++ b/arch/arm/mach-cns3xxx/cns3420vb.c
@@ -26,7 +26,6 @@
 #include <linux/mtd/partitions.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
@@ -202,7 +201,6 @@ MACHINE_START(CNS3420VB, "Cavium Networks CNS3420 Validation Board")
 	.map_io		= cns3420_map_io,
 	.init_irq	= cns3xxx_init_irq,
 	.timer		= &cns3xxx_timer,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= cns3420_init,
 	.restart	= cns3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-armlex4210.c b/arch/arm/mach-exynos/mach-armlex4210.c
index 3f37a5e..97c7aeb 100644
--- a/arch/arm/mach-exynos/mach-armlex4210.c
+++ b/arch/arm/mach-exynos/mach-armlex4210.c
@@ -16,7 +16,6 @@
 #include <linux/smsc911x.h>
 
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 
 #include <plat/cpu.h>
@@ -202,7 +201,6 @@ MACHINE_START(ARMLEX4210, "ARMLEX4210")
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= armlex4210_map_io,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= armlex4210_machine_init,
 	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index eadf4b5..4c65483 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -15,7 +15,6 @@
 #include <linux/serial_core.h>
 
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 #include <mach/map.h>
 
 #include <plat/cpu.h>
@@ -102,7 +101,6 @@ DT_MACHINE_START(EXYNOS4210_DT, "Samsung Exynos4 (Flattened Device Tree)")
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= exynos4_dt_map_io,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= exynos4_dt_machine_init,
 	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index db1cd8e..49482ed 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -13,7 +13,6 @@
 #include <linux/serial_core.h>
 
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 #include <mach/map.h>
 
 #include <plat/cpu.h>
@@ -97,7 +96,6 @@ DT_MACHINE_START(EXYNOS5_DT, "SAMSUNG EXYNOS5 (Flattened Device Tree)")
 	.init_irq	= exynos5_init_irq,
 	.smp		= smp_ops(exynos_smp_ops),
 	.map_io		= exynos5250_dt_map_io,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= exynos5250_dt_machine_init,
 	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index c05d7aa..466bbe0 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -36,7 +36,6 @@
 #include <media/v4l2-mediabus.h>
 
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 
 #include <plat/adc.h>
@@ -1383,7 +1382,6 @@ MACHINE_START(NURI, "NURI")
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= nuri_map_io,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= nuri_machine_init,
 	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index 9adf491..8a0804e 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -26,7 +26,6 @@
 #include <linux/platform_data/s3c-hsotg.h>
 
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 
 #include <video/platform_lcd.h>
@@ -815,7 +814,6 @@ MACHINE_START(ORIGEN, "ORIGEN")
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= origen_map_io,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= origen_machine_init,
 	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
diff --git a/arch/arm/mach-exynos/mach-smdk4x12.c b/arch/arm/mach-exynos/mach-smdk4x12.c
index 730f1ac..2ca2b12 100644
--- a/arch/arm/mach-exynos/mach-smdk4x12.c
+++ b/arch/arm/mach-exynos/mach-smdk4x12.c
@@ -24,7 +24,6 @@
 #include <linux/platform_data/s3c-hsotg.h>
 
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 
 #include <video/samsung_fimd.h>
@@ -379,7 +378,6 @@ MACHINE_START(SMDK4212, "SMDK4212")
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdk4x12_map_io,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdk4x12_machine_init,
 	.timer		= &exynos4_timer,
 	.restart	= exynos4_restart,
@@ -393,7 +391,6 @@ MACHINE_START(SMDK4412, "SMDK4412")
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdk4x12_map_io,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdk4x12_machine_init,
 	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
index ee4fb1a..6158c26 100644
--- a/arch/arm/mach-exynos/mach-smdkv310.c
+++ b/arch/arm/mach-exynos/mach-smdkv310.c
@@ -23,7 +23,6 @@
 #include <linux/platform_data/s3c-hsotg.h>
 
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 
 #include <video/platform_lcd.h>
@@ -427,7 +426,6 @@ MACHINE_START(SMDKV310, "SMDKV310")
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdkv310_map_io,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdkv310_machine_init,
 	.timer		= &exynos4_timer,
 	.reserve	= &smdkv310_reserve,
@@ -440,7 +438,6 @@ MACHINE_START(SMDKC210, "SMDKC210")
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdkv310_map_io,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdkv310_machine_init,
 	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index ebc9dd3..0320d8f 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -27,7 +27,6 @@
 #include <drm/exynos_drm.h>
 
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 
 #include <video/samsung_fimd.h>
@@ -1155,7 +1154,6 @@ MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= universal_map_io,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= universal_machine_init,
 	.init_late	= exynos_init_late,
 	.timer		= &s5p_timer,
diff --git a/arch/arm/mach-exynos/mct.c b/arch/arm/mach-exynos/mct.c
index b601fb8..ef5097d 100644
--- a/arch/arm/mach-exynos/mct.c
+++ b/arch/arm/mach-exynos/mct.c
@@ -20,7 +20,6 @@
 #include <linux/delay.h>
 #include <linux/percpu.h>
 
-#include <asm/hardware/gic.h>
 #include <asm/localtimer.h>
 
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 40e36a5..024d078 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -219,7 +219,6 @@ DT_MACHINE_START(HIGHBANK, "Highbank")
 	.map_io		= highbank_map_io,
 	.init_irq	= highbank_init_irq,
 	.timer		= &highbank_timer,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= highbank_init,
 	.dt_compat	= highbank_match,
 	.restart	= highbank_restart,
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 47c91f7..3291b9c 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -207,7 +207,6 @@ DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad (Device Tree)")
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
index 3669c12..bd2580a 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -877,7 +877,6 @@ MACHINE_START(OMAP_4430SDP, "OMAP4430 4430SDP board")
 	.map_io		= omap4_map_io,
 	.init_early	= omap4430_init_early,
 	.init_irq	= gic_init_irq,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= omap_4430sdp_init,
 	.init_late	= omap4430_init_late,
 	.timer		= &omap4_timer,
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 601ecdf..f2f8d3d 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -16,7 +16,6 @@
 #include <linux/of_platform.h>
 #include <linux/irqdomain.h>
 
-#include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
 
 #include "common.h"
@@ -129,7 +128,6 @@ DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
 	.map_io		= omap4_map_io,
 	.init_early	= omap4430_init_early,
 	.init_irq	= omap_gic_of_init,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= omap_generic_init,
 	.init_late	= omap4430_init_late,
 	.timer		= &omap4_timer,
@@ -150,7 +148,6 @@ DT_MACHINE_START(OMAP5_DT, "Generic OMAP5 (Flattened Device Tree)")
 	.map_io		= omap5_map_io,
 	.init_early	= omap5_init_early,
 	.init_irq	= omap_gic_of_init,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= omap_generic_init,
 	.timer		= &omap5_timer,
 	.dt_compat	= omap5_boards_compat,
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index bfcd397..f3ca476 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -520,7 +520,6 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
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
index d3b3cd2..fef2777 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -472,7 +472,6 @@ MACHINE_START(REALVIEW_EB, "ARM-RealView EB")
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
index 25eb88a..07292e3 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -654,7 +654,6 @@ MACHINE_START(AG5EVM, "ag5evm")
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
index 0a43f31..3e587a6 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -780,7 +780,6 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g")
 	.init_early	= sh73a0_add_early_devices,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= sh73a0_init_irq,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= kzm_init,
 	.init_late	= shmobile_init_late,
 	.timer		= &shmobile_timer,
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index b8a7525..f715184 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -38,7 +38,6 @@
 #include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 #include <asm/traps.h>
 
 /* Fixed 3.3V regulator to be used by SDHI0 */
@@ -173,7 +172,6 @@ MACHINE_START(MARZEN, "marzen")
 	.init_early	= r8a7779_add_early_devices,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= r8a7779_init_irq,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= marzen_init,
 	.init_late	= shmobile_init_late,
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
index f01e1eb..a685dd1 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -54,7 +54,6 @@ static const char *altera_dt_match[] = {
 
 DT_MACHINE_START(SOCFPGA, "Altera SOCFPGA")
 	.init_irq	= gic_init_irq,
-	.handle_irq     = gic_handle_irq,
 	.timer		= &dw_apb_timer,
 	.init_machine	= socfpga_cyclone5_init,
 	.restart	= socfpga_cyclone5_restart,
diff --git a/arch/arm/mach-spear13xx/spear1310.c b/arch/arm/mach-spear13xx/spear1310.c
index 9fbbfc5..0fe6b25 100644
--- a/arch/arm/mach-spear13xx/spear1310.c
+++ b/arch/arm/mach-spear13xx/spear1310.c
@@ -81,7 +81,6 @@ DT_MACHINE_START(SPEAR1310_DT, "ST SPEAr1310 SoC with Flattened Device Tree")
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
index aa5325c..4c6968a 100644
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
@@ -181,7 +179,6 @@ DT_MACHINE_START(TEGRA_DT, "nVidia Tegra20 (Flattened Device Tree)")
 	.smp		= smp_ops(tegra_smp_ops),
 	.init_early	= tegra20_init_early,
 	.init_irq	= tegra_dt_init_irq,
-	.handle_irq	= gic_handle_irq,
 	.timer		= &tegra_sys_timer,
 	.init_machine	= tegra_dt_init,
 	.init_late	= tegra_dt_init_late,
diff --git a/arch/arm/mach-tegra/board-dt-tegra30.c b/arch/arm/mach-tegra/board-dt-tegra30.c
index 5e92a81..6a1ba3b 100644
--- a/arch/arm/mach-tegra/board-dt-tegra30.c
+++ b/arch/arm/mach-tegra/board-dt-tegra30.c
@@ -31,7 +31,6 @@
 #include <linux/of_platform.h>
 
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 
 #include <mach/iomap.h>
 
@@ -88,7 +87,6 @@ DT_MACHINE_START(TEGRA30_DT, "NVIDIA Tegra30 (Flattened Device Tree)")
 	.map_io		= tegra_map_common_io,
 	.init_early	= tegra30_init_early,
 	.init_irq	= tegra_dt_init_irq,
-	.handle_irq	= gic_handle_irq,
 	.timer		= &tegra_sys_timer,
 	.init_machine	= tegra30_dt_init,
 	.init_late	= tegra_init_late,
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 416d436..537df50 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -40,7 +40,6 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 
 #include <plat/ste_dma40.h>
 #include <plat/gpio-nomadik.h>
@@ -696,7 +695,6 @@ MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
 	.init_irq	= ux500_init_irq,
 	/* we re-use nomadik timer here */
 	.timer		= &ux500_timer,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= mop500_init_machine,
 	.init_late	= ux500_init_late,
 MACHINE_END
@@ -707,7 +705,6 @@ MACHINE_START(HREFV60, "ST-Ericsson U8500 Platform HREFv60+")
 	.map_io		= u8500_map_io,
 	.init_irq	= ux500_init_irq,
 	.timer		= &ux500_timer,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= hrefv60_init_machine,
 	.init_late	= ux500_init_late,
 MACHINE_END
@@ -719,7 +716,6 @@ MACHINE_START(SNOWBALL, "Calao Systems Snowball platform")
 	.init_irq	= ux500_init_irq,
 	/* we re-use nomadik timer here */
 	.timer		= &ux500_timer,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= snowball_init_machine,
 	.init_late	= ux500_init_late,
 MACHINE_END
@@ -847,7 +843,6 @@ DT_MACHINE_START(U8500_DT, "ST-Ericsson U8500 platform (Device Tree Support)")
 	.init_irq	= ux500_init_irq,
 	/* we re-use nomadik timer here */
 	.timer		= &ux500_timer,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= u8500_init_machine,
 	.init_late	= ux500_init_late,
 	.dt_compat      = u8500_dt_board_compat,
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index cd98c04..f0e3e5e 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -15,7 +15,6 @@
 #include <linux/of_fdt.h>
 
 #include <asm/smp_scu.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
 
 #include <mach/motherboard.h>
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 560e0df..5e95e84 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -537,7 +537,6 @@ MACHINE_START(VEXPRESS, "ARM-Versatile Express")
 	.init_early	= v2m_init_early,
 	.init_irq	= v2m_init_irq,
 	.timer		= &v2m_timer,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= v2m_init,
 	.restart	= v2m_restart,
 MACHINE_END
@@ -671,6 +670,5 @@ DT_MACHINE_START(VEXPRESS_DT, "ARM-Versatile Express")
 	.init_irq	= v2m_dt_init_irq,
 	.timer		= &v2m_dt_timer,
 	.init_machine	= v2m_dt_init,
-	.handle_irq	= gic_handle_irq,
 	.restart	= v2m_restart,
 MACHINE_END
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index ab5cfdd..73e9368 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -112,7 +112,6 @@ static const char *xilinx_dt_match[] = {
 MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
 	.map_io		= xilinx_map_io,
 	.init_irq	= xilinx_irq_init,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= xilinx_init_machine,
 	.timer		= &xttcpss_sys_timer,
 	.dt_compat	= xilinx_dt_match,
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index ead9018..f3c5fbb 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -110,7 +110,6 @@ void tzic_handle_irq(struct pt_regs *);
 #define imx50_handle_irq tzic_handle_irq
 #define imx51_handle_irq tzic_handle_irq
 #define imx53_handle_irq tzic_handle_irq
-#define imx6q_handle_irq gic_handle_irq
 
 extern void imx_enable_cpu(int cpu, bool enable);
 extern void imx_set_cpu_jump(int cpu, void *jump_addr);
-- 
1.7.10.4
