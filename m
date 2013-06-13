From: yadi.brar01@gmail.com (Yadwinder Singh Brar)
Date: Fri, 14 Jun 2013 00:05:31 +0530
Subject: [PATCH v4 1/6] clk: samsung: Use clk->base instead of directly
 using clk->con0 for PLL3xxx
In-Reply-To: <4909432.mh6TOzaEGM@flatron>
References: <1370272196-4346-1-git-send-email-yadi.brar@samsung.com>
 <CAL1qeaF-tsY727eLBdWRW3iBsTtygFLbjm6nFRCu+xV6XzpFSA@mail.gmail.com>
 <CAKew6eVUGzLweLsQkYx-VGxbzWjUbROk0_63djSsYyH17tbGvg@mail.gmail.com>
 <4909432.mh6TOzaEGM@flatron>
Message-ID: <CAKew6eXxdanR-4aoWGAw3j2co+Kke4joWcXQ6xjZ3UTC1j-ycw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 3:00 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On Thursday 13 of June 2013 12:32:05 Yadwinder Singh Brar wrote:
>> On Thu, Jun 13, 2013 at 3:32 AM, Andrew Bresticker
>>
>> <abrestic@chromium.org> wrote:
>> > Doug,
>> >
>> >>> Hmm, if done properly, it could simplify PLL registration in SoC
>> >>> clock
>> >>> initialization code a lot.
>> >>>
>> >>> I'm not sure if this is really the best solution (feel free to
>> >>> suggest
>> >>> anything better), but we could put PLLs in an array, like other
>> >>> clocks,
>> >>> e.g.
>> >>>
>> >>>         ... exynos4210_pll_clks[] = {
>> >>>
>> >>>                 CLK_PLL45XX(...),
>> >>>                 CLK_PLL45XX(...),
>> >>>                 CLK_PLL46XX(...),
>> >>>                 CLK_PLL46XX(...),
>> >>>
>> >>>         };
>> >>>
>> >>> and then just call a helper like
>> >>>
>> >>>         samsung_clk_register_pll(exynos4210_pll_clks,
>> >>>
>> >>>                         ARRAY_SIZE(exynos4210_pll_clks));
>> >>
>> >> Something like that looks like what I was thinking.  I'd have to see
>> >> it actually coded up to see if there's something I'm missing that
>> >> would prevent us from doing that, but I don't see anything.
>> >
>> > The only issue I see with this is that we may only want to register a
>> > rate table with a PLL only if fin_pll is running at a certain rate.
>> > On 5250 and 5420, for example, we have EPLL and VPLL rate tables that
>> > should only be registered if fin_pll is 24Mhz.  We may have to
>> > register those separately, but this approach seems fine otherwise.
>>
>> As Andrew Bresticker said, we will face problem with different table,
>> and it will give some pain while handling such cases but I think
>> overall code may look better.
>>
>> Similar thoughts were their in my mind also, but i didn't want to
>> disturb this series :).
>
> Yes, I was thinking the same as well, but now that Exynos5420 doesn't
> follow the 0x100 register spacing, we have a problem :) .
>
>> Anyways, I think we can do it now only rather going for incremental
>> patches after this series.
>> I was thinking to make samsung_clk_register_pllxxxx itself  little
>> generic instead
>> of using helper, as we are almost duplicating code for most PLLs.
>>
>> A rough picture in my mind was,
>> After implementing  generic samung_clk_register_pll(), code may look
>> like below. Its just an idea, please feel free to correct it.
>> Later we can factor out other common clk.ops for PLLs also.
>>
>> this diff is over this series.
>> Assuming a generic samung_clk_register_pll() is their(which i think is
>> not impossible)
>> 8<----------------------------------------------------------------------
>> ----
>>
>> --- a/drivers/clk/samsung/clk-exynos5250.c
>> +++ b/drivers/clk/samsung/clk-exynos5250.c
>> @@ -493,6 +493,20 @@ static __initdata struct samsung_pll_rate_table
>> epll_24mhz_tbl[] = {
>>         PLL_36XX_RATE(32768000, 131, 3, 5, 4719),
>>  };
>>
>> +struct __initdata samsung_pll_init_data samsung_plls[] = {
>> +       PLL(pll_3500, "fout_apll", "fin_pll", APLL_LOCK, APLL_CON0,
>> NULL), +       PLL(pll_3500, "fout_mpll", "fin_pll", MPLL_LOCK,
>> MPLL_CON0, NULL), +       PLL(pll_3500, "fout_bpll",
>> "fin_pll",BPLL_LOCK, BPLL_CON0, NULL), +       PLL(pll_3500,
>> "fout_gpll", "fin_pll",GPLL_LOCK, GPLL_CON0, NULL), +
>> PLL(pll_3500, "fout_cpll", "fin_pll",BPLL_LOCK, CPLL_CON0, NULL), +};
>> +
>> +struct __initdata samsung_pll_init_data epll_init_data =
>> +       PLL(pll_3600, "fout_epll", "fin_pll", EPLL_LOCK, EPLL_CON0,
>> NULL); +
>> +struct __initdata samsung_pll_init_data vpll_init_data =
>> +       PLL(pll_3600, "fout_epll", "fin_pll", VPLL_LOCK, VPLL_CON0,
>> NULL); +
>
> This is mostly what I had in my mind. In addition I think I might have a
> solution for rate tables:
>
> If we create another array
>
>         struct samsung_pll_rate_table *rate_tables_24mhz[] = {
>                 apll_rate_table_24mhz,
>                 mpll_rate_table_24mhz, /* can be NULL as well, if no
> support for rate change */
>                 epll_rate_table_24mhz,
>                 vpll_rate_table_24mhz,
>                 /* ... */
>         };
>
> which lists rate tables for given input frequency. This relies on making
> rate tables end with a sentinel, to remove the need of passing array
> sizes.
>

I think we may also have to make assumption that entries in the arrays
rate_tables_24mhz[] and samsung_plls[] should be in same order in
both arrays, and which may not be fair assumption, otherwise we
have to use some mechanism to identify which rate_table is for which PLL,
which will increase code and complexity.
Am I missed something or you are thinking something else?

Any thoughts from Doug or others ?

>>  /* register exynox5250 clocks */
>>  void __init exynos5250_clk_init(struct device_node *np)
>>  {
>> @@ -519,44 +533,22 @@ void __init exynos5250_clk_init(struct device_node
>> *np) samsung_clk_register_mux(exynos5250_pll_pmux_clks,
>>                         ARRAY_SIZE(exynos5250_pll_pmux_clks));
>>
>> -       fin_pll_rate = _get_rate("fin_pll");
>> +       samsung_clk_register_pll(samsung_plls,
>> ARRAY_SIZE(samsung_plls)); +
>
> ...and then pass it here like:
>
>         if (fin_pll_rate == 24 * MHZ) {
>                 samsung_clk_register_pll(samsung_plls,
> ARRAY_SIZE(samsung_plls), rate_tables_24mhz);
>         } else {
>                 /* warning or whatever */
>                 samsung_clk_register_pll(samsung_plls,
> ARRAY_SIZE(samsung_plls), NULL);
>         }
>
> This way we could specify different rate tables depending on input
> frequency for a whole group of PLLs.
>

I think code lines or complexity will be same.
Also all PLLs may not have same parent.

> The only thing I don't like here is having two separate arrays that need
> to have the same sizes. Feel free to improve (or discard) this idea,
> though.
>

Sorry, I didn't get your point. You are talking about which two arrays?

Regards,
Yadwinder

> Best regards,
> Tomasz
>
>>         vpllsrc = __clk_lookup("mout_vpllsrc");
>>         if (vpllsrc)
>>                 mout_vpllsrc_rate = clk_get_rate(vpllsrc);
>>
>> -       apll = samsung_clk_register_pll35xx("fout_apll", "fin_pll",
>> -                       reg_base, NULL, 0);
>> -       mpll = samsung_clk_register_pll35xx("fout_mpll", "fin_pll",
>> -                       reg_base + 0x4000, NULL, 0);
>> -       bpll = samsung_clk_register_pll35xx("fout_bpll", "fin_pll",
>> -                       reg_base + 0x20010, NULL, 0);
>> -       gpll = samsung_clk_register_pll35xx("fout_gpll", "fin_pll",
>> -                       reg_base + 0x10050, NULL, 0);
>> -       cpll = samsung_clk_register_pll35xx("fout_cpll", "fin_pll",
>> -                       reg_base + 0x10020, NULL, 0);
>> -
>> +       fin_pll_rate = _get_rate("fin_pll");
>>         if (fin_pll_rate == (24 * MHZ)) {
>> -               epll = samsung_clk_register_pll36xx("fout_epll",
>> "fin_pll", -                               reg_base + 0x10030,
>> epll_24mhz_tbl, -
>> ARRAY_SIZE(epll_24mhz_tbl));
>> -       } else {
>> -               pr_warn("%s: valid epll rate_table missing for\n"
>> -                       "parent fin_pll:%lu hz\n", __func__,
>> fin_pll_rate); -               epll =
>> samsung_clk_register_pll36xx("fout_epll", "fin_pll", -
>>              reg_base + 0x10030, NULL, 0);
>> +               epll_init_data.rate_table =  epll_24mhz_tb;
>>         }
>> +       samsung_clk_register_pll(&fout_epll_data, 1);
>>
>>         if (mout_vpllsrc_rate == (24 * MHZ)) {
>> -               vpll = samsung_clk_register_pll36xx("fout_vpll",
>> "mout_vpllsrc" -                       , reg_base + 0x10040,
>> vpll_24mhz_tbl,
>> -                       ARRAY_SIZE(vpll_24mhz_tbl));
>> -       } else {
>> -               pr_warn("%s: valid vpll rate_table missing for\n"
>> -                       "parent mout_vpllsrc_rate:%lu hz\n", __func__,
>> -                       mout_vpllsrc_rate);
>> -               samsung_clk_register_pll36xx("fout_vpll",
>> "mout_vpllsrc", -                       reg_base + 0x10040, NULL, 0);
>> +               vpll_init_data.rate_table =  epll_24mhz_tb;
>>         }
>> +       samsung_clk_register_pll(&fout_epll_data, 1);
>>         samsung_clk_register_fixed_rate(exynos5250_fixed_rate_clks,
>>                         ARRAY_SIZE(exynos5250_fixed_rate_clks));
>> diff --git a/drivers/clk/samsung/clk-pll.h
>> b/drivers/clk/samsung/clk-pll.h index 4780e6c..3b02dc5 100644
>> --- a/drivers/clk/samsung/clk-pll.h
>> +++ b/drivers/clk/samsung/clk-pll.h
>> @@ -39,6 +39,39 @@ struct samsung_pll_rate_table {
>>         unsigned int kdiv;
>>  };
>>
>> +#define PLL(_type, _name, _pname, _lock_reg, _con_reg, _rate_table)
>> \ +       {
>>   \ +               .type   =       _type,
>>     \ +               .name   =       _name,
>>       \ +               .parent_name =  _pname,
>>         \ +               .flags  =       CLK_GET_RATE_NOCACHE,
>>           \ +               .rate_table =   _rate_table,
>>             \ +               .con_reg =      _con_reg,
>>               \ +               .lock_reg =     _lock_reg,
>>                 \ +       }
>> +
>> +enum samsung_pll_type {
>> +       pll_3500,
>> +       pll_45xx,
>> +       pll_2550,
>> +       pll_3600,
>> +       pll_46xx,
>> +       pll_2660,
>> +};
>> +
>> +
>> +struct samsung_pll_init_data {
>> +       enum            samsung_pll_type type;
>> +       struct          samsung_pll_rate_table *rate_table;
>> +       const char      *name;
>> +       const char      *parent_name;
>> +       unsigned long   flags;
>> +       const void __iomem *con_reg;
>> +       const void __iomem *lock_reg;
>> +};
>> +
>> +extern int  __init samsung_clk_register_pll(struct
>> samsung_pll_init_data *data, +                               unsigned
>> int nr_pll);
>> +
>>
>> Regards,
>> Yadwinder
