From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 4 Nov 2013 11:36:51 +0000
Subject: [PATCH v2] ARM: remove name from machine_desc for DT platforms
In-Reply-To: <1383511801-31682-1-git-send-email-robherring2@gmail.com>
References: <1383511801-31682-1-git-send-email-robherring2@gmail.com>
Message-ID: <CACxGe6sMXjcsGNEiGQ923_yEKXwaAj_qfqZQPpXqHgh1znsF0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 3, 2013 at 8:50 PM, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> As part of the effort to ultimately remove struct machine_desc, the
> machine name is not really needed. It is only used for /proc/cpuinfo
> "Hardware" field. Get this information from the DT instead and remove
> the name string in the machine descriptor for DT machine descriptors. The
> model or machine compatible property from the DT is used instead.

I've obviously missed some discussions because I wasn't aware of the
plan to remove machine_desc. That's neither here not there, but for as
long as the structure still exists it is really useful to discover
which machine_desc the kernel chooses at boot time. If you're going to
remove this, then at the very least I would embed the filename or
something similar into the machine desc so it is available for
debugging. It can go away when the structure is removed.

g.

>
> This likely changes the name reported by /proc/cpuinfo. There could be
> some userspace dependencies on the old name. Debian libdebian-installer
> used to use this to determine kernel flavour, but now uses the DT
> directly. It is not really a good idea for userspace to depend on this
> anyway.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
> Kevin, Olof,
>
> Here is updated patch based on arm-soc for-next and my DT for-next
> branches. I plan to get the DT changes in early in the merge window.
>
> The patch is also available here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git dt-rm-mach-name
>
> Rob
>
>  arch/arm/include/asm/mach/arch.h                     |  3 +--
>  arch/arm/kernel/devtree.c                            |  2 +-
>  arch/arm/kernel/setup.c                              |  4 ++--
>  arch/arm/mach-at91/board-dt-rm9200.c                 |  2 +-
>  arch/arm/mach-at91/board-dt-sam9.c                   |  2 +-
>  arch/arm/mach-at91/board-dt-sama5.c                  |  2 +-
>  arch/arm/mach-bcm/board_bcm281xx.c                   |  2 +-
>  arch/arm/mach-bcm2835/bcm2835.c                      |  2 +-
>  arch/arm/mach-cns3xxx/core.c                         |  2 +-
>  arch/arm/mach-davinci/da8xx-dt.c                     |  2 +-
>  arch/arm/mach-dove/board-dt.c                        |  2 +-
>  arch/arm/mach-exynos/mach-exynos4-dt.c               |  2 +-
>  arch/arm/mach-exynos/mach-exynos5-dt.c               |  2 +-
>  arch/arm/mach-highbank/highbank.c                    |  2 +-
>  arch/arm/mach-imx/imx25-dt.c                         |  2 +-
>  arch/arm/mach-imx/imx27-dt.c                         |  2 +-
>  arch/arm/mach-imx/imx31-dt.c                         |  2 +-
>  arch/arm/mach-imx/imx51-dt.c                         |  2 +-
>  arch/arm/mach-imx/mach-imx53.c                       |  2 +-
>  arch/arm/mach-imx/mach-imx6q.c                       |  2 +-
>  arch/arm/mach-imx/mach-imx6sl.c                      |  2 +-
>  arch/arm/mach-imx/mach-vf610.c                       |  2 +-
>  arch/arm/mach-integrator/integrator_ap.c             |  2 +-
>  arch/arm/mach-integrator/integrator_cp.c             |  2 +-
>  arch/arm/mach-keystone/keystone.c                    |  2 +-
>  arch/arm/mach-kirkwood/board-dt.c                    |  2 +-
>  arch/arm/mach-lpc32xx/phy3250.c                      |  2 +-
>  arch/arm/mach-mmp/mmp-dt.c                           |  4 ++--
>  arch/arm/mach-mmp/mmp2-dt.c                          |  2 +-
>  arch/arm/mach-msm/board-dt.c                         |  2 +-
>  arch/arm/mach-mvebu/armada-370-xp.c                  |  2 +-
>  arch/arm/mach-mxs/mach-mxs.c                         |  2 +-
>  arch/arm/mach-nomadik/cpu-8815.c                     |  2 +-
>  arch/arm/mach-nspire/nspire.c                        |  2 +-
>  arch/arm/mach-omap2/board-generic.c                  | 20 ++++++++++----------
>  arch/arm/mach-orion5x/board-dt.c                     |  2 +-
>  arch/arm/mach-picoxcell/common.c                     |  2 +-
>  arch/arm/mach-prima2/common.c                        |  6 +++---
>  arch/arm/mach-pxa/pxa-dt.c                           |  2 +-
>  arch/arm/mach-rockchip/rockchip.c                    |  2 +-
>  arch/arm/mach-s3c24xx/mach-s3c2416-dt.c              |  2 +-
>  arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c              |  2 +-
>  arch/arm/mach-shmobile/board-ape6evm-reference.c     |  2 +-
>  arch/arm/mach-shmobile/board-ape6evm.c               |  2 +-
>  .../mach-shmobile/board-armadillo800eva-reference.c  |  2 +-
>  arch/arm/mach-shmobile/board-armadillo800eva.c       |  2 +-
>  arch/arm/mach-shmobile/board-bockw-reference.c       |  2 +-
>  arch/arm/mach-shmobile/board-bockw.c                 |  2 +-
>  arch/arm/mach-shmobile/board-genmai.c                |  2 +-
>  arch/arm/mach-shmobile/board-koelsch.c               |  2 +-
>  arch/arm/mach-shmobile/board-kzm9d-reference.c       |  2 +-
>  arch/arm/mach-shmobile/board-kzm9d.c                 |  2 +-
>  arch/arm/mach-shmobile/board-kzm9g-reference.c       |  2 +-
>  arch/arm/mach-shmobile/board-kzm9g.c                 |  2 +-
>  arch/arm/mach-shmobile/board-lager-reference.c       |  2 +-
>  arch/arm/mach-shmobile/board-lager.c                 |  2 +-
>  arch/arm/mach-shmobile/board-mackerel.c              |  2 +-
>  arch/arm/mach-shmobile/board-marzen-reference.c      |  2 +-
>  arch/arm/mach-shmobile/board-marzen.c                |  2 +-
>  arch/arm/mach-shmobile/setup-emev2.c                 |  2 +-
>  arch/arm/mach-shmobile/setup-r7s72100.c              |  2 +-
>  arch/arm/mach-shmobile/setup-r8a73a4.c               |  2 +-
>  arch/arm/mach-shmobile/setup-r8a7740.c               |  2 +-
>  arch/arm/mach-shmobile/setup-r8a7778.c               |  2 +-
>  arch/arm/mach-shmobile/setup-r8a7779.c               |  2 +-
>  arch/arm/mach-shmobile/setup-r8a7790.c               |  2 +-
>  arch/arm/mach-shmobile/setup-r8a7791.c               |  2 +-
>  arch/arm/mach-shmobile/setup-sh7372.c                |  2 +-
>  arch/arm/mach-shmobile/setup-sh73a0.c                |  2 +-
>  arch/arm/mach-socfpga/socfpga.c                      |  2 +-
>  arch/arm/mach-spear/spear1310.c                      |  2 +-
>  arch/arm/mach-spear/spear1340.c                      |  2 +-
>  arch/arm/mach-spear/spear300.c                       |  2 +-
>  arch/arm/mach-spear/spear310.c                       |  2 +-
>  arch/arm/mach-spear/spear320.c                       |  2 +-
>  arch/arm/mach-spear/spear6xx.c                       |  2 +-
>  arch/arm/mach-sti/board-dt.c                         |  2 +-
>  arch/arm/mach-sunxi/sunxi.c                          |  6 +++---
>  arch/arm/mach-tegra/tegra.c                          |  2 +-
>  arch/arm/mach-u300/core.c                            |  2 +-
>  arch/arm/mach-ux500/cpu-db8500.c                     |  2 +-
>  arch/arm/mach-versatile/versatile_dt.c               |  2 +-
>  arch/arm/mach-vexpress/v2m.c                         |  2 +-
>  arch/arm/mach-virt/virt.c                            |  2 +-
>  arch/arm/mach-vt8500/vt8500.c                        |  2 +-
>  arch/arm/mach-zynq/common.c                          |  2 +-
>  86 files changed, 101 insertions(+), 102 deletions(-)
>
> diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
> index 402a2bc..3c82227 100644
> --- a/arch/arm/include/asm/mach/arch.h
> +++ b/arch/arm/include/asm/mach/arch.h
> @@ -88,11 +88,10 @@ static const struct machine_desc __mach_desc_##_type        \
>  #define MACHINE_END                            \
>  };
>
> -#define DT_MACHINE_START(_name, _namestr)              \
> +#define DT_MACHINE_START(_name)                \
>  static const struct machine_desc __mach_desc_##_name   \
>   __used                                                        \
>   __attribute__((__section__(".arch.info.init"))) = {   \
>         .nr             = ~0,                           \
> -       .name           = _namestr,
>
>  #endif
> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> index 739c3df..46e3aff 100644
> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
> @@ -199,7 +199,7 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
>         const struct machine_desc *mdesc, *mdesc_best = NULL;
>
>  #ifdef CONFIG_ARCH_MULTIPLATFORM
> -       DT_MACHINE_START(GENERIC_DT, "Generic DT based system")
> +       DT_MACHINE_START(GENERIC_DT)
>         MACHINE_END
>
>         mdesc_best = &__mach_desc_GENERIC_DT;
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 0e1e2b3..b0747bb 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -611,7 +611,7 @@ void __init dump_machine_table(void)
>
>         early_print("Available machine support:\n\nID (hex)\tNAME\n");
>         for_each_machine_desc(p)
> -               early_print("%08x\t%s\n", p->nr, p->name);
> +               early_print("%08x\t%s\n", p->nr, p->name ? p->name : *p->dt_compat);
>
>         early_print("\nPlease check your kernel config and/or bootloader.\n");
>
> @@ -859,7 +859,7 @@ void __init setup_arch(char **cmdline_p)
>         if (!mdesc)
>                 mdesc = setup_machine_tags(__atags_pointer, __machine_arch_type);
>         machine_desc = mdesc;
> -       machine_name = mdesc->name;
> +       machine_name = mdesc->name ? mdesc->name : of_flat_dt_get_machine_name();
>
>         setup_dma_zone(mdesc);
>
> diff --git a/arch/arm/mach-at91/board-dt-rm9200.c b/arch/arm/mach-at91/board-dt-rm9200.c
> index 3a185fa..afe079e 100644
> --- a/arch/arm/mach-at91/board-dt-rm9200.c
> +++ b/arch/arm/mach-at91/board-dt-rm9200.c
> @@ -40,7 +40,7 @@ static const char *at91rm9200_dt_board_compat[] __initdata = {
>         NULL
>  };
>
> -DT_MACHINE_START(at91rm9200_dt, "Atmel AT91RM9200 (Device Tree)")
> +DT_MACHINE_START(at91rm9200_dt)
>         .init_time      = at91rm9200_timer_init,
>         .map_io         = at91_map_io,
>         .handle_irq     = at91_aic_handle_irq,
> diff --git a/arch/arm/mach-at91/board-dt-sam9.c b/arch/arm/mach-at91/board-dt-sam9.c
> index 3dab868..0465a74 100644
> --- a/arch/arm/mach-at91/board-dt-sam9.c
> +++ b/arch/arm/mach-at91/board-dt-sam9.c
> @@ -41,7 +41,7 @@ static const char *at91_dt_board_compat[] __initdata = {
>         NULL
>  };
>
> -DT_MACHINE_START(at91sam_dt, "Atmel AT91SAM (Device Tree)")
> +DT_MACHINE_START(at91sam_dt)
>         /* Maintainer: Atmel */
>         .init_time      = at91sam926x_pit_init,
>         .map_io         = at91_map_io,
> diff --git a/arch/arm/mach-at91/board-dt-sama5.c b/arch/arm/mach-at91/board-dt-sama5.c
> index bf00d15..2e2699d 100644
> --- a/arch/arm/mach-at91/board-dt-sama5.c
> +++ b/arch/arm/mach-at91/board-dt-sama5.c
> @@ -70,7 +70,7 @@ static const char *sama5_dt_board_compat[] __initdata = {
>         NULL
>  };
>
> -DT_MACHINE_START(sama5_dt, "Atmel SAMA5 (Device Tree)")
> +DT_MACHINE_START(sama5_dt)
>         /* Maintainer: Atmel */
>         .init_time      = at91sam926x_pit_init,
>         .map_io         = at91_map_io,
> diff --git a/arch/arm/mach-bcm/board_bcm281xx.c b/arch/arm/mach-bcm/board_bcm281xx.c
> index cb3dc36..5b59e8a 100644
> --- a/arch/arm/mach-bcm/board_bcm281xx.c
> +++ b/arch/arm/mach-bcm/board_bcm281xx.c
> @@ -67,7 +67,7 @@ static void __init board_init(void)
>
>  static const char * const bcm11351_dt_compat[] = { "brcm,bcm11351", NULL, };
>
> -DT_MACHINE_START(BCM11351_DT, "BCM281xx Broadcom Application Processor")
> +DT_MACHINE_START(BCM11351_DT)
>         .init_machine = board_init,
>         .restart = bcm_kona_restart,
>         .dt_compat = bcm11351_dt_compat,
> diff --git a/arch/arm/mach-bcm2835/bcm2835.c b/arch/arm/mach-bcm2835/bcm2835.c
> index d50135b..a810e61 100644
> --- a/arch/arm/mach-bcm2835/bcm2835.c
> +++ b/arch/arm/mach-bcm2835/bcm2835.c
> @@ -128,7 +128,7 @@ static const char * const bcm2835_compat[] = {
>         NULL
>  };
>
> -DT_MACHINE_START(BCM2835, "BCM2835")
> +DT_MACHINE_START(BCM2835)
>         .map_io = bcm2835_map_io,
>         .init_irq = bcm2835_init_irq,
>         .handle_irq = bcm2835_handle_irq,
> diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
> index e38b279..8bf66ac 100644
> --- a/arch/arm/mach-cns3xxx/core.c
> +++ b/arch/arm/mach-cns3xxx/core.c
> @@ -366,7 +366,7 @@ static const char *cns3xxx_dt_compat[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(CNS3XXX_DT, "Cavium Networks CNS3xxx")
> +DT_MACHINE_START(CNS3XXX_DT)
>         .dt_compat      = cns3xxx_dt_compat,
>         .nr_irqs        = NR_IRQS_CNS3XXX,
>         .map_io         = cns3xxx_map_io,
> diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
> index d2bc574..974afaf 100644
> --- a/arch/arm/mach-davinci/da8xx-dt.c
> +++ b/arch/arm/mach-davinci/da8xx-dt.c
> @@ -65,7 +65,7 @@ static const char *da850_boards_compat[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(DA850_DT, "Generic DA850/OMAP-L138/AM18x")
> +DT_MACHINE_START(DA850_DT)
>         .map_io         = da850_init,
>         .init_irq       = da8xx_init_irq,
>         .init_time      = davinci_timer_init,
> diff --git a/arch/arm/mach-dove/board-dt.c b/arch/arm/mach-dove/board-dt.c
> index 49fa9ab..4797e5b 100644
> --- a/arch/arm/mach-dove/board-dt.c
> +++ b/arch/arm/mach-dove/board-dt.c
> @@ -35,7 +35,7 @@ static const char * const dove_dt_board_compat[] = {
>         NULL
>  };
>
> -DT_MACHINE_START(DOVE_DT, "Marvell Dove (Flattened Device Tree)")
> +DT_MACHINE_START(DOVE_DT)
>         .map_io         = dove_map_io,
>         .init_machine   = dove_dt_init,
>         .restart        = dove_restart,
> diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
> index 4b8f6e2..44d0b23 100644
> --- a/arch/arm/mach-exynos/mach-exynos4-dt.c
> +++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
> @@ -43,7 +43,7 @@ static void __init exynos4_reserve(void)
>                                 mfc_mem.lsize);
>  #endif
>  }
> -DT_MACHINE_START(EXYNOS4210_DT, "Samsung Exynos4 (Flattened Device Tree)")
> +DT_MACHINE_START(EXYNOS4210_DT)
>         /* Maintainer: Thomas Abraham <thomas.abraham@linaro.org> */
>         .smp            = smp_ops(exynos_smp_ops),
>         .map_io         = exynos_init_io,
> diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
> index 7976ab3..d2ba907 100644
> --- a/arch/arm/mach-exynos/mach-exynos5-dt.c
> +++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
> @@ -66,7 +66,7 @@ static void __init exynos5_reserve(void)
>  #endif
>  }
>
> -DT_MACHINE_START(EXYNOS5_DT, "SAMSUNG EXYNOS5 (Flattened Device Tree)")
> +DT_MACHINE_START(EXYNOS5_DT)
>         /* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
>         .smp            = smp_ops(exynos_smp_ops),
>         .map_io         = exynos_init_io,
> diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
> index b3d7e56..f0a26bb 100644
> --- a/arch/arm/mach-highbank/highbank.c
> +++ b/arch/arm/mach-highbank/highbank.c
> @@ -157,7 +157,7 @@ static const char *highbank_match[] __initconst = {
>         NULL,
>  };
>
> -DT_MACHINE_START(HIGHBANK, "Highbank")
> +DT_MACHINE_START(HIGHBANK)
>  #if defined(CONFIG_ZONE_DMA) && defined(CONFIG_ARM_LPAE)
>         .dma_zone_size  = (4ULL * SZ_1G),
>  #endif
> diff --git a/arch/arm/mach-imx/imx25-dt.c b/arch/arm/mach-imx/imx25-dt.c
> index 3e1ec5f..25401d9 100644
> --- a/arch/arm/mach-imx/imx25-dt.c
> +++ b/arch/arm/mach-imx/imx25-dt.c
> @@ -34,7 +34,7 @@ static void __init imx25_timer_init(void)
>         mx25_clocks_init_dt();
>  }
>
> -DT_MACHINE_START(IMX25_DT, "Freescale i.MX25 (Device Tree Support)")
> +DT_MACHINE_START(IMX25_DT)
>         .map_io         = mx25_map_io,
>         .init_early     = imx25_init_early,
>         .init_irq       = mx25_init_irq,
> diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
> index 4e235ec..3d35369 100644
> --- a/arch/arm/mach-imx/imx27-dt.c
> +++ b/arch/arm/mach-imx/imx27-dt.c
> @@ -39,7 +39,7 @@ static void __init imx27_timer_init(void)
>         mx27_clocks_init_dt();
>  }
>
> -DT_MACHINE_START(IMX27_DT, "Freescale i.MX27 (Device Tree Support)")
> +DT_MACHINE_START(IMX27_DT)
>         .map_io         = mx27_map_io,
>         .init_early     = imx27_init_early,
>         .init_irq       = mx27_init_irq,
> diff --git a/arch/arm/mach-imx/imx31-dt.c b/arch/arm/mach-imx/imx31-dt.c
> index 818a1cc..6c60dfa 100644
> --- a/arch/arm/mach-imx/imx31-dt.c
> +++ b/arch/arm/mach-imx/imx31-dt.c
> @@ -35,7 +35,7 @@ static void __init imx31_dt_timer_init(void)
>         mx31_clocks_init_dt();
>  }
>
> -DT_MACHINE_START(IMX31_DT, "Freescale i.MX31 (Device Tree Support)")
> +DT_MACHINE_START(IMX31_DT)
>         .map_io         = mx31_map_io,
>         .init_early     = imx31_init_early,
>         .init_irq       = mx31_init_irq,
> diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
> index bece8a6..0c4f758 100644
> --- a/arch/arm/mach-imx/imx51-dt.c
> +++ b/arch/arm/mach-imx/imx51-dt.c
> @@ -34,7 +34,7 @@ static const char *imx51_dt_board_compat[] __initdata = {
>         NULL
>  };
>
> -DT_MACHINE_START(IMX51_DT, "Freescale i.MX51 (Device Tree Support)")
> +DT_MACHINE_START(IMX51_DT)
>         .map_io         = mx51_map_io,
>         .init_early     = imx51_init_early,
>         .init_irq       = mx51_init_irq,
> diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
> index c9c4d8d..ba3d370 100644
> --- a/arch/arm/mach-imx/mach-imx53.c
> +++ b/arch/arm/mach-imx/mach-imx53.c
> @@ -36,7 +36,7 @@ static const char *imx53_dt_board_compat[] __initdata = {
>         NULL
>  };
>
> -DT_MACHINE_START(IMX53_DT, "Freescale i.MX53 (Device Tree Support)")
> +DT_MACHINE_START(IMX53_DT)
>         .map_io         = mx53_map_io,
>         .init_early     = imx53_init_early,
>         .init_irq       = mx53_init_irq,
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index 0f9f241..4c38229 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -249,7 +249,7 @@ static const char *imx6q_dt_compat[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad/DualLite (Device Tree)")
> +DT_MACHINE_START(IMX6Q)
>         .smp            = smp_ops(imx_smp_ops),
>         .map_io         = imx6q_map_io,
>         .init_irq       = imx6q_init_irq,
> diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
> index 2f952e3..0391857 100644
> --- a/arch/arm/mach-imx/mach-imx6sl.c
> +++ b/arch/arm/mach-imx/mach-imx6sl.c
> @@ -66,7 +66,7 @@ static const char *imx6sl_dt_compat[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(IMX6SL, "Freescale i.MX6 SoloLite (Device Tree)")
> +DT_MACHINE_START(IMX6SL)
>         .map_io         = debug_ll_io_init,
>         .init_irq       = imx6sl_init_irq,
>         .init_machine   = imx6sl_init_machine,
> diff --git a/arch/arm/mach-imx/mach-vf610.c b/arch/arm/mach-imx/mach-vf610.c
> index af0cb8a..646f412 100644
> --- a/arch/arm/mach-imx/mach-vf610.c
> +++ b/arch/arm/mach-imx/mach-vf610.c
> @@ -31,7 +31,7 @@ static const char *vf610_dt_compat[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(VYBRID_VF610, "Freescale Vybrid VF610 (Device Tree)")
> +DT_MACHINE_START(VYBRID_VF610)
>         .init_irq       = vf610_init_irq,
>         .init_machine   = vf610_init_machine,
>         .dt_compat      = vf610_dt_compat,
> diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
> index d50dc2d..5cb38c5 100644
> --- a/arch/arm/mach-integrator/integrator_ap.c
> +++ b/arch/arm/mach-integrator/integrator_ap.c
> @@ -556,7 +556,7 @@ static const char * ap_dt_board_compat[] = {
>         NULL,
>  };
>
> -DT_MACHINE_START(INTEGRATOR_AP_DT, "ARM Integrator/AP (Device Tree)")
> +DT_MACHINE_START(INTEGRATOR_AP_DT)
>         .reserve        = integrator_reserve,
>         .map_io         = ap_map_io,
>         .init_early     = ap_init_early,
> diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
> index 1df6e76..04d8609 100644
> --- a/arch/arm/mach-integrator/integrator_cp.c
> +++ b/arch/arm/mach-integrator/integrator_cp.c
> @@ -349,7 +349,7 @@ static const char * intcp_dt_board_compat[] = {
>         NULL,
>  };
>
> -DT_MACHINE_START(INTEGRATOR_CP_DT, "ARM Integrator/CP (Device Tree)")
> +DT_MACHINE_START(INTEGRATOR_CP_DT)
>         .reserve        = integrator_reserve,
>         .map_io         = intcp_map_io,
>         .init_early     = intcp_init_early,
> diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
> index b661c5c..a22b3e6 100644
> --- a/arch/arm/mach-keystone/keystone.c
> +++ b/arch/arm/mach-keystone/keystone.c
> @@ -67,7 +67,7 @@ void keystone_restart(enum reboot_mode mode, const char *cmd)
>         writel(val, keystone_rstctrl);
>  }
>
> -DT_MACHINE_START(KEYSTONE, "Keystone")
> +DT_MACHINE_START(KEYSTONE)
>         .smp            = smp_ops(keystone_smp_ops),
>         .init_machine   = keystone_init,
>         .dt_compat      = keystone_match,
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index 9caa4fe..a3a098b 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -177,7 +177,7 @@ static const char * const kirkwood_dt_board_compat[] = {
>         NULL
>  };
>
> -DT_MACHINE_START(KIRKWOOD_DT, "Marvell Kirkwood (Flattened Device Tree)")
> +DT_MACHINE_START(KIRKWOOD_DT)
>         /* Maintainer: Jason Cooper <jason@lakedaemon.net> */
>         .map_io         = kirkwood_map_io,
>         .init_machine   = kirkwood_dt_init,
> diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
> index e54f87e..b5e58f7 100644
> --- a/arch/arm/mach-lpc32xx/phy3250.c
> +++ b/arch/arm/mach-lpc32xx/phy3250.c
> @@ -259,7 +259,7 @@ static char const *lpc32xx_dt_compat[] __initdata = {
>         NULL
>  };
>
> -DT_MACHINE_START(LPC32XX_DT, "LPC32XX SoC (Flattened Device Tree)")
> +DT_MACHINE_START(LPC32XX_DT)
>         .atag_offset    = 0x100,
>         .map_io         = lpc32xx_map_io,
>         .init_irq       = lpc32xx_init_irq,
> diff --git a/arch/arm/mach-mmp/mmp-dt.c b/arch/arm/mach-mmp/mmp-dt.c
> index cca529c..f528529 100644
> --- a/arch/arm/mach-mmp/mmp-dt.c
> +++ b/arch/arm/mach-mmp/mmp-dt.c
> @@ -58,14 +58,14 @@ static const char *mmp_dt_board_compat[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(PXA168_DT, "Marvell PXA168 (Device Tree Support)")
> +DT_MACHINE_START(PXA168_DT)
>         .map_io         = mmp_map_io,
>         .init_time      = mmp_dt_init_timer,
>         .init_machine   = pxa168_dt_init,
>         .dt_compat      = mmp_dt_board_compat,
>  MACHINE_END
>
> -DT_MACHINE_START(PXA910_DT, "Marvell PXA910 (Device Tree Support)")
> +DT_MACHINE_START(PXA910_DT)
>         .map_io         = mmp_map_io,
>         .init_time      = mmp_dt_init_timer,
>         .init_machine   = pxa910_dt_init,
> diff --git a/arch/arm/mach-mmp/mmp2-dt.c b/arch/arm/mach-mmp/mmp2-dt.c
> index 023cb45..6bb0144 100644
> --- a/arch/arm/mach-mmp/mmp2-dt.c
> +++ b/arch/arm/mach-mmp/mmp2-dt.c
> @@ -42,7 +42,7 @@ static const char *mmp2_dt_board_compat[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(MMP2_DT, "Marvell MMP2 (Device Tree Support)")
> +DT_MACHINE_START(MMP2_DT)
>         .map_io         = mmp_map_io,
>         .init_time      = mmp_dt_init_timer,
>         .init_machine   = mmp2_dt_init,
> diff --git a/arch/arm/mach-msm/board-dt.c b/arch/arm/mach-msm/board-dt.c
> index 16e6183..bb6caf5 100644
> --- a/arch/arm/mach-msm/board-dt.c
> +++ b/arch/arm/mach-msm/board-dt.c
> @@ -26,7 +26,7 @@ static const char * const msm_dt_match[] __initconst = {
>         NULL
>  };
>
> -DT_MACHINE_START(MSM_DT, "Qualcomm MSM (Flattened Device Tree)")
> +DT_MACHINE_START(MSM_DT)
>         .smp = smp_ops(msm_smp_ops),
>         .dt_compat = msm_dt_match,
>  MACHINE_END
> diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
> index e2acff9..168a963 100644
> --- a/arch/arm/mach-mvebu/armada-370-xp.c
> +++ b/arch/arm/mach-mvebu/armada-370-xp.c
> @@ -55,7 +55,7 @@ static const char * const armada_370_xp_dt_compat[] = {
>         NULL,
>  };
>
> -DT_MACHINE_START(ARMADA_XP_DT, "Marvell Armada 370/XP (Device Tree)")
> +DT_MACHINE_START(ARMADA_XP_DT)
>         .smp            = smp_ops(armada_xp_smp_ops),
>         .init_machine   = armada_370_xp_dt_init,
>         .map_io         = armada_370_xp_map_io,
> diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> index 1dc5acd..26bbc0f 100644
> --- a/arch/arm/mach-mxs/mach-mxs.c
> +++ b/arch/arm/mach-mxs/mach-mxs.c
> @@ -501,7 +501,7 @@ static const char *mxs_dt_compat[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(MXS, "Freescale MXS (Device Tree)")
> +DT_MACHINE_START(MXS)
>         .handle_irq     = icoll_handle_irq,
>         .init_machine   = mxs_machine_init,
>         .init_late      = mxs_pm_init,
> diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
> index cce2c9d..4ab4f0e 100644
> --- a/arch/arm/mach-nomadik/cpu-8815.c
> +++ b/arch/arm/mach-nomadik/cpu-8815.c
> @@ -189,7 +189,7 @@ static const char * cpu8815_board_compat[] = {
>         NULL,
>  };
>
> -DT_MACHINE_START(NOMADIK_DT, "Nomadik STn8815")
> +DT_MACHINE_START(NOMADIK_DT)
>         .map_io         = cpu8815_map_io,
>         .init_machine   = cpu8815_init_of,
>         .restart        = cpu8815_restart,
> diff --git a/arch/arm/mach-nspire/nspire.c b/arch/arm/mach-nspire/nspire.c
> index 4b2ed2e..26bceb9 100644
> --- a/arch/arm/mach-nspire/nspire.c
> +++ b/arch/arm/mach-nspire/nspire.c
> @@ -72,7 +72,7 @@ static void nspire_restart(char mode, const char *cmd)
>         writel(2, base + NSPIRE_MISC_HWRESET);
>  }
>
> -DT_MACHINE_START(NSPIRE, "TI-NSPIRE")
> +DT_MACHINE_START(NSPIRE)
>         .dt_compat      = nspire_dt_match,
>         .map_io         = nspire_map_io,
>         .init_machine   = nspire_init,
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index 19f1652..89d5bdd 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -44,7 +44,7 @@ static const char *omap242x_boards_compat[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(OMAP242X_DT, "Generic OMAP2420 (Flattened Device Tree)")
> +DT_MACHINE_START(OMAP242X_DT)
>         .reserve        = omap_reserve,
>         .map_io         = omap242x_map_io,
>         .init_early     = omap2420_init_early,
> @@ -63,7 +63,7 @@ static const char *omap243x_boards_compat[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(OMAP243X_DT, "Generic OMAP2430 (Flattened Device Tree)")
> +DT_MACHINE_START(OMAP243X_DT)
>         .reserve        = omap_reserve,
>         .map_io         = omap243x_map_io,
>         .init_early     = omap2430_init_early,
> @@ -82,7 +82,7 @@ static const char *omap3_boards_compat[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
> +DT_MACHINE_START(OMAP3_DT)
>         .reserve        = omap_reserve,
>         .map_io         = omap3_map_io,
>         .init_early     = omap3430_init_early,
> @@ -100,7 +100,7 @@ static const char *omap36xx_boards_compat[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(OMAP36XX_DT, "Generic OMAP36xx (Flattened Device Tree)")
> +DT_MACHINE_START(OMAP36XX_DT)
>         .reserve        = omap_reserve,
>         .map_io         = omap3_map_io,
>         .init_early     = omap3630_init_early,
> @@ -119,7 +119,7 @@ static const char *omap3_gp_boards_compat[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(OMAP3_GP_DT, "Generic OMAP3-GP (Flattened Device Tree)")
> +DT_MACHINE_START(OMAP3_GP_DT)
>         .reserve        = omap_reserve,
>         .map_io         = omap3_map_io,
>         .init_early     = omap3430_init_early,
> @@ -139,7 +139,7 @@ static const char *am33xx_boards_compat[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
> +DT_MACHINE_START(AM33XX_DT)
>         .reserve        = omap_reserve,
>         .map_io         = am33xx_map_io,
>         .init_early     = am33xx_init_early,
> @@ -159,7 +159,7 @@ static const char *omap4_boards_compat[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
> +DT_MACHINE_START(OMAP4_DT)
>         .reserve        = omap_reserve,
>         .smp            = smp_ops(omap4_smp_ops),
>         .map_io         = omap4_map_io,
> @@ -179,7 +179,7 @@ static const char *omap5_boards_compat[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(OMAP5_DT, "Generic OMAP5 (Flattened Device Tree)")
> +DT_MACHINE_START(OMAP5_DT)
>         .reserve        = omap_reserve,
>         .smp            = smp_ops(omap4_smp_ops),
>         .map_io         = omap5_map_io,
> @@ -199,7 +199,7 @@ static const char *am43_boards_compat[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(AM43_DT, "Generic AM43 (Flattened Device Tree)")
> +DT_MACHINE_START(AM43_DT)
>         .map_io         = am33xx_map_io,
>         .init_early     = am43xx_init_early,
>         .init_late      = am43xx_init_late,
> @@ -216,7 +216,7 @@ static const char *dra7xx_boards_compat[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(DRA7XX_DT, "Generic DRA7XX (Flattened Device Tree)")
> +DT_MACHINE_START(DRA7XX_DT)
>         .reserve        = omap_reserve,
>         .smp            = smp_ops(omap4_smp_ops),
>         .map_io         = omap5_map_io,
> diff --git a/arch/arm/mach-orion5x/board-dt.c b/arch/arm/mach-orion5x/board-dt.c
> index b91002c..ee2d6e9 100644
> --- a/arch/arm/mach-orion5x/board-dt.c
> +++ b/arch/arm/mach-orion5x/board-dt.c
> @@ -68,7 +68,7 @@ static const char *orion5x_dt_compat[] = {
>         NULL,
>  };
>
> -DT_MACHINE_START(ORION5X_DT, "Marvell Orion5x (Flattened Device Tree)")
> +DT_MACHINE_START(ORION5X_DT)
>         /* Maintainer: Thomas Petazzoni <thomas.petazzoni@free-electrons.com> */
>         .map_io         = orion5x_map_io,
>         .init_early     = orion5x_init_early,
> diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
> index ec79fea..ffe1270 100644
> --- a/arch/arm/mach-picoxcell/common.c
> +++ b/arch/arm/mach-picoxcell/common.c
> @@ -78,7 +78,7 @@ static void picoxcell_wdt_restart(enum reboot_mode mode, const char *cmd)
>         }
>  }
>
> -DT_MACHINE_START(PICOXCELL, "Picochip picoXcell")
> +DT_MACHINE_START(PICOXCELL)
>         .map_io         = picoxcell_map_io,
>         .init_machine   = picoxcell_init_machine,
>         .dt_compat      = picoxcell_dt_match,
> diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
> index d49aff7..2ca30d5 100644
> --- a/arch/arm/mach-prima2/common.c
> +++ b/arch/arm/mach-prima2/common.c
> @@ -32,7 +32,7 @@ static const char *atlas6_dt_match[] __initdata = {
>         NULL
>  };
>
> -DT_MACHINE_START(ATLAS6_DT, "Generic ATLAS6 (Flattened Device Tree)")
> +DT_MACHINE_START(ATLAS6_DT)
>         /* Maintainer: Barry Song <baohua.song@csr.com> */
>         .map_io         = sirfsoc_map_io,
>         .init_late      = sirfsoc_init_late,
> @@ -47,7 +47,7 @@ static const char *prima2_dt_match[] __initdata = {
>         NULL
>  };
>
> -DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
> +DT_MACHINE_START(PRIMA2_DT)
>         /* Maintainer: Barry Song <baohua.song@csr.com> */
>         .map_io         = sirfsoc_map_io,
>         .dma_zone_size  = SZ_256M,
> @@ -63,7 +63,7 @@ static const char *marco_dt_match[] __initdata = {
>         NULL
>  };
>
> -DT_MACHINE_START(MARCO_DT, "Generic MARCO (Flattened Device Tree)")
> +DT_MACHINE_START(MARCO_DT)
>         /* Maintainer: Barry Song <baohua.song@csr.com> */
>         .smp            = smp_ops(sirfsoc_smp_ops),
>         .map_io         = sirfsoc_map_io,
> diff --git a/arch/arm/mach-pxa/pxa-dt.c b/arch/arm/mach-pxa/pxa-dt.c
> index f6a2c4b..b7fcb0c 100644
> --- a/arch/arm/mach-pxa/pxa-dt.c
> +++ b/arch/arm/mach-pxa/pxa-dt.c
> @@ -51,7 +51,7 @@ static const char *pxa3xx_dt_board_compat[] __initdata = {
>  #endif
>
>  #ifdef CONFIG_PXA3xx
> -DT_MACHINE_START(PXA_DT, "Marvell PXA3xx (Device Tree Support)")
> +DT_MACHINE_START(PXA_DT)
>         .map_io         = pxa3xx_map_io,
>         .init_irq       = pxa3xx_dt_init_irq,
>         .handle_irq     = pxa3xx_handle_irq,
> diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
> index 82c0b07..c14c517 100644
> --- a/arch/arm/mach-rockchip/rockchip.c
> +++ b/arch/arm/mach-rockchip/rockchip.c
> @@ -37,7 +37,7 @@ static const char * const rockchip_board_dt_compat[] = {
>         NULL,
>  };
>
> -DT_MACHINE_START(ROCKCHIP_DT, "Rockchip Cortex-A9 (Device Tree)")
> +DT_MACHINE_START(ROCKCHIP_DT)
>         .init_machine   = rockchip_dt_init,
>         .dt_compat      = rockchip_board_dt_compat,
>  MACHINE_END
> diff --git a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
> index f50454a..a6ae5d7 100644
> --- a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
> +++ b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
> @@ -80,7 +80,7 @@ static char const *s3c2416_dt_compat[] __initdata = {
>         NULL
>  };
>
> -DT_MACHINE_START(S3C2416_DT, "Samsung S3C2416 (Flattened Device Tree)")
> +DT_MACHINE_START(S3C2416_DT)
>         /* Maintainer: Heiko Stuebner <heiko@sntech.de> */
>         .dt_compat      = s3c2416_dt_compat,
>         .map_io         = s3c2416_dt_map_io,
> diff --git a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c b/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
> index 7eb9a10..7becf1a 100644
> --- a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
> +++ b/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
> @@ -75,7 +75,7 @@ static char const *s3c64xx_dt_compat[] __initdata = {
>         NULL
>  };
>
> -DT_MACHINE_START(S3C6400_DT, "Samsung S3C64xx (Flattened Device Tree)")
> +DT_MACHINE_START(S3C6400_DT)
>         /* Maintainer: Tomasz Figa <tomasz.figa@gmail.com> */
>         .dt_compat      = s3c64xx_dt_compat,
>         .map_io         = s3c64xx_dt_map_io,
> diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
> index 3276afc..fffe53c 100644
> --- a/arch/arm/mach-shmobile/board-ape6evm-reference.c
> +++ b/arch/arm/mach-shmobile/board-ape6evm-reference.c
> @@ -56,7 +56,7 @@ static const char *ape6evm_boards_compat_dt[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(APE6EVM_DT, "ape6evm")
> +DT_MACHINE_START(APE6EVM_DT)
>         .init_early     = r8a73a4_init_early,
>         .init_machine   = ape6evm_add_standard_devices,
>         .dt_compat      = ape6evm_boards_compat_dt,
> diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
> index 0fa068e..a2df979 100644
> --- a/arch/arm/mach-shmobile/board-ape6evm.c
> +++ b/arch/arm/mach-shmobile/board-ape6evm.c
> @@ -280,7 +280,7 @@ static const char *ape6evm_boards_compat_dt[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(APE6EVM_DT, "ape6evm")
> +DT_MACHINE_START(APE6EVM_DT)
>         .init_early     = r8a73a4_init_early,
>         .init_machine   = ape6evm_add_standard_devices,
>         .dt_compat      = ape6evm_boards_compat_dt,
> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
> index 57d1a78..ea3b1e1 100644
> --- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
> @@ -185,7 +185,7 @@ static const char *eva_boards_compat_dt[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva-reference")
> +DT_MACHINE_START(ARMADILLO800EVA_DT)
>         .map_io         = r8a7740_map_io,
>         .init_early     = r8a7740_init_delay,
>         .init_irq       = r8a7740_init_irq_of,
> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
> index 8bc8e4c..e8f1e74 100644
> --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
> @@ -1311,7 +1311,7 @@ static const char *eva_boards_compat_dt[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva")
> +DT_MACHINE_START(ARMADILLO800EVA_DT)
>         .map_io         = r8a7740_map_io,
>         .init_early     = eva_add_early_devices,
>         .init_irq       = r8a7740_init_irq_of,
> diff --git a/arch/arm/mach-shmobile/board-bockw-reference.c b/arch/arm/mach-shmobile/board-bockw-reference.c
> index ae88fda..60bd5df 100644
> --- a/arch/arm/mach-shmobile/board-bockw-reference.c
> +++ b/arch/arm/mach-shmobile/board-bockw-reference.c
> @@ -73,7 +73,7 @@ static const char *bockw_boards_compat_dt[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(BOCKW_DT, "bockw")
> +DT_MACHINE_START(BOCKW_DT)
>         .init_early     = r8a7778_init_delay,
>         .init_irq       = r8a7778_init_irq_dt,
>         .init_machine   = bockw_init,
> diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
> index 6163fb1..8ff74db 100644
> --- a/arch/arm/mach-shmobile/board-bockw.c
> +++ b/arch/arm/mach-shmobile/board-bockw.c
> @@ -697,7 +697,7 @@ static const char *bockw_boards_compat_dt[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(BOCKW_DT, "bockw")
> +DT_MACHINE_START(BOCKW_DT)
>         .init_early     = r8a7778_init_delay,
>         .init_irq       = r8a7778_init_irq_dt,
>         .init_machine   = bockw_init,
> diff --git a/arch/arm/mach-shmobile/board-genmai.c b/arch/arm/mach-shmobile/board-genmai.c
> index 3e92e3c..1117ad8 100644
> --- a/arch/arm/mach-shmobile/board-genmai.c
> +++ b/arch/arm/mach-shmobile/board-genmai.c
> @@ -36,7 +36,7 @@ static const char * const genmai_boards_compat_dt[] __initconst = {
>         NULL,
>  };
>
> -DT_MACHINE_START(GENMAI_DT, "genmai")
> +DT_MACHINE_START(GENMAI_DT)
>         .init_early     = r7s72100_init_early,
>         .init_machine   = genmai_add_standard_devices,
>         .dt_compat      = genmai_boards_compat_dt,
> diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
> index ace1711..d923206 100644
> --- a/arch/arm/mach-shmobile/board-koelsch.c
> +++ b/arch/arm/mach-shmobile/board-koelsch.c
> @@ -38,7 +38,7 @@ static const char * const koelsch_boards_compat_dt[] __initconst = {
>         NULL,
>  };
>
> -DT_MACHINE_START(KOELSCH_DT, "koelsch")
> +DT_MACHINE_START(KOELSCH_DT)
>         .smp            = smp_ops(r8a7791_smp_ops),
>         .init_early     = r8a7791_init_early,
>         .init_machine   = koelsch_add_standard_devices,
> diff --git a/arch/arm/mach-shmobile/board-kzm9d-reference.c b/arch/arm/mach-shmobile/board-kzm9d-reference.c
> index 054d8d5..7d4d8d6 100644
> --- a/arch/arm/mach-shmobile/board-kzm9d-reference.c
> +++ b/arch/arm/mach-shmobile/board-kzm9d-reference.c
> @@ -38,7 +38,7 @@ static const char *kzm9d_boards_compat_dt[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(KZM9D_DT, "kzm9d")
> +DT_MACHINE_START(KZM9D_DT)
>         .smp            = smp_ops(emev2_smp_ops),
>         .map_io         = emev2_map_io,
>         .init_early     = emev2_init_delay,
> diff --git a/arch/arm/mach-shmobile/board-kzm9d.c b/arch/arm/mach-shmobile/board-kzm9d.c
> index 30c2cc6..a6ed124 100644
> --- a/arch/arm/mach-shmobile/board-kzm9d.c
> +++ b/arch/arm/mach-shmobile/board-kzm9d.c
> @@ -82,7 +82,7 @@ static const char *kzm9d_boards_compat_dt[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(KZM9D_DT, "kzm9d")
> +DT_MACHINE_START(KZM9D_DT)
>         .smp            = smp_ops(emev2_smp_ops),
>         .map_io         = emev2_map_io,
>         .init_early     = emev2_init_delay,
> diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> index 598e324..c345976 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> @@ -46,7 +46,7 @@ static const char *kzm9g_boards_compat_dt[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
> +DT_MACHINE_START(KZM9G_DT)
>         .smp            = smp_ops(sh73a0_smp_ops),
>         .map_io         = sh73a0_map_io,
>         .init_early     = sh73a0_init_delay,
> diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
> index fe689b7..6fd22ee 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g.c
> @@ -904,7 +904,7 @@ static const char *kzm9g_boards_compat_dt[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(KZM9G_DT, "kzm9g")
> +DT_MACHINE_START(KZM9G_DT)
>         .smp            = smp_ops(sh73a0_smp_ops),
>         .map_io         = sh73a0_map_io,
>         .init_early     = sh73a0_add_early_devices,
> diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
> index 1a1a4a8..624356d 100644
> --- a/arch/arm/mach-shmobile/board-lager-reference.c
> +++ b/arch/arm/mach-shmobile/board-lager-reference.c
> @@ -37,7 +37,7 @@ static const char *lager_boards_compat_dt[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(LAGER_DT, "lager")
> +DT_MACHINE_START(LAGER_DT)
>         .smp            = smp_ops(r8a7790_smp_ops),
>         .init_early     = r8a7790_init_early,
>         .init_time      = rcar_gen2_timer_init,
> diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
> index a8d3ce6..7ff9ae4 100644
> --- a/arch/arm/mach-shmobile/board-lager.c
> +++ b/arch/arm/mach-shmobile/board-lager.c
> @@ -253,7 +253,7 @@ static const char * const lager_boards_compat_dt[] __initconst = {
>         NULL,
>  };
>
> -DT_MACHINE_START(LAGER_DT, "lager")
> +DT_MACHINE_START(LAGER_DT)
>         .smp            = smp_ops(r8a7790_smp_ops),
>         .init_early     = r8a7790_init_early,
>         .init_time      = rcar_gen2_timer_init,
> diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
> index af06753..e033b93 100644
> --- a/arch/arm/mach-shmobile/board-mackerel.c
> +++ b/arch/arm/mach-shmobile/board-mackerel.c
> @@ -1510,7 +1510,7 @@ static const char *mackerel_boards_compat_dt[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(MACKEREL_DT, "mackerel")
> +DT_MACHINE_START(MACKEREL_DT)
>         .map_io         = sh7372_map_io,
>         .init_early     = sh7372_add_early_devices,
>         .init_irq       = sh7372_init_irq,
> diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
> index 2773936..a00256b 100644
> --- a/arch/arm/mach-shmobile/board-marzen-reference.c
> +++ b/arch/arm/mach-shmobile/board-marzen-reference.c
> @@ -36,7 +36,7 @@ static const char *marzen_boards_compat_dt[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(MARZEN, "marzen")
> +DT_MACHINE_START(MARZEN)
>         .smp            = smp_ops(r8a7779_smp_ops),
>         .map_io         = r8a7779_map_io,
>         .init_early     = r8a7779_init_delay,
> diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
> index da1352f..9eac68d 100644
> --- a/arch/arm/mach-shmobile/board-marzen.c
> +++ b/arch/arm/mach-shmobile/board-marzen.c
> @@ -378,7 +378,7 @@ static const char *marzen_boards_compat_dt[] __initdata = {
>          NULL,
>  };
>
> -DT_MACHINE_START(MARZEN, "marzen")
> +DT_MACHINE_START(MARZEN)
>         .smp            = smp_ops(r8a7779_smp_ops),
>         .map_io         = r8a7779_map_io,
>         .init_early     = r8a7779_add_early_devices,
> diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
> index 3ad531c..5ede34d 100644
> --- a/arch/arm/mach-shmobile/setup-emev2.c
> +++ b/arch/arm/mach-shmobile/setup-emev2.c
> @@ -202,7 +202,7 @@ static const char *emev2_boards_compat_dt[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
> +DT_MACHINE_START(EMEV2_DT)
>         .smp            = smp_ops(emev2_smp_ops),
>         .map_io         = emev2_map_io,
>         .init_early     = emev2_init_delay,
> diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c b/arch/arm/mach-shmobile/setup-r7s72100.c
> index d4eb509..78ed46a 100644
> --- a/arch/arm/mach-shmobile/setup-r7s72100.c
> +++ b/arch/arm/mach-shmobile/setup-r7s72100.c
> @@ -81,7 +81,7 @@ static const char *r7s72100_boards_compat_dt[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(R7S72100_DT, "Generic R7S72100 (Flattened Device Tree)")
> +DT_MACHINE_START(R7S72100_DT)
>         .init_early     = r7s72100_init_early,
>         .dt_compat      = r7s72100_boards_compat_dt,
>  MACHINE_END
> diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
> index b0f2749..6027b92 100644
> --- a/arch/arm/mach-shmobile/setup-r8a73a4.c
> +++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
> @@ -312,7 +312,7 @@ static const char *r8a73a4_boards_compat_dt[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
> +DT_MACHINE_START(R8A73A4_DT)
>         .init_early     = r8a73a4_init_early,
>         .dt_compat      = r8a73a4_boards_compat_dt,
>  MACHINE_END
> diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
> index b7d4b2c..c18f2a0e 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7740.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7740.c
> @@ -1062,7 +1062,7 @@ static const char *r8a7740_boards_compat_dt[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
> +DT_MACHINE_START(R8A7740_DT)
>         .map_io         = r8a7740_map_io,
>         .init_early     = r8a7740_init_delay,
>         .init_irq       = r8a7740_init_irq_of,
> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
> index 03fcc59..f86e80f 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
> @@ -493,7 +493,7 @@ static const char *r8a7778_compat_dt[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(R8A7778_DT, "Generic R8A7778 (Flattened Device Tree)")
> +DT_MACHINE_START(R8A7778_DT)
>         .init_early     = r8a7778_init_delay,
>         .init_irq       = r8a7778_init_irq_dt,
>         .dt_compat      = r8a7778_compat_dt,
> diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
> index 13049e9..0b8c6d4 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7779.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7779.c
> @@ -936,7 +936,7 @@ static const char *r8a7779_compat_dt[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(R8A7779_DT, "Generic R8A7779 (Flattened Device Tree)")
> +DT_MACHINE_START(R8A7779_DT)
>         .map_io         = r8a7779_map_io,
>         .init_early     = r8a7779_init_delay,
>         .nr_irqs        = NR_IRQS_LEGACY,
> diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
> index c47bceb..3dcbdb2 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7790.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7790.c
> @@ -216,7 +216,7 @@ static const char * const r8a7790_boards_compat_dt[] __initconst = {
>         NULL,
>  };
>
> -DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
> +DT_MACHINE_START(R8A7790_DT)
>         .smp            = smp_ops(r8a7790_smp_ops),
>         .init_early     = r8a7790_init_early,
>         .init_time      = rcar_gen2_timer_init,
> diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
> index d9393d6..ec49e9e 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7791.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7791.c
> @@ -175,7 +175,7 @@ static const char *r8a7791_boards_compat_dt[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(R8A7791_DT, "Generic R8A7791 (Flattened Device Tree)")
> +DT_MACHINE_START(R8A7791_DT)
>         .smp            = smp_ops(r8a7791_smp_ops),
>         .init_early     = r8a7791_init_early,
>         .init_time      = rcar_gen2_timer_init,
> diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
> index 3118783..6c22b68 100644
> --- a/arch/arm/mach-shmobile/setup-sh7372.c
> +++ b/arch/arm/mach-shmobile/setup-sh7372.c
> @@ -1162,7 +1162,7 @@ static const char *sh7372_boards_compat_dt[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(SH7372_DT, "Generic SH7372 (Flattened Device Tree)")
> +DT_MACHINE_START(SH7372_DT)
>         .map_io         = sh7372_map_io,
>         .init_early     = sh7372_add_early_devices_dt,
>         .nr_irqs        = NR_IRQS_LEGACY,
> diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
> index 22de174..f49279e 100644
> --- a/arch/arm/mach-shmobile/setup-sh73a0.c
> +++ b/arch/arm/mach-shmobile/setup-sh73a0.c
> @@ -963,7 +963,7 @@ static const char *sh73a0_boards_compat_dt[] __initdata = {
>         NULL,
>  };
>
> -DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
> +DT_MACHINE_START(SH73A0_DT)
>         .smp            = smp_ops(sh73a0_smp_ops),
>         .map_io         = sh73a0_map_io,
>         .init_early     = sh73a0_init_delay,
> diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
> index dd0d49c..1c47025 100644
> --- a/arch/arm/mach-socfpga/socfpga.c
> +++ b/arch/arm/mach-socfpga/socfpga.c
> @@ -114,7 +114,7 @@ static const char *altera_dt_match[] = {
>         NULL
>  };
>
> -DT_MACHINE_START(SOCFPGA, "Altera SOCFPGA")
> +DT_MACHINE_START(SOCFPGA)
>         .smp            = smp_ops(socfpga_smp_ops),
>         .map_io         = socfpga_map_io,
>         .init_irq       = socfpga_init_irq,
> diff --git a/arch/arm/mach-spear/spear1310.c b/arch/arm/mach-spear/spear1310.c
> index 7ad0030..388b055 100644
> --- a/arch/arm/mach-spear/spear1310.c
> +++ b/arch/arm/mach-spear/spear1310.c
> @@ -56,7 +56,7 @@ static void __init spear1310_map_io(void)
>         spear13xx_map_io();
>  }
>
> -DT_MACHINE_START(SPEAR1310_DT, "ST SPEAr1310 SoC with Flattened Device Tree")
> +DT_MACHINE_START(SPEAR1310_DT)
>         .smp            =       smp_ops(spear13xx_smp_ops),
>         .map_io         =       spear1310_map_io,
>         .init_time      =       spear13xx_timer_init,
> diff --git a/arch/arm/mach-spear/spear1340.c b/arch/arm/mach-spear/spear1340.c
> index 3fb6834..009815e 100644
> --- a/arch/arm/mach-spear/spear1340.c
> +++ b/arch/arm/mach-spear/spear1340.c
> @@ -151,7 +151,7 @@ static const char * const spear1340_dt_board_compat[] = {
>         NULL,
>  };
>
> -DT_MACHINE_START(SPEAR1340_DT, "ST SPEAr1340 SoC with Flattened Device Tree")
> +DT_MACHINE_START(SPEAR1340_DT)
>         .smp            =       smp_ops(spear13xx_smp_ops),
>         .map_io         =       spear13xx_map_io,
>         .init_time      =       spear13xx_timer_init,
> diff --git a/arch/arm/mach-spear/spear300.c b/arch/arm/mach-spear/spear300.c
> index b52e48f..bd094b3 100644
> --- a/arch/arm/mach-spear/spear300.c
> +++ b/arch/arm/mach-spear/spear300.c
> @@ -209,7 +209,7 @@ static void __init spear300_map_io(void)
>         spear3xx_map_io();
>  }
>
> -DT_MACHINE_START(SPEAR300_DT, "ST SPEAr300 SoC with Flattened Device Tree")
> +DT_MACHINE_START(SPEAR300_DT)
>         .map_io         =       spear300_map_io,
>         .init_time      =       spear3xx_timer_init,
>         .init_machine   =       spear300_dt_init,
> diff --git a/arch/arm/mach-spear/spear310.c b/arch/arm/mach-spear/spear310.c
> index ed2029d..465e916 100644
> --- a/arch/arm/mach-spear/spear310.c
> +++ b/arch/arm/mach-spear/spear310.c
> @@ -251,7 +251,7 @@ static void __init spear310_map_io(void)
>         spear3xx_map_io();
>  }
>
> -DT_MACHINE_START(SPEAR310_DT, "ST SPEAr310 SoC with Flattened Device Tree")
> +DT_MACHINE_START(SPEAR310_DT)
>         .map_io         =       spear310_map_io,
>         .init_time      =       spear3xx_timer_init,
>         .init_machine   =       spear310_dt_init,
> diff --git a/arch/arm/mach-spear/spear320.c b/arch/arm/mach-spear/spear320.c
> index bf634b3..6b6b381 100644
> --- a/arch/arm/mach-spear/spear320.c
> +++ b/arch/arm/mach-spear/spear320.c
> @@ -266,7 +266,7 @@ static void __init spear320_map_io(void)
>         spear3xx_map_io();
>  }
>
> -DT_MACHINE_START(SPEAR320_DT, "ST SPEAr320 SoC with Flattened Device Tree")
> +DT_MACHINE_START(SPEAR320_DT)
>         .map_io         =       spear320_map_io,
>         .init_time      =       spear3xx_timer_init,
>         .init_machine   =       spear320_dt_init,
> diff --git a/arch/arm/mach-spear/spear6xx.c b/arch/arm/mach-spear/spear6xx.c
> index da26fa5..a69fc83 100644
> --- a/arch/arm/mach-spear/spear6xx.c
> +++ b/arch/arm/mach-spear/spear6xx.c
> @@ -420,7 +420,7 @@ static const char *spear600_dt_board_compat[] = {
>         NULL
>  };
>
> -DT_MACHINE_START(SPEAR600_DT, "ST SPEAr600 (Flattened Device Tree)")
> +DT_MACHINE_START(SPEAR600_DT)
>         .map_io         =       spear6xx_map_io,
>         .init_time      =       spear6xx_timer_init,
>         .init_machine   =       spear600_dt_init,
> diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
> index 1217fb5..6cd60cb 100644
> --- a/arch/arm/mach-sti/board-dt.c
> +++ b/arch/arm/mach-sti/board-dt.c
> @@ -39,7 +39,7 @@ static const char *stih41x_dt_match[] __initdata = {
>         NULL
>  };
>
> -DT_MACHINE_START(STM, "STiH415/416 SoC with Flattened Device Tree")
> +DT_MACHINE_START(STM)
>         .init_machine   = stih41x_machine_init,
>         .smp            = smp_ops(sti_smp_ops),
>         .dt_compat      = stih41x_dt_match,
> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> index 61d3a38..fb307fa 100644
> --- a/arch/arm/mach-sunxi/sunxi.c
> +++ b/arch/arm/mach-sunxi/sunxi.c
> @@ -121,7 +121,7 @@ static const char * const sunxi_board_dt_compat[] = {
>         NULL,
>  };
>
> -DT_MACHINE_START(SUNXI_DT, "Allwinner A1X (Device Tree)")
> +DT_MACHINE_START(SUNXI_DT)
>         .init_machine   = sunxi_dt_init,
>         .dt_compat      = sunxi_board_dt_compat,
>         .restart        = sun4i_restart,
> @@ -132,7 +132,7 @@ static const char * const sun6i_board_dt_compat[] = {
>         NULL,
>  };
>
> -DT_MACHINE_START(SUN6I_DT, "Allwinner sun6i (A31) Family")
> +DT_MACHINE_START(SUN6I_DT)
>         .init_machine   = sunxi_dt_init,
>         .dt_compat      = sun6i_board_dt_compat,
>         .restart        = sun6i_restart,
> @@ -143,7 +143,7 @@ static const char * const sun7i_board_dt_compat[] = {
>         NULL,
>  };
>
> -DT_MACHINE_START(SUN7I_DT, "Allwinner sun7i (A20) Family")
> +DT_MACHINE_START(SUN7I_DT)
>         .init_machine   = sunxi_dt_init,
>         .dt_compat      = sun7i_board_dt_compat,
>         .restart        = sun4i_restart,
> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
> index ce553d5..90bff68 100644
> --- a/arch/arm/mach-tegra/tegra.c
> +++ b/arch/arm/mach-tegra/tegra.c
> @@ -180,7 +180,7 @@ static const char * const tegra_dt_board_compat[] = {
>         NULL
>  };
>
> -DT_MACHINE_START(TEGRA_DT, "NVIDIA Tegra SoC (Flattened Device Tree)")
> +DT_MACHINE_START(TEGRA_DT)
>         .map_io         = tegra_map_common_io,
>         .smp            = smp_ops(tegra_smp_ops),
>         .init_early     = tegra_init_early,
> diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
> index 35670b1..8bac5c8 100644
> --- a/arch/arm/mach-u300/core.c
> +++ b/arch/arm/mach-u300/core.c
> @@ -405,7 +405,7 @@ static const char * u300_board_compat[] = {
>         NULL,
>  };
>
> -DT_MACHINE_START(U300_DT, "U300 S335/B335 (Device Tree)")
> +DT_MACHINE_START(U300_DT)
>         .map_io         = u300_map_io,
>         .init_irq       = u300_init_irq_dt,
>         .init_time      = clocksource_of_init,
> diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
> index 2e85c1e..8506568 100644
> --- a/arch/arm/mach-ux500/cpu-db8500.c
> +++ b/arch/arm/mach-ux500/cpu-db8500.c
> @@ -210,7 +210,7 @@ static const char * stericsson_dt_platform_compat[] = {
>         NULL,
>  };
>
> -DT_MACHINE_START(U8500_DT, "ST-Ericsson Ux5x0 platform (Device Tree Support)")
> +DT_MACHINE_START(U8500_DT)
>         .smp            = smp_ops(ux500_smp_ops),
>         .map_io         = u8500_map_io,
>         .init_irq       = ux500_init_irq,
> diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile_dt.c
> index 3621b00..4940da8 100644
> --- a/arch/arm/mach-versatile/versatile_dt.c
> +++ b/arch/arm/mach-versatile/versatile_dt.c
> @@ -41,7 +41,7 @@ static const char *versatile_dt_match[] __initconst = {
>         NULL,
>  };
>
> -DT_MACHINE_START(VERSATILE_PB, "ARM-Versatile (Device Tree Support)")
> +DT_MACHINE_START(VERSATILE_PB)
>         .map_io         = versatile_map_io,
>         .init_early     = versatile_init_early,
>         .init_irq       = versatile_init_irq,
> diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
> index 4f8b8cb..868c40c 100644
> --- a/arch/arm/mach-vexpress/v2m.c
> +++ b/arch/arm/mach-vexpress/v2m.c
> @@ -441,7 +441,7 @@ static const char * const v2m_dt_match[] __initconst = {
>         NULL,
>  };
>
> -DT_MACHINE_START(VEXPRESS_DT, "ARM-Versatile Express")
> +DT_MACHINE_START(VEXPRESS_DT)
>         .dt_compat      = v2m_dt_match,
>         .smp            = smp_ops(vexpress_smp_ops),
>         .smp_init       = smp_init_ops(vexpress_smp_init_ops),
> diff --git a/arch/arm/mach-virt/virt.c b/arch/arm/mach-virt/virt.c
> index b184e57..d1495fd 100644
> --- a/arch/arm/mach-virt/virt.c
> +++ b/arch/arm/mach-virt/virt.c
> @@ -35,7 +35,7 @@ static const char *virt_dt_match[] = {
>         NULL
>  };
>
> -DT_MACHINE_START(VIRT, "Dummy Virtual Machine")
> +DT_MACHINE_START(VIRT)
>         .init_machine   = virt_init,
>         .dt_compat      = virt_dt_match,
>  MACHINE_END
> diff --git a/arch/arm/mach-vt8500/vt8500.c b/arch/arm/mach-vt8500/vt8500.c
> index 4a73464..373b4a6 100644
> --- a/arch/arm/mach-vt8500/vt8500.c
> +++ b/arch/arm/mach-vt8500/vt8500.c
> @@ -171,7 +171,7 @@ static const char * const vt8500_dt_compat[] = {
>         NULL
>  };
>
> -DT_MACHINE_START(WMT_DT, "VIA/Wondermedia SoC (Device Tree Support)")
> +DT_MACHINE_START(WMT_DT)
>         .dt_compat      = vt8500_dt_compat,
>         .map_io         = vt8500_map_io,
>         .init_machine   = vt8500_init,
> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
> index 5f25256..f36211c 100644
> --- a/arch/arm/mach-zynq/common.c
> +++ b/arch/arm/mach-zynq/common.c
> @@ -101,7 +101,7 @@ static const char * const zynq_dt_match[] = {
>         NULL
>  };
>
> -DT_MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
> +DT_MACHINE_START(XILINX_EP107)
>         .smp            = smp_ops(zynq_smp_ops),
>         .map_io         = zynq_map_io,
>         .init_machine   = zynq_init_machine,
> --
> 1.8.1.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
