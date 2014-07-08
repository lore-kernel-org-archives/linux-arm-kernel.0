From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 08 Jul 2014 16:21:09 +0200
Subject: [RFC PATCH 1/3] watchdog: s3c2410: add restart notifier
In-Reply-To: <10183342.ZfePbPvRx9@diego>
References: <1531376.ijR0PPyvmJ@diego> <10183342.ZfePbPvRx9@diego>
Message-ID: <53BBFE55.4080202@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 06.07.2014 20:42, Heiko St?bner wrote:
> On a lot of Samsung systems the watchdog is responsible for restarting the
> system and until now this code was contained in plat-samsung/watchdog-reset.c .
> 
> With the introduction of the restart notifiers, this code can now move into
> driver itself, removing the need for arch-specific code.
> 
> Tested on a S3C2442 based GTA02
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/watchdog/s3c2410_wdt.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 7c6ccd0..3f89912 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -41,6 +41,7 @@
>  #include <linux/of.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
> +#include <linux/reboot.h>
>  
>  #define S3C2410_WTCON		0x00
>  #define S3C2410_WTDAT		0x04
> @@ -438,6 +439,31 @@ static inline void s3c2410wdt_cpufreq_deregister(struct s3c2410_wdt *wdt)
>  }
>  #endif
>  
> +static struct s3c2410_wdt *s3c2410wdt_restart_ctx;

This isn't the most elegant way to store context data. Maybe you could
embed the notifier_block struct into s3c2410_wdt struct and then use
container of to retrieve it from s3c2410wdt_restart_notify()?

> +static int s3c2410wdt_restart_notify(struct notifier_block *this,
> +				     unsigned long mode, void *cmd)
> +{
> +	void __iomem *wdt_base = s3c2410wdt_restart_ctx->reg_base;
> +
> +	/* disable watchdog, to be safe  */
> +	writel(0, wdt_base + S3C2410_WTCON);
> +
> +	/* put initial values into count and data */
> +	writel(0x80, wdt_base + S3C2410_WTCNT);
> +	writel(0x80, wdt_base + S3C2410_WTDAT);
> +
> +	/* set the watchdog to go and reset... */
> +	writel(S3C2410_WTCON_ENABLE | S3C2410_WTCON_DIV16 |
> +		S3C2410_WTCON_RSTEN | S3C2410_WTCON_PRESCALE(0x20),
> +		wdt_base + S3C2410_WTCON);

I wonder whether you shouldn't wait a bit here for the reset to be
actually triggered.

Best regards,
Tomasz
