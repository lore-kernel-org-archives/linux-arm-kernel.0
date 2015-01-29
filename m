From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 29 Jan 2015 08:53:31 +0530
Subject: [PATCH 2/3] cpufreq: s3c: remove last use of resume_clocks
 callback
In-Reply-To: <1422451015-390439-3-git-send-email-arnd@arndb.de>
References: <1422451015-390439-1-git-send-email-arnd@arndb.de>
 <1422451015-390439-3-git-send-email-arnd@arndb.de>
Message-ID: <CAKohpo=v7SLii7ykqWfpf0ZAzCF6Oi9_ARVNmTu9u4j9poXafA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 January 2015 at 18:46, Arnd Bergmann <arnd@arndb.de> wrote:
> Commit 32726d2d550 ("ARM: SAMSUNG: Remove legacy clock code")
> already removed the callback pointer, but there was one remaining
> user:
>
> drivers/cpufreq/s3c24xx-cpufreq.c: In function 's3c_cpufreq_resume_clocks':
> drivers/cpufreq/s3c24xx-cpufreq.c:149:14: error: 'struct s3c_cpufreq_info' has no member named 'resume_clocks'
>   cpu_cur.info->resume_clocks();
>               ^
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 32726d2d550 ("ARM: SAMSUNG: Remove legacy clock code")
> Cc: stable at vger.kernel.org # v3.17+
> ---
>  drivers/cpufreq/s3c24xx-cpufreq.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
> index bd340a1ca87d..733aa5153e74 100644
> --- a/drivers/cpufreq/s3c24xx-cpufreq.c
> +++ b/drivers/cpufreq/s3c24xx-cpufreq.c
> @@ -144,11 +144,6 @@ static void s3c_cpufreq_setfvco(struct s3c_cpufreq_config *cfg)
>         (cfg->info->set_fvco)(cfg);
>  }
>
> -static inline void s3c_cpufreq_resume_clocks(void)
> -{
> -       cpu_cur.info->resume_clocks();
> -}
> -
>  static inline void s3c_cpufreq_updateclk(struct clk *clk,
>                                          unsigned int freq)
>  {
> @@ -417,9 +412,6 @@ static int s3c_cpufreq_resume(struct cpufreq_policy *policy)
>
>         last_target = ~0;       /* invalidate last_target setting */
>
> -       /* first, find out what speed we resumed at. */
> -       s3c_cpufreq_resume_clocks();
> -
>         /* whilst we will be called later on, we try and re-set the
>          * cpu frequencies as soon as possible so that we do not end
>          * up resuming devices and then immediately having to re-set

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
