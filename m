From: adrian.wenl@gmail.com (Lei Wen)
Date: Tue, 8 May 2012 21:08:54 +0800
Subject: [PATCH V2] clk: give clock chance to change parent at setrate
 stage
In-Reply-To: <CALZhoSQcjrOk3s6NFRs34H5uiYWK+TYeqJpoiwC6XSF+xPXrzg@mail.gmail.com>
References: <CAG9bXvmAf-0fmVb8nzWkuAKaMoOJVzR=hThwXpN_izQzM26q-g@mail.gmail.com>
 <1336146319-6803-1-git-send-email-leiwen@marvell.com>
 <CALZhoSQcjrOk3s6NFRs34H5uiYWK+TYeqJpoiwC6XSF+xPXrzg@mail.gmail.com>
Message-ID: <CALZhoSQ1VEQjG5Sdh0FM=OtH3FKB35_Xt=yd+9sVZnijTBwuVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Fri, May 4, 2012 at 11:58 PM, Lei Wen <adrian.wenl@gmail.com> wrote:
> There is one clock rate changing requirement like those:
> 1. clock may need specify specific rate binded with specific parent
> 2. driver care only set_rate, don't care for which parent it is linked
> 3. It need registering notification to changing voltage
> 4. It want keep parent and rate changing in an atomic operation, which
> ? means for chaning parent, it only caching the mux chaning, and
> ? maintent the relationship in this tree, while do the real parent
> ? and rate chaning in the set_rate callback. And it requires
> ? recalculated rate reflect the true rate changing state to make the
> ? decision to whether sending notification.
>
> Base on those assumption, the logic in set_rate is changed a little, the
> round_rate should return not only best parent_rate, but also best
> parent. If best parent is changed, we would switch parent first, then do
> the sub rate chaning.
>
> Signed-off-by: Lei Wen <leiwen@marvell.com>
> Acked-by: Raul Xiong <raulxiong@gmail.com>
> ---
> ?drivers/clk/clk.c ? ? ? ? ? ?| ? 22 +++++++++++++++++++++-
> ?include/linux/clk-provider.h | ? ?2 ++
> ?2 files changed, 23 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 9cf6f59..d207617 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -23,6 +23,7 @@ static DEFINE_MUTEX(prepare_lock);
> ?static HLIST_HEAD(clk_root_list);
> ?static HLIST_HEAD(clk_orphan_list);
> ?static LIST_HEAD(clk_notifier_list);
> +static int __clk_set_parent(struct clk *clk, struct clk *parent);
>
> ?/*** ? ? ? ?debugfs support ? ? ? ?***/
>
> @@ -767,6 +768,7 @@ static struct clk *clk_calc_new_rates(struct clk
> *clk, unsigned long rate)
> ? ? ? ?struct clk *top = clk;
> ? ? ? ?unsigned long best_parent_rate = clk->parent->rate;
> ? ? ? ?unsigned long new_rate;
> + ? ? ? int ret;
>
> ? ? ? ?if (!clk->ops->round_rate && !(clk->flags & CLK_SET_RATE_PARENT)) {
> ? ? ? ? ? ? ? ?clk->new_rate = clk->rate;
> @@ -785,6 +787,21 @@ static struct clk *clk_calc_new_rates(struct clk
> *clk, unsigned long rate)
> ? ? ? ?else
> ? ? ? ? ? ? ? ?new_rate = clk->ops->round_rate(clk->hw, rate, NULL);
>
> + ? ? ? if (clk->hw->new_parent && (clk->hw->new_parent != clk->parent)) {
> + ? ? ? ? ? ? ? if ((clk->flags & CLK_SET_PARENT_GATE) && clk->prepare_count)
> + ? ? ? ? ? ? ? ? ? ? ? ret = -EBUSY;
> + ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? ? ? ? ? ret = __clk_set_parent(clk, clk->hw->new_parent);
> +
> + ? ? ? ? ? ? ? if (ret) {
> + ? ? ? ? ? ? ? ? ? ? ? pr_debug("%s: %s set parent to %s failed\n", __func__,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? clk->name, clk->hw->new_parent->name);
> + ? ? ? ? ? ? ? ? ? ? ? return NULL;
> + ? ? ? ? ? ? ? }
> +
> + ? ? ? ? ? ? ? __clk_reparent(clk, clk->hw->new_parent);
> + ? ? ? }
> +
> ? ? ? ?if (best_parent_rate != clk->parent->rate) {
> ? ? ? ? ? ? ? ?top = clk_calc_new_rates(clk->parent, best_parent_rate);
>
> @@ -1050,7 +1067,10 @@ out:
>
> ? ? ? ?clk->parent = new_parent;
>
> - ? ? ? __clk_recalc_rates(clk, POST_RATE_CHANGE);
> + ? ? ? if (!clk->hw->new_parent)
> + ? ? ? ? ? ? ? __clk_recalc_rates(clk, POST_RATE_CHANGE);
> + ? ? ? else
> + ? ? ? ? ? ? ? clk->hw->new_parent = NULL;
> ?}
>
> ?static int __clk_set_parent(struct clk *clk, struct clk *parent)
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 5508897..54dad8a 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -23,9 +23,11 @@
> ?*
> ?* clk: pointer to the struct clk instance that points back to this struct
> ?* clk_hw instance
> + * new_parent: pointer for caching new parent position
> ?*/
> ?struct clk_hw {
> ? ? ? ?struct clk *clk;
> + ? ? ? struct clk *new_parent;
> ?};
>
> ?/*
> --
> 1.7.5.4

Any suggestion for this patch, could it be acceptable?

Thanks,
Lei
