From: mturquette@ti.com (Turquette, Mike)
Date: Fri, 26 Aug 2011 16:45:03 -0700
Subject: [PATCH 02/11] clk: Implement clk_set_rate
In-Reply-To: <1314191759-16941-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20110824131324.GB16520@opensource.wolfsonmicro.com>
	<1314191759-16941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1314191759-16941-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <CAJOA=zP2DGmox8PG6kbXHfw4kC+bTN1HM6n=8OJvETfMMxt7vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 6:15 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> From: Jeremy Kerr <jeremy.kerr@canonical.com>
>
> Implemenent clk_set_rate by adding a set_rate callback to clk_hw_ops,
> and core code to handle propagation of rate changes up and down the
> clock tree.

Propagating rates up the tree is wrong.  If a parent rate must be
changed then clk_set_rate should be called on the parent explicitly,
then clk_set_rate can be called on the target child clk.

I don't see any other way to do it that is safe, save for some batch
operation mechanism that takes predefined clock sub-trees into account
(which is likely only feasible for SoCs since their data manuals
provide all this info).

> +/*
> + * clk_recalc_rates - Given a clock (with a recently updated clk->rate),
> + * ? ? notify its children that the rate may need to be recalculated, using
> + * ? ? ops->recalc_rate().
> + */
> +static void clk_recalc_rates(struct clk *clk)
> +{
> + ? ? ? struct hlist_node *tmp;
> + ? ? ? struct clk *child;
> +
> + ? ? ? if (clk->ops->recalc_rate)
> + ? ? ? ? ? ? ? clk->rate = clk->ops->recalc_rate(clk->hw);
> +
> + ? ? ? hlist_for_each_entry(child, tmp, &clk->children, child_node)
> + ? ? ? ? ? ? ? clk_recalc_rates(child);

We need a rate post-change notifier here that drivers can subscribe
to.  Since many devices do not support having their clocks changed on
the fly while the device is enabled, a pre-change and post-change
notifier are necessary to notify devices downstream of the clock being
changed.  Imagine doing a rate change high up in the tree (PLL) and
you can see that many devices will need these notifiers propagated to
them.

> +}
> +
> ?int clk_set_rate(struct clk *clk, unsigned long rate)
> ?{
> - ? ? ? /* not yet implemented */
> - ? ? ? return -ENOSYS;
> + ? ? ? unsigned long parent_rate, new_rate;
> + ? ? ? int ret;
> +
> + ? ? ? if (!clk->ops->set_rate)
> + ? ? ? ? ? ? ? return -ENOSYS;
> +
> + ? ? ? new_rate = rate;
> +
> + ? ? ? /* prevent racing with updates to the clock topology */
> + ? ? ? mutex_lock(&prepare_lock);
> +
> +propagate:

Need a rate pre-change notifier here that walks the tree.  Drivers
subscribing to this notifier can save context and call their
pm_runtime_put or clk_disable bits so that they can survive the rate
change without any glitches before the rate actually changes.

> + ? ? ? ret = clk->ops->set_rate(clk->hw, new_rate, &parent_rate);
> +
> + ? ? ? if (ret < 0)
> + ? ? ? ? ? ? ? return ret;
> +
> + ? ? ? /* ops->set_rate may require the parent's rate to change (to
> + ? ? ? ?* parent_rate), we need to propagate the set_rate call to the
> + ? ? ? ?* parent.
> + ? ? ? ?*/
> + ? ? ? if (ret == CLK_SET_RATE_PROPAGATE) {
> + ? ? ? ? ? ? ? new_rate = parent_rate;
> + ? ? ? ? ? ? ? clk = clk->parent;
> + ? ? ? ? ? ? ? goto propagate;
> + ? ? ? }

Again, I feel this is wrong.  Rate change propagation should only flow
downstream.  Any rate change arbitration that requires changes
upstream should be considered and handled by the driver.

> +
> + ? ? ? /* If successful (including propagation to the parent clock(s)),
> + ? ? ? ?* recalculate the rates of the clock, including children. ?We'll be
> + ? ? ? ?* calling this on the 'parent-most' clock that we propagated to.
> + ? ? ? ?*/
> + ? ? ? clk_recalc_rates(clk);

As mentioned above, recalc should propagate rate post-change notification.

Regards,
Mike
