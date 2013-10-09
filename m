From: robherring2@gmail.com (Rob Herring)
Date: Wed,  9 Oct 2013 15:55:07 -0500
Subject: [PATCH] ARM: remove name from machine_desc for DT platforms
Message-ID: <1381352107-32464-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

As part of the effort to ultimately remove struct machine_desc, the
machine name is not really needed. It is only used for /proc/cpuinfo
"Hardware" field. Get this information from the DT instead and remove
the name string in the machine descriptor for DT machine descriptors. The
model or machine compatible property from the DT is used instead.

This likely changes the name reported by /proc/cpuinfo. There could be
some userspace dependencies on the old name. Debian libdebian-installer
used to use this to determine kernel flavour, but now uses the DT
directly. It is not really a good idea for userspace to depend on this
anyway.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
This is based on my early DT clean-up series[1] which I plan to go into
3.13. This patch will require some coordination with arm-soc for any new
platforms if it goes into 3.13

Rob

[1] http://www.kernelhub.org/?p=2&msg=340878

 arch/arm/include/asm/mach/arch.h                       |  3 +--
 arch/arm/kernel/devtree.c                              |  2 +-
 arch/arm/kernel/setup.c                                |  4 ++--
 arch/arm/mach-at91/board-dt-rm9200.c                   |  2 +-
 arch/arm/mach-at91/board-dt-sam9.c                     |  2 +-
 arch/arm/mach-at91/board-dt-sama5.c                    |  2 +-
 arch/arm/mach-bcm/board_bcm281xx.c                     |  2 +-
 arch/arm/mach-bcm2835/bcm2835.c                        |  2 +-
 arch/arm/mach-cns3xxx/core.c                           |  2 +-
 arch/arm/mach-davinci/da8xx-dt.c                       |  2 +-
 arch/arm/mach-dove/board-dt.c                          |  2 +-
 arch/arm/mach-exynos/mach-exynos4-dt.c                 |  2 +-
 arch/arm/mach-exynos/mach-exynos5-dt.c                 |  2 +-
 arch/arm/mach-highbank/highbank.c                      |  2 +-
 arch/arm/mach-imx/imx25-dt.c                           |  2 +-
 arch/arm/mach-imx/imx27-dt.c                           |  2 +-
 arch/arm/mach-imx/imx31-dt.c                           |  2 +-
 arch/arm/mach-imx/imx51-dt.c                           |  2 +-
 arch/arm/mach-imx/mach-imx53.c                         |  2 +-
 arch/arm/mach-imx/mach-imx6q.c                         |  2 +-
 arch/arm/mach-imx/mach-imx6sl.c                        |  2 +-
 arch/arm/mach-imx/mach-vf610.c                         |  2 +-
 arch/arm/mach-integrator/integrator_ap.c               |  2 +-
 arch/arm/mach-integrator/integrator_cp.c               |  2 +-
 arch/arm/mach-keystone/keystone.c                      |  2 +-
 arch/arm/mach-kirkwood/board-dt.c                      |  2 +-
 arch/arm/mach-lpc32xx/phy3250.c                        |  2 +-
 arch/arm/mach-mmp/mmp-dt.c                             |  4 ++--
 arch/arm/mach-mmp/mmp2-dt.c                            |  2 +-
 arch/arm/mach-msm/board-dt-8660.c                      |  2 +-
 arch/arm/mach-msm/board-dt-8960.c                      |  2 +-
 arch/arm/mach-mvebu/armada-370-xp.c                    |  2 +-
 arch/arm/mach-mxs/mach-mxs.c                           |  2 +-
 arch/arm/mach-nomadik/cpu-8815.c                       |  2 +-
 arch/arm/mach-nspire/nspire.c                          |  2 +-
 arch/arm/mach-omap2/board-generic.c                    | 18 +++++++++---------
 arch/arm/mach-orion5x/board-dt.c                       |  2 +-
 arch/arm/mach-picoxcell/common.c                       |  2 +-
 arch/arm/mach-prima2/common.c                          |  6 +++---
 arch/arm/mach-pxa/pxa-dt.c                             |  2 +-
 arch/arm/mach-rockchip/rockchip.c                      |  2 +-
 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c                |  2 +-
 arch/arm/mach-shmobile/board-ape6evm-reference.c       |  2 +-
 arch/arm/mach-shmobile/board-ape6evm.c                 |  2 +-
 .../mach-shmobile/board-armadillo800eva-reference.c    |  2 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c         |  2 +-
 arch/arm/mach-shmobile/board-bockw-reference.c         |  2 +-
 arch/arm/mach-shmobile/board-bockw.c                   |  2 +-
 arch/arm/mach-shmobile/board-kzm9d-reference.c         |  2 +-
 arch/arm/mach-shmobile/board-kzm9d.c                   |  2 +-
 arch/arm/mach-shmobile/board-kzm9g-reference.c         |  2 +-
 arch/arm/mach-shmobile/board-kzm9g.c                   |  2 +-
 arch/arm/mach-shmobile/board-lager-reference.c         |  2 +-
 arch/arm/mach-shmobile/board-lager.c                   |  2 +-
 arch/arm/mach-shmobile/board-mackerel.c                |  2 +-
 arch/arm/mach-shmobile/board-marzen-reference.c        |  2 +-
 arch/arm/mach-shmobile/board-marzen.c                  |  2 +-
 arch/arm/mach-shmobile/setup-emev2.c                   |  2 +-
 arch/arm/mach-shmobile/setup-r8a73a4.c                 |  2 +-
 arch/arm/mach-shmobile/setup-r8a7740.c                 |  2 +-
 arch/arm/mach-shmobile/setup-r8a7778.c                 |  2 +-
 arch/arm/mach-shmobile/setup-r8a7779.c                 |  2 +-
 arch/arm/mach-shmobile/setup-r8a7790.c                 |  2 +-
 arch/arm/mach-shmobile/setup-sh7372.c                  |  2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c                  |  2 +-
 arch/arm/mach-socfpga/socfpga.c                        |  2 +-
 arch/arm/mach-spear/spear1310.c                        |  2 +-
 arch/arm/mach-spear/spear1340.c                        |  2 +-
 arch/arm/mach-spear/spear300.c                         |  2 +-
 arch/arm/mach-spear/spear310.c                         |  2 +-
 arch/arm/mach-spear/spear320.c                         |  2 +-
 arch/arm/mach-spear/spear6xx.c                         |  2 +-
 arch/arm/mach-sti/board-dt.c                           |  2 +-
 arch/arm/mach-sunxi/sunxi.c                            |  2 +-
 arch/arm/mach-tegra/tegra.c                            |  2 +-
 arch/arm/mach-u300/core.c                              |  2 +-
 arch/arm/mach-ux500/cpu-db8500.c                       |  2 +-
 arch/arm/mach-versatile/versatile_dt.c                 |  2 +-
 arch/arm/mach-vexpress/v2m.c                           |  2 +-
 arch/arm/mach-virt/virt.c                              |  2 +-
 arch/arm/mach-vt8500/vt8500.c                          |  2 +-
 arch/arm/mach-zynq/common.c                            |  2 +-
 82 files changed, 94 insertions(+), 95 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 402a2bc..3c82227 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -88,11 +88,10 @@ static const struct machine_desc __mach_desc_##_type	\
 #define MACHINE_END				\
 };
 
-#define DT_MACHINE_START(_name, _namestr)		\
+#define DT_MACHINE_START(_name)		\
 static const struct machine_desc __mach_desc_##_name	\
  __used							\
  __attribute__((__section__(".arch.info.init"))) = {	\
 	.nr		= ~0,				\
-	.name		= _namestr,
 
 #endif
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 739c3df..46e3aff 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -199,7 +199,7 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 	const struct machine_desc *mdesc, *mdesc_best = NULL;
 
 #ifdef CONFIG_ARCH_MULTIPLATFORM
-	DT_MACHINE_START(GENERIC_DT, "Generic DT based system")
+	DT_MACHINE_START(GENERIC_DT)
 	MACHINE_END
 
 	mdesc_best = &__mach_desc_GENERIC_DT;
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 0e1e2b3..b0747bb 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -611,7 +611,7 @@ void __init dump_machine_table(void)
 
 	early_print("Available machine support:\n\nID (hex)\tNAME\n");
 	for_each_machine_desc(p)
-		early_print("%08x\t%s\n", p->nr, p->name);
+		early_print("%08x\t%s\n", p->nr, p->name ? p->name : *p->dt_compat);
 
 	early_print("\nPlease check your kernel config and/or bootloader.\n");
 
@@ -859,7 +859,7 @@ void __init setup_arch(char **cmdline_p)
 	if (!mdesc)
 		mdesc = setup_machine_tags(__atags_pointer, __machine_arch_type);
 	machine_desc = mdesc;
-	machine_name = mdesc->name;
+	machine_name = mdesc->name ? mdesc->name : of_flat_dt_get_machine_name();
 
 	setup_dma_zone(mdesc);
 
diff --git a/arch/arm/mach-at91/board-dt-rm9200.c b/arch/arm/mach-at91/board-dt-rm9200.c
index 3fcb662..d136d54 100644
--- a/arch/arm/mach-at91/board-dt-rm9200.c
+++ b/arch/arm/mach-at91/board-dt-rm9200.c
@@ -46,7 +46,7 @@ static const char *at91rm9200_dt_board_compat[] __initdata = {
 	NULL
 };
 
-DT_MACHINE_START(at91rm9200_dt, "Atmel AT91RM9200 (Device Tree)")
+DT_MACHINE_START(at91rm9200_dt)
 	.init_time      = at91rm9200_timer_init,
 	.map_io		= at91_map_io,
 	.handle_irq	= at91_aic_handle_irq,
diff --git a/arch/arm/mach-at91/board-dt-sam9.c b/arch/arm/mach-at91/board-dt-sam9.c
index 8db3013..8353827 100644
--- a/arch/arm/mach-at91/board-dt-sam9.c
+++ b/arch/arm/mach-at91/board-dt-sam9.c
@@ -47,7 +47,7 @@ static const char *at91_dt_board_compat[] __initdata = {
 	NULL
 };
 
-DT_MACHINE_START(at91sam_dt, "Atmel AT91SAM (Device Tree)")
+DT_MACHINE_START(at91sam_dt)
 	/* Maintainer: Atmel */
 	.init_time	= at91sam926x_pit_init,
 	.map_io		= at91_map_io,
diff --git a/arch/arm/mach-at91/board-dt-sama5.c b/arch/arm/mach-at91/board-dt-sama5.c
index bf00d15..2e2699d 100644
--- a/arch/arm/mach-at91/board-dt-sama5.c
+++ b/arch/arm/mach-at91/board-dt-sama5.c
@@ -70,7 +70,7 @@ static const char *sama5_dt_board_compat[] __initdata = {
 	NULL
 };
 
-DT_MACHINE_START(sama5_dt, "Atmel SAMA5 (Device Tree)")
+DT_MACHINE_START(sama5_dt)
 	/* Maintainer: Atmel */
 	.init_time	= at91sam926x_pit_init,
 	.map_io		= at91_map_io,
diff --git a/arch/arm/mach-bcm/board_bcm281xx.c b/arch/arm/mach-bcm/board_bcm281xx.c
index 8d9f931..bd2b496 100644
--- a/arch/arm/mach-bcm/board_bcm281xx.c
+++ b/arch/arm/mach-bcm/board_bcm281xx.c
@@ -67,7 +67,7 @@ static void __init board_init(void)
 
 static const char * const bcm11351_dt_compat[] = { "brcm,bcm11351", NULL, };
 
-DT_MACHINE_START(BCM11351_DT, "Broadcom Application Processor")
+DT_MACHINE_START(BCM11351_DT)
 	.init_time = clocksource_of_init,
 	.init_machine = board_init,
 	.restart = bcm_kona_restart,
diff --git a/arch/arm/mach-bcm2835/bcm2835.c b/arch/arm/mach-bcm2835/bcm2835.c
index 40686d7..c90b06f 100644
--- a/arch/arm/mach-bcm2835/bcm2835.c
+++ b/arch/arm/mach-bcm2835/bcm2835.c
@@ -129,7 +129,7 @@ static const char * const bcm2835_compat[] = {
 	NULL
 };
 
-DT_MACHINE_START(BCM2835, "BCM2835")
+DT_MACHINE_START(BCM2835)
 	.map_io = bcm2835_map_io,
 	.init_irq = bcm2835_init_irq,
 	.handle_irq = bcm2835_handle_irq,
diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index e38b279..8bf66ac 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -366,7 +366,7 @@ static const char *cns3xxx_dt_compat[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(CNS3XXX_DT, "Cavium Networks CNS3xxx")
+DT_MACHINE_START(CNS3XXX_DT)
 	.dt_compat	= cns3xxx_dt_compat,
 	.nr_irqs	= NR_IRQS_CNS3XXX,
 	.map_io		= cns3xxx_map_io,
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index d2bc574..974afaf 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -65,7 +65,7 @@ static const char *da850_boards_compat[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(DA850_DT, "Generic DA850/OMAP-L138/AM18x")
+DT_MACHINE_START(DA850_DT)
 	.map_io		= da850_init,
 	.init_irq	= da8xx_init_irq,
 	.init_time	= davinci_timer_init,
diff --git a/arch/arm/mach-dove/board-dt.c b/arch/arm/mach-dove/board-dt.c
index 49f72a8..2350cc7 100644
--- a/arch/arm/mach-dove/board-dt.c
+++ b/arch/arm/mach-dove/board-dt.c
@@ -81,7 +81,7 @@ static const char * const dove_dt_board_compat[] = {
 	NULL
 };
 
-DT_MACHINE_START(DOVE_DT, "Marvell Dove (Flattened Device Tree)")
+DT_MACHINE_START(DOVE_DT)
 	.map_io		= dove_map_io,
 	.init_early	= dove_dt_init_early,
 	.init_time	= dove_dt_time_init,
diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index 0099c6c..61f943b 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -47,7 +47,7 @@ static void __init exynos4_reserve(void)
 				mfc_mem.lsize);
 #endif
 }
-DT_MACHINE_START(EXYNOS4210_DT, "Samsung Exynos4 (Flattened Device Tree)")
+DT_MACHINE_START(EXYNOS4210_DT)
 	/* Maintainer: Thomas Abraham <thomas.abraham@linaro.org> */
 	.smp		= smp_ops(exynos_smp_ops),
 	.map_io		= exynos_init_io,
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index f874b77..e5f350a 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -70,7 +70,7 @@ static void __init exynos5_reserve(void)
 #endif
 }
 
-DT_MACHINE_START(EXYNOS5_DT, "SAMSUNG EXYNOS5 (Flattened Device Tree)")
+DT_MACHINE_START(EXYNOS5_DT)
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	.smp		= smp_ops(exynos_smp_ops),
 	.map_io		= exynos_init_io,
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 8e63ccd..1a2ba0c 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -170,7 +170,7 @@ static const char *highbank_match[] __initconst = {
 	NULL,
 };
 
-DT_MACHINE_START(HIGHBANK, "Highbank")
+DT_MACHINE_START(HIGHBANK)
 #if defined(CONFIG_ZONE_DMA) && defined(CONFIG_ARM_LPAE)
 	.dma_zone_size	= (4ULL * SZ_1G),
 #endif
diff --git a/arch/arm/mach-imx/imx25-dt.c b/arch/arm/mach-imx/imx25-dt.c
index 3e1ec5f..25401d9 100644
--- a/arch/arm/mach-imx/imx25-dt.c
+++ b/arch/arm/mach-imx/imx25-dt.c
@@ -34,7 +34,7 @@ static void __init imx25_timer_init(void)
 	mx25_clocks_init_dt();
 }
 
-DT_MACHINE_START(IMX25_DT, "Freescale i.MX25 (Device Tree Support)")
+DT_MACHINE_START(IMX25_DT)
 	.map_io		= mx25_map_io,
 	.init_early	= imx25_init_early,
 	.init_irq	= mx25_init_irq,
diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
index 4e235ec..3d35369 100644
--- a/arch/arm/mach-imx/imx27-dt.c
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -39,7 +39,7 @@ static void __init imx27_timer_init(void)
 	mx27_clocks_init_dt();
 }
 
-DT_MACHINE_START(IMX27_DT, "Freescale i.MX27 (Device Tree Support)")
+DT_MACHINE_START(IMX27_DT)
 	.map_io		= mx27_map_io,
 	.init_early	= imx27_init_early,
 	.init_irq	= mx27_init_irq,
diff --git a/arch/arm/mach-imx/imx31-dt.c b/arch/arm/mach-imx/imx31-dt.c
index 818a1cc..6c60dfa 100644
--- a/arch/arm/mach-imx/imx31-dt.c
+++ b/arch/arm/mach-imx/imx31-dt.c
@@ -35,7 +35,7 @@ static void __init imx31_dt_timer_init(void)
 	mx31_clocks_init_dt();
 }
 
-DT_MACHINE_START(IMX31_DT, "Freescale i.MX31 (Device Tree Support)")
+DT_MACHINE_START(IMX31_DT)
 	.map_io		= mx31_map_io,
 	.init_early	= imx31_init_early,
 	.init_irq	= mx31_init_irq,
diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
index 53e43e5..025db17 100644
--- a/arch/arm/mach-imx/imx51-dt.c
+++ b/arch/arm/mach-imx/imx51-dt.c
@@ -39,7 +39,7 @@ static void __init imx51_timer_init(void)
 	mx51_clocks_init_dt();
 }
 
-DT_MACHINE_START(IMX51_DT, "Freescale i.MX51 (Device Tree Support)")
+DT_MACHINE_START(IMX51_DT)
 	.map_io		= mx51_map_io,
 	.init_early	= imx51_init_early,
 	.init_irq	= mx51_init_irq,
diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 98c5894..8e0f186 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -41,7 +41,7 @@ static void __init imx53_timer_init(void)
 	mx53_clocks_init_dt();
 }
 
-DT_MACHINE_START(IMX53_DT, "Freescale i.MX53 (Device Tree Support)")
+DT_MACHINE_START(IMX53_DT)
 	.map_io		= mx53_map_io,
 	.init_early	= imx53_init_early,
 	.init_irq	= mx53_init_irq,
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 90372a2..cbdaaa4 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -307,7 +307,7 @@ static const char *imx6q_dt_compat[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad/DualLite (Device Tree)")
+DT_MACHINE_START(IMX6Q)
 	.smp		= smp_ops(imx_smp_ops),
 	.map_io		= imx6q_map_io,
 	.init_irq	= imx6q_init_irq,
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index 0d75dc5..d9ef20d 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -41,7 +41,7 @@ static const char *imx6sl_dt_compat[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(IMX6SL, "Freescale i.MX6 SoloLite (Device Tree)")
+DT_MACHINE_START(IMX6SL)
 	.map_io		= debug_ll_io_init,
 	.init_irq	= imx6sl_init_irq,
 	.init_time	= imx6sl_timer_init,
diff --git a/arch/arm/mach-imx/mach-vf610.c b/arch/arm/mach-imx/mach-vf610.c
index 816991d..a354dd2 100644
--- a/arch/arm/mach-imx/mach-vf610.c
+++ b/arch/arm/mach-imx/mach-vf610.c
@@ -39,7 +39,7 @@ static const char *vf610_dt_compat[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(VYBRID_VF610, "Freescale Vybrid VF610 (Device Tree)")
+DT_MACHINE_START(VYBRID_VF610)
 	.init_irq	= vf610_init_irq,
 	.init_time	= vf610_init_time,
 	.init_machine   = vf610_init_machine,
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index d9e95e6..03cbb3e 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -553,7 +553,7 @@ static const char * ap_dt_board_compat[] = {
 	NULL,
 };
 
-DT_MACHINE_START(INTEGRATOR_AP_DT, "ARM Integrator/AP (Device Tree)")
+DT_MACHINE_START(INTEGRATOR_AP_DT)
 	.reserve	= integrator_reserve,
 	.map_io		= ap_map_io,
 	.init_early	= ap_init_early,
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 8c60fcb..36e861a 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -344,7 +344,7 @@ static const char * intcp_dt_board_compat[] = {
 	NULL,
 };
 
-DT_MACHINE_START(INTEGRATOR_CP_DT, "ARM Integrator/CP (Device Tree)")
+DT_MACHINE_START(INTEGRATOR_CP_DT)
 	.reserve	= integrator_reserve,
 	.map_io		= intcp_map_io,
 	.init_early	= intcp_init_early,
diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index b661c5c..a22b3e6 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -67,7 +67,7 @@ void keystone_restart(enum reboot_mode mode, const char *cmd)
 	writel(val, keystone_rstctrl);
 }
 
-DT_MACHINE_START(KEYSTONE, "Keystone")
+DT_MACHINE_START(KEYSTONE)
 	.smp		= smp_ops(keystone_smp_ops),
 	.init_machine	= keystone_init,
 	.dt_compat	= keystone_match,
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 82d3ad8..eabe521 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -118,7 +118,7 @@ static const char * const kirkwood_dt_board_compat[] = {
 	NULL
 };
 
-DT_MACHINE_START(KIRKWOOD_DT, "Marvell Kirkwood (Flattened Device Tree)")
+DT_MACHINE_START(KIRKWOOD_DT)
 	/* Maintainer: Jason Cooper <jason@lakedaemon.net> */
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_dt_init_early,
diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index e54f87e..b5e58f7 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -259,7 +259,7 @@ static char const *lpc32xx_dt_compat[] __initdata = {
 	NULL
 };
 
-DT_MACHINE_START(LPC32XX_DT, "LPC32XX SoC (Flattened Device Tree)")
+DT_MACHINE_START(LPC32XX_DT)
 	.atag_offset	= 0x100,
 	.map_io		= lpc32xx_map_io,
 	.init_irq	= lpc32xx_init_irq,
diff --git a/arch/arm/mach-mmp/mmp-dt.c b/arch/arm/mach-mmp/mmp-dt.c
index cca529c..f528529 100644
--- a/arch/arm/mach-mmp/mmp-dt.c
+++ b/arch/arm/mach-mmp/mmp-dt.c
@@ -58,14 +58,14 @@ static const char *mmp_dt_board_compat[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(PXA168_DT, "Marvell PXA168 (Device Tree Support)")
+DT_MACHINE_START(PXA168_DT)
 	.map_io		= mmp_map_io,
 	.init_time	= mmp_dt_init_timer,
 	.init_machine	= pxa168_dt_init,
 	.dt_compat	= mmp_dt_board_compat,
 MACHINE_END
 
-DT_MACHINE_START(PXA910_DT, "Marvell PXA910 (Device Tree Support)")
+DT_MACHINE_START(PXA910_DT)
 	.map_io		= mmp_map_io,
 	.init_time	= mmp_dt_init_timer,
 	.init_machine	= pxa910_dt_init,
diff --git a/arch/arm/mach-mmp/mmp2-dt.c b/arch/arm/mach-mmp/mmp2-dt.c
index 023cb45..6bb0144 100644
--- a/arch/arm/mach-mmp/mmp2-dt.c
+++ b/arch/arm/mach-mmp/mmp2-dt.c
@@ -42,7 +42,7 @@ static const char *mmp2_dt_board_compat[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(MMP2_DT, "Marvell MMP2 (Device Tree Support)")
+DT_MACHINE_START(MMP2_DT)
 	.map_io		= mmp_map_io,
 	.init_time	= mmp_dt_init_timer,
 	.init_machine	= mmp2_dt_init,
diff --git a/arch/arm/mach-msm/board-dt-8660.c b/arch/arm/mach-msm/board-dt-8660.c
index c294689..058462d 100644
--- a/arch/arm/mach-msm/board-dt-8660.c
+++ b/arch/arm/mach-msm/board-dt-8660.c
@@ -40,7 +40,7 @@ static const char *msm8x60_fluid_match[] __initdata = {
 	NULL
 };
 
-DT_MACHINE_START(MSM_DT, "Qualcomm MSM (Flattened Device Tree)")
+DT_MACHINE_START(MSM_DT)
 	.smp = smp_ops(msm_smp_ops),
 	.init_machine = msm8x60_dt_init,
 	.init_late = msm8x60_init_late,
diff --git a/arch/arm/mach-msm/board-dt-8960.c b/arch/arm/mach-msm/board-dt-8960.c
index d4ca52c..62602421 100644
--- a/arch/arm/mach-msm/board-dt-8960.c
+++ b/arch/arm/mach-msm/board-dt-8960.c
@@ -28,7 +28,7 @@ static const char * const msm8960_dt_match[] __initconst = {
 	NULL
 };
 
-DT_MACHINE_START(MSM8960_DT, "Qualcomm MSM (Flattened Device Tree)")
+DT_MACHINE_START(MSM8960_DT)
 	.smp = smp_ops(msm_smp_ops),
 	.init_machine = msm_dt_init,
 	.dt_compat = msm8960_dt_match,
diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index e2acff9..168a963 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -55,7 +55,7 @@ static const char * const armada_370_xp_dt_compat[] = {
 	NULL,
 };
 
-DT_MACHINE_START(ARMADA_XP_DT, "Marvell Armada 370/XP (Device Tree)")
+DT_MACHINE_START(ARMADA_XP_DT)
 	.smp		= smp_ops(armada_xp_smp_ops),
 	.init_machine	= armada_370_xp_dt_init,
 	.map_io		= armada_370_xp_map_io,
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 98f6e2a..b81344f 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -506,7 +506,7 @@ static const char *mxs_dt_compat[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(MXS, "Freescale MXS (Device Tree)")
+DT_MACHINE_START(MXS)
 	.handle_irq	= icoll_handle_irq,
 	.init_time	= mxs_timer_init,
 	.init_machine	= mxs_machine_init,
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 13e0df9..43618fd 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -257,7 +257,7 @@ static const char * cpu8815_board_compat[] = {
 	NULL,
 };
 
-DT_MACHINE_START(NOMADIK_DT, "Nomadik STn8815")
+DT_MACHINE_START(NOMADIK_DT)
 	.map_io		= cpu8815_map_io,
 	.init_time	= cpu8815_timer_init_of,
 	.init_machine	= cpu8815_init_of,
diff --git a/arch/arm/mach-nspire/nspire.c b/arch/arm/mach-nspire/nspire.c
index 99e2609..03a5418 100644
--- a/arch/arm/mach-nspire/nspire.c
+++ b/arch/arm/mach-nspire/nspire.c
@@ -80,7 +80,7 @@ static void nspire_restart(char mode, const char *cmd)
 	writel(2, base + NSPIRE_MISC_HWRESET);
 }
 
-DT_MACHINE_START(NSPIRE, "TI-NSPIRE")
+DT_MACHINE_START(NSPIRE)
 	.dt_compat	= nspire_dt_match,
 	.map_io		= nspire_map_io,
 	.init_time	= nspire_init_time,
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 39c7838..924255a 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -78,7 +78,7 @@ static const char *omap242x_boards_compat[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(OMAP242X_DT, "Generic OMAP2420 (Flattened Device Tree)")
+DT_MACHINE_START(OMAP242X_DT)
 	.reserve	= omap_reserve,
 	.map_io		= omap242x_map_io,
 	.init_early	= omap2420_init_early,
@@ -97,7 +97,7 @@ static const char *omap243x_boards_compat[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(OMAP243X_DT, "Generic OMAP2430 (Flattened Device Tree)")
+DT_MACHINE_START(OMAP243X_DT)
 	.reserve	= omap_reserve,
 	.map_io		= omap243x_map_io,
 	.init_early	= omap2430_init_early,
@@ -116,7 +116,7 @@ static const char *omap3_boards_compat[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
+DT_MACHINE_START(OMAP3_DT)
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3430_init_early,
@@ -135,7 +135,7 @@ static const char *omap3_gp_boards_compat[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(OMAP3_GP_DT, "Generic OMAP3-GP (Flattened Device Tree)")
+DT_MACHINE_START(OMAP3_GP_DT)
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap3430_init_early,
@@ -155,7 +155,7 @@ static const char *am33xx_boards_compat[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
+DT_MACHINE_START(AM33XX_DT)
 	.reserve	= omap_reserve,
 	.map_io		= am33xx_map_io,
 	.init_early	= am33xx_init_early,
@@ -174,7 +174,7 @@ static const char *omap4_boards_compat[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
+DT_MACHINE_START(OMAP4_DT)
 	.reserve	= omap_reserve,
 	.smp		= smp_ops(omap4_smp_ops),
 	.map_io		= omap4_map_io,
@@ -194,7 +194,7 @@ static const char *omap5_boards_compat[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(OMAP5_DT, "Generic OMAP5 (Flattened Device Tree)")
+DT_MACHINE_START(OMAP5_DT)
 	.reserve	= omap_reserve,
 	.smp		= smp_ops(omap4_smp_ops),
 	.map_io		= omap5_map_io,
@@ -213,7 +213,7 @@ static const char *am43_boards_compat[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(AM43_DT, "Generic AM43 (Flattened Device Tree)")
+DT_MACHINE_START(AM43_DT)
 	.map_io		= am33xx_map_io,
 	.init_early	= am43xx_init_early,
 	.init_irq	= omap_gic_of_init,
@@ -229,7 +229,7 @@ static const char *dra7xx_boards_compat[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(DRA7XX_DT, "Generic DRA7XX (Flattened Device Tree)")
+DT_MACHINE_START(DRA7XX_DT)
 	.reserve	= omap_reserve,
 	.smp		= smp_ops(omap4_smp_ops),
 	.map_io		= omap5_map_io,
diff --git a/arch/arm/mach-orion5x/board-dt.c b/arch/arm/mach-orion5x/board-dt.c
index b91002c..ee2d6e9 100644
--- a/arch/arm/mach-orion5x/board-dt.c
+++ b/arch/arm/mach-orion5x/board-dt.c
@@ -68,7 +68,7 @@ static const char *orion5x_dt_compat[] = {
 	NULL,
 };
 
-DT_MACHINE_START(ORION5X_DT, "Marvell Orion5x (Flattened Device Tree)")
+DT_MACHINE_START(ORION5X_DT)
 	/* Maintainer: Thomas Petazzoni <thomas.petazzoni@free-electrons.com> */
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
index ec79fea..ffe1270 100644
--- a/arch/arm/mach-picoxcell/common.c
+++ b/arch/arm/mach-picoxcell/common.c
@@ -78,7 +78,7 @@ static void picoxcell_wdt_restart(enum reboot_mode mode, const char *cmd)
 	}
 }
 
-DT_MACHINE_START(PICOXCELL, "Picochip picoXcell")
+DT_MACHINE_START(PICOXCELL)
 	.map_io		= picoxcell_map_io,
 	.init_machine	= picoxcell_init_machine,
 	.dt_compat	= picoxcell_dt_match,
diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index e110b6d..3d190f5 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -40,7 +40,7 @@ static const char *atlas6_dt_match[] __initdata = {
 	NULL
 };
 
-DT_MACHINE_START(ATLAS6_DT, "Generic ATLAS6 (Flattened Device Tree)")
+DT_MACHINE_START(ATLAS6_DT)
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
 	.map_io         = sirfsoc_map_io,
 	.init_time	= sirfsoc_init_time,
@@ -56,7 +56,7 @@ static const char *prima2_dt_match[] __initdata = {
 	NULL
 };
 
-DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
+DT_MACHINE_START(PRIMA2_DT)
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
 	.map_io         = sirfsoc_map_io,
 	.init_time	= sirfsoc_init_time,
@@ -73,7 +73,7 @@ static const char *marco_dt_match[] __initdata = {
 	NULL
 };
 
-DT_MACHINE_START(MARCO_DT, "Generic MARCO (Flattened Device Tree)")
+DT_MACHINE_START(MARCO_DT)
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
 	.smp            = smp_ops(sirfsoc_smp_ops),
 	.map_io         = sirfsoc_map_io,
diff --git a/arch/arm/mach-pxa/pxa-dt.c b/arch/arm/mach-pxa/pxa-dt.c
index f6a2c4b..b7fcb0c 100644
--- a/arch/arm/mach-pxa/pxa-dt.c
+++ b/arch/arm/mach-pxa/pxa-dt.c
@@ -51,7 +51,7 @@ static const char *pxa3xx_dt_board_compat[] __initdata = {
 #endif
 
 #ifdef CONFIG_PXA3xx
-DT_MACHINE_START(PXA_DT, "Marvell PXA3xx (Device Tree Support)")
+DT_MACHINE_START(PXA_DT)
 	.map_io		= pxa3xx_map_io,
 	.init_irq	= pxa3xx_dt_init_irq,
 	.handle_irq	= pxa3xx_handle_irq,
diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index 724d2d8..7eed075 100644
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -45,7 +45,7 @@ static const char * const rockchip_board_dt_compat[] = {
 	NULL,
 };
 
-DT_MACHINE_START(ROCKCHIP_DT, "Rockchip Cortex-A9 (Device Tree)")
+DT_MACHINE_START(ROCKCHIP_DT)
 	.init_machine	= rockchip_dt_init,
 	.init_time	= rockchip_timer_init,
 	.dt_compat	= rockchip_board_dt_compat,
diff --git a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
index f50454a..a6ae5d7 100644
--- a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
+++ b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
@@ -80,7 +80,7 @@ static char const *s3c2416_dt_compat[] __initdata = {
 	NULL
 };
 
-DT_MACHINE_START(S3C2416_DT, "Samsung S3C2416 (Flattened Device Tree)")
+DT_MACHINE_START(S3C2416_DT)
 	/* Maintainer: Heiko Stuebner <heiko@sntech.de> */
 	.dt_compat	= s3c2416_dt_compat,
 	.map_io		= s3c2416_dt_map_io,
diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
index a23fa71..cade0db 100644
--- a/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ b/arch/arm/mach-shmobile/board-ape6evm-reference.c
@@ -56,7 +56,7 @@ static const char *ape6evm_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(APE6EVM_DT, "ape6evm")
+DT_MACHINE_START(APE6EVM_DT)
 	.init_early	= r8a73a4_init_delay,
 	.init_machine	= ape6evm_add_standard_devices,
 	.dt_compat	= ape6evm_boards_compat_dt,
diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 24b87eea..6717c6b 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -239,7 +239,7 @@ static const char *ape6evm_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(APE6EVM_DT, "ape6evm")
+DT_MACHINE_START(APE6EVM_DT)
 	.init_early	= r8a73a4_init_delay,
 	.init_machine	= ape6evm_add_standard_devices,
 	.dt_compat	= ape6evm_boards_compat_dt,
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index 57d1a78..ea3b1e1 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -185,7 +185,7 @@ static const char *eva_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva-reference")
+DT_MACHINE_START(ARMADILLO800EVA_DT)
 	.map_io		= r8a7740_map_io,
 	.init_early	= r8a7740_init_delay,
 	.init_irq	= r8a7740_init_irq_of,
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 5bd1479..0e7a522 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1310,7 +1310,7 @@ static const char *eva_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva")
+DT_MACHINE_START(ARMADILLO800EVA_DT)
 	.map_io		= r8a7740_map_io,
 	.init_early	= eva_add_early_devices,
 	.init_irq	= r8a7740_init_irq_of,
diff --git a/arch/arm/mach-shmobile/board-bockw-reference.c b/arch/arm/mach-shmobile/board-bockw-reference.c
index 1a7c893..3388a62 100644
--- a/arch/arm/mach-shmobile/board-bockw-reference.c
+++ b/arch/arm/mach-shmobile/board-bockw-reference.c
@@ -53,7 +53,7 @@ static const char *bockw_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(BOCKW_DT, "bockw")
+DT_MACHINE_START(BOCKW_DT)
 	.init_early	= r8a7778_init_delay,
 	.init_irq	= r8a7778_init_irq_dt,
 	.init_machine	= bockw_init,
diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 6b9faf3..b64f674 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -315,7 +315,7 @@ static const char *bockw_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(BOCKW_DT, "bockw")
+DT_MACHINE_START(BOCKW_DT)
 	.init_early	= r8a7778_init_delay,
 	.init_irq	= r8a7778_init_irq_dt,
 	.init_machine	= bockw_init,
diff --git a/arch/arm/mach-shmobile/board-kzm9d-reference.c b/arch/arm/mach-shmobile/board-kzm9d-reference.c
index 8f8bb2fa..e2af95e 100644
--- a/arch/arm/mach-shmobile/board-kzm9d-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9d-reference.c
@@ -37,7 +37,7 @@ static const char *kzm9d_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(KZM9D_DT, "kzm9d")
+DT_MACHINE_START(KZM9D_DT)
 	.smp		= smp_ops(emev2_smp_ops),
 	.map_io		= emev2_map_io,
 	.init_early	= emev2_init_delay,
diff --git a/arch/arm/mach-shmobile/board-kzm9d.c b/arch/arm/mach-shmobile/board-kzm9d.c
index 30c2cc6..a6ed124 100644
--- a/arch/arm/mach-shmobile/board-kzm9d.c
+++ b/arch/arm/mach-shmobile/board-kzm9d.c
@@ -82,7 +82,7 @@ static const char *kzm9d_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(KZM9D_DT, "kzm9d")
+DT_MACHINE_START(KZM9D_DT)
 	.smp		= smp_ops(emev2_smp_ops),
 	.map_io		= emev2_map_io,
 	.init_early	= emev2_init_delay,
diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index 598e324..c345976 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -46,7 +46,7 @@ static const char *kzm9g_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
+DT_MACHINE_START(KZM9G_DT)
 	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_init_delay,
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index f199496..5896b8b 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -903,7 +903,7 @@ static const char *kzm9g_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(KZM9G_DT, "kzm9g")
+DT_MACHINE_START(KZM9G_DT)
 	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_add_early_devices,
diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 9c316a1..8d1a8b9 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -37,7 +37,7 @@ static const char *lager_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(LAGER_DT, "lager")
+DT_MACHINE_START(LAGER_DT)
 	.init_early	= r8a7790_init_delay,
 	.init_machine	= lager_add_standard_devices,
 	.init_time	= r8a7790_timer_init,
diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index ffb6f0a..bd9db23 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -160,7 +160,7 @@ static const char *lager_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(LAGER_DT, "lager")
+DT_MACHINE_START(LAGER_DT)
 	.init_early	= r8a7790_init_delay,
 	.init_time	= r8a7790_timer_init,
 	.init_machine	= lager_add_standard_devices,
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index af06753..e033b93 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1510,7 +1510,7 @@ static const char *mackerel_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(MACKEREL_DT, "mackerel")
+DT_MACHINE_START(MACKEREL_DT)
 	.map_io		= sh7372_map_io,
 	.init_early	= sh7372_add_early_devices,
 	.init_irq	= sh7372_init_irq,
diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 3f4250a..ab98ab2 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -35,7 +35,7 @@ static const char *marzen_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(MARZEN, "marzen")
+DT_MACHINE_START(MARZEN)
 	.smp		= smp_ops(r8a7779_smp_ops),
 	.map_io		= r8a7779_map_io,
 	.init_early	= r8a7779_init_delay,
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 3f5044f..1094871 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -304,7 +304,7 @@ static const char *marzen_boards_compat_dt[] __initdata = {
         NULL,
 };
 
-DT_MACHINE_START(MARZEN, "marzen")
+DT_MACHINE_START(MARZEN)
 	.smp		= smp_ops(r8a7779_smp_ops),
 	.map_io		= r8a7779_map_io,
 	.init_early	= r8a7779_add_early_devices,
diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index 3ad531c..5ede34d 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -202,7 +202,7 @@ static const char *emev2_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
+DT_MACHINE_START(EMEV2_DT)
 	.smp		= smp_ops(emev2_smp_ops),
 	.map_io		= emev2_map_io,
 	.init_early	= emev2_init_delay,
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index 8949170..097dbbc 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -221,7 +221,7 @@ static const char *r8a73a4_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
+DT_MACHINE_START(R8A73A4_DT)
 	.init_early	= r8a73a4_init_delay,
 	.dt_compat	= r8a73a4_boards_compat_dt,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index b7d4b2c..c18f2a0e 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -1062,7 +1062,7 @@ static const char *r8a7740_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
+DT_MACHINE_START(R8A7740_DT)
 	.map_io		= r8a7740_map_io,
 	.init_early	= r8a7740_init_delay,
 	.init_irq	= r8a7740_init_irq_of,
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 6a2657e..fa84959 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -437,7 +437,7 @@ static const char *r8a7778_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(R8A7778_DT, "Generic R8A7778 (Flattened Device Tree)")
+DT_MACHINE_START(R8A7778_DT)
 	.init_early	= r8a7778_init_delay,
 	.init_irq	= r8a7778_init_irq_dt,
 	.dt_compat	= r8a7778_compat_dt,
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index ecd0148..35e5315 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -778,7 +778,7 @@ static const char *r8a7779_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(R8A7779_DT, "Generic R8A7779 (Flattened Device Tree)")
+DT_MACHINE_START(R8A7779_DT)
 	.map_io		= r8a7779_map_io,
 	.init_early	= r8a7779_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index d0f5c9f..e481762 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -281,7 +281,7 @@ static const char *r8a7790_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
+DT_MACHINE_START(R8A7790_DT)
 	.init_early	= r8a7790_init_delay,
 	.init_time	= r8a7790_timer_init,
 	.dt_compat	= r8a7790_boards_compat_dt,
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 3118783..6c22b68 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -1162,7 +1162,7 @@ static const char *sh7372_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(SH7372_DT, "Generic SH7372 (Flattened Device Tree)")
+DT_MACHINE_START(SH7372_DT)
 	.map_io		= sh7372_map_io,
 	.init_early	= sh7372_add_early_devices_dt,
 	.nr_irqs	= NR_IRQS_LEGACY,
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 22de174..f49279e 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -963,7 +963,7 @@ static const char *sh73a0_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
+DT_MACHINE_START(SH73A0_DT)
 	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_init_delay,
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index bfce964..4a8ea96 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -116,7 +116,7 @@ static const char *altera_dt_match[] = {
 	NULL
 };
 
-DT_MACHINE_START(SOCFPGA, "Altera SOCFPGA")
+DT_MACHINE_START(SOCFPGA)
 	.smp		= smp_ops(socfpga_smp_ops),
 	.map_io		= socfpga_map_io,
 	.init_irq	= socfpga_init_irq,
diff --git a/arch/arm/mach-spear/spear1310.c b/arch/arm/mach-spear/spear1310.c
index 7ad0030..388b055 100644
--- a/arch/arm/mach-spear/spear1310.c
+++ b/arch/arm/mach-spear/spear1310.c
@@ -56,7 +56,7 @@ static void __init spear1310_map_io(void)
 	spear13xx_map_io();
 }
 
-DT_MACHINE_START(SPEAR1310_DT, "ST SPEAr1310 SoC with Flattened Device Tree")
+DT_MACHINE_START(SPEAR1310_DT)
 	.smp		=	smp_ops(spear13xx_smp_ops),
 	.map_io		=	spear1310_map_io,
 	.init_time	=	spear13xx_timer_init,
diff --git a/arch/arm/mach-spear/spear1340.c b/arch/arm/mach-spear/spear1340.c
index 3fb6834..009815e 100644
--- a/arch/arm/mach-spear/spear1340.c
+++ b/arch/arm/mach-spear/spear1340.c
@@ -151,7 +151,7 @@ static const char * const spear1340_dt_board_compat[] = {
 	NULL,
 };
 
-DT_MACHINE_START(SPEAR1340_DT, "ST SPEAr1340 SoC with Flattened Device Tree")
+DT_MACHINE_START(SPEAR1340_DT)
 	.smp		=	smp_ops(spear13xx_smp_ops),
 	.map_io		=	spear13xx_map_io,
 	.init_time	=	spear13xx_timer_init,
diff --git a/arch/arm/mach-spear/spear300.c b/arch/arm/mach-spear/spear300.c
index b52e48f..bd094b3 100644
--- a/arch/arm/mach-spear/spear300.c
+++ b/arch/arm/mach-spear/spear300.c
@@ -209,7 +209,7 @@ static void __init spear300_map_io(void)
 	spear3xx_map_io();
 }
 
-DT_MACHINE_START(SPEAR300_DT, "ST SPEAr300 SoC with Flattened Device Tree")
+DT_MACHINE_START(SPEAR300_DT)
 	.map_io		=	spear300_map_io,
 	.init_time	=	spear3xx_timer_init,
 	.init_machine	=	spear300_dt_init,
diff --git a/arch/arm/mach-spear/spear310.c b/arch/arm/mach-spear/spear310.c
index ed2029d..465e916 100644
--- a/arch/arm/mach-spear/spear310.c
+++ b/arch/arm/mach-spear/spear310.c
@@ -251,7 +251,7 @@ static void __init spear310_map_io(void)
 	spear3xx_map_io();
 }
 
-DT_MACHINE_START(SPEAR310_DT, "ST SPEAr310 SoC with Flattened Device Tree")
+DT_MACHINE_START(SPEAR310_DT)
 	.map_io		=	spear310_map_io,
 	.init_time	=	spear3xx_timer_init,
 	.init_machine	=	spear310_dt_init,
diff --git a/arch/arm/mach-spear/spear320.c b/arch/arm/mach-spear/spear320.c
index bf634b3..6b6b381 100644
--- a/arch/arm/mach-spear/spear320.c
+++ b/arch/arm/mach-spear/spear320.c
@@ -266,7 +266,7 @@ static void __init spear320_map_io(void)
 	spear3xx_map_io();
 }
 
-DT_MACHINE_START(SPEAR320_DT, "ST SPEAr320 SoC with Flattened Device Tree")
+DT_MACHINE_START(SPEAR320_DT)
 	.map_io		=	spear320_map_io,
 	.init_time	=	spear3xx_timer_init,
 	.init_machine	=	spear320_dt_init,
diff --git a/arch/arm/mach-spear/spear6xx.c b/arch/arm/mach-spear/spear6xx.c
index da26fa5..a69fc83 100644
--- a/arch/arm/mach-spear/spear6xx.c
+++ b/arch/arm/mach-spear/spear6xx.c
@@ -420,7 +420,7 @@ static const char *spear600_dt_board_compat[] = {
 	NULL
 };
 
-DT_MACHINE_START(SPEAR600_DT, "ST SPEAr600 (Flattened Device Tree)")
+DT_MACHINE_START(SPEAR600_DT)
 	.map_io		=	spear6xx_map_io,
 	.init_time	=	spear6xx_timer_init,
 	.init_machine	=	spear600_dt_init,
diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
index 8fe6f0c..509e5bb 100644
--- a/arch/arm/mach-sti/board-dt.c
+++ b/arch/arm/mach-sti/board-dt.c
@@ -41,7 +41,7 @@ static const char *stih41x_dt_match[] __initdata = {
 	NULL
 };
 
-DT_MACHINE_START(STM, "STiH415/416 SoC with Flattened Device Tree")
+DT_MACHINE_START(STM)
 	.init_time	= stih41x_timer_init,
 	.smp		= smp_ops(sti_smp_ops),
 	.dt_compat	= stih41x_dt_match,
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index e79fb34..8508c98 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -138,7 +138,7 @@ static const char * const sunxi_board_dt_compat[] = {
 	NULL,
 };
 
-DT_MACHINE_START(SUNXI_DT, "Allwinner A1X (Device Tree)")
+DT_MACHINE_START(SUNXI_DT)
 	.init_machine	= sunxi_dt_init,
 	.init_time	= sunxi_timer_init,
 	.dt_compat	= sunxi_board_dt_compat,
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 5b86055..931a49b 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -114,7 +114,7 @@ static const char * const tegra_dt_board_compat[] = {
 	NULL
 };
 
-DT_MACHINE_START(TEGRA_DT, "NVIDIA Tegra SoC (Flattened Device Tree)")
+DT_MACHINE_START(TEGRA_DT)
 	.map_io		= tegra_map_common_io,
 	.smp		= smp_ops(tegra_smp_ops),
 	.init_early	= tegra_init_early,
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 35670b1..8bac5c8 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -405,7 +405,7 @@ static const char * u300_board_compat[] = {
 	NULL,
 };
 
-DT_MACHINE_START(U300_DT, "U300 S335/B335 (Device Tree)")
+DT_MACHINE_START(U300_DT)
 	.map_io		= u300_map_io,
 	.init_irq	= u300_init_irq_dt,
 	.init_time	= clocksource_of_init,
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 301c346..5ad5432 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -316,7 +316,7 @@ static const char * stericsson_dt_platform_compat[] = {
 	NULL,
 };
 
-DT_MACHINE_START(U8500_DT, "ST-Ericsson Ux5x0 platform (Device Tree Support)")
+DT_MACHINE_START(U8500_DT)
 	.smp            = smp_ops(ux500_smp_ops),
 	.map_io		= u8500_map_io,
 	.init_irq	= ux500_init_irq,
diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile_dt.c
index 3621b00..4940da8 100644
--- a/arch/arm/mach-versatile/versatile_dt.c
+++ b/arch/arm/mach-versatile/versatile_dt.c
@@ -41,7 +41,7 @@ static const char *versatile_dt_match[] __initconst = {
 	NULL,
 };
 
-DT_MACHINE_START(VERSATILE_PB, "ARM-Versatile (Device Tree Support)")
+DT_MACHINE_START(VERSATILE_PB)
 	.map_io		= versatile_map_io,
 	.init_early	= versatile_init_early,
 	.init_irq	= versatile_init_irq,
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 95a469e..3bf5ed7 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -452,7 +452,7 @@ static const char * const v2m_dt_match[] __initconst = {
 	NULL,
 };
 
-DT_MACHINE_START(VEXPRESS_DT, "ARM-Versatile Express")
+DT_MACHINE_START(VEXPRESS_DT)
 	.dt_compat	= v2m_dt_match,
 	.smp		= smp_ops(vexpress_smp_ops),
 	.smp_init	= smp_init_ops(vexpress_smp_init_ops),
diff --git a/arch/arm/mach-virt/virt.c b/arch/arm/mach-virt/virt.c
index b184e57..d1495fd 100644
--- a/arch/arm/mach-virt/virt.c
+++ b/arch/arm/mach-virt/virt.c
@@ -35,7 +35,7 @@ static const char *virt_dt_match[] = {
 	NULL
 };
 
-DT_MACHINE_START(VIRT, "Dummy Virtual Machine")
+DT_MACHINE_START(VIRT)
 	.init_machine	= virt_init,
 	.dt_compat	= virt_dt_match,
 MACHINE_END
diff --git a/arch/arm/mach-vt8500/vt8500.c b/arch/arm/mach-vt8500/vt8500.c
index eefaa60..5622846 100644
--- a/arch/arm/mach-vt8500/vt8500.c
+++ b/arch/arm/mach-vt8500/vt8500.c
@@ -176,7 +176,7 @@ static const char * const vt8500_dt_compat[] = {
 	NULL
 };
 
-DT_MACHINE_START(WMT_DT, "VIA/Wondermedia SoC (Device Tree Support)")
+DT_MACHINE_START(WMT_DT)
 	.dt_compat	= vt8500_dt_compat,
 	.map_io		= vt8500_map_io,
 	.init_machine	= vt8500_init,
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 5f25256..f36211c 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -101,7 +101,7 @@ static const char * const zynq_dt_match[] = {
 	NULL
 };
 
-DT_MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
+DT_MACHINE_START(XILINX_EP107)
 	.smp		= smp_ops(zynq_smp_ops),
 	.map_io		= zynq_map_io,
 	.init_machine	= zynq_init_machine,
-- 
1.8.1.2
