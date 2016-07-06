From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 6 Jul 2016 09:39:27 +0200
Subject: [PATCH 2/2] soc: samsung: Add support for Exynos7 PMU
In-Reply-To: <1467750507-13853-3-git-send-email-a.kesavan@samsung.com>
References: <1467750507-13853-1-git-send-email-a.kesavan@samsung.com>
 <1467750507-13853-3-git-send-email-a.kesavan@samsung.com>
Message-ID: <CAJKOXPc=RZEe_zQvnmxXRttppJfGJwyjmkF0XxAnV0YnGxvcyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 5, 2016 at 10:28 PM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
> Add initial PMU settings for exynos7. This is required for
> future suspend-to-ram and cpuidle support.
>
> Signed-off-by: Eunseok Choi <es10.choi@samsung.com>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
>  drivers/soc/samsung/Kconfig                 |   2 +-
>  drivers/soc/samsung/Makefile                |   3 +-
>  drivers/soc/samsung/exynos-pmu.c            |   3 +
>  drivers/soc/samsung/exynos-pmu.h            |   2 +
>  drivers/soc/samsung/exynos7-pmu.c           | 367 ++++++++++++++++++++++++++++
>  include/linux/soc/samsung/exynos-regs-pmu.h | 259 ++++++++++++++++++++
>  6 files changed, 634 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/soc/samsung/exynos7-pmu.c
>
> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
> index 2455339..c57caea 100644
> --- a/drivers/soc/samsung/Kconfig
> +++ b/drivers/soc/samsung/Kconfig
> @@ -8,7 +8,7 @@ if SOC_SAMSUNG
>
>  config EXYNOS_PMU
>         bool "Exynos PMU controller driver" if COMPILE_TEST
> -       depends on (ARM && ARCH_EXYNOS) || ((ARM || ARM64) && COMPILE_TEST)
> +       depends on ARCH_EXYNOS || ((ARM || ARM64) && COMPILE_TEST)
>
>  config EXYNOS_PM_DOMAINS
>         bool "Exynos PM domains" if COMPILE_TEST
> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
> index 3619f2e..5435525 100644
> --- a/drivers/soc/samsung/Makefile
> +++ b/drivers/soc/samsung/Makefile
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_EXYNOS_PMU)       += exynos-pmu.o exynos3250-pmu.o exynos4-pmu.o \
> -                                       exynos5250-pmu.o exynos5420-pmu.o
> +                                       exynos5250-pmu.o exynos5420-pmu.o \
> +                                       exynos7-pmu.o
>  obj-$(CONFIG_EXYNOS_PM_DOMAINS) += pm_domains.o
> diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
> index 0acdfd8..7cda8fb 100644
> --- a/drivers/soc/samsung/exynos-pmu.c
> +++ b/drivers/soc/samsung/exynos-pmu.c
> @@ -88,6 +88,9 @@ static const struct of_device_id exynos_pmu_of_device_ids[] = {
>         }, {
>                 .compatible = "samsung,exynos5420-pmu",
>                 .data = &exynos5420_pmu_data,
> +       }, {
> +               .compatible = "samsung,exynos7-pmu",
> +               .data = &exynos7_pmu_data,

Hi,

Thanks for the patch. Few comments:

You set here compatible for Exynos7. However there are at least three
publicly known Exynos7 chipsets (7420, 7580, 7870 -
https://en.wikipedia.org/wiki/Exynos). My questions are:
1. Are all of these share the same PMU configuration?
2. New different Exynos7 may be released, right?

The exynos7 compatible is already spread all over DTS... but probably
it is safer to use a specific SoC revision. Unless you are sure that
all Exynos7 SoCs will be 100% compatible here and there won't be
another exynos7xxx-pmu.


>         },
>         { /*sentinel*/ },
>  };
> diff --git a/drivers/soc/samsung/exynos-pmu.h b/drivers/soc/samsung/exynos-pmu.h
> index 1bdc506..d559504 100644
> --- a/drivers/soc/samsung/exynos-pmu.h
> +++ b/drivers/soc/samsung/exynos-pmu.h
> @@ -38,7 +38,9 @@ extern const struct exynos_pmu_data exynos4212_pmu_data;
>  extern const struct exynos_pmu_data exynos4412_pmu_data;
>  extern const struct exynos_pmu_data exynos5250_pmu_data;
>  extern const struct exynos_pmu_data exynos5420_pmu_data;
> +extern const struct exynos_pmu_data exynos7_pmu_data;
>
>  extern void pmu_raw_writel(u32 val, u32 offset);
>  extern u32 pmu_raw_readl(u32 offset);
> +extern u32 exynos_get_eint_wake_mask(void);
>  #endif /* __EXYNOS_PMU_H */
> diff --git a/drivers/soc/samsung/exynos7-pmu.c b/drivers/soc/samsung/exynos7-pmu.c
> new file mode 100644
> index 0000000..f8635da
> --- /dev/null
> +++ b/drivers/soc/samsung/exynos7-pmu.c
> @@ -0,0 +1,367 @@
> +/*
> + * Copyright (c) 2016 Samsung Electronics Co., Ltd.
> + *             http://www.samsung.com/
> + *
> + * EXYNOS7 - CPU PMU (Power Management Unit) support
> + * Author: Abhilash Kesavan <a.kesavan@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/of_address.h>
> +#include <linux/soc/samsung/exynos-regs-pmu.h>
> +#include <linux/soc/samsung/exynos-pmu.h>
> +
> +#include "exynos-pmu.h"
> +
> +static const struct exynos_pmu_conf exynos7_pmu_config[] = {
> +       /* { .offset = offset, .val = { AFTR, LPA, SLEEP } } */
> +       { EXYNOS7_ATLAS_CPU0_SYS_PWR_REG,               { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_DIS_IRQ_ATLAS_CPU0_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_DIS_IRQ_ATLAS_CPU0_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_DIS_IRQ_ATLAS_CPU0_CPUSEQ_SYS_PWR_REG, { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_ATLAS_CPU1_SYS_PWR_REG,               { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_DIS_IRQ_ATLAS_CPU1_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_DIS_IRQ_ATLAS_CPU1_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_DIS_IRQ_ATLAS_CPU1_CPUSEQ_SYS_PWR_REG, { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_ATLAS_CPU2_SYS_PWR_REG,               { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_DIS_IRQ_ATLAS_CPU2_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_DIS_IRQ_ATLAS_CPU2_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_DIS_IRQ_ATLAS_CPU2_CPUSEQ_SYS_PWR_REG, { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_ATLAS_CPU3_SYS_PWR_REG,               { 0x0, 0x0, 0x8 } },
> +       { EXYNOS7_DIS_IRQ_ATLAS_CPU3_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_DIS_IRQ_ATLAS_CPU3_CENTRAL_SYS_PWR_REG, { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_DIS_IRQ_ATLAS_CPU3_CPUSEQ_SYS_PWR_REG, { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_ATLAS_NONCPU_SYS_PWR_REG,             { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_ATLAS_DBG_SYS_PWR_REG,                { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_ATLAS_L2_SYS_PWR_REG,                 { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_CLKSTOP_CMU_TOP_SYS_PWR_REG,          { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_CLKRUN_CMU_TOP_SYS_PWR_REG,           { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_CMU_TOP_SYS_PWR_REG,            { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_CPUCLKSTOP_SYS_PWR_REG,         { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_CLKSTOP_CMU_MIF_SYS_PWR_REG,          { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_CLKRUN_CMU_MIF_SYS_PWR_REG,           { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_CMU_MIF_SYS_PWR_REG,            { 0x1, 0x1, 0x0 } },
> +       { EXYNOS7_DDRPHY_DLLLOCK_SYS_PWR_REG,           { 0x1, 0x1, 0x1 } },
> +       { EXYNOS7_DISABLE_PLL_CMU_TOP_SYS_PWR_REG,      { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_DISABLE_PLL_CMU_MIF_SYS_PWR_REG,      { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_TOP_BUS_SYS_PWR_REG,                  { 0x7, 0x0, 0x0 } },
> +       { EXYNOS7_TOP_RETENTION_SYS_PWR_REG,            { 0x1, 0x0, 0x1 } },
> +       { EXYNOS7_TOP_PWR_SYS_PWR_REG,                  { 0x3, 0x0, 0x3 } },
> +       { EXYNOS7_TOP_BUS_MIF_SYS_PWR_REG,              { 0x7, 0x0, 0x0 } },
> +       { EXYNOS7_TOP_RETENTION_MIF_SYS_PWR_REG,        { 0x1, 0x0, 0x1 } },
> +       { EXYNOS7_TOP_PWR_MIF_SYS_PWR_REG,              { 0x3, 0x0, 0x3 } },
> +       { EXYNOS7_RET_OSCCLK_GATE_SYS_PWR_REG,          { 0x1, 0x0, 0x1 } },
> +       { EXYNOS7_LOGIC_RESET_SYS_PWR_REG,              { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_OSCCLK_GATE_SYS_PWR_REG,              { 0x1, 0x0, 0x1 } },
> +       { EXYNOS7_SLEEP_RESET_SYS_PWR_REG,              { 0x1, 0x1, 0x0 } },
> +       { EXYNOS7_LOGIC_RESET_MIF_SYS_PWR_REG,          { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_OSCCLK_GATE_MIF_SYS_PWR_REG,          { 0x1, 0x0, 0x1 } },
> +       { EXYNOS7_SLEEP_RESET_MIF_SYS_PWR_REG,          { 0x1, 0x1, 0x0 } },
> +       { EXYNOS7_RET_OSCCLK_GATE_MIF_SYS_PWR_REG,      { 0x1, 0x0, 0x1 } },
> +       { EXYNOS7_MEMORY_TOP_SYS_PWR_REG,               { 0x3, 0x0, 0x0 } },
> +       { EXYNOS7_MEMORY_TOP_ALV_SYS_PWR_REG,           { 0x3, 0x0, 0x0 } },
> +       { EXYNOS7_PAD_RETENTION_LPDDR4_SYS_PWR_REG,     { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_PAD_RETENTION_AUD_SYS_PWR_REG,        { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_PAD_RETENTION_JTAG_SYS_PWR_REG,       { 0x1, 0x1, 0x0 } },
> +       { EXYNOS7_PAD_RETENTION_MMC2_SYS_PWR_REG,       { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_PAD_RETENTION_TOP_SYS_PWR_REG,        { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_PAD_RETENTION_UART_SYS_PWR_REG,       { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_PAD_RETENTION_MMC0_SYS_PWR_REG,       { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_PAD_RETENTION_MMC1_SYS_PWR_REG,       { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_PAD_RETENTION_EBIA_SYS_PWR_REG,       { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_PAD_RETENTION_EBIB_SYS_PWR_REG,       { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_PAD_RETENTION_SPI_SYS_PWR_REG,        { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_PAD_RETENTION_MIF_SYS_PWR_REG,        { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_PAD_ISOLATION_SYS_PWR_REG,            { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_PAD_RETENTION_LLI_SYS_PWR_REG,        { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_PAD_RETENTION_UFS_SYS_PWR_REG,        { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_PAD_ISOLATION_MIF_SYS_PWR_REG,        { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_PAD_RETENTION_FSYSGENIO_SYS_PWR_REG,  { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_PAD_ALV_SEL_SYS_PWR_REG,              { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_XXTI_SYS_PWR_REG,                     { 0x1, 0x1, 0x0 } },
> +       { EXYNOS7_XXTI26_SYS_PWR_REG,                   { 0x1, 0x1, 0x0 } },
> +       { EXYNOS7_EXT_REGULATOR_SYS_PWR_REG,            { 0x1, 0x1, 0x0 } },
> +       { EXYNOS7_GPIO_MODE_SYS_PWR_REG,                { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_GPIO_MODE_FSYS0_SYS_PWR_REG,          { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_GPIO_MODE_FSYS1_SYS_PWR_REG,          { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_GPIO_MODE_BUS0_SYS_PWR_REG,           { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_GPIO_MODE_MIF_SYS_PWR_REG,            { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_GPIO_MODE_AUD_SYS_PWR_REG,            { 0x1, 0x1, 0x0 } },
> +       { EXYNOS7_ATLAS_SYS_PWR_REG,                    { 0xF, 0xF, 0x0 } },
> +       { EXYNOS7_CLKRUN_CMU_ATLAS_SYS_PWR_REG,         { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_CLKSTOP_CMU_ATLAS_SYS_PWR_REG,        { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_DISABLE_PLL_CMU_ATLAS_SYS_PWR_REG,    { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_LOGIC_ATLAS_SYS_PWR_REG,        { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_MEMORY_ATLAS_SYS_PWR_REG,             { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_CMU_ATLAS_SYS_PWR_REG,          { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_SLEEP_ATLAS_SYS_PWR_REG,        { 0x1, 0x1, 0x0 } },
> +       { EXYNOS7_AUD_SYS_PWR_REG,                      { 0xF, 0x0, 0x0 } },
> +       { EXYNOS7_BUS0_SYS_PWR_REG,                     { 0xF, 0x0, 0x0 } },
> +       { EXYNOS7_CAM0_SYS_PWR_REG,                     { 0xF, 0x0, 0x0 } },
> +       { EXYNOS7_CAM1_SYS_PWR_REG,                     { 0xF, 0x0, 0x0 } },
> +       { EXYNOS7_DISP_SYS_PWR_REG,                     { 0xF, 0x0, 0x0 } },
> +       { EXYNOS7_FSYS0_SYS_PWR_REG,                    { 0xF, 0x0, 0x0 } },
> +       { EXYNOS7_FSYS1_SYS_PWR_REG,                    { 0xF, 0x0, 0x0 } },
> +       { EXYNOS7_G3D_SYS_PWR_REG,                      { 0xF, 0x0, 0x0 } },
> +       { EXYNOS7_ISP0_SYS_PWR_REG,                     { 0xF, 0x0, 0x0 } },
> +       { EXYNOS7_ISP1_SYS_PWR_REG,                     { 0xF, 0x0, 0x0 } },
> +       { EXYNOS7_MFC_SYS_PWR_REG,                      { 0xF, 0x0, 0x0 } },
> +       { EXYNOS7_MSCL_SYS_PWR_REG,                     { 0xF, 0x0, 0x0 } },
> +       { EXYNOS7_VPP_SYS_PWR_REG,                      { 0xF, 0x0, 0x0 } },
> +       { EXYNOS7_CLKRUN_CMU_AUD_SYS_PWR_REG,           { 0x0, 0x1, 0x0 } },
> +       { EXYNOS7_CLKRUN_CMU_BUS0_SYS_PWR_REG,          { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_CLKRUN_CMU_DISP_SYS_PWR_REG,          { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_CLKRUN_CMU_FSYS0_SYS_PWR_REG,         { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_CLKRUN_CMU_FSYS1_SYS_PWR_REG,         { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_CLKRUN_CMU_G3D_SYS_PWR_REG,           { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_CLKRUN_CMU_ISP0_SYS_PWR_REG,          { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_CLKRUN_CMU_ISP1_SYS_PWR_REG,          { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_CLKRUN_CMU_MFC_SYS_PWR_REG,           { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_CLKRUN_CMU_MSCL_SYS_PWR_REG,          { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_CLKRUN_CMU_VPP_SYS_PWR_REG,           { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_CLKSTOP_CMU_AUD_SYS_PWR_REG,          { 0x0, 0x1, 0x0 } },
> +       { EXYNOS7_CLKSTOP_CMU_BUS0_SYS_PWR_REG,         { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_CLKSTOP_CMU_DISP_SYS_PWR_REG,         { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_CLKSTOP_CMU_FSYS0_SYS_PWR_REG,        { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_CLKSTOP_CMU_FSYS1_SYS_PWR_REG,        { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_CLKSTOP_CMU_G3D_SYS_PWR_REG,          { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_CLKSTOP_CMU_ISP0_SYS_PWR_REG,         { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_CLKSTOP_CMU_ISP1_SYS_PWR_REG,         { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_CLKSTOP_CMU_MFC_SYS_PWR_REG,          { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_CLKSTOP_CMU_MSCL_SYS_PWR_REG,         { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_CLKSTOP_CMU_VPP_SYS_PWR_REG,          { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_DISABLE_PLL_CMU_AUD_SYS_PWR_REG,      { 0x1, 0x1, 0x0 } },
> +       { EXYNOS7_DISABLE_PLL_CMU_BUS0_SYS_PWR_REG,     { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_DISABLE_PLL_CMU_DISP_SYS_PWR_REG,     { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_DISABLE_PLL_CMU_FSYS0_SYS_PWR_REG,    { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_DISABLE_PLL_CMU_FSYS1_SYS_PWR_REG,    { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_DISABLE_PLL_CMU_G3D_SYS_PWR_REG,      { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_DISABLE_PLL_CMU_ISP0_SYS_PWR_REG,     { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_DISABLE_PLL_CMU_ISP1_SYS_PWR_REG,     { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_DISABLE_PLL_CMU_MFC_SYS_PWR_REG,      { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_DISABLE_PLL_CMU_MSCL_SYS_PWR_REG,     { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_DISABLE_PLL_CMU_VPP_SYS_PWR_REG,      { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_LOGIC_AUD_SYS_PWR_REG,          { 0x0, 0x1, 0x0 } },
> +       { EXYNOS7_RESET_LOGIC_BUS0_SYS_PWR_REG,         { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_LOGIC_DISP_SYS_PWR_REG,         { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_LOGIC_FSYS0_SYS_PWR_REG,        { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_LOGIC_FSYS1_SYS_PWR_REG,        { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_LOGIC_G3D_SYS_PWR_REG,          { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_LOGIC_ISP0_SYS_PWR_REG,         { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_LOGIC_ISP1_SYS_PWR_REG,         { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_LOGIC_MFC_SYS_PWR_REG,          { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_LOGIC_MSCL_SYS_PWR_REG,         { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_LOGIC_VPP_SYS_PWR_REG,          { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_MEMORY_AUD_SYS_PWR_REG,               { 0x0, 0x3, 0x0 } },
> +       { EXYNOS7_MEMORY_DISP_SYS_PWR_REG,              { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_MEMORY_FSYS0_SYS_PWR_REG,             { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_MEMORY_FSYS1_SYS_PWR_REG,             { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_MEMORY_G3D_SYS_PWR_REG,               { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_MEMORY_ISP0_SYS_PWR_REG,              { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_MEMORY_ISP1_SYS_PWR_REG,              { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_MEMORY_MFC_SYS_PWR_REG,               { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_MEMORY_MSCL_SYS_PWR_REG,              { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_MEMORY_VPP_SYS_PWR_REG,               { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_CMU_AUD_SYS_PWR_REG,            { 0x0, 0x1, 0x0 } },
> +       { EXYNOS7_RESET_CMU_BUS0_SYS_PWR_REG,           { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_CMU_DISP_SYS_PWR_REG,           { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_CMU_FSYS0_SYS_PWR_REG,          { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_CMU_FSYS1_SYS_PWR_REG,          { 0x1, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_CMU_G3D_SYS_PWR_REG,            { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_CMU_ISP0_SYS_PWR_REG,           { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_CMU_ISP1_SYS_PWR_REG,           { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_CMU_MFC_SYS_PWR_REG,            { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_CMU_MSCL_SYS_PWR_REG,           { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_CMU_VPP_SYS_PWR_REG,            { 0x0, 0x0, 0x0 } },
> +       { EXYNOS7_RESET_SLEEP_BUS0_SYS_PWR_REG,         { 0x1, 0x1, 0x0 } },
> +       { EXYNOS7_RESET_SLEEP_FSYS0_SYS_PWR_REG,        { 0x1, 0x1, 0x0 } },
> +       { EXYNOS7_RESET_SLEEP_FSYS1_SYS_PWR_REG,        { 0x1, 0x1, 0x0 } },
> +       { PMU_TABLE_END, },
> +};
> +
> +/* PMU configurations (provided by hardware team) that are not part of the UM */
> +static const struct exynos_pmu_conf exynos7_pmu_config_extra[] = {
> +       /* { .offset = offset, .val = { AFTR, LPA, SLEEP } } */
> +       { EXYNOS7_PMU_SYNC_CTRL,        { 0x0,      0x0,        0x0        } },
> +       { EXYNOS7_CENTRAL_SEQ_MIF_OPTION, { 0x1000, 0x1000,     0x0        } },
> +       { EXYNOS7_WAKEUP_MASK_MIF,      { 0x100013, 0x100013,   0x0        } },
> +       { EXYNOS7_ATLAS_NONCPU_OPTION,  { 0x11,     0x11,       0x11       } },
> +       { EXYNOS7_MEMORY_TOP_OPTION,    { 0x11,     0x11,       0x1        } },
> +       { EXYNOS7_MEMORY_TOP_ALV_OPTION, { 0x11,    0x11,       0x11       } },
> +       { EXYNOS7_RESET_CMU_TOP_OPTION, { 0x0,      0x80000000, 0x0        } },
> +       { EXYNOS7_ATLAS_OPTION,         { 0x101,    0x101,      0x80001101 } },
> +       { EXYNOS7_BUS0_OPTION,          { 0x101,    0x101,      0x1101     } },
> +       { EXYNOS7_FSYS0_OPTION,         { 0x101,    0x101,      0x1101     } },
> +       { EXYNOS7_FSYS1_OPTION,         { 0x101,    0x101,      0x1101     } },
> +       { EXYNOS7_AUD_OPTION,           { 0x101,    0xC0000101, 0x101      } },
> +       { EXYNOS7_G3D_OPTION,           { 0x181,    0x181,      0x181      } },
> +       { EXYNOS7_SLEEP_RESET_OPTION,   { 0x100000, 0x100000,   0x100000   } },
> +       { EXYNOS7_TOP_PWR_OPTION,       { 0x1,      0x80800002, 0x1        } },
> +       { EXYNOS7_TOP_PWR_MIF_OPTION,   { 0x1,      0x1,        0x1        } },
> +       { EXYNOS7_LOGIC_RESET_OPTION,   { 0x0,      0x80000000, 0x0        } },
> +       { EXYNOS7_TOP_RETENTION_OPTION, { 0x0,      0x80000000, 0x0        } },
> +       { PMU_TABLE_END, },
> +};
> +
> +static unsigned int const exynos7_list_feed[] = {
> +       EXYNOS7_ATLAS_NONCPU_OPTION,
> +       EXYNOS7_TOP_PWR_OPTION,
> +       EXYNOS7_TOP_PWR_MIF_OPTION,
> +       EXYNOS7_AUD_OPTION,
> +       EXYNOS7_CAM0_OPTION,
> +       EXYNOS7_DISP_OPTION,
> +       EXYNOS7_G3D_OPTION,
> +       EXYNOS7_MSCL_OPTION,
> +       EXYNOS7_MFC_OPTION,
> +       EXYNOS7_BUS0_OPTION,
> +       EXYNOS7_FSYS0_OPTION,
> +       EXYNOS7_FSYS1_OPTION,
> +       EXYNOS7_ISP0_OPTION,
> +       EXYNOS7_ISP1_OPTION,
> +       EXYNOS7_VPP_OPTION,
> +};
> +
> +static void exynos7_set_wakeupmask(enum sys_powerdown mode)
> +{
> +       u32 intmask = 0;
> +
> +       pmu_raw_writel(exynos_get_eint_wake_mask(), EXYNOS7_EINT_WAKEUP_MASK);
> +
> +       switch (mode) {
> +       case SYS_SLEEP:
> +               /* BIT(31): deactivate wakeup event monitoring circuit */
> +               intmask = 0x7FFFFFFF;
> +               break;
> +       default:
> +               break;
> +       }
> +       pmu_raw_writel(intmask, EXYNOS7_WAKEUP_MASK);
> +       pmu_raw_writel(0xFFFF0000, EXYNOS7_WAKEUP_MASK2);
> +       pmu_raw_writel(0xFFFF0000, EXYNOS7_WAKEUP_MASK3);
> +}
> +
> +static void exynos7_pmu_central_seq(bool enable)
> +{
> +       unsigned int tmp;
> +
> +       /* central sequencer */
> +       tmp = pmu_raw_readl(EXYNOS7_CENTRAL_SEQ_CONFIGURATION);
> +       if (enable)
> +               tmp &= ~EXYNOS7_CENTRALSEQ_PWR_CFG;
> +       else
> +               tmp |= EXYNOS7_CENTRALSEQ_PWR_CFG;
> +       pmu_raw_writel(tmp, EXYNOS7_CENTRAL_SEQ_CONFIGURATION);
> +
> +       /* central sequencer MIF */
> +       tmp = pmu_raw_readl(EXYNOS7_CENTRAL_SEQ_MIF_CONFIGURATION);
> +       if (enable)
> +               tmp &= ~EXYNOS7_CENTRALSEQ_PWR_CFG;
> +       else
> +               tmp |= EXYNOS7_CENTRALSEQ_PWR_CFG;
> +       pmu_raw_writel(tmp, EXYNOS7_CENTRAL_SEQ_MIF_CONFIGURATION);
> +}
> +
> +static void exynos7_powerdown_conf(enum sys_powerdown mode)
> +{
> +       exynos7_set_wakeupmask(mode);
> +       exynos7_pmu_central_seq(true);
> +       if (!(pmu_raw_readl(EXYNOS7_PMU_DEBUG) &
> +                               EXYNOS7_CLKOUT_DISABLE))
> +               pmu_raw_writel(0x1, EXYNOS7_XXTI_SYS_PWR_REG);
> +}
> +
> +static void exynos7_pmu_init(void)
> +{
> +       unsigned int cpu;
> +       unsigned int tmp, i;
> +       struct device_node *node;
> +       static void __iomem *atlas_cmu_base;

1. Why static?
2. This looks like used only in if() block below. Move it there so it
will stay local to that block.

> +
> +        /* Enable only SC_FEEDBACK for the register list */
> +       for (i = 0 ; i < ARRAY_SIZE(exynos7_list_feed) ; i++) {
> +               tmp = pmu_raw_readl(exynos7_list_feed[i]);
> +               tmp &= ~EXYNOS5_USE_SC_COUNTER;
> +               tmp |= EXYNOS5_USE_SC_FEEDBACK;
> +               pmu_raw_writel(tmp, exynos7_list_feed[i]);
> +       }
> +
> +       /*
> +        * Disable automatic L2 flush, Disable L2 retention and
> +        * Enable STANDBYWFIL2, ACE/ACP
> +        */
> +       tmp = pmu_raw_readl(EXYNOS7_ATLAS_L2_OPTION);
> +       tmp &= ~(EXYNOS7_USE_AUTO_L2FLUSHREQ | EXYNOS7_USE_RETENTION);
> +       tmp |= (EXYNOS7_USE_STANDBYWFIL2 |
> +               EXYNOS7_USE_DEACTIVATE_ACE |
> +               EXYNOS7_USE_DEACTIVATE_ACP);
> +       pmu_raw_writel(tmp, EXYNOS7_ATLAS_L2_OPTION);
> +
> +       /*
> +        * Enable both SC_COUNTER and SC_FEEDBACK for the CPUs
> +        * Use STANDBYWFI and SMPEN to indicate that core is ready to enter
> +        * low power mode
> +        */
> +       for (cpu = 0; cpu < 4; cpu++) {

'4' shouldn't be hardcoded here. num_possible_cpus()?

> +               tmp = pmu_raw_readl(EXYNOS7_CPU_OPTION(cpu));
> +               tmp |= (EXYNOS5_USE_SC_FEEDBACK | EXYNOS5_USE_SC_COUNTER);
> +               tmp |= EXYNOS7_USE_SMPEN;
> +               tmp |= EXYNOS7_USE_STANDBYWFI;
> +               tmp &= ~EXYNOS7_USE_STANDBYWFE;
> +               pmu_raw_writel(tmp, EXYNOS7_CPU_OPTION(cpu));
> +
> +               tmp = pmu_raw_readl(EXYNOS7_CPU_DURATION(cpu));
> +               tmp |= EXYNOS7_DUR_WAIT_RESET;
> +               tmp &= ~EXYNOS7_DUR_SCALL;
> +               tmp |= EXYNOS7_DUR_SCALL_VALUE;
> +               pmu_raw_writel(tmp, EXYNOS7_CPU_DURATION(cpu));
> +       }
> +
> +       /* Skip atlas block power-off during automatic power down sequence */
> +       tmp = pmu_raw_readl(EXYNOS7_ATLAS_CPUSEQUENCER_OPTION);
> +       tmp |= EXYNOS7_SKIP_BLK_PWR_DOWN;
> +       pmu_raw_writel(tmp, EXYNOS7_ATLAS_CPUSEQUENCER_OPTION);
> +
> +       /* Limit in-rush current during local power up of cores */
> +       tmp = pmu_raw_readl(EXYNOS7_UP_SCHEDULER);
> +       tmp |= EXYNOS7_ENABLE_ATLAS_CPU;
> +       pmu_raw_writel(tmp, EXYNOS7_UP_SCHEDULER);
> +
> +       /* Enable PS hold and hardware tripping */
> +       tmp = pmu_raw_readl(EXYNOS7_PS_HOLD_CONTROL);
> +       tmp |= EXYNOS7_PS_HOLD_OUTPUT;
> +       tmp |= EXYNOS7_ENABLE_HW_TRIP;
> +       pmu_raw_writel(tmp, EXYNOS7_PS_HOLD_CONTROL);
> +
> +       /* Enable debug area of atlas cpu */
> +       tmp = pmu_raw_readl(EXYNOS7_ATLAS_DBG_CONFIGURATION);
> +       tmp |= EXYNOS7_DBG_INITIATE_WAKEUP;
> +       pmu_raw_writel(tmp, EXYNOS7_ATLAS_DBG_CONFIGURATION);
> +
> +       /*
> +        * Set clock freeze cycle count to 0 before and after arm clamp or
> +        * reset signal transition
> +        */
> +       node = of_find_compatible_node(NULL, NULL,
> +                               "samsung,exynos7-clock-atlas");
> +       if (node) {
> +               atlas_cmu_base = of_iomap(node, 0);
> +               if (!atlas_cmu_base)
> +                       return;
> +
> +               __raw_writel(0x0,
> +                               atlas_cmu_base + EXYNOS7_CORE_ARMCLK_STOPCTRL);
> +               iounmap(atlas_cmu_base);

Missing:
of_node_put(node);

...but I think this creates unnecessary dependency on different
compatible. I understand that disabling the EXTENDED_CLKSTOP is needed
after configuring the PMU so this code belongs here. However
everything you need is just a mapping of CMU address. The PMU driver
should receive in bindings everything it needs to do its work. Either
it is a phandle to something or an address for iomap. In this case the
PMU should probably get two addresses: PMU and optionally CMU (part of
CMU for example). Of course bindings would have to be updated.

> +       }
> +
> +       pr_info("Exynos7 PMU has been initialized\n");
> +}
> +
> +const struct exynos_pmu_data exynos7_pmu_data = {
> +       .pmu_config             = exynos7_pmu_config,
> +       .pmu_init               = exynos7_pmu_init,
> +       .pmu_config_extra       = exynos7_pmu_config_extra,
> +       .powerdown_conf         = exynos7_powerdown_conf,
> +};
> diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
> index d30186e..2de1d94 100644
> --- a/include/linux/soc/samsung/exynos-regs-pmu.h
> +++ b/include/linux/soc/samsung/exynos-regs-pmu.h

(...)

> +/* EXYNOS7_PMU_DEBUG */
> +#define EXYNOS7_CLKOUT_DISABLE                                 (0x1 << 0)
> +
> +#define EXYNOS7_USE_SMPEN                                      (0x1 << 28)
> +#define EXYNOS7_USE_STANDBYWFE                                 (0x1 << 24)
> +#define EXYNOS7_USE_STANDBYWFI                                 (0x1 << 16)
> +#define EXYNOS7_USE_SC_FEEDBACK                                        (0x1 << 1)
> +#define EXYNOS7_USE_SC_COUNTER                                 (0x1 << 0)
> +
> +/* EXYNOS7_PAD_RETENTION_AUD_OPTION */
> +#define PAD_INITIATE_WAKEUP                                    (0x1 << 28)
> +
> +#define EXYNOS7_DUR_WAIT_RESET                                 (0xF << 20)
> +#define EXYNOS7_DUR_SCALL                                      (0xF << 4)
> +#define EXYNOS7_DUR_SCALL_VALUE                                        (0x1 << 4)
> +
> +#define EXYNOS7_SKIP_BLK_PWR_DOWN                              (0x1 << 8)
> +#define EXYNOS7_ENABLE_ATLAS_CPU                               (0x1 << 0)
> +
> +#define EXYNOS7_PS_HOLD_OUTPUT                                 (0x1 << 8)
> +#define EXYNOS7_ENABLE_HW_TRIP                                 (0x1 << 31)
> +#define EXYNOS7_DBG_INITIATE_WAKEUP                            (0x3 << 16)
> +
> +#define EXYNOS7_CORE_ARMCLK_STOPCTRL                           (0x1000)
Please add comment that this is from different block (CMU).
> +
>  #endif /* __LINUX_SOC_EXYNOS_REGS_PMU_H */
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
