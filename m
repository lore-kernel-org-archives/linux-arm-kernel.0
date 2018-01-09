From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 9 Jan 2018 13:23:56 +0100
Subject: [PATCH 3/9] soc: samsung: pmu: Add the PMU data of exynos5433 to
 support low-power state
In-Reply-To: <1515484746-10656-4-git-send-email-cw00.choi@samsung.com>
References: <CGME20180109075905epcas1p321b8898a0d45287d63364e1aa768fdab@epcas1p3.samsung.com>
 <1515484746-10656-1-git-send-email-cw00.choi@samsung.com>
 <1515484746-10656-4-git-send-email-cw00.choi@samsung.com>
Message-ID: <CAJKOXPf027Nz4CsNt4i1yuiQVMtZpv8ncrbgP1D-y4YM8kn30A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 9, 2018 at 8:59 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patch adds the PMU (Power Management Unit) data of exynos5433 SoC
> in order to support the various power modes. Each power mode has
> the different value for reducing the power-consumption.
>
> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm/mach-exynos/common.h               |   2 -
>  drivers/soc/samsung/Makefile                |   3 +-
>  drivers/soc/samsung/exynos-pmu.c            |   1 +
>  drivers/soc/samsung/exynos-pmu.h            |   2 +
>  drivers/soc/samsung/exynos5433-pmu.c        | 286 ++++++++++++++++++++++++++++
>  include/linux/soc/samsung/exynos-regs-pmu.h | 148 ++++++++++++++
>  6 files changed, 439 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/soc/samsung/exynos5433-pmu.c
>
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index 098f84a149a3..afbc143a3d5d 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -125,8 +125,6 @@ enum {
>  void exynos_set_boot_flag(unsigned int cpu, unsigned int mode);
>  void exynos_clear_boot_flag(unsigned int cpu, unsigned int mode);
>
> -extern u32 exynos_get_eint_wake_mask(void);
> -

This does not look good. Does it compile without warnings on ARMv7 platforms?

>  #ifdef CONFIG_PM_SLEEP
>  extern void __init exynos_pm_init(void);
>  #else
> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
> index 29f294baac6e..d2e637339a45 100644
> --- a/drivers/soc/samsung/Makefile
> +++ b/drivers/soc/samsung/Makefile
> @@ -2,5 +2,6 @@
>  obj-$(CONFIG_EXYNOS_PMU)       += exynos-pmu.o
>
>  obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)   += exynos3250-pmu.o exynos4-pmu.o \
> -                                       exynos5250-pmu.o exynos5420-pmu.o
> +                                       exynos5250-pmu.o exynos5420-pmu.o \
> +                                       exynos5433-pmu.o
>  obj-$(CONFIG_EXYNOS_PM_DOMAINS) += pm_domains.o
> diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
> index cfc9de518344..7112d7b2749b 100644
> --- a/drivers/soc/samsung/exynos-pmu.c
> +++ b/drivers/soc/samsung/exynos-pmu.c
> @@ -97,6 +97,7 @@ void exynos_sys_powerup_conf(enum sys_powerdown mode)
>                 .data = exynos_pmu_data_arm_ptr(exynos5420_pmu_data),
>         }, {
>                 .compatible = "samsung,exynos5433-pmu",
> +               .data = exynos_pmu_data_arm_ptr(exynos5433_pmu_data),
>         },
>         { /*sentinel*/ },
>  };
> diff --git a/drivers/soc/samsung/exynos-pmu.h b/drivers/soc/samsung/exynos-pmu.h
> index efbaf8929252..895c786a2f4c 100644
> --- a/drivers/soc/samsung/exynos-pmu.h
> +++ b/drivers/soc/samsung/exynos-pmu.h
> @@ -28,6 +28,7 @@ struct exynos_pmu_data {
>  };
>
>  extern void __iomem *pmu_base_addr;
> +extern u32 exynos_get_eint_wake_mask(void);
>
>  #ifdef CONFIG_EXYNOS_PMU_ARM_DRIVERS
>  /* list of all exported SoC specific data */
> @@ -36,6 +37,7 @@ struct exynos_pmu_data {
>  extern const struct exynos_pmu_data exynos4412_pmu_data;
>  extern const struct exynos_pmu_data exynos5250_pmu_data;
>  extern const struct exynos_pmu_data exynos5420_pmu_data;
> +extern const struct exynos_pmu_data exynos5433_pmu_data;
>  #endif
>
>  extern void pmu_raw_writel(u32 val, u32 offset);
> diff --git a/drivers/soc/samsung/exynos5433-pmu.c b/drivers/soc/samsung/exynos5433-pmu.c
> new file mode 100644
> index 000000000000..2571e61522f0
> --- /dev/null
> +++ b/drivers/soc/samsung/exynos5433-pmu.c
> @@ -0,0 +1,286 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2018 Samsung Electronics Co., Ltd.
> +// Copyright (c) Jonghwa Lee <jonghwa3.lee@samsung.com>
> +// Copyright (c) Chanwoo Choi <cw00.choi@samsung.com>

Did you want to add here authorship notice or personal copyrights?

> +//
> +// EXYNOS5433 - CPU PMU (Power Management Unit) support
> +
> +#include <linux/soc/samsung/exynos-regs-pmu.h>
> +#include <linux/soc/samsung/exynos-pmu.h>
> +
> +#include "exynos-pmu.h"
> +
> +static struct exynos_pmu_conf exynos5433_pmu_config[] = {

This should be also const.

> +       /* { .offset = address, .val = { AFTR, LPA, SLEEP } } */
> +       { EXYNOS5433_ATLAS_CPU0_SYS_PWR_REG,                    { 0x0, 0x0, 0x8 } },
> +       { EXYNOS5433_DIS_IRQ_ATLAS_CPU0_CENTRAL_SYS_PWR_REG,    { 0x0, 0x0, 0x0 } },
> +       { EXYNOS5433_ATLAS_CPU1_SYS_PWR_REG,                    { 0x0, 0x0, 0x8 } },
> +       { EXYNOS5433_DIS_IRQ_ATLAS_CPU1_CENTRAL_SYS_PWR_REG,    { 0x0, 0x0, 0x0 } },
> +       { EXYNOS5433_ATLAS_CPU2_SYS_PWR_REG,                    { 0x0, 0x0, 0x8 } },
> +       { EXYNOS5433_DIS_IRQ_ATLAS_CPU2_CENTRAL_SYS_PWR_REG,    { 0x0, 0x0, 0x0 } },
> +       { EXYNOS5433_ATLAS_CPU3_SYS_PWR_REG,                    { 0x0, 0x0, 0x8 } },
> +       { EXYNOS5433_DIS_IRQ_ATLAS_CPU3_CENTRAL_SYS_PWR_REG,    { 0x0, 0x0, 0x0 } },
> +       { EXYNOS5433_APOLLO_CPU0_SYS_PWR_REG,                   { 0x0, 0x0, 0x8 } },
> +       { EXYNOS5433_DIS_IRQ_APOLLO_CPU0_CENTRAL_SYS_PWR_REG,   { 0x0, 0x0, 0x0 } },
> +       { EXYNOS5433_APOLLO_CPU1_SYS_PWR_REG,                   { 0x0, 0x0, 0x8 } },
> +       { EXYNOS5433_DIS_IRQ_APOLLO_CPU1_CENTRAL_SYS_PWR_REG,   { 0x0, 0x0, 0x0 } },
> +       { EXYNOS5433_APOLLO_CPU2_SYS_PWR_REG,                   { 0x0, 0x0, 0x8 } },
> +       { EXYNOS5433_DIS_IRQ_APOLLO_CPU2_CENTRAL_SYS_PWR_REG,   { 0x0, 0x0, 0x0 } },
> +       { EXYNOS5433_APOLLO_CPU3_SYS_PWR_REG,                   { 0x0, 0x0, 0x8 } },
> +       { EXYNOS5433_DIS_IRQ_APOLLO_CPU3_CENTRAL_SYS_PWR_REG,   { 0x0, 0x0, 0x0 } },
> +       { EXYNOS5433_ATLAS_NONCPU_SYS_PWR_REG,                  { 0x0, 0x0, 0x8 } },
> +       { EXYNOS5433_APOLLO_NONCPU_SYS_PWR_REG,                 { 0x0, 0x0, 0x8 } },
> +       { EXYNOS5433_A5IS_SYS_PWR_REG,                          { 0x0, 0x0, 0x0 } },
> +       { EXYNOS5433_DIS_IRQ_A5IS_LOCAL_SYS_PWR_REG,            { 0x0, 0x0, 0x0 } },
> +       { EXYNOS5433_DIS_IRQ_A5IS_CENTRAL_SYS_PWR_REG,          { 0x0, 0x0, 0x0 } },
> +       { EXYNOS5433_ATLAS_L2_SYS_PWR_REG,                      { 0x0, 0x0, 0x7 } },
> +       { EXYNOS5433_APOLLO_L2_SYS_PWR_REG,                     { 0x0, 0x0, 0x7 } },
> +       { EXYNOS5433_CLKSTOP_CMU_TOP_SYS_PWR_REG,               { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_CLKRUN_CMU_TOP_SYS_PWR_REG,                { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_RESET_CMU_TOP_SYS_PWR_REG,                 { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_RESET_CPUCLKSTOP_SYS_PWR_REG,              { 0x1, 0x1, 0x0 } },
> +       { EXYNOS5433_CLKSTOP_CMU_MIF_SYS_PWR_REG,               { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_CLKRUN_CMU_MIF_SYS_PWR_REG,                { 0x1, 0x1, 0x0 } },
> +       { EXYNOS5433_RESET_CMU_MIF_SYS_PWR_REG,                 { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_DDRPHY_DLLLOCK_SYS_PWR_REG,                { 0x1, 0x1, 0x1 } },
> +       { EXYNOS5433_DISABLE_PLL_CMU_TOP_SYS_PWR_REG,           { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_DISABLE_PLL_AUD_PLL_SYS_PWR_REG,           { 0x1, 0x1, 0x0 } },
> +       { EXYNOS5433_DISABLE_PLL_CMU_MIF_SYS_PWR_REG,           { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_TOP_BUS_SYS_PWR_REG,                       { 0x7, 0x0, 0x0 } },
> +       { EXYNOS5433_TOP_RETENTION_SYS_PWR_REG,                 { 0x1, 0x0, 0x1 } },
> +       { EXYNOS5433_TOP_PWR_SYS_PWR_REG,                       { 0x3, 0x0, 0x3 } },
> +       { EXYNOS5433_TOP_BUS_MIF_SYS_PWR_REG,                   { 0x7, 0x0, 0x0 } },
> +       { EXYNOS5433_TOP_RETENTION_MIF_SYS_PWR_REG,             { 0x1, 0x0, 0x1 } },
> +       { EXYNOS5433_TOP_PWR_MIF_SYS_PWR_REG,                   { 0x3, 0x0, 0x3 } },
> +       { EXYNOS5433_LOGIC_RESET_SYS_PWR_REG,                   { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_OSCCLK_GATE_SYS_PWR_REG,                   { 0x1, 0x0, 0x1 } },
> +       { EXYNOS5433_SLEEP_RESET_SYS_PWR_REG,                   { 0x1, 0x1, 0x0 } },
> +       { EXYNOS5433_LOGIC_RESET_MIF_SYS_PWR_REG,               { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_OSCCLK_GATE_MIF_SYS_PWR_REG,               { 0x1, 0x0, 0x1 } },
> +       { EXYNOS5433_SLEEP_RESET_MIF_SYS_PWR_REG,               { 0x1, 0x1, 0x0 } },
> +       { EXYNOS5433_MEMORY_TOP_SYS_PWR_REG,                    { 0x3, 0x0, 0x0 } },
> +       { EXYNOS5433_PAD_RETENTION_LPDDR3_SYS_PWR_REG,          { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_PAD_RETENTION_JTAG_SYS_PWR_REG,            { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_PAD_RETENTION_TOP_SYS_PWR_REG,             { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_PAD_RETENTION_UART_SYS_PWR_REG,            { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_PAD_RETENTION_EBIA_SYS_PWR_REG,            { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_PAD_RETENTION_EBIB_SYS_PWR_REG,            { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_PAD_RETENTION_SPI_SYS_PWR_REG,             { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_PAD_RETENTION_MIF_SYS_PWR_REG,             { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_PAD_ISOLATION_SYS_PWR_REG,                 { 0x1, 0x0, 0x1 } },
> +       { EXYNOS5433_PAD_RETENTION_USBXTI_SYS_PWR_REG,          { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_PAD_RETENTION_BOOTLDO_SYS_PWR_REG,         { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_PAD_ISOLATION_MIF_SYS_PWR_REG,             { 0x1, 0x0, 0x1 } },
> +       { EXYNOS5433_PAD_RETENTION_FSYSGENIO_SYS_PWR_REG,       { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_PAD_ALV_SEL_SYS_PWR_REG,                   { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_XXTI_SYS_PWR_REG,                          { 0x1, 0x1, 0x0 } },
> +       { EXYNOS5433_XXTI26_SYS_PWR_REG,                        { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_EXT_REGULATOR_SYS_PWR_REG,                 { 0x1, 0x1, 0x0 } },
> +       { EXYNOS5433_GPIO_MODE_SYS_PWR_REG,                     { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_GPIO_MODE_FSYS0_SYS_PWR_REG,               { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_GPIO_MODE_MIF_SYS_PWR_REG,                 { 0x1, 0x0, 0x0 } },
> +       { EXYNOS5433_GPIO_MODE_AUD_SYS_PWR_REG,                 { 0x1, 0x1, 0x0 } },
> +       { EXYNOS5433_GSCL_SYS_PWR_REG,                          { 0xF, 0x0, 0x0 } },
> +       { EXYNOS5433_CAM0_SYS_PWR_REG,                          { 0xF, 0x0, 0x0 } },
> +       { EXYNOS5433_MSCL_SYS_PWR_REG,                          { 0xF, 0x0, 0x0 } },
> +       { EXYNOS5433_G3D_SYS_PWR_REG,                           { 0xF, 0x0, 0x0 } },
> +       { EXYNOS5433_DISP_SYS_PWR_REG,                          { 0xF, 0x0, 0x0 } },
> +       { EXYNOS5433_CAM1_SYS_PWR_REG,                          { 0xF, 0x0, 0x0 } },
> +       { EXYNOS5433_AUD_SYS_PWR_REG,                           { 0xF, 0xF, 0x0 } },
> +       { EXYNOS5433_FSYS_SYS_PWR_REG,                          { 0xF, 0x0, 0x0 } },
> +       { EXYNOS5433_BUS2_SYS_PWR_REG,                          { 0xF, 0x0, 0x0 } },
> +       { EXYNOS5433_G2D_SYS_PWR_REG,                           { 0xF, 0x0, 0x0 } },
> +       { EXYNOS5433_ISP0_SYS_PWR_REG,                          { 0xF, 0x0, 0x0 } },
> +       { EXYNOS5433_MFC_SYS_PWR_REG,                           { 0xF, 0x0, 0x0 } },
> +       { EXYNOS5433_HEVC_SYS_PWR_REG,                          { 0xF, 0x0, 0x0 } },
> +       { EXYNOS5433_RESET_SLEEP_FSYS_SYS_PWR_REG,              { 0x1, 0x1, 0x0 } },
> +       { EXYNOS5433_RESET_SLEEP_BUS2_SYS_PWR_REG,              { 0x1, 0x1, 0x0 } },
> +       { PMU_TABLE_END, },
> +};
> +
> +static unsigned int const exynos5433_list_feed[] = {
> +       EXYNOS5433_ATLAS_NONCPU_OPTION,
> +       EXYNOS5433_APOLLO_NONCPU_OPTION,
> +       EXYNOS5433_TOP_PWR_OPTION,
> +       EXYNOS5433_TOP_PWR_MIF_OPTION,
> +       EXYNOS5433_AUD_OPTION,
> +       EXYNOS5433_CAM0_OPTION,
> +       EXYNOS5433_DISP_OPTION,
> +       EXYNOS5433_G2D_OPTION,
> +       EXYNOS5433_G3D_OPTION,
> +       EXYNOS5433_HEVC_OPTION,
> +       EXYNOS5433_MSCL_OPTION,
> +       EXYNOS5433_MFC_OPTION,
> +       EXYNOS5433_GSCL_OPTION,
> +       EXYNOS5433_FSYS_OPTION,
> +       EXYNOS5433_ISP_OPTION,
> +       EXYNOS5433_BUS2_OPTION,
> +};
> +
> +static unsigned int const exynos5433_list_pad_retention[] = {
> +       EXYNOS5433_PAD_RETENTION_LPDDR3_OPTION,
> +       EXYNOS5433_PAD_RETENTION_AUD_OPTION,
> +       EXYNOS5433_PAD_RETENTION_MMC2_OPTION,
> +       EXYNOS5433_PAD_RETENTION_TOP_OPTION,
> +       EXYNOS5433_PAD_RETENTION_UART_OPTION,
> +       EXYNOS5433_PAD_RETENTION_MMC0_OPTION,
> +       EXYNOS5433_PAD_RETENTION_MMC1_OPTION,
> +       EXYNOS5433_PAD_RETENTION_EBIA_OPTION,
> +       EXYNOS5433_PAD_RETENTION_EBIB_OPTION,
> +       EXYNOS5433_PAD_RETENTION_SPI_OPTION,
> +       EXYNOS5433_PAD_RETENTION_MIF_OPTION,
> +       EXYNOS5433_PAD_RETENTION_USBXTI_OPTION,
> +       EXYNOS5433_PAD_RETENTION_BOOTLDO_OPTION,
> +       EXYNOS5433_PAD_RETENTION_UFS_OPTION,
> +       EXYNOS5433_PAD_RETENTION_FSYSGENIO_OPTION,

Looks like conflicting with existing
drivers/pinctrl/samsung/pinctrl-exynos-arm64.c... and probably this
should be part of pinctrl driver's suspend/resume paths.

> +};
> +
> +static void exynos5433_set_wakeupmask(enum sys_powerdown mode)
> +{
> +       u32 intmask = 0;
> +
> +       pmu_raw_writel(exynos_get_eint_wake_mask(),
> +                                       EXYNOS5433_EINT_WAKEUP_MASK);
> +
> +       /* Disable WAKEUP event monitor */
> +       intmask = pmu_raw_readl(EXYNOS5433_WAKEUP_MASK);
> +       intmask &= ~(1 << 31);

This should have a define. Maybe it is an already defined field like
S5P_CORE_AUTOWAKEUP_EN or S5P_PS_HOLD_EN?

> +       pmu_raw_writel(intmask, EXYNOS5433_WAKEUP_MASK);
> +
> +       pmu_raw_writel(0xFFFF0000, EXYNOS5433_WAKEUP_MASK2);
> +       pmu_raw_writel(0xFFFF0000, EXYNOS5433_WAKEUP_MASK3);

Both need explaining what you are masking, preferably by appropriate
comment and maybe also define for raw constants.

> +}
> +
> +static void exynos5433_pmu_central_seq(bool enable)
> +{
> +       unsigned int tmp;
> +
> +       tmp = pmu_raw_readl(EXYNOS5433_CENTRAL_SEQ_CONFIGURATION);
> +       if (enable)
> +               tmp &= ~EXYNOS5433_CENTRALSEQ_PWR_CFG;
> +       else
> +               tmp |= EXYNOS5433_CENTRALSEQ_PWR_CFG;
> +       pmu_raw_writel(tmp, EXYNOS5433_CENTRAL_SEQ_CONFIGURATION);
> +
> +       tmp = pmu_raw_readl(EXYNOS5433_CENTRAL_SEQ_MIF_CONFIGURATION);
> +       if (enable)
> +               tmp &= ~EXYNOS5433_CENTRALSEQ_PWR_CFG;
> +       else
> +               tmp |= EXYNOS5433_CENTRALSEQ_PWR_CFG;
> +       pmu_raw_writel(tmp, EXYNOS5433_CENTRAL_SEQ_MIF_CONFIGURATION);
> +}
> +
> +static void exynos5433_pmu_pad_retention_release(void)
> +{
> +       unsigned int tmp;
> +       int i;

unsigned int i

> +
> +       for (i = 0 ; i < ARRAY_SIZE(exynos5433_list_pad_retention) ; i++) {
> +               tmp = pmu_raw_readl(exynos5433_list_pad_retention[i]);
> +               tmp |= EXYNOS5433_INITIATE_WAKEUP_FROM_LOWPOWER;
> +               pmu_raw_writel(tmp, exynos5433_list_pad_retention[i]);
> +       }
> +}
> +
> +static void exynos5433_pmu_init(void)
> +{
> +       unsigned int tmp;
> +       int i, cluster, cpu;

unsigned int i

> +
> +       /* Enable non retention flip-flop reset for wakeup */
> +       tmp = pmu_raw_readl(EXYNOS5433_PMU_SPARE0);
> +       tmp |= EXYNOS5433_EN_NONRET_RESET;
> +       pmu_raw_writel(tmp, EXYNOS5433_PMU_SPARE0);

This is spare register. Who is using it? Firmware? Please add its
usage also in Documentation/arm/Samsung/Bootloader-interface.txt.

> +
> +        /* Enable only SC_FEEDBACK for the register list */
> +       for (i = 0 ; i < ARRAY_SIZE(exynos5433_list_feed) ; i++) {
> +               tmp = pmu_raw_readl(exynos5433_list_feed[i]);
> +               tmp &= ~EXYNOS5_USE_SC_COUNTER;
> +               tmp |= EXYNOS5_USE_SC_FEEDBACK;
> +               pmu_raw_writel(tmp, exynos5433_list_feed[i]);
> +       }
> +
> +       /*
> +        * Disable automatic L2 flush, Disable L2 retention and
> +        * Enable STANDBYWFIL2, ACE/ACP
> +        */
> +       for (cluster = 0; cluster < 2; cluster++) {
> +               tmp = pmu_raw_readl(EXYNOS5433_ATLAS_L2_OPTION + (cluster * 0x20));

I would prefer to follow the convention for similar registers for cores, like:
EXYNOS_ARM_CORE_CONFIGURATION
EXYNOS_ARM_CORE_STATUS

This moves the offset into the header, along to other register offsets.

> +               tmp &= ~(EXYNOS5433_USE_AUTO_L2FLUSHREQ | EXYNOS5433_USE_RETENTION);
> +
> +               if (cluster == 0) {
> +                       tmp |= (EXYNOS5433_USE_STANDBYWFIL2 |
> +                               EXYNOS5433_USE_DEACTIVATE_ACE |
> +                               EXYNOS5433_USE_DEACTIVATE_ACP);
> +               }
> +               pmu_raw_writel(tmp, EXYNOS5433_ATLAS_L2_OPTION + (cluster * 0x20));
> +       }
> +
> +       /*
> +        * Enable both SC_COUNTER and SC_FEEDBACK for the CPUs
> +        * Use STANDBYWFI and SMPEN to indicate that core is ready to enter
> +        * low power mode
> +        */
> +       for (cpu = 0; cpu < 8; cpu++) {
> +               tmp = pmu_raw_readl(EXYNOS5433_CPU_OPTION(cpu));
> +               tmp |= (EXYNOS5_USE_SC_FEEDBACK | EXYNOS5_USE_SC_COUNTER);
> +               tmp |= EXYNOS5433_USE_SMPEN;
> +               tmp |= EXYNOS5433_USE_STANDBYWFI;
> +               tmp &= ~EXYNOS5433_USE_STANDBYWFE;
> +               pmu_raw_writel(tmp, EXYNOS5433_CPU_OPTION(cpu));
> +
> +               tmp = pmu_raw_readl(EXYNOS5433_CPU_DURATION(cpu));
> +               tmp |= EXYNOS5433_DUR_WAIT_RESET;
> +               tmp &= ~EXYNOS5433_DUR_SCALL;
> +               tmp |= EXYNOS5433_DUR_SCALL_VALUE;
> +               pmu_raw_writel(tmp, EXYNOS5433_CPU_DURATION(cpu));
> +       }
> +
> +       /* Skip atlas block power-off during automatic power down sequence */
> +       tmp = pmu_raw_readl(EXYNOS5433_ATLAS_CPUSEQUENCER_OPTION);
> +       tmp |= EXYNOS5433_SKIP_BLK_PWR_DOWN;
> +       pmu_raw_writel(tmp, EXYNOS5433_ATLAS_CPUSEQUENCER_OPTION);
> +
> +       /* Limit in-rush current during local power up of cores */
> +       tmp = pmu_raw_readl(EXYNOS5433_UP_SCHEDULER);
> +       tmp |= EXYNOS5433_ENABLE_ATLAS_CPU;
> +       pmu_raw_writel(tmp, EXYNOS5433_UP_SCHEDULER);
> +}
> +
> +static void exynos5433_powerdown_conf(enum sys_powerdown mode)
> +{
> +       switch (mode) {
> +       case SYS_SLEEP:
> +               exynos5433_set_wakeupmask(mode);
> +               exynos5433_pmu_central_seq(true);
> +               break;
> +       default:
> +               break;
> +       };
> +}
> +
> +static void exynos5433_powerup_conf(enum sys_powerdown mode)
> +{
> +       unsigned int wakeup;
> +
> +       switch (mode) {
> +       case SYS_SLEEP:
> +               wakeup = pmu_raw_readl(EXYNOS5433_CENTRAL_SEQ_CONFIGURATION);
> +               wakeup &= EXYNOS5433_CENTRALSEQ_PWR_CFG;
> +               if (wakeup)
> +                       exynos5433_pmu_pad_retention_release();
> +               else
> +                       exynos5433_pmu_central_seq(false);

I do not understand what you want to achieve here. Re-suspend?

> +               break;
> +       default:
> +               break;
> +       };
> +}
> +
> +const struct exynos_pmu_data exynos5433_pmu_data = {
> +       .pmu_config             = exynos5433_pmu_config,
> +       .pmu_init               = exynos5433_pmu_init,
> +       .powerdown_conf         = exynos5433_powerdown_conf,
> +       .powerup_conf           = exynos5433_powerup_conf,
> +};
> diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
> index bebdde5dccd6..93a52d133ba1 100644
> --- a/include/linux/soc/samsung/exynos-regs-pmu.h
> +++ b/include/linux/soc/samsung/exynos-regs-pmu.h
> @@ -645,7 +645,110 @@
>                                          | EXYNOS5420_KFC_USE_STANDBY_WFI3)
>
>  /* For EXYNOS5433 */
> +#define EXYNOS5433_UP_SCHEDULER                                        (0x0120)
> +#define EXYNOS5433_CENTRAL_SEQ_CONFIGURATION                   (0x0200)
> +#define EXYNOS5433_CENTRAL_SEQ_MIF_CONFIGURATION               (0x0240)
> +#define EXYNOS5433_EINT_WAKEUP_MASK                            (0x060C)
> +#define EXYNOS5433_WAKEUP_MASK                                 (0x0610)
> +#define EXYNOS5433_WAKEUP_MASK2                                        (0x0614)
> +#define EXYNOS5433_WAKEUP_MASK3                                        (0x0618)
> +#define EXYNOS5433_EINT_WAKEUP_MASK1                           (0x062C)
>  #define EXYNOS5433_USBHOST30_PHY_CONTROL                       (0x0728)
> +#define EXYNOS5433_PMU_SPARE0                                  (0x0900)
> +#define EXYNOS5433_ATLAS_CPU0_SYS_PWR_REG                      (0x1000)
> +#define EXYNOS5433_DIS_IRQ_ATLAS_CPU0_CENTRAL_SYS_PWR_REG      (0x1008)
> +#define EXYNOS5433_ATLAS_CPU1_SYS_PWR_REG                      (0x1010)
> +#define EXYNOS5433_DIS_IRQ_ATLAS_CPU1_CENTRAL_SYS_PWR_REG      (0x1018)
> +#define EXYNOS5433_ATLAS_CPU2_SYS_PWR_REG                      (0x1020)
> +#define EXYNOS5433_DIS_IRQ_ATLAS_CPU2_CENTRAL_SYS_PWR_REG      (0x1028)
> +#define EXYNOS5433_ATLAS_CPU3_SYS_PWR_REG                      (0x1030)
> +#define EXYNOS5433_DIS_IRQ_ATLAS_CPU3_CENTRAL_SYS_PWR_REG      (0x1038)
> +#define EXYNOS5433_APOLLO_CPU0_SYS_PWR_REG                     (0x1040)
> +#define EXYNOS5433_DIS_IRQ_APOLLO_CPU0_CENTRAL_SYS_PWR_REG     (0x1048)
> +#define EXYNOS5433_APOLLO_CPU1_SYS_PWR_REG                     (0x1050)
> +#define EXYNOS5433_DIS_IRQ_APOLLO_CPU1_CENTRAL_SYS_PWR_REG     (0x1058)
> +#define EXYNOS5433_APOLLO_CPU2_SYS_PWR_REG                     (0x1060)
> +#define EXYNOS5433_DIS_IRQ_APOLLO_CPU2_CENTRAL_SYS_PWR_REG     (0x1068)
> +#define EXYNOS5433_APOLLO_CPU3_SYS_PWR_REG                     (0x1070)
> +#define EXYNOS5433_DIS_IRQ_APOLLO_CPU3_CENTRAL_SYS_PWR_REG     (0x1078)
> +#define EXYNOS5433_ATLAS_NONCPU_SYS_PWR_REG                    (0x1080)
> +#define EXYNOS5433_ATLAS_L2_SYS_PWR_REG                                (0x10C0)
> +#define EXYNOS5433_APOLLO_L2_SYS_PWR_REG                       (0x10C4)
> +#define EXYNOS5433_APOLLO_NONCPU_SYS_PWR_REG                   (0x1084)
> +#define EXYNOS5433_A5IS_SYS_PWR_REG                            (0x10B0)
> +#define EXYNOS5433_DIS_IRQ_A5IS_LOCAL_SYS_PWR_REG              (0x10B4)
> +#define EXYNOS5433_DIS_IRQ_A5IS_CENTRAL_SYS_PWR_REG            (0x10B8)
> +#define EXYNOS5433_CLKSTOP_CMU_TOP_SYS_PWR_REG                 (0x1100)
> +#define EXYNOS5433_CLKRUN_CMU_TOP_SYS_PWR_REG                  (0x1104)
> +#define EXYNOS5433_RESET_CMU_TOP_SYS_PWR_REG                   (0x110C)
> +#define EXYNOS5433_RESET_CPUCLKSTOP_SYS_PWR_REG                        (0x111C)
> +#define EXYNOS5433_CLKSTOP_CMU_MIF_SYS_PWR_REG                 (0x1120)
> +#define EXYNOS5433_CLKRUN_CMU_MIF_SYS_PWR_REG                  (0x1124)
> +#define EXYNOS5433_RESET_CMU_MIF_SYS_PWR_REG                   (0x112C)
> +#define EXYNOS5433_DDRPHY_DLLLOCK_SYS_PWR_REG                  (0x1138)
> +#define EXYNOS5433_DISABLE_PLL_CMU_TOP_SYS_PWR_REG             (0x1140)
> +#define EXYNOS5433_DISABLE_PLL_AUD_PLL_SYS_PWR_REG             (0x1144)
> +#define EXYNOS5433_DISABLE_PLL_CMU_MIF_SYS_PWR_REG             (0x1160)
> +#define EXYNOS5433_TOP_BUS_SYS_PWR_REG                         (0x1180)
> +#define EXYNOS5433_TOP_RETENTION_SYS_PWR_REG                   (0x1184)
> +#define EXYNOS5433_TOP_PWR_SYS_PWR_REG                         (0x1188)
> +#define EXYNOS5433_TOP_BUS_MIF_SYS_PWR_REG                     (0x1190)
> +#define EXYNOS5433_TOP_RETENTION_MIF_SYS_PWR_REG               (0x1194)
> +#define EXYNOS5433_TOP_PWR_MIF_SYS_PWR_REG                     (0x1198)
> +#define EXYNOS5433_LOGIC_RESET_SYS_PWR_REG                     (0x11A0)
> +#define EXYNOS5433_OSCCLK_GATE_SYS_PWR_REG                     (0x11A4)
> +#define EXYNOS5433_SLEEP_RESET_SYS_PWR_REG                     (0x11A8)
> +#define EXYNOS5433_LOGIC_RESET_MIF_SYS_PWR_REG                 (0x11B0)
> +#define EXYNOS5433_OSCCLK_GATE_MIF_SYS_PWR_REG                 (0x11B4)
> +#define EXYNOS5433_SLEEP_RESET_MIF_SYS_PWR_REG                 (0x11B8)
> +#define EXYNOS5433_MEMORY_TOP_SYS_PWR_REG                      (0x11C0)
> +#define EXYNOS5433_PAD_RETENTION_LPDDR3_SYS_PWR_REG            (0x1200)
> +#define EXYNOS5433_PAD_RETENTION_JTAG_SYS_PWR_REG              (0x1208)
> +#define EXYNOS5433_PAD_RETENTION_TOP_SYS_PWR_REG               (0x1220)
> +#define EXYNOS5433_PAD_RETENTION_UART_SYS_PWR_REG              (0x1224)
> +#define EXYNOS5433_PAD_RETENTION_EBIA_SYS_PWR_REG              (0x1230)
> +#define EXYNOS5433_PAD_RETENTION_EBIB_SYS_PWR_REG              (0x1234)
> +#define EXYNOS5433_PAD_RETENTION_SPI_SYS_PWR_REG               (0x1238)
> +#define EXYNOS5433_PAD_RETENTION_MIF_SYS_PWR_REG               (0x123C)
> +#define EXYNOS5433_PAD_ISOLATION_SYS_PWR_REG                   (0x1240)
> +#define EXYNOS5433_PAD_RETENTION_USBXTI_SYS_PWR_REG            (0x1244)
> +#define EXYNOS5433_PAD_RETENTION_BOOTLDO_SYS_PWR_REG           (0x1248)
> +#define EXYNOS5433_PAD_ISOLATION_MIF_SYS_PWR_REG               (0x1250)
> +#define EXYNOS5433_PAD_RETENTION_FSYSGENIO_SYS_PWR_REG         (0x1254)
> +#define EXYNOS5433_PAD_ALV_SEL_SYS_PWR_REG                     (0x1260)
> +#define EXYNOS5433_XXTI_SYS_PWR_REG                            (0x1284)
> +#define EXYNOS5433_XXTI26_SYS_PWR_REG                          (0x1288)
> +#define EXYNOS5433_EXT_REGULATOR_SYS_PWR_REG                   (0x12C0)
> +#define EXYNOS5433_GPIO_MODE_SYS_PWR_REG                       (0x1300)
> +#define EXYNOS5433_GPIO_MODE_FSYS0_SYS_PWR_REG                 (0x1304)
> +#define EXYNOS5433_GPIO_MODE_MIF_SYS_PWR_REG                   (0x1320)
> +#define EXYNOS5433_GPIO_MODE_AUD_SYS_PWR_REG                   (0x1340)
> +#define EXYNOS5433_GSCL_SYS_PWR_REG                            (0x1400)
> +#define EXYNOS5433_CAM0_SYS_PWR_REG                            (0x1404)
> +#define EXYNOS5433_MSCL_SYS_PWR_REG                            (0x1408)
> +#define EXYNOS5433_G3D_SYS_PWR_REG                             (0x140C)
> +#define EXYNOS5433_DISP_SYS_PWR_REG                            (0x1410)
> +#define EXYNOS5433_CAM1_SYS_PWR_REG                            (0x1414)
> +#define EXYNOS5433_AUD_SYS_PWR_REG                             (0x1418)
> +#define EXYNOS5433_FSYS_SYS_PWR_REG                            (0x141C)
> +#define EXYNOS5433_BUS2_SYS_PWR_REG                            (0x1420)
> +#define EXYNOS5433_G2D_SYS_PWR_REG                             (0x1424)
> +#define EXYNOS5433_ISP0_SYS_PWR_REG                            (0x1428)
> +#define EXYNOS5433_MFC_SYS_PWR_REG                             (0x1430)
> +#define EXYNOS5433_HEVC_SYS_PWR_REG                            (0x1438)
> +#define EXYNOS5433_RESET_SLEEP_FSYS_SYS_PWR_REG                        (0x15DC)
> +#define EXYNOS5433_RESET_SLEEP_BUS2_SYS_PWR_REG                        (0x15E0)
> +#define EXYNOS5433_ATLAS_CPU0_OPTION                           (0x2008)
> +#define EXYNOS5433_CPU_OPTION(_nr)                             (EXYNOS5433_ATLAS_CPU0_OPTION + (_nr) * 0x80)
> +#define EXYNOS5433_ATLAS_CPU0_DURATION0                                (0x2010)
> +#define EXYNOS5433_CPU_DURATION(_nr)                           (EXYNOS5433_ATLAS_CPU0_DURATION0 + (_nr) * 0x80)
> +#define EXYNOS5433_ATLAS_NONCPU_OPTION                         (0x2408)
> +#define EXYNOS5433_APOLLO_NONCPU_OPTION                                (0x2428)
> +#define EXYNOS5433_ATLAS_CPUSEQUENCER_OPTION                   (0x2488)
> +#define EXYNOS5433_ATLAS_L2_OPTION                             (0x2608)
> +#define EXYNOS5433_TOP_PWR_MIF_OPTION                          (0x2CC8)
> +#define EXYNOS5433_TOP_PWR_OPTION                              (0x2C48)
> +#define EXYNOS5433_PAD_RETENTION_LPDDR3_OPTION                 (0x3008)
>  #define EXYNOS5433_PAD_RETENTION_AUD_OPTION                    (0x3028)
>  #define EXYNOS5433_PAD_RETENTION_MMC2_OPTION                   (0x30C8)
>  #define EXYNOS5433_PAD_RETENTION_TOP_OPTION                    (0x3108)
> @@ -660,5 +763,50 @@
>  #define EXYNOS5433_PAD_RETENTION_BOOTLDO_OPTION                        (0x3248)
>  #define EXYNOS5433_PAD_RETENTION_UFS_OPTION                    (0x3268)
>  #define EXYNOS5433_PAD_RETENTION_FSYSGENIO_OPTION              (0x32A8)
> +#define EXYNOS5433_PS_HOLD_CONTROL                             (0x330C)
> +#define EXYNOS5433_GSCL_OPTION                                 (0x4008)
> +#define EXYNOS5433_CAM0_OPTION                                 (0x4028)
> +#define EXYNOS5433_MSCL_OPTION                                 (0x4048)
> +#define EXYNOS5433_G3D_OPTION                                  (0x4068)
> +#define EXYNOS5433_DISP_OPTION                                 (0x4088)
> +#define EXYNOS5433_AUD_OPTION                                  (0x40C8)
> +#define EXYNOS5433_FSYS_OPTION                                 (0x40E8)
> +#define EXYNOS5433_BUS2_OPTION                                 (0x4108)
> +#define EXYNOS5433_G2D_OPTION                                  (0x4128)
> +#define EXYNOS5433_ISP_OPTION                                  (0x4148)
> +#define EXYNOS5433_MFC_OPTION                                  (0x4188)
> +#define EXYNOS5433_HEVC_OPTION                                 (0x41C8)
> +
> +/* EXYNOS5433_PMU_SPARE0 */
> +#define EXYNOS5433_EN_NONRET_RESET                             (1 << 0)

Use BIT(0) here and in other places.

Best regards,
Krzysztof

> +
> +/* EXYNOS5433_CENTRAL_SEQ_CONFIGURATION */
> +#define EXYNOS5433_CENTRALSEQ_PWR_CFG                          (0x1 << 16)
> +
> +/* EXYNOS5433_ATLAS_L2_OPTION */
> +#define EXYNOS5433_USE_DEACTIVATE_ACE                          (0x1 << 19)
> +#define EXYNOS5433_USE_DEACTIVATE_ACP                          (0x1 << 18)
> +#define EXYNOS5433_USE_AUTO_L2FLUSHREQ                         (0x1 << 17)
> +#define EXYNOS5433_USE_STANDBYWFIL2                            (0x1 << 16)
> +#define EXYNOS5433_USE_RETENTION                               (0x1 << 4)
> +
> +/* EXYNOS5433_CPU_OPTION */
> +#define EXYNOS5433_USE_SMPEN                                   (0x1 << 28)
> +#define EXYNOS5433_USE_STANDBYWFE                              (0x1 << 24)
> +#define EXYNOS5433_USE_STANDBYWFI                              (0x1 << 16)
> +
> +/* EXYNOS5433_PAD_RETENTION_*_OPTION */
> +#define EXYNOS5433_INITIATE_WAKEUP_FROM_LOWPOWER               (0x1 << 28)
> +
> +/* EXYNOS5433_CPU_DURATION */
> +#define EXYNOS5433_DUR_WAIT_RESET                              (0xF << 20)
> +#define EXYNOS5433_DUR_SCALL                                   (0xF << 4)
> +#define EXYNOS5433_DUR_SCALL_VALUE                             (0x1 << 4)
> +
> +/* EXYNOS5433_ATLAS_CPUSEQUENCER_OPTION */
> +#define EXYNOS5433_SKIP_BLK_PWR_DOWN                           (0x1 << 8)
> +
> +/* EXYNOS5433_UP_SCHEDULER */
> +#define EXYNOS5433_ENABLE_ATLAS_CPU                            (0x1 << 0)
>
>  #endif /* __LINUX_SOC_EXYNOS_REGS_PMU_H */
> --
> 1.9.1
>
