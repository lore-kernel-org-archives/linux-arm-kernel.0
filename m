From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Jul 2016 17:44:26 -0700
Subject: [PATCH V3 3/8] clk: core: support clocks which requires parents
 enable (part 1)
In-Reply-To: <1467279078-2330-4-git-send-email-aisheng.dong@nxp.com>
References: <1467279078-2330-1-git-send-email-aisheng.dong@nxp.com>
 <1467279078-2330-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20160702004426.GL27880@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30, Dong Aisheng wrote:
> On Freescale i.MX7D platform, all clocks operations, including
> enable/disable, rate change and re-parent, requires its parent
> clock enable. Current clock core can not support it well.
> This patch introduce a new flag CLK_OPS_PARENT_ENABLE to handle this
> special case in clock core that enable its parent clock firstly for
> each operation and disable it later after operation complete.
> 
> The patch part 1 fixes the possible disabling clocks while its parent
> is off during kernel booting phase in clk_disable_unused_subtree().
> 
> Before the completion of kernel booting, clock tree is still not built
> completely, there may be a case that the child clock is on but its
> parent is off which could be caused by either HW initial reset state
> or bootloader initialization.
> 
> Taking bootloader as an example, we may enable all clocks in HW by default.
> And during kernel booting time, the parent clock could be disabled in its
> driver probe due to calling clk_prepare_enable and clk_disable_unprepare.
> Because it's child clock is only enabled in HW while its SW usecount
> in clock tree is still 0, so clk_disable of parent clock will gate
> the parent clock in both HW and SW usecount ultimately. Then there will
> be a child clock is still on in HW but its parent is already off.
> 
> Later in clk_disable_unused(), this clock disable accessing while its
> parent off will cause system hang due to the limitation of HW which
> must require its parent on.
> 
> This patch simply enables the parent clock first before disabling
> if flag CLK_OPS_PARENT_ENABLE is set in clk_disable_unused_subtree().
> This is a simple solution and only affects booting time.
> 
> After kernel booting up the clock tree is already created, there will
> be no case that child is off but its parent is off.
> So no need do this checking for normal clk_disable() later.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
