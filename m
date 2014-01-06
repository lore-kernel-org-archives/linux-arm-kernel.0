From: r.sh.open@gmail.com (Rahul Sharma)
Date: Mon, 6 Jan 2014 17:06:50 +0530
Subject: [PATCH 5/7] clk/samsung: add support for pll2550xx
In-Reply-To: <1450803.Oy1I8miDAj@amdc1227>
References: <1386345391-23482-1-git-send-email-rahul.sharma@samsung.com>
 <1386345391-23482-6-git-send-email-rahul.sharma@samsung.com>
 <1450803.Oy1I8miDAj@amdc1227>
Message-ID: <CAPdUM4PZFK4fMSjJd-gpb4tb3khwWwaG5GeJR5yi_=RMn9EaQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 19 December 2013 17:31, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Pankaj, Rahul, Arun,
>
> On Friday 06 of December 2013 21:26:29 Rahul Sharma wrote:
>> From: Pankaj Dubey <pankaj.dubey@samsung.com>
>>
>> exynos5260 use pll2520xx and it has different bitfields
>> for P,M,S values as compared to pll2550xx. Support for
>> pll2520xx is added here.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
>> Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
>> ---
>>  drivers/clk/samsung/clk-pll.c |  107 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/clk/samsung/clk-pll.h |    1 +
>>  2 files changed, 108 insertions(+)
>>
>> diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
>> index e8e8953..237a889 100644
>> --- a/drivers/clk/samsung/clk-pll.c
>> +++ b/drivers/clk/samsung/clk-pll.c
>> @@ -710,6 +710,107 @@ struct clk * __init samsung_clk_register_pll2550x(const char *name,
>>       return clk;
>>  }
>>
>> +/*
>> + * PLL2550xx Clock Type
>> + */
>> +
>> +/* Maximum lock time can be 270 * PDIV cycles */
>> +#define PLL2550XX_LOCK_FACTOR (270)
>> +
>> +#define PLL2550XX_MDIV_MASK          (0x3FF)
>> +#define PLL2550XX_PDIV_MASK          (0x3F)
>> +#define PLL2550XX_SDIV_MASK          (0x7)
>> +#define PLL2550XX_LOCK_STAT_MASK     (0x1)
>> +#define PLL2550XX_MDIV_SHIFT         (9)
>> +#define PLL2550XX_PDIV_SHIFT         (3)
>> +#define PLL2550XX_SDIV_SHIFT         (0)
>> +#define PLL2550XX_LOCK_STAT_SHIFT    (21)
>> +
>> +static unsigned long samsung_pll2550xx_recalc_rate(struct clk_hw *hw,
>> +                             unsigned long parent_rate)
>> +{
>> +     struct samsung_clk_pll *pll = to_clk_pll(hw);
>> +     u32 mdiv, pdiv, sdiv, pll_con;
>> +     u64 fvco = parent_rate;
>> +
>> +     pll_con = __raw_readl(pll->con_reg);
>> +     mdiv = (pll_con >> PLL2550XX_MDIV_SHIFT) & PLL2550XX_MDIV_MASK;
>> +     pdiv = (pll_con >> PLL2550XX_PDIV_SHIFT) & PLL2550XX_PDIV_MASK;
>> +     sdiv = (pll_con >> PLL2550XX_SDIV_SHIFT) & PLL2550XX_SDIV_MASK;
>> +
>> +     fvco *= mdiv;
>> +     do_div(fvco, (pdiv << sdiv));
>> +
>> +     return (unsigned long)fvco;
>> +}
>> +
>> +static inline bool samsung_pll2550xx_mp_change(u32 mdiv, u32 pdiv, u32 pll_con)
>> +{
>> +     if ((mdiv != ((pll_con >> PLL2550XX_MDIV_SHIFT) &
>> +                             PLL2550XX_MDIV_MASK)) ||
>> +             (pdiv != ((pll_con >> PLL2550XX_PDIV_SHIFT) &
>> +                             PLL2550XX_PDIV_MASK)))
>> +             return 1;
>> +     else
>> +             return 0;
>
> This doesn't look too good. Can you make this consistent with
> implementations of this helper for other PLLs, such as
> samsung_pll35xx_mp_change()?

I have changed this in V2.

>
>> +}
>> +
>> +static int samsung_pll2550xx_set_rate(struct clk_hw *hw, unsigned long drate,
>> +                                     unsigned long prate)
>> +{
>> +     struct samsung_clk_pll *pll = to_clk_pll(hw);
>> +     const struct samsung_pll_rate_table *rate;
>> +     u32 tmp;
>> +
>> +     /* Get required rate settings from table */
>> +     rate = samsung_get_pll_settings(pll, drate);
>> +     if (!rate) {
>> +             pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
>> +                     drate, __clk_get_name(hw->clk));
>> +             return -EINVAL;
>> +     }
>> +
>> +     tmp = __raw_readl(pll->con_reg);
>> +
>> +     if (!(samsung_pll2550xx_mp_change(rate->mdiv, rate->pdiv, tmp))) {
>> +             /* If only s change, change just s value only*/
>> +             tmp &= ~(PLL2550XX_SDIV_MASK << PLL2550XX_SDIV_SHIFT);
>> +             tmp |= rate->sdiv << PLL2550XX_SDIV_SHIFT;
>> +             __raw_writel(tmp, pll->con_reg);
>> +     } else {
>
> Please make coding style of this function consistent with implementations
> of this operation for other PLLs, such as samsung_pll35xx_set_rate().
>
> Otherwise the patch looks fine.

Ok.

Regards,
Rahul Sharma.

>
> Best regards,
> Tomasz
>
