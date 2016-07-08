From: mturquette@baylibre.com (Michael Turquette)
Date: Fri, 08 Jul 2016 11:36:16 -0700
Subject: [PATCH v4 4/7] rtc: ac100: Add clk output support
In-Reply-To: <1467302331-9663-5-git-send-email-wens@csie.org>
References: <1467302331-9663-1-git-send-email-wens@csie.org>
 <1467302331-9663-5-git-send-email-wens@csie.org>
Message-ID: <146800297598.73491.13472152266331488346@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Chen-Yu Tsai (2016-06-30 08:58:48)
> +static long ac100_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
> +                                   unsigned long prate)
> +{
> +       unsigned long best_rate = 0, tmp_rate, tmp_prate;
> +       int i;
> +
> +       if (prate == AC100_RTC_32K_RATE)
> +               return divider_round_rate(hw, rate, &prate, NULL,
> +                                         AC100_CLKOUT_DIV_WIDTH,
> +                                         CLK_DIVIDER_POWER_OF_TWO);
> +
> +       for (i = 0; ac100_clkout_prediv[i].div; i++) {
> +               tmp_prate = DIV_ROUND_UP(prate, ac100_clkout_prediv[i].val);
> +               tmp_rate = divider_round_rate(hw, rate, &tmp_prate, NULL,
> +                                             AC100_CLKOUT_DIV_WIDTH,
> +                                             CLK_DIVIDER_POWER_OF_TWO);
> +
> +               if (tmp_rate > rate)
> +                       continue;
> +               if (rate - tmp_rate < best_rate - tmp_rate)
> +                       best_rate = tmp_rate;
> +       }
> +
> +       return best_rate;
> +}
> +
> +static int ac100_clkout_determine_rate(struct clk_hw *hw,
> +                                      struct clk_rate_request *req)
> +{
> +       struct clk_hw *best_parent;
> +       unsigned long best = 0;
> +       int i, num_parents = clk_hw_get_num_parents(hw);
> +
> +       for (i = 0; i < num_parents; i++) {
> +               struct clk_hw *parent = clk_hw_get_parent_by_index(hw, i);
> +               unsigned long tmp, prate = clk_hw_get_rate(parent);
> +
> +               tmp = ac100_clkout_round_rate(hw, req->rate, prate);
> +
> +               if (tmp > req->rate)
> +                       continue;
> +               if (req->rate - tmp < req->rate - best) {
> +                       best = tmp;
> +                       best_parent = parent;
> +               }
> +       }
> +
> +       if (!best)
> +               return -EINVAL;
> +
> +       req->best_parent_hw = best_parent;
> +       req->best_parent_rate = best;
> +       req->rate = best;
> +
> +       return 0;
> +}

You only need one of the two functions above. Keep the .determine_rate
callback and drop .round_rate.

Otherwise the rest of the clk support looks great to me. Feel free to
add:

Reviewed-by: Michael Turquette <mturquette@baylibre.com>

Regards,
Mike
