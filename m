From: yadi.brar01@gmail.com (Yadwinder Singh Brar)
Date: Wed, 21 Aug 2013 18:02:16 +0530
Subject: [PATCH 12/16] clk: samsung: pll: Add support for rate
 configuration of PLL46xx
In-Reply-To: <1377019903-14614-13-git-send-email-t.figa@samsung.com>
References: <1377019903-14614-1-git-send-email-t.figa@samsung.com>
 <1377019903-14614-13-git-send-email-t.figa@samsung.com>
Message-ID: <CAKew6eU4ofumk64fwZSK-R-UUBQos6UU1TLDdVRDE-bvOrbitw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +       con0 |= (rate->mdiv << PLL46XX_MDIV_SHIFT) |
> +                       (rate->pdiv << PLL46XX_PDIV_SHIFT) |
> +                       (rate->sdiv << PLL46XX_SDIV_SHIFT) |
> +                       (rate->vsel << PLL46XX_VSEL_SHIFT);
> +
> +       /* Set PLL AFC, MFR and MRR values. */

This comments seems to be miss match with below code.

> +       con1 = __raw_readl(pll->con_reg + 0x4);
> +       con1 &= ~((PLL46XX_KDIV_MASK << PLL46XX_KDIV_SHIFT) |
> +                       (PLL46XX_MFR_MASK << PLL46XX_MFR_SHIFT) |
> +                       (PLL46XX_MRR_MASK << PLL46XX_MRR_SHIFT));
> +       con1 |= (rate->kdiv << PLL46XX_KDIV_SHIFT) |
> +                       (rate->mfr << PLL46XX_MFR_SHIFT) |
> +                       (rate->mrr << PLL46XX_MRR_SHIFT);
> +
<snip>
> --- a/drivers/clk/samsung/clk-pll.h
> +++ b/drivers/clk/samsung/clk-pll.h
> @@ -51,6 +51,28 @@ enum samsung_pll_type {
>                 .afc    =       (_afc),                         \
>         }
>
> +#define PLL_4600_RATE(_rate, _m, _p, _s, _k, _vsel)            \
> +       {                                                       \
> +               .rate   =       (_rate),                        \
> +               .mdiv   =       (_m),                           \
> +               .pdiv   =       (_p),                           \
> +               .sdiv   =       (_s),                           \
> +               .kdiv   =       (_k),                           \
> +               .vsel   =       (_vsel),                        \
> +       }
> +
> +#define PLL_4650_RATE(_rate, _m, _p, _s, _k, _mfr, _mrr, _vsel)        \
> +       {                                                       \
> +               .rate   =       (_rate),                        \
> +               .mdiv   =       (_m),                           \
> +               .pdiv   =       (_p),                           \
> +               .sdiv   =       (_s),                           \
> +               .kdiv   =       (_k),                           \
> +               .mfr    =       (_mfr),                         \
> +               .mrr    =       (_mrr),                         \
> +               .vsel   =       (_vsel),                        \
> +       }
> +
>  /* NOTE: Rate table should be kept sorted in descending order. */
>
>  struct samsung_pll_rate_table {
> @@ -60,6 +82,9 @@ struct samsung_pll_rate_table {
>         unsigned int sdiv;
>         unsigned int kdiv;
>         unsigned int afc;
> +       unsigned int mfr;
> +       unsigned int mrr;
> +       unsigned int vsel;
>  };
>

This struct seems to be expanding too much.
Can we re-think on options for using bit map same as register
definition? It can reduce code in set_rate also little bit.

Regards,
Yadwinder
