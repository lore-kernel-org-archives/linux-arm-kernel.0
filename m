From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 29 Jan 2015 08:53:19 +0530
Subject: [PATCH 1/3] cpufreq: s3c: remove incorrect __init annotations
In-Reply-To: <1422451015-390439-2-git-send-email-arnd@arndb.de>
References: <1422451015-390439-1-git-send-email-arnd@arndb.de>
 <1422451015-390439-2-git-send-email-arnd@arndb.de>
Message-ID: <CAKohpok5XsZ3o-Q_Ber8n5GaThe1x7BiHqFyHPSDLUDpyCXxog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 January 2015 at 18:46, Arnd Bergmann <arnd@arndb.de> wrote:
> The two functions s3c2416_cpufreq_driver_init and s3c_cpufreq_register
> are marked init but are called from a context that might be run after
> the __init sections are discarded, as the compiler points out:
>
> WARNING: vmlinux.o(.data+0x1ad9dc): Section mismatch in reference from the variable s3c2416_cpufreq_driver to the function .init.text:s3c2416_cpufreq_driver_init()
> WARNING: drivers/built-in.o(.text+0x35b5dc): Section mismatch in reference from the function s3c2410a_cpufreq_add() to the function .init.text:s3c_cpufreq_register()
>
> This removes the __init markings.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: stable at vger.kernel.org
> ---
>  drivers/cpufreq/s3c2416-cpufreq.c | 4 ++--
>  drivers/cpufreq/s3c24xx-cpufreq.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/s3c2416-cpufreq.c b/drivers/cpufreq/s3c2416-cpufreq.c
> index 2fd53eaaec20..d6d425773fa4 100644
> --- a/drivers/cpufreq/s3c2416-cpufreq.c
> +++ b/drivers/cpufreq/s3c2416-cpufreq.c
> @@ -263,7 +263,7 @@ out:
>  }
>
>  #ifdef CONFIG_ARM_S3C2416_CPUFREQ_VCORESCALE
> -static void __init s3c2416_cpufreq_cfg_regulator(struct s3c2416_data *s3c_freq)
> +static void s3c2416_cpufreq_cfg_regulator(struct s3c2416_data *s3c_freq)
>  {
>         int count, v, i, found;
>         struct cpufreq_frequency_table *pos;
> @@ -333,7 +333,7 @@ static struct notifier_block s3c2416_cpufreq_reboot_notifier = {
>         .notifier_call = s3c2416_cpufreq_reboot_notifier_evt,
>  };
>
> -static int __init s3c2416_cpufreq_driver_init(struct cpufreq_policy *policy)
> +static int s3c2416_cpufreq_driver_init(struct cpufreq_policy *policy)
>  {
>         struct s3c2416_data *s3c_freq = &s3c2416_cpufreq;
>         struct cpufreq_frequency_table *pos;
> diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
> index d00f1cee4509..bd340a1ca87d 100644
> --- a/drivers/cpufreq/s3c24xx-cpufreq.c
> +++ b/drivers/cpufreq/s3c24xx-cpufreq.c
> @@ -454,7 +454,7 @@ static struct cpufreq_driver s3c24xx_driver = {
>  };
>
>
> -int __init s3c_cpufreq_register(struct s3c_cpufreq_info *info)
> +int s3c_cpufreq_register(struct s3c_cpufreq_info *info)
>  {
>         if (!info || !info->name) {
>                 printk(KERN_ERR "%s: failed to pass valid information\n",

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
