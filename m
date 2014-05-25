From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 26 May 2014 06:41:11 +0900
Subject: [PATCH v2] cpufreq: exynos: Fix driver compilation with
 ARCH_MULTIPLATFORM
In-Reply-To: <1400858533-4327-1-git-send-email-t.figa@samsung.com>
References: <1400670752-673-1-git-send-email-t.figa@samsung.com>
 <1400858533-4327-1-git-send-email-t.figa@samsung.com>
Message-ID: <53826377.8060709@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/14 00:22, Tomasz Figa wrote:
> Currently Exynos cpufreq drivers rely on globally mapped clock
> controller registers to configure frequency of CPU cores. This is
> obviously wrong and will be removed in near future, but to enable
> support for multi-platform builds without introducing a regression it
> needs to be worked around.
>
> This patch hacks the code to look for clock controller node in device
> tree and map its registers using of_iomap(), instead of relying on
> global mapping, so dependencies on platform headers are removed and the
> driver can compile again with multiplatform support.
>
> Signed-off-by: Tomasz Figa<t.figa@samsung.com>
> ---
>   drivers/cpufreq/Kconfig.arm          |  6 ++---
>   drivers/cpufreq/exynos-cpufreq.c     |  2 --
>   drivers/cpufreq/exynos-cpufreq.h     | 30 ++++++++++++-------------
>   drivers/cpufreq/exynos4210-cpufreq.c | 39 +++++++++++++++++++++++++++-----
>   drivers/cpufreq/exynos4x12-cpufreq.c | 40 ++++++++++++++++++++++++++++-----
>   drivers/cpufreq/exynos5250-cpufreq.c | 43 +++++++++++++++++++++++++++++-------
>   6 files changed, 119 insertions(+), 41 deletions(-)
>
Viresh,

I'm not sure Thomas' v5 cpufreq-cpu0 driver can be upstreamed for 3.16 
because of dependency with others, some of them got ack though...

* "PM / OPP: move cpufreq specific helpers out of OPP layer"
- https://www.mail-archive.com/linux-omap at vger.kernel.org/msg104610.html
* "cpufreq: opp: Add device tree based lookup of boost mode frequency"
- http://www.spinics.net/lists/arm-kernel/msg334336.html

So firstly, I've queued this instead with exynos-multiplatform series...

How do you think?

- Kukjin

> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 6a7dd3e..36d20d0 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -31,7 +31,7 @@ config ARM_EXYNOS_CPUFREQ
>
>   config ARM_EXYNOS4210_CPUFREQ
>   	bool "SAMSUNG EXYNOS4210"
> -	depends on CPU_EXYNOS4210&&  !ARCH_MULTIPLATFORM
> +	depends on CPU_EXYNOS4210
>   	default y
>   	select ARM_EXYNOS_CPUFREQ
>   	help
> @@ -42,7 +42,7 @@ config ARM_EXYNOS4210_CPUFREQ
>
>   config ARM_EXYNOS4X12_CPUFREQ
>   	bool "SAMSUNG EXYNOS4x12"
> -	depends on (SOC_EXYNOS4212 || SOC_EXYNOS4412)&&  !ARCH_MULTIPLATFORM
> +	depends on SOC_EXYNOS4212 || SOC_EXYNOS4412
>   	default y
>   	select ARM_EXYNOS_CPUFREQ
>   	help
> @@ -53,7 +53,7 @@ config ARM_EXYNOS4X12_CPUFREQ
>
>   config ARM_EXYNOS5250_CPUFREQ
>   	bool "SAMSUNG EXYNOS5250"
> -	depends on SOC_EXYNOS5250&&  !ARCH_MULTIPLATFORM
> +	depends on SOC_EXYNOS5250
>   	default y
>   	select ARM_EXYNOS_CPUFREQ
>   	help
> diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
> index 7c2a096..1e0ec57 100644
> --- a/drivers/cpufreq/exynos-cpufreq.c
> +++ b/drivers/cpufreq/exynos-cpufreq.c
> @@ -19,8 +19,6 @@
>   #include<linux/platform_device.h>
>   #include<linux/of.h>
>
> -#include<plat/cpu.h>
> -
>   #include "exynos-cpufreq.h"
>
>   static struct exynos_dvfs_info *exynos_info;
> diff --git a/drivers/cpufreq/exynos-cpufreq.h b/drivers/cpufreq/exynos-cpufreq.h
> index a28ee9d..8dfebac 100644
> --- a/drivers/cpufreq/exynos-cpufreq.h
> +++ b/drivers/cpufreq/exynos-cpufreq.h
> @@ -50,6 +50,7 @@ struct exynos_dvfs_info {
>   	struct cpufreq_frequency_table	*freq_table;
>   	void (*set_freq)(unsigned int, unsigned int);
>   	bool (*need_apll_change)(unsigned int, unsigned int);
> +	void __iomem	*cmu_regs;
>   };
>
>   #ifdef CONFIG_ARM_EXYNOS4210_CPUFREQ
> @@ -77,24 +78,21 @@ static inline int exynos5250_cpufreq_init(struct exynos_dvfs_info *info)
>   }
>   #endif
>
> -#include<plat/cpu.h>
> -#include<mach/map.h>
> +#define EXYNOS4_CLKSRC_CPU			0x14200
> +#define EXYNOS4_CLKMUX_STATCPU			0x14400
>
> -#define EXYNOS4_CLKSRC_CPU			(S5P_VA_CMU + 0x14200)
> -#define EXYNOS4_CLKMUX_STATCPU			(S5P_VA_CMU + 0x14400)
> -
> -#define EXYNOS4_CLKDIV_CPU			(S5P_VA_CMU + 0x14500)
> -#define EXYNOS4_CLKDIV_CPU1			(S5P_VA_CMU + 0x14504)
> -#define EXYNOS4_CLKDIV_STATCPU			(S5P_VA_CMU + 0x14600)
> -#define EXYNOS4_CLKDIV_STATCPU1			(S5P_VA_CMU + 0x14604)
> +#define EXYNOS4_CLKDIV_CPU			0x14500
> +#define EXYNOS4_CLKDIV_CPU1			0x14504
> +#define EXYNOS4_CLKDIV_STATCPU			0x14600
> +#define EXYNOS4_CLKDIV_STATCPU1			0x14604
>
>   #define EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT	(16)
>   #define EXYNOS4_CLKMUX_STATCPU_MUXCORE_MASK	(0x7<<  EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT)
>
> -#define EXYNOS5_APLL_LOCK			(S5P_VA_CMU + 0x00000)
> -#define EXYNOS5_APLL_CON0			(S5P_VA_CMU + 0x00100)
> -#define EXYNOS5_CLKMUX_STATCPU			(S5P_VA_CMU + 0x00400)
> -#define EXYNOS5_CLKDIV_CPU0			(S5P_VA_CMU + 0x00500)
> -#define EXYNOS5_CLKDIV_CPU1			(S5P_VA_CMU + 0x00504)
> -#define EXYNOS5_CLKDIV_STATCPU0			(S5P_VA_CMU + 0x00600)
> -#define EXYNOS5_CLKDIV_STATCPU1			(S5P_VA_CMU + 0x00604)
> +#define EXYNOS5_APLL_LOCK			0x00000
> +#define EXYNOS5_APLL_CON0			0x00100
> +#define EXYNOS5_CLKMUX_STATCPU			0x00400
> +#define EXYNOS5_CLKDIV_CPU0			0x00500
> +#define EXYNOS5_CLKDIV_CPU1			0x00504
> +#define EXYNOS5_CLKDIV_STATCPU0			0x00600
> +#define EXYNOS5_CLKDIV_STATCPU1			0x00604
> diff --git a/drivers/cpufreq/exynos4210-cpufreq.c b/drivers/cpufreq/exynos4210-cpufreq.c
> index 6384e5b..61a5431 100644
> --- a/drivers/cpufreq/exynos4210-cpufreq.c
> +++ b/drivers/cpufreq/exynos4210-cpufreq.c
> @@ -16,6 +16,8 @@
>   #include<linux/io.h>
>   #include<linux/slab.h>
>   #include<linux/cpufreq.h>
> +#include<linux/of.h>
> +#include<linux/of_address.h>
>
>   #include "exynos-cpufreq.h"
>
> @@ -23,6 +25,7 @@ static struct clk *cpu_clk;
>   static struct clk *moutcore;
>   static struct clk *mout_mpll;
>   static struct clk *mout_apll;
> +static struct exynos_dvfs_info *cpufreq;
>
>   static unsigned int exynos4210_volt_table[] = {
>   	1250000, 1150000, 1050000, 975000, 950000,
> @@ -60,20 +63,20 @@ static void exynos4210_set_clkdiv(unsigned int div_index)
>
>   	tmp = apll_freq_4210[div_index].clk_div_cpu0;
>
> -	__raw_writel(tmp, EXYNOS4_CLKDIV_CPU);
> +	__raw_writel(tmp, cpufreq->cmu_regs + EXYNOS4_CLKDIV_CPU);
>
>   	do {
> -		tmp = __raw_readl(EXYNOS4_CLKDIV_STATCPU);
> +		tmp = __raw_readl(cpufreq->cmu_regs + EXYNOS4_CLKDIV_STATCPU);
>   	} while (tmp&  0x1111111);
>
>   	/* Change Divider - CPU1 */
>
>   	tmp = apll_freq_4210[div_index].clk_div_cpu1;
>
> -	__raw_writel(tmp, EXYNOS4_CLKDIV_CPU1);
> +	__raw_writel(tmp, cpufreq->cmu_regs + EXYNOS4_CLKDIV_CPU1);
>
>   	do {
> -		tmp = __raw_readl(EXYNOS4_CLKDIV_STATCPU1);
> +		tmp = __raw_readl(cpufreq->cmu_regs + EXYNOS4_CLKDIV_STATCPU1);
>   	} while (tmp&  0x11);
>   }
>
> @@ -85,7 +88,7 @@ static void exynos4210_set_apll(unsigned int index)
>   	clk_set_parent(moutcore, mout_mpll);
>
>   	do {
> -		tmp = (__raw_readl(EXYNOS4_CLKMUX_STATCPU)
> +		tmp = (__raw_readl(cpufreq->cmu_regs + EXYNOS4_CLKMUX_STATCPU)
>   			>>  EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT);
>   		tmp&= 0x7;
>   	} while (tmp != 0x2);
> @@ -96,7 +99,7 @@ static void exynos4210_set_apll(unsigned int index)
>   	clk_set_parent(moutcore, mout_apll);
>
>   	do {
> -		tmp = __raw_readl(EXYNOS4_CLKMUX_STATCPU);
> +		tmp = __raw_readl(cpufreq->cmu_regs + EXYNOS4_CLKMUX_STATCPU);
>   		tmp&= EXYNOS4_CLKMUX_STATCPU_MUXCORE_MASK;
>   	} while (tmp != (0x1<<  EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT));
>   }
> @@ -115,8 +118,30 @@ static void exynos4210_set_frequency(unsigned int old_index,
>
>   int exynos4210_cpufreq_init(struct exynos_dvfs_info *info)
>   {
> +	struct device_node *np;
>   	unsigned long rate;
>
> +	/*
> +	 * HACK: This is a temporary workaround to get access to clock
> +	 * controller registers directly and remove static mappings and
> +	 * dependencies on platform headers. It is necessary to enable
> +	 * Exynos multi-platform support and will be removed together with
> +	 * this whole driver as soon as Exynos gets migrated to use
> +	 * cpufreq-cpu0 driver.
> +	 */
> +	np = of_find_compatible_node(NULL, NULL, "samsung,exynos4210-clock");
> +	if (!np) {
> +		pr_err("%s: failed to find clock controller DT node\n",
> +			__func__);
> +		return -ENODEV;
> +	}
> +
> +	info->cmu_regs = of_iomap(np, 0);
> +	if (!info->cmu_regs) {
> +		pr_err("%s: failed to map CMU registers\n", __func__);
> +		return -EFAULT;
> +	}
> +
>   	cpu_clk = clk_get(NULL, "armclk");
>   	if (IS_ERR(cpu_clk))
>   		return PTR_ERR(cpu_clk);
> @@ -143,6 +168,8 @@ int exynos4210_cpufreq_init(struct exynos_dvfs_info *info)
>   	info->freq_table = exynos4210_freq_table;
>   	info->set_freq = exynos4210_set_frequency;
>
> +	cpufreq = info;
> +
>   	return 0;
>
>   err_mout_apll:
> diff --git a/drivers/cpufreq/exynos4x12-cpufreq.c b/drivers/cpufreq/exynos4x12-cpufreq.c
> index 63a3907..351a207 100644
> --- a/drivers/cpufreq/exynos4x12-cpufreq.c
> +++ b/drivers/cpufreq/exynos4x12-cpufreq.c
> @@ -16,6 +16,8 @@
>   #include<linux/io.h>
>   #include<linux/slab.h>
>   #include<linux/cpufreq.h>
> +#include<linux/of.h>
> +#include<linux/of_address.h>
>
>   #include "exynos-cpufreq.h"
>
> @@ -23,6 +25,7 @@ static struct clk *cpu_clk;
>   static struct clk *moutcore;
>   static struct clk *mout_mpll;
>   static struct clk *mout_apll;
> +static struct exynos_dvfs_info *cpufreq;
>
>   static unsigned int exynos4x12_volt_table[] = {
>   	1350000, 1287500, 1250000, 1187500, 1137500, 1087500, 1037500,
> @@ -105,19 +108,20 @@ static void exynos4x12_set_clkdiv(unsigned int div_index)
>
>   	tmp = apll_freq_4x12[div_index].clk_div_cpu0;
>
> -	__raw_writel(tmp, EXYNOS4_CLKDIV_CPU);
> +	__raw_writel(tmp, cpufreq->cmu_regs + EXYNOS4_CLKDIV_CPU);
>
> -	while (__raw_readl(EXYNOS4_CLKDIV_STATCPU)&  0x11111111)
> +	while (__raw_readl(cpufreq->cmu_regs + EXYNOS4_CLKDIV_STATCPU)
> +	&  0x11111111)
>   		cpu_relax();
>
>   	/* Change Divider - CPU1 */
>   	tmp = apll_freq_4x12[div_index].clk_div_cpu1;
>
> -	__raw_writel(tmp, EXYNOS4_CLKDIV_CPU1);
> +	__raw_writel(tmp, cpufreq->cmu_regs + EXYNOS4_CLKDIV_CPU1);
>
>   	do {
>   		cpu_relax();
> -		tmp = __raw_readl(EXYNOS4_CLKDIV_STATCPU1);
> +		tmp = __raw_readl(cpufreq->cmu_regs + EXYNOS4_CLKDIV_STATCPU1);
>   	} while (tmp != 0x0);
>   }
>
> @@ -130,7 +134,7 @@ static void exynos4x12_set_apll(unsigned int index)
>
>   	do {
>   		cpu_relax();
> -		tmp = (__raw_readl(EXYNOS4_CLKMUX_STATCPU)
> +		tmp = (__raw_readl(cpufreq->cmu_regs + EXYNOS4_CLKMUX_STATCPU)
>   			>>  EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT);
>   		tmp&= 0x7;
>   	} while (tmp != 0x2);
> @@ -142,7 +146,7 @@ static void exynos4x12_set_apll(unsigned int index)
>
>   	do {
>   		cpu_relax();
> -		tmp = __raw_readl(EXYNOS4_CLKMUX_STATCPU);
> +		tmp = __raw_readl(cpufreq->cmu_regs + EXYNOS4_CLKMUX_STATCPU);
>   		tmp&= EXYNOS4_CLKMUX_STATCPU_MUXCORE_MASK;
>   	} while (tmp != (0x1<<  EXYNOS4_CLKSRC_CPU_MUXCORE_SHIFT));
>   }
> @@ -161,8 +165,30 @@ static void exynos4x12_set_frequency(unsigned int old_index,
>
>   int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
>   {
> +	struct device_node *np;
>   	unsigned long rate;
>
> +	/*
> +	 * HACK: This is a temporary workaround to get access to clock
> +	 * controller registers directly and remove static mappings and
> +	 * dependencies on platform headers. It is necessary to enable
> +	 * Exynos multi-platform support and will be removed together with
> +	 * this whole driver as soon as Exynos gets migrated to use
> +	 * cpufreq-cpu0 driver.
> +	 */
> +	np = of_find_compatible_node(NULL, NULL, "samsung,exynos4412-clock");
> +	if (!np) {
> +		pr_err("%s: failed to find clock controller DT node\n",
> +			__func__);
> +		return -ENODEV;
> +	}
> +
> +	info->cmu_regs = of_iomap(np, 0);
> +	if (!info->cmu_regs) {
> +		pr_err("%s: failed to map CMU registers\n", __func__);
> +		return -EFAULT;
> +	}
> +
>   	cpu_clk = clk_get(NULL, "armclk");
>   	if (IS_ERR(cpu_clk))
>   		return PTR_ERR(cpu_clk);
> @@ -194,6 +220,8 @@ int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
>   	info->freq_table = exynos4x12_freq_table;
>   	info->set_freq = exynos4x12_set_frequency;
>
> +	cpufreq = info;
> +
>   	return 0;
>
>   err_mout_apll:
> diff --git a/drivers/cpufreq/exynos5250-cpufreq.c b/drivers/cpufreq/exynos5250-cpufreq.c
> index 363a0b3..c91ce69 100644
> --- a/drivers/cpufreq/exynos5250-cpufreq.c
> +++ b/drivers/cpufreq/exynos5250-cpufreq.c
> @@ -16,8 +16,8 @@
>   #include<linux/io.h>
>   #include<linux/slab.h>
>   #include<linux/cpufreq.h>
> -
> -#include<mach/map.h>
> +#include<linux/of.h>
> +#include<linux/of_address.h>
>
>   #include "exynos-cpufreq.h"
>
> @@ -25,6 +25,7 @@ static struct clk *cpu_clk;
>   static struct clk *moutcore;
>   static struct clk *mout_mpll;
>   static struct clk *mout_apll;
> +static struct exynos_dvfs_info *cpufreq;
>
>   static unsigned int exynos5250_volt_table[] = {
>   	1300000, 1250000, 1225000, 1200000, 1150000,
> @@ -87,17 +88,18 @@ static void set_clkdiv(unsigned int div_index)
>
>   	tmp = apll_freq_5250[div_index].clk_div_cpu0;
>
> -	__raw_writel(tmp, EXYNOS5_CLKDIV_CPU0);
> +	__raw_writel(tmp, cpufreq->cmu_regs + EXYNOS5_CLKDIV_CPU0);
>
> -	while (__raw_readl(EXYNOS5_CLKDIV_STATCPU0)&  0x11111111)
> +	while (__raw_readl(cpufreq->cmu_regs + EXYNOS5_CLKDIV_STATCPU0)
> +	&  0x11111111)
>   		cpu_relax();
>
>   	/* Change Divider - CPU1 */
>   	tmp = apll_freq_5250[div_index].clk_div_cpu1;
>
> -	__raw_writel(tmp, EXYNOS5_CLKDIV_CPU1);
> +	__raw_writel(tmp, cpufreq->cmu_regs + EXYNOS5_CLKDIV_CPU1);
>
> -	while (__raw_readl(EXYNOS5_CLKDIV_STATCPU1)&  0x11)
> +	while (__raw_readl(cpufreq->cmu_regs + EXYNOS5_CLKDIV_STATCPU1)&  0x11)
>   		cpu_relax();
>   }
>
> @@ -111,7 +113,8 @@ static void set_apll(unsigned int index)
>
>   	do {
>   		cpu_relax();
> -		tmp = (__raw_readl(EXYNOS5_CLKMUX_STATCPU)>>  16);
> +		tmp = (__raw_readl(cpufreq->cmu_regs + EXYNOS5_CLKMUX_STATCPU)
> +			>>  16);
>   		tmp&= 0x7;
>   	} while (tmp != 0x2);
>
> @@ -122,7 +125,7 @@ static void set_apll(unsigned int index)
>
>   	do {
>   		cpu_relax();
> -		tmp = __raw_readl(EXYNOS5_CLKMUX_STATCPU);
> +		tmp = __raw_readl(cpufreq->cmu_regs + EXYNOS5_CLKMUX_STATCPU);
>   		tmp&= (0x7<<  16);
>   	} while (tmp != (0x1<<  16));
>   }
> @@ -141,8 +144,30 @@ static void exynos5250_set_frequency(unsigned int old_index,
>
>   int exynos5250_cpufreq_init(struct exynos_dvfs_info *info)
>   {
> +	struct device_node *np;
>   	unsigned long rate;
>
> +	/*
> +	 * HACK: This is a temporary workaround to get access to clock
> +	 * controller registers directly and remove static mappings and
> +	 * dependencies on platform headers. It is necessary to enable
> +	 * Exynos multi-platform support and will be removed together with
> +	 * this whole driver as soon as Exynos gets migrated to use
> +	 * cpufreq-cpu0 driver.
> +	 */
> +	np = of_find_compatible_node(NULL, NULL, "samsung,exynos5250-clock");
> +	if (!np) {
> +		pr_err("%s: failed to find clock controller DT node\n",
> +			__func__);
> +		return -ENODEV;
> +	}
> +
> +	info->cmu_regs = of_iomap(np, 0);
> +	if (!info->cmu_regs) {
> +		pr_err("%s: failed to map CMU registers\n", __func__);
> +		return -EFAULT;
> +	}
> +
>   	cpu_clk = clk_get(NULL, "armclk");
>   	if (IS_ERR(cpu_clk))
>   		return PTR_ERR(cpu_clk);
> @@ -169,6 +194,8 @@ int exynos5250_cpufreq_init(struct exynos_dvfs_info *info)
>   	info->freq_table = exynos5250_freq_table;
>   	info->set_freq = exynos5250_set_frequency;
>
> +	cpufreq = info;
> +
>   	return 0;
>
>   err_mout_apll:

-- 
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
