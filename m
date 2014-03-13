From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 13 Mar 2014 19:29:03 +0900
Subject: [PATCH v5 3/5] clk/samsung: add support for pll2650xx
In-Reply-To: <532109C6.2060100@samsung.com>
References: <1394636208-3125-1-git-send-email-rahul.sharma@samsung.com>
 <1394636208-3125-4-git-send-email-rahul.sharma@samsung.com>
 <532109C6.2060100@samsung.com>
Message-ID: <CAGcde9FiFkbtuCrG1TWAmbcM-LLMu8fAMKS-L4keZ2ehuEDn=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 10:28 AM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
> Hi Rahul,
>
>
> On 03/12/2014 11:56 PM, Rahul Sharma wrote:
>>
>> Add support for pll2650xx in samsung pll file. This PLL variant
>> is close to pll36xx but uses CON2 registers instead of CON1.
>>
>> Aud_pll in Exynos5260 is pll2650xx and uses this code.
>>
>> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
>> ---
>>   drivers/clk/samsung/clk-pll.c |  101
>> +++++++++++++++++++++++++++++++++++++++++
>>   drivers/clk/samsung/clk-pll.h |    1 +
>>   2 files changed, 102 insertions(+)
>>
>> diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
>> index 18e42ef..b07fad2 100644
>> --- a/drivers/clk/samsung/clk-pll.c
>> +++ b/drivers/clk/samsung/clk-pll.c
>> @@ -1049,6 +1049,101 @@ static const struct clk_ops
>> samsung_pll2550xx_clk_min_ops = {
>>         .recalc_rate = samsung_pll2550xx_recalc_rate,
>>   };
>>   +/*
>> + * PLL2650XX Clock Type
>> + */
>> +
>> +/* Maximum lock time can be 3000 * PDIV cycles */
>> +#define PLL2650XX_LOCK_FACTOR 3000
>> +
>> +#define PLL2650XX_MDIV_SHIFT           9
>> +#define PLL2650XX_PDIV_SHIFT           3
>> +#define PLL2650XX_SDIV_SHIFT           0
>> +#define PLL2650XX_KDIV_SHIFT           0
>> +#define PLL2650XX_MDIV_MASK            0x1ff
>> +#define PLL2650XX_PDIV_MASK            0x3f
>> +#define PLL2650XX_SDIV_MASK            0x7
>> +#define PLL2650XX_KDIV_MASK            0xffff
>> +#define PLL2650XX_PLL_ENABLE_SHIFT     23
>> +#define PLL2650XX_PLL_LOCKTIME_SHIFT   21
>> +#define PLL2650XX_PLL_FOUTMASK_SHIFT   31
>> +
>> +static unsigned long samsung_pll2650xx_recalc_rate(struct clk_hw *hw,
>> +                               unsigned long parent_rate)
>> +{
>> +       struct samsung_clk_pll *pll = to_clk_pll(hw);
>> +       u32 mdiv, pdiv, sdiv, pll_con0, pll_con2;
>> +       s16 kdiv;
>> +       u64 fvco = parent_rate;
>> +
>> +       pll_con0 = __raw_readl(pll->con_reg);
>> +       pll_con2 = __raw_readl(pll->con_reg + 8);
>> +       mdiv = (pll_con0 >> PLL2650XX_MDIV_SHIFT) & PLL2650XX_MDIV_MASK;
>> +       pdiv = (pll_con0 >> PLL2650XX_PDIV_SHIFT) & PLL2650XX_PDIV_MASK;
>> +       sdiv = (pll_con0 >> PLL2650XX_SDIV_SHIFT) & PLL2650XX_SDIV_MASK;
>> +       kdiv = (s16)(pll_con2 & PLL2650XX_KDIV_MASK);
>> +
>> +       fvco *= (mdiv << 16) + kdiv;
>> +       do_div(fvco, (pdiv << sdiv));
>> +       fvco >>= 16;
>> +
>> +       return (unsigned long)fvco;
>> +}
>> +
>> +static int samsung_pll2650xx_set_rate(struct clk_hw *hw, unsigned long
>> drate,
>> +                                       unsigned long parent_rate)
>> +{
>> +       struct samsung_clk_pll *pll = to_clk_pll(hw);
>> +       u32 tmp, pll_con0, pll_con2;
>> +       const struct samsung_pll_rate_table *rate;
>> +
>> +       rate = samsung_get_pll_settings(pll, drate);
>> +       if (!rate) {
>> +               pr_err("%s: Invalid rate : %lu for pll clk %s\n",
>> __func__,
>> +                       drate, __clk_get_name(hw->clk));
>> +               return -EINVAL;
>> +       }
>> +
>> +       pll_con0 = __raw_readl(pll->con_reg);
>> +       pll_con2 = __raw_readl(pll->con_reg + 8);
>> +
>> +        /* Change PLL PMS values */
>> +       pll_con0 &= ~(PLL2650XX_MDIV_MASK << PLL2650XX_MDIV_SHIFT |
>> +                       PLL2650XX_PDIV_MASK << PLL2650XX_PDIV_SHIFT |
>> +                       PLL2650XX_SDIV_MASK << PLL2650XX_SDIV_SHIFT);
>> +       pll_con0 |= rate->mdiv << PLL2650XX_MDIV_SHIFT;
>> +       pll_con0 |= rate->pdiv << PLL2650XX_PDIV_SHIFT;
>> +       pll_con0 |= rate->sdiv << PLL2650XX_SDIV_SHIFT;
>> +       pll_con0 |= 1 << PLL2650XX_PLL_ENABLE_SHIFT;
>> +       pll_con0 |= 1 << PLL2650XX_PLL_FOUTMASK_SHIFT;
>> +
>> +       pll_con2 &= ~(PLL2650XX_KDIV_MASK << PLL2650XX_KDIV_SHIFT);
>> +       pll_con2 |= ((~(rate->kdiv) + 1) & PLL2650XX_KDIV_MASK)
>> +                       << PLL2650XX_KDIV_SHIFT;
>> +
>> +       /* Set PLL lock time. */
>> +       __raw_writel(PLL2650XX_LOCK_FACTOR * rate->pdiv, pll->lock_reg);
>> +
>> +       __raw_writel(pll_con0, pll->con_reg);
>> +       __raw_writel(pll_con2, pll->con_reg + 8);
>> +
>> +       do {
>> +               tmp = __raw_readl(pll->con_reg);
>> +       } while (!(tmp & (0x1 << PLL2650XX_PLL_LOCKTIME_SHIFT)));
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct clk_ops samsung_pll2650xx_clk_ops = {
>> +       .recalc_rate = samsung_pll2650xx_recalc_rate,
>> +       .set_rate = samsung_pll2650xx_set_rate,
>> +       .round_rate = samsung_pll_round_rate,
>> +};
>> +
>> +static const struct clk_ops samsung_pll2650xx_clk_min_ops = {
>> +       .recalc_rate = samsung_pll2650xx_recalc_rate,
>> +};
>> +
>>   static void __init _samsung_clk_register_pll(struct samsung_clk_provider
>> *ctx,
>>                                 struct samsung_pll_clock *pll_clk,
>>                                 void __iomem *base)
>> @@ -1157,6 +1252,12 @@ static void __init _samsung_clk_register_pll(struct
>> samsung_clk_provider *ctx,
>>                 else
>>                         init.ops = &samsung_pll2550xx_clk_ops;
>>                 break;
>> +       case pll_2650xx:
>> +               if (!pll->rate_table)
>> +                       init.ops = &samsung_pll2650xx_clk_min_ops;
>> +               else
>> +                       init.ops = &samsung_pll2650xx_clk_ops;
>> +               break;
>>         default:
>>                 pr_warn("%s: Unknown pll type for pll clk %s\n",
>>                         __func__, pll_clk->name);
>> diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
>> index ec4bc1d..c0ed4d4 100644
>> --- a/drivers/clk/samsung/clk-pll.h
>> +++ b/drivers/clk/samsung/clk-pll.h
>> @@ -32,6 +32,7 @@ enum samsung_pll_type {
>>         pll_s3c2410_upll,
>>         pll_s3c2440_mpll,
>>         pll_2550xx,
>> +       pll_2650xx,
>>   };
>>     #define PLL_35XX_RATE(_rate, _m, _p, _s)                    \
>
>
> Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>
> --
> Best Regards,
> Pankaj Dubey
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
