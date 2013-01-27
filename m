From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 27 Jan 2013 09:21:42 +0530
Subject: [PATCH v2 1/3] cpufreq: kirkwood: Add a cpufreq driver for
 Marvell Kirkwood SoCs
In-Reply-To: <1359215039-2848-2-git-send-email-andrew@lunn.ch>
References: <1359215039-2848-1-git-send-email-andrew@lunn.ch>
 <1359215039-2848-2-git-send-email-andrew@lunn.ch>
Message-ID: <CAKohpok1w2RB1ncyNTcd04XTNFfnq_S98YEcxNjpWGWMVA7TaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Few more comments from my side :(

On 26 January 2013 21:13, Andrew Lunn <andrew@lunn.ch> wrote:
> diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/cpufreq.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <asm/proc-fns.h>
> +
> +#define CPU_SW_INT_BLK BIT(28)
> +
> +
> +#include <linux/clk-private.h>

Any specific reason for keeping it together with other #includes?

> +static void kirkwood_cpufreq_set_cpu_state(unsigned int index)
> +{
> +

Can remove extra blank line.

> +       if (freqs.old != freqs.new) {
> +               local_irq_disable();
> +
> +               /* Disable interrupts to the CPU */
> +               reg = readl_relaxed(priv.base);
> +               reg |= CPU_SW_INT_BLK;
> +               writel(reg, priv.base);

Any specific reason for calling writel() instead of writel_relaxed()?
relaxed one would take less time and would be much more efficient.

same for all other writel's too.

> +};
> +
> +static int kirkwood_cpufreq_verify(struct cpufreq_policy *policy)
> +{
> +       return cpufreq_frequency_table_verify(policy, &kirkwood_freq_table[0]);

return cpufreq_frequency_table_verify(policy, kirkwood_freq_table); ??

> +}
> +
> +static int kirkwood_cpufreq_target(struct cpufreq_policy *policy,
> +                           unsigned int target_freq,
> +                           unsigned int relation)
> +{
> +       unsigned int index = 0;
> +
> +       if (cpufreq_frequency_table_target(policy, kirkwood_freq_table,
> +                               target_freq, relation, &index))
> +               return -EINVAL;
> +
> +       kirkwood_cpufreq_set_cpu_state(index);

This routine does have error cases, like: wrong value of "state"
variable, so returning int from it might make sense. Though i believe
state can't be anything else then STATE_CPU_FREQ or STATE_DDR_FREQ.
In which case, switch must be modified?

> +       return 0;
> +}
> +
> +/*
> + *     Module init and exit code
> + */

Can be converted to a single line comment if you want. :)

> +static int kirkwood_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> +{
> +       cpufreq_frequency_table_put_attr(policy->cpu);
> +       return 0;
> +}

Hmm.. Exit is normally called in two cases. Either cpufreq driver is
unregistered
or cpu is removed. In that case i am not sure if this routine makes sense? As
we have a uniprocessor SoC here.

@Rafael?

> +static struct freq_attr *kirkwood_cpufreq_attr[] = {
> +       &cpufreq_freq_attr_scaling_available_freqs,
> +       NULL,
> +};
> +
> +

Can remove extra blank line.
