From: raulxiong@gmail.com (Raul Xiong)
Date: Mon, 7 May 2012 11:32:50 +0800
Subject: [PATCH 3/3] ARM: MMP: add 88pm860x battery-charger support
In-Reply-To: <1332825946-2260-1-git-send-email-jtzhou@marvell.com>
References: <1332825946-2260-1-git-send-email-jtzhou@marvell.com>
Message-ID: <CAG9bXvnXcsqNjb50N3RzdNaEMEL_iv2Y2o5Ve7ZZHpyh79ZOqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/3/27 Jett.Zhou <jtzhou@marvell.com>
>
> Add 88pm860x chg_desc platform data for ttc platform.
>
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> ---
> ?arch/arm/mach-mmp/ttc_dkb.c | ? 37 +++++++++++++++++++++++++++++++++++++
> ?1 files changed, 37 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
> index 5ac5d58..4e18be7 100644
> --- a/arch/arm/mach-mmp/ttc_dkb.c
> +++ b/arch/arm/mach-mmp/ttc_dkb.c
> @@ -17,6 +17,9 @@
> ?#include <linux/interrupt.h>
> ?#include <linux/i2c/pca953x.h>
> ?#include <linux/gpio.h>
> +#include <linux/mfd/88pm860x.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/power/charger-manager.h>
>
> ?#include <asm/mach-types.h>
> ?#include <asm/mach/arch.h>
> @@ -134,8 +137,42 @@ static struct pca953x_platform_data max7312_data[] =
> {
> ? ? ? ?},
> ?};
>
> +static char *ttc_psy_chg_stat[] = {"usb", NULL};
> +/*
> + * Temperature can be handled by battery monitor base on interrupt
> + * scheme, so dummy it to make sure charger-manager initialize ok.
> + */
> +static int dummy_temp_out_of_range(int *mC)
> +{
> + ? ? ? *mC = 2500;
> + ? ? ? return 0;
> +}
> +
> +struct charger_desc chg_desc_data = {
> + ? ? ? .polling_mode ? ? ? ? ? = CM_POLL_ALWAYS,
> + ? ? ? .polling_interval_ms ? ?= 180000,
> + ? ? ? .battery_present ? ? ? ?= CM_FUEL_GAUGE,
> + ? ? ? .psy_charger_stat ? ? ? = &ttc_psy_chg_stat[0],
> + ? ? ? .psy_fuel_gauge ? ? ? ? = "battery-monitor",
> + ? ? ? .temperature_out_of_range ? ? ? = dummy_temp_out_of_range,
> +};
> +
> +static struct pm860x_platform_data ttc_dkb_pm8607_info = {
> + ? ? ? .chg_desc ? ? ? = &chg_desc_data,
> + ? ? ? .companion_addr = 0x11,
> + ? ? ? .irq_mode ? ? ? = 0,
> + ? ? ? .irq_base ? ? ? = IRQ_BOARD_START,
> + ? ? ? .i2c_port ? ? ? = GI2C_PORT,
> +};
> +
> ?static struct i2c_board_info ttc_dkb_i2c_info[] = {
> ? ? ? ?{
> + ? ? ? ? ? ? ? .type ? ? ? ? ? = "88PM860x",
> + ? ? ? ? ? ? ? .addr ? ? ? ? ? = 0x34,
> + ? ? ? ? ? ? ? .platform_data ?= &ttc_dkb_pm8607_info,
> + ? ? ? ? ? ? ? .irq ? ? ? ? ? ?= IRQ_PXA910_PMIC_INT,
> + ? ? ? },
> + ? ? ? {
> ? ? ? ? ? ? ? ?.type ? ? ? ? ? = "max7312",
> ? ? ? ? ? ? ? ?.addr ? ? ? ? ? = 0x23,
> ? ? ? ? ? ? ? ?.irq ? ? ? ? ? ?= MMP_GPIO_TO_IRQ(80),
> --
> 1.7.0.4
>

Acked-by: Raul Xiong <raulxiong@gmail.com>

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
