From: nm@ti.com (Nishanth Menon)
Date: Thu, 11 Apr 2013 18:23:52 -0500
Subject: [RESEND PATCH V6 1/4] cpufreq: exynos: Add cpufreq driver for
 exynos5440
In-Reply-To: <1365415054-30771-1-git-send-email-amit.daniel@samsung.com>
References: <CAKohpo=t_YTCTRCfnwQ+GPF=frsTGDigT3RZHJuVQ+R+YZU7Hg@mail.gmail.com>
 <1365415054-30771-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <CAGo_u6oZM0K8XDMtmXKFyoGy2qf+-HSPvU0EMangM5Jj_prKsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On Mon, Apr 8, 2013 at 4:57 AM, Amit Daniel Kachhap
<amit.daniel@samsung.com> wrote:
> +
> +static int init_div_table(void)
> +{
> +       struct cpufreq_frequency_table *freq_tbl = dvfs_info->freq_table;
> +       unsigned int tmp, clk_div, ema_div, freq, volt_id;
> +       int i = 0;
> +       struct opp *opp;
> +
> +       for (i = 0; freq_tbl[i].frequency != CPUFREQ_TABLE_END; i++) {
> +
> +               opp = opp_find_freq_exact(dvfs_info->dev,
> +                                       freq_tbl[i].frequency * 1000, true);
> +               if (IS_ERR(opp)) {
> +                       dev_err(dvfs_info->dev,
> +                               "failed to find valid OPP for %u KHZ\n",
> +                               freq_tbl[i].frequency);
> +                       return PTR_ERR(opp);
> +               }
please use RCU read locks.

> +
> +               freq = freq_tbl[i].frequency / 1000; /* In MHZ */
> +               clk_div = ((freq / CPU_DIV_FREQ_MAX) & P0_7_CPUCLKDEV_MASK)
> +                                       << P0_7_CPUCLKDEV_SHIFT;
> +               clk_div |= ((freq / CPU_ATB_FREQ_MAX) & P0_7_ATBCLKDEV_MASK)
> +                                       << P0_7_ATBCLKDEV_SHIFT;
> +               clk_div |= ((freq / CPU_DBG_FREQ_MAX) & P0_7_CSCLKDEV_MASK)
> +                                       << P0_7_CSCLKDEV_SHIFT;
> +
> +               /* Calculate EMA */
> +               volt_id = opp_get_voltage(opp);
Please use RCU read locks as documented for OPP library.

Regards,
Nishanth Menon
