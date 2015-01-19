From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 19 Jan 2015 08:00:39 -0800
Subject: [PATCH 2/2] cpufreq: add cpufreq driver for Mediatek MT8173 SoC
In-Reply-To: <1420797291-15972-3-git-send-email-pi-cheng.chen@linaro.org>
References: <1420797291-15972-1-git-send-email-pi-cheng.chen@linaro.org>
 <1420797291-15972-3-git-send-email-pi-cheng.chen@linaro.org>
Message-ID: <20150119160039.22722.67992@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting pi-cheng.chen (2015-01-09 01:54:51)
> diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
> new file mode 100644
> index 0000000..b578c10
> --- /dev/null
> +++ b/drivers/cpufreq/mt8173-cpufreq.c
> @@ -0,0 +1,459 @@

Hello Pi-Cheng,

<snip>

> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/cpufreq.h>
> +#include <linux/cpufreq-dt.h>
> +#include <linux/cpumask.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>

I'll echo what Viresh said here. CPUfreq drivers should typically be
clock consumers and only require clk.h, not clk-provider.h. More on that
below.

<snip>

> +static void cpuclk_mux_set(int cluster, u32 sel)
> +{
> +       u32 val;
> +       u32 mask = 0x3;
> +
> +       if (cluster == BIG_CLUSTER) {
> +               mask <<= 2;
> +               sel <<= 2;
> +       }
> +
> +       spin_lock(&lock);
> +
> +       val = readl(clk_mux_regs);
> +       val = (val & ~mask) | sel;
> +       writel(val, clk_mux_regs);
> +
> +       spin_unlock(&lock);
> +}

Is cpuclk a mux that is represented in the MT8173 clock driver? It looks
like a clock that belong to the clock driver, but this cpufreq driver is
writing to that register directly.

<snip>

> +static int mt8173_cpufreq_dvfs_info_init(void)
> +{

<snip>

> +       mainpll = __clk_lookup("mainpll");
> +       if (!mainpll) {
> +               pr_err("failed to get mainpll clk\n");
> +               ret = -ENOENT;
> +               goto dvfs_info_release;
> +       }
> +       mainpll_freq = clk_get_rate(mainpll);

This is definitely bad. Why not use clk_get() here? __clk_lookup should
not be exposed to clock consumer drivers (and I hope to get rid of it
completely some day).

Regards,
Mike
