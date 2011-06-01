From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 1 Jun 2011 18:55:05 +0900
Subject: [PATCH 1/5] CPUFREQ/S3C64xx: Move S3C64xx CPUfreq driver into
	drivers/cpufreq
In-Reply-To: <1306921493-30911-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20110601094313.GA23122@opensource.wolfsonmicro.com>
	<1306921493-30911-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <BANLkTinR_WLjsgm5ogt_BbJwPFC0Kc1Dqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Instead of samsung tree, it should be handled at cpufreq tree.
CCed the cpufreq maintainer.

Thank you,
Kyungmin Park

On Wed, Jun 1, 2011 at 6:44 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> This is a straight code motion patch, there are no changes to the driver
> itself. The Kconfig is left untouched as the ARM CPUfreq Kconfig is all
> in one big block in arm/Kconfig and should be moved en masse rather than
> being done piecemeal.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> ?arch/arm/mach-s3c64xx/Makefile ?| ? ?4 -
> ?arch/arm/mach-s3c64xx/cpufreq.c | ?270 ---------------------------------------
> ?drivers/cpufreq/Makefile ? ? ? ?| ? ?1 +
> ?drivers/cpufreq/s3c64xx.c ? ? ? | ?269 ++++++++++++++++++++++++++++++++++++++
> ?4 files changed, 270 insertions(+), 274 deletions(-)
> ?delete mode 100644 arch/arm/mach-s3c64xx/cpufreq.c
> ?create mode 100644 drivers/cpufreq/s3c64xx.c
>
> diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
> index 4657363..f5a7144 100644
> --- a/arch/arm/mach-s3c64xx/Makefile
> +++ b/arch/arm/mach-s3c64xx/Makefile
> @@ -23,10 +23,6 @@ obj-$(CONFIG_CPU_S3C6410) ? ?+= s3c6410.o
> ?obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?+= irq.o
> ?obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?+= irq-eint.o
>
> -# CPU frequency scaling
> -
> -obj-$(CONFIG_CPU_FREQ_S3C64XX) ?+= cpufreq.o
> -
> ?# DMA support
>
> ?obj-$(CONFIG_S3C64XX_DMA) ? ? ?+= dma.o
> diff --git a/arch/arm/mach-s3c64xx/cpufreq.c b/arch/arm/mach-s3c64xx/cpufreq.c
> deleted file mode 100644
> index 4375b97..0000000
> --- a/arch/arm/mach-s3c64xx/cpufreq.c
> +++ /dev/null
> @@ -1,270 +0,0 @@
> -/* linux/arch/arm/plat-s3c64xx/cpufreq.c
> - *
> - * Copyright 2009 Wolfson Microelectronics plc
> - *
> - * S3C64xx CPUfreq Support
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/types.h>
> -#include <linux/init.h>
> -#include <linux/cpufreq.h>
> -#include <linux/clk.h>
> -#include <linux/err.h>
> -#include <linux/regulator/consumer.h>
> -
> -static struct clk *armclk;
> -static struct regulator *vddarm;
> -static unsigned long regulator_latency;
> -
> -#ifdef CONFIG_CPU_S3C6410
> -struct s3c64xx_dvfs {
> - ? ? ? unsigned int vddarm_min;
> - ? ? ? unsigned int vddarm_max;
> -};
> -
> -static struct s3c64xx_dvfs s3c64xx_dvfs_table[] = {
> - ? ? ? [0] = { 1000000, 1150000 },
> - ? ? ? [1] = { 1050000, 1150000 },
> - ? ? ? [2] = { 1100000, 1150000 },
> - ? ? ? [3] = { 1200000, 1350000 },
> -};
> -
> -static struct cpufreq_frequency_table s3c64xx_freq_table[] = {
> - ? ? ? { 0, ?66000 },
> - ? ? ? { 0, 133000 },
> - ? ? ? { 1, 222000 },
> - ? ? ? { 1, 266000 },
> - ? ? ? { 2, 333000 },
> - ? ? ? { 2, 400000 },
> - ? ? ? { 2, 532000 },
> - ? ? ? { 2, 533000 },
> - ? ? ? { 3, 667000 },
> - ? ? ? { 0, CPUFREQ_TABLE_END },
> -};
> -#endif
> -
> -static int s3c64xx_cpufreq_verify_speed(struct cpufreq_policy *policy)
> -{
> - ? ? ? if (policy->cpu != 0)
> - ? ? ? ? ? ? ? return -EINVAL;
> -
> - ? ? ? return cpufreq_frequency_table_verify(policy, s3c64xx_freq_table);
> -}
> -
> -static unsigned int s3c64xx_cpufreq_get_speed(unsigned int cpu)
> -{
> - ? ? ? if (cpu != 0)
> - ? ? ? ? ? ? ? return 0;
> -
> - ? ? ? return clk_get_rate(armclk) / 1000;
> -}
> -
> -static int s3c64xx_cpufreq_set_target(struct cpufreq_policy *policy,
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned int target_freq,
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned int relation)
> -{
> - ? ? ? int ret;
> - ? ? ? unsigned int i;
> - ? ? ? struct cpufreq_freqs freqs;
> - ? ? ? struct s3c64xx_dvfs *dvfs;
> -
> - ? ? ? ret = cpufreq_frequency_table_target(policy, s3c64xx_freq_table,
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?target_freq, relation, &i);
> - ? ? ? if (ret != 0)
> - ? ? ? ? ? ? ? return ret;
> -
> - ? ? ? freqs.cpu = 0;
> - ? ? ? freqs.old = clk_get_rate(armclk) / 1000;
> - ? ? ? freqs.new = s3c64xx_freq_table[i].frequency;
> - ? ? ? freqs.flags = 0;
> - ? ? ? dvfs = &s3c64xx_dvfs_table[s3c64xx_freq_table[i].index];
> -
> - ? ? ? if (freqs.old == freqs.new)
> - ? ? ? ? ? ? ? return 0;
> -
> - ? ? ? pr_debug("cpufreq: Transition %d-%dkHz\n", freqs.old, freqs.new);
> -
> - ? ? ? cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> -
> -#ifdef CONFIG_REGULATOR
> - ? ? ? if (vddarm && freqs.new > freqs.old) {
> - ? ? ? ? ? ? ? ret = regulator_set_voltage(vddarm,
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dvfs->vddarm_min,
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dvfs->vddarm_max);
> - ? ? ? ? ? ? ? if (ret != 0) {
> - ? ? ? ? ? ? ? ? ? ? ? pr_err("cpufreq: Failed to set VDDARM for %dkHz: %d\n",
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?freqs.new, ret);
> - ? ? ? ? ? ? ? ? ? ? ? goto err;
> - ? ? ? ? ? ? ? }
> - ? ? ? }
> -#endif
> -
> - ? ? ? ret = clk_set_rate(armclk, freqs.new * 1000);
> - ? ? ? if (ret < 0) {
> - ? ? ? ? ? ? ? pr_err("cpufreq: Failed to set rate %dkHz: %d\n",
> - ? ? ? ? ? ? ? ? ? ? ?freqs.new, ret);
> - ? ? ? ? ? ? ? goto err;
> - ? ? ? }
> -
> -#ifdef CONFIG_REGULATOR
> - ? ? ? if (vddarm && freqs.new < freqs.old) {
> - ? ? ? ? ? ? ? ret = regulator_set_voltage(vddarm,
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dvfs->vddarm_min,
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dvfs->vddarm_max);
> - ? ? ? ? ? ? ? if (ret != 0) {
> - ? ? ? ? ? ? ? ? ? ? ? pr_err("cpufreq: Failed to set VDDARM for %dkHz: %d\n",
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?freqs.new, ret);
> - ? ? ? ? ? ? ? ? ? ? ? goto err_clk;
> - ? ? ? ? ? ? ? }
> - ? ? ? }
> -#endif
> -
> - ? ? ? cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> -
> - ? ? ? pr_debug("cpufreq: Set actual frequency %lukHz\n",
> - ? ? ? ? ? ? ? ?clk_get_rate(armclk) / 1000);
> -
> - ? ? ? return 0;
> -
> -err_clk:
> - ? ? ? if (clk_set_rate(armclk, freqs.old * 1000) < 0)
> - ? ? ? ? ? ? ? pr_err("Failed to restore original clock rate\n");
> -err:
> - ? ? ? cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> -
> - ? ? ? return ret;
> -}
> -
> -#ifdef CONFIG_REGULATOR
> -static void __init s3c64xx_cpufreq_config_regulator(void)
> -{
> - ? ? ? int count, v, i, found;
> - ? ? ? struct cpufreq_frequency_table *freq;
> - ? ? ? struct s3c64xx_dvfs *dvfs;
> -
> - ? ? ? count = regulator_count_voltages(vddarm);
> - ? ? ? if (count < 0) {
> - ? ? ? ? ? ? ? pr_err("cpufreq: Unable to check supported voltages\n");
> - ? ? ? }
> -
> - ? ? ? freq = s3c64xx_freq_table;
> - ? ? ? while (count > 0 && freq->frequency != CPUFREQ_TABLE_END) {
> - ? ? ? ? ? ? ? if (freq->frequency == CPUFREQ_ENTRY_INVALID)
> - ? ? ? ? ? ? ? ? ? ? ? continue;
> -
> - ? ? ? ? ? ? ? dvfs = &s3c64xx_dvfs_table[freq->index];
> - ? ? ? ? ? ? ? found = 0;
> -
> - ? ? ? ? ? ? ? for (i = 0; i < count; i++) {
> - ? ? ? ? ? ? ? ? ? ? ? v = regulator_list_voltage(vddarm, i);
> - ? ? ? ? ? ? ? ? ? ? ? if (v >= dvfs->vddarm_min && v <= dvfs->vddarm_max)
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? found = 1;
> - ? ? ? ? ? ? ? }
> -
> - ? ? ? ? ? ? ? if (!found) {
> - ? ? ? ? ? ? ? ? ? ? ? pr_debug("cpufreq: %dkHz unsupported by regulator\n",
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?freq->frequency);
> - ? ? ? ? ? ? ? ? ? ? ? freq->frequency = CPUFREQ_ENTRY_INVALID;
> - ? ? ? ? ? ? ? }
> -
> - ? ? ? ? ? ? ? freq++;
> - ? ? ? }
> -
> - ? ? ? /* Guess based on having to do an I2C/SPI write; in future we
> - ? ? ? ?* will be able to query the regulator performance here. */
> - ? ? ? regulator_latency = 1 * 1000 * 1000;
> -}
> -#endif
> -
> -static int s3c64xx_cpufreq_driver_init(struct cpufreq_policy *policy)
> -{
> - ? ? ? int ret;
> - ? ? ? struct cpufreq_frequency_table *freq;
> -
> - ? ? ? if (policy->cpu != 0)
> - ? ? ? ? ? ? ? return -EINVAL;
> -
> - ? ? ? if (s3c64xx_freq_table == NULL) {
> - ? ? ? ? ? ? ? pr_err("cpufreq: No frequency information for this CPU\n");
> - ? ? ? ? ? ? ? return -ENODEV;
> - ? ? ? }
> -
> - ? ? ? armclk = clk_get(NULL, "armclk");
> - ? ? ? if (IS_ERR(armclk)) {
> - ? ? ? ? ? ? ? pr_err("cpufreq: Unable to obtain ARMCLK: %ld\n",
> - ? ? ? ? ? ? ? ? ? ? ?PTR_ERR(armclk));
> - ? ? ? ? ? ? ? return PTR_ERR(armclk);
> - ? ? ? }
> -
> -#ifdef CONFIG_REGULATOR
> - ? ? ? vddarm = regulator_get(NULL, "vddarm");
> - ? ? ? if (IS_ERR(vddarm)) {
> - ? ? ? ? ? ? ? ret = PTR_ERR(vddarm);
> - ? ? ? ? ? ? ? pr_err("cpufreq: Failed to obtain VDDARM: %d\n", ret);
> - ? ? ? ? ? ? ? pr_err("cpufreq: Only frequency scaling available\n");
> - ? ? ? ? ? ? ? vddarm = NULL;
> - ? ? ? } else {
> - ? ? ? ? ? ? ? s3c64xx_cpufreq_config_regulator();
> - ? ? ? }
> -#endif
> -
> - ? ? ? freq = s3c64xx_freq_table;
> - ? ? ? while (freq->frequency != CPUFREQ_TABLE_END) {
> - ? ? ? ? ? ? ? unsigned long r;
> -
> - ? ? ? ? ? ? ? /* Check for frequencies we can generate */
> - ? ? ? ? ? ? ? r = clk_round_rate(armclk, freq->frequency * 1000);
> - ? ? ? ? ? ? ? r /= 1000;
> - ? ? ? ? ? ? ? if (r != freq->frequency) {
> - ? ? ? ? ? ? ? ? ? ? ? pr_debug("cpufreq: %dkHz unsupported by clock\n",
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?freq->frequency);
> - ? ? ? ? ? ? ? ? ? ? ? freq->frequency = CPUFREQ_ENTRY_INVALID;
> - ? ? ? ? ? ? ? }
> -
> - ? ? ? ? ? ? ? /* If we have no regulator then assume startup
> - ? ? ? ? ? ? ? ?* frequency is the maximum we can support. */
> - ? ? ? ? ? ? ? if (!vddarm && freq->frequency > s3c64xx_cpufreq_get_speed(0))
> - ? ? ? ? ? ? ? ? ? ? ? freq->frequency = CPUFREQ_ENTRY_INVALID;
> -
> - ? ? ? ? ? ? ? freq++;
> - ? ? ? }
> -
> - ? ? ? policy->cur = clk_get_rate(armclk) / 1000;
> -
> - ? ? ? /* Datasheet says PLL stabalisation time (if we were to use
> - ? ? ? ?* the PLLs, which we don't currently) is ~300us worst case,
> - ? ? ? ?* but add some fudge.
> - ? ? ? ?*/
> - ? ? ? policy->cpuinfo.transition_latency = (500 * 1000) + regulator_latency;
> -
> - ? ? ? ret = cpufreq_frequency_table_cpuinfo(policy, s3c64xx_freq_table);
> - ? ? ? if (ret != 0) {
> - ? ? ? ? ? ? ? pr_err("cpufreq: Failed to configure frequency table: %d\n",
> - ? ? ? ? ? ? ? ? ? ? ?ret);
> - ? ? ? ? ? ? ? regulator_put(vddarm);
> - ? ? ? ? ? ? ? clk_put(armclk);
> - ? ? ? }
> -
> - ? ? ? return ret;
> -}
> -
> -static struct cpufreq_driver s3c64xx_cpufreq_driver = {
> - ? ? ? .owner ? ? ? ? ?= THIS_MODULE,
> - ? ? ? .flags ? ? ? ? ?= 0,
> - ? ? ? .verify ? ? ? ? = s3c64xx_cpufreq_verify_speed,
> - ? ? ? .target ? ? ? ? = s3c64xx_cpufreq_set_target,
> - ? ? ? .get ? ? ? ? ? ?= s3c64xx_cpufreq_get_speed,
> - ? ? ? .init ? ? ? ? ? = s3c64xx_cpufreq_driver_init,
> - ? ? ? .name ? ? ? ? ? = "s3c",
> -};
> -
> -static int __init s3c64xx_cpufreq_init(void)
> -{
> - ? ? ? return cpufreq_register_driver(&s3c64xx_cpufreq_driver);
> -}
> -module_init(s3c64xx_cpufreq_init);
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index e2fc2d2..0031e04 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -40,4 +40,5 @@ obj-$(CONFIG_X86_CPUFREQ_NFORCE2) ? ? += cpufreq-nforce2.o
> ?##################################################################################d
>
> ?# ARM SoC drivers
> +obj-$(CONFIG_CPU_FREQ_S3C64XX) ? ? ? ? += s3c64xx.o
> ?obj-$(CONFIG_UX500_SOC_DB8500) ? ? ? ? += db8500-cpufreq.o
> diff --git a/drivers/cpufreq/s3c64xx.c b/drivers/cpufreq/s3c64xx.c
> new file mode 100644
> index 0000000..fc3f180
> --- /dev/null
> +++ b/drivers/cpufreq/s3c64xx.c
> @@ -0,0 +1,269 @@
> +/*
> + * Copyright 2009 Wolfson Microelectronics plc
> + *
> + * S3C64xx CPUfreq Support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/init.h>
> +#include <linux/cpufreq.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/regulator/consumer.h>
> +
> +static struct clk *armclk;
> +static struct regulator *vddarm;
> +static unsigned long regulator_latency;
> +
> +#ifdef CONFIG_CPU_S3C6410
> +struct s3c64xx_dvfs {
> + ? ? ? unsigned int vddarm_min;
> + ? ? ? unsigned int vddarm_max;
> +};
> +
> +static struct s3c64xx_dvfs s3c64xx_dvfs_table[] = {
> + ? ? ? [0] = { 1000000, 1150000 },
> + ? ? ? [1] = { 1050000, 1150000 },
> + ? ? ? [2] = { 1100000, 1150000 },
> + ? ? ? [3] = { 1200000, 1350000 },
> +};
> +
> +static struct cpufreq_frequency_table s3c64xx_freq_table[] = {
> + ? ? ? { 0, ?66000 },
> + ? ? ? { 0, 133000 },
> + ? ? ? { 1, 222000 },
> + ? ? ? { 1, 266000 },
> + ? ? ? { 2, 333000 },
> + ? ? ? { 2, 400000 },
> + ? ? ? { 2, 532000 },
> + ? ? ? { 2, 533000 },
> + ? ? ? { 3, 667000 },
> + ? ? ? { 0, CPUFREQ_TABLE_END },
> +};
> +#endif
> +
> +static int s3c64xx_cpufreq_verify_speed(struct cpufreq_policy *policy)
> +{
> + ? ? ? if (policy->cpu != 0)
> + ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? return cpufreq_frequency_table_verify(policy, s3c64xx_freq_table);
> +}
> +
> +static unsigned int s3c64xx_cpufreq_get_speed(unsigned int cpu)
> +{
> + ? ? ? if (cpu != 0)
> + ? ? ? ? ? ? ? return 0;
> +
> + ? ? ? return clk_get_rate(armclk) / 1000;
> +}
> +
> +static int s3c64xx_cpufreq_set_target(struct cpufreq_policy *policy,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned int target_freq,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned int relation)
> +{
> + ? ? ? int ret;
> + ? ? ? unsigned int i;
> + ? ? ? struct cpufreq_freqs freqs;
> + ? ? ? struct s3c64xx_dvfs *dvfs;
> +
> + ? ? ? ret = cpufreq_frequency_table_target(policy, s3c64xx_freq_table,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?target_freq, relation, &i);
> + ? ? ? if (ret != 0)
> + ? ? ? ? ? ? ? return ret;
> +
> + ? ? ? freqs.cpu = 0;
> + ? ? ? freqs.old = clk_get_rate(armclk) / 1000;
> + ? ? ? freqs.new = s3c64xx_freq_table[i].frequency;
> + ? ? ? freqs.flags = 0;
> + ? ? ? dvfs = &s3c64xx_dvfs_table[s3c64xx_freq_table[i].index];
> +
> + ? ? ? if (freqs.old == freqs.new)
> + ? ? ? ? ? ? ? return 0;
> +
> + ? ? ? pr_debug("cpufreq: Transition %d-%dkHz\n", freqs.old, freqs.new);
> +
> + ? ? ? cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +
> +#ifdef CONFIG_REGULATOR
> + ? ? ? if (vddarm && freqs.new > freqs.old) {
> + ? ? ? ? ? ? ? ret = regulator_set_voltage(vddarm,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dvfs->vddarm_min,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dvfs->vddarm_max);
> + ? ? ? ? ? ? ? if (ret != 0) {
> + ? ? ? ? ? ? ? ? ? ? ? pr_err("cpufreq: Failed to set VDDARM for %dkHz: %d\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?freqs.new, ret);
> + ? ? ? ? ? ? ? ? ? ? ? goto err;
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> +#endif
> +
> + ? ? ? ret = clk_set_rate(armclk, freqs.new * 1000);
> + ? ? ? if (ret < 0) {
> + ? ? ? ? ? ? ? pr_err("cpufreq: Failed to set rate %dkHz: %d\n",
> + ? ? ? ? ? ? ? ? ? ? ?freqs.new, ret);
> + ? ? ? ? ? ? ? goto err;
> + ? ? ? }
> +
> +#ifdef CONFIG_REGULATOR
> + ? ? ? if (vddarm && freqs.new < freqs.old) {
> + ? ? ? ? ? ? ? ret = regulator_set_voltage(vddarm,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dvfs->vddarm_min,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dvfs->vddarm_max);
> + ? ? ? ? ? ? ? if (ret != 0) {
> + ? ? ? ? ? ? ? ? ? ? ? pr_err("cpufreq: Failed to set VDDARM for %dkHz: %d\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?freqs.new, ret);
> + ? ? ? ? ? ? ? ? ? ? ? goto err_clk;
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> +#endif
> +
> + ? ? ? cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> +
> + ? ? ? pr_debug("cpufreq: Set actual frequency %lukHz\n",
> + ? ? ? ? ? ? ? ?clk_get_rate(armclk) / 1000);
> +
> + ? ? ? return 0;
> +
> +err_clk:
> + ? ? ? if (clk_set_rate(armclk, freqs.old * 1000) < 0)
> + ? ? ? ? ? ? ? pr_err("Failed to restore original clock rate\n");
> +err:
> + ? ? ? cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> +
> + ? ? ? return ret;
> +}
> +
> +#ifdef CONFIG_REGULATOR
> +static void __init s3c64xx_cpufreq_config_regulator(void)
> +{
> + ? ? ? int count, v, i, found;
> + ? ? ? struct cpufreq_frequency_table *freq;
> + ? ? ? struct s3c64xx_dvfs *dvfs;
> +
> + ? ? ? count = regulator_count_voltages(vddarm);
> + ? ? ? if (count < 0) {
> + ? ? ? ? ? ? ? pr_err("cpufreq: Unable to check supported voltages\n");
> + ? ? ? }
> +
> + ? ? ? freq = s3c64xx_freq_table;
> + ? ? ? while (count > 0 && freq->frequency != CPUFREQ_TABLE_END) {
> + ? ? ? ? ? ? ? if (freq->frequency == CPUFREQ_ENTRY_INVALID)
> + ? ? ? ? ? ? ? ? ? ? ? continue;
> +
> + ? ? ? ? ? ? ? dvfs = &s3c64xx_dvfs_table[freq->index];
> + ? ? ? ? ? ? ? found = 0;
> +
> + ? ? ? ? ? ? ? for (i = 0; i < count; i++) {
> + ? ? ? ? ? ? ? ? ? ? ? v = regulator_list_voltage(vddarm, i);
> + ? ? ? ? ? ? ? ? ? ? ? if (v >= dvfs->vddarm_min && v <= dvfs->vddarm_max)
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? found = 1;
> + ? ? ? ? ? ? ? }
> +
> + ? ? ? ? ? ? ? if (!found) {
> + ? ? ? ? ? ? ? ? ? ? ? pr_debug("cpufreq: %dkHz unsupported by regulator\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?freq->frequency);
> + ? ? ? ? ? ? ? ? ? ? ? freq->frequency = CPUFREQ_ENTRY_INVALID;
> + ? ? ? ? ? ? ? }
> +
> + ? ? ? ? ? ? ? freq++;
> + ? ? ? }
> +
> + ? ? ? /* Guess based on having to do an I2C/SPI write; in future we
> + ? ? ? ?* will be able to query the regulator performance here. */
> + ? ? ? regulator_latency = 1 * 1000 * 1000;
> +}
> +#endif
> +
> +static int s3c64xx_cpufreq_driver_init(struct cpufreq_policy *policy)
> +{
> + ? ? ? int ret;
> + ? ? ? struct cpufreq_frequency_table *freq;
> +
> + ? ? ? if (policy->cpu != 0)
> + ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? if (s3c64xx_freq_table == NULL) {
> + ? ? ? ? ? ? ? pr_err("cpufreq: No frequency information for this CPU\n");
> + ? ? ? ? ? ? ? return -ENODEV;
> + ? ? ? }
> +
> + ? ? ? armclk = clk_get(NULL, "armclk");
> + ? ? ? if (IS_ERR(armclk)) {
> + ? ? ? ? ? ? ? pr_err("cpufreq: Unable to obtain ARMCLK: %ld\n",
> + ? ? ? ? ? ? ? ? ? ? ?PTR_ERR(armclk));
> + ? ? ? ? ? ? ? return PTR_ERR(armclk);
> + ? ? ? }
> +
> +#ifdef CONFIG_REGULATOR
> + ? ? ? vddarm = regulator_get(NULL, "vddarm");
> + ? ? ? if (IS_ERR(vddarm)) {
> + ? ? ? ? ? ? ? ret = PTR_ERR(vddarm);
> + ? ? ? ? ? ? ? pr_err("cpufreq: Failed to obtain VDDARM: %d\n", ret);
> + ? ? ? ? ? ? ? pr_err("cpufreq: Only frequency scaling available\n");
> + ? ? ? ? ? ? ? vddarm = NULL;
> + ? ? ? } else {
> + ? ? ? ? ? ? ? s3c64xx_cpufreq_config_regulator();
> + ? ? ? }
> +#endif
> +
> + ? ? ? freq = s3c64xx_freq_table;
> + ? ? ? while (freq->frequency != CPUFREQ_TABLE_END) {
> + ? ? ? ? ? ? ? unsigned long r;
> +
> + ? ? ? ? ? ? ? /* Check for frequencies we can generate */
> + ? ? ? ? ? ? ? r = clk_round_rate(armclk, freq->frequency * 1000);
> + ? ? ? ? ? ? ? r /= 1000;
> + ? ? ? ? ? ? ? if (r != freq->frequency) {
> + ? ? ? ? ? ? ? ? ? ? ? pr_debug("cpufreq: %dkHz unsupported by clock\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?freq->frequency);
> + ? ? ? ? ? ? ? ? ? ? ? freq->frequency = CPUFREQ_ENTRY_INVALID;
> + ? ? ? ? ? ? ? }
> +
> + ? ? ? ? ? ? ? /* If we have no regulator then assume startup
> + ? ? ? ? ? ? ? ?* frequency is the maximum we can support. */
> + ? ? ? ? ? ? ? if (!vddarm && freq->frequency > s3c64xx_cpufreq_get_speed(0))
> + ? ? ? ? ? ? ? ? ? ? ? freq->frequency = CPUFREQ_ENTRY_INVALID;
> +
> + ? ? ? ? ? ? ? freq++;
> + ? ? ? }
> +
> + ? ? ? policy->cur = clk_get_rate(armclk) / 1000;
> +
> + ? ? ? /* Datasheet says PLL stabalisation time (if we were to use
> + ? ? ? ?* the PLLs, which we don't currently) is ~300us worst case,
> + ? ? ? ?* but add some fudge.
> + ? ? ? ?*/
> + ? ? ? policy->cpuinfo.transition_latency = (500 * 1000) + regulator_latency;
> +
> + ? ? ? ret = cpufreq_frequency_table_cpuinfo(policy, s3c64xx_freq_table);
> + ? ? ? if (ret != 0) {
> + ? ? ? ? ? ? ? pr_err("cpufreq: Failed to configure frequency table: %d\n",
> + ? ? ? ? ? ? ? ? ? ? ?ret);
> + ? ? ? ? ? ? ? regulator_put(vddarm);
> + ? ? ? ? ? ? ? clk_put(armclk);
> + ? ? ? }
> +
> + ? ? ? return ret;
> +}
> +
> +static struct cpufreq_driver s3c64xx_cpufreq_driver = {
> + ? ? ? .owner ? ? ? ? ?= THIS_MODULE,
> + ? ? ? .flags ? ? ? ? ?= 0,
> + ? ? ? .verify ? ? ? ? = s3c64xx_cpufreq_verify_speed,
> + ? ? ? .target ? ? ? ? = s3c64xx_cpufreq_set_target,
> + ? ? ? .get ? ? ? ? ? ?= s3c64xx_cpufreq_get_speed,
> + ? ? ? .init ? ? ? ? ? = s3c64xx_cpufreq_driver_init,
> + ? ? ? .name ? ? ? ? ? = "s3c",
> +};
> +
> +static int __init s3c64xx_cpufreq_init(void)
> +{
> + ? ? ? return cpufreq_register_driver(&s3c64xx_cpufreq_driver);
> +}
> +module_init(s3c64xx_cpufreq_init);
> --
> 1.7.5.3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
