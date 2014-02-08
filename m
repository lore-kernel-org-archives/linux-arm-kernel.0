From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 08 Feb 2014 21:23:24 +0100
Subject: [PATCH 01/12] ARM: S3C24XX: cpufreq-utils: don't write raw values
 to MPLLCON when using ccf
In-Reply-To: <201312131357.19899.heiko@sntech.de>
References: <201312131356.40755.heiko@sntech.de>
 <201312131357.19899.heiko@sntech.de>
Message-ID: <52F6923C.3040103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 13.12.2013 13:57, Heiko St?bner wrote:
> The s3c24xx cpufreq driver needs to change the mpll speed and was doing
> this by writing raw values from a translation table into the MPLLCON
> register.
>
> Change this to use a regular clk_set_rate call when using the common
> clock framework and only write the raw value in the samsung_clock case.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   arch/arm/mach-s3c24xx/cpufreq-utils.c |   13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm/mach-s3c24xx/cpufreq-utils.c b/arch/arm/mach-s3c24xx/cpufreq-utils.c
> index 2a0aa56..680a031 100644
> --- a/arch/arm/mach-s3c24xx/cpufreq-utils.c
> +++ b/arch/arm/mach-s3c24xx/cpufreq-utils.c
> @@ -14,6 +14,7 @@
>   #include <linux/errno.h>
>   #include <linux/cpufreq.h>
>   #include <linux/io.h>
> +#include <linux/clk.h>
>
>   #include <mach/map.h>
>   #include <mach/regs-clock.h>
> @@ -60,5 +61,17 @@ void s3c2410_cpufreq_setrefresh(struct s3c_cpufreq_config *cfg)
>    */
>   void s3c2410_set_fvco(struct s3c_cpufreq_config *cfg)
>   {
> +#ifdef CONFIG_SAMSUNG_CLOCK
>   	__raw_writel(cfg->pll.driver_data, S3C2410_MPLLCON);
> +#endif
> +
> +#ifdef CONFIG_COMMON_CLK
> +	struct clk *mpll = clk_get(NULL, "mpll");
> +	if (IS_ERR(mpll))
> +		return;

Wouldn't it be more sensible to get the clock only once, at the time 
cpufreq is initialized? This would avoid going through the list of all 
clocks every CPU frequency change and be more semantically correct.

If there is no good place to put this clk_get() then maybe it could be 
simply called on first call to s3c2410_set_fvco() and the clock saved to 
a static variable.

Best regards,
Tomasz
