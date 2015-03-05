From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Thu, 5 Mar 2015 10:43:21 +0800
Subject: [PATCH] clk: mediatek: Export CPU mux clocks for CPU frequency
 control
In-Reply-To: <20150304112109.GB11010@pengutronix.de>
References: <1425466152-7867-1-git-send-email-pi-cheng.chen@linaro.org>
 <20150304112109.GB11010@pengutronix.de>
Message-ID: <CALx668WKKmifhuODsV+Uaoq4ggcmB1=wbpLzXBnjEtxbuB4qig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On 4 March 2015 at 19:21, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Wed, Mar 04, 2015 at 06:49:11PM +0800, pi-cheng.chen wrote:
>> This patch adds CPU mux clocks which are used by Mediatek cpufreq driver
>> for intermediate clock source switching. This patch is based on Mediatek
>> clock driver patches[1].
>>
>> [1] http://thread.gmane.org/gmane.linux.kernel/1892436
>>
>> Signed-off-by: pi-cheng.chen <pi-cheng.chen@linaro.org>
>> ---
>> +static long clk_cpumux_determine_rate(struct clk_hw *hw, unsigned long rate,
>> +                                   unsigned long min_rate,
>> +                                   unsigned long max_rate,
>> +                                   unsigned long *best_parent_rate,
>> +                                   struct clk_hw **best_parent_p)
>> +{
>> +     struct clk *clk = hw->clk, *parent;
>> +     unsigned long parent_rate;
>> +     int i;
>> +
>> +     for (i = MAINPLL_INDEX; i >= ARMPLL_INDEX; i--) {
>> +             parent = clk_get_parent_by_index(clk, i);
>> +             if (!parent)
>> +                     return 0;
>> +
>> +             if (i == MAINPLL_INDEX) {
>> +                     parent_rate = __clk_get_rate(parent);
>> +                     if (parent_rate == rate)
>> +                             break;
>> +             }
>> +
>> +             parent_rate = __clk_round_rate(parent, rate);
>> +     }
>> +
>> +     *best_parent_rate = parent_rate;
>> +     *best_parent_p = __clk_get_hw(parent);
>> +     return parent_rate;
>> +}
>
> Why this determine_rate hook? If you want to switch the clock to some
> intermediate parent I would assume you do this explicitly by setting the
> parent and not implicitly by setting a rate.
>

I use determine_rate hook here because I am using generic cpufreq-dt
driver and I want to make clock switching transparent to cpufreq-dt.
I.e. when I am trying to switch the clock from ARMPLL to MAINPLL, I
call clk_set_rate() with the rate of MAINPLL, and determine_rate will
select MAINPLL as the new parent.

>> +int mtk_clk_register_cpumuxes(struct device_node *node,
>> +                           struct mtk_composite *clks, int num,
>> +                           struct clk_onecell_data *clk_data)
>> +{
>> +     int i;
>> +     struct clk *clk;
>> +     struct regmap *regmap;
>> +
>> +     if (!clk_data)
>> +             return -ENOMEM;
>> +
>> +     regmap = syscon_node_to_regmap(node);
>> +     if (IS_ERR(regmap)) {
>> +             pr_err("Cannot find regmap for %s: %ld\n", node->full_name,
>> +                    PTR_ERR(regmap));
>> +             return PTR_ERR(regmap);
>> +     }
>> +
>> +     for (i = 0; i < num; i++) {
>> +             struct mtk_composite *mux = &clks[i];
>> +
>> +             clk = mtk_clk_register_cpumux(mux->name, mux->parent_names,
>> +                                           mux->num_parents, regmap,
>> +                                           mux->mux_reg, mux->mux_shift,
>> +                                           mux->mux_width);
>
> Pass 'mux' directly instead of dispatching this struct into the
> individual fields.
> Also, probably better to move this function to
> drivers/clk/mediatek/clk-cpumux.c

Will do it. Thanks for reviewing.

Best Regards,
Pi-Cheng

>
> Sascha
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
