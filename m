From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 20 Apr 2011 18:41:31 +0800
Subject: [PATCH v1 2/3]ARM: mmp: append mmc 2v8 regulator on dkb board
In-Reply-To: <BANLkTiktkC5ffsTh4sxh7-nuY8dsi5R2ZA@mail.gmail.com>
References: <BANLkTiktkC5ffsTh4sxh7-nuY8dsi5R2ZA@mail.gmail.com>
Message-ID: <BANLkTi=xt_aJ+mHO1ni7Xt_mVrLbHKxMKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc'ed linux-arm-kernel ML. Patch looks good to me.

On Wed, Apr 20, 2011 at 6:34 PM, Jun Nie <niej0001@gmail.com> wrote:
> ?ARM: mmp: append mmc 2v8 regulator on dkb board
>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> ?arch/arm/mach-mmp/include/mach/mfp-pxa910.h | ? ?3 ++
> ?arch/arm/mach-mmp/ttc_dkb.c ? ? ? ? ? ? ? ? | ? 37 +++++++++++++++++++++++++++
> ?2 files changed, 40 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
> b/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
> index fbd7ee8..d1150ab 100644
> --- a/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
> +++ b/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
> @@ -167,4 +167,7 @@
> ?#define GPIO119_PWM3_OUT ? ? ? MFP_CFG(GPIO119, AF2)
> ?#define GPIO120_PWM4_OUT ? ? ? MFP_CFG(GPIO120, AF2)
>
> +/* GPIO */
> +#define GPIO15_GPIO ? ? ? ? ? ?MFP_CFG(GPIO15, AF0)
> +
> ?#endif /* __ASM_MACH MFP_PXA910_H */
> diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
> index e411039..c8a85f1 100644
> --- a/arch/arm/mach-mmp/ttc_dkb.c
> +++ b/arch/arm/mach-mmp/ttc_dkb.c
> @@ -15,6 +15,8 @@
> ?#include <linux/mtd/partitions.h>
> ?#include <linux/mtd/onenand.h>
> ?#include <linux/interrupt.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/regulator/fixed.h>
>
> ?#include <asm/mach-types.h>
> ?#include <asm/mach/arch.h>
> @@ -27,6 +29,8 @@
>
> ?#define TTCDKB_NR_IRQS ? ? ? ? (IRQ_BOARD_START + 24)
>
> +#define GPIO_SD_2V8_ENABLE ? ? ? ? ? ? (15)
> +
> ?static unsigned long ttc_dkb_pin_config[] __initdata = {
> ? ? ? ?/* UART2 */
> ? ? ? ?GPIO47_UART2_RXD,
> @@ -55,6 +59,9 @@ static unsigned long ttc_dkb_pin_config[] __initdata = {
> ? ? ? ?DF_WEn_DF_WEn,
> ? ? ? ?DF_REn_DF_REn,
> ? ? ? ?DF_RDY0_DF_RDY0,
> +
> + ? ? ? /* 2V8 SD/MMC regulator */
> + ? ? ? GPIO15_GPIO,
> ?};
>
> ?static struct mtd_partition ttc_dkb_onenand_partitions[] = {
> @@ -113,6 +120,35 @@ static struct platform_device *ttc_dkb_devices[] = {
> ? ? ? ?&ttc_dkb_device_onenand,
> ?};
>
> +static struct regulator_consumer_supply dkb_mmc_2v8_supplies[] = {
> + ? ? ? REGULATOR_SUPPLY("mmc_2v8", "sdhci-pxa.0"),
> +};
> +
> +static struct regulator_init_data dkb_mmc_2v8_data = {
> + ? ? ? .constraints ? ?= {
> + ? ? ? ? ? ? ? .valid_ops_mask ? ? ? ? = REGULATOR_CHANGE_STATUS,
> + ? ? ? },
> + ? ? ? .num_consumer_supplies ?= ARRAY_SIZE(dkb_mmc_2v8_supplies),
> + ? ? ? .consumer_supplies ? ? ?= dkb_mmc_2v8_supplies,
> +};
> +
> +static struct fixed_voltage_config dkb_mmc_2v8 = {
> + ? ? ? .supply_name ? ? ? ? ? ?= "mmc_2v8",
> + ? ? ? .microvolts ? ? ? ? ? ? = 2800000,
> + ? ? ? .gpio ? ? ? ? ? ? ? ? ? = GPIO_SD_2V8_ENABLE,
> + ? ? ? .enable_high ? ? ? ? ? ?= 1,
> + ? ? ? .enabled_at_boot ? ? ? ?= 0,
> + ? ? ? .init_data ? ? ? ? ? ? ?= &dkb_mmc_2v8_data,
> +};
> +
> +static struct platform_device dkb_mmc_2v8_device = {
> + ? ? ? .name ? ? ? ? ? = "mmc-fixed-voltage",
> + ? ? ? .id ? ? ? ? ? ? = 1,
> + ? ? ? .dev = {
> + ? ? ? ? ? ? ? .platform_data = &dkb_mmc_2v8,
> + ? ? ? },
> +};
> +
> ?static void __init ttc_dkb_init(void)
> ?{
> ? ? ? ?mfp_config(ARRAY_AND_SIZE(ttc_dkb_pin_config));
> @@ -122,6 +158,7 @@ static void __init ttc_dkb_init(void)
>
> ? ? ? ?/* off-chip devices */
> ? ? ? ?platform_add_devices(ARRAY_AND_SIZE(ttc_dkb_devices));
> + ? ? ? platform_device_register(&dkb_mmc_2v8_device);
> ?}
>
> ?MACHINE_START(TTC_DKB, "PXA910-based TTC_DKB Development Platform")
> --
> 1.7.0.4
>
