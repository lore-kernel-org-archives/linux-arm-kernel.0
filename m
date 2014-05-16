From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 16 May 2014 19:54:01 +0900
Subject: [PATCH v3] cpufreq: exynos:  Fix the compile error
In-Reply-To: <000001cf70f0$2e48f930$8adaeb90$@samsung.com>
References: <000001cf70f0$2e48f930$8adaeb90$@samsung.com>
Message-ID: <037e01cf70f5$25b374d0$711a5e70$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jonghwan Choi wrote:
> 
> Commit 7da83a80 ("ARM: EXYNOS: Migrate Exynos specific macros from plat to
> mach") which lands in samsung tree causes build breakage
> for cpufreq-exynos like following:
> 
> drivers/cpufreq/exynos-cpufreq.c: In function 'exynos_cpufreq_probe':
> drivers/cpufreq/exynos-cpufreq.c:166:2: error: implicit declaration of
> function 'soc_is_exynos4210'
> [-Werror=implicit-function-declaration]
> drivers/cpufreq/exynos-cpufreq.c:168:2: error: implicit declaration of
> function 'soc_is_exynos4212'
> [-Werror=implicit-function-declaration]
> drivers/cpufreq/exynos-cpufreq.c:168:2: error: implicit declaration of
> function 'soc_is_exynos4412'
> [-Werror=implicit-function-declaration]
> drivers/cpufreq/exynos-cpufreq.c:170:2: error: implicit declaration of
> function 'soc_is_exynos5250'
> [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors
> make[2]: *** [drivers/cpufreq/exynos-cpufreq.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> drivers/cpufreq/exynos4x12-cpufreq.c: In function 'exynos4x12_set_clkdiv':
> drivers/cpufreq/exynos4x12-cpufreq.c:118:2: error: implicit declaration of
> function 'soc_is_exynos4212'
> [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors
> make[2]: *** [drivers/cpufreq/exynos4x12-cpufreq.o] Error 1
> make[1]: *** [drivers/cpufreq] Error 2
> This fixes above error with getting SoC information via
> of_machine_is_compatible() instead of soc_is_exynosXXXX().
> 

Probably,
Suggested-by: Tomasz Figa ?

> Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>

Looks better.

Rafael, if you have no objection on this, shall I pick this into samsung
tree for 3.16 because of the current build breakage with enabling exynos
cpufreq?

Thanks,
Kukjin

> ---
>  drivers/cpufreq/exynos-cpufreq.c     |   20 +++++++++++++++++---
>  drivers/cpufreq/exynos-cpufreq.h     |    8 ++++++++
>  drivers/cpufreq/exynos4x12-cpufreq.c |   11 ++++-------
>  3 files changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-
> cpufreq.c
> index f99cfe2..9aecffef 100644
> --- a/drivers/cpufreq/exynos-cpufreq.c
> +++ b/drivers/cpufreq/exynos-cpufreq.c
> @@ -17,6 +17,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/cpufreq.h>
>  #include <linux/platform_device.h>
> +#include <linux/of.h>
> 
>  #include <plat/cpu.h>
> 
> @@ -163,11 +164,24 @@ static int exynos_cpufreq_probe(struct
> platform_device *pdev)
>  	if (!exynos_info)
>  		return -ENOMEM;
> 
> -	if (soc_is_exynos4210())
> +	if (of_machine_is_compatible("samsung,exynos4210")) {
> +		exynos_info->type = EXYNOS_SOC_4210;
> +	} else if (of_machine_is_compatible("samsung,exynos4212")) {
> +		exynos_info->type = EXYNOS_SOC_4212;
> +	} else if (of_machine_is_compatible("samsung,exynos4412")) {
> +		exynos_info->type = EXYNOS_SOC_4212;
> +	} else if (of_machine_is_compatible("samsung,exynos5250")) {
> +		exynos_info->type = EXYNOS_SOC_5250;
> +	} else {
> +		pr_err("%s: Unknown SoC type\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	if (exynos_info->type == EXYNOS_SOC_4210)
>  		ret = exynos4210_cpufreq_init(exynos_info);
> -	else if (soc_is_exynos4212() || soc_is_exynos4412())
> +	else if (exynos_info->type == EXYNOS_SOC_4212 || exynos_info->type
> == EXYNOS_SOC_4412)
>  		ret = exynos4x12_cpufreq_init(exynos_info);
> -	else if (soc_is_exynos5250())
> +	else if (exynos_info->type == EXYNOS_SOC_5250)
>  		ret = exynos5250_cpufreq_init(exynos_info);
>  	else
>  		return 0;
> diff --git a/drivers/cpufreq/exynos-cpufreq.h b/drivers/cpufreq/exynos-
> cpufreq.h
> index 3ddade8..f189547 100644
> --- a/drivers/cpufreq/exynos-cpufreq.h
> +++ b/drivers/cpufreq/exynos-cpufreq.h
> @@ -17,6 +17,13 @@ enum cpufreq_level_index {
>  	L20,
>  };
> 
> +enum exynos_soc_type {
> +	EXYNOS_SOC_4210,
> +	EXYNOS_SOC_4212,
> +	EXYNOS_SOC_4412,
> +	EXYNOS_SOC_5250,
> +};
> +
>  #define APLL_FREQ(f, a0, a1, a2, a3, a4, a5, a6, a7, b0, b1, b2, m, p, s)
> \
>  	{ \
>  		.freq = (f) * 1000, \
> @@ -34,6 +41,7 @@ struct apll_freq {
>  };
> 
>  struct exynos_dvfs_info {
> +	enum exynos_soc_type type;
>  	unsigned long	mpll_freq_khz;
>  	unsigned int	pll_safe_idx;
>  	struct clk	*cpu_clk;
> diff --git a/drivers/cpufreq/exynos4x12-cpufreq.c
> b/drivers/cpufreq/exynos4x12-cpufreq.c
> index 466c76a..63a3907 100644
> --- a/drivers/cpufreq/exynos4x12-cpufreq.c
> +++ b/drivers/cpufreq/exynos4x12-cpufreq.c
> @@ -100,7 +100,6 @@ static struct apll_freq apll_freq_4412[] = {
>  static void exynos4x12_set_clkdiv(unsigned int div_index)
>  {
>  	unsigned int tmp;
> -	unsigned int stat_cpu1;
> 
>  	/* Change Divider - CPU0 */
> 
> @@ -115,13 +114,11 @@ static void exynos4x12_set_clkdiv(unsigned int
> div_index)
>  	tmp = apll_freq_4x12[div_index].clk_div_cpu1;
> 
>  	__raw_writel(tmp, EXYNOS4_CLKDIV_CPU1);
> -	if (soc_is_exynos4212())
> -		stat_cpu1 = 0x11;
> -	else
> -		stat_cpu1 = 0x111;
> 
> -	while (__raw_readl(EXYNOS4_CLKDIV_STATCPU1) & stat_cpu1)
> +	do {
>  		cpu_relax();
> +		tmp = __raw_readl(EXYNOS4_CLKDIV_STATCPU1);
> +	} while (tmp != 0x0);
>  }
> 
>  static void exynos4x12_set_apll(unsigned int index)
> @@ -184,7 +181,7 @@ int exynos4x12_cpufreq_init(struct exynos_dvfs_info
> *info)
>  	if (IS_ERR(mout_apll))
>  		goto err_mout_apll;
> 
> -	if (soc_is_exynos4212())
> +	if (info->type == EXYNOS_SOC_4212)
>  		apll_freq_4x12 = apll_freq_4212;
>  	else
>  		apll_freq_4x12 = apll_freq_4412;
> --
> 1.7.10.4
