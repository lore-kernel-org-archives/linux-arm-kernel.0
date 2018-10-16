From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 16 Oct 2018 14:27:58 -0700
Subject: [PATCH V4 04/11] clk: imx: scu: add scu clock gpr divider
In-Reply-To: <1539504194-28289-5-git-send-email-aisheng.dong@nxp.com>
References: <1539504194-28289-1-git-send-email-aisheng.dong@nxp.com>
 <1539504194-28289-5-git-send-email-aisheng.dong@nxp.com>
Message-ID: <153972527843.5275.15123840961402192766@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting A.s. Dong (2018-10-14 01:07:52)
> +/*
> + * clk_divider_scu_recalc_rate - Get clock rate for a SCU clock
> + * @hw: clock to get rate for
> + * @parent_rate: parent rate provided by common clock framework
> + *
> + * Gets the current clock rate of a SCU clock. Returns the current
> + * clock rate, or zero in failure.
> + */
> +static unsigned long clk_divider_gpr_scu_recalc_rate(struct clk_hw *hw,
> +                                                    unsigned long parent_rate)
> +{
> +       struct clk_divider_gpr_scu *clk = to_clk_divider_gpr_scu(hw);
> +       u32 val;
> +       int ret;
> +
> +       ret = imx_sc_misc_get_control(ccm_ipc_handle, clk->rsrc_id,
> +                                     clk->gpr_id, &val);
> +       if (ret) {
> +               pr_err("%s: failed to get clock rate %d\n",
> +                       clk_hw_get_name(hw), ret);
> +               return 0;
> +       }
> +
> +       return val ? parent_rate / 2 : parent_rate;

I hope parent_rate can't be zero here.

> +}
> +
> +/*
> + * clk_divider_scu_round_rate - Round clock rate for a SCU clock
> + * @hw: clock to round rate for
> + * @rate: rate to round
> + * @parent_rate: parent rate provided by common clock framework
> + *
> + * Round clock rate for a SCU clock according to parent rate
> + */
> +static long clk_divider_gpr_scu_round_rate(struct clk_hw *hw, unsigned long rate,
> +                                          unsigned long *prate)
> +{
> +       if (rate < *prate)
> +               rate = *prate / 2;
> +       else
> +               rate = *prate;
> +
> +       return rate;
> +}
> +
> +/*
> + * clk_divider_scu_set_rate - Set rate for a SCU clock
> + * @hw: clock to change rate for
> + * @rate: target rate for the clock
> + * @parent_rate: rate of the clock parent
> + *
> + * Sets a clock frequency for a SCU clock. Returns the SCU
> + * protocol status.
> + */
> +static int clk_divider_gpr_scu_set_rate(struct clk_hw *hw, unsigned long rate,
> +                                       unsigned long parent_rate)
> +{
> +       struct clk_divider_gpr_scu *clk = to_clk_divider_gpr_scu(hw);
> +       uint32_t val;
> +
> +       val = (rate < parent_rate) ? 1 : 0;

Nitpick: Write it out as 

	val = 0;
	if (rate < parent_rate)
		val = 1;

> +
> +       return imx_sc_misc_set_control(ccm_ipc_handle, clk->rsrc_id,
> +                                      clk->gpr_id, val);
> +}
> +
> +static const struct clk_ops clk_divider_gpr_scu_ops = {
> +       .recalc_rate = clk_divider_gpr_scu_recalc_rate,
> +       .round_rate = clk_divider_gpr_scu_round_rate,
> +       .set_rate = clk_divider_gpr_scu_set_rate,
> +};
> +
> +struct clk_hw *imx_clk_divider_gpr_scu(const char *name, const char *parent_name,
> +                                      u32 rsrc_id, u8 gpr_id)
> +{
> +       struct clk_divider_gpr_scu *div;
> +       struct clk_init_data init;
> +       struct clk_hw *hw;
> +       int ret;
> +
> +       div = kzalloc(sizeof(*div), GFP_KERNEL);
> +       if (!div)
> +               return ERR_PTR(-ENOMEM);
> +
> +       div->rsrc_id = rsrc_id;
> +       div->gpr_id = gpr_id;
> +
> +       init.name = name;
> +       init.ops = &clk_divider_gpr_scu_ops;
> +       init.flags = CLK_GET_RATE_NOCACHE;

Same NOCACHE comment.

> +       init.parent_names = parent_name ? &parent_name : NULL;
> +       init.num_parents = parent_name ? 1 : 0;
> +
> +       div->hw.init = &init;
> +
> +       hw = &div->hw;
> +       ret = clk_hw_register(NULL, hw);
> +       if (ret) {
> +               kfree(div);
> +               hw = ERR_PTR(ret);
> +       }
> +
> +       return hw;
> +}
