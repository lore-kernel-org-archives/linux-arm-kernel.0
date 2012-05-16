From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 15 May 2012 23:00:50 -0700
Subject: [PATCH] clk: Fix race conditions between clk_set_parent() and
 clk_enable()
In-Reply-To: <1336798797-8724-1-git-send-email-skannan@codeaurora.org>
References: <1336798797-8724-1-git-send-email-skannan@codeaurora.org>
Message-ID: <CAJOA=zNVQUDbHQCgnQ56S50fva2eKUXAH9aVkTbtyvQW+fq9SA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 9:59 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
> Since clocks with CLK_SET_PARENT_GATE flag only allow clk_set_parent() on
> unprepared clocks and calling clk_enable() on an unprepared clock would be
> violating the clock API usage model, allow set_parent() ops to be sleepable
> for clocks which have the CLK_SET_PARENT_GATE flag. Putting it another way,
> if a clock's parent can't be switched without sleeping, then by definition
> the parent can't be switched while it's prepared (CLK_SET_PARENT_GATE).
>
...
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index e5d5dc1..09b9112 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1059,7 +1059,7 @@ static int __clk_set_parent(struct clk *clk, struct clk *parent)
> ?{
> ? ? ? ?struct clk *old_parent;
> ? ? ? ?unsigned long flags;
> - ? ? ? int ret = -EINVAL;
> + ? ? ? int ret;
> ? ? ? ?u8 i;
>
> ? ? ? ?old_parent = clk->parent;
> @@ -1083,7 +1083,13 @@ static int __clk_set_parent(struct clk *clk, struct clk *parent)
> ? ? ? ?if (i == clk->num_parents) {
> ? ? ? ? ? ? ? ?pr_debug("%s: clock %s is not a possible parent of clock %s\n",
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?__func__, parent->name, clk->name);
> - ? ? ? ? ? ? ? goto out;
> + ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? }
> +
> + ? ? ? if (clk->flags & CLK_SET_PARENT_GATE) {
> + ? ? ? ? ? ? ? ret = clk->ops->set_parent(clk->hw, i);
> + ? ? ? ? ? ? ? clk->parent = parent;
> + ? ? ? ? ? ? ? return ret;
> ? ? ? ?}
>
> ? ? ? ?/* migrate prepare and enable */

The above hunk is a good change since it fixes a bug where we
prepare/enable the parent clocks around the .set_parent callback, even
when CLK_SET_PARENT_GATE is set.  It should be a separate patch.

Thanks,
Mike
