From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 9 May 2016 15:11:46 -0700
Subject: [PATCH 01/16] clk: fix critical clock locking
In-Reply-To: <1462737711-10017-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160509221146.GS3492@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08, Maxime Ripard wrote:
> The critical clock handling in __clk_core_init isn't taking the enable lock
> before calling clk_core_enable, which in turns triggers the warning in the
> lockdep_assert_held call in that function when lockep is enabled.
> 
> Add the calls to clk_enable_lock/unlock to make sure it doesn't happen.
> 
> Fixes: 32b9b1096186 ("clk: Allow clocks to be marked as CRITICAL")
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---

Why is this patch hiding in this series?

>  drivers/clk/clk.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index ce39add5a258..16a38df3c688 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2404,8 +2404,15 @@ static int __clk_core_init(struct clk_core *core)
>  		core->ops->init(core->hw);
>  
>  	if (core->flags & CLK_IS_CRITICAL) {
> +		unsigned long flags;
> +
> +		clk_prepare_lock();
>  		clk_core_prepare(core);
> +		clk_prepare_unlock();

It looks like we already hold the prepare lock at this point.

> +
> +		flags = clk_enable_lock();
>  		clk_core_enable(core);
> +		clk_enable_unlock(flags);

This seems correct though.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
