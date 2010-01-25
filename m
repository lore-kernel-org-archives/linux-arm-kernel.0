From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 25 Jan 2010 10:46:26 +0100
Subject: [PATCH 4/4] ARM: S3C64XX: Add s3c64xx support to touchscreen
	driver
In-Reply-To: <b2e8f9f71001221447u550c9713l9f04aeec030c86db@mail.gmail.com>
	(Maurus Cuelenaere's message of "Fri\,
	22 Jan 2010 23\:47\:17 +0100")
References: <b2e8f9f71001221447u550c9713l9f04aeec030c86db@mail.gmail.com>
Message-ID: <87aaw2zfd9.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maurus Cuelenaere <mcuelenaere@gmail.com> writes:

Hi,

> ARM: S3C64XX: Add s3c64xx support to touchscreen driver
>
> This ack's the extra interrupt s3c64xx platforms have in the touchscreen driver.
>
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> ---
>  drivers/input/touchscreen/Kconfig      |    6 +++---
>  drivers/input/touchscreen/s3c2410_ts.c |   28 ++++++++++++++++++++++++----
>  2 files changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/input/touchscreen/Kconfig
> b/drivers/input/touchscreen/Kconfig
> index dfafc76..0378b3d 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -146,11 +146,11 @@ config TOUCHSCREEN_FUJITSU
>  	  module will be called fujitsu-ts.
>
>  config TOUCHSCREEN_S3C2410
> -	tristate "Samsung S3C2410 touchscreen input driver"
> -	depends on ARCH_S3C2410
> +	tristate "Samsung S3C touchscreen input driver"
> +	depends on ARCH_S3C2410 || ARCH_S3C64XX
>  	select S3C24XX_ADC
>  	help
> -	  Say Y here if you have the s3c2410 touchscreen.
> +	  Say Y here if you have the s3c touchscreen.
>
>  	  If unsure, say N.
>
> diff --git a/drivers/input/touchscreen/s3c2410_ts.c
> b/drivers/input/touchscreen/s3c2410_ts.c
> index 3debbc2..7dfbc38 100644
> --- a/drivers/input/touchscreen/s3c2410_ts.c
> +++ b/drivers/input/touchscreen/s3c2410_ts.c
> @@ -40,7 +40,9 @@
>  #include <plat/regs-adc.h>
>  #include <plat/ts.h>
>
> +#ifdef PLAT_S3C24XX
>  #include <mach/regs-gpio.h>
> +#endif
>
>  #define TSC_SLEEP  (S3C2410_ADCTSC_PULL_UP_DISABLE | S3C2410_ADCTSC_XY_PST(0))
>
> @@ -88,6 +90,12 @@ struct s3c2410ts {
>
>  static struct s3c2410ts ts;
>
> +enum s3c_cpu_type {
> +	TYPE_S3C2410,
> +	TYPE_S3C2440,
> +	TYPE_S3C64XX,
> +};
> +
>  /**
>   * s3c2410_ts_connect - configure gpio for s3c2410 systems
>   *
> @@ -95,6 +103,7 @@ static struct s3c2410ts ts;
>   * connected to the device (later systems such as the S3C2440 integrate
>   * these into the device).
>  */
> +#ifdef PLAT_S3C24XX
>  static inline void s3c2410_ts_connect(void)
>  {
>  	s3c2410_gpio_cfgpin(S3C2410_GPG(12), S3C2410_GPG12_XMON);
> @@ -102,6 +111,7 @@ static inline void s3c2410_ts_connect(void)
>  	s3c2410_gpio_cfgpin(S3C2410_GPG(14), S3C2410_GPG14_YMON);
>  	s3c2410_gpio_cfgpin(S3C2410_GPG(15), S3C2410_GPG15_nYPON);
>  }
> +#endif

Please, remove all theses #ifdef. I don't see the point of them as it's
only few lines of C code and they don't get executed when running on
other platforms than 2410.

Arnaud
