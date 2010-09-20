From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 20 Sep 2010 22:40:25 +0800
Subject: [PATCH 04/11] ARM: pxa: Add M41T00 RTC support into Colibri
	evalboard
In-Reply-To: <1284604382-23683-4-git-send-email-marek.vasut@gmail.com>
References: <1284604382-23683-1-git-send-email-marek.vasut@gmail.com>
	<1284604382-23683-4-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTi=YjLbQ=cxcws=Qrkbz=0yHa=bGzZz9qFT_1Sg3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 16, 2010 at 10:32 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> Acked-by: Daniel Mack <daniel@caiaq.de>

OK.

> ---
> ?arch/arm/mach-pxa/colibri-pxa270-evalboard.c | ? 23 +++++++++++++++++++++++
> ?arch/arm/mach-pxa/colibri-pxa270.c ? ? ? ? ? | ? ?4 ++++
> ?arch/arm/mach-pxa/colibri-pxa300.c ? ? ? ? ? | ? ?4 ++++
> ?arch/arm/mach-pxa/colibri-pxa320.c ? ? ? ? ? | ? ?4 ++++
> ?4 files changed, 35 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/colibri-pxa270-evalboard.c b/arch/arm/mach-pxa/colibri-pxa270-evalboard.c
> index e1a2b52..7f27aec 100644
> --- a/arch/arm/mach-pxa/colibri-pxa270-evalboard.c
> +++ b/arch/arm/mach-pxa/colibri-pxa270-evalboard.c
> @@ -19,6 +19,7 @@
> ?#include <asm/mach-types.h>
> ?#include <mach/hardware.h>
> ?#include <asm/mach/arch.h>
> +#include <linux/i2c.h>
>
> ?#include <mach/pxa27x.h>
> ?#include <mach/colibri.h>
> @@ -26,6 +27,8 @@
> ?#include <mach/ohci.h>
> ?#include <mach/pxa27x-udc.h>
>
> +#include <plat/i2c.h>
> +
> ?#include "generic.h"
> ?#include "devices.h"
>
> @@ -87,6 +90,25 @@ static void __init colibri_pxa270_uhc_init(void)
> ?static inline void colibri_pxa270_uhc_init(void) {}
> ?#endif
>
> +/******************************************************************************
> + * I2C RTC
> + ******************************************************************************/
> +#if defined(CONFIG_RTC_DRV_DS1307) || defined(CONFIG_RTC_DRV_DS1307_MODULE)
> +static struct i2c_board_info __initdata colibri_pxa270_i2c_devs[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? I2C_BOARD_INFO("m41t00", 0x68),
> + ? ? ? },
> +};
> +
> +static void __init colibri_pxa270_rtc_init(void)
> +{
> + ? ? ? pxa_set_i2c_info(NULL);
> + ? ? ? i2c_register_board_info(0, ARRAY_AND_SIZE(colibri_pxa270_i2c_devs));
> +}
> +#else
> +static inline void colibri_pxa270_rtc_init(void) {}
> +#endif
> +
> ?void __init colibri_pxa270_evalboard_init(void)
> ?{
> ? ? ? ?pxa_set_ffuart_info(NULL);
> @@ -95,4 +117,5 @@ void __init colibri_pxa270_evalboard_init(void)
>
> ? ? ? ?colibri_pxa270_mmc_init();
> ? ? ? ?colibri_pxa270_uhc_init();
> + ? ? ? colibri_pxa270_rtc_init();
> ?}
> diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
> index 8488dfe..1024da5 100644
> --- a/arch/arm/mach-pxa/colibri-pxa270.c
> +++ b/arch/arm/mach-pxa/colibri-pxa270.c
> @@ -73,6 +73,10 @@ static mfp_cfg_t colibri_pxa270_evalboard_pin_config[] __initdata = {
> ? ? ? ?GPIO1_GPIO, ? ? /* READY */
> ? ? ? ?GPIO84_GPIO, ? ?/* DETECT */
> ? ? ? ?GPIO107_GPIO, ? /* PPEN */
> +
> + ? ? ? /* I2C */
> + ? ? ? GPIO117_I2C_SCL,
> + ? ? ? GPIO118_I2C_SDA,
> ?};
> ?#else
> ?static mfp_cfg_t colibri_pxa270_evalboard_pin_config[] __initdata = {};
> diff --git a/arch/arm/mach-pxa/colibri-pxa300.c b/arch/arm/mach-pxa/colibri-pxa300.c
> index dab49ce..5bf8055 100644
> --- a/arch/arm/mach-pxa/colibri-pxa300.c
> +++ b/arch/arm/mach-pxa/colibri-pxa300.c
> @@ -46,6 +46,10 @@ static mfp_cfg_t colibri_pxa300_evalboard_pin_config[] __initdata = {
> ? ? ? ?/* UHC */
> ? ? ? ?GPIO0_2_USBH_PEN,
> ? ? ? ?GPIO1_2_USBH_PWR,
> +
> + ? ? ? /* I2C */
> + ? ? ? GPIO21_I2C_SCL,
> + ? ? ? GPIO22_I2C_SDA,
> ?};
> ?#else
> ?static mfp_cfg_t colibri_pxa300_evalboard_pin_config[] __initdata = {};
> diff --git a/arch/arm/mach-pxa/colibri-pxa320.c b/arch/arm/mach-pxa/colibri-pxa320.c
> index e886ab2..4257382 100644
> --- a/arch/arm/mach-pxa/colibri-pxa320.c
> +++ b/arch/arm/mach-pxa/colibri-pxa320.c
> @@ -69,6 +69,10 @@ static mfp_cfg_t colibri_pxa320_evalboard_pin_config[] __initdata = {
> ? ? ? ?/* UHC */
> ? ? ? ?GPIO2_2_USBH_PEN,
> ? ? ? ?GPIO3_2_USBH_PWR,
> +
> + ? ? ? /* I2C */
> + ? ? ? GPIO32_I2C_SCL,
> + ? ? ? GPIO33_I2C_SDA,
> ?};
> ?#else
> ?static mfp_cfg_t colibri_pxa320_evalboard_pin_config[] __initdata = {};
> --
> 1.7.1
>
>
