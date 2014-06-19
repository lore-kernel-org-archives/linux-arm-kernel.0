From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 19 Jun 2014 12:21:55 +0200
Subject: [PATCH v2] clocksource: exynos-mct: Register the timer for stable
 udelay
In-Reply-To: <1403167145-5267-1-git-send-email-amit.daniel@samsung.com>
References: <1403167145-5267-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <53A2B9C3.1050906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Amit,

Please see my comments inline.

On 19.06.2014 10:39, Amit Daniel Kachhap wrote:
> This patch register the exynos mct clocksource as the current timer
> as it has constant clock rate. This will generate correct udelay for the
> exynos platform and avoid using unnecessary calibrated jiffies. This change
> has been tested on exynos5420 based board and udelay is very close to
> expected.
> 
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
> Changes in V2:
> * Added #defines for ARM and ARM64 as pointed by Doug Anderson.
> 
> Patches from David Riley confirmed that udelay is broken in exynos5420.
> Link to those patches are,
> 1) https://patchwork.kernel.org/patch/4344911/
> 2) https://patchwork.kernel.org/patch/4344881/
> 
>  drivers/clocksource/exynos_mct.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index f71d55f..02927e2 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -195,10 +195,25 @@ static u64 notrace exynos4_read_sched_clock(void)
>  	return exynos4_frc_read(&mct_frc);
>  }
>  
> +static struct delay_timer exynos4_delay_timer;
> +
> +static unsigned long exynos4_read_current_timer(void)
> +{
> +#ifdef ARM
> +	return __raw_readl(reg_base + EXYNOS4_MCT_G_CNT_L);
> +#else /* ARM64, etc */
> +	return exynos4_frc_read(&mct_frc);
> +#endif
> +}
> +

No need for anything like this. Even if running on ARM64, the delay
timer code should be able to cope with different timer widths. For
delays, 32 bits are enough, so just always read the lower part.

Also use of raw accessors in drivers is discouraged - please use
readl_relaxed().

Btw. I don't even see support for this on ARM64 in mainline, where arch
timer is always used for delays and AFAIK this is a platform requirement.

>  static void __init exynos4_clocksource_init(void)
>  {
>  	exynos4_mct_frc_start();
>  
> +	exynos4_delay_timer.read_current_timer = &exynos4_read_current_timer;

nit: No need for & for function pointers.

Best regards,
Tomasz
