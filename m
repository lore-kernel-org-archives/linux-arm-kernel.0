From: jassisinghbrar@gmail.com (jassi brar)
Date: Sat, 28 Nov 2009 10:31:03 +0900
Subject: [PATCH 6/7] S3C6410: Use platform data to supply pin
	configuration for IISv4
In-Reply-To: <1259340239-12067-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20091127164312.GA11913@rakim.wolfsonmicro.main>
	<1259340239-12067-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1b68c6790911271731y3b5aa5b7jafe3347dcb51b4d6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 28, 2009 at 1:43 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> Follow the lead of the PCM controller and make the driver less
> directly dependant on the particular CPU configuration.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> ?arch/arm/plat-s3c64xx/dev-audio.c | ? 22 ++++++++++++++++++++++
> ?1 files changed, 22 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-s3c64xx/dev-audio.c b/arch/arm/plat-s3c64xx/dev-audio.c
> index a21a88f..e49e1eb 100644
> --- a/arch/arm/plat-s3c64xx/dev-audio.c
> +++ b/arch/arm/plat-s3c64xx/dev-audio.c
> @@ -20,8 +20,10 @@
>
> ?#include <plat/devs.h>
> ?#include <plat/audio.h>
> +#include <plat/gpio-bank-c.h>
> ?#include <plat/gpio-bank-d.h>
> ?#include <plat/gpio-bank-e.h>
> +#include <plat/gpio-bank-h.h>
> ?#include <plat/gpio-cfg.h>
>
> ?static struct resource s3c64xx_iis0_resource[] = {
> @@ -56,6 +58,23 @@ struct platform_device s3c64xx_device_iis1 = {
> ?};
> ?EXPORT_SYMBOL(s3c64xx_device_iis1);
>
> +static int s3c64xx_iisv4_cfg_gpio(struct platform_device *pdev)
> +{
> + ? ? ? s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C64XX_GPC4_I2S_V40_DO0);
> + ? ? ? s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C64XX_GPC5_I2S_V40_DO1);
> + ? ? ? s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C64XX_GPC7_I2S_V40_DO2);
> + ? ? ? s3c_gpio_cfgpin(S3C64XX_GPH(6), S3C64XX_GPH6_I2S_V40_BCLK);
> + ? ? ? s3c_gpio_cfgpin(S3C64XX_GPH(7), S3C64XX_GPH7_I2S_V40_CDCLK);
> + ? ? ? s3c_gpio_cfgpin(S3C64XX_GPH(8), S3C64XX_GPH8_I2S_V40_LRCLK);
> + ? ? ? s3c_gpio_cfgpin(S3C64XX_GPH(9), S3C64XX_GPH9_I2S_V40_DI);
> +
> + ? ? ? return 0;
> +}
> +
> +static struct s3c_audio_pdata s3c64xx_iisv4_pdata = {
> + ? ? ? .cfg_gpio = s3c64xx_iisv4_cfg_gpio,
> +};
> +
Yes. And I was preparing for v3 I2S controllers of s3c64xx too to be
converted this way, otherwise the forthcoming support for 6440,C100,C110
etc wud need duplication of the code.

> ?static struct resource s3c64xx_iisv4_resource[] = {
> ? ? ? ?[0] = {
> ? ? ? ? ? ? ? ?.start = S3C64XX_PA_IISV4,
> @@ -69,6 +88,9 @@ struct platform_device s3c64xx_device_iisv4 = {
> ? ? ? ?.id ? ? ? ? ? ? ? = -1,
> ? ? ? ?.num_resources ? ?= ARRAY_SIZE(s3c64xx_iisv4_resource),
> ? ? ? ?.resource ? ? ? ? = s3c64xx_iisv4_resource,
> + ? ? ? .dev = {
> + ? ? ? ? ? ? ? .platform_data = &s3c64xx_iisv4_pdata,
> + ? ? ? },
> ?};
> ?EXPORT_SYMBOL(s3c64xx_device_iisv4);
