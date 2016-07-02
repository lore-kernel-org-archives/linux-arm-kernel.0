From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Jul 2016 18:21:40 -0700
Subject: [PATCH v9 01/10] clk: fix initial state of critical clock's
 parents
In-Reply-To: <1466581229-2342-2-git-send-email-erin.lo@mediatek.com>
References: <1466581229-2342-1-git-send-email-erin.lo@mediatek.com>
 <1466581229-2342-2-git-send-email-erin.lo@mediatek.com>
Message-ID: <20160702012140.GB17071@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Resending to everyone)

On 06/22, Erin Lo wrote:
> From: James Liao <jamesjj.liao@mediatek.com>
> 
> This patch fixed wrong state of parent clocks if they are registered
> after critical clocks.
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>

It would be nice if you included the information about the
problem from James' previous mail. This says what it does, but
doesn't explain what the problem is and how it is fixing it.

> ---
>  drivers/clk/clk.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index d584004..e9f5f89 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2388,8 +2388,15 @@ static int __clk_core_init(struct clk_core *core)
>  	hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node) {
>  		struct clk_core *parent = __clk_init_parent(orphan);
>  
> -		if (parent)
> +		if (parent) {
>  			clk_core_reparent(orphan, parent);
> +
> +			if (orphan->prepare_count)
> +				clk_core_prepare(parent);
> +
> +			if (orphan->enable_count)
> +				clk_core_enable(parent);
> +		}
>  	}

I'm pretty sure I pointed this problem out to Mike when the
critical clk patches were being pushed. I can't recall what the
plan was though to fix the problem. I'm pretty sure he said that
clk_core_reparent() would take care of it, but obviously it is
not doing that. Or perhaps it was that clk handoff should figure
out that the parents of a critical clk are also on and thus keep
them on.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
