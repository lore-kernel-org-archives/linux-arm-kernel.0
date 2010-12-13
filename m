From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 13 Dec 2010 11:40:11 +0800
Subject: [PATCH] ARM: mmp: added 5V Regulator enable for Brownstone
In-Reply-To: <1292185730-3015-1-git-send-email-mark.brown314@gmail.com>
References: <1292185730-3015-1-git-send-email-mark.brown314@gmail.com>
Message-ID: <AANLkTimvYKgvo+X8tFGJr3EnNyFi2Bmk87=V+h_aXNQ3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 13, 2010 at 4:28 AM, Mark F. Brown <mark.brown314@gmail.com> wrote:
> 5V supply for USB ports, LCD connector, and HDMI
>
> Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>

Looks good. Applied to 'devel'.

> ---
> ?arch/arm/mach-mmp/brownstone.c | ? 20 ++++++++++++++++++++
> ?1 files changed, 20 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
> index 635c400..9d37b35 100644
> --- a/arch/arm/mach-mmp/brownstone.c
> +++ b/arch/arm/mach-mmp/brownstone.c
> @@ -97,8 +97,13 @@ static unsigned long brownstone_pin_config[] __initdata = {
> ? ? ? ?GPIO111_MMC3_DAT0 | MFP_PULL_HIGH,
> ? ? ? ?GPIO112_MMC3_CMD | MFP_PULL_HIGH,
> ? ? ? ?GPIO151_MMC3_CLK,
> +
> + ? ? ? /* 5V Regulator */
> + ? ? ? GPIO89_GPIO89,
> ?};
>
> +#define GPIO_5V_ENABLE (89)
> +
> ?static struct regulator_consumer_supply max8649_supply[] = {
> ? ? ? ?REGULATOR_SUPPLY("vcc_core", NULL),
> ?};
> @@ -145,10 +150,25 @@ static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
> ? ? ? ?.max_speed ? ? ?= 25000000,
> ?};
>
> +/* enable for MAX8815A regulator (5V_ENABLE) */
> +static void brownstone_enable_5v_regulator(void)
> +{
> + ? ? ? int ret;
> + ? ? ? ret = gpio_request(GPIO_5V_ENABLE, "5V_ENABLE");
> + ? ? ? if (ret < 0)
> + ? ? ? ? ? ? ? pr_warning("Unable to request GPIO_5V_ENABLE\n");
> + ? ? ? else
> + ? ? ? ? ? ? ? gpio_direction_output(GPIO_5V_ENABLE, 1);
> + ? ? ? gpio_free(GPIO_5V_ENABLE);
> +}
> +
> ?static void __init brownstone_init(void)
> ?{
> ? ? ? ?mfp_config(ARRAY_AND_SIZE(brownstone_pin_config));
>
> + ? ? ? /* enable 5v regulator */
> + ? ? ? brownstone_enable_5v_regulator();
> +
> ? ? ? ?/* on-chip devices */
> ? ? ? ?mmp2_add_uart(1);
> ? ? ? ?mmp2_add_uart(3);
> --
> 1.7.0.4
>
>
