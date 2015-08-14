From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 13 Aug 2015 18:01:09 -0700
Subject: [PATCH V3 4/5] clk: core: add CLK_OPS_PARENT_ON flags to support
 clocks require parent on
In-Reply-To: <1438089585-30103-5-git-send-email-aisheng.dong@freescale.com>
References: <1438089585-30103-1-git-send-email-aisheng.dong@freescale.com>
 <1438089585-30103-5-git-send-email-aisheng.dong@freescale.com>
Message-ID: <20150814010109.GW26614@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28, Dong Aisheng wrote:
> On Freescale i.MX7D platform, all clocks operations, including
> enable/disable, rate change and re-parent, requires its parent
> clock on. Current clock core can not support it well.
> This patch introduce a new flag CLK_OPS_PARENT_ON to handle this
> special case in clock core that enable its parent clock firstly for
> each operation and disable it later after operation complete.
> 
> This patch fixes disaling clocks while its parent is off.
> This is a special case that is caused by a state mis-align between
> HW and SW in clock tree during booting.
> Usually in uboot, we may enable all clocks in HW by default.
> And during kernel booting time, the parent clock could be disabled in its
> driver probe due to calling clk_prepare_enable and clk_disable_unprepare.
> Because it's child clock is only enabled in HW while its SW usecount
> in clock tree is still 0, so clk_disable of parent clock will gate
> the parent clock in both HW and SW usecount ultimately.
> Then there will be a clock is on in HW while its parent is disabled.
> 
> Later when clock core does clk_disable_unused, this clock disable
> will cause system hang due to the limitation of operation requiring
> its parent clock on.
> 
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
> ---

Sorry, I still don't agree with this patch. There's no reason we
should be turning on clocks during late init so that we can turn
off clocks. If there's some sort of problem in doing that we
should figure it out and make it so that during late init we turn
off clocks from the leaves of the tree to the root.

I agree that there's a problem here where we don't properly
handle keeping children clocks on if a driver comes in and turns
off a clock in the middle of the tree before late init. That's a
real bug, and we should fix it. Mike Turquette has been doing
some work to have a way to indicate that certain clocks should be
kept on until client drivers grab them. I think it will also make
sure to up refcounts on parent clocks in the middle of the tree
when it figures out that a child clock is enabled. Would that be
all that we need to do to fix this problem?

Also, the subject of this patch and patch 5 are the same. Why?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
