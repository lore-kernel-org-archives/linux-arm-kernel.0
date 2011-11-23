From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 23 Nov 2011 14:17:50 -0800
Subject: [RFC V1 2/8] clk: pass parent rate if recalc_rate is NULL
In-Reply-To: <1322046755-13511-3-git-send-email-richard.zhao@linaro.org>
References: <1322046755-13511-1-git-send-email-richard.zhao@linaro.org>
 <1322046755-13511-3-git-send-email-richard.zhao@linaro.org>
Message-ID: <CAPtuhThkadZ9CDnizqZOuUUC47so=PqW3j4gEHiBCoAz2SccAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 3:12 AM, Richard Zhao <richard.zhao@linaro.org> wrote:
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
> ?drivers/clk/clk.c | ? ?4 ++++
> ?1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index ed557c9..2d8422f 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -256,6 +256,8 @@ static void clk_recalc_rates(struct clk *clk)
>
> ? ? ? ?if (clk->ops->recalc_rate)
> ? ? ? ? ? ? ? ?clk->rate = clk->ops->recalc_rate(clk);
> + ? ? ? else if (clk->parent)
> + ? ? ? ? ? ? ? clk->rate = clk->parent->rate;

My code at Linaro Connect did this but Saravana expressed that this
was not a safe assumption to make.  I suppose it depends on how many
clks you want to model, but don't provide good support with
clk_hw_ops.

I'm inclined to leave it out if it is making assumptions that work for
one platform but not another.  Saravana can you clarify if I
understood you correctly?

Regards,
Mike

>
> ? ? ? ?if (old_rate == clk->rate)
> ? ? ? ? ? ? ? ?return;
> @@ -527,6 +529,8 @@ void clk_init(struct device *dev, struct clk *clk)
>
> ? ? ? ?if (clk->ops->recalc_rate)
> ? ? ? ? ? ? ? ?clk->rate = clk->ops->recalc_rate(clk);
> + ? ? ? else if (clk->parent)
> + ? ? ? ? ? ? ? clk->rate = clk->parent->rate;
> ? ? ? ?else
> ? ? ? ? ? ? ? ?clk->rate = 0;
>
> --
> 1.7.5.4
>
>
>
