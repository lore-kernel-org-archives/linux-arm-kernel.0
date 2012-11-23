From: padma.kvr@gmail.com (Padma Venkat)
Date: Fri, 23 Nov 2012 16:50:35 +0530
Subject: [PATCH V3] ARM: EXYNOS5: Add clocks for EXYNOS5 Audio Subsystem.
In-Reply-To: <1352176731-16199-1-git-send-email-padma.v@samsung.com>
References: <1352176731-16199-1-git-send-email-padma.v@samsung.com>
Message-ID: <CAAgF-BeKuRM+RgprMwEsz9e-1XjhmKa9niLmFZPpTagLTMd4FA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cc'ing Mark Brown.

On Tue, Nov 6, 2012 at 10:08 AM, Padmavathi Venna <padma.v@samsung.com> wrote:
> This patch adds all the required clock instances for audio
> subsystem and adds the clock alias names for sclk-i2s and
> i2s-bus clks. This patch also do the static mapping
> of audss clock base address to control audss clocks in CMU
> clock framework.
>
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> ---
>
> Changes since V2:
>         - Rebased on 3.7-rc3
>
> Changes since V1:
>         - Rebased on 3.6-rc6
>         - Modified some of the clk names as suggested by Kukjin Kim
>         - Added NULL in place of cdclk of sclk_audio0 src list as it
>           is machine dependent and I am not using it as src.
>
>  arch/arm/mach-exynos/clock-exynos5.c           |  117 ++++++++++++++++++++++++
>  arch/arm/mach-exynos/common.c                  |    5 +
>  arch/arm/mach-exynos/include/mach/map.h        |    1 +
>  arch/arm/mach-exynos/include/mach/regs-audss.h |    7 +-
>  arch/arm/plat-samsung/include/plat/map-s5p.h   |    2 +
>  5 files changed, 131 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
> index a88e0d9..7a61d41 100644
> --- a/arch/arm/mach-exynos/clock-exynos5.c
> +++ b/arch/arm/mach-exynos/clock-exynos5.c
> @@ -24,6 +24,7 @@
>
>  #include <mach/map.h>
>  #include <mach/regs-clock.h>
> +#include <mach/regs-audss.h>
>  #include <mach/sysmmu.h>
>
>  #include "common.h"
> @@ -166,6 +167,16 @@ static int exynos5_clk_ip_gen_ctrl(struct clk *clk, int enable)
>         return s5p_gatectrl(EXYNOS5_CLKGATE_IP_GEN, clk, enable);
>  }
>
> +static int exynos5_clksrc_mask_maudio_ctrl(struct clk *clk, int enable)
> +{
> +       return s5p_gatectrl(EXYNOS5_CLKSRC_MASK_MAUDIO, clk, enable);
> +}
> +
> +static int exynos5_clk_audss_ctrl(struct clk *clk, int enable)
> +{
> +       return s5p_gatectrl(EXYNOS_CLKGATE_AUDSS, clk, enable);
> +}
> +
>  static int exynos5_clk_ip_mfc_ctrl(struct clk *clk, int enable)
>  {
>         return s5p_gatectrl(EXYNOS5_CLKGATE_IP_MFC, clk, enable);
> @@ -707,6 +718,11 @@ static struct clk exynos5_init_clocks_off[] = {
>                 .ctrlbit        = (1 << 3),
>         }, {
>                 .name           = "iis",
> +               .devname        = "samsung-i2s.0",
> +               .enable         = exynos5_clk_audss_ctrl,
> +               .ctrlbit        = (3 << 2),
> +       }, {
> +               .name           = "iis",
>                 .devname        = "samsung-i2s.1",
>                 .enable         = exynos5_clk_ip_peric_ctrl,
>                 .ctrlbit        = (1 << 20),
> @@ -717,6 +733,11 @@ static struct clk exynos5_init_clocks_off[] = {
>                 .ctrlbit        = (1 << 21),
>         }, {
>                 .name           = "pcm",
> +               .devname        = "samsung-pcm.0",
> +               .enable         = exynos5_clk_audss_ctrl,
> +               .ctrlbit        = (3 << 4),
> +       }, {
> +               .name           = "pcm",
>                 .devname        = "samsung-pcm.1",
>                 .enable         = exynos5_clk_ip_peric_ctrl,
>                 .ctrlbit        = (1 << 22),
> @@ -958,6 +979,95 @@ static struct clk exynos5_init_clocks_on[] = {
>         }
>  };
>
> +static struct clk *clkset_sclk_audio0_list[] = {
> +       [0] = NULL,
> +       [1] = &clk_ext_xtal_mux,
> +       [2] = &exynos5_clk_sclk_hdmi27m,
> +       [3] = &exynos5_clk_sclk_dptxphy,
> +       [4] = &exynos5_clk_sclk_usbphy,
> +       [5] = &exynos5_clk_sclk_hdmiphy,
> +       [6] = &exynos5_clk_mout_mpll.clk,
> +       [7] = &exynos5_clk_mout_epll.clk,
> +       [8] = &exynos5_clk_sclk_vpll.clk,
> +       [9] = &exynos5_clk_mout_cpll.clk,
> +};
> +
> +static struct clksrc_sources exynos5_clkset_sclk_audio0 = {
> +       .sources        = clkset_sclk_audio0_list,
> +       .nr_sources     = ARRAY_SIZE(clkset_sclk_audio0_list),
> +};
> +
> +static struct clksrc_clk exynos5_clk_sclk_audio0 = {
> +       .clk    = {
> +               .name           = "sclk-audio0",
> +               .enable         = exynos5_clksrc_mask_maudio_ctrl,
> +               .ctrlbit        = (1 << 0),
> +       },
> +       .sources = &exynos5_clkset_sclk_audio0,
> +       .reg_src = { .reg = EXYNOS5_CLKSRC_MAUDIO, .shift = 0, .size = 4 },
> +       .reg_div = { .reg = EXYNOS5_CLKDIV_MAUDIO, .shift = 0, .size = 4 },
> +};
> +
> +static struct clk *exynos5_clkset_mout_audss_list[] = {
> +       &clk_ext_xtal_mux,
> +       &clk_fout_epll,
> +};
> +
> +static struct clksrc_sources clkset_mout_audss = {
> +       .sources        = exynos5_clkset_mout_audss_list,
> +       .nr_sources     = ARRAY_SIZE(exynos5_clkset_mout_audss_list),
> +};
> +
> +static struct clksrc_clk exynos5_clk_mout_audss = {
> +       .clk    = {
> +               .name           = "mout_audss",
> +       },
> +       .sources = &clkset_mout_audss,
> +       .reg_src = { .reg = EXYNOS_CLKSRC_AUDSS, .shift = 0, .size = 1 },
> +};
> +
> +static struct clk *exynos5_clkset_sclk_i2s_list[] = {
> +       [0] = &exynos5_clk_mout_audss.clk,
> +       [1] = NULL,
> +       [2] = &exynos5_clk_sclk_audio0.clk,
> +};
> +
> +static struct clksrc_sources exynos5_clkset_sclk_i2s = {
> +       .sources        = exynos5_clkset_sclk_i2s_list,
> +       .nr_sources     = ARRAY_SIZE(exynos5_clkset_sclk_i2s_list),
> +};
> +
> +static struct clksrc_clk exynos5_clk_sclk_i2s = {
> +       .clk            = {
> +               .name           = "sclk-i2s",
> +               .devname        = "samsung-i2s.0",
> +               .enable         = exynos5_clk_audss_ctrl,
> +               .ctrlbit        = (1 << 3),
> +       },
> +       .sources = &exynos5_clkset_sclk_i2s,
> +       .reg_src = { .reg = EXYNOS_CLKSRC_AUDSS, .shift = 2, .size = 2 },
> +       .reg_div = { .reg = EXYNOS_CLKDIV_AUDSS, .shift = 8, .size = 4 },
> +};
> +
> +static struct clksrc_clk exynos5_clk_dout_srp = {
> +       .clk    = {
> +               .name           = "dout_srp",
> +               .parent         = &exynos5_clk_mout_audss.clk,
> +       },
> +       .reg_div = { .reg = EXYNOS_CLKDIV_AUDSS, .shift = 0, .size = 4 },
> +};
> +
> +static struct clksrc_clk exynos5_clk_i2s_bus = {
> +       .clk    = {
> +               .name           = "i2s-bus",
> +               .devname        = "samsung-i2s.0",
> +               .parent         = &exynos5_clk_dout_srp.clk,
> +               .enable         = exynos5_clk_audss_ctrl,
> +               .ctrlbit        = (1 << 2),
> +       },
> +       .reg_div = { .reg = EXYNOS_CLKDIV_AUDSS, .shift = 4, .size = 4 },
> +};
> +
>  static struct clk exynos5_clk_pdma0 = {
>         .name           = "dma",
>         .devname        = "dma-pl330.0",
> @@ -1334,6 +1444,9 @@ static struct clksrc_clk *exynos5_sysclks[] = {
>         &exynos5_clk_mdout_spi1,
>         &exynos5_clk_mdout_spi2,
>         &exynos5_clk_sclk_fimd1,
> +       &exynos5_clk_mout_audss,
> +       &exynos5_clk_dout_srp,
> +       &exynos5_clk_sclk_audio0,
>  };
>
>  static struct clk *exynos5_clk_cdev[] = {
> @@ -1352,6 +1465,8 @@ static struct clksrc_clk *exynos5_clksrc_cdev[] = {
>         &exynos5_clk_sclk_mmc1,
>         &exynos5_clk_sclk_mmc2,
>         &exynos5_clk_sclk_mmc3,
> +       &exynos5_clk_i2s_bus,
> +       &exynos5_clk_sclk_i2s,
>  };
>
>  static struct clk_lookup exynos5_clk_lookup[] = {
> @@ -1370,6 +1485,8 @@ static struct clk_lookup exynos5_clk_lookup[] = {
>         CLKDEV_INIT("dma-pl330.1", "apb_pclk", &exynos5_clk_pdma1),
>         CLKDEV_INIT("dma-pl330.2", "apb_pclk", &exynos5_clk_mdma1),
>         CLKDEV_INIT("exynos5-fb.1", "lcd", &exynos5_clk_fimd1),
> +       CLKDEV_INIT("samsung-i2s.0", "i2s_opclk0", &exynos5_clk_sclk_i2s.clk),
> +       CLKDEV_INIT("samsung-i2s.0", "i2s_opclk1", &exynos5_clk_i2s_bus.clk),
>  };
>
>  static unsigned long exynos5_epll_get_rate(struct clk *clk)
> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> index 4e577f6..b4f968a 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -109,6 +109,11 @@ static struct map_desc exynos_iodesc[] __initdata = {
>                 .pfn            = __phys_to_pfn(EXYNOS_PA_CHIPID),
>                 .length         = SZ_4K,
>                 .type           = MT_DEVICE,
> +       }, {
> +               .virtual        = (unsigned long)S5P_VA_AUDSS,
> +               .pfn            = __phys_to_pfn(EXYNOS_PA_AUDSS),
> +               .length         = SZ_4K,
> +               .type           = MT_DEVICE,
>         },
>  };
>
> diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
> index 4192d23..ce15ef5 100644
> --- a/arch/arm/mach-exynos/include/mach/map.h
> +++ b/arch/arm/mach-exynos/include/mach/map.h
> @@ -45,6 +45,7 @@
>  #define EXYNOS5_PA_I2S0                        0x03830000
>  #define EXYNOS5_PA_I2S1                        0x12D60000
>  #define EXYNOS5_PA_I2S2                        0x12D70000
> +#define EXYNOS_PA_AUDSS                        0x03810000
>
>  #define EXYNOS4_PA_PCM0                        0x03840000
>  #define EXYNOS4_PA_PCM1                        0x13980000
> diff --git a/arch/arm/mach-exynos/include/mach/regs-audss.h b/arch/arm/mach-exynos/include/mach/regs-audss.h
> index ca5a8b6..3b23b0d 100644
> --- a/arch/arm/mach-exynos/include/mach/regs-audss.h
> +++ b/arch/arm/mach-exynos/include/mach/regs-audss.h
> @@ -3,7 +3,7 @@
>   * Copyright (c) 2011 Samsung Electronics
>   *             http://www.samsung.com
>   *
> - * Exynos4 Audio SubSystem clock register definitions
> + * Exynos Audio SubSystem clock register definitions
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -15,4 +15,9 @@
>
>  #define EXYNOS4_AUDSS_INT_MEM  (0x03000000)
>
> +#define EXYNOS_AUDSSREG(x)             (S5P_VA_AUDSS + (x))
> +
> +#define EXYNOS_CLKSRC_AUDSS            EXYNOS_AUDSSREG(0x0)
> +#define EXYNOS_CLKDIV_AUDSS            EXYNOS_AUDSSREG(0x4)
> +#define EXYNOS_CLKGATE_AUDSS           EXYNOS_AUDSSREG(0x8)
>  #endif /* _PLAT_REGS_AUDSS_H */
> diff --git a/arch/arm/plat-samsung/include/plat/map-s5p.h b/arch/arm/plat-samsung/include/plat/map-s5p.h
> index c2d7bda..038aa96 100644
> --- a/arch/arm/plat-samsung/include/plat/map-s5p.h
> +++ b/arch/arm/plat-samsung/include/plat/map-s5p.h
> @@ -40,6 +40,8 @@
>  #define S5P_VA_GIC_CPU         S3C_ADDR(0x02810000)
>  #define S5P_VA_GIC_DIST                S3C_ADDR(0x02820000)
>
> +#define S5P_VA_AUDSS           S3C_ADDR(0x02830000)
> +
>  #define VA_VIC(x)              (S3C_VA_IRQ + ((x) * 0x10000))
>  #define VA_VIC0                        VA_VIC(0)
>  #define VA_VIC1                        VA_VIC(1)
> --
> 1.7.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
