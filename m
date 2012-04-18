From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 17 Apr 2012 18:07:25 -0700
Subject: [PATCH 3/3] clk: propagate round_rate for CLK_SET_RATE_PARENT case
In-Reply-To: <1334235019-15553-3-git-send-email-shawn.guo@linaro.org>
References: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
 <1334235019-15553-1-git-send-email-shawn.guo@linaro.org>
 <1334235019-15553-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAJOA=zOYTUA7d2bAXfuN2xYeUOhQ5oQ16FHNn+GkgsFpncJXUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 5:50 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Need to propagate round_rate call for the clk that has no .round_rate
> operation but with flag CLK_SET_RATE_PARENT set.
>
> For example, clk_mux is a clk with no .round_rate operation. ?However,
> it could likely be in a clk_set_rate propagation path, saying it has
> parent clk who has .round_rate and .set_rate operations.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Thanks for the patch Shawn.  I've pulled this into my -next branch.

Regards,
Mike

> ---
> ?drivers/clk/clk.c | ? ?8 ++++++--
> ?1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index d04e1e4..1f1fff1 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -587,8 +587,12 @@ unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
> ? ? ? ?if (!clk)
> ? ? ? ? ? ? ? ?return -EINVAL;
>
> - ? ? ? if (!clk->ops->round_rate)
> - ? ? ? ? ? ? ? return clk->rate;
> + ? ? ? if (!clk->ops->round_rate) {
> + ? ? ? ? ? ? ? if (clk->flags & CLK_SET_RATE_PARENT)
> + ? ? ? ? ? ? ? ? ? ? ? return __clk_round_rate(clk->parent, rate);
> + ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? ? ? ? ? return clk->rate;
> + ? ? ? }
>
> ? ? ? ?if (clk->parent)
> ? ? ? ? ? ? ? ?parent_rate = clk->parent->rate;
> --
> 1.7.5.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
