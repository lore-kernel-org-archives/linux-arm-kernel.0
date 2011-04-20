From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 20 Apr 2011 18:44:39 +0800
Subject: [PATCH v1 3/3]ARM: mmp: support mmc on pxa910 dkb board
In-Reply-To: <BANLkTin1mbEnZcq53r26nJBfC5YTwK7f1A@mail.gmail.com>
References: <BANLkTin1mbEnZcq53r26nJBfC5YTwK7f1A@mail.gmail.com>
Message-ID: <BANLkTi=MitQ4R7CTcsrnrQU7wrh=sUWM5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 6:34 PM, Jun Nie <niej0001@gmail.com> wrote:
> ARM: mmp: support mmc on pxa910 dkb board
>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> ?arch/arm/mach-mmp/include/mach/mfp-pxa910.h | ? 12 ++++++++
> ?arch/arm/mach-mmp/ttc_dkb.c ? ? ? ? ? ? ? ? | ? 39 ++++++++++++++++++++++++--
> ?2 files changed, 48 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
> b/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
> index d1150ab..45f97cd 100644
> --- a/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
> +++ b/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
> @@ -159,6 +159,18 @@
> ?#define MMC1_CD_MMC1_CD ? ? ? ? ? ? ? ?MFP_CFG_DRV(MMC1_CD, AF0, MEDIUM)
> ?#define MMC1_WP_MMC1_WP ? ? ? ? ? ? ? ?MFP_CFG_DRV(MMC1_WP, AF0, MEDIUM)
>
> +/* MMC2 */
> +#define MMC2_DAT3_GPIO_33 ? ? ? MFP_CFG_DRV(GPIO33, AF1, MEDIUM)
> +#define MMC2_DAT3_GPIO_34 ? ? ? MFP_CFG_DRV(GPIO34, AF1, MEDIUM)
> +#define MMC2_DAT3_GPIO_35 ? ? ? MFP_CFG_DRV(GPIO35, AF1, MEDIUM)
> +#define MMC2_DAT3_GPIO_36 ? ? ? MFP_CFG_DRV(GPIO36, AF1, MEDIUM)
> +#define MMC2_DAT3_GPIO_37 ? ? ? MFP_CFG_DRV(GPIO37, AF1, MEDIUM)
> +#define MMC2_DAT2_GPIO_38 ? ? ? MFP_CFG_DRV(GPIO38, AF1, MEDIUM)
> +#define MMC2_DAT1_GPIO_39 ? ? ? MFP_CFG_DRV(GPIO39, AF1, MEDIUM)
> +#define MMC2_DAT0_GPIO_40 ? ? ? MFP_CFG_DRV(GPIO40, AF1, MEDIUM)
> +#define MMC2_CMD_GPIO_41 ? ? ? ?MFP_CFG_DRV(GPIO41, AF1, MEDIUM)
> +#define MMC2_CLK_GPIO_42 ? ? ? ?MFP_CFG_DRV(GPIO42, AF1, VERY_SLOW)
> +
> ?/* PWM */
> ?#define GPIO27_PWM3_AF2 ? ? ? ? ? ? ? ?MFP_CFG(GPIO27, AF2)
> ?#define GPIO51_PWM2_OUT ? ? ? ? ? ? ? ?MFP_CFG(GPIO51, AF2)
> diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
> index c8a85f1..718b87c 100644
> --- a/arch/arm/mach-mmp/ttc_dkb.c
> +++ b/arch/arm/mach-mmp/ttc_dkb.c
> @@ -17,6 +17,9 @@
> ?#include <linux/interrupt.h>
> ?#include <linux/regulator/machine.h>
> ?#include <linux/regulator/fixed.h>
> +#include <linux/mmc/sdhci.h>
> +#include <linux/gpio.h>
> +#include <linux/err.h>
>
> ?#include <asm/mach-types.h>
> ?#include <asm/mach/arch.h>
> @@ -24,6 +27,7 @@
> ?#include <mach/addr-map.h>
> ?#include <mach/mfp-pxa910.h>
> ?#include <mach/pxa910.h>
> +#include <mach/gpio.h>
>
> ?#include "common.h"
>
> @@ -60,6 +64,24 @@ static unsigned long ttc_dkb_pin_config[] __initdata = {
> ? ? ? ?DF_REn_DF_REn,
> ? ? ? ?DF_RDY0_DF_RDY0,
>
> + ? ? ? /*sdh MMC0*/
> + ? ? ? MMC1_DAT3_MMC1_DAT3,
> + ? ? ? MMC1_DAT2_MMC1_DAT2,
> + ? ? ? MMC1_DAT1_MMC1_DAT1,
> + ? ? ? MMC1_DAT0_MMC1_DAT0,
> + ? ? ? MMC1_CMD_MMC1_CMD,
> + ? ? ? MMC1_CLK_MMC1_CLK,
> + ? ? ? MMC1_CD_MMC1_CD | MFP_PULL_HIGH,
> + ? ? ? MMC1_WP_MMC1_WP,
> +
> + ? ? ? /*sdh MMC1*/
> + ? ? ? MMC2_DAT3_GPIO_37,
> + ? ? ? MMC2_DAT2_GPIO_38,
> + ? ? ? MMC2_DAT1_GPIO_39,
> + ? ? ? MMC2_DAT0_GPIO_40,
> + ? ? ? MMC2_CMD_GPIO_41,
> + ? ? ? MMC2_CLK_GPIO_42,
> +
> ? ? ? ?/* 2V8 SD/MMC regulator */
> ? ? ? ?GPIO15_GPIO,
> ?};
> @@ -121,7 +143,7 @@ static struct platform_device *ttc_dkb_devices[] = {
> ?};
>
> ?static struct regulator_consumer_supply dkb_mmc_2v8_supplies[] = {
> - ? ? ? REGULATOR_SUPPLY("mmc_2v8", "sdhci-pxa.0"),
> + ? ? ? REGULATOR_SUPPLY("vmmc", "sdhci-pxa.0"),

Why did you add one regulator and then replaced it? Otherwise looks good.

Cc'ed linux-arm-kernel ML.

> ?};
>
> ?static struct regulator_init_data dkb_mmc_2v8_data = {
> @@ -133,7 +155,7 @@ static struct regulator_init_data dkb_mmc_2v8_data = {
> ?};
>
> ?static struct fixed_voltage_config dkb_mmc_2v8 = {
> - ? ? ? .supply_name ? ? ? ? ? ?= "mmc_2v8",
> + ? ? ? .supply_name ? ? ? ? ? ?= "vmmc",
> ? ? ? ?.microvolts ? ? ? ? ? ? = 2800000,
> ? ? ? ?.gpio ? ? ? ? ? ? ? ? ? = GPIO_SD_2V8_ENABLE,
> ? ? ? ?.enable_high ? ? ? ? ? ?= 1,
> @@ -142,19 +164,30 @@ static struct fixed_voltage_config dkb_mmc_2v8 = {
> ?};
>
> ?static struct platform_device dkb_mmc_2v8_device = {
> - ? ? ? .name ? ? ? ? ? = "mmc-fixed-voltage",
> + ? ? ? .name ? ? ? ? ? = "reg-fixed-voltage",
> ? ? ? ?.id ? ? ? ? ? ? = 1,
> ? ? ? ?.dev = {
> ? ? ? ? ? ? ? ?.platform_data = &dkb_mmc_2v8,
> ? ? ? ?},
> ?};
>
> +/* MMC0 controller for SD-MMC */
> +static struct sdhci_pxa_platdata pxa910_sdh_platdata_mmc0 = {
> + ? ? ? .quirks ? ? ? ? ? ? ? ? = SDHCI_QUIRK_BROKEN_ADMA,
> +};
> +/* MMC1 controller for SDIO */
> +static struct sdhci_pxa_platdata pxa910_sdh_platdata_mmc1 = {
> + ? ? ? .quirks ? ? ? ? ? ? ? ? = SDHCI_QUIRK_BROKEN_ADMA,
> +};
> +
> ?static void __init ttc_dkb_init(void)
> ?{
> ? ? ? ?mfp_config(ARRAY_AND_SIZE(ttc_dkb_pin_config));
>
> ? ? ? ?/* on-chip devices */
> ? ? ? ?pxa910_add_uart(1);
> + ? ? ? pxa910_add_sdhost(0, &pxa910_sdh_platdata_mmc0);
> + ? ? ? pxa910_add_sdhost(1, &pxa910_sdh_platdata_mmc1);
>
> ? ? ? ?/* off-chip devices */
> ? ? ? ?platform_add_devices(ARRAY_AND_SIZE(ttc_dkb_devices));
> --
> 1.7.0.4
>
