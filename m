From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 16 Mar 2011 09:38:11 +0100
Subject: [PATCH] ARM: S3C64XX: Fix section mismatch from cpufreq init
In-Reply-To: <1299769093-14516-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1299769093-14516-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20110316083811.GG13316@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2011 at 02:58:13PM +0000, Mark Brown wrote:
> The cpufreq init function is referenced from the driver structure and
> we don't appear to have annotations which allow us to mark that it'll
> never be called after system init, causing the linker consistency
> infrastructure to complain. Just remove the __init annotation to avoid
> noise from the build.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/cpufreq.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/cpufreq.c b/arch/arm/mach-s3c64xx/cpufreq.c
> index 74c0e83..4375b97 100644
> --- a/arch/arm/mach-s3c64xx/cpufreq.c
> +++ b/arch/arm/mach-s3c64xx/cpufreq.c
> @@ -181,7 +181,7 @@ static void __init s3c64xx_cpufreq_config_regulator(void)
>  }
>  #endif
>  
> -static int __init s3c64xx_cpufreq_driver_init(struct cpufreq_policy *policy)
> +static int s3c64xx_cpufreq_driver_init(struct cpufreq_policy *policy)
>  {
>  	int ret;
>  	struct cpufreq_frequency_table *freq;
Actually this is warning is a false positive.  There is a section
mismatch, but it is never a problem because the .init callback is only
called by cpufreq_register_driver. To get rid of the warning the right
fix is to remove the .init callback from struct cpufreq_driver and
change the prototype of cpufreq_register_driver to

	int cpufreq_register_driver(struct cpufreq_driver *, int (*)(struct cpufreq_policy *))

(that is pass the init callback to cpufreq_register_driver).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
