From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 19 Mar 2018 18:11:32 -0700
Subject: [PATCH v5 08/12] clk: actions: Add factor clock support
In-Reply-To: <20180317100952.28538-9-manivannan.sadhasivam@linaro.org>
References: <20180317100952.28538-1-manivannan.sadhasivam@linaro.org>
 <20180317100952.28538-9-manivannan.sadhasivam@linaro.org>
Message-ID: <152150829204.254778.2737344357539002182@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Manivannan Sadhasivam (2018-03-17 03:09:48)
> +
> +static int clk_val_best(struct clk_hw *hw, unsigned long rate,
> +                       unsigned long *best_parent_rate)
> +{
[...]
> +               }
> +
> +               parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw),
> +                               try_parent_rate);
> +               cur_rate = DIV_ROUND_UP(parent_rate, clkt->div) * clkt->mul;
> +               if (cur_rate <= rate && cur_rate > best) {
> +                       bestval = clkt->val;
> +                       best = cur_rate;
> +                       *best_parent_rate = parent_rate;
> +               }
> +       }
> +
> +       if (!bestval) {
> +               bestval = _get_table_maxval(clkt);
> +               *best_parent_rate = clk_hw_round_rate(
> +                               clk_hw_get_parent(hw), 1);
> +       }
> +
> +       return bestval;

Also, if this is largely copy/paste from the factor clk code then
perhaps those functions can be exported to here and reused instead of
copy/paste.

> +}
