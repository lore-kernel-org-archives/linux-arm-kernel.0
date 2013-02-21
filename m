From: nm@ti.com (Nishanth Menon)
Date: Thu, 21 Feb 2013 08:59:02 -0600
Subject: [PATCH] PM / OPP: fix condition for empty of_init_opp_table()
In-Reply-To: <1361444685-1034-1-git-send-email-shawn.guo@linaro.org>
References: <1361444685-1034-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130221145902.GA22712@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19:04-20130221, Shawn Guo wrote:
> randconfig build reports the following error which is caused by that
> CONFIG_PM_OPP is unset.
> 
Minor: caused by CONFIG_PM_OPP not being set?
>   CC      arch/arm/mach-imx/mach-imx6q.o
> arch/arm/mach-imx/mach-imx6q.c: In function ?imx6q_opp_init?:
> arch/arm/mach-imx/mach-imx6q.c:248:2: error: implicit declaration of function ?of_init_opp_table? [-Werror=implicit-function-declaration]
thanks for catching this.
> 
> Fix the error by giving a more correct condition for empty
> of_init_opp_table() implementation.
> 
> Reported-by: Rob Herring <robherring2@gmail.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  include/linux/opp.h |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/opp.h b/include/linux/opp.h
> index 214e0eb..3aca2b8 100644
> --- a/include/linux/opp.h
> +++ b/include/linux/opp.h
> @@ -47,15 +47,6 @@ int opp_enable(struct device *dev, unsigned long freq);
>  int opp_disable(struct device *dev, unsigned long freq);
>  
>  struct srcu_notifier_head *opp_get_notifier(struct device *dev);
> -
> -#ifdef CONFIG_OF
> -int of_init_opp_table(struct device *dev);
> -#else
> -static inline int of_init_opp_table(struct device *dev)
> -{
> -	return -EINVAL;
> -}
> -#endif /* CONFIG_OF */
>  #else
>  static inline unsigned long opp_get_voltage(struct opp *opp)
>  {
> @@ -112,6 +103,15 @@ static inline struct srcu_notifier_head *opp_get_notifier(struct device *dev)
>  }
>  #endif		/* CONFIG_PM_OPP */
>  
> +#if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
> +int of_init_opp_table(struct device *dev);
> +#else
> +static inline int of_init_opp_table(struct device *dev)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +
>  #if defined(CONFIG_CPU_FREQ) && defined(CONFIG_PM_OPP)
>  int opp_init_cpufreq_table(struct device *dev,
>  			    struct cpufreq_frequency_table **table);

Acked-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
