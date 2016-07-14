From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 Jul 2016 11:34:34 +0800
Subject: [PATCH v4 4/7] rtc: ac100: Add clk output support
In-Reply-To: <146800297598.73491.13472152266331488346@resonance>
References: <1467302331-9663-1-git-send-email-wens@csie.org>
 <1467302331-9663-5-git-send-email-wens@csie.org>
 <146800297598.73491.13472152266331488346@resonance>
Message-ID: <CAGb2v67ft=EktCcfGFdBN1K4SoOyK+Stz2WuvqScMmRjoBWxfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 9, 2016 at 2:36 AM, Michael Turquette
<mturquette@baylibre.com> wrote:
> Quoting Chen-Yu Tsai (2016-06-30 08:58:48)
>> +static long ac100_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
>> +                                   unsigned long prate)
>> +{
>> +       unsigned long best_rate = 0, tmp_rate, tmp_prate;
>> +       int i;
>> +
>> +       if (prate == AC100_RTC_32K_RATE)
>> +               return divider_round_rate(hw, rate, &prate, NULL,
>> +                                         AC100_CLKOUT_DIV_WIDTH,
>> +                                         CLK_DIVIDER_POWER_OF_TWO);
>> +
>> +       for (i = 0; ac100_clkout_prediv[i].div; i++) {
>> +               tmp_prate = DIV_ROUND_UP(prate, ac100_clkout_prediv[i].val);
>> +               tmp_rate = divider_round_rate(hw, rate, &tmp_prate, NULL,
>> +                                             AC100_CLKOUT_DIV_WIDTH,
>> +                                             CLK_DIVIDER_POWER_OF_TWO);
>> +
>> +               if (tmp_rate > rate)
>> +                       continue;
>> +               if (rate - tmp_rate < best_rate - tmp_rate)
>> +                       best_rate = tmp_rate;
>> +       }
>> +
>> +       return best_rate;
>> +}
>> +
>> +static int ac100_clkout_determine_rate(struct clk_hw *hw,
>> +                                      struct clk_rate_request *req)
>> +{
>> +       struct clk_hw *best_parent;
>> +       unsigned long best = 0;
>> +       int i, num_parents = clk_hw_get_num_parents(hw);
>> +
>> +       for (i = 0; i < num_parents; i++) {
>> +               struct clk_hw *parent = clk_hw_get_parent_by_index(hw, i);
>> +               unsigned long tmp, prate = clk_hw_get_rate(parent);
>> +
>> +               tmp = ac100_clkout_round_rate(hw, req->rate, prate);
>> +
>> +               if (tmp > req->rate)
>> +                       continue;
>> +               if (req->rate - tmp < req->rate - best) {
>> +                       best = tmp;
>> +                       best_parent = parent;
>> +               }
>> +       }
>> +
>> +       if (!best)
>> +               return -EINVAL;
>> +
>> +       req->best_parent_hw = best_parent;
>> +       req->best_parent_rate = best;
>> +       req->rate = best;
>> +
>> +       return 0;
>> +}
>
> You only need one of the two functions above. Keep the .determine_rate
> callback and drop .round_rate.

Only .round_rate is set in the clk_ops. ac100_clkout_round_rate just
serves to split out some of the calculations done per parent.

> Otherwise the rest of the clk support looks great to me. Feel free to
> add:
>
> Reviewed-by: Michael Turquette <mturquette@baylibre.com>

Thanks!

ChenYu
