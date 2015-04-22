From: carlo@caione.org (Carlo Caione)
Date: Wed, 22 Apr 2015 09:31:40 +0200
Subject: [PATCH 1/3] clk: meson: Add support for Meson clock controller
In-Reply-To: <20150410233135.18916.85534@quantum>
References: <1425313322-18567-1-git-send-email-carlo@caione.org>
 <1425313322-18567-2-git-send-email-carlo@caione.org>
 <20150410233135.18916.85534@quantum>
Message-ID: <CAOQ7t2b4aD14xjXN96k977OXw+GbKCh3Nu3Yh-Qx7A7Cm0j_tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 11, 2015 at 1:31 AM, Michael Turquette
<mturquette@linaro.org> wrote:
> Quoting Carlo Caione (2015-03-02 08:22:00)
>> +static int meson_clk_cpu_pre_rate_change(struct meson_clk_cpu *clk_cpu,
>> +                                        struct clk_notifier_data *ndata)
>> +{
>> +       u32 cpu_clk_cntl;
>> +
>> +       spin_lock(clk_cpu->lock);
>> +
>> +       /* switch MUX1 to xtal */
>> +       cpu_clk_cntl = readl(clk_cpu->base + clk_cpu->reg_off
>> +                               + MESON_CPU_CLK_CNTL);
>> +       cpu_clk_cntl &= ~MESON_CPU_CLK_MUX1;
>> +       writel(cpu_clk_cntl, clk_cpu->base + clk_cpu->reg_off
>> +                               + MESON_CPU_CLK_CNTL);
>> +       udelay(100);
>> +
>> +       /* switch MUX2 to sys-pll */
>> +       cpu_clk_cntl |= MESON_CPU_CLK_MUX2;
>> +       writel(cpu_clk_cntl, clk_cpu->base + clk_cpu->reg_off
>> +                               + MESON_CPU_CLK_CNTL);
>> +
>> +       spin_unlock(clk_cpu->lock);
>> +
>> +       return 0;
>> +}
>> +
>> +static int meson_clk_cpu_post_rate_change(struct meson_clk_cpu *clk_cpu,
>> +                                         struct clk_notifier_data *ndata)
>> +{
>> +       u32 cpu_clk_cntl;
>> +
>> +       spin_lock(clk_cpu->lock);
>> +
>> +       /* switch MUX1 to divisors' output */
>> +       cpu_clk_cntl = readl(clk_cpu->base + clk_cpu->reg_off
>> +                               + MESON_CPU_CLK_CNTL);
>> +       cpu_clk_cntl |= MESON_CPU_CLK_MUX1;
>> +       writel(cpu_clk_cntl, clk_cpu->base + clk_cpu->reg_off
>> +                               + MESON_CPU_CLK_CNTL);
>> +       udelay(100);
>> +
>> +       spin_unlock(clk_cpu->lock);
>> +
>> +       return 0;
>> +}
>> +
>> +/*
>> + * This clock notifier is called when the frequency of the of the parent
>> + * PLL clock is to be changed. We use the xtal input as temporary parent
>> + * while the PLL frequency is stabilized.
>> + */
>> +static int meson_clk_cpu_notifier_cb(struct notifier_block *nb,
>> +                                    unsigned long event, void *data)
>> +{
>> +       struct clk_notifier_data *ndata = data;
>> +       struct meson_clk_cpu *clk_cpu = to_meson_clk_cpu_nb(nb);
>> +       int ret = 0;
>> +
>> +       if (event == PRE_RATE_CHANGE)
>> +               ret = meson_clk_cpu_pre_rate_change(clk_cpu, ndata);
>> +       else if (event == POST_RATE_CHANGE)
>> +               ret = meson_clk_cpu_post_rate_change(clk_cpu, ndata);
>> +
>> +       return notifier_from_errno(ret);
>> +}
>
> Why use a notifier for this? Could you simply call
> meson_clk_cpu_{pre,post}_rate_change directly from
> meson_clk_cpu_set_rate?

Hi Mike,

the notifier is used to reparent the CPU clock when the frequency of
the parent PLL is changed and before the PLL frequency is actually
changed.
IIUC using the {pre,post} hooks from meson_clk_cpu_set_rate doesn't
achieve the same. The idea is adapted from the CPU clock driver of the
rockchip SoCs (rockchip/clk-cpu.c).

Thanks for the review,

-- 
Carlo Caione
