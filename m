From: pramod.gurav.etc@gmail.com (pramod gurav)
Date: Wed, 23 Jul 2014 12:51:43 +0530
Subject: [PATCH v2 14/16] cpufreq: Add cpufreq driver for Tegra124
In-Reply-To: <1405957142-19416-15-git-send-email-ttynkkynen@nvidia.com>
References: <1405957142-19416-1-git-send-email-ttynkkynen@nvidia.com>
 <1405957142-19416-15-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <CAMf-jSkOF3qN=GSju=tsMp5SBUo+TqNQOROnirr=N_zz7Ca43Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 9:09 PM, Tuomas Tynkkynen <ttynkkynen@nvidia.com> wrote:
> Add a new cpufreq driver for Tegra124. Instead of using the PLLX as

<snip>

> +
> +static int tegra124_cpu_switch_to_dfll(void)
> +{
> +       struct clk *original_cpu_clk_parent;
> +       unsigned long rate;
> +       struct dev_pm_opp *opp;
> +       int ret;
> +
> +       rate = clk_get_rate(cpu_clk);
> +       opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
> +       if (IS_ERR(opp))
> +               return PTR_ERR(opp);
> +
> +       ret = clk_set_rate(dfll_clk, rate);
> +       if (ret)
> +               return ret;
> +
> +       original_cpu_clk_parent = clk_get_parent(cpu_clk);
> +       clk_set_parent(cpu_clk, pllp_clk);

Needs return check.

> +       if (ret)
> +               return ret;
Which 'ret' is being checked here? nothing is assigned here. May be
fixing previous comment will fix this.

> +
> +       ret = clk_prepare_enable(dfll_clk);

<snip>

> Please read the FAQ at  http://www.tux.org/lkml/



-- 
Thanks and Regards
Pramod
