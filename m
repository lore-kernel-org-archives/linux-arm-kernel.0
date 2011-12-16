From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 16 Dec 2011 13:21:18 -0800
Subject: [RFC V2 1/8] clk: pass parent rate if recalc_rate is NULL
In-Reply-To: <1323854638-3455-2-git-send-email-richard.zhao@linaro.org>
References: <1323854638-3455-1-git-send-email-richard.zhao@linaro.org>
 <1323854638-3455-2-git-send-email-richard.zhao@linaro.org>
Message-ID: <CAPtuhTjbL6zPv1WGA_tV5dfXbdsqLk+gazG5ZSnwDELkRn5RaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 1:23 AM, Richard Zhao <richard.zhao@linaro.org> wrote:
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
> ?drivers/clk/clk.c | ? ?4 ++++
> ?1 files changed, 4 insertions(+), 0 deletions(-)

Last time this patch came up I pointed out that Saravana objected to
it at Linaro Connect but there was no response, so I'll try again.

Saravana, do you still dislike this change for your platform?
Otherwise it seems like a sane default and I'll take it in for the
next series.

Regards,
Mike

> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index a6ddbb1..30ba22e 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -470,6 +470,8 @@ static void __clk_recalc_rates(struct clk *clk, unsigned long msg)
>
> ? ? ? ?if (clk->ops->recalc_rate)
> ? ? ? ? ? ? ? ?clk->rate = clk->ops->recalc_rate(clk);
> + ? ? ? else if (clk->parent)
> + ? ? ? ? ? ? ? clk->rate = clk->parent->rate;
>
> ? ? ? ?/* ignore return value for POST_RATE_CHANGE & ABORT_RATE_CHANGE */
> ? ? ? ?if (clk->notifier_count)
> @@ -864,6 +866,8 @@ void clk_init(struct device *dev, struct clk *clk)
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
