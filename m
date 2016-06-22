From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 22 Jun 2016 13:59:13 +0200
Subject: [PATCH 1/2] cpufreq: exynos: use relaxed IO accesors
In-Reply-To: <1466587984-14105-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466587984-14105-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <CAJKOXPf--C=PXmMthaLy8MVL8BBFe9gWaFv9sMh6Xzft4k6U8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 11:33 AM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> The use of __raw IO accesors is not endian safe and should be used
> sparingly. The relaxed variants should be as lightweight and also
> are endian safe.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm at vger.kernel.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/cpufreq/exynos5440-cpufreq.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
> index c0f3373..7a5707f 100644
> --- a/drivers/cpufreq/exynos5440-cpufreq.c
> +++ b/drivers/cpufreq/exynos5440-cpufreq.c
> @@ -155,7 +155,7 @@ static int init_div_table(void)
>                 tmp = (clk_div | ema_div | (volt_id << P0_7_VDD_SHIFT)
>                         | ((freq / FREQ_UNIT) << P0_7_FREQ_SHIFT));
>
> -               __raw_writel(tmp, dvfs_info->base + XMU_PMU_P0_7 + 4 *
> +               writel_relaxed(tmp, dvfs_info->base + XMU_PMU_P0_7 + 4 *
>                                                 (pos - freq_tbl));
>         }
>
> @@ -169,17 +169,17 @@ static void exynos_enable_dvfs(unsigned int cur_frequency)
>         struct cpufreq_frequency_table *freq_table = dvfs_info->freq_table;
>         struct cpufreq_frequency_table *pos;
>         /* Disable DVFS */
> -       __raw_writel(0, dvfs_info->base + XMU_DVFS_CTRL);
> +       writel_relaxed(0,       dvfs_info->base + XMU_DVFS_CTRL);

Please fix the whitespace.

Rest looks good but this patch appeared twice. I suspect they are the same?

Best regards,
Krzysztof
