From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Jul 2016 17:45:04 -0700
Subject: [PATCH V3 4/8] clk: core: support clocks which requires parents
 enable (part 2)
In-Reply-To: <1467279078-2330-5-git-send-email-aisheng.dong@nxp.com>
References: <1467279078-2330-1-git-send-email-aisheng.dong@nxp.com>
 <1467279078-2330-5-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20160702004504.GM27880@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30, Dong Aisheng wrote:
> On Freescale i.MX7D platform, all clocks operations, including
> enable/disable, rate change and re-parent, requires its parent clock on.
> Current clock core can not support it well.
> This patch adding flag CLK_OPS_PARENT_ENABLE to handle this special case in
> clock core that enable its parent clock firstly for each operation and
> disable it later after operation complete.
> 
> The patch part 2 fixes set clock rate and set parent while its parent
> is off. The most special case is for set_parent() operation which requires
> all parents including both old and new one to be enabled at the same time
> during the operation.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---

Applied to clk-next

> @@ -1502,6 +1514,9 @@ static void clk_change_rate(struct clk_core *core)
>  
>  	trace_clk_set_rate(core, core->new_rate);
>  
> +	if (core->flags & CLK_OPS_PARENT_ENABLE)
> +		clk_core_prepare_enable(parent);
> +

I swapped this with trace_clk_set_rate() so the tracepoint is
closer to the hw operation.

>  	if (!skip_set_rate && core->ops->set_rate)
>  		core->ops->set_rate(core->hw, core->new_rate, best_parent_rate);
>  

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
