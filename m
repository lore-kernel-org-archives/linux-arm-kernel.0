From: sajjan.linux@gmail.com (Vikas Sajjan)
Date: Mon, 28 Apr 2014 18:06:51 +0530
Subject: [PATCH V2 1/3] ARM: EXYNOS5: Add PMU settings for exynos5420
In-Reply-To: <534D812C.7070808@gmail.com>
References: <1395900785-11334-1-git-send-email-vikas.sajjan@samsung.com>
 <1395900785-11334-2-git-send-email-vikas.sajjan@samsung.com>
 <534D812C.7070808@gmail.com>
Message-ID: <CAGm_ybgUL_CSzrU+pqH=n0QEQqbt8QmGjA0MyqA9fJDupFpJfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Wed, Apr 16, 2014 at 12:27 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Vikas,
>
> Basically the same comments apply as for the series:
>
> [PATCH v2 0/3] Add initial support of PMU for exynos5260
> (https://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg27339.html)
>
> In addition to above, please see some comments inline.
>
>
> On 27.03.2014 07:13, Vikas Sajjan wrote:
>>
>> Add intial PMU settings for exynos5420. This is required for
>> future S2R and Switching support.
>>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
>> ---
>>   arch/arm/mach-exynos/common.h   |   10 ++
>>   arch/arm/mach-exynos/pmu.c      |  307
>> +++++++++++++++++++++++++++++++++++++++
>>   arch/arm/mach-exynos/regs-pmu.h |  228 +++++++++++++++++++++++++++++
>>   3 files changed, 545 insertions(+)
>>
>> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
>> index 9ef3f83..347afc2 100644
>> --- a/arch/arm/mach-exynos/common.h
>> +++ b/arch/arm/mach-exynos/common.h
>> @@ -15,6 +15,16 @@
>>   #include <linux/reboot.h>
>>   #include <linux/of.h>
>>
>> +#define EXYNOS5420_USE_STANDBY_WFI_ALL (EXYNOS5420_ARM_USE_STANDBY_WFI0
>> \
>> +                                        | EXYNOS5420_ARM_USE_STANDBY_WFI1
>> \
>> +                                        | EXYNOS5420_ARM_USE_STANDBY_WFI2
>> \
>> +                                        | EXYNOS5420_ARM_USE_STANDBY_WFI3
>> \
>> +                                        | EXYNOS5420_KFC_USE_STANDBY_WFI0
>> \
>> +                                        | EXYNOS5420_KFC_USE_STANDBY_WFI1
>> \
>> +                                        | EXYNOS5420_KFC_USE_STANDBY_WFI2
>> \
>> +                                        |
>> EXYNOS5420_KFC_USE_STANDBY_WFI3)
>> +
>> +
>>   void mct_init(void __iomem *base, int irq_g0, int irq_l0, int irq_l1);
>>
>>   struct map_desc;
>> diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
>> index 05c7ce1..f69a6ed 100644
>> --- a/arch/arm/mach-exynos/pmu.c
>> +++ b/arch/arm/mach-exynos/pmu.c
>> @@ -12,9 +12,14 @@
>>   #include <linux/io.h>
>>   #include <linux/kernel.h>
>>   #include <linux/bug.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/delay.h>
>> +#include <linux/pm.h>
>>
>>   #include <plat/cpu.h>
>>
>> +#include <asm/cputype.h>
>> +
>>   #include "common.h"
>>   #include "regs-pmu.h"
>>
>> @@ -318,6 +323,212 @@ static const struct exynos_pmu_conf
>> exynos5250_pmu_config[] = {
>>         { PMU_TABLE_END,},
>>   };
>>
>> +static const struct exynos_pmu_conf exynos5420_pmu_config[] = {
>> +       /* { .reg = address, .val = { AFTR, LPA, SLEEP } */
>> +       { EXYNOS5_ARM_CORE0_SYS_PWR_REG,                        { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5_DIS_IRQ_ARM_CORE0_LOCAL_SYS_PWR_REG,          { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5_DIS_IRQ_ARM_CORE0_CENTRAL_SYS_PWR_REG,        { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5_ARM_CORE1_SYS_PWR_REG,                        { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5_DIS_IRQ_ARM_CORE1_LOCAL_SYS_PWR_REG,          { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5_DIS_IRQ_ARM_CORE1_CENTRAL_SYS_PWR_REG,        { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_ARM_CORE2_SYS_PWR_REG,                     { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_DIS_IRQ_ARM_CORE2_LOCAL_SYS_PWR_REG,       { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_DIS_IRQ_ARM_CORE2_CENTRAL_SYS_PWR_REG,     { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_ARM_CORE3_SYS_PWR_REG,                     { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_DIS_IRQ_ARM_CORE3_LOCAL_SYS_PWR_REG,       { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_DIS_IRQ_ARM_CORE3_CENTRAL_SYS_PWR_REG,     { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_KFC_CORE0_SYS_PWR_REG,                     { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_DIS_IRQ_KFC_CORE0_LOCAL_SYS_PWR_REG,       { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_DIS_IRQ_KFC_CORE0_CENTRAL_SYS_PWR_REG,     { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_KFC_CORE1_SYS_PWR_REG,                     { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_DIS_IRQ_KFC_CORE1_LOCAL_SYS_PWR_REG,       { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_DIS_IRQ_KFC_CORE1_CENTRAL_SYS_PWR_REG,     { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_KFC_CORE2_SYS_PWR_REG,                     { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_DIS_IRQ_KFC_CORE2_LOCAL_SYS_PWR_REG,       { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_DIS_IRQ_KFC_CORE2_CENTRAL_SYS_PWR_REG,     { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_KFC_CORE3_SYS_PWR_REG,                     { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_DIS_IRQ_KFC_CORE3_LOCAL_SYS_PWR_REG,       { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_DIS_IRQ_KFC_CORE3_CENTRAL_SYS_PWR_REG,     { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5_ISP_ARM_SYS_PWR_REG,                          { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5_DIS_IRQ_ISP_ARM_LOCAL_SYS_PWR_REG,            { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5_DIS_IRQ_ISP_ARM_CENTRAL_SYS_PWR_REG,          { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_ARM_COMMON_SYS_PWR_REG,                    { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_KFC_COMMON_SYS_PWR_REG,                    { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5_ARM_L2_SYS_PWR_REG,                           { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_KFC_L2_SYS_PWR_REG,                        { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5_CMU_ACLKSTOP_SYS_PWR_REG,                     { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5_CMU_SCLKSTOP_SYS_PWR_REG,                     { 0x1,
>> 0x0, 0x1} },
>> +       { EXYNOS5_CMU_RESET_SYS_PWR_REG,                        { 0x1,
>> 0x1, 0x0} },
>> +       { EXYNOS5_CMU_ACLKSTOP_SYSMEM_SYS_PWR_REG,              { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5_CMU_SCLKSTOP_SYSMEM_SYS_PWR_REG,              { 0x1,
>> 0x0, 0x1} },
>> +       { EXYNOS5_CMU_RESET_SYSMEM_SYS_PWR_REG,                 { 0x1,
>> 0x1, 0x0} },
>> +       { EXYNOS5_DRAM_FREQ_DOWN_SYS_PWR_REG,                   { 0x1,
>> 0x0, 0x1} },
>> +       { EXYNOS5_DDRPHY_DLLOFF_SYS_PWR_REG,                    { 0x1,
>> 0x1, 0x1} },
>> +       { EXYNOS5_DDRPHY_DLLLOCK_SYS_PWR_REG,                   { 0x1,
>> 0x0, 0x1} },
>> +       { EXYNOS5_APLL_SYSCLK_SYS_PWR_REG,                      { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5_MPLL_SYSCLK_SYS_PWR_REG,                      { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5_VPLL_SYSCLK_SYS_PWR_REG,                      { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5_EPLL_SYSCLK_SYS_PWR_REG,                      { 0x1,
>> 0x1, 0x0} },
>> +       { EXYNOS5_BPLL_SYSCLK_SYS_PWR_REG,                      { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5_CPLL_SYSCLK_SYS_PWR_REG,                      { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_DPLL_SYSCLK_SYS_PWR_REG,                   { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_IPLL_SYSCLK_SYS_PWR_REG,                   { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_KPLL_SYSCLK_SYS_PWR_REG,                   { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5_MPLLUSER_SYSCLK_SYS_PWR_REG,                  { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5_BPLLUSER_SYSCLK_SYS_PWR_REG,                  { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_RPLL_SYSCLK_SYS_PWR_REG,                   { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_SPLL_SYSCLK_SYS_PWR_REG,                   { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5_TOP_BUS_SYS_PWR_REG,                          { 0x3,
>> 0x0, 0x0} },
>> +       { EXYNOS5_TOP_RETENTION_SYS_PWR_REG,                    { 0x1,
>> 0x1, 0x1} },
>> +       { EXYNOS5_TOP_PWR_SYS_PWR_REG,                          { 0x3,
>> 0x3, 0x0} },
>> +       { EXYNOS5_TOP_BUS_SYSMEM_SYS_PWR_REG,                   { 0x3,
>> 0x0, 0x0} },
>> +       { EXYNOS5_TOP_RETENTION_SYSMEM_SYS_PWR_REG,             { 0x1,
>> 0x0, 0x1} },
>> +       { EXYNOS5_TOP_PWR_SYSMEM_SYS_PWR_REG,                   { 0x3,
>> 0x0, 0x0} },
>> +       { EXYNOS5_LOGIC_RESET_SYS_PWR_REG,                      { 0x1,
>> 0x1, 0x0} },
>> +       { EXYNOS5_OSCCLK_GATE_SYS_PWR_REG,                      { 0x1,
>> 0x0, 0x1} },
>> +       { EXYNOS5_LOGIC_RESET_SYSMEM_SYS_PWR_REG,               { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5_OSCCLK_GATE_SYSMEM_SYS_PWR_REG,               { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_INTRAM_MEM_SYS_PWR_REG,                    { 0x3,
>> 0x0, 0x3} },
>> +       { EXYNOS5420_INTROM_MEM_SYS_PWR_REG,                    { 0x3,
>> 0x0, 0x3} },
>> +       { EXYNOS5_PAD_RETENTION_DRAM_SYS_PWR_REG,               { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5_PAD_RETENTION_MAU_SYS_PWR_REG,                { 0x1,
>> 0x1, 0x0} },
>> +       { EXYNOS5420_PAD_RETENTION_JTAG_SYS_PWR_REG,            { 0x1,
>> 0x1, 0x0} },
>> +       { EXYNOS5420_PAD_RETENTION_DRAM_SYS_PWR_REG,            { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_PAD_RETENTION_UART_SYS_PWR_REG,            { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_PAD_RETENTION_MMC0_SYS_PWR_REG,            { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_PAD_RETENTION_MMC1_SYS_PWR_REG,            { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_PAD_RETENTION_MMC2_SYS_PWR_REG,            { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_PAD_RETENTION_HSI_SYS_PWR_REG,             { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_PAD_RETENTION_EBIA_SYS_PWR_REG,            { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_PAD_RETENTION_EBIB_SYS_PWR_REG,            { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_PAD_RETENTION_SPI_SYS_PWR_REG,             { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_PAD_RETENTION_DRAM_COREBLK_SYS_PWR_REG,    { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5_PAD_ISOLATION_SYS_PWR_REG,                    { 0x1,
>> 0x1, 0x0} },
>> +       { EXYNOS5_PAD_ISOLATION_SYSMEM_SYS_PWR_REG,             { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5_PAD_ALV_SEL_SYS_PWR_REG,                      { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5_XUSBXTI_SYS_PWR_REG,                          { 0x1,
>> 0x1, 0x0} },
>> +       { EXYNOS5_XXTI_SYS_PWR_REG,                             { 0x1,
>> 0x1, 0x0} },
>> +       { EXYNOS5_EXT_REGULATOR_SYS_PWR_REG,                    { 0x1,
>> 0x1, 0x0} },
>> +       { EXYNOS5_GPIO_MODE_SYS_PWR_REG,                        { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5_GPIO_MODE_SYSMEM_SYS_PWR_REG,                 { 0x1,
>> 0x1, 0x0} },
>> +       { EXYNOS5_GPIO_MODE_MAU_SYS_PWR_REG,                    { 0x1,
>> 0x1, 0x0} },
>> +       { EXYNOS5_TOP_ASB_RESET_SYS_PWR_REG,                    { 0x1,
>> 0x1, 0x0} },
>> +       { EXYNOS5_TOP_ASB_ISOLATION_SYS_PWR_REG,                { 0x1,
>> 0x0, 0x0} },
>> +       { EXYNOS5_GSCL_SYS_PWR_REG,                             { 0x7,
>> 0x0, 0x0} },
>> +       { EXYNOS5_ISP_SYS_PWR_REG,                              { 0x7,
>> 0x0, 0x0} },
>> +       { EXYNOS5_MFC_SYS_PWR_REG,                              { 0x7,
>> 0x0, 0x0} },
>> +       { EXYNOS5_G3D_SYS_PWR_REG,                              { 0x7,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_DISP1_SYS_PWR_REG,                         { 0x7,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_MAU_SYS_PWR_REG,                           { 0x7,
>> 0x7, 0x0} },
>> +       { EXYNOS5420_G2D_SYS_PWR_REG,                           { 0x7,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_MSC_SYS_PWR_REG,                           { 0x7,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_FSYS_SYS_PWR_REG,                          { 0x7,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_FSYS2_SYS_PWR_REG,                         { 0x7,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_PSGEN_SYS_PWR_REG,                         { 0x7,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_PERIC_SYS_PWR_REG,                         { 0x7,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_WCORE_SYS_PWR_REG,                         { 0x7,
>> 0x0, 0x0} },
>> +       { EXYNOS5_CMU_CLKSTOP_GSCL_SYS_PWR_REG,                 { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5_CMU_CLKSTOP_ISP_SYS_PWR_REG,                  { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5_CMU_CLKSTOP_MFC_SYS_PWR_REG,                  { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5_CMU_CLKSTOP_G3D_SYS_PWR_REG,                  { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_CLKSTOP_DISP1_SYS_PWR_REG,             { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_CLKSTOP_MAU_SYS_PWR_REG,               { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_CLKSTOP_G2D_SYS_PWR_REG,               { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_CLKSTOP_MSC_SYS_PWR_REG,               { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_CLKSTOP_FSYS_SYS_PWR_REG,              { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_CLKSTOP_PSGEN_SYS_PWR_REG,             { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_CLKSTOP_PERIC_SYS_PWR_REG,             { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_CLKSTOP_WCORE_SYS_PWR_REG,             { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5_CMU_SYSCLK_GSCL_SYS_PWR_REG,                  { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5_CMU_SYSCLK_ISP_SYS_PWR_REG,                   { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5_CMU_SYSCLK_MFC_SYS_PWR_REG,                   { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5_CMU_SYSCLK_G3D_SYS_PWR_REG,                   { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_SYSCLK_DISP1_SYS_PWR_REG,              { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_SYSCLK_MAU_SYS_PWR_REG,                { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_SYSCLK_G2D_SYS_PWR_REG,                { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_SYSCLK_MSC_SYS_PWR_REG,                { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_SYSCLK_FSYS_SYS_PWR_REG,               { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_SYSCLK_FSYS2_SYS_PWR_REG,              { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_SYSCLK_PSGEN_SYS_PWR_REG,              { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_SYSCLK_PERIC_SYS_PWR_REG,              { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_SYSCLK_WCORE_SYS_PWR_REG,              { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_RESET_FSYS2_SYS_PWR_REG,               { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_RESET_PSGEN_SYS_PWR_REG,               { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_RESET_PERIC_SYS_PWR_REG,               { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_RESET_WCORE_SYS_PWR_REG,               { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5_CMU_RESET_GSCL_SYS_PWR_REG,                   { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5_CMU_RESET_ISP_SYS_PWR_REG,                    { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5_CMU_RESET_MFC_SYS_PWR_REG,                    { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5_CMU_RESET_G3D_SYS_PWR_REG,                    { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_RESET_DISP1_SYS_PWR_REG,               { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_RESET_MAU_SYS_PWR_REG,                 { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_RESET_G2D_SYS_PWR_REG,                 { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_RESET_MSC_SYS_PWR_REG,                 { 0x0,
>> 0x0, 0x0} },
>> +       { EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG,                { 0x0,
>> 0x0, 0x0} },
>
>
> style: Lines over 80 characters.
>

Yeah rgiht it reaches 83rd column , but wanted to maintain the readability.

>
>> +       { PMU_TABLE_END,},
>> +};
>> +
>> +void __iomem *exynos5_list_disable_pmu_reg[] = {
>
>
> static void __iomem * const
>
>> +       EXYNOS5_CMU_CLKSTOP_GSCL_SYS_PWR_REG,
>> +       EXYNOS5_CMU_CLKSTOP_ISP_SYS_PWR_REG,
>> +       EXYNOS5_CMU_CLKSTOP_MFC_SYS_PWR_REG,
>> +       EXYNOS5_CMU_CLKSTOP_G3D_SYS_PWR_REG,
>> +       EXYNOS5_CMU_CLKSTOP_DISP1_SYS_PWR_REG,
>> +       EXYNOS5_CMU_CLKSTOP_MAU_SYS_PWR_REG,
>> +       EXYNOS5_CMU_SYSCLK_GSCL_SYS_PWR_REG,
>> +       EXYNOS5_CMU_SYSCLK_ISP_SYS_PWR_REG,
>> +       EXYNOS5_CMU_SYSCLK_MFC_SYS_PWR_REG,
>> +       EXYNOS5_CMU_SYSCLK_G3D_SYS_PWR_REG,
>> +       EXYNOS5_CMU_SYSCLK_DISP1_SYS_PWR_REG,
>> +       EXYNOS5_CMU_SYSCLK_MAU_SYS_PWR_REG,
>> +       EXYNOS5_CMU_RESET_GSCL_SYS_PWR_REG,
>> +       EXYNOS5_CMU_RESET_MFC_SYS_PWR_REG,
>> +       EXYNOS5_CMU_RESET_G3D_SYS_PWR_REG,
>> +       EXYNOS5_CMU_RESET_DISP1_SYS_PWR_REG,
>> +       EXYNOS5_CMU_RESET_MAU_SYS_PWR_REG,
>> +};
>> +
>> +void __iomem *exynos5420_list_disable_pmu_reg[] = {
>
>
> static void __iomem * const
>
>> +       EXYNOS5_CMU_CLKSTOP_GSCL_SYS_PWR_REG,
>> +       EXYNOS5_CMU_CLKSTOP_ISP_SYS_PWR_REG,
>> +       EXYNOS5_CMU_CLKSTOP_MFC_SYS_PWR_REG,
>> +       EXYNOS5_CMU_CLKSTOP_G3D_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_CLKSTOP_DISP1_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_CLKSTOP_MAU_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_CLKSTOP_G2D_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_CLKSTOP_MSC_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_CLKSTOP_FSYS_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_CLKSTOP_PSGEN_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_CLKSTOP_PERIC_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_CLKSTOP_WCORE_SYS_PWR_REG,
>> +       EXYNOS5_CMU_SYSCLK_GSCL_SYS_PWR_REG,
>> +       EXYNOS5_CMU_SYSCLK_ISP_SYS_PWR_REG,
>> +       EXYNOS5_CMU_SYSCLK_MFC_SYS_PWR_REG,
>> +       EXYNOS5_CMU_SYSCLK_G3D_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_SYSCLK_DISP1_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_SYSCLK_MAU_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_SYSCLK_G2D_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_SYSCLK_MSC_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_SYSCLK_FSYS_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_SYSCLK_FSYS2_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_SYSCLK_PSGEN_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_SYSCLK_PERIC_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_SYSCLK_WCORE_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_RESET_FSYS2_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_RESET_PSGEN_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_RESET_PERIC_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_RESET_WCORE_SYS_PWR_REG,
>> +       EXYNOS5_CMU_RESET_GSCL_SYS_PWR_REG,
>> +       EXYNOS5_CMU_RESET_ISP_SYS_PWR_REG,
>> +       EXYNOS5_CMU_RESET_MFC_SYS_PWR_REG,
>> +       EXYNOS5_CMU_RESET_G3D_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_RESET_DISP1_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_RESET_MAU_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_RESET_G2D_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_RESET_MSC_SYS_PWR_REG,
>> +       EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG,
>> +};
>> +
>>   static void __iomem * const exynos5_list_both_cnt_feed[] = {
>>         EXYNOS5_ARM_CORE0_OPTION,
>>         EXYNOS5_ARM_CORE1_OPTION,
>> @@ -371,6 +582,21 @@ static void exynos5_init_pmu(void)
>>         }
>>   }
>>
>> +/*
>> + * exynos_set_core_flag - set the cluster id to IROM register
>> + *                       to ensure that we wake up with the
>> + *                       current cluster.
>> + */
>> +static void exynos_set_core_flag(void)
>> +{
>> +       int cluster_id = (read_cpuid_mpidr() >> 8) & 0xf;
>
>
> Please use proper macros to extract cluster ID from mpidr value.
>
>
>> +
>> +       if (cluster_id)
>> +               __raw_writel(1, EXYNOS_IROM_DATA2);
>> +       else
>> +               __raw_writel(0, EXYNOS_IROM_DATA2);
>
>
> Couldn't __raw_writel(cluster_id, EXYNOS_IROM_DATA2) work here?
>
>
>> +}
>> +
>>   void exynos_sys_powerdown_conf(enum sys_powerdown mode)
>>   {
>>         unsigned int i;
>> @@ -378,6 +604,9 @@ void exynos_sys_powerdown_conf(enum sys_powerdown
>> mode)
>>         if (soc_is_exynos5250())
>>                 exynos5_init_pmu();
>>
>> +       if (soc_is_exynos5420())
>> +               exynos_set_core_flag();
>> +
>>         for (i = 0; (exynos_pmu_config[i].reg != PMU_TABLE_END) ; i++)
>>                 __raw_writel(exynos_pmu_config[i].val[mode],
>>                                 exynos_pmu_config[i].reg);
>> @@ -389,9 +618,27 @@ void exynos_sys_powerdown_conf(enum sys_powerdown
>> mode)
>>         }
>>   }
>>
>> +static void exynos5_power_off(void)
>> +{
>> +       unsigned int tmp;
>> +
>> +       pr_info("Power down.\n");
>> +       tmp = __raw_readl(EXYNOS_PS_HOLD_CONTROL);
>> +       tmp &= ~(1 << 8);
>
>
> This is wrong as it assumes fixed polarity of PSHOLD pin. Instead, it should
> just invert the setting. A simple XOR should be enough.

OK, Will change.

>
>
>> +       __raw_writel(tmp, EXYNOS_PS_HOLD_CONTROL);
>> +
>> +       /* Wait a little so we don't give a false warning below */
>> +       mdelay(100);
>> +
>> +       pr_err("Power down failed, please power off system manually.\n");
>> +       while (1)
>> +               ;
>> +}
>> +
>>   static int __init exynos_pmu_init(void)
>>   {
>>         unsigned int value;
>> +       int i;
>>
>>         exynos_pmu_config = exynos4210_pmu_config;
>>
>> @@ -416,6 +663,66 @@ static int __init exynos_pmu_init(void)
>>
>>                 exynos_pmu_config = exynos5250_pmu_config;
>>                 pr_info("EXYNOS5250 PMU Initialize\n");
>> +       } else if (soc_is_exynos5420()) {
>> +               /*
>> +                * Set the CMU_RESET, CMU_SYSCLK and CMU_CLKSTOP registers
>> +                * for local power blocks to Low initially as per Table
>> 8-4:
>> +                * "System-Level Power-Down Configuration Registers".
>> +                */
>> +               for (i = 0;
>> +                       i < ARRAY_SIZE(exynos5420_list_disable_pmu_reg);
>> +                       i++)
>> +                       __raw_writel(0x0,
>> exynos5420_list_disable_pmu_reg[i]);
>> +               /* Time taken to stabilized XXTI clock */
>> +               __raw_writel(0x005dc, EXYNOS5_XXTI_DURATION3);
>> +
>> +               /* Enable USE_STANDBY_WFI for all CORE */
>> +               __raw_writel(EXYNOS5420_USE_STANDBY_WFI_ALL,
>> +                               S5P_CENTRAL_SEQ_OPTION);
>> +
>> +               value = __raw_readl(EXYNOS_L2_OPTION(0));
>> +               value &= ~EXYNOS5_USE_RETENTION;
>> +               __raw_writel(value, EXYNOS_L2_OPTION(0));
>> +
>> +               value = __raw_readl(EXYNOS_L2_OPTION(1));
>> +               value &= ~EXYNOS5_USE_RETENTION;
>> +               __raw_writel(value, EXYNOS_L2_OPTION(1));
>> +
>> +               /*
>> +                * If L2_COMMON is turned off, clocks related to ATB async
>> +                * bridge are gated. Thus, when ISP power is gated, LPI
>> +                * may get stuck.
>> +                */
>> +               value = __raw_readl(EXYNOS5420_LPI_MASK);
>> +               value |= EXYNOS5420_ATB_ISP_ARM;
>> +               __raw_writel(value, EXYNOS5420_LPI_MASK);
>> +               value = __raw_readl(EXYNOS5420_LPI_MASK1);
>> +               value |= EXYNOS5420_ATB_KFC;
>> +               __raw_writel(value, EXYNOS5420_LPI_MASK1);
>> +
>> +               /* Prevent issue of new bus request from L2 memory */
>> +               value = __raw_readl(EXYNOS5420_ARM_COMMON_OPTION);
>> +               value |= EXYNOS5_SKIP_DEACTIVATE_ACEACP_IN_PWDN;
>> +               __raw_writel(value, EXYNOS5420_ARM_COMMON_OPTION);
>> +
>> +               value = __raw_readl(EXYNOS5420_KFC_COMMON_OPTION);
>> +               value |= EXYNOS5_SKIP_DEACTIVATE_ACEACP_IN_PWDN;
>> +               __raw_writel(value, EXYNOS5420_KFC_COMMON_OPTION);
>> +
>> +               /*
>> +                * This setting is to reduce suspend/resume time.
>> +                */
>> +               __raw_writel(DUR_WAIT_RESET,
>> EXYNOS5420_LOGIC_RESET_DURATION3);
>> +
>> +               /* Serialized CPU wakeup of Eagle */
>> +               __raw_writel(SPREAD_ENABLE,
>> EXYNOS5420_ARM_INTR_SPREAD_ENABLE);
>> +               __raw_writel(SPREAD_USE_STANDWFI,
>> +                       EXYNOS5420_ARM_INTR_SPREAD_USE_STANDBYWFI);
>> +               __raw_writel(0x1, EXYNOS5420_UP_SCHEDULER);
>> +
>> +               exynos_pmu_config = exynos5420_pmu_config;
>> +               pm_power_off = exynos5_power_off;
>> +               pr_info("EXYNOS5420 PMU Initialized\n");
>>         } else {
>>                 pr_info("EXYNOS: PMU not supported\n");
>>         }
>> diff --git a/arch/arm/mach-exynos/regs-pmu.h
>> b/arch/arm/mach-exynos/regs-pmu.h
>> index 4f6a256..cfbfc575 100644
>> --- a/arch/arm/mach-exynos/regs-pmu.h
>> +++ b/arch/arm/mach-exynos/regs-pmu.h
>> @@ -39,6 +39,8 @@
>>   #define S5P_INFORM6                           S5P_PMUREG(0x0818)
>>   #define S5P_INFORM7                           S5P_PMUREG(0x081C)
>>
>> +#define EXYNOS_IROM_DATA2                      S5P_PMUREG(0x0988)
>
>
> Is this register available on Exynos4 too?

Yeah, it is available in Exynos4 also.

>
>
>> +
>>   #define S5P_ARM_CORE0_LOWPWR                  S5P_PMUREG(0x1000)
>>   #define S5P_DIS_IRQ_CORE0                     S5P_PMUREG(0x1004)
>>   #define S5P_DIS_IRQ_CENTRAL0                  S5P_PMUREG(0x1008)
>> @@ -108,6 +110,10 @@
>>   #define S5P_ARM_CORE1_CONFIGURATION           S5P_PMUREG(0x2080)
>>   #define S5P_ARM_CORE1_STATUS                  S5P_PMUREG(0x2084)
>>
>> +#define EXYNOS5_ARM_L2_OPTION                  S5P_PMUREG(0x2608)
>> +#define EXYNOS5_USE_RETENTION                  BIT(4)
>> +
>> +
>>   #define S5P_PAD_RET_MAUDIO_OPTION             S5P_PMUREG(0x3028)
>>   #define S5P_PAD_RET_GPIO_OPTION                       S5P_PMUREG(0x3108)
>>   #define S5P_PAD_RET_UART_OPTION                       S5P_PMUREG(0x3128)
>> @@ -121,6 +127,36 @@
>>
>>   #define S5P_CHECK_SLEEP                               0x00000BAD
>>
>> +#define S5P_ARM_CORE0_CONFIGURATION            S5P_PMUREG(0x2000)
>> +#define S5P_ARM_CORE0_STATUS                   S5P_PMUREG(0x2004)
>> +#define S5P_ARM_CORE0_OPTION                   S5P_PMUREG(0x2008)
>> +
>> +#define EXYNOS_ARM_CORE_OPTION(_nr)            (S5P_ARM_CORE0_OPTION \
>> +                                               + ((_nr) * 0x80))
>> +#define EXYNOS_ARM_CORE_STATUS(_nr)            (S5P_ARM_CORE0_STATUS \
>> +                                               + ((_nr) * 0x80))
>> +#define EXYNOS_ARM_CORE_CONFIGURATION(_nr)     \
>> +                       (S5P_ARM_CORE0_CONFIGURATION + ((_nr) * 0x80))
>> +#define EXYNOS_CORE_LOCAL_PWR_EN               0x3
>> +
>> +#define EXYNOS_ARM_COMMON_CONFIGURATION                S5P_PMUREG(0x2500)
>> +#define EXYNOS_ARM_COMMON_STATUS               S5P_PMUREG(0x2504)
>> +#define EXYNOS_COMMON_CONFIGURATION(_nr)       \
>> +                       (EXYNOS_ARM_COMMON_CONFIGURATION + ((_nr) * 0x80))
>> +#define EXYNOS_COMMON_STATUS(_nr)              \
>> +                       (EXYNOS_COMMON_CONFIGURATION(_nr) + 0x4)
>> +#define EXYNOS_COMMON_OPTION(_nr)              \
>> +                       (EXYNOS_COMMON_CONFIGURATION(_nr) + 0x8)
>> +
>> +#define EXYNOS_ARM_L2_CONFIGURATION            S5P_PMUREG(0x2600)
>> +#define EXYNOS_L2_CONFIGURATION(_nr)           \
>> +                       (EXYNOS_ARM_L2_CONFIGURATION + ((_nr) * 0x80))
>> +#define EXYNOS_L2_STATUS(_nr)                  \
>> +                       (EXYNOS_L2_CONFIGURATION(_nr) + 0x4)
>> +#define EXYNOS_L2_OPTION(_nr)                  \
>> +                       (EXYNOS_L2_CONFIGURATION(_nr) + 0x8)
>> +#define EXYNOS_L2_COMMON_PWR_EN                        0x3
>> +
>>   /* Only for EXYNOS4210 */
>>   #define S5P_CMU_CLKSTOP_LCD1_LOWPWR   S5P_PMUREG(0x1154)
>>   #define S5P_CMU_RESET_LCD1_LOWPWR     S5P_PMUREG(0x1174)
>> @@ -313,4 +349,196 @@
>>
>>   #define EXYNOS5_OPTION_USE_RETENTION                          (1 << 4)
>>
>> +/* Only for EXYNOS5420 */
>> +#define EXYNOS5420_ISP_ARM_OPTION
>> S5P_PMUREG(0x2488)
>> +#define EXYNOS5420_L2RSTDISABLE_VALUE                          (1 << 3)
>> +
>> +#define EXYNOS5420_LPI_MASK
>> S5P_PMUREG(0x0004)
>> +#define EXYNOS5420_LPI_MASK1
>> S5P_PMUREG(0x0008)
>> +#define EXYNOS5420_UFS                                         (1 << 8)
>> +#define EXYNOS5420_ATB_KFC                                     (1 << 13)
>> +#define EXYNOS5420_ATB_ISP_ARM                                 (1 << 19)
>> +#define EXYNOS5420_EMULATION                                   (1 << 31)
>> +#define ATB_ISP_ARM                                            (1 << 12)
>> +#define ATB_KFC                                                        (1
>> << 13)
>> +#define ATB_NOC                                                        (1
>> << 14)
>> +
>> +#define EXYNOS5420_ARM_INTR_SPREAD_ENABLE
>> S5P_PMUREG(0x0100)
>> +#define EXYNOS5420_ARM_INTR_SPREAD_USE_STANDBYWFI
>> S5P_PMUREG(0x0104)
>> +#define EXYNOS5420_UP_SCHEDULER
>> S5P_PMUREG(0x0120)
>> +#define SPREAD_ENABLE                                          0xF
>> +#define SPREAD_USE_STANDWFI                                    0xF
>> +
>> +#define EXYNOS5420_BB_CON1
>> S5P_PMUREG(0x0784)
>> +#define EXYNOS5420_BB_SEL_EN                                   (1 << 31)
>> +#define EXYNOS5420_BB_PMOS_EN                                  (1 << 7)
>> +#define EXYNOS5420_BB_1300X                                    0XF
>> +
>> +#define EXYNOS5420_ARM_CORE2_SYS_PWR_REG
>> S5P_PMUREG(0x1020)
>> +#define EXYNOS5420_DIS_IRQ_ARM_CORE2_LOCAL_SYS_PWR_REG
>> S5P_PMUREG(0x1024)
>> +#define EXYNOS5420_DIS_IRQ_ARM_CORE2_CENTRAL_SYS_PWR_REG
>> S5P_PMUREG(0x1028)
>> +#define EXYNOS5420_ARM_CORE3_SYS_PWR_REG
>> S5P_PMUREG(0x1030)
>> +#define EXYNOS5420_DIS_IRQ_ARM_CORE3_LOCAL_SYS_PWR_REG
>> S5P_PMUREG(0x1034)
>> +#define EXYNOS5420_DIS_IRQ_ARM_CORE3_CENTRAL_SYS_PWR_REG
>> S5P_PMUREG(0x1038)
>> +#define EXYNOS5420_KFC_CORE0_SYS_PWR_REG
>> S5P_PMUREG(0x1040)
>> +#define EXYNOS5420_DIS_IRQ_KFC_CORE0_LOCAL_SYS_PWR_REG
>> S5P_PMUREG(0x1044)
>> +#define EXYNOS5420_DIS_IRQ_KFC_CORE0_CENTRAL_SYS_PWR_REG
>> S5P_PMUREG(0x1048)
>> +#define EXYNOS5420_KFC_CORE1_SYS_PWR_REG
>> S5P_PMUREG(0x1050)
>> +#define EXYNOS5420_DIS_IRQ_KFC_CORE1_LOCAL_SYS_PWR_REG
>> S5P_PMUREG(0x1054)
>> +#define EXYNOS5420_DIS_IRQ_KFC_CORE1_CENTRAL_SYS_PWR_REG
>> S5P_PMUREG(0x1058)
>> +#define EXYNOS5420_KFC_CORE2_SYS_PWR_REG
>> S5P_PMUREG(0x1060)
>> +#define EXYNOS5420_DIS_IRQ_KFC_CORE2_LOCAL_SYS_PWR_REG
>> S5P_PMUREG(0x1064)
>> +#define EXYNOS5420_DIS_IRQ_KFC_CORE2_CENTRAL_SYS_PWR_REG
>> S5P_PMUREG(0x1068)
>> +#define EXYNOS5420_KFC_CORE3_SYS_PWR_REG
>> S5P_PMUREG(0x1070)
>> +#define EXYNOS5420_DIS_IRQ_KFC_CORE3_LOCAL_SYS_PWR_REG
>> S5P_PMUREG(0x1074)
>> +#define EXYNOS5420_DIS_IRQ_KFC_CORE3_CENTRAL_SYS_PWR_REG
>> S5P_PMUREG(0x1078)
>> +#define EXYNOS5420_ISP_ARM_SYS_PWR_REG
>> S5P_PMUREG(0x1090)
>> +#define EXYNOS5420_DIS_IRQ_ISP_ARM_LOCAL_SYS_PWR_REG
>> S5P_PMUREG(0x1094)
>> +#define EXYNOS5420_DIS_IRQ_ISP_ARM_CENTRAL_SYS_PWR_REG
>> S5P_PMUREG(0x1098)
>> +#define EXYNOS5420_ARM_COMMON_SYS_PWR_REG
>> S5P_PMUREG(0x10A0)
>> +#define EXYNOS5420_KFC_COMMON_SYS_PWR_REG
>> S5P_PMUREG(0x10B0)
>> +#define EXYNOS5420_KFC_L2_SYS_PWR_REG
>> S5P_PMUREG(0x10D0)
>> +#define EXYNOS5420_DPLL_SYSCLK_SYS_PWR_REG
>> S5P_PMUREG(0x1158)
>> +#define EXYNOS5420_IPLL_SYSCLK_SYS_PWR_REG
>> S5P_PMUREG(0x115C)
>> +#define EXYNOS5420_KPLL_SYSCLK_SYS_PWR_REG
>> S5P_PMUREG(0x1160)
>> +#define EXYNOS5420_RPLL_SYSCLK_SYS_PWR_REG
>> S5P_PMUREG(0x1174)
>> +#define EXYNOS5420_SPLL_SYSCLK_SYS_PWR_REG
>> S5P_PMUREG(0x1178)
>> +#define EXYNOS5420_INTRAM_MEM_SYS_PWR_REG
>> S5P_PMUREG(0x11B8)
>> +#define EXYNOS5420_INTROM_MEM_SYS_PWR_REG
>> S5P_PMUREG(0x11BC)
>> +#define EXYNOS5420_ONENANDXL_MEM_SYS_PWR
>> S5P_PMUREG(0x11C0)
>> +#define EXYNOS5420_USBDEV_MEM_SYS_PWR
>> S5P_PMUREG(0x11CC)
>> +#define EXYNOS5420_USBDEV1_MEM_SYS_PWR
>> S5P_PMUREG(0x11D0)
>> +#define EXYNOS5420_SDMMC_MEM_SYS_PWR
>> S5P_PMUREG(0x11D4)
>> +#define EXYNOS5420_CSSYS_MEM_SYS_PWR
>> S5P_PMUREG(0x11D8)
>> +#define EXYNOS5420_SECSS_MEM_SYS_PWR
>> S5P_PMUREG(0x11DC)
>> +#define EXYNOS5420_ROTATOR_MEM_SYS_PWR
>> S5P_PMUREG(0x11E0)
>> +#define EXYNOS5420_INTRAM_MEM_SYS_PWR
>> S5P_PMUREG(0x11E4)
>> +#define EXYNOS5420_INTROM_MEM_SYS_PWR
>> S5P_PMUREG(0x11E8)
>> +#define EXYNOS5420_PAD_RETENTION_JTAG_SYS_PWR_REG
>> S5P_PMUREG(0x1208)
>> +#define EXYNOS5420_PAD_RETENTION_DRAM_SYS_PWR_REG
>> S5P_PMUREG(0x1210)
>> +#define EXYNOS5420_PAD_RETENTION_UART_SYS_PWR_REG
>> S5P_PMUREG(0x1214)
>> +#define EXYNOS5420_PAD_RETENTION_MMC0_SYS_PWR_REG
>> S5P_PMUREG(0x1218)
>> +#define EXYNOS5420_PAD_RETENTION_MMC1_SYS_PWR_REG
>> S5P_PMUREG(0x121C)
>> +#define EXYNOS5420_PAD_RETENTION_MMC2_SYS_PWR_REG
>> S5P_PMUREG(0x1220)
>> +#define EXYNOS5420_PAD_RETENTION_HSI_SYS_PWR_REG
>> S5P_PMUREG(0x1224)
>> +#define EXYNOS5420_PAD_RETENTION_EBIA_SYS_PWR_REG
>> S5P_PMUREG(0x1228)
>> +#define EXYNOS5420_PAD_RETENTION_EBIB_SYS_PWR_REG
>> S5P_PMUREG(0x122C)
>> +#define EXYNOS5420_PAD_RETENTION_SPI_SYS_PWR_REG
>> S5P_PMUREG(0x1230)
>> +#define EXYNOS5420_PAD_RETENTION_DRAM_COREBLK_SYS_PWR_REG
>> S5P_PMUREG(0x1234)
>> +#define EXYNOS5420_DISP1_SYS_PWR_REG
>> S5P_PMUREG(0x1410)
>> +#define EXYNOS5420_MAU_SYS_PWR_REG
>> S5P_PMUREG(0x1414)
>> +#define EXYNOS5420_G2D_SYS_PWR_REG
>> S5P_PMUREG(0x1418)
>> +#define EXYNOS5420_MSC_SYS_PWR_REG
>> S5P_PMUREG(0x141C)
>> +#define EXYNOS5420_FSYS_SYS_PWR_REG
>> S5P_PMUREG(0x1420)
>> +#define EXYNOS5420_FSYS2_SYS_PWR_REG
>> S5P_PMUREG(0x1424)
>> +#define EXYNOS5420_PSGEN_SYS_PWR_REG
>> S5P_PMUREG(0x1428)
>> +#define EXYNOS5420_PERIC_SYS_PWR_REG
>> S5P_PMUREG(0x142C)
>> +#define EXYNOS5420_WCORE_SYS_PWR_REG
>> S5P_PMUREG(0x1430)
>> +#define EXYNOS5420_CMU_CLKSTOP_DISP1_SYS_PWR_REG
>> S5P_PMUREG(0x1490)
>> +#define EXYNOS5420_CMU_CLKSTOP_MAU_SYS_PWR_REG
>> S5P_PMUREG(0x1494)
>> +#define EXYNOS5420_CMU_CLKSTOP_G2D_SYS_PWR_REG
>> S5P_PMUREG(0x1498)
>> +#define EXYNOS5420_CMU_CLKSTOP_MSC_SYS_PWR_REG
>> S5P_PMUREG(0x149C)
>> +#define EXYNOS5420_CMU_CLKSTOP_FSYS_SYS_PWR_REG
>> S5P_PMUREG(0x14A0)
>> +#define EXYNOS5420_CMU_CLKSTOP_FSYS2_SYS_PWR_REG
>> S5P_PMUREG(0x14A4)
>> +#define EXYNOS5420_CMU_CLKSTOP_PSGEN_SYS_PWR_REG
>> S5P_PMUREG(0x14A8)
>> +#define EXYNOS5420_CMU_CLKSTOP_PERIC_SYS_PWR_REG
>> S5P_PMUREG(0x14AC)
>> +#define EXYNOS5420_CMU_CLKSTOP_WCORE_SYS_PWR_REG
>> S5P_PMUREG(0x14B0)
>> +#define EXYNOS5420_CMU_SYSCLK_TOPPWR_SYS_PWR_REG
>> S5P_PMUREG(0x14BC)
>> +#define EXYNOS5420_CMU_SYSCLK_DISP1_SYS_PWR_REG
>> S5P_PMUREG(0x14D0)
>> +#define EXYNOS5420_CMU_SYSCLK_MAU_SYS_PWR_REG
>> S5P_PMUREG(0x14D4)
>> +#define EXYNOS5420_CMU_SYSCLK_G2D_SYS_PWR_REG
>> S5P_PMUREG(0x14D8)
>> +#define EXYNOS5420_CMU_SYSCLK_MSC_SYS_PWR_REG
>> S5P_PMUREG(0x14DC)
>> +#define EXYNOS5420_CMU_SYSCLK_FSYS_SYS_PWR_REG
>> S5P_PMUREG(0x14E0)
>> +#define EXYNOS5420_CMU_SYSCLK_FSYS2_SYS_PWR_REG
>> S5P_PMUREG(0x14E4)
>> +#define EXYNOS5420_CMU_SYSCLK_PSGEN_SYS_PWR_REG
>> S5P_PMUREG(0x14E8)
>> +#define EXYNOS5420_CMU_SYSCLK_PERIC_SYS_PWR_REG
>> S5P_PMUREG(0x14EC)
>> +#define EXYNOS5420_CMU_SYSCLK_WCORE_SYS_PWR_REG
>> S5P_PMUREG(0x14F0)
>> +#define EXYNOS5420_CMU_SYSCLK_SYSMEM_TOPPWR_SYS_PWR_REG
>> S5P_PMUREG(0x14F4)
>> +#define EXYNOS5420_CMU_RESET_FSYS2_SYS_PWR_REG
>> S5P_PMUREG(0x1570)
>> +#define EXYNOS5420_CMU_RESET_PSGEN_SYS_PWR_REG
>> S5P_PMUREG(0x1574)
>> +#define EXYNOS5420_CMU_RESET_PERIC_SYS_PWR_REG
>> S5P_PMUREG(0x1578)
>> +#define EXYNOS5420_CMU_RESET_WCORE_SYS_PWR_REG
>> S5P_PMUREG(0x157C)
>> +#define EXYNOS5420_CMU_RESET_DISP1_SYS_PWR_REG
>> S5P_PMUREG(0x1590)
>> +#define EXYNOS5420_CMU_RESET_MAU_SYS_PWR_REG
>> S5P_PMUREG(0x1594)
>> +#define EXYNOS5420_CMU_RESET_G2D_SYS_PWR_REG
>> S5P_PMUREG(0x1598)
>> +#define EXYNOS5420_CMU_RESET_MSC_SYS_PWR_REG
>> S5P_PMUREG(0x159C)
>> +#define EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG
>> S5P_PMUREG(0x15A0)
>> +#define EXYNOS5420_SFR_AXI_CGDIS1
>> S5P_PMUREG(0x15E4)
>> +#define EXYNOS_ARM_CORE2_CONFIGURATION
>> S5P_PMUREG(0x2100)
>> +#define EXYNOS5420_ARM_CORE2_OPTION
>> S5P_PMUREG(0x2108)
>> +#define EXYNOS_ARM_CORE3_CONFIGURATION
>> S5P_PMUREG(0x2180)
>> +#define EXYNOS5420_ARM_CORE3_OPTION
>> S5P_PMUREG(0x2188)
>> +#define EXYNOS5420_ARM_COMMON_STATUS
>> S5P_PMUREG(0x2504)
>> +#define EXYNOS5420_ARM_COMMON_OPTION
>> S5P_PMUREG(0x2508)
>> +#define EXYNOS5420_KFC_COMMON_STATUS
>> S5P_PMUREG(0x2584)
>> +#define EXYNOS5420_KFC_COMMON_OPTION
>> S5P_PMUREG(0x2588)
>> +#define EXYNOS5420_LOGIC_RESET_DURATION3
>> S5P_PMUREG(0x2D1C)
>> +
>> +#define EXYNOS5420_PAD_RET_GPIO_OPTION
>> S5P_PMUREG(0x30C8)
>> +#define EXYNOS5420_PAD_RET_UART_OPTION
>> S5P_PMUREG(0x30E8)
>> +#define EXYNOS5420_PAD_RET_MMCA_OPTION
>> S5P_PMUREG(0x3108)
>> +#define EXYNOS5420_PAD_RET_MMCB_OPTION
>> S5P_PMUREG(0x3128)
>> +#define EXYNOS5420_PAD_RET_MMCC_OPTION
>> S5P_PMUREG(0x3148)
>> +#define EXYNOS5420_PAD_RET_HSI_OPTION
>> S5P_PMUREG(0x3168)
>> +#define EXYNOS5420_PAD_RET_SPI_OPTION
>> S5P_PMUREG(0x31C8)
>> +#define EXYNOS5420_PAD_RET_DRAM_COREBLK_OPTION
>> S5P_PMUREG(0x31E8)
>> +#define EXYNOS_PAD_RET_DRAM_OPTION
>> S5P_PMUREG(0x3008)
>> +#define EXYNOS_PAD_RET_MAUDIO_OPTION
>> S5P_PMUREG(0x3028)
>> +#define EXYNOS_PAD_RET_JTAG_OPTION
>> S5P_PMUREG(0x3048)
>> +#define EXYNOS_PAD_RET_GPIO_OPTION
>> S5P_PMUREG(0x3108)
>> +#define EXYNOS_PAD_RET_UART_OPTION
>> S5P_PMUREG(0x3128)
>> +#define EXYNOS_PAD_RET_MMCA_OPTION
>> S5P_PMUREG(0x3148)
>> +#define EXYNOS_PAD_RET_MMCB_OPTION
>> S5P_PMUREG(0x3168)
>> +#define EXYNOS_PAD_RET_EBIA_OPTION
>> S5P_PMUREG(0x3188)
>> +#define EXYNOS_PAD_RET_EBIB_OPTION
>> S5P_PMUREG(0x31A8)
>> +
>> +#define EXYNOS_PS_HOLD_CONTROL
>> S5P_PMUREG(0x330C)
>> +#define EXYNOS5_XXTI_DURATION3
>> S5P_PMUREG(0x343C)
>> +
>> +/* For SYS_PWR_REG */
>> +#define EXYNOS_SYS_PWR_CFG                                     (1 << 0)
>> +
>> +#define EXYNOS5420_MFC_CONFIGURATION
>> S5P_PMUREG(0x4060)
>> +#define EXYNOS5420_MFC_STATUS
>> S5P_PMUREG(0x4064)
>> +#define EXYNOS5420_MFC_OPTION
>> S5P_PMUREG(0x4068)
>> +#define EXYNOS5420_G3D_CONFIGURATION
>> S5P_PMUREG(0x4080)
>> +#define EXYNOS5420_G3D_STATUS
>> S5P_PMUREG(0x4084)
>> +#define EXYNOS5420_G3D_OPTION
>> S5P_PMUREG(0x4088)
>> +#define EXYNOS5420_DISP0_CONFIGURATION
>> S5P_PMUREG(0x40A0)
>> +#define EXYNOS5420_DISP0_STATUS
>> S5P_PMUREG(0x40A4)
>> +#define EXYNOS5420_DISP0_OPTION
>> S5P_PMUREG(0x40A8)
>> +#define EXYNOS5420_DISP1_CONFIGURATION
>> S5P_PMUREG(0x40C0)
>> +#define EXYNOS5420_DISP1_STATUS
>> S5P_PMUREG(0x40C4)
>> +#define EXYNOS5420_DISP1_OPTION
>> S5P_PMUREG(0x40C8)
>> +#define EXYNOS5420_MAU_CONFIGURATION
>> S5P_PMUREG(0x40E0)
>> +#define EXYNOS5420_MAU_STATUS
>> S5P_PMUREG(0x40E4)
>> +#define EXYNOS5420_MAU_OPTION
>> S5P_PMUREG(0x40E8)
>> +#define EXYNOS5420_FSYS2_OPTION
>> S5P_PMUREG(0x4168)
>> +#define EXYNOS5420_PSGEN_OPTION
>> S5P_PMUREG(0x4188)
>
>
> style: A lot of lines over 80 characters.
>
>
>> +
>> +/* For EXYNOS_CENTRAL_SEQ_OPTION */
>> +#define EXYNOS5_USE_STANDBYWFI_ARM_CORE0                       (1 << 16)
>> +#define EXYNOS5_USE_STANDBYWFI_ARM_CORE1                       (1 << 17)
>> +#define EXYNOS5_USE_STANDBYWFE_ARM_CORE0                       (1 << 24)
>> +#define EXYNOS5_USE_STANDBYWFE_ARM_CORE1                       (1 << 25)
>> +
>> +#define EXYNOS5420_ARM_USE_STANDBY_WFI0                                (1
>> << 4)
>> +#define EXYNOS5420_ARM_USE_STANDBY_WFI1                                (1
>> << 5)
>> +#define EXYNOS5420_ARM_USE_STANDBY_WFI2                                (1
>> << 6)
>> +#define EXYNOS5420_ARM_USE_STANDBY_WFI3                                (1
>> << 7)
>> +#define EXYNOS5420_KFC_USE_STANDBY_WFI0                                (1
>> << 8)
>> +#define EXYNOS5420_KFC_USE_STANDBY_WFI1                                (1
>> << 9)
>> +#define EXYNOS5420_KFC_USE_STANDBY_WFI2                                (1
>> << 10)
>> +#define EXYNOS5420_KFC_USE_STANDBY_WFI3                                (1
>> << 11)
>> +#define EXYNOS5420_ARM_USE_STANDBY_WFE0                                (1
>> << 16)
>> +#define EXYNOS5420_ARM_USE_STANDBY_WFE1                                (1
>> << 17)
>> +#define EXYNOS5420_ARM_USE_STANDBY_WFE2                                (1
>> << 18)
>> +#define EXYNOS5420_ARM_USE_STANDBY_WFE3                                (1
>> << 19)
>> +#define EXYNOS5420_KFC_USE_STANDBY_WFE0                                (1
>> << 20)
>> +#define EXYNOS5420_KFC_USE_STANDBY_WFE1                                (1
>> << 21)
>> +#define EXYNOS5420_KFC_USE_STANDBY_WFE2                                (1
>> << 22)
>> +#define EXYNOS5420_KFC_USE_STANDBY_WFE3                                (1
>> << 23)
>
>
> BIT() macro could be used. The same for similar bit definitions above.

Sure, will modify.

>
> Best regards,
> Tomasz
