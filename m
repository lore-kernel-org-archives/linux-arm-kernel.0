From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 19 Nov 2014 14:30:56 -0800
Subject: [PATCH 1/4] ARM: meson: add basic infrastructure for clocks
In-Reply-To: <1416393143-20434-2-git-send-email-carlo@caione.org>
References: <1416393143-20434-1-git-send-email-carlo@caione.org>
 <1416393143-20434-2-git-send-email-carlo@caione.org>
Message-ID: <20141119223056.25314.11072@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Carlo Caione (2014-11-19 02:32:20)
> This patchset adds the infrastructure for registering and managing the
> core clocks found on Amlogic MesonX SoCs and also adds the support for
> the basic Meson6 clocks.

Minor nitpick: typically the $SUBJECT starts with "arm:" if the patch
primarily deals with code under arch/arm. Since this code lives in
drivers/clk it might be better to use something like:

clk: meson: add basic infrastructure for clocks

<snip>

> +static void meson_clk_pll_get_parms(struct meson_clk_pll *pll,
> +                                   unsigned long *rate, unsigned long p_rate,
> +                                   u16 *best_n, u16 *best_m, u16 *best_od_fb)
> +{
> +       unsigned long rate_mhz, p_rate_mhz;
> +       unsigned long pll_vco_min_mhz, pll_vco_max_mhz;
> +       unsigned long cur_rate_mhz, best_rate_mhz;
> +       u16 m, m_min, m_max, m_mask;
> +       u16 n, n_min, n_max, n_mask, _n_min, _n_max;
> +       u16 od_fb, od_fb_max;
> +
> +       rate_mhz = *rate / 1000000;
> +       p_rate_mhz = p_rate / 1000000;
> +       pll_vco_min_mhz = pll->conf->vco_min_mhz;
> +       pll_vco_max_mhz = pll->conf->vco_max_mhz;
> +       best_rate_mhz = ULONG_MAX;
> +       *best_n = 0;
> +       *best_m = 0;
> +       *best_od_fb = 1;
> +
> +       m_mask = PMASK(pll->conf->m.width);
> +       n_mask = PMASK(pll->conf->n.width);
> +
> +       /* FREF = P_RATE / N */
> +       n_min = max_t(u16, DIV_ROUND_UP(p_rate_mhz, MESON_FREF_MAX_MHZ), 1);
> +       n_max = min_t(u16, p_rate_mhz / MESON_FREF_MIN_MHZ, n_mask);
> +
> +       od_fb_max = 1 << PMASK(pll->conf->od_fb.width);
> +
> +       for (od_fb = 1; od_fb <= od_fb_max; od_fb <<= 1) {
> +
> +               /* VCO = P_RATE * M * OD_FB / N */
> +               m_min = max_t(u16, DIV_ROUND_UP(pll_vco_min_mhz,
> +                             p_rate_mhz * od_fb) * n_min, 1);
> +               m_max = min_t(u16, (pll_vco_max_mhz * n_max) /
> +                             (p_rate_mhz * od_fb), m_mask);
> +
> +
> +               for (m = m_min; m <= m_max; m++) {
> +                       _n_min = max_t(u16, n_min,
> +                                      DIV_ROUND_UP(p_rate_mhz * m * od_fb,
> +                                      pll_vco_max_mhz));
> +                       _n_max = min_t(u16, n_max,
> +                                      p_rate_mhz * m * od_fb / pll_vco_min_mhz);
> +
> +                       for (n = _n_min; n <= _n_max; n++) {
> +                               cur_rate_mhz = p_rate_mhz * m * od_fb / n;
> +
> +                               if (abs(cur_rate_mhz - rate_mhz) <
> +                                  abs(best_rate_mhz - rate_mhz)) {
> +                                       best_rate_mhz = cur_rate_mhz;
> +                                       *best_n = n;
> +                                       *best_m = m;
> +                                       *best_od_fb = od_fb;
> +                                       if (best_rate_mhz == rate_mhz)
> +                                               goto done;
> +                               }
> +                       }
> +               }
> +       }

Nothing strictly wrong with the above, but is is n^3 complexity. If your
tables are large then you might be spending a non-trivial amount time
calculating the pll parameters.

<snip>

> +
> +done:
> +       *best_od_fb >>= 1;
> +       *rate = best_rate_mhz * 1000000;
> +       return;
> +
> +}
> +
> +static unsigned long meson_clk_pll_recalc_rate(struct clk_hw *hw,
> +                                               unsigned long parent_rate)
> +{
> +       struct meson_clk_pll *pll = to_meson_clk_pll(hw);
> +       struct parm *p_n, *p_m, *p_od_fb;
> +       unsigned long parent_rate_mhz = parent_rate / 1000000;
> +       unsigned long rate_mhz;
> +       u16 n, m, od_fb = 1;
> +       u32 reg_n, reg_m, reg_od_fb;
> +
> +       p_n = &pll->conf->n;
> +       p_m = &pll->conf->m;
> +       p_od_fb = &pll->conf->od_fb;
> +
> +       reg_n = readl(pll->base + p_n->reg_off);
> +       n = PARM_GET(p_n->width, p_n->shift, reg_n);
> +
> +       reg_m = readl(pll->base + p_m->reg_off);
> +       m = PARM_GET(p_m->width, p_m->shift, reg_m);
> +
> +       if (p_od_fb->width != MESON_PARM_NOT_APPLICABLE) {
> +               reg_od_fb = readl(pll->base + p_od_fb->reg_off);
> +               od_fb = PARM_GET(p_od_fb->width, p_od_fb->shift, reg_od_fb);
> +               od_fb = 1 << od_fb;
> +       }
> +
> +       rate_mhz = parent_rate_mhz * m * od_fb / n;
> +
> +       return rate_mhz * 1000000;
> +}
> +
> +static long meson_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +                                     unsigned long *parent_rate)
> +{
> +       struct meson_clk_pll *pll = to_meson_clk_pll(hw);
> +       u16 m, n, od_fb;
> +
> +       meson_clk_pll_get_parms(pll, &rate, *parent_rate, &n, &m, &od_fb);
> +       if (m == 0 || n == 0)
> +               return -EINVAL;
> +
> +       return rate;
> +}

Can the clock signal input to your pll by multiplexed? Are there
multiple possible parents to a pll? If so you might want to use
.determine_rate over .round_rate.

<snip>

> diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
> new file mode 100644
> index 0000000..6c0f611
> --- /dev/null
> +++ b/drivers/clk/meson/clkc.h
> @@ -0,0 +1,159 @@
> +/*
> + * Copyright (c) 2014 Carlo Caione <carlo@caione.org>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef __CLKC_H
> +#define __CLKC_H

<snip>

> +void meson_clk_init(struct device_node *np, unsigned long nr_clks);
> +void meson_clk_add_lookup(struct clk *clk, unsigned int id);
> +void meson_clk_register_pll_divs(struct pll_div_conf *pll_divs,
> +                                unsigned int nr_pll_divs,
> +                                void __iomem *reg_base);
> +void meson_clk_register_pll_div(struct pll_div_conf *pll_div_conf,
> +                               void __iomem *reg_base, spinlock_t *lock);
> +void meson_clk_register_clks(struct clk_conf *clk_confs,
> +                            unsigned int nr_confs,
> +                            void __iomem *clk_base);

Missing #endif here causes compile failure.

Regards,
Mike
