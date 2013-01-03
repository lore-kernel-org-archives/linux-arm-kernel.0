From: robherring2@gmail.com (Rob Herring)
Date: Thu,  3 Jan 2013 11:54:18 -0600
Subject: [PATCH v4 09/19] ARM: use common irqchip_init for GIC init
In-Reply-To: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
Message-ID: <1357235668-9450-10-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Convert all GIC DT initialization over to use common irqchip_init
function.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Kukjin Kim <kgene.kim@samsung.com>
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
 arch/arm/include/asm/hardware/gic.h            |    1 -
 arch/arm/mach-bcm/board_bcm.c                  |   16 ++--------------
 arch/arm/mach-exynos/common.c                  |    8 +++++---
 arch/arm/mach-highbank/highbank.c              |   10 ++--------
 arch/arm/mach-imx/mach-imx6q.c                 |    9 ++-------
 arch/arm/mach-msm/board-dt-8660.c              |   15 ++-------------
 arch/arm/mach-msm/board-dt-8960.c              |   15 ++-------------
 arch/arm/mach-omap2/omap4-common.c             |    9 ++-------
 arch/arm/mach-shmobile/setup-emev2.c           |   14 ++------------
 arch/arm/mach-socfpga/socfpga.c                |   13 ++++---------
 arch/arm/mach-spear13xx/include/mach/generic.h |    1 -
 arch/arm/mach-spear13xx/spear1310.c            |    4 ++--
 arch/arm/mach-spear13xx/spear1340.c            |    4 ++--
 arch/arm/mach-spear13xx/spear13xx.c            |   13 +------------
 arch/arm/mach-tegra/common.c                   |   10 ++--------
 arch/arm/mach-ux500/cpu.c                      |    8 ++------
 arch/arm/mach-vexpress/v2m.c                   |   14 ++------------
 arch/arm/mach-zynq/common.c                    |   16 +---------------
 18 files changed, 35 insertions(+), 145 deletions(-)

diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 2a16e03..5c14398 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -36,7 +36,6 @@ extern struct irq_chip gic_arch_extn;
 
 void gic_init_bases(unsigned int, int, void __iomem *, void __iomem *,
 		    u32 offset, struct device_node *);
-int gic_of_init(struct device_node *node, struct device_node *parent);
 void gic_secondary_init(unsigned int);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 
diff --git a/arch/arm/mach-bcm/board_bcm.c b/arch/arm/mach-bcm/board_bcm.c
index 6ad83d7..5c920bd 100644
--- a/arch/arm/mach-bcm/board_bcm.c
+++ b/arch/arm/mach-bcm/board_bcm.c
@@ -11,22 +11,15 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
+#include <linux/irqchip.h>
 
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
-
 #include <asm/mach/time.h>
 
-static const struct of_device_id irq_match[] = {
-	{.compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
-	{}
-};
-
 static void timer_init(void)
 {
 }
@@ -35,11 +28,6 @@ static struct sys_timer timer = {
 	.init = timer_init,
 };
 
-static void __init init_irq(void)
-{
-	of_irq_init(irq_match);
-}
-
 static void __init board_init(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table, NULL,
@@ -49,7 +37,7 @@ static void __init board_init(void)
 static const char * const bcm11351_dt_compat[] = { "bcm,bcm11351", NULL, };
 
 DT_MACHINE_START(BCM11351_DT, "Broadcom Application Processor")
-	.init_irq = init_irq,
+	.init_irq = irqchip_init,
 	.timer = &timer,
 	.init_machine = board_init,
 	.dt_compat = bcm11351_dt_compat,
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index d6d0dc6..70de42e 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -22,6 +22,7 @@
 #include <linux/of_irq.h>
 #include <linux/export.h>
 #include <linux/irqdomain.h>
+#include <linux/irqchip.h>
 #include <linux/of_address.h>
 
 #include <asm/proc-fns.h>
@@ -637,8 +638,6 @@ static int __init combiner_of_init(struct device_node *np,
 }
 
 static const struct of_device_id exynos_dt_irq_match[] = {
-	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
-	{ .compatible = "arm,cortex-a15-gic", .data = gic_of_init, },
 	{ .compatible = "samsung,exynos4210-combiner",
 			.data = combiner_of_init, },
 	{},
@@ -654,8 +653,10 @@ void __init exynos4_init_irq(void)
 	if (!of_have_populated_dt())
 		gic_init_bases(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU, gic_bank_offset, NULL);
 #ifdef CONFIG_OF
-	else
+	else {
+		irqchip_init();
 		of_irq_init(exynos_dt_irq_match);
+	}
 #endif
 
 	if (!of_have_populated_dt())
@@ -672,6 +673,7 @@ void __init exynos4_init_irq(void)
 void __init exynos5_init_irq(void)
 {
 #ifdef CONFIG_OF
+	irqchip_init();
 	of_irq_init(exynos_dt_irq_match);
 #endif
 	/*
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index d48331c..4168247 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -18,6 +18,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
@@ -32,7 +33,6 @@
 #include <asm/smp_twd.h>
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/timer-sp.h>
-#include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -66,12 +66,6 @@ void highbank_set_cpu_jump(int cpu, void *jump_addr)
 			  HB_JUMP_TABLE_PHYS(cpu) + 15);
 }
 
-const static struct of_device_id irq_match[] = {
-	{ .compatible = "arm,cortex-a15-gic", .data = gic_of_init, },
-	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
-	{}
-};
-
 #ifdef CONFIG_CACHE_L2X0
 static void highbank_l2x0_disable(void)
 {
@@ -82,7 +76,7 @@ static void highbank_l2x0_disable(void)
 
 static void __init highbank_init_irq(void)
 {
-	of_irq_init(irq_match);
+	irqchip_init();
 
 	if (of_find_compatible_node(NULL, NULL, "arm,cortex-a9"))
 		highbank_scu_map_io();
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 1fbf9a1..724bfeb 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -29,7 +30,6 @@
 #include <asm/cpuidle.h>
 #include <asm/smp_twd.h>
 #include <asm/hardware/cache-l2x0.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/system_misc.h>
@@ -221,17 +221,12 @@ static void __init imx6q_map_io(void)
 	imx6q_clock_map_io();
 }
 
-static const struct of_device_id imx6q_irq_match[] __initconst = {
-	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
-	{ /* sentinel */ }
-};
-
 static void __init imx6q_init_irq(void)
 {
 	l2x0_of_init(0, ~0UL);
 	imx_src_init();
 	imx_gpc_init();
-	of_irq_init(imx6q_irq_match);
+	irqchip_init();
 }
 
 static void __init imx6q_timer_init(void)
diff --git a/arch/arm/mach-msm/board-dt-8660.c b/arch/arm/mach-msm/board-dt-8660.c
index bd4062f9..c111cec 100644
--- a/arch/arm/mach-msm/board-dt-8660.c
+++ b/arch/arm/mach-msm/board-dt-8660.c
@@ -11,26 +11,15 @@
  */
 
 #include <linux/init.h>
+#include <linux/irqchip.h>
 #include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 
 #include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
 
 #include <mach/board.h>
 #include "common.h"
 
-static const struct of_device_id msm_dt_gic_match[] __initconst = {
-	{ .compatible = "qcom,msm-8660-qgic", .data = gic_of_init },
-	{}
-};
-
-static void __init msm8x60_init_irq(void)
-{
-	of_irq_init(msm_dt_gic_match);
-}
-
 static void __init msm8x60_init_late(void)
 {
 	smd_debugfs_init();
@@ -55,7 +44,7 @@ static const char *msm8x60_fluid_match[] __initdata = {
 DT_MACHINE_START(MSM_DT, "Qualcomm MSM (Flattened Device Tree)")
 	.smp = smp_ops(msm_smp_ops),
 	.map_io = msm_map_msm8x60_io,
-	.init_irq = msm8x60_init_irq,
+	.init_irq = irqchip_init,
 	.init_machine = msm8x60_dt_init,
 	.init_late = msm8x60_init_late,
 	.timer = &msm_dt_timer,
diff --git a/arch/arm/mach-msm/board-dt-8960.c b/arch/arm/mach-msm/board-dt-8960.c
index f45e985..fad0e50 100644
--- a/arch/arm/mach-msm/board-dt-8960.c
+++ b/arch/arm/mach-msm/board-dt-8960.c
@@ -11,24 +11,13 @@
  */
 
 #include <linux/init.h>
-#include <linux/of_irq.h>
+#include <linux/irqchip.h>
 #include <linux/of_platform.h>
 
-#include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
 
 #include "common.h"
 
-static const struct of_device_id msm_dt_gic_match[] __initconst = {
-	{ .compatible = "qcom,msm-qgic2", .data = gic_of_init },
-	{ }
-};
-
-static void __init msm_dt_init_irq(void)
-{
-	of_irq_init(msm_dt_gic_match);
-}
-
 static void __init msm_dt_init(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
@@ -42,7 +31,7 @@ static const char * const msm8960_dt_match[] __initconst = {
 DT_MACHINE_START(MSM8960_DT, "Qualcomm MSM (Flattened Device Tree)")
 	.smp = smp_ops(msm_smp_ops),
 	.map_io = msm_map_msm8960_io,
-	.init_irq = msm_dt_init_irq,
+	.init_irq = irqchip_init,
 	.timer = &msm_dt_timer,
 	.init_machine = msm_dt_init,
 	.dt_compat = msm8960_dt_match,
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 6897ae2..addd161 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/platform_device.h>
 #include <linux/memblock.h>
 #include <linux/of_irq.h>
@@ -255,16 +256,10 @@ static int __init omap4_sar_ram_init(void)
 }
 early_initcall(omap4_sar_ram_init);
 
-static struct of_device_id irq_match[] __initdata = {
-	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
-	{ .compatible = "arm,cortex-a15-gic", .data = gic_of_init, },
-	{ }
-};
-
 void __init omap_gic_of_init(void)
 {
 	omap_wakeupgen_init();
-	of_irq_init(irq_match);
+	irqchip_init();
 }
 
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index 4a8cb69..5004034 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -20,13 +20,13 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/gpio-em.h>
 #include <linux/of_platform.h>
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/io.h>
-#include <linux/of_irq.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/emev2.h>
@@ -445,26 +445,16 @@ void __init emev2_add_standard_devices_dt(void)
 			     emev2_auxdata_lookup, NULL);
 }
 
-static const struct of_device_id emev2_dt_irq_match[] = {
-	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
-	{},
-};
-
 static const char *emev2_boards_compat_dt[] __initdata = {
 	"renesas,emev2",
 	NULL,
 };
 
-void __init emev2_init_irq_dt(void)
-{
-	of_irq_init(emev2_dt_irq_match);
-}
-
 DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
 	.smp		= smp_ops(emev2_smp_ops),
 	.init_early	= emev2_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
-	.init_irq	= emev2_init_irq_dt,
+	.init_irq	= irqchip_init,
 	.init_machine	= emev2_add_standard_devices_dt,
 	.timer		= &shmobile_timer,
 	.dt_compat	= emev2_boards_compat_dt,
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 6a613b7..7d55feb 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -15,12 +15,12 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include <linux/dw_apb_timer.h>
+#include <linux/irqchip.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 
 #include <asm/hardware/cache-l2x0.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
@@ -62,11 +62,6 @@ static void __init socfpga_map_io(void)
 	early_printk("Early printk initialized\n");
 }
 
-const static struct of_device_id irq_match[] = {
-	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
-	{}
-};
-
 void __init socfpga_sysmgr_init(void)
 {
 	struct device_node *np;
@@ -78,9 +73,9 @@ void __init socfpga_sysmgr_init(void)
 	rst_manager_base_addr = of_iomap(np, 0);
 }
 
-static void __init gic_init_irq(void)
+static void __init socfpga_init_irq(void)
 {
-	of_irq_init(irq_match);
+	irqchip_init();
 	socfpga_sysmgr_init();
 }
 
@@ -105,7 +100,7 @@ static const char *altera_dt_match[] = {
 DT_MACHINE_START(SOCFPGA, "Altera SOCFPGA")
 	.smp		= smp_ops(socfpga_smp_ops),
 	.map_io		= socfpga_map_io,
-	.init_irq	= gic_init_irq,
+	.init_irq	= socfpga_init_irq,
 	.timer		= &dw_apb_timer,
 	.init_machine	= socfpga_cyclone5_init,
 	.restart	= socfpga_cyclone5_restart,
diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index c33f4d9..510dec7 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -28,7 +28,6 @@ extern struct dw_dma_slave nand_write_dma_priv;
 /* Add spear13xx family function declarations here */
 void __init spear_setup_of_timer(void);
 void __init spear13xx_map_io(void);
-void __init spear13xx_dt_init_irq(void);
 void __init spear13xx_l2x0_init(void);
 bool dw_dma_filter(struct dma_chan *chan, void *slave);
 void spear_restart(char, const char *);
diff --git a/arch/arm/mach-spear13xx/spear1310.c b/arch/arm/mach-spear13xx/spear1310.c
index 295bb04..5de3e6f 100644
--- a/arch/arm/mach-spear13xx/spear1310.c
+++ b/arch/arm/mach-spear13xx/spear1310.c
@@ -14,9 +14,9 @@
 #define pr_fmt(fmt) "SPEAr1310: " fmt
 
 #include <linux/amba/pl022.h>
+#include <linux/irqchip.h>
 #include <linux/of_platform.h>
 #include <linux/pata_arasan_cf_data.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/generic.h>
@@ -90,7 +90,7 @@ static void __init spear1310_map_io(void)
 DT_MACHINE_START(SPEAR1310_DT, "ST SPEAr1310 SoC with Flattened Device Tree")
 	.smp		=	smp_ops(spear13xx_smp_ops),
 	.map_io		=	spear1310_map_io,
-	.init_irq	=	spear13xx_dt_init_irq,
+	.init_irq	=	irqchip_init,
 	.timer		=	&spear13xx_timer,
 	.init_machine	=	spear1310_dt_init,
 	.restart	=	spear_restart,
diff --git a/arch/arm/mach-spear13xx/spear1340.c b/arch/arm/mach-spear13xx/spear1340.c
index c3a7702..18331de 100644
--- a/arch/arm/mach-spear13xx/spear1340.c
+++ b/arch/arm/mach-spear13xx/spear1340.c
@@ -18,7 +18,7 @@
 #include <linux/delay.h>
 #include <linux/dw_dmac.h>
 #include <linux/of_platform.h>
-#include <asm/hardware/gic.h>
+#include <linux/irqchip.h>
 #include <asm/mach/arch.h>
 #include <mach/dma.h>
 #include <mach/generic.h>
@@ -184,7 +184,7 @@ static const char * const spear1340_dt_board_compat[] = {
 DT_MACHINE_START(SPEAR1340_DT, "ST SPEAr1340 SoC with Flattened Device Tree")
 	.smp		=	smp_ops(spear13xx_smp_ops),
 	.map_io		=	spear13xx_map_io,
-	.init_irq	=	spear13xx_dt_init_irq,
+	.init_irq	=	irqchip_init,
 	.timer		=	&spear13xx_timer,
 	.init_machine	=	spear1340_dt_init,
 	.restart	=	spear_restart,
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index c4af775..22e3cd5 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -17,9 +17,8 @@
 #include <linux/clk.h>
 #include <linux/dw_dmac.h>
 #include <linux/err.h>
-#include <linux/of_irq.h>
+#include <linux/of.h>
 #include <asm/hardware/cache-l2x0.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
 #include <asm/smp_twd.h>
 #include <mach/dma.h>
@@ -186,13 +185,3 @@ static void __init spear13xx_timer_init(void)
 struct sys_timer spear13xx_timer = {
 	.init = spear13xx_timer_init,
 };
-
-static const struct of_device_id gic_of_match[] __initconst = {
-	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init },
-	{ /* Sentinel */ }
-};
-
-void __init spear13xx_dt_init_irq(void)
-{
-	of_irq_init(gic_of_match);
-}
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index d54cfc5..3599959 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -21,10 +21,9 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/of_irq.h>
+#include <linux/irqchip.h>
 
 #include <asm/hardware/cache-l2x0.h>
-#include <asm/hardware/gic.h>
 
 #include <mach/powergate.h>
 
@@ -57,15 +56,10 @@ u32 tegra_uart_config[4] = {
 };
 
 #ifdef CONFIG_OF
-static const struct of_device_id tegra_dt_irq_match[] __initconst = {
-	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init },
-	{ }
-};
-
 void __init tegra_dt_init_irq(void)
 {
 	tegra_init_irq();
-	of_irq_init(tegra_dt_irq_match);
+	irqchip_init();
 }
 #endif
 
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 721e7b4..a5931f7 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/platform_data/clk-ux500.h>
 
 #include <asm/hardware/gic.h>
@@ -42,11 +43,6 @@ void __iomem *_PRCMU_BASE;
  * This feels fragile because it depends on the gpio device getting probed
  * _before_ any device uses the gpio interrupts.
 */
-static const struct of_device_id ux500_dt_irq_match[] = {
-	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
-	{},
-};
-
 void __init ux500_init_irq(void)
 {
 	void __iomem *dist_base;
@@ -62,7 +58,7 @@ void __init ux500_init_irq(void)
 
 #ifdef CONFIG_OF
 	if (of_have_populated_dt())
-		of_irq_init(ux500_dt_irq_match);
+		irqchip_init();
 	else
 #endif
 		gic_init(0, 29, dist_base, cpu_base);
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 557d361..82be02b 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -7,6 +7,7 @@
 #include <linux/io.h>
 #include <linux/smp.h>
 #include <linux/init.h>
+#include <linux/irqchip.h>
 #include <linux/of_address.h>
 #include <linux/of_fdt.h>
 #include <linux/of_irq.h>
@@ -30,7 +31,6 @@
 #include <asm/mach/time.h>
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/cache-l2x0.h>
-#include <asm/hardware/gic.h>
 #include <asm/hardware/timer-sp.h>
 
 #include <mach/ct-ca9x4.h>
@@ -433,16 +433,6 @@ void __init v2m_dt_init_early(void)
 	}
 }
 
-static  struct of_device_id vexpress_irq_match[] __initdata = {
-	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
-	{}
-};
-
-static void __init v2m_dt_init_irq(void)
-{
-	of_irq_init(vexpress_irq_match);
-}
-
 static void __init v2m_dt_timer_init(void)
 {
 	struct device_node *node = NULL;
@@ -496,7 +486,7 @@ DT_MACHINE_START(VEXPRESS_DT, "ARM-Versatile Express")
 	.smp		= smp_ops(vexpress_smp_ops),
 	.map_io		= v2m_dt_map_io,
 	.init_early	= v2m_dt_init_early,
-	.init_irq	= v2m_dt_init_irq,
+	.init_irq	= irqchip_init,
 	.timer		= &v2m_dt_timer,
 	.init_machine	= v2m_dt_init,
 	.restart	= vexpress_restart,
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 40f46ae..2d96745 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -31,7 +31,6 @@
 #include <asm/mach-types.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
-#include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 
 #include "common.h"
@@ -55,19 +54,6 @@ static void __init xilinx_init_machine(void)
 	of_platform_bus_probe(NULL, zynq_of_bus_ids, NULL);
 }
 
-static struct of_device_id irq_match[] __initdata = {
-	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
-	{ }
-};
-
-/**
- * xilinx_irq_init() - Interrupt controller initialization for the GIC.
- */
-static void __init xilinx_irq_init(void)
-{
-	of_irq_init(irq_match);
-}
-
 #define SCU_PERIPH_PHYS		0xF8F00000
 #define SCU_PERIPH_SIZE		SZ_8K
 #define SCU_PERIPH_VIRT		(VMALLOC_END - SCU_PERIPH_SIZE)
@@ -117,7 +103,7 @@ static const char *xilinx_dt_match[] = {
 
 MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
 	.map_io		= xilinx_map_io,
-	.init_irq	= xilinx_irq_init,
+	.init_irq	= irqchip_init,
 	.init_machine	= xilinx_init_machine,
 	.timer		= &xttcpss_sys_timer,
 	.dt_compat	= xilinx_dt_match,
-- 
1.7.10.4
