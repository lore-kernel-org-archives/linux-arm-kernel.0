From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Sun, 11 May 2014 18:50:42 +0530
Subject: [PATCH V3 1/3] ARM: EXYNOS5: PMU support for 5420
In-Reply-To: <1399546342-30494-1-git-send-email-vikas.sajjan@samsung.com>
References: <1399546342-30494-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <CAGOxZ52Vnvmu71qH7oJFiuRqbHdtMWYgjjBsPOPf+K52o9tb7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI

On Thu, May 8, 2014 at 4:22 PM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
> Add intial PMU settings for exynos5420. This is required for
> future S2R and Switching support.
>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
> ---
>  arch/arm/mach-exynos/common.h   |    9 ++
>  arch/arm/mach-exynos/exynos.c   |    1 +
>  arch/arm/mach-exynos/pmu.c      |  325 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-exynos/regs-pmu.h |  231 ++++++++++++++++++++++++++++
>  4 files changed, 566 insertions(+)
>
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index 8f45a35..9e31cf1 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -17,6 +17,15 @@
>
>  void exynos_firmware_init(void);
>
> +#define EXYNOS5420_USE_STANDBY_WFI_ALL (EXYNOS5420_ARM_USE_STANDBY_WFI0  \
> +                                        | EXYNOS5420_ARM_USE_STANDBY_WFI1  \
> +                                        | EXYNOS5420_ARM_USE_STANDBY_WFI2  \
> +                                        | EXYNOS5420_ARM_USE_STANDBY_WFI3  \
> +                                        | EXYNOS5420_KFC_USE_STANDBY_WFI0  \
> +                                        | EXYNOS5420_KFC_USE_STANDBY_WFI1  \
> +                                        | EXYNOS5420_KFC_USE_STANDBY_WFI2  \
> +                                        | EXYNOS5420_KFC_USE_STANDBY_WFI3)
> +
>  #ifdef CONFIG_PINCTRL_EXYNOS
>  extern u32 exynos_get_eint_wake_mask(void);
>  #else
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index a59b122..72b6c3f 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -259,6 +259,7 @@ static const struct of_device_id exynos_dt_pmu_match[] = {
>         { .compatible = "samsung,exynos4212-pmu" },
>         { .compatible = "samsung,exynos4412-pmu" },
>         { .compatible = "samsung,exynos5250-pmu" },
> +       { .compatible = "samsung,exynos5420-pmu" },
>         {},
>  };
>
> diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
> index 1570761..c40e6c1 100644
> --- a/arch/arm/mach-exynos/pmu.c
> +++ b/arch/arm/mach-exynos/pmu.c
> @@ -9,6 +9,7 @@
>   * published by the Free Software Foundation.
>   */
>
> +#include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  #include <linux/of.h>
> @@ -16,8 +17,11 @@
>  #include <linux/slab.h>
>  #include <linux/mfd/syscon.h>
>
> +#include <asm/cputype.h>
> +
>  #include "exynos-pmu.h"
>  #include "regs-pmu.h"
> +#include "common.h"
>
>  struct exynos_pmu_data {
>         const struct exynos_pmu_conf *pmu_config;
> @@ -332,6 +336,151 @@ static const struct exynos_pmu_conf exynos5250_pmu_config[] = {
>         { PMU_TABLE_END,},
>  };
>
> +static struct exynos_pmu_conf exynos5420_pmu_config[] = {
> +       /* { .reg = address, .val = { AFTR, LPA, SLEEP } */
> +       { EXYNOS5_ARM_CORE0_SYS_PWR_REG,                        { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_DIS_IRQ_ARM_CORE0_LOCAL_SYS_PWR_REG,          { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_DIS_IRQ_ARM_CORE0_CENTRAL_SYS_PWR_REG,        { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_ARM_CORE1_SYS_PWR_REG,                        { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_DIS_IRQ_ARM_CORE1_LOCAL_SYS_PWR_REG,          { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_DIS_IRQ_ARM_CORE1_CENTRAL_SYS_PWR_REG,        { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_ARM_CORE2_SYS_PWR_REG,                     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_ARM_CORE2_LOCAL_SYS_PWR_REG,       { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_ARM_CORE2_CENTRAL_SYS_PWR_REG,     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_ARM_CORE3_SYS_PWR_REG,                     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_ARM_CORE3_LOCAL_SYS_PWR_REG,       { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_ARM_CORE3_CENTRAL_SYS_PWR_REG,     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_KFC_CORE0_SYS_PWR_REG,                     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_KFC_CORE0_LOCAL_SYS_PWR_REG,       { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_KFC_CORE0_CENTRAL_SYS_PWR_REG,     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_KFC_CORE1_SYS_PWR_REG,                     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_KFC_CORE1_LOCAL_SYS_PWR_REG,       { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_KFC_CORE1_CENTRAL_SYS_PWR_REG,     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_KFC_CORE2_SYS_PWR_REG,                     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_KFC_CORE2_LOCAL_SYS_PWR_REG,       { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_KFC_CORE2_CENTRAL_SYS_PWR_REG,     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_KFC_CORE3_SYS_PWR_REG,                     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_KFC_CORE3_LOCAL_SYS_PWR_REG,       { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_KFC_CORE3_CENTRAL_SYS_PWR_REG,     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_ISP_ARM_SYS_PWR_REG,                          { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_DIS_IRQ_ISP_ARM_LOCAL_SYS_PWR_REG,            { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_DIS_IRQ_ISP_ARM_CENTRAL_SYS_PWR_REG,          { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_ARM_COMMON_SYS_PWR_REG,                    { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_KFC_COMMON_SYS_PWR_REG,                    { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_ARM_L2_SYS_PWR_REG,                           { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_KFC_L2_SYS_PWR_REG,                        { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_ACLKSTOP_SYS_PWR_REG,                     { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_CMU_SCLKSTOP_SYS_PWR_REG,                     { 0x1, 0x0, 0x1} },
> +       { EXYNOS5_CMU_RESET_SYS_PWR_REG,                        { 0x1, 0x1, 0x0} },
> +       { EXYNOS5_CMU_ACLKSTOP_SYSMEM_SYS_PWR_REG,              { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_CMU_SCLKSTOP_SYSMEM_SYS_PWR_REG,              { 0x1, 0x0, 0x1} },
> +       { EXYNOS5_CMU_RESET_SYSMEM_SYS_PWR_REG,                 { 0x1, 0x1, 0x0} },
> +       { EXYNOS5_DRAM_FREQ_DOWN_SYS_PWR_REG,                   { 0x1, 0x0, 0x1} },
> +       { EXYNOS5_DDRPHY_DLLOFF_SYS_PWR_REG,                    { 0x1, 0x1, 0x1} },
> +       { EXYNOS5_DDRPHY_DLLLOCK_SYS_PWR_REG,                   { 0x1, 0x0, 0x1} },
> +       { EXYNOS5_APLL_SYSCLK_SYS_PWR_REG,                      { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_MPLL_SYSCLK_SYS_PWR_REG,                      { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_VPLL_SYSCLK_SYS_PWR_REG,                      { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_EPLL_SYSCLK_SYS_PWR_REG,                      { 0x1, 0x1, 0x0} },
> +       { EXYNOS5_BPLL_SYSCLK_SYS_PWR_REG,                      { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_CPLL_SYSCLK_SYS_PWR_REG,                      { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_DPLL_SYSCLK_SYS_PWR_REG,                   { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_IPLL_SYSCLK_SYS_PWR_REG,                   { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_KPLL_SYSCLK_SYS_PWR_REG,                   { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_MPLLUSER_SYSCLK_SYS_PWR_REG,                  { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_BPLLUSER_SYSCLK_SYS_PWR_REG,                  { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_RPLL_SYSCLK_SYS_PWR_REG,                   { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_SPLL_SYSCLK_SYS_PWR_REG,                   { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_TOP_BUS_SYS_PWR_REG,                          { 0x3, 0x0, 0x0} },
> +       { EXYNOS5_TOP_RETENTION_SYS_PWR_REG,                    { 0x1, 0x1, 0x1} },
> +       { EXYNOS5_TOP_PWR_SYS_PWR_REG,                          { 0x3, 0x3, 0x0} },
> +       { EXYNOS5_TOP_BUS_SYSMEM_SYS_PWR_REG,                   { 0x3, 0x0, 0x0} },
> +       { EXYNOS5_TOP_RETENTION_SYSMEM_SYS_PWR_REG,             { 0x1, 0x0, 0x1} },
> +       { EXYNOS5_TOP_PWR_SYSMEM_SYS_PWR_REG,                   { 0x3, 0x0, 0x0} },
> +       { EXYNOS5_LOGIC_RESET_SYS_PWR_REG,                      { 0x1, 0x1, 0x0} },
> +       { EXYNOS5_OSCCLK_GATE_SYS_PWR_REG,                      { 0x1, 0x0, 0x1} },
> +       { EXYNOS5_LOGIC_RESET_SYSMEM_SYS_PWR_REG,               { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_OSCCLK_GATE_SYSMEM_SYS_PWR_REG,               { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_INTRAM_MEM_SYS_PWR_REG,                    { 0x3, 0x0, 0x3} },
> +       { EXYNOS5420_INTROM_MEM_SYS_PWR_REG,                    { 0x3, 0x0, 0x3} },
> +       { EXYNOS5_PAD_RETENTION_DRAM_SYS_PWR_REG,               { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_PAD_RETENTION_MAU_SYS_PWR_REG,                { 0x1, 0x1, 0x0} },
> +       { EXYNOS5420_PAD_RETENTION_JTAG_SYS_PWR_REG,            { 0x1, 0x1, 0x0} },
> +       { EXYNOS5420_PAD_RETENTION_DRAM_SYS_PWR_REG,            { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_PAD_RETENTION_UART_SYS_PWR_REG,            { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_PAD_RETENTION_MMC0_SYS_PWR_REG,            { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_PAD_RETENTION_MMC1_SYS_PWR_REG,            { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_PAD_RETENTION_MMC2_SYS_PWR_REG,            { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_PAD_RETENTION_HSI_SYS_PWR_REG,             { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_PAD_RETENTION_EBIA_SYS_PWR_REG,            { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_PAD_RETENTION_EBIB_SYS_PWR_REG,            { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_PAD_RETENTION_SPI_SYS_PWR_REG,             { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_PAD_RETENTION_DRAM_COREBLK_SYS_PWR_REG,    { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_PAD_ISOLATION_SYS_PWR_REG,                    { 0x1, 0x1, 0x0} },
> +       { EXYNOS5_PAD_ISOLATION_SYSMEM_SYS_PWR_REG,             { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_PAD_ALV_SEL_SYS_PWR_REG,                      { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_XUSBXTI_SYS_PWR_REG,                          { 0x1, 0x1, 0x0} },
> +       { EXYNOS5_XXTI_SYS_PWR_REG,                             { 0x1, 0x1, 0x0} },
> +       { EXYNOS5_EXT_REGULATOR_SYS_PWR_REG,                    { 0x1, 0x1, 0x0} },
> +       { EXYNOS5_GPIO_MODE_SYS_PWR_REG,                        { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_GPIO_MODE_SYSMEM_SYS_PWR_REG,                 { 0x1, 0x1, 0x0} },
> +       { EXYNOS5_GPIO_MODE_MAU_SYS_PWR_REG,                    { 0x1, 0x1, 0x0} },
> +       { EXYNOS5_TOP_ASB_RESET_SYS_PWR_REG,                    { 0x1, 0x1, 0x0} },
> +       { EXYNOS5_TOP_ASB_ISOLATION_SYS_PWR_REG,                { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_GSCL_SYS_PWR_REG,                             { 0x7, 0x0, 0x0} },
> +       { EXYNOS5_ISP_SYS_PWR_REG,                              { 0x7, 0x0, 0x0} },
> +       { EXYNOS5_MFC_SYS_PWR_REG,                              { 0x7, 0x0, 0x0} },
> +       { EXYNOS5_G3D_SYS_PWR_REG,                              { 0x7, 0x0, 0x0} },
> +       { EXYNOS5420_DISP1_SYS_PWR_REG,                         { 0x7, 0x0, 0x0} },
> +       { EXYNOS5420_MAU_SYS_PWR_REG,                           { 0x7, 0x7, 0x0} },
> +       { EXYNOS5420_G2D_SYS_PWR_REG,                           { 0x7, 0x0, 0x0} },
> +       { EXYNOS5420_MSC_SYS_PWR_REG,                           { 0x7, 0x0, 0x0} },
> +       { EXYNOS5420_FSYS_SYS_PWR_REG,                          { 0x7, 0x0, 0x0} },
> +       { EXYNOS5420_FSYS2_SYS_PWR_REG,                         { 0x7, 0x0, 0x0} },
> +       { EXYNOS5420_PSGEN_SYS_PWR_REG,                         { 0x7, 0x0, 0x0} },
> +       { EXYNOS5420_PERIC_SYS_PWR_REG,                         { 0x7, 0x0, 0x0} },
> +       { EXYNOS5420_WCORE_SYS_PWR_REG,                         { 0x7, 0x0, 0x0} },
> +       { EXYNOS5_CMU_CLKSTOP_GSCL_SYS_PWR_REG,                 { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_CLKSTOP_ISP_SYS_PWR_REG,                  { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_CLKSTOP_MFC_SYS_PWR_REG,                  { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_CLKSTOP_G3D_SYS_PWR_REG,                  { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_CLKSTOP_DISP1_SYS_PWR_REG,             { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_CLKSTOP_MAU_SYS_PWR_REG,               { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_CLKSTOP_G2D_SYS_PWR_REG,               { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_CLKSTOP_MSC_SYS_PWR_REG,               { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_CLKSTOP_FSYS_SYS_PWR_REG,              { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_CLKSTOP_PSGEN_SYS_PWR_REG,             { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_CLKSTOP_PERIC_SYS_PWR_REG,             { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_CLKSTOP_WCORE_SYS_PWR_REG,             { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_SYSCLK_GSCL_SYS_PWR_REG,                  { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_SYSCLK_ISP_SYS_PWR_REG,                   { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_SYSCLK_MFC_SYS_PWR_REG,                   { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_SYSCLK_G3D_SYS_PWR_REG,                   { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_SYSCLK_DISP1_SYS_PWR_REG,              { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_SYSCLK_MAU_SYS_PWR_REG,                { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_SYSCLK_G2D_SYS_PWR_REG,                { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_SYSCLK_MSC_SYS_PWR_REG,                { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_SYSCLK_FSYS_SYS_PWR_REG,               { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_SYSCLK_FSYS2_SYS_PWR_REG,              { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_SYSCLK_PSGEN_SYS_PWR_REG,              { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_SYSCLK_PERIC_SYS_PWR_REG,              { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_SYSCLK_WCORE_SYS_PWR_REG,              { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_RESET_FSYS2_SYS_PWR_REG,               { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_RESET_PSGEN_SYS_PWR_REG,               { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_RESET_PERIC_SYS_PWR_REG,               { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_RESET_WCORE_SYS_PWR_REG,               { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_RESET_GSCL_SYS_PWR_REG,                   { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_RESET_ISP_SYS_PWR_REG,                    { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_RESET_MFC_SYS_PWR_REG,                    { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_RESET_G3D_SYS_PWR_REG,                    { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_RESET_DISP1_SYS_PWR_REG,               { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_RESET_MAU_SYS_PWR_REG,                 { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_RESET_G2D_SYS_PWR_REG,                 { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_RESET_MSC_SYS_PWR_REG,                 { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG,                { 0x0, 0x0, 0x0} },
> +       { PMU_TABLE_END,},
> +};
> +
>  static unsigned int const exynos5_list_both_cnt_feed[] = {
>         EXYNOS5_ARM_CORE0_OPTION,
>         EXYNOS5_ARM_CORE1_OPTION,
> @@ -352,6 +501,98 @@ static unsigned int const exynos5_list_diable_wfi_wfe[] = {
>         EXYNOS5_ISP_ARM_OPTION,
>  };
>
> +static unsigned int const exynos5_list_disable_pmu_reg[] = {
> +       EXYNOS5_CMU_CLKSTOP_GSCL_SYS_PWR_REG,
> +       EXYNOS5_CMU_CLKSTOP_ISP_SYS_PWR_REG,
> +       EXYNOS5_CMU_CLKSTOP_MFC_SYS_PWR_REG,
> +       EXYNOS5_CMU_CLKSTOP_G3D_SYS_PWR_REG,
> +       EXYNOS5_CMU_CLKSTOP_DISP1_SYS_PWR_REG,
> +       EXYNOS5_CMU_CLKSTOP_MAU_SYS_PWR_REG,
> +       EXYNOS5_CMU_SYSCLK_GSCL_SYS_PWR_REG,
> +       EXYNOS5_CMU_SYSCLK_ISP_SYS_PWR_REG,
> +       EXYNOS5_CMU_SYSCLK_MFC_SYS_PWR_REG,
> +       EXYNOS5_CMU_SYSCLK_G3D_SYS_PWR_REG,
> +       EXYNOS5_CMU_SYSCLK_DISP1_SYS_PWR_REG,
> +       EXYNOS5_CMU_SYSCLK_MAU_SYS_PWR_REG,
> +       EXYNOS5_CMU_RESET_GSCL_SYS_PWR_REG,
> +       EXYNOS5_CMU_RESET_MFC_SYS_PWR_REG,
> +       EXYNOS5_CMU_RESET_G3D_SYS_PWR_REG,
> +       EXYNOS5_CMU_RESET_DISP1_SYS_PWR_REG,
> +       EXYNOS5_CMU_RESET_MAU_SYS_PWR_REG,
> +};
> +
> +static unsigned int const exynos5420_list_disable_pmu_reg[] = {
> +       EXYNOS5_CMU_CLKSTOP_GSCL_SYS_PWR_REG,
> +       EXYNOS5_CMU_CLKSTOP_ISP_SYS_PWR_REG,
> +       EXYNOS5_CMU_CLKSTOP_G3D_SYS_PWR_REG,
> +       EXYNOS5420_CMU_CLKSTOP_DISP1_SYS_PWR_REG,
> +       EXYNOS5420_CMU_CLKSTOP_MAU_SYS_PWR_REG,
> +       EXYNOS5420_CMU_CLKSTOP_G2D_SYS_PWR_REG,
> +       EXYNOS5420_CMU_CLKSTOP_MSC_SYS_PWR_REG,
> +       EXYNOS5420_CMU_CLKSTOP_FSYS_SYS_PWR_REG,
> +       EXYNOS5420_CMU_CLKSTOP_PSGEN_SYS_PWR_REG,
> +       EXYNOS5420_CMU_CLKSTOP_PERIC_SYS_PWR_REG,
> +       EXYNOS5420_CMU_CLKSTOP_WCORE_SYS_PWR_REG,
> +       EXYNOS5_CMU_SYSCLK_GSCL_SYS_PWR_REG,
> +       EXYNOS5_CMU_SYSCLK_ISP_SYS_PWR_REG,
> +       EXYNOS5_CMU_SYSCLK_G3D_SYS_PWR_REG,
> +       EXYNOS5420_CMU_SYSCLK_DISP1_SYS_PWR_REG,
> +       EXYNOS5420_CMU_SYSCLK_MAU_SYS_PWR_REG,
> +       EXYNOS5420_CMU_SYSCLK_G2D_SYS_PWR_REG,
> +       EXYNOS5420_CMU_SYSCLK_MSC_SYS_PWR_REG,
> +       EXYNOS5420_CMU_SYSCLK_FSYS_SYS_PWR_REG,
> +       EXYNOS5420_CMU_SYSCLK_FSYS2_SYS_PWR_REG,
> +       EXYNOS5420_CMU_SYSCLK_PSGEN_SYS_PWR_REG,
> +       EXYNOS5420_CMU_SYSCLK_PERIC_SYS_PWR_REG,
> +       EXYNOS5420_CMU_SYSCLK_WCORE_SYS_PWR_REG,
> +       EXYNOS5420_CMU_RESET_FSYS2_SYS_PWR_REG,
> +       EXYNOS5420_CMU_RESET_PSGEN_SYS_PWR_REG,
> +       EXYNOS5420_CMU_RESET_PERIC_SYS_PWR_REG,
> +       EXYNOS5420_CMU_RESET_WCORE_SYS_PWR_REG,
> +       EXYNOS5_CMU_RESET_GSCL_SYS_PWR_REG,
> +       EXYNOS5_CMU_RESET_ISP_SYS_PWR_REG,
> +       EXYNOS5_CMU_RESET_G3D_SYS_PWR_REG,
> +       EXYNOS5420_CMU_RESET_DISP1_SYS_PWR_REG,
> +       EXYNOS5420_CMU_RESET_MAU_SYS_PWR_REG,
> +       EXYNOS5420_CMU_RESET_G2D_SYS_PWR_REG,
> +       EXYNOS5420_CMU_RESET_MSC_SYS_PWR_REG,
> +       EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG,
> +};
> +
> +static void exynos5_power_off(void)
> +{
> +       unsigned int tmp;
> +
> +       pr_info("Power down.\n");
> +       regmap_read(pmu_context->pmu_regmap, EXYNOS_PS_HOLD_CONTROL, &tmp);
> +       tmp ^= (1 << 8);
> +       regmap_write(pmu_context->pmu_regmap, EXYNOS_PS_HOLD_CONTROL, tmp);
> +
> +       /* Wait a little so we don't give a false warning below */
> +       mdelay(100);
> +
> +       pr_err("Power down failed, please power off system manually.\n");
> +       while (1)
> +               ;
> +}
> +
> +/*
> + * exynos_set_core_flag - set the cluster id to IROM register
> + *                       to ensure that we wake up with the
> + *                       current cluster.
> + */
> +static void exynos5420_set_core_flag(void)
> +{
> +       unsigned int this_cluster;
> +       this_cluster = MPIDR_AFFINITY_LEVEL(read_cpuid_mpidr(), 1);
> +
> +       regmap_write(pmu_context->pmu_regmap, EXYNOS_IROM_DATA2, this_cluster);
> +}
> +
> +void exynos5420_powerdown_conf(enum sys_powerdown mode)
> +{
> +       exynos5420_set_core_flag();
> +}
>  void exynos5_powerdown_conf(enum sys_powerdown mode)
>  {
>         unsigned int i;
> @@ -429,6 +670,80 @@ static void exynos5250_pmu_init(void)
>         regmap_write(pmu_regmap, EXYNOS5_MASK_WDTRESET_REQUEST, tmp);
>  }
>
> +static void exynos5420_pmu_init(void)
> +{
> +       unsigned int value;
> +       int i;
> +
> +       /*
> +        * Set the CMU_RESET, CMU_SYSCLK and CMU_CLKSTOP registers
> +        * for local power blocks to Low initially as per Table 8-4:
> +        * "System-Level Power-Down Configuration Registers".
> +        */
> +       for (i = 0; i < ARRAY_SIZE(exynos5420_list_disable_pmu_reg); i++)
> +               regmap_write(pmu_context->pmu_regmap,
> +                       exynos5420_list_disable_pmu_reg[i], 0);
> +
> +       /* Time taken to stabilized XXTI clock */
> +       regmap_write(pmu_context->pmu_regmap, EXYNOS5_XXTI_DURATION3, 0x005dc);
> +
There is no good reason why XXTI_DURATION3 need to be set here. This
is something that iROM sets, please remove this.

> +       /* Enable USE_STANDBY_WFI for all CORE */
> +       regmap_write(pmu_context->pmu_regmap, S5P_CENTRAL_SEQ_OPTION,
> +               EXYNOS5420_USE_STANDBY_WFI_ALL);
> +
> +       regmap_read(pmu_context->pmu_regmap, EXYNOS_L2_OPTION(0), &value);
> +       value &= ~EXYNOS5_USE_RETENTION;
> +       regmap_write(pmu_context->pmu_regmap, EXYNOS_L2_OPTION(0), value);
> +
> +       regmap_read(pmu_context->pmu_regmap, EXYNOS_L2_OPTION(1), &value);
> +       value &= ~EXYNOS5_USE_RETENTION;
> +       regmap_write(pmu_context->pmu_regmap, EXYNOS_L2_OPTION(1), value);
> +
> +       /*
> +        * If L2_COMMON is turned off, clocks related to ATB async
> +        * bridge are gated. Thus, when ISP power is gated, LPI
> +        * may get stuck.
> +        */
> +       regmap_read(pmu_context->pmu_regmap, EXYNOS5420_LPI_MASK, &value);
> +       value |= EXYNOS5420_ATB_ISP_ARM;
> +       regmap_write(pmu_context->pmu_regmap, EXYNOS5420_LPI_MASK, value);
> +       regmap_read(pmu_context->pmu_regmap, EXYNOS5420_LPI_MASK1, &value);
> +       value |= EXYNOS5420_ATB_KFC;
> +       regmap_write(pmu_context->pmu_regmap, EXYNOS5420_LPI_MASK1, value);
> +
> +       /* Prevent issue of new bus request from L2 memory */
> +       regmap_read(pmu_context->pmu_regmap, EXYNOS5420_ARM_COMMON_OPTION,
> +                                               &value);
> +       value |= EXYNOS5_SKIP_DEACTIVATE_ACEACP_IN_PWDN;
> +       regmap_write(pmu_context->pmu_regmap, EXYNOS5420_ARM_COMMON_OPTION,
> +                                               value);
> +       regmap_read(pmu_context->pmu_regmap, EXYNOS5420_KFC_COMMON_OPTION,
> +                                               &value);
> +       value |= EXYNOS5_SKIP_DEACTIVATE_ACEACP_IN_PWDN;
> +       regmap_write(pmu_context->pmu_regmap, EXYNOS5420_KFC_COMMON_OPTION,
> +                                               value);
> +
> +       /*
> +        * This setting is to reduce suspend/resume time.
> +        */
> +       regmap_write(pmu_context->pmu_regmap,
> +                       EXYNOS5420_LOGIC_RESET_DURATION3,
> +                       DUR_WAIT_RESET);
> +
> +       /* Serialized CPU wakeup of Eagle */
> +       regmap_write(pmu_context->pmu_regmap,
> +                       EXYNOS5420_ARM_INTR_SPREAD_ENABLE,
> +                       SPREAD_ENABLE);
> +       regmap_write(pmu_context->pmu_regmap,
> +                       EXYNOS5420_ARM_INTR_SPREAD_USE_STANDBYWFI,
> +                       SPREAD_USE_STANDWFI);
> +
> +       regmap_write(pmu_context->pmu_regmap, EXYNOS5420_UP_SCHEDULER, 0x1);
> +
> +       pm_power_off = exynos5_power_off;
> +       pr_info("EXYNOS5420 PMU Initialize\n");
> +}
> +
>  static struct exynos_pmu_data exynos4210_pmu_data = {
>         .pmu_config     = exynos4210_pmu_config,
>  };
> @@ -448,6 +763,12 @@ static struct exynos_pmu_data exynos5250_pmu_data = {
>         .powerdown_conf = exynos5_powerdown_conf,
>  };
>
> +static struct exynos_pmu_data exynos5420_pmu_data = {
> +       .pmu_config     = exynos5420_pmu_config,
> +       .pmu_init       = exynos5420_pmu_init,
> +       .powerdown_conf = exynos5420_powerdown_conf,
> +};
> +
>  /*
>   * PMU platform driver and devicetree bindings.
>   */
> @@ -468,6 +789,10 @@ static struct of_device_id exynos_pmu_of_device_ids[] = {
>                 .compatible = "samsung,exynos5250-pmu",
>                 .data = (void *)&exynos5250_pmu_data,
>         },
> +       {
> +               .compatible = "samsung,exynos5420-pmu",
> +               .data = (void *)&exynos5420_pmu_data,
> +       },
>         {},
>  };
>
> diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
> index 54798e9..39a8300 100644
> --- a/arch/arm/mach-exynos/regs-pmu.h
> +++ b/arch/arm/mach-exynos/regs-pmu.h
> @@ -36,6 +36,7 @@
>  #define S5P_INFORM6                            (0x0818)
>  #define S5P_INFORM7                            (0x081C)
>
> +#define EXYNOS_IROM_DATA2                      (0x0988)
>  #define S5P_ARM_CORE0_LOWPWR                   (0x1000)
>  #define S5P_DIS_IRQ_CORE0                      (0x1004)
>  #define S5P_DIS_IRQ_CENTRAL0                   (0x1008)
> @@ -105,6 +106,42 @@
>  #define S5P_ARM_CORE1_CONFIGURATION            (0x2080)
>  #define S5P_ARM_CORE1_STATUS                   (0x2084)
>
> +#define EXYNOS_ARM_CORE_OPTION(_nr)            (S5P_ARM_CORE0_OPTION \
> +                                               + ((_nr) * 0x80))
> +#define EXYNOS_ARM_CORE_STATUS(_nr)            (S5P_ARM_CORE0_STATUS \
> +                                               + ((_nr) * 0x80))
> +#define EXYNOS_ARM_CORE_CONFIGURATION(_nr)     \
> +                       (S5P_ARM_CORE0_CONFIGURATION + ((_nr) * 0x80))
> +#define EXYNOS_CORE_LOCAL_PWR_EN               0x3
> +
> +#define EXYNOS_ARM_COMMON_CONFIGURATION                (0x2500)
> +#define EXYNOS_ARM_COMMON_STATUS               (0x2504)
> +#define EXYNOS_COMMON_CONFIGURATION(_nr)       \
> +                       (EXYNOS_ARM_COMMON_CONFIGURATION + ((_nr) * 0x80))
> +#define EXYNOS_COMMON_STATUS(_nr)              \
> +                       (EXYNOS_COMMON_CONFIGURATION(_nr) + 0x4)
> +#define EXYNOS_COMMON_OPTION(_nr)              \
> +                       (EXYNOS_COMMON_CONFIGURATION(_nr) + 0x8)
> +
> +#define EXYNOS_ARM_L2_CONFIGURATION            (0x2600)
> +#define EXYNOS_L2_CONFIGURATION(_nr)           \
> +                       (EXYNOS_ARM_L2_CONFIGURATION + ((_nr) * 0x80))
> +#define EXYNOS_L2_STATUS(_nr)                  \
> +                       (EXYNOS_L2_CONFIGURATION(_nr) + 0x4)
> +#define EXYNOS_L2_OPTION(_nr)                  \
> +                       (EXYNOS_L2_CONFIGURATION(_nr) + 0x8)
> +#define EXYNOS_L2_COMMON_PWR_EN                        0x3
> +
> +#define EXYNOS_ARM_CORE_X_STATUS_OFFSET                0x4
> +
> +#define EXYNOS5_APLL_SYSCLK_CONFIGURATION      (0x2A00)
> +#define EXYNOS5_APLL_SYSCLK_STATUS             (0x2A04)
> +
> +#define EXYNOS5_ARM_L2_OPTION                  (0x2608)
> +#define EXYNOS5_USE_RETENTION                  BIT(4)
> +
> +#define EXYNOS5_L2RSTDISABLE_VALUE             (1 << 3)
> +
>  #define S5P_PAD_RET_MAUDIO_OPTION              (0x3028)
>  #define S5P_PAD_RET_GPIO_OPTION                        (0x3108)
>  #define S5P_PAD_RET_UART_OPTION                        (0x3128)
> @@ -177,6 +214,7 @@
>  #define EXYNOS5_AUTO_WDTRESET_DISABLE                          (0x0408)
>  #define EXYNOS5_MASK_WDTRESET_REQUEST                          (0x040C)
>
> +#define EXYNOS5_USE_RETENTION                  BIT(4)
>  #define EXYNOS5_SYS_WDTRESET                                   (1 << 20)
>
>  #define EXYNOS5_ARM_CORE0_SYS_PWR_REG                          (0x1000)
> @@ -305,4 +343,197 @@
>
>  #define EXYNOS5_OPTION_USE_RETENTION                           (1 << 4)
>
> +/* Only for EXYNOS5420 */
> +#define EXYNOS5420_ISP_ARM_OPTION                              0x2488
> +#define EXYNOS5420_L2RSTDISABLE_VALUE                          BIT(3)
> +
> +#define EXYNOS5420_LPI_MASK                                    0x0004
> +#define EXYNOS5420_LPI_MASK1                                   0x0008
> +#define EXYNOS5420_UFS                                         BIT(8)
> +#define EXYNOS5420_ATB_KFC                                     BIT(13)
> +#define EXYNOS5420_ATB_ISP_ARM                                 BIT(19)
> +#define EXYNOS5420_EMULATION                                   BIT(31)
> +#define ATB_ISP_ARM                                            BIT(12)
> +#define ATB_KFC                                                        BIT(13)
> +#define ATB_NOC                                                        BIT(14)
> +
> +#define EXYNOS5420_ARM_INTR_SPREAD_ENABLE                      0x0100
> +#define EXYNOS5420_ARM_INTR_SPREAD_USE_STANDBYWFI              0x0104
> +#define EXYNOS5420_UP_SCHEDULER                                        0x0120
> +#define SPREAD_ENABLE                                          0xF
> +#define SPREAD_USE_STANDWFI                                    0xF
> +
> +#define EXYNOS5420_BB_CON1                                     0x0784
> +#define EXYNOS5420_BB_SEL_EN                                   BIT(31)
> +#define EXYNOS5420_BB_PMOS_EN                                  BIT(7)
> +#define EXYNOS5420_BB_1300X                                    0XF
> +
> +#define EXYNOS5420_ARM_CORE2_SYS_PWR_REG                       0x1020
> +#define EXYNOS5420_DIS_IRQ_ARM_CORE2_LOCAL_SYS_PWR_REG         0x1024
> +#define EXYNOS5420_DIS_IRQ_ARM_CORE2_CENTRAL_SYS_PWR_REG       0x1028
> +#define EXYNOS5420_ARM_CORE3_SYS_PWR_REG                       0x1030
> +#define EXYNOS5420_DIS_IRQ_ARM_CORE3_LOCAL_SYS_PWR_REG         0x1034
> +#define EXYNOS5420_DIS_IRQ_ARM_CORE3_CENTRAL_SYS_PWR_REG       0x1038
> +#define EXYNOS5420_KFC_CORE0_SYS_PWR_REG                       0x1040
> +#define EXYNOS5420_DIS_IRQ_KFC_CORE0_LOCAL_SYS_PWR_REG         0x1044
> +#define EXYNOS5420_DIS_IRQ_KFC_CORE0_CENTRAL_SYS_PWR_REG       0x1048
> +#define EXYNOS5420_KFC_CORE1_SYS_PWR_REG                       0x1050
> +#define EXYNOS5420_DIS_IRQ_KFC_CORE1_LOCAL_SYS_PWR_REG         0x1054
> +#define EXYNOS5420_DIS_IRQ_KFC_CORE1_CENTRAL_SYS_PWR_REG       0x1058
> +#define EXYNOS5420_KFC_CORE2_SYS_PWR_REG                       0x1060
> +#define EXYNOS5420_DIS_IRQ_KFC_CORE2_LOCAL_SYS_PWR_REG         0x1064
> +#define EXYNOS5420_DIS_IRQ_KFC_CORE2_CENTRAL_SYS_PWR_REG       0x1068
> +#define EXYNOS5420_KFC_CORE3_SYS_PWR_REG                       0x1070
> +#define EXYNOS5420_DIS_IRQ_KFC_CORE3_LOCAL_SYS_PWR_REG         0x1074
> +#define EXYNOS5420_DIS_IRQ_KFC_CORE3_CENTRAL_SYS_PWR_REG       0x1078
> +#define EXYNOS5420_ISP_ARM_SYS_PWR_REG                         0x1090
> +#define EXYNOS5420_DIS_IRQ_ISP_ARM_LOCAL_SYS_PWR_REG           0x1094
> +#define EXYNOS5420_DIS_IRQ_ISP_ARM_CENTRAL_SYS_PWR_REG         0x1098
> +#define EXYNOS5420_ARM_COMMON_SYS_PWR_REG                      0x10A0
> +#define EXYNOS5420_KFC_COMMON_SYS_PWR_REG                      0x10B0
> +#define EXYNOS5420_KFC_L2_SYS_PWR_REG                          0x10D0
> +#define EXYNOS5420_DPLL_SYSCLK_SYS_PWR_REG                     0x1158
> +#define EXYNOS5420_IPLL_SYSCLK_SYS_PWR_REG                     0x115C
> +#define EXYNOS5420_KPLL_SYSCLK_SYS_PWR_REG                     0x1160
> +#define EXYNOS5420_RPLL_SYSCLK_SYS_PWR_REG                      0x1174
> +#define EXYNOS5420_SPLL_SYSCLK_SYS_PWR_REG                      0x1178
> +#define EXYNOS5420_INTRAM_MEM_SYS_PWR_REG                       0x11B8
> +#define EXYNOS5420_INTROM_MEM_SYS_PWR_REG                       0x11BC
> +#define EXYNOS5420_ONENANDXL_MEM_SYS_PWR                       0x11C0
> +#define EXYNOS5420_USBDEV_MEM_SYS_PWR                          0x11CC
> +#define EXYNOS5420_USBDEV1_MEM_SYS_PWR                         0x11D0
> +#define EXYNOS5420_SDMMC_MEM_SYS_PWR                           0x11D4
> +#define EXYNOS5420_CSSYS_MEM_SYS_PWR                           0x11D8
> +#define EXYNOS5420_SECSS_MEM_SYS_PWR                           0x11DC
> +#define EXYNOS5420_ROTATOR_MEM_SYS_PWR                         0x11E0
> +#define EXYNOS5420_INTRAM_MEM_SYS_PWR                          0x11E4
> +#define EXYNOS5420_INTROM_MEM_SYS_PWR                          0x11E8
> +#define EXYNOS5420_PAD_RETENTION_JTAG_SYS_PWR_REG              0x1208
> +#define EXYNOS5420_PAD_RETENTION_DRAM_SYS_PWR_REG              0x1210
> +#define EXYNOS5420_PAD_RETENTION_UART_SYS_PWR_REG              0x1214
> +#define EXYNOS5420_PAD_RETENTION_MMC0_SYS_PWR_REG              0x1218
> +#define EXYNOS5420_PAD_RETENTION_MMC1_SYS_PWR_REG              0x121C
> +#define EXYNOS5420_PAD_RETENTION_MMC2_SYS_PWR_REG              0x1220
> +#define EXYNOS5420_PAD_RETENTION_HSI_SYS_PWR_REG               0x1224
> +#define EXYNOS5420_PAD_RETENTION_EBIA_SYS_PWR_REG              0x1228
> +#define EXYNOS5420_PAD_RETENTION_EBIB_SYS_PWR_REG              0x122C
> +#define EXYNOS5420_PAD_RETENTION_SPI_SYS_PWR_REG               0x1230
> +#define EXYNOS5420_PAD_RETENTION_DRAM_COREBLK_SYS_PWR_REG      0x1234
> +#define EXYNOS5420_DISP1_SYS_PWR_REG                           0x1410
> +#define EXYNOS5420_MAU_SYS_PWR_REG                             0x1414
> +#define EXYNOS5420_G2D_SYS_PWR_REG                             0x1418
> +#define EXYNOS5420_MSC_SYS_PWR_REG                             0x141C
> +#define EXYNOS5420_FSYS_SYS_PWR_REG                            0x1420
> +#define EXYNOS5420_FSYS2_SYS_PWR_REG                           0x1424
> +#define EXYNOS5420_PSGEN_SYS_PWR_REG                           0x1428
> +#define EXYNOS5420_PERIC_SYS_PWR_REG                           0x142C
> +#define EXYNOS5420_WCORE_SYS_PWR_REG                           0x1430
> +#define EXYNOS5420_CMU_CLKSTOP_DISP1_SYS_PWR_REG               0x1490
> +#define EXYNOS5420_CMU_CLKSTOP_MAU_SYS_PWR_REG                 0x1494
> +#define EXYNOS5420_CMU_CLKSTOP_G2D_SYS_PWR_REG                 0x1498
> +#define EXYNOS5420_CMU_CLKSTOP_MSC_SYS_PWR_REG                 0x149C
> +#define EXYNOS5420_CMU_CLKSTOP_FSYS_SYS_PWR_REG                        0x14A0
> +#define EXYNOS5420_CMU_CLKSTOP_FSYS2_SYS_PWR_REG               0x14A4
> +#define EXYNOS5420_CMU_CLKSTOP_PSGEN_SYS_PWR_REG               0x14A8
> +#define EXYNOS5420_CMU_CLKSTOP_PERIC_SYS_PWR_REG               0x14AC
> +#define EXYNOS5420_CMU_CLKSTOP_WCORE_SYS_PWR_REG               0x14B0
> +#define EXYNOS5420_CMU_SYSCLK_TOPPWR_SYS_PWR_REG               0x14BC
> +#define EXYNOS5420_CMU_SYSCLK_DISP1_SYS_PWR_REG                        0x14D0
> +#define EXYNOS5420_CMU_SYSCLK_MAU_SYS_PWR_REG                  0x14D4
> +#define EXYNOS5420_CMU_SYSCLK_G2D_SYS_PWR_REG                  0x14D8
> +#define EXYNOS5420_CMU_SYSCLK_MSC_SYS_PWR_REG                  0x14DC
> +#define EXYNOS5420_CMU_SYSCLK_FSYS_SYS_PWR_REG                 0x14E0
> +#define EXYNOS5420_CMU_SYSCLK_FSYS2_SYS_PWR_REG                        0x14E4
> +#define EXYNOS5420_CMU_SYSCLK_PSGEN_SYS_PWR_REG                        0x14E8
> +#define EXYNOS5420_CMU_SYSCLK_PERIC_SYS_PWR_REG                        0x14EC
> +#define EXYNOS5420_CMU_SYSCLK_WCORE_SYS_PWR_REG                        0x14F0
> +#define EXYNOS5420_CMU_SYSCLK_SYSMEM_TOPPWR_SYS_PWR_REG                0x14F4
> +#define EXYNOS5420_CMU_RESET_FSYS2_SYS_PWR_REG                 0x1570
> +#define EXYNOS5420_CMU_RESET_PSGEN_SYS_PWR_REG                 0x1574
> +#define EXYNOS5420_CMU_RESET_PERIC_SYS_PWR_REG                 0x1578
> +#define EXYNOS5420_CMU_RESET_WCORE_SYS_PWR_REG                 0x157C
> +#define EXYNOS5420_CMU_RESET_DISP1_SYS_PWR_REG                 0x1590
> +#define EXYNOS5420_CMU_RESET_MAU_SYS_PWR_REG                   0x1594
> +#define EXYNOS5420_CMU_RESET_G2D_SYS_PWR_REG                   0x1598
> +#define EXYNOS5420_CMU_RESET_MSC_SYS_PWR_REG                   0x159C
> +#define EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG                  0x15A0
> +#define EXYNOS5420_SFR_AXI_CGDIS1                              0x15E4
> +#define EXYNOS_ARM_CORE2_CONFIGURATION                         0x2100
> +#define EXYNOS5420_ARM_CORE2_OPTION                            0x2108
> +#define EXYNOS_ARM_CORE3_CONFIGURATION                         0x2180
> +#define EXYNOS5420_ARM_CORE3_OPTION                            0x2188
> +#define EXYNOS5420_ARM_COMMON_STATUS                           0x2504
> +#define EXYNOS5420_ARM_COMMON_OPTION                           0x2508
> +#define EXYNOS5420_KFC_COMMON_STATUS                           0x2584
> +#define EXYNOS5420_KFC_COMMON_OPTION                           0x2588
> +#define EXYNOS5420_LOGIC_RESET_DURATION3                       0x2D1C
> +
> +#define EXYNOS5420_PAD_RET_GPIO_OPTION                         0x30C8
> +#define EXYNOS5420_PAD_RET_UART_OPTION                         0x30E8
> +#define EXYNOS5420_PAD_RET_MMCA_OPTION                         0x3108
> +#define EXYNOS5420_PAD_RET_MMCB_OPTION                         0x3128
> +#define EXYNOS5420_PAD_RET_MMCC_OPTION                         0x3148
> +#define EXYNOS5420_PAD_RET_HSI_OPTION                          0x3168
> +#define EXYNOS5420_PAD_RET_SPI_OPTION                          0x31C8
> +#define EXYNOS5420_PAD_RET_DRAM_COREBLK_OPTION                 0x31E8
> +#define EXYNOS_PAD_RET_DRAM_OPTION                             0x3008
> +#define EXYNOS_PAD_RET_MAUDIO_OPTION                           0x3028
> +#define EXYNOS_PAD_RET_JTAG_OPTION                             0x3048
> +#define EXYNOS_PAD_RET_GPIO_OPTION                             0x3108
> +#define EXYNOS_PAD_RET_UART_OPTION                             0x3128
> +#define EXYNOS_PAD_RET_MMCA_OPTION                             0x3148
> +#define EXYNOS_PAD_RET_MMCB_OPTION                             0x3168
> +#define EXYNOS_PAD_RET_EBIA_OPTION                             0x3188
> +#define EXYNOS_PAD_RET_EBIB_OPTION                             0x31A8
> +
> +#define EXYNOS_PS_HOLD_CONTROL                                 0x330C
> +#define EXYNOS5_XXTI_DURATION3                                 0x343C
> +
> +/* For SYS_PWR_REG */
> +#define EXYNOS_SYS_PWR_CFG                                     BIT(0)
> +
> +#define EXYNOS5420_MFC_CONFIGURATION                           0x4060
> +#define EXYNOS5420_MFC_STATUS                                  0x4064
> +#define EXYNOS5420_MFC_OPTION                                  0x4068
> +#define EXYNOS5420_G3D_CONFIGURATION                           0x4080
> +#define EXYNOS5420_G3D_STATUS                                  0x4084
> +#define EXYNOS5420_G3D_OPTION                                  0x4088
> +#define EXYNOS5420_DISP0_CONFIGURATION                         0x40A0
> +#define EXYNOS5420_DISP0_STATUS                                        0x40A4
> +#define EXYNOS5420_DISP0_OPTION                                        0x40A8
> +#define EXYNOS5420_DISP1_CONFIGURATION                         0x40C0
> +#define EXYNOS5420_DISP1_STATUS                                        0x40C4
> +#define EXYNOS5420_DISP1_OPTION                                        0x40C8
> +#define EXYNOS5420_MAU_CONFIGURATION                           0x40E0
> +#define EXYNOS5420_MAU_STATUS                                  0x40E4
> +#define EXYNOS5420_MAU_OPTION                                  0x40E8
> +#define EXYNOS5420_FSYS2_OPTION                                        0x4168
> +#define EXYNOS5420_PSGEN_OPTION                                        0x4188
> +
> +/* For EXYNOS_CENTRAL_SEQ_OPTION */
> +#define EXYNOS5_USE_STANDBYWFI_ARM_CORE0                       BIT(16)
> +#define EXYNOS5_USE_STANDBYWFI_ARM_CORE1                       BUT(17)
> +#define EXYNOS5_USE_STANDBYWFE_ARM_CORE0                       BIT(24)
> +#define EXYNOS5_USE_STANDBYWFE_ARM_CORE1                       BIT(25)
> +
> +#define EXYNOS5420_ARM_USE_STANDBY_WFI0                                BIT(4)
> +#define EXYNOS5420_ARM_USE_STANDBY_WFI1                                BIT(5)
> +#define EXYNOS5420_ARM_USE_STANDBY_WFI2                                BIT(6)
> +#define EXYNOS5420_ARM_USE_STANDBY_WFI3                                BIT(7)
> +#define EXYNOS5420_KFC_USE_STANDBY_WFI0                                BIT(8)
> +#define EXYNOS5420_KFC_USE_STANDBY_WFI1                                BIT(9)
> +#define EXYNOS5420_KFC_USE_STANDBY_WFI2                                BIT(10)
> +#define EXYNOS5420_KFC_USE_STANDBY_WFI3                                BIT(11)
> +#define EXYNOS5420_ARM_USE_STANDBY_WFE0                                BIT(16)
> +#define EXYNOS5420_ARM_USE_STANDBY_WFE1                                BIT(17)
> +#define EXYNOS5420_ARM_USE_STANDBY_WFE2                                BIT(18)
> +#define EXYNOS5420_ARM_USE_STANDBY_WFE3                                BIT(19)
> +#define EXYNOS5420_KFC_USE_STANDBY_WFE0                                BIT(20)
> +#define EXYNOS5420_KFC_USE_STANDBY_WFE1                                BIT(21)
> +#define EXYNOS5420_KFC_USE_STANDBY_WFE2                                BIT(22)
> +#define EXYNOS5420_KFC_USE_STANDBY_WFE3                                BIT(23)
> +
> +#define DUR_WAIT_RESET                         0xF
> +
> +
>  #endif /* __ASM_ARCH_REGS_PMU_H */
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Regards,
Alim
